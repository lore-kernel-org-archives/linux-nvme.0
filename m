From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 17 Dec 2018 13:58:28 -0800
Subject: [PATCH] nvme-rdma: fix timeout handler
In-Reply-To: <20181216163217.GA12814@lst.de>
References: <20181213212917.8900-1-sagi@grimberg.me>
 <20181216163217.GA12814@lst.de>
Message-ID: <a9c82a82-6841-3e3d-54b1-659c72a062fd@grimberg.me>


> So why did nvme_rdma_error_recovery not complete this request?
> I think that is where our problem is, and we are just papering over it.

nvme_rdma_error_recovery in essence, kicks in when the controller is
LIVE and only then sees a failure. What it does is teardown the
controller and schedule a periodic reconnect work..

When we fail the connection establishment, we don't want to do that,
but simply fail and let create_ctrl cleanup and fail.

Technically, nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) is
failing because we are not LIVE, but rather CONNECTING (as we are still
in the create_ctrl time).
