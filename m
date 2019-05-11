From: hch@lst.de (Christoph Hellwig)
Date: Sat, 11 May 2019 09:18:22 +0200
Subject: [PATCH] nvme: add support for Verify command opcode
In-Reply-To: <20190511000406.5458-1-kenneth.heitke@intel.com>
References: <20190511000406.5458-1-kenneth.heitke@intel.com>
Message-ID: <20190511071822.GA14764@lst.de>

On Fri, May 10, 2019@06:04:06PM -0600, Kenneth Heitke wrote:
> This allows the Verify command to be sent using the
> NVME_IOCTL_SUBMIT_IO ioctl.
> 
> Signed-off-by: Kenneth Heitke <kenneth.heitke at intel.com>

I think we've decided that NVME_IOCTL_SUBMIT_IO is deprecated and
everyone should be using NVME_IOCTL_IO_CMD instead.

Maybe we need to add an official deprecating warnings (probably
just a printk_once, maybe per process name?)
