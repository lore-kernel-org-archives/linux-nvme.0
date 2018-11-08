From: james.smart@broadcom.com (James Smart)
Date: Thu, 8 Nov 2018 08:50:15 -0800
Subject: [PATCH] nvme-core: add work elements to struct nvme_ctrl
In-Reply-To: <20181108003021.28624-1-sagi@grimberg.me>
References: <20181108003021.28624-1-sagi@grimberg.me>
Message-ID: <bc013b46-fd62-4490-1a5c-082350a851ad@broadcom.com>



On 11/7/2018 4:30 PM, Sagi Grimberg wrote:
> connect_work and err_work can be reused rdma, fc and by other future
> transports so share those in nvme_ctrl.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fc.c   | 18 ++++++++----------
>   drivers/nvme/host/nvme.h |  2 ++
>   drivers/nvme/host/rdma.c | 19 ++++++++-----------
>   3 files changed, 18 insertions(+), 21 deletions(-)
>
>
looks fine

Reviewed-by:?? James Smart?? <jsmart2021 at gmail.com>
