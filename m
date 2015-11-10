From: hch@lst.de (Christoph Hellwig)
Date: Tue, 10 Nov 2015 06:57:07 +0100
Subject: [PATCH 07/12] nvme: special case AEN requests
In-Reply-To: <564114AF.4010201@kernel.dk>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-8-git-send-email-hch@lst.de>
 <20151109214038.GE5386@localhost.localdomain> <564114AF.4010201@kernel.dk>
Message-ID: <20151110055707.GB19753@lst.de>

On Mon, Nov 09, 2015@02:48:31PM -0700, Jens Axboe wrote:
> That fact is just implementation detail, I don't think we should make 
> assumptions about the range of reserved vs normal tags. That's just asking 
> for trouble if this changes at some point.

I'm pretty sure I did see another driver (hpsa patchset?) do this as well.
I can add a is_reserved_tag helper which still uses that knowledege, but
keeps it inside the block layer.
