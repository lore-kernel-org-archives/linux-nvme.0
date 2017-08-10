From: hch@lst.de (Christoph Hellwig)
Date: Thu, 10 Aug 2017 10:36:50 +0200
Subject: [PATCH] nvme: fix directive command numd calculation
In-Reply-To: <6cfd6f4a-ead7-2e60-398e-748dd1b62b3c@kernel.dk>
References: <CGME20170809182322epcas2p177ff5f42184c24dcab4a73a9c640916b@epcas2p1.samsung.com>
 <1502303189-11939-1-git-send-email-kwan.huen@ssi.samsung.com>
 <6cfd6f4a-ead7-2e60-398e-748dd1b62b3c@kernel.dk>
Message-ID: <20170810083650.GA22739@lst.de>

On Wed, Aug 09, 2017@01:23:47PM -0600, Jens Axboe wrote:
> On 08/09/2017 12:26 PM, kwan.huen@ssi.samsung.com wrote:
> > From: "Kwan (Hingkwan) Huen-SSI" <kwan.huen at samsung.com>
> > 
> > The numd field of directive receive command takes number of dwords to 
> > transfer. This fix has the correct calculation for numd.
> 
> Oops, that's my bad.
> 
> Reviewed-by: Jens Axboe <axboe at kernel.dk>

Do you want to take it directly for the block tree?
