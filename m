From: asb@cin.ufpe.br (Angelo Brito)
Date: Fri, 18 Dec 2015 17:17:19 -0200
Subject: NVMe Generic Devices Linux x Windows
Message-ID: <CAMjVwgQ+WicdTLjXb5Xa70XC+BnQdvyob+iGhjBt_t3Z9bw=dA@mail.gmail.com>

Hello All,

I have a generic NVMe device that works perfectly on Linux but does
not work on Windows. The device is recognized as a Default NVMe
Controller with Microsoft as vendor but issue an error code 10: This
device cannot start. I am aware that this is a generic error code and
could mean any thing.

I have started to debug from the device perspective and the Host CPU
just writes the MSI configuration registers during startup. I use
Altera?s PCIe Hard IP to implement the PCIe and my controller is
hosted on FPGA. The NVMe controller was never started. Is it an
expected behavior to work on Linux but not on windows?
Someone can share any more leads to debug? Why windows doesn?t start my device?


Regards,
Angelo Silva Brito.
B.S. in Computer Engineering - UFPE Brazil
http://about.me/angelobrito
_________________________________________________
