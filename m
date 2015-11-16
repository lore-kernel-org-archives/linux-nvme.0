From: hch@lst.de (Christoph Hellwig)
Date: Mon, 16 Nov 2015 09:32:32 +0100
Subject: [RFC] generic NVMe target and NVMe loop driver
In-Reply-To: <1447661338.10221.8.camel@hasee>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
 <1447659004.23230.102.camel@haakon3.risingtidesystems.com>
 <1447661338.10221.8.camel@hasee>
Message-ID: <20151116083232.GC21218@lst.de>

On Mon, Nov 16, 2015@12:08:58AM -0800, Ming Lin wrote:
> But the tests I have done so far didn't show competitive performance
> compared with vhost-scsi. Maybe because the mmio thing is slow.

It is.  Take a look at the google patches for the NVMe even index
extension, which make it behave a lot more like virtio.
