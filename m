From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 10 Feb 2017 15:51:24 +0100
Subject: [PATCH v2 1/4] MicroSemi Switchtec management interface driver
In-Reply-To: <1486058763-7730-2-git-send-email-logang@deltatee.com>
References: <1486058763-7730-1-git-send-email-logang@deltatee.com>
 <1486058763-7730-2-git-send-email-logang@deltatee.com>
Message-ID: <20170210145124.GA24594@kroah.com>

On Thu, Feb 02, 2017@11:06:00AM -0700, Logan Gunthorpe wrote:
> +	cdev = &stdev->cdev;
> +	cdev_init(cdev, &switchtec_fops);
> +	cdev->owner = THIS_MODULE;
> +	cdev->kobj.parent = &dev->kobj;

Minor nit, the kobject in a cdev is unlike any other kobject you have
ever seen, don't mess with it, it's not doing anything like you think it
is doing.  So no need to set the parent field.

thanks,

greg k-h
