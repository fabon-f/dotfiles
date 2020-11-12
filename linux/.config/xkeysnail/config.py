# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

define_timeout(0.4)

define_multipurpose_modmap({
    Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],
    Key.CAPSLOCK: [Key.ESC, Key.LEFT_CTRL]
})
