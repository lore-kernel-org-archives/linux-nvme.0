From: jsmart2021@gmail.com (James Smart)
Date: Fri, 14 Jul 2017 08:34:27 -0700
Subject: [PATCH 2/2] nvmet-fc: fix byte swapping in
 nvmet_fc_ls_create_association
In-Reply-To: <20170714104309.10757-2-hch@lst.de>
References: <20170714104309.10757-1-hch@lst.de>
 <20170714104309.10757-2-hch@lst.de>
Message-ID: <55bc4dc8-1ded-6b39-e47a-9109bbdc330e@gmail.com>

On 7/14/2017 3:43 AM, Christoph Hellwig wrote:
> We always need to do non-equal comparisms on the native endian versions
> to get the correct result.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: James Smart <james.smart at broadcom.com>
