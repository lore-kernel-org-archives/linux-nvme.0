From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 12 Feb 2017 23:54:22 -0800
Subject: [PATCH V4 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
In-Reply-To: <1486742454-3254-3-git-send-email-scott.bauer@intel.com>
References: <1486742454-3254-1-git-send-email-scott.bauer@intel.com>
 <1486742454-3254-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20170213075422.GB20361@infradead.org>

>  int sed_ioctl(struct opal_dev *dev, unsigned int cmd, unsigned long ptr)
>  {
> +	void *ioctl_ptr;
> +	int ret = -ENOTTY;
>  	void __user *arg = (void __user *)ptr;

Can we use this opportunity to clean up the usual ioctl argument mess.
Id say pass the "void __user *argp" argument already (nvme_ioctl should
have a local variable for it anyway), and then just rename ioctl_ptr
variable to the usual short p.

> +	unsigned int cmd_size = _IOC_SIZE(cmd);
>  

> +	ioctl_ptr = memdup_user(arg, cmd_size);

cmd_size is only used once, so why not opencode the expression in the
argument to memdup_user.
