From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 28 Mar 2018 01:31:36 -0700
Subject: [PATCH v2] nvme: expand nvmf_check_if_ready checks
In-Reply-To: <20180327230724.25843-1-jsmart2021@gmail.com>
References: <20180327230724.25843-1-jsmart2021@gmail.com>
Message-ID: <20180328083136.GC31409@infradead.org>

> +static inline blk_status_t nvmf_check_if_ready(struct nvme_ctrl *ctrl,
> +		struct request *rq, bool qlive, bool connectivity)

Please rename qlive to queue_live and explain what connectivity means.
Maye this should be is_connected?  How do we get a command on a not
conected queue?

Also I think the function is large enough now to move out of line.
