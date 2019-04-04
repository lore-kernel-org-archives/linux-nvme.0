From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 4 Apr 2019 19:38:33 +0000
Subject: [PATCH] Log error status on Identify Namespace failure
In-Reply-To: <20190404185745.12501-1-kenneth.heitke@intel.com>
References: <20190404185745.12501-1-kenneth.heitke@intel.com>
Message-ID: <7EFB9BA7-79C5-454F-B106-75C0C282E2EB@wdc.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>


On 4/4/19, 11:57 AM, "Linux-nvme on behalf of Kenneth Heitke" <linux-nvme-bounces@lists.infradead.org on behalf of kenneth.heitke@intel.com> wrote:

    Identify Namespace failures are logged as a warning but there is not
    an indication of the cause for the failure. Update the log message to
    include the error status.
    
    Signed-off-by: Kenneth Heitke <kenneth.heitke at intel.com>
    ---
     drivers/nvme/host/core.c | 2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)
    
    diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
    index b5939112b9b6..ddb943395118 100644
    --- a/drivers/nvme/host/core.c
    +++ b/drivers/nvme/host/core.c
    @@ -1105,7 +1105,7 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
     
     	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
     	if (error) {
    -		dev_warn(ctrl->device, "Identify namespace failed\n");
    +		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
     		kfree(id);
     		return NULL;
     	}
    -- 
    2.17.1
    
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
