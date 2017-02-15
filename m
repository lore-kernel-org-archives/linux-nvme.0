From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Feb 2017 10:54:56 +0200
Subject: [PATCH] nvmet: Fixed avoided printing nvmet: twice in error logs.
In-Reply-To: <1486591039-1177-1-git-send-email-parav@mellanox.com>
References: <1486591039-1177-1-git-send-email-parav@mellanox.com>
Message-ID: <07938b52-ca0c-f2bb-d8f8-4964475edf93@grimberg.me>


> This patch avoids printing "nvmet:" twice in error logs as its already
> coming through pr_fmt macro.
> It makes some of the logs more verbose by including qid to it.
> It avoid code duplication for checking controller status for admin and
> io queue by having common function for both that further can be reused
> by other transports.
> Fixed typo reported by Max Gurtovoy.

Hey Parav,

This looks good but please split this patch to:
1. nvmet_check_ctrl_status()
2. remove "nvmet:" from logging

> @@ -645,6 +645,22 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
>  	return status;
>  }
>
> +int nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)

Please return u16 status here.
