import numpy as np
import pandas as pd

from . import KalmanFilter_EKF

class KalmanVelocity(KalmanFilter_EKF):
    def __init__(self):
        super().__init__(dim_x=4, dim_z=2)
        dt = 1
        self.x = np.array([[0], [0], [0], [0]])
        self.F = np.array([[1, 1, 0, 0],
                           [0, 1, 0, 0],
                           [0, 0, 1, 1],
                           [0, 0, 0, 1]]
                          )
        self.H = np.array([[1, 0, 0, 0],
                           [0, 0, 1, 0]]
                          )
        self.R *= 2
        self.Q = np.array([[.25*(dt**4), .5*(dt**3),  0,         0],
                           [.5*(dt**3),  .25*(dt**4), 0,         0],
                           [0,         0,         .25*(dt**4), .5*(dt**3)],
                           [0,         0,         .5*(dt**3),  .25*(dt**4)]]
        )
        self.Q *= 0.
        self.P *= 10.

    def predict(self, u=0):
        """
        Predict next position.
        Parameters
        ----------
        u : np.array
        Optional control vector. If non-zero, it is multiplied by B
        to create the control input into the system.
        """

        self.x = np.dot(self.F, self.x) + np.dot(self.B, u)
        self.P = self.F.dot(self.P).dot(self.F.T) + self.Q

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
            self.predict()
            mes = Z[['x', 'y']].iloc[i].to_numpy()
            self.update(np.resize(mes,  (2, 1)))
            # save for latter plotting
            coord_x_est.append(self.x[0])
            coord_y_est.append(self.x[2])
            time_est.append(int(Z[['time']].iloc[i]))

        return pd.DataFrame({'X_f': coord_x_est,
                             'Y_f': coord_y_est,
                             'time': time_est
                             })
    def clear(self):
        self.x = np.array([[0], [0], [0], [0]])
        self.F = np.array([[1, 100, 0, 0],
                           [0, 1, 0, 0],
                           [0, 0, 1, 100],
                           [0, 0, 0, 1]]
                          )
        self.H = np.array([[1, 0, 0, 0],
                           [0, 0, 1, 0]]
                          )
        self.R *= 2
        self.Q = np.array([[.25 * (dt ** 4), .5 * (dt ** 3), 0, 0],
                           [.5 * (dt ** 3), .25 * (dt ** 4), 0, 0],
                           [0, 0, .25 * (dt ** 4), .5 * (dt ** 3)],
                           [0, 0, .5 * (dt ** 3), .25 * (dt ** 4)]]
                          )
        self.Q *= 0.
        self.P *= 10.

    def nonlinear_state(self):
        """
        """
        pass

    def jacobianF(self):
        """
        """
        pass

    def recover(self, Z, x, y, time):
        pass