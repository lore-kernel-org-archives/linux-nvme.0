From: maxg@mellanox.com (Max Gurtovoy)
Date: Sat, 16 Sep 2017 13:04:07 +0300
Subject: [PATCH v2] nvmet: implement valid sqhd values in completions
In-Reply-To: <20170914175810.13011-1-jsmart2021@gmail.com>
References: <20170914175810.13011-1-jsmart2021@gmail.com>
Message-ID: <e554b8fc-4045-eef0-44fe-ef707955bff7@mellanox.com>



On 9/14/2017 8:58 PM, James Smart wrote:
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
> v2: assignment corrected for endianness
> 
>   drivers/nvme/target/core.c        | 9 +++++----
>   drivers/nvme/target/fabrics-cmd.c | 9 +++++++--
>   drivers/nvme/target/nvmet.h       | 1 +
>   3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 7c23eaf8e563..764d46698b03 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -390,8 +390,8 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>   	if (status)
>   		nvmet_set_status(req, status);
>   
> -	/* XXX: need to fill in something useful for sq_head */
> -	req->rsp->sq_head = 0;
> +	req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
> +	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
>   	if (likely(req->sq)) /* may happen during early failure */
>   		req->rsp->sq_id = cpu_to_le16(req->sq->qid);
>   	req->rsp->command_id = req->cmd->common.command_id;

According to the "if (likely(req->sq)) /* may happen during early 
failure */" condition, we can get null deref here 2 lines above that...
