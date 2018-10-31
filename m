From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 17:31:08 -0700
Subject: [PATCH 02/16] blk-mq: abstract out queue map
In-Reply-To: <20181030183252.17857-3-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-3-axboe@kernel.dk>
Message-ID: <725b4d35-2390-58d9-4041-0bac6de6cd77@grimberg.me>


> @@ -41,12 +41,12 @@ int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
>   			goto fallback;
>   
>   		for_each_cpu(cpu, mask)
> -			set->mq_map[cpu] = queue;
> +			set->map[0].mq_map[cpu] = queue;

Any reason not to change the signature like the other mappers?
