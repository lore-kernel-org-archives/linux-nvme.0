From: james.smart@broadcom.com (James Smart)
Date: Wed, 31 Jan 2018 09:11:36 -0800
Subject: [PATCH 3/3] nvme: delete NVME_CTRL_LIVE --> NVME_CTRL_CONNECTING
 transition
In-Reply-To: <1517416286-31109-4-git-send-email-maxg@mellanox.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
 <1517416286-31109-4-git-send-email-maxg@mellanox.com>
Message-ID: <bb905705-7f96-a3e1-aa01-bd910a8a49fa@broadcom.com>

On 1/31/2018 8:31 AM, Max Gurtovoy wrote:
> There is no logical reason to move from live state to connecting
> state. In case of initial connection establishment, the transition
> should be NVME_CTRL_NEW --> NVME_CTRL_CONNECTING --> NVME_CTRL_LIVE.
> In case of error recovery or reset, the transition should be
> NVME_CTRL_LIVE --> NVME_CTRL_RESETTING --> NVME_CTRL_CONNECTING -->
> NVME_CTRL_LIVE.
>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>


Reviewed-by: James Smart <james.smart at broadcom.com>
