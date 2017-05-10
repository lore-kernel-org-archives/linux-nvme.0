From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 May 2017 16:41:21 +0200
Subject: [PATCH nvme-cli] fabrics: add option to override drivers queue
 depth
In-Reply-To: <20170510090412.14132-1-jthumshirn@suse.de>
References: <20170510090412.14132-1-jthumshirn@suse.de>
Message-ID: <20170510144120.GA24518@lst.de>

On Wed, May 10, 2017@11:04:12AM +0200, Johannes Thumshirn wrote:
> Currently it is not possible to override the fabrics drivers default queue
> depth with the nvme userspace utility, but only when manually writing the
> parameters to the /dev/nvme-fabrics character device.
> 
> Add an option to override the drivers default queue depth for NVMe over
> fabrics.

Looks fine, but we should probably also add this to connect-all.
