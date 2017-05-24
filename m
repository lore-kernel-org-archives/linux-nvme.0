From: hch@lst.de (Christoph Hellwig)
Date: Wed, 24 May 2017 11:42:19 +0200
Subject: Getting rid of nvme's pci watchdog timer?
In-Reply-To: <CALCETrWTmjrokDT3Ao5QsXonqUqKHWf9=Kp=z0x89rKTUz49Pg@mail.gmail.com>
References: <CALCETrWTmjrokDT3Ao5QsXonqUqKHWf9=Kp=z0x89rKTUz49Pg@mail.gmail.com>
Message-ID: <20170524094219.GB17483@lst.de>

On Tue, May 23, 2017@02:23:50PM -0700, Andy Lutomirski wrote:
> nvme polls pci devices to make sure they're not dead even when they're
> completely idle.  Can we fix that without killing scalability?  Can we
> piggyback off the block layer's timeout mechanism?  Could we simply
> *delete* the watchdog timer and add some CSTS and PCI_STATUS
> diagnostics to nvme_timeout()?
> 
> I doubt that one rounded wakeup per second makes much difference on
> CPU/package power saving, but it could be pretty bad for ASPM and
> maybe even APST power saving.

Note that section 8.4.1 in NVMe says controller should service mmio
access in non-operational power states.  That being said not touching
an idle controller all the time seems pretty useful to me.  I don't
really understand the need for the watchdog fully as it predates my
involvement, but I vaguely remember discussion the issue with Keith
a while ago, so he might be able to help.
