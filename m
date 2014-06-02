From: angelusbritos@gmail.com (Angelo Brito)
Date: Mon, 2 Jun 2014 16:32:23 -0300
Subject: A NVME command always generates some additional commands?
Message-ID: <CAMjVwgQZQ9R+FD2sPhdLraGhdf-8OrwZngMTQVfVMh1__5QFhg@mail.gmail.com>

Hello guys,

We are developing a NVMe device and your device is under tests right
now. So we are monitoring what is requested, what is executed and what
are the answers. Then every time we request a NVMe I/O Command some
additional 23 I/O Read Commands are generated to read some blocks next
to the end of our memory or next to the start. Is it an expected
behavior? I didn't find a reason at the driver for these commands to
be generated.

I'm using Red Hat Enterprise Linux with kernel 3.10.0-rc5linux and the
default driver version.
What do you think? Any suggestions of how to shut these commands down?

Regards,
Angelo Silva Brito.
http://about.me/angelobrito
_________________________________________________
