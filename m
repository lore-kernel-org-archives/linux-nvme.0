From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jun 2018 09:59:24 +0200
Subject: [PATCH 3/4] nvme-fabrics: handle the admin-only case properly
 in nvmf_check_ready
In-Reply-To: <925032f4-4f28-4a2c-4255-61566c71595c@broadcom.com>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-4-hch@lst.de>
 <925032f4-4f28-4a2c-4255-61566c71595c@broadcom.com>
Message-ID: <20180613075924.GA22979@lst.de>

On Tue, Jun 12, 2018@02:48:33PM -0700, James Smart wrote:
> True. Although there was no validation of it being an admin cmd. But 
> reitterates my statement of NVME_CTRL_ADMIN_ONLY being just a variant of 
> NVME_CTRL_LIVE.

I have to admit that so far the NVME_CTRL_ADMIN_ONLY state has
created way too much trouble.  I wonder if we can find a better
fix for the original scanning problem that it solved using e.g
the number of queues variable?
