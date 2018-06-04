From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Jun 2018 14:56:44 +0200
Subject: [PATCH] nvme: avoid hang on inaccessible paths
In-Reply-To: <db93e436-8f3b-352b-7395-f8eb7cf2e198@grimberg.me>
References: <20180530111637.22223-1-hare@suse.de>
 <20180530121241.GA1850@lst.de> <20180530143020.50a299b8@pentland.suse.de>
 <20180530125452.GA2763@lst.de>
 <35d5d780-b1c2-d176-639b-b41106e3e980@grimberg.me>
 <20180604082455.6369788d@pentland.suse.de> <20180604063753.GA20811@lst.de>
 <db93e436-8f3b-352b-7395-f8eb7cf2e198@grimberg.me>
Message-ID: <20180604125644.GB30945@lst.de>

On Mon, Jun 04, 2018@03:17:43PM +0300, Sagi Grimberg wrote:
> From udev man:
>
> RUN{type}
>
> ...
>        This can only be used for very short-running foreground tasks.
>        Running an event process for a long period of time may block all
>        further events for this or a dependent device.
>
>        Starting daemons or other long running processes is not appropriate
>        for udev; the forked processes, detached or not, will be
>        unconditionally killed after the event handling has finished.
>
> One way around this is to disown the command from udev shell
> (e.g. $cmd & disown)

Oh well.  Offloading to a workqueue in the kernel to work around
this just doesn't really sound like the proper solution.  Then again
our connect really should not take longer than a reasonable timeout
anyway..
