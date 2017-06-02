From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 2 Jun 2017 09:52:03 +0200
Subject: [PATCH 4/4] nvme-pci: implement host memory buffer support
In-Reply-To: <20170601112729.9726-5-hch@lst.de>
References: <20170601112729.9726-1-hch@lst.de>
 <20170601112729.9726-5-hch@lst.de>
Message-ID: <4adef89c-fa40-4b0b-cc65-a7f9c4175e0b@suse.de>

On 06/01/2017 01:27 PM, Christoph Hellwig wrote:
> If a controller supports the host memory buffer we try to provide
> it with the requested size up to an upper cap set as a module
> parameter.  We try to give as few as possible descriptors, eventually
> working our way down.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---

I don't really think the goto back and forth jumping is very intuitive,
but I can't come up with a better solution either, so
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
