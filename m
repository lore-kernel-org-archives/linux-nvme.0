From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Mon, 1 Feb 2016 16:36:00 +0000
Subject: Is nvme_clear_queue() correct?
Message-ID: <BJXPR01MB1993DAAA2A2F862E41AA849E0DE0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

Hi,

nvme_clear_queue() is invoked by nvme_dev_disable. It finds all inuse tags and cancels the corresponding requests. However, it seems to have some issues:

1. Some requests might be in q->request_list, ctx->rq_list or hctx->dispatch. nvme_clear_queue does not remove them from these lists, it may cause problems.
2. Some blk_mq_run_hw_queue might be running concurrently with nvme_dev_disable, they are not aware that the requests have been canceled.

Looking forward to your comments. Thanks.
