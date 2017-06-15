From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 14:11:19 +0200
Subject: [PATCH] nvme: move protection information check into nvme_setup_rw
In-Reply-To: <d64302e7-6fae-3171-5634-59da3c964bee@grimberg.me>
References: <20170612163632.23009-1-hch@lst.de>
 <d64302e7-6fae-3171-5634-59da3c964bee@grimberg.me>
Message-ID: <20170615121119.GB23200@lst.de>

On Thu, Jun 15, 2017@12:21:45PM +0300, Sagi Grimberg wrote:
> Not directly related to this patch, but 8 should be replaced with
> sizeof(struct t10_pi_tuple).
>
> Otherwise looks good,
>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>
> Should I send out an incremental change?

Yes, please do.
