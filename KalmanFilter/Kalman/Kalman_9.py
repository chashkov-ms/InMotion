import numpy as np
# import KalmanFilter_EKF
from . import KalmanFilter_EKF

class KalmanFilter_EKF_9(KalmanFilter_EKF):
    def __init__(self):
        super().__init__(dim_x=9, dim_z=3)
        self.x = np.array([[0],
                           [0], [0],
                           [0], [0],
                           [0], [0],
                           [0], [0]]
                          )
        self.JF = self.jacobianF()
        self.H = np.array([[0, 1, 0, 0, 0, 0, 0, 0, 0],
                           [0, 0, 1, 0, 0, 0, 0, 0, 0],
                           [1, 0, 0, 0, 0, 0, 0, 0, 0]
                           ]
                          )
        self.R *= 2
        self.Q = np.array(
            [[5e-10,   0,     0,     0,     0,     0,      0,     0,      0],
             [0,       5e-00, 0,     0,     0,     0,      0,     0,      0],
             [0,       0,     5e-00, 0,     0,     0,      0,     0,      0],
             [0,       0,     0,     3e-00, 0,     0,      0,     0,      0],
             [0,       0,     0,     0,     3e-00, 0,      0,     0,      0],
             [0,       0,     0,     0,     0,     3e-00,  0,     0,      0],
             [0,       0,     0,     0,     0,     0,      3e-00, 0,      0],
             [0,       0,     0,     0,     0,     0,      0,     3e-00,  0],
             [0,       0,     0,     0,     0,     0,      0,     0,      3e-00]]
        )
        self.P *= 1.



    def nonlinear_state(self):
        """
        Evalute next position.
        """
        self.x[0] = self.x[0] + 100
        self.x[1] = self.x[1] + \
                    self.x[3] * self.x[0] + \
                    self.x[5] / 2 * (self.x[0] ** 2) + \
                    self.x[7] / 6 * (self.x[0] ** 3)
        self.x[2] = self.x[2] + \
                    self.x[4] * self.x[0] + \
                    self.x[6] / 2 * (self.x[0] ** 2) + \
                    self.x[8] / 6 * (self.x[0] ** 3)
        self.x[3] = self.x[3] + \
                    self.x[5] * self.x[0] + \
                    self.x[7] / 2 * (self.x[0] ** 2)
        self.x[4] = self.x[4] + \
                    self.x[6] * self.x[0] + \
                    self.x[8] / 2 * (self.x[0] ** 2)
        self.x[5] = self.x[5] + \
                    self.x[6] * self.x[0]
        self.x[6] = self.x[6] + \
                    self.x[8] * self.x[0]

    def jacobianF(self):
        """
        Function return jacobian for k-step iteration
        1                0 0 0 0 0        0        0        0
        vx+at+ex(t**2)/2 1 0 t 0 (t**2)/2 0        (t**3)/6 0
        vy+at+ey(t**2)/2 0 1 0 t 0        (t**2)/2 0        (t**3)/6
        ax+ex*t          0 0 1 0 t        0        (t**2)/2 0
        ay+ey*t          0 0 0 1 0        t        0        (t**2)/2
        ex               0 0 0 0 1        0        t        0
        ey               0 0 0 0 0        1        0        t
        0                0 0 0 0 0        0        1        0
        0                0 0 0 0 0        0        0        1
        """
        jacob = np.eye(len(self.x))
        jacob[1][0] = self.x[3] + self.x[5] * self.x[0] + self.x[7] * (self.x[0] ** 2) / 2
        jacob[1][3] = self.x[0]
        jacob[1][5] = (self.x[0] ** 2) / 2
        jacob[1][7] = (self.x[0] ** 3) / 6
        jacob[2][0] = self.x[4] + self.x[6] * self.x[0] + self.x[8] * (self.x[0] ** 2) / 2
        jacob[2][4] = self.x[0]
        jacob[2][6] = (self.x[0] ** 2) / 2
        jacob[2][8] = (self.x[0] ** 3) / 6
        jacob[3][0] = self.x[5] + self.x[7] * self.x[0]
        jacob[3][5] = self.x[0]
        jacob[3][7] = (self.x[0] ** 2) / 2
        jacob[4][0] = self.x[6] + self.x[8] * self.x[0]
        jacob[4][6] = self.x[0]
        jacob[4][8] = (self.x[0] ** 2) / 2
        jacob[5][0] = self.x[7]
        jacob[6][7] = self.x[0]
        jacob[6][0] = self.x[8]
        jacob[6][8] = self.x[0]
        return jacob

    def clear(self):
        self.x = np.array([[0],
                           [0], [0],
                           [0], [0],
                           [0], [0],
                           [0], [0]]
                          )
        self.JF = self.jacobianF()
        self.H = np.array([[0, 1, 0, 0, 0, 0, 0, 0, 0],
                           [0, 0, 1, 0, 0, 0, 0, 0, 0],
                           [1, 0, 0, 0, 0, 0, 0, 0, 0]
                           ]
                          )
        self.R *= 2
        self.Q = np.array(
            [[5e-10,   0,     0,     0,     0,     0,      0,     0,      0],
             [0,       5e-00, 0,     0,     0,     0,      0,     0,      0],
             [0,       0,     5e-00, 0,     0,     0,      0,     0,      0],
             [0,       0,     0,     3e-00, 0,     0,      0,     0,      0],
             [0,       0,     0,     0,     3e-00, 0,      0,     0,      0],
             [0,       0,     0,     0,     0,     3e-00,  0,     0,      0],
             [0,       0,     0,     0,     0,     0,      3e-00, 0,      0],
             [0,       0,     0,     0,     0,     0,      0,     3e-00,  0],
             [0,       0,     0,     0,     0,     0,      0,     0,      3e-00]]
        )
        self.P *= 1.

    def recover(self, Z, x, y, time):
        dt = Z.iloc[0].time - Z.iloc[1].time
        for j in range(1, int(round(dt / 100))):
            time.append(time[-1] + 100)
            x.append(x[-1] +
                     self.x[3] * time[-1] +
                               self.x[5] / 2 * (time[-1] ** 2) +
                               self.x[7] / 6 * (time[-1] ** 3)
                               )
            y.append(y[-1] +
                               self.x[4] * time[-1] +
                               self.x[6] / 2 * (time[-1] ** 2) +
                               self.x[8] / 6 * (time[-1] ** 3)
                               )
