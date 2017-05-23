From: luto@amacapital.net (Andy Lutomirski)
Date: Tue, 23 May 2017 14:23:50 -0700
Subject: Getting rid of nvme's pci watchdog timer?
Message-ID: <CALCETrWTmjrokDT3Ao5QsXonqUqKHWf9=Kp=z0x89rKTUz49Pg@mail.gmail.com>

nvme polls pci devices to make sure they're not dead even when they're
completely idle.  Can we fix that without killing scalability?  Can we
piggyback off the block layer's timeout mechanism?  Could we simply
*delete* the watchdog timer and add some CSTS and PCI_STATUS
diagnostics to nvme_timeout()?

I doubt that one rounded wakeup per second makes much difference on
CPU/package power saving, but it could be pretty bad for ASPM and
maybe even APST power saving.
