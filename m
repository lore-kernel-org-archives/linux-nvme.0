From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Jul 2017 09:29:26 +0300
Subject: [PATCH 8/8] xen-blockfront: quiesce IO before device removal
In-Reply-To: <20170704221908.GA3732@ming.t460p>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-9-git-send-email-sagi@grimberg.me>
 <20170704221908.GA3732@ming.t460p>
Message-ID: <77cea68f-7915-2bbf-0861-05d1ca389e6c@grimberg.me>



> Looks the above change isn't needed since this blk_mq_start_stopped_hw_queues()
> should have been the counterpart of blk_mq_stop_hw_queue() in
> blkif_queue_rq().

Removed the patch altogether in v2 as I'm not convinced it is needed.
