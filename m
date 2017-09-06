From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Sep 2017 12:38:16 +0200
Subject: [PATCH 2/3] nvmet-rdma: use SRQ per completion vector
In-Reply-To: <1504609157-3004-3-git-send-email-maxg@mellanox.com>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
 <1504609157-3004-3-git-send-email-maxg@mellanox.com>
Message-ID: <20170906103816.GB24667@lst.de>

> @@ -104,18 +107,25 @@ struct nvmet_rdma_queue {
>  
>  	int			idx;
>  	int			host_qid;
> +	int			comp_vector;

How will this interact with these changes:

http://git.infradead.org/users/hch/rdma.git/shortlog/refs/heads/rdma-cq.2

which I'd really like to see in?

> +struct nvmet_rdma_srq {
> +	struct ib_srq            *srq;
> +	struct nvmet_rdma_cmd    *srq_cmds;
> +	size_t                   srq_size;

Please kill the srq_ prefix, given that it's already implied by the
structure.

> +static void nvmet_rdma_destroy_srq(struct nvmet_rdma_srq *nsrq)
> +{
> +	if (!nsrq)
> +		return;

We should never get here with a null pointer, right?

>  	srq_attr.attr.max_wr = srq_size;
> @@ -808,27 +838,57 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
>  		 * non-shared receive queues.
>  		 */
>  		pr_info("SRQ requested but not supported.\n");
> +		kfree(nsrq);
>  		return 0;

goto out_free_nsrq..

> +	ndev->srqs[index] = nsrq;

Move this to the caller so that we don't need to pass in the index.

> +	ndev->srqs = kzalloc(srq_count * sizeof(*ndev->srqs), GFP_KERNEL);

kcalloc / kmalloc_array?

> +	if (ndev->srqs && ndev->srqs[queue->comp_vector % ndev->srq_count]) {

ndev->srqs[queue->comp_vector % ndev->srq_count] should always be
non-NULL, right?
