import numpy as np
import pandas as pd

from abc import ABC, abstractmethod

class KalmanFilter_EKF:
    def __init__(self, dim_x, dim_z, dim_u=0):
        """
        Create a Kalman filter. You are responsible for setting the
        various state variables to reasonable values; the defaults below will
        not give you a functional filter.
        Parameters
        ----------
        dim_x : int
        Number of state variables for the Kalman filter. For example, if
        you are tracking the position and velocity of an object in two
        dimensions, dim_x would be 4.
        This is used to set the default size of P, Q, and u
        dim_z : int
        Number of of measurement inputs. For example, if the sensor
        provides you with position in (x,y), dim_z would be 2.
        dim_u : int (optional)
        size of the control input, if it is being used.
        Default value of 0 indicates it is not used.
        """

        self.x = np.zeros((dim_x, 1))  # state
        self.P = np.eye(dim_x)  # uncertainty covariance
        self.Q = np.eye(dim_x)  # process uncertainty
        self.u = np.zeros((dim_x, 1))  # motion vector
        self.B = 0  # control transition matrix
        self.JF = 0  # state F-jacobian matrix
        self.H = 0  # Measurement function
        self.R = np.eye(dim_z)  # state uncertainty

        # identity matrix. Do not alter this.
        self._I = np.eye(dim_x)
    def _predict(self, u=0):
        """
        Predict next position.
        Parameters
        ----------
        u : np.array
        Optional control vector. If non-zero, it is multiplied by B
        to create the control input into the system.
        """

        self._nonlinear_state()
        # self.x = np.dot(self.JF, self.x) + np.dot(self.B, u)
        self.P = self.JF.dot(self.P).dot(self.JF.T) + self.Q

    def _update(self, Z, R=None):
        """
        Add a new measurement (Z) to the kalman filter. If Z is None, nothing
        is changed.
        Parameters
        ---------
        Z : np.array
        measurement for this update.
        R : np.array, scalar, or None
        Optionally provide R to override the measurement noise for this
        one call, otherwise self.R will be used.
        """

        if Z is None:
            return

        if R is None:
            R = self.R
        elif np.isscalar(R):
            R = np.eye(self.dim_z) * R

        # error (residual) between measurement and prediction
        y = Z - np.dot(self.H, self.x)

        # project system uncertainty into measurement space
        S = np.dot(self.H, self.P).dot(self.H.T) + R

        # map system uncertainty into kalman gain
        K = np.dot(self.P, self.H.T).dot(np.linalg.inv(S))

        # predict new x with residual scaled by the kalman gain
        self.x = self.x + np.dot(K, y)

        I_KH = self._I - np.dot(K, self.H)
        self.P = np.dot(I_KH, self.P).dot(I_KH.T) + \
                 np.dot(K, R).dot(K.T)

    def filtering(self, Z):
        """
        This fuction filtering input data Z
        :param Z: pandas DataFrame input data
        :return: pandas dataFrame filtering data
        """
        coord_x_est = [0]
        coord_y_est = [0]
        time_est = [0]
        for i in range(1, len(Z.x)):
            self._recover(Z.iloc[i-1:i+1].reset_index(drop = True), coord_x_est, coord_y_est, time_est)
            self._predict()
            mes = Z.loc[i].to_numpy()
            self._update(np.resize(mes,  (3, 1)))
            # save for latter plotting
            coord_x_est.append(self.x[2])
            coord_y_est.append(self.x[3])
            time_est.append(self.x[0])

        return pd.DataFrame({'X_f': coord_x_est,
                             'Y_f': coord_y_est,
                             'time': time_est
                             })

    @abstractmethod
    def _nonlinear_state(self):
        pass

    @abstractmethod
    def _predict(self, u=0):
        """
        Predict next position.
        Parameters
        ----------
        u : np.array
        Optional control vector. If non-zero, it is multiplied by B
        to create the control input into the system.
        """
        pass

    @abstractmethod
    def _jacobianF(self):
        """
        Function return jacobian for k-step iteration
        """
        pass

    @abstractmethod
    def _recover(self, Z, x, y, time):
        pass