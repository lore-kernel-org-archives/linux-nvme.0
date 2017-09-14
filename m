From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 14 Sep 2017 10:01:39 -0700
Subject: [PATCH] nvmet: implement valid sqhd values in completions
In-Reply-To: <20170907201836.25067-1-jsmart2021@gmail.com>
References: <20170907201836.25067-1-jsmart2021@gmail.com>
Message-ID: <20170914170139.GA25583@infradead.org>

On Thu, Sep 07, 2017@01:18:36PM -0700, James Smart wrote:
> To support sqhd, for initiators that are following the spec and
> paying attention to sqhd vs their sqtail values:
> - add sqhd to struct nvmet_sq
> - initialize sqhd to 0 in nvmet_sq_setup
> - rather than propagate the 0's-based qsize value from the connect message
>   which requires a +1 in every sqhd update, and as nothing else references
>   it, convert to 1's-based value in nvmt_sq/cq_setup() calls.
> - validate connect message sqsize being non-zero per spec.
> - updated assign sqhd for every completion that goes back.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/target/core.c        | 9 +++++----
>  drivers/nvme/target/fabrics-cmd.c | 9 +++++++--
>  drivers/nvme/target/nvmet.h       | 1 +
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 7c23eaf8e563..434394ead4a2 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -390,8 +390,8 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>  	if (status)
>  		nvmet_set_status(req, status);
>  
> -	/* XXX: need to fill in something useful for sq_head */
> -	req->rsp->sq_head = 0;
> +	req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
> +	req->rsp->sq_head = req->sq->sqhd;

This is missing an endianes conversion:

drivers/nvme/target/core.c:394:27: warning: incorrect type in assignment (different base types)
drivers/nvme/target/core.c:394:27:    expected restricted __le16 [usertype] sq_head
drivers/nvme/target/core.c:394:27:    got unsigned short [unsigned] [usertype] sqhd
