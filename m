From: keith.busch@intel.com (Keith Busch)
Date: Thu, 5 Apr 2018 17:05:16 -0600
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <20180405224830.GI10098@localhost.localdomain>
References: <5d6d1a8c-6490-4046-0fba-da0a0df3d00c@gmail.com>
 <20180405213847.GG10098@localhost.localdomain>
 <20180405212205.33dqwqck2co25a3x@sbauer-Z170X-UD5>
 <719ea777-e57d-511e-52c5-cf83027d1fd0@gmail.com>
 <20180405224138.GH10098@localhost.localdomain>
 <20180405224830.GI10098@localhost.localdomain>
Message-ID: <20180405230515.GJ10098@localhost.localdomain>

Just trying to confirm a suspicion, could you retry with the following?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b6f43b738f03..f9847a9f2973 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -890,12 +890,23 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(nvmeq->cq_vector < 0)) {
 		ret = BLK_STS_IOERR;
 		spin_unlock_irq(&nvmeq->q_lock);
-		goto out_cleanup_iod;
+		goto out_unmap_iod;
 	}
 	__nvme_submit_cmd(nvmeq, &cmnd);
 	nvme_process_cq(nvmeq);
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_STS_OK;
+
+out_unmap_iod:
+	nvme_unmap_data(dev, req);
+	{
+		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+		iod->nents = 0;
+		iod->sg = NULL;
+		iod->npages = -1;
+	}
+	return ret;
+
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
 out_free_cmd:
--
