From: james.smart@broadcom.com (James Smart)
Date: Mon, 30 Oct 2017 12:52:44 -0700
Subject: [PATCH 2/5] nvme-fc: merge __nvme_fc_schedule_delete_work into
 __nvme_fc_del_ctrl
In-Reply-To: <20171029084431.8702-3-hch@lst.de>
References: <20171029084431.8702-1-hch@lst.de>
 <20171029084431.8702-3-hch@lst.de>
Message-ID: <3df3f145-8586-baef-a30e-ad31bef7a1e2@broadcom.com>

On 10/29/2017 1:44 AM, Christoph Hellwig wrote:
> No need to have two functions doing the same thing.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/fc.c | 20 ++++++--------------
>   1 file changed, 6 insertions(+), 14 deletions(-)
>
>

Looks fine.

Reviewed-by: James Smart? <james.smart at broadcom.com>
