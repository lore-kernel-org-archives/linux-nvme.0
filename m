From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Nov 2014 15:51:52 +0000 (UTC)
Subject: System hang issue during hibernation resume due to del_gendisk
In-Reply-To: <908627706.204341415718459019.JavaMail.weblogic@epmlwas06b>
References: <908627706.204341415718459019.JavaMail.weblogic@epmlwas06b>
Message-ID: <alpine.LNX.2.00.1411111511590.4225@localhost.lm.intel.com>

On Tue, 11 Nov 2014, Sunad Bhandary S wrote:
> Hi Keith,
>
> While I was working with NVMe devices I came across a system hang issue. The
> following are the steps to reproduce the issue:
>
> 1) Mounted a NVMe device with  Linux NVMe Driver and EXT3 file format .
> 2) Put the device to hibernate state using pm-hibernate
> 3) Remove the NVMe device.
> 4) Resume from hibernation
> The system hangs up with a blank screen and the only option is to force reboot.
>
> I suspect this to be a issue with the call of del_gendisk. If i make the call
> to del_gendisk in the cleanup path in the free_namespaces function the system
> resumes without any issues for the same scenario.

I am surprised to hear you can remove a pci device while hibernated.

I knew calling del_gendisk from resume wouldn't work, which is why it's
done in a work queue, and removed in another thread if the device is
gone. That's still not okay?

I don't think we want to move del_gendisk to free_namespace since it
will leave the device available to new opens after it is removed.

> Also the issue is not observed in EXT4 file format.
>
> The issue seems to be the same as discussed here
> https://groups.google.com/forum/#!topic/fa.linux.kernel/aHbwSyQdADY . I am
> keen to know if this issue has been fixed in the latest kernel versions and
> if it is safe to call del_gendisk when the userspace is frozen in the latest
> kernel versions.

Thanks for the link! I'm definitely interested to see if there's something
better we can do in this area.

> Regards,
> Sunad
