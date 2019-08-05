From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Aug 2019 11:10:44 -0700
Subject: [PATCH] nvme: simplify nvme_req_qid()
In-Reply-To: <20190804071902.31872-1-minwoo.im.dev@gmail.com>
References: <20190804071902.31872-1-minwoo.im.dev@gmail.com>
Message-ID: <4ce851fc-2560-cb45-9733-bb8ff4a5069e@grimberg.me>


> blk_mq_unique_tag() just makes a unique tag which holds not only the
> tag, but also the queue_num of the hctx.  With this unique tag,
> blk_mq_unique_tag_to_hwq is nothing but removing the tag from it.
> 
> Therefore the qid or the I/O queues can simply be:
> 	(struct blk_mq_hw_ctx *)->queue_num + 1

This pattern is not unique to nvme, perhaps add a helper for it
in the block layer and modify the callers?
