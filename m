From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 9 Feb 2017 14:26:02 +0000
Subject: [PATCH] block: sed-opal: reduce stack size of ioctl handler
In-Reply-To: <20170208211546.2789607-1-arnd@arndb.de>
References: <20170208211546.2789607-1-arnd@arndb.de>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0281652@AcuExch.aculab.com>

From: Arnd Bergmann
> Sent: 08 February 2017 21:15
>
> When CONFIG_KASAN is in use, the sed_ioctl function uses unusually large stack,
> as each possible ioctl argument gets its own stack area plus redzone:

Why not do a single copy_from_user() at the top of sed_ioctl() based on
the _IOC_DIR() and __IOC_SIZE() values?

Something like:
int sed_ioctl(..., unsigned int cmd, void __user *arg)
{
	u64 buf[??]; /* or a union */
	unsigned int cmd_sz = _IOC_SIZE(cmd);

	if (_IOC_DIR(cmd) & (_IOC_WRITE | _IOC_READ) && cmd_sz > sizeof buf)
		return -EINVAL;

	if (_IOC_DIR(cmd) & _IOC_WRITE) {
		if (copy_from_user(buf, arg, cmd_sz))
			return -EFAULT;
	} else {
		if (IOC_DIR(cmd) & _IOC_READ))
			memzero(buf, cmd_sz);
	}

	switch (cmd) {
	...
		rval = ...
	...
	}

	if (rval >= 0 && (_IOC_DIR(cmd) & _IOC_READ)
			&& copy_to_user(arg, buf, cmd_sz));
		return -EFAULT;

	return rval;
}

	David
