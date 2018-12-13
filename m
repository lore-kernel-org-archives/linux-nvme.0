From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:52:43 +0100
Subject: [PATCH V2 04/12] nvmet: add interface to update error-log page
In-Reply-To: <20181212231148.4107-5-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
 <20181212231148.4107-5-chaitanya.kulkarni@wdc.com>
Message-ID: <20181213085243.GA1611@lst.de>

This needed a little byte swapping fix:


diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ba0ab5481cc5..cc81d0231587 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -677,7 +677,7 @@ static void nvmet_set_error(struct nvmet_req *req, u16 status)
 	new_error_slot->status_field = cpu_to_le16(status << 1);
 	new_error_slot->param_error_location = cpu_to_le16(req->error_loc);
 	new_error_slot->lba = cpu_to_le64(req->error_slba);
-	new_error_slot->nsid = cpu_to_le32(req->cmd->common.nsid);
+	new_error_slot->nsid = req->cmd->common.nsid;
 	spin_unlock_irqrestore(&ctrl->error_lock, flags);
 
 	/* set the more bit for this request */
