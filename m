From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Jun 2017 18:06:02 +0200
Subject: [PATCH v2] nvme: use uuid_t in nvme_ns
In-Reply-To: <20170612091240.18343-1-jthumshirn@suse.de>
References: <20170612091240.18343-1-jthumshirn@suse.de>
Message-ID: <20170612160602.GB30030@lst.de>

On Mon, Jun 12, 2017@11:12:40AM +0200, Johannes Thumshirn wrote:
> struct nvme_ns still uses u u8 uuid[16], change it to using uuid_t and
> use the UUID API.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Thanks, folded into the two patches originall introducing the code.
