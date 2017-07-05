From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Jul 2017 19:27:20 +0200
Subject: [PATCH v2 8/8] nvme-fc: use blk_mq_delay_run_hw_queue instead
 of open-coding it
In-Reply-To: <1499155056-11241-9-git-send-email-sagi@grimberg.me>
References: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
 <1499155056-11241-9-git-send-email-sagi@grimberg.me>
Message-ID: <20170705172720.GC5417@lst.de>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
