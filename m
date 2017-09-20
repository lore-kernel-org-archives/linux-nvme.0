From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Sep 2017 14:14:02 +0300
Subject: [REPOST][PATCH v3] nvmet: implement valid sqhd values in
 completions
In-Reply-To: <20170918160829.895-1-jsmart2021@gmail.com>
References: <20170918160829.895-1-jsmart2021@gmail.com>
Message-ID: <1d417d0e-3ae8-7928-d3ab-ebd70657f8e5@grimberg.me>



On 18/09/17 19:08, James Smart wrote:
> To support sqhd, for initiators that are following the spec and
> paying attention to sqhd vs their sqtail values:
> - add sqhd to struct nvmet_sq
> - initialize sqhd to 0 in nvmet_sq_setup
> - rather than propagate the 0's-based qsize value from the connect message
>    which requires a +1 in every sqhd update, and as nothing else references
>    it, convert to 1's-based value in nvmt_sq/cq_setup() calls.
> - validate connect message sqsize being non-zero per spec.
> - updated assign sqhd for every completion that goes back.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v2:
>    v2: assignment corrected for endianness
> v3:
>    removed if test on req->sq that is unneeded
> 
>    repost fixed the "comment" indicator in the patch header
> 
>   drivers/nvme/target/core.c        | 12 ++++++------
>   drivers/nvme/target/fabrics-cmd.c |  9 +++++++--
>   drivers/nvme/target/nvmet.h       |  1 +
>   3 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 7c23eaf8e563..8c86c258d2e8 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -390,10 +390,9 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>   	if (status)
>   		nvmet_set_status(req, status);
>   
> -	/* XXX: need to fill in something useful for sq_head */
> -	req->rsp->sq_head = 0;
> -	if (likely(req->sq)) /* may happen during early failure */
> -		req->rsp->sq_id = cpu_to_le16(req->sq->qid);

It wasn't documented why it is safe to remove the condition statement.

Besides that, looks good to me,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
