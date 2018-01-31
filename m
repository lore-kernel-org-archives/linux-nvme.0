From: james.smart@broadcom.com (James Smart)
Date: Wed, 31 Jan 2018 09:10:03 -0800
Subject: [PATCH 1/3] nvme: rename NVME_CTRL_RECONNECTING state to
 NVME_CTRL_CONNECTING
In-Reply-To: <1517416286-31109-2-git-send-email-maxg@mellanox.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
 <1517416286-31109-2-git-send-email-maxg@mellanox.com>
Message-ID: <de653273-cdff-97eb-8385-d89215c764c0@broadcom.com>

On 1/31/2018 8:31 AM, Max Gurtovoy wrote:
> In pci transport, this state is used to mark the initialization
> process. This should be also used in other transports as well.
>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---

Reviewed-by: James Smart <james.smart at broadcom.com>
