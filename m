From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 Jan 2018 11:37:45 +0200
Subject: [PATCH] nvme: check ctrl.tagset before start ns scan
In-Reply-To: <1514916461-8696-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1514916461-8696-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <ef7f1b69-c042-60f7-6bd3-6dd4c4d73b90@grimberg.me>

Hi Jianchao,

> ctrl.tagset maybe NULL due to failure of io queue setup or blk-mq
> tagset allocation in nvme_reset_work. Then panic would come up.
> To fix this, just add ctrl.tagset check in nvme_scan_work.

This came up before (and forgotten...) I think we should not
have state indicators other than ctrl->state.

How about instead we add a new state NVME_CTRL_ADMIN_LIVE when we have
no I/O queues.
