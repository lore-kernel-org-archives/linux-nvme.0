From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 9 Feb 2017 17:43:20 +0000
Subject: Sed-opal fixups 
In-Reply-To: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0281B85@AcuExch.aculab.com>

From: Scott Bauer
> Sent: 09 February 2017 17:20
> It may be too late to change anyhting in the uapi header. When we
> switched over to using IOC_SIZE I found a bug where I had switched
> up a structure in one of the series from v4 to v5 but never changed
> the structure in the IOW. The structure that was in there was to small
> so when we kzalloc on it we don't request enough space. It worked before
> because we were using the cmd strictly as a command #, not using the IOC
> and friends.
> 
> If it's too late to modify that IOW, I can work around it by reallocing
> on the correct size for that command only. I verified the rest of the
> commands and the structures are the same.
> 
> Let me know what you think, please.

Maybe define IOC_OPAL_ACTIVATE_LSP_OLD to the incorrect value and
IOC_OPAL_ACTIVATE_LSP to the correct one.
But that relies on any users specifying the correct structure.
I wouldn't guarantee that.

At the top of the driver's ioctl path add:
	if (cmd == IOC_OPAL_ACTIVATE_LSP_OLD) cmd = IOC_OPAL_ACTIVATE_LSP;

For some code I added a userspace wrapper on ioctl() to check the
size of the supplied arg matched that required by the 'cmd'.
I've also done the same in the kernel.
(all as compile time checks).

	David
