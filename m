From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 16:23:31 +0100
Subject: NVMe: Regression: write zeros corrupts ext4 file system
In-Reply-To: <20190311145457.GA10411@localhost.localdomain>
References: <20190311022441.GA16849@ming.t460p>
 <20190311145457.GA10411@localhost.localdomain>
Message-ID: <20190311152331.GA9000@lst.de>

On Mon, Mar 11, 2019@08:54:59AM -0600, Keith Busch wrote:
> In QEMU, blk_aio_pwrite_zeroes() takes bytes, but the nvme controller
> thought it was blocks. Oops, that went by unnoticed till now!
> 
> We should fix QEMU (patch below). Question is, should we quirk driver 
> for older versions too?

I think we should.  We are actually still quirking all qemu controllers
for broken Identify behavior, at some point we'll have to make them
version specific..
