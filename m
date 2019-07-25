From: willy@infradead.org (Matthew Wilcox)
Date: Thu, 25 Jul 2019 12:00:24 -0700
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <20190725182701.GA11547@kroah.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
 <20190725182701.GA11547@kroah.com>
Message-ID: <20190725190024.GD30641@bombadil.infradead.org>

On Thu, Jul 25, 2019@08:27:01PM +0200, Greg Kroah-Hartman wrote:
> > NVMe-OF is configured using configfs. The target is specified by the
> > user writing a path to a configfs attribute. This is the way it works
> > today but with blkdev_get_by_path()[1]. For the passthru code, we need
> > to get a nvme_ctrl instead of a block_device, but the principal is the same.
> 
> Why isn't a fd being passed in there instead of a random string?

I suppose we could echo a string of the file descriptor number there,
and look up the fd in the process' file descriptor table ...

I'll get my coat.
