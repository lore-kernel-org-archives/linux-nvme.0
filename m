From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 14:11:51 -0700
Subject: [PATCH v6 5/7] nvme-tcp: fail command with
 NVME_SC_HOST_PATH_ERROR send failed
In-Reply-To: <20190813064304.7344-6-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
 <20190813064304.7344-6-sagi@grimberg.me>
Message-ID: <5043e03d-b6f2-6691-611b-e7d08feff0e3@broadcom.com>



On 8/12/2019 11:43 PM, Sagi Grimberg wrote:
> This is a more appropriate error status for a transport error
> detected by us (the host).
>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>

Reviewed-by: James Smart <james.smart at broadcom.com>

-- james
