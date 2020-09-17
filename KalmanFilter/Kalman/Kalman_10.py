import numpy as np
from . import KalmanFilter_EKF
# import KalmanFilter_EKF

class KalmanFilter_EKF_10(KalmanFilter_EKF):
    def __init__(self):
        super().__init__(dim_x=10, dim_z=3)
        self.x = np.array([[0], [100],
                           [0], [0],
                           [0], [0],
                           [0], [0],
                           [0], [0]]
                          )
        self.JF = self.jacobianF()
        self.H = np.array([[0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
                           [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
                           [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                           ]
                          )
        self.R *= 2
        self.Q = np.array(
            [[10, 0, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 10, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 5e-07, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 5e-07, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 3e-08, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 3e-08, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 3e-23, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 3e-23, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 3e-31, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 0, 3e-31]]
        )
        self.P *= 50.

    def nonlinear_state(self):
        """
        Predict next position.
        """
        self.x[0] = self.x[0] + self.x[1]
        self.x[2] = self.x[2] + \
                    self.x[4] * self.x[0] + \
                    self.x[6] / 2 * (self.x[0] ** 2) + \
                    self.x[8] / 6 * (self.x[0] ** 3)
        self.x[3] = self.x[3] + \
                    self.x[5] * self.x[0] + \
                    self.x[7] / 2 * (self.x[0] ** 2) + \
                    self.x[9] / 6 * (self.x[0] ** 3)
        self.x[4] = self.x[4] + \
                    self.x[6] * self.x[0] + \
                    self.x[8] / 2 * (self.x[0] ** 2)
        self.x[5] = self.x[5] + \
                    self.x[7] * self.x[0] + \
                    self.x[9] / 2 * (self.x[0] ** 2)
        self.x[6] = self.x[6] + \
                    self.x[8] * self.x[0]
        self.x[7] = self.x[7] + \
                    self.x[9] * self.x[0]

    def jacobianF(self):
        """
        Function return jacobian for k-step iteration
        1                1 0 0 0 0 0        0        0        0
        0                1 0 0 0 0 0        0        0        0
        vx+at+ex(t**2)/2 0 1 0 t 0 (t**2)/2 0        (t**3)/6 0
        vy+at+ey(t**2)/2 0 0 1 0 t 0        (t**2)/2 0        (t**3)/6
        ax+ex*t          0 0 0 1 0 t        0        (t**2)/2 0
        ay+ey*t          0 0 0 0 1 0        t        0        (t**2)/2
        ex               0 0 0 0 0 1        0        t        0
        ey               0 0 0 0 0 0        1        0        t
        0                0 0 0 0 0 0        0        1        0
        0                0 0 0 0 0 0        0        0        1
        """

        jacob = np.eye(len(self.x))
        jacob[0][1] = 1
        jacob[2][0] = self.x[4] + self.x[6] * self.x[0] + self.x[8] * (self.x[0] ** 2) / 2
        jacob[2][4] = self.x[0]
        jacob[2][6] = (self.x[0] ** 2) / 2
        jacob[2][8] = (self.x[0] ** 3) / 6
        jacob[3][0] = self.x[5] + self.x[7] * self.x[0] + self.x[9] * (self.x[0] ** 2) / 2
        jacob[3][5] = self.x[0]
        jacob[3][7] = (self.x[0] ** 2) / 2
        jacob[3][9] = (self.x[0] ** 3) / 6
        jacob[4][0] = self.x[6] + self.x[8] * self.x[0]
        jacob[4][6] = self.x[0]
        jacob[4][8] = (self.x[0] ** 2) / 2
        jacob[5][0] = self.x[7] + self.x[9] * self.x[0]
        jacob[5][7] = self.x[0]
        jacob[5][9] = (self.x[0] ** 2) / 2
        jacob[6][0] = self.x[8]
        jacob[6][8] = self.x[0]
        jacob[7][0] = self.x[9]
        jacob[7][9] = self.x[0]
        return jacob

    def clear(self):
        self.x = np.array([[0], [100],
                           [0], [0],
                           [0], [0],
                           [0], [0],
                           [0], [0]]
                          )
        self.JF = self.jacobianF()
        self.H = np.array([[0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
                           [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
                           [1, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                           ]
                          )
        self.R *= 2
        self.Q = np.array(
            [[10, 0, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 10, 0, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 5e-07, 0, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 5e-07, 0, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 3e-08, 0, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 3e-08, 0, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 3e-23, 0, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 3e-23, 0, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 3e-31, 0],
             [0, 0, 0, 0, 0, 0, 0, 0, 0, 3e-31]]
        )
        self.P *= 50.