From: james.smart@broadcom.com (James Smart)
Date: Wed, 31 Jan 2018 09:10:56 -0800
Subject: [PATCH 2/3] nvme-rdma: use NVME_CTRL_CONNECTING state to mark
 init process
In-Reply-To: <1517416286-31109-3-git-send-email-maxg@mellanox.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
 <1517416286-31109-3-git-send-email-maxg@mellanox.com>
Message-ID: <3fa126f5-afdb-a361-c755-914ab28e56fb@broadcom.com>

On 1/31/2018 8:31 AM, Max Gurtovoy wrote:
> In order to avoid concurrent error recovery during initialization
> process (allowed by the NVME_CTRL_NEW --> NVME_CTRL_RESETTING transition)
> we must mark the ctrl as CONNECTING before initial connection
> establisment.
>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>


Reviewed-by: James Smart <james.smart at broadcom.com>

Prefer to have Sagi sign off as well on the rdma part

-- james
