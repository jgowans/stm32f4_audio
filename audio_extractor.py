#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as plt

with open('klaxon.raw', 'rb') as f:
    raw = f.read()
audio = np.frombuffer(raw, dtype=np.int16)
audio = audio * (512.0/25000)
audio = audio
audio = audio.clip(-1023, 1023)
with open("klaxon.h", 'w') as f:
    f.write("#include <stdint.h>\nconst int16_t klaxon_array[] = { ")
    for idx, val in enumerate(audio):
        if idx%15 == 0:
            f.write('\n')
        f.write("{v}, ".format(v = int(round(val))))
    f.write("};")
#plt.plot(audio)
#plt.show()
