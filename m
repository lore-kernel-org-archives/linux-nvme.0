From: hch@lst.de (Christoph Hellwig)
Date: Tue, 7 Jun 2016 12:49:25 +0200
Subject: [PATCH 01/10] nvme.h: add RTD3R, RTD3E and OAES fields
In-Reply-To: <20160607081009.xd7wsyfuv4swuf4p@c203.arch.suse.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
 <1465248052-17811-2-git-send-email-hch@lst.de>
 <20160607081009.xd7wsyfuv4swuf4p@c203.arch.suse.de>
Message-ID: <20160607104925.GA17103@lst.de>

On Tue, Jun 07, 2016@10:10:09AM +0200, Johannes Thumshirn wrote:
> Just out of curiosity, why not CTRATT as well?

ctratt is part of the fabrics spec and not the NVMe 1.2 spec, and we tried
to keep those separate.
