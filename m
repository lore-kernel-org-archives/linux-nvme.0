From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 May 2017 11:05:04 +0300
Subject: [PATCH 3/3] nvme-rdma: Support ctrl_loss_tmo
In-Reply-To: <d52b4109-e6d7-9085-a358-8812f937d169@broadcom.com>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
 <1489876941-6401-4-git-send-email-sagi@grimberg.me>
 <d52b4109-e6d7-9085-a358-8812f937d169@broadcom.com>
Message-ID: <a81f3f86-3d41-b8b3-2453-5aa2d10e2bed@grimberg.me>


> Shouldn't there be a:
>         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
>                 return;
>
> right here ?

Correct. I'll send a fix.
