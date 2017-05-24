From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 May 2017 07:21:42 -0400
Subject: Getting rid of nvme's pci watchdog timer?
In-Reply-To: <20170524094219.GB17483@lst.de>
References: <CALCETrWTmjrokDT3Ao5QsXonqUqKHWf9=Kp=z0x89rKTUz49Pg@mail.gmail.com>
 <20170524094219.GB17483@lst.de>
Message-ID: <20170524112141.GA13742@localhost.localdomain>

On Wed, May 24, 2017@11:42:19AM +0200, Christoph Hellwig wrote:
> an idle controller all the time seems pretty useful to me.  I don't
> really understand the need for the watchdog fully as it predates my
> involvement, but I vaguely remember discussion the issue with Keith
> a while ago, so he might be able to help.

This was originally added to the driver's health check kthread to
keep a pulse on the devices, but I think it's causing more harm than
good. The hotplug races are bad enough, and this power savings killer is
yet another reason to remove it. I'm in favor of removing the watchdog
timer and moving the status check to the timeout callback so we verify
health only when we have a reason to believe something is wrong.
