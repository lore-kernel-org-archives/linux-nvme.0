From: james.smart@broadcom.com (James Smart)
Date: Mon, 30 Oct 2017 12:58:06 -0700
Subject: [PATCH 3/5] nvme: move controller deletion to common code
In-Reply-To: <20171029084431.8702-4-hch@lst.de>
References: <20171029084431.8702-1-hch@lst.de>
 <20171029084431.8702-4-hch@lst.de>
Message-ID: <89831278-db71-8fb4-b562-3da9ebbb5cd5@broadcom.com>

On 10/29/2017 1:44 AM, Christoph Hellwig wrote:
> Move the ->delete_work and the associated helpers to common code instead
> of duplicating them in every driver.  This also adds the missing reference
> get/put for the loop driver.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>

Looks fine.

Reviewed-by: James Smart? <james.smart at broadcom.com>
