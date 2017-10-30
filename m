From: james.smart@broadcom.com (James Smart)
Date: Mon, 30 Oct 2017 13:00:29 -0700
Subject: [PATCH 5/5] nvme: consolidate common code from ->reset_work
In-Reply-To: <20171029084431.8702-6-hch@lst.de>
References: <20171029084431.8702-1-hch@lst.de>
 <20171029084431.8702-6-hch@lst.de>
Message-ID: <09da8c25-e855-f260-ac56-cff3de54e9f9@broadcom.com>

On 10/29/2017 1:44 AM, Christoph Hellwig wrote:
> No change in behavior except that the FC code cancels two work items a
> little later now.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>


Looks fine.

Reviewed-by: James Smart? <james.smart at broadcom.com>
