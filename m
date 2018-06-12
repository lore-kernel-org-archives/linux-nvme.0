From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 14:47:01 -0700
Subject: [PATCH 2/4] nvme-fabrics: handle queue ready fast path inline
In-Reply-To: <20180611154647.32558-3-hch@lst.de>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-3-hch@lst.de>
Message-ID: <16e906ac-0d27-8880-8f15-135337341b5f@broadcom.com>



On 6/11/2018 8:46 AM, Christoph Hellwig wrote:
> Avoid a function call for the queue live fast path.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/fabrics.c |  7 ++-----
>   drivers/nvme/host/fabrics.h | 10 +++++++++-
>   2 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 72d290c71a1e..6b4e253b9347 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
>

Reviewed-by:?? James Smart ? <james.smart at broadcom.com>
