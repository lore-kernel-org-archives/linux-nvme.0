From: marc.smith@mcc.edu (Marc Smith)
Date: Fri, 14 Dec 2018 01:39:42 -0500
Subject: Find Allocation Unit Size
Message-ID: <CAHkw+LdJZD6Z3BgSve-Sg2FyrNZ9iaBw1RUehS7o+2mTEpWCjA@mail.gmail.com>

Hi,

I'm testing some NVMe drives, and playing with creating multiple
namespaces (via the nvme CLI tool). I've noticed with some values,
there is rounding that is occurring (or so I assume). I'm using a 4096
block size, and with values like 200 GiB or 1000 GiB I do not see the
rounding occur (checking value in bytes against unvmcap after
creation).

But other values do seem to round... I suspect this is aligning to the
allocation unit size, but I'm not sure where to find that value for my
NVMe drives? Hoping someone could point me in the right direction!

Thanks in advance.


--Marc
