import numpy as np
import pandas as pd

from . import KalmanFilter_EKF

class LinearKalman4(KalmanFilter_EKF):
    def __init__(self):
        super().__init__(dim_x=8, dim_z=2)
        dt = 100
        self.x = np.array([[0], [0], [0], [0], [0], [0], [0], [0]])
        self.F = np.array([[1, dt, 1/2*(dt**2), 1/6*(dt**3), 0, 0, 0, 0],
                           [0, 1, dt, 1/2*(dt**2), 0, 0, 0, 0],
                           [0, 0, 1, dt, 0, 0, 0, 0],
                           [0, 0, 0, 1, 0, 0, 0, 0],
                           [0, 0, 0, 0, 1, dt, 1/2*(dt**2), 1/6*(dt**3)],
                           [0, 0, 0, 0, 0, 1, dt, 1/2*(dt**2)],
                           [0, 0, 0, 0, 0, 0, 1, dt],
                           [0, 0, 0, 0, 0, 0, 0, 1]]
                          )
        self.H = np.array([[1, 0, 0, 0, 0, 0, 0, 0],
                           [0, 0, 0, 0, 1, 0, 0, 0]]
                          )
        self.R *= 9e-4

        self.Q = np.array([[1/36*(dt**6), 1/12*(dt**5), 1/6*(dt**4),   1/6*(dt**4),  0, 0, 0, 0],
                           [1/12*(dt**5), 1/4*(dt**4),  1/2*(dt**3),  1/2*(dt**2),  0, 0, 0, 0],
                           [1/6*(dt**4),   1/2*(dt**3),  (dt**2),      (dt**1),     0, 0, 0, 0],
                           [1/6*(dt**3),   1/2*(dt**2),  (dt**1),      1,           0, 0, 0, 0],
                           [0, 0, 0, 0,   1/36*(dt**6), 1/12*(dt**5), 1/6*(dt**4),  1/6*(dt**4)],
                           [0, 0, 0, 0,   1/12*(dt**5), 1/4*(dt**4),  1/2*(dt**3), 1/2*(dt**2)],
                           [0, 0, 0, 0,   1/6*(dt**4),   1/2*(dt**3),  (dt**2),     (dt**1)],
                           [0, 0, 0, 0,   1/6*(dt**3),   1/2*(dt**2),  (dt**1),     1]]
        )
        self.sygma = 40e-22

        self.Q *= self.sygma
        self.P *= 10.

    def __configure(self, dt):
        self.F = np.array([[1, dt, 1 / 2 * (dt ** 2), 1 / 6 * (dt ** 3), 0, 0, 0, 0],
                           [0, 1, dt, 1 / 2 * (dt ** 2), 0, 0, 0, 0],
                           [0, 0, 1, dt, 0, 0, 0, 0],
                           [0, 0, 0, 1, 0, 0, 0, 0],
                           [0, 0, 0, 0, 1, dt, 1 / 2 * (dt ** 2), 1 / 6 * (dt ** 3)],
                           [0, 0, 0, 0, 0, 1, dt, 1 / 2 * (dt ** 2)],
                           [0, 0, 0, 0, 0, 0, 1, dt],
                           [0, 0, 0, 0, 0, 0, 0, 1]]
                          )
        self.Q = np.array([[1 / 36 * (dt ** 6), 1 / 12 * (dt ** 5), 1 / 6 * (dt ** 4), 1 / 6 * (dt ** 4), 0, 0, 0, 0],
                           [1 / 12 * (dt ** 5), 1 / 4 * (dt ** 4), 1 / 2 * (dt ** 3), 1 / 2 * (dt ** 2), 0, 0, 0, 0],
                           [1 / 6 * (dt ** 4), 1 / 2 * (dt ** 3), (dt ** 2), (dt ** 1), 0, 0, 0, 0],
                           [1 / 6 * (dt ** 3), 1 / 2 * (dt ** 2), (dt ** 1), 1, 0, 0, 0, 0],
                           [0, 0, 0, 0, 1 / 36 * (dt ** 6), 1 / 12 * (dt ** 5), 1 / 6 * (dt ** 4), 1 / 6 * (dt ** 4)],
                           [0, 0, 0, 0, 1 / 12 * (dt ** 5), 1 / 4 * (dt ** 4), 1 / 2 * (dt ** 3), 1 / 2 * (dt ** 2)],
                           [0, 0, 0, 0, 1 / 6 * (dt ** 4), 1 / 2 * (dt ** 3), (dt ** 2), (dt ** 1)],
                           [0, 0, 0, 0, 1 / 6 * (dt ** 3), 1 / 2 * (dt ** 2), (dt ** 1), 1]]
                          )
        self.Q *= self.sygma

    def _predict(self, u=0):
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
        :param Z: pandas DataFrame following structure input data
            Z = pd.DataFrame(x, y, time)
            x coord in meter
            y coord in meter
            time in msec

        :return: pandas dataFrame the following structure filtering data
            pd.DataFrame(x_filtered, y_filtered, time)
        """
        coord_x_est = [0]
        coord_y_est = [0]
        time_est = [Z[['time']].iloc[0][0]]
        for i in range(1, len(Z.x)):
            new_dt = Z[['time']].iloc[i][0] - time_est[-1]
            while (new_dt > 150):
                new_state = [coord_x_est[-1], coord_y_est[-1], time_est[-1]]
                new_state = self._restore(new_state)
                coord_x_est.append(new_state[0])
                coord_y_est.append(new_state[1])
                time_est.append(new_state[2])
                new_dt -= 100

#            self.configure(new_dt)
            self._predict()
            mes = Z[['x', 'y']].iloc[i].to_numpy()
            self._update(np.resize(mes,  (2, 1)))
            # save for latter plotting
            coord_x_est.append(self.x[0])
            coord_y_est.append(self.x[4])
            time_est.append(int(Z[['time']].iloc[i]))

        return pd.DataFrame({'X_f': coord_x_est,
                             'Y_f': coord_y_est,
                             'time': time_est
                             })
    def clear(self):
        dt = 100
        self.x = np.array([[0], [0], [0], [0], [0], [0], [0], [0]])
        self.F = np.array([[1, dt, 1 / 2 * (dt ** 2), 1 / 6 * (dt ** 3), 0, 0, 0, 0],
                           [0, 1, dt, 1 / 2 * (dt ** 2), 0, 0, 0, 0],
                           [0, 0, 1, dt, 0, 0, 0, 0],
                           [0, 0, 0, 1, 0, 0, 0, 0],
                           [0, 0, 0, 0, 1, dt, 1 / 2 * (dt ** 2), 1 / 6 * (dt ** 3)],
                           [0, 0, 0, 0, 0, 1, dt, 1 / 2 * (dt ** 2)],
                           [0, 0, 0, 0, 0, 0, 1, dt],
                           [0, 0, 0, 0, 0, 0, 0, 1]]
                          )
        self.H = np.array([[1, 0, 0, 0, 0, 0, 0, 0],
                           [0, 0, 0, 0, 1, 0, 0, 0]]
                          )
        self.R *= 9e-4

        self.Q = np.array([[1 / 36 * (dt ** 6), 1 / 12 * (dt ** 5), 1 / 6*(dt ** 4), 1 / 6*(dt ** 4), 0, 0, 0, 0],
                           [1 / 12 * (dt ** 5), 1 / 4 * (dt ** 4), 1 / 2 * (dt ** 3), 1 / 2*(dt ** 2), 0, 0, 0, 0],
                           [1 / 6*(dt ** 4), 1 / 2 * (dt ** 3), (dt ** 2), (dt ** 1), 0, 0, 0, 0],
                           [1 / 6*(dt ** 3), 1 / 2 * (dt ** 2), (dt ** 1), 1, 0, 0, 0, 0],
                           [0, 0, 0, 0, 1 / 36 * (dt ** 6), 1 / 12 * (dt ** 5), 1 / 6*(dt ** 4), 1 / 6*(dt ** 4)],
                           [0, 0, 0, 0, 1 / 12 * (dt ** 5), 1 / 4 * (dt ** 4), 1 / 2 * (dt ** 3), 1 / 2*(dt ** 2)],
                           [0, 0, 0, 0, 1 / 6*(dt ** 4), 1 / 2 * (dt ** 3), (dt ** 2), (dt ** 1)],
                           [0, 0, 0, 0, 1 / 6*(dt ** 3), 1 / 2 * (dt ** 2), (dt ** 1), 1]]
                          )

        self.Q *= self.sygma
        self.P *= 10.

    def _restore(self, last_state):
        """
        :param last_state: list of system state
        last_state[0] - last x coord
        last_state[1] - last y coord
        last_state[2] - last time
        :return:
        """
        new_state = self.x
        new_state[0] = last_state[0]
        new_state[4] = last_state[1]
        new_state = np.dot(self.F, new_state)
        new_x = last_state[0] + 0.2 * (last_state[0] - new_state[0])
        new_y = last_state[1] + 0.2 * (last_state[1] - new_state[4])
        return [new_x, new_y, last_state[2]+100]

    def _nonlinear_state(self):
        """
        """
        pass

    def _jacobianF(self):
        """
        """
        pass

    def _recover(self, Z, x, y, time):
        pass