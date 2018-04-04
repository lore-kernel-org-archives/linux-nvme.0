From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 15:39:02 +0300
Subject: [PATCH] nvme-multipath: implement active-active round-robin path
 selector
In-Reply-To: <20180327043851.6640-1-baegjae@gmail.com>
References: <20180327043851.6640-1-baegjae@gmail.com>
Message-ID: <6a9c0385-7055-13da-fc5b-f7b7c41cd3eb@grimberg.me>


> @@ -85,7 +121,14 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
>   	int srcu_idx;
>   
>   	srcu_idx = srcu_read_lock(&head->srcu);
> -	ns = nvme_find_path(head);
> +	switch (head->mpath_policy) {
> +	case NVME_MPATH_ROUND_ROBIN:
> +		ns = nvme_find_path_rr(head);
> +		break;
> +	case NVME_MPATH_ACTIVE_STANDBY:
> +	default:
> +		ns = nvme_find_path(head);
> +	}

If we grow multiple path selectors, would be more elegant to
use a callout mechanism.
