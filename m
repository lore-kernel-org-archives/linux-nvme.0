From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Nov 2018 09:28:15 -0700
Subject: [RFC PATCH] nvme of: don't flush scan work inside reset context
In-Reply-To: <20181105115734.15515-1-ming.lei@redhat.com>
References: <20181105115734.15515-1-ming.lei@redhat.com>
Message-ID: <20181105162814.GA3443@localhost.localdomain>

On Mon, Nov 05, 2018@07:57:34PM +0800, Ming Lei wrote:
> -void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> +void nvme_stop_ctrl(struct nvme_ctrl *ctrl, bool flush_scan)
>  {
>  	nvme_mpath_stop(ctrl);
>  	nvme_stop_keep_alive(ctrl);

Newly added parameter 'flush_scan' is unsused. ?
