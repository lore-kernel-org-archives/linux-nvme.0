From: james.smart@broadcom.com (James Smart)
Date: Fri, 8 Mar 2019 11:15:35 -0800
Subject: [PATCH] nvmet-fc: use zero-sized array and struct_size() in
 kzalloc()
In-Reply-To: <20190223185108.GA6706@embeddedor>
References: <20190223185108.GA6706@embeddedor>
Message-ID: <b383ade6-f8fe-eb81-4d9c-a822e573390d@broadcom.com>

On 2/23/2019 10:51 AM, Gustavo A. R. Silva wrote:
> Update the code to use a zero-sized array instead of a pointer in
> structure nvmet_fc_tgt_queue and use struct_size() in kzalloc().
>
> Notice that one of the more common cases of allocation size calculations
> is finding the size of a structure that has a zero-sized array at the end,
> along with memory for some number of elements for that array. For example:
>
> struct foo {
> 	int stuff;
> 	struct boo entry[];
> };
>
> instance = kzalloc(sizeof(struct foo) + sizeof(struct boo) * count, GFP_KERNEL);
>
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
>
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
>
> This code was detected with the help of Coccinelle.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo at embeddedor.com>
> ---
>   drivers/nvme/target/fc.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 1e9654f04c60..23baec38f97e 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -128,12 +128,12 @@ struct nvmet_fc_tgt_queue {
>   	struct nvmet_cq			nvme_cq;
>   	struct nvmet_sq			nvme_sq;
>   	struct nvmet_fc_tgt_assoc	*assoc;
> -	struct nvmet_fc_fcp_iod		*fod;		/* array of fcp_iods */
>   	struct list_head		fod_list;
>   	struct list_head		pending_cmd_list;
>   	struct list_head		avail_defer_list;
>   	struct workqueue_struct		*work_q;
>   	struct kref			ref;
> +	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
>   } __aligned(sizeof(unsigned long long));
>   
>   struct nvmet_fc_tgt_assoc {
> @@ -588,9 +588,7 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (qid > NVMET_NR_QUEUES)
>   		return NULL;
>   
> -	queue = kzalloc((sizeof(*queue) +
> -				(sizeof(struct nvmet_fc_fcp_iod) * sqsize)),
> -				GFP_KERNEL);
> +	queue = kzalloc(struct_size(queue, fod, sqsize), GFP_KERNEL);
>   	if (!queue)
>   		return NULL;
>   
> @@ -603,7 +601,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
>   	if (!queue->work_q)
>   		goto out_a_put;
>   
> -	queue->fod = (struct nvmet_fc_fcp_iod *)&queue[1];
>   	queue->qid = qid;
>   	queue->sqsize = sqsize;
>   	queue->assoc = assoc;

Reviewed-by:? James Smart <james.smart at broadcom.com>

I guess this is a better style.

-- james
