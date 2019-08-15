From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Aug 2019 10:15:27 -0700
Subject: [PATCH 4/5] nvme-tcp: Add TOS for tcp transport
In-Reply-To: <1565876027-25092-6-git-send-email-israelr@mellanox.com>
References: <1565876027-25092-1-git-send-email-israelr@mellanox.com>
 <1565876027-25092-6-git-send-email-israelr@mellanox.com>
Message-ID: <8022ef05-466c-6994-2e63-e8084e9749b4@grimberg.me>


> @@ -2314,7 +2326,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
>   			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
> -			  NVMF_OPT_NR_WRITE_QUEUES,
> +			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_TOS,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };

This does not apply on nvme-5.4
