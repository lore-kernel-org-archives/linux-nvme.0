From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 25 Jul 2019 19:40:32 +0200
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <20190725172335.6825-3-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
Message-ID: <20190725174032.GA27818@kroah.com>

On Thu, Jul 25, 2019@11:23:21AM -0600, Logan Gunthorpe wrote:
> cdev_get_by_path() attempts to retrieve a struct cdev from
> a path name. It is analagous to blkdev_get_by_path().
> 
> This will be necessary to create a nvme_ctrl_get_by_path()to
> support NVMe-OF passthru.

Ick, why?  Why would a cdev have a "pathname"?

What is "NVMe-OF passthru"?  Why does a char device node have anything
to do with NVMe?

We have way too many ways to abuse cdevs today, my long-term-wish has
always been to clean this interface up to make it more sane and unified,
and get rid of the "outliers" (all created at the time for a good
reason, that's not the problem.)  But to add "just one more" seems
really odd to me.

thanks,

greg k-h
