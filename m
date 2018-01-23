From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Jan 2018 14:45:31 +0200
Subject: [PATCH 1/5] nvme: Request cancelling helpers
In-Reply-To: <20180122215630.13697-1-keith.busch@intel.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
Message-ID: <7fd83a08-b0f3-9580-2f6f-9e333b046772@grimberg.me>


> +void nvme_set_iter(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> +		   busy_tag_iter_fn *fn)

Nit: maybe nvme_tagset_iter?


Other than that looks good!

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
