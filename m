From: joe@perches.com (Joe Perches)
Date: Sat, 23 Feb 2019 12:05:50 -0800
Subject: [PATCH] nvmet-fc: use zero-sized array and struct_size() in
 kzalloc()
In-Reply-To: <20190223185108.GA6706@embeddedor>
References: <20190223185108.GA6706@embeddedor>
Message-ID: <a38ddf4132398ca7f1705fa377fb52a2b09a2801.camel@perches.com>

On Sat, 2019-02-23@12:51 -0600, Gustavo A. R. Silva wrote:
> Update the code to use a zero-sized array instead of a pointer in
> structure nvmet_fc_tgt_queue and use struct_size() in kzalloc().
[]
> This code was detected with the help of Coccinelle.

Really?
Impressive script that found this one.

> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
[]
> @@ -128,12 +128,12 @@ struct nvmet_fc_tgt_queue {
>  	struct nvmet_cq			nvme_cq;
>  	struct nvmet_sq			nvme_sq;
>  	struct nvmet_fc_tgt_assoc	*assoc;
> -	struct nvmet_fc_fcp_iod		*fod;		/* array of fcp_iods */
>  	struct list_head		fod_list;
>  	struct list_head		pending_cmd_list;
>  	struct list_head		avail_defer_list;
>  	struct workqueue_struct		*work_q;
>  	struct kref			ref;
> +	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
>  } __aligned(sizeof(unsigned long long));

Moving a pointer from the middle of a struct to
the end seems unusual for coccinelle.
