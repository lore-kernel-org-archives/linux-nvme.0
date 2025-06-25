Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3508C83000
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 04:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emLgMd9NdJMjhl8z4aBxY3ZGdmBDfpCboppn1p+odHQ=; b=wW05cIspgp8CRcVDxI2jjVAWSk
	SAiM+LBu7dZFNAiQPVRgA9427mzmSUx8Zi/oaUb0MVe/7c7aG0RIjwa4x2YoWUgbcEgrmRZnPAIds
	cJYsvzBCM8Zlb4mVuzORKD6JrwePZ41xWsZ6f9hejfQ2aoXj+8cnE2yxJYk1n8gl8Ixkvc8t3Am0n
	q4lRGYlI+Bpoih6xVO1jCKjmQ3fbfO9t6xwPd6szh4DLJ9Qb6k4IcjC+VMIqPiwmozCF1DwfQuXls
	ud73QC63oq6m3kfh+7jP2vnjGYxIe+9dFzzOq47z06uHFdbKgNe54TkzRG8VxCTX22GdiedgOwpRV
	1KKmaQzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUHZl-00000007T1w-2LuL;
	Wed, 25 Jun 2025 04:17:33 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUHZi-00000007T0U-3KXt
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 04:17:31 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OMigaA030672;
	Wed, 25 Jun 2025 04:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=emLgM
	d9NdJMjhl8z4aBxY3ZGdmBDfpCboppn1p+odHQ=; b=sLu2xyNyx6zdFy4KAjzlh
	ETOd+BH31D72lw59vDkqgAQKoKPb+TQ0UOCNFgyaGyxwReqqboPSYXqn0NxgVpzE
	NuKqODgplFj+oTZVLh6Hp2R5UqUUqFR6uettkqqx2IdSrtJ2QxaW3KuoYxgRqH7t
	VOkZqOWiNoNAAQxTmNZm9CeidLOvUBzVlR4byW5T7p2Y6IUVpG8OeFicjvcMB2q5
	utmEBmNMHdfISCiEZAaEb9XfdBR5Q7PI8iYQ6CmJyEniylkFved2gWB3fkFbH22v
	nfuo/Fh4YNSjFWR5cj6Bj9ZE2T0MHh7GRr2OfaHM19qbG9OIziZpeJmWM/oO3npC
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8mxej4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 04:17:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1WKS6024347;
	Wed, 25 Jun 2025 04:17:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkrhffr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 04:17:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55P4HGqa029022;
	Wed, 25 Jun 2025 04:17:17 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehkrhfem-2;
	Wed, 25 Jun 2025 04:17:17 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, rdunlap@infradead.org, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        nilay@linux.ibm.com, corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] nvme: Fix multiple spelling and grammar issues in host drivers
Date: Tue, 24 Jun 2025 21:16:30 -0700
Message-ID: <20250625041643.174110-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250625041643.174110-1-alok.a.tiwari@oracle.com>
References: <20250625041643.174110-1-alok.a.tiwari@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506250029
X-Authority-Analysis: v=2.4 cv=IcWHWXqa c=1 sm=1 tr=0 ts=685b7850 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8 a=XhBexOnarudRnIWOcXAA:9 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf
 awl=host:13207
X-Proofpoint-ORIG-GUID: Wz8z3D6RuFZ3FBn-U2dDtbpmDQ0mPanP
X-Proofpoint-GUID: Wz8z3D6RuFZ3FBn-U2dDtbpmDQ0mPanP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzMCBTYWx0ZWRfX5//C/y83WULC Ws63kyfQJOyPORryhoW6td+0nH0Acqmoegn3XX27gvX9bL0AzRgmneYrpi4BxcqCYbc1yEQPbYD IQyRWGDmGbpqsi2z7GGMLiwtuzoSBfkQyXvEbaaeIyxq5VF8XdOF29q7DhgmLP/9vBjCXM7fp9Z
 +sJ2wtvP91Gg5vI6C1eDVNEM1TSLgxinx7lNqTXxo3gJnEfpstaxdUJW5JM8A1TbM6CfTQO2mvZ H9yap2Q4/ah6S05NzAuo4WVkUW8NDywAXR4UzyxA2ZkXB66hUbN28ncq7sbDQy4mWD5DQnf6Har qTmZU8ehyzTIXuAS8RR1ebBOLPrzOHUreQz/PEJTWq2sqGMR717FQnlquvwMu1rrQ4qMfW7XAE3
 EgbEQLrh6rHomDhuYGbFpMLELu/lhFSNpI8ljonmCToA96OMklQJXj8C9tYXozmi+/lPQ01+
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_211730_829387_33CB0532 
X-CRM114-Status: GOOD (  29.41  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This commit fixes several typos and grammatical issues across
various nvme host driver files:
- Corrected "glace" to "glance" in a comment in apple.c
- Fixed "Idependent" to "Independent" in core.c
- Changed "unsucceesful" to "unsuccessful", "they blk-mq" to "the
blk-mq", Fixed "terminaed" to "terminated" and other grammar in fc.c
- Updated "O's" to "0's" to clarify meaning in nvme.h
- function name comment *_transter_len() -> *_transfer_len() in zns.c

Fixed sysfs_emit() output format in pci.c (replaced x%08x with 0x%08x)

These changes improve the code readability and documentation
consistency across the NVMe driver.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
v2
no changes only added Reviewed-by
---
 drivers/nvme/host/apple.c      |  4 ++--
 drivers/nvme/host/core.c       |  2 +-
 drivers/nvme/host/fc.c         | 10 +++++-----
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/host/pci.c        |  2 +-
 drivers/nvme/host/rdma.c       |  2 +-
 drivers/nvme/target/passthru.c |  4 ++--
 drivers/nvme/target/zns.c      |  2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b1fddfa33ab97..1286c31320e63 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -301,8 +301,8 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
 	memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
 
 	/*
-	 * This lock here doesn't make much sense at a first glace but
-	 * removing it will result in occasional missed completetion
+	 * This lock here doesn't make much sense at a first glance but
+	 * removing it will result in occasional missed completion
 	 * interrupts even though the commands still appear on the CQ.
 	 * It's unclear why this happens but our best guess is that
 	 * there is a bug in the firmware triggered when a new command
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601d..ffefa781a3de3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4289,7 +4289,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 
 	/*
-	 * If available try to use the Command Set Idependent Identify Namespace
+	 * If available try to use the Command Set Independent Identify Namespace
 	 * data structure to find all the generic information that is needed to
 	 * set up a namespace.  If not fall back to the legacy version.
 	 */
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 014b387f1e8b1..08a5ea3e93836 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -899,7 +899,7 @@ EXPORT_SYMBOL_GPL(nvme_fc_set_remoteport_devloss);
  * may crash.
  *
  * As such:
- * Wrapper all the dma routines and check the dev pointer.
+ * Wrap all the dma routines and check the dev pointer.
  *
  * If simple mappings (return just a dma address, we'll noop them,
  * returning a dma address of 0.
@@ -1955,8 +1955,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	}
 
 	/*
-	 * For the linux implementation, if we have an unsucceesful
-	 * status, they blk-mq layer can typically be called with the
+	 * For the linux implementation, if we have an unsuccessful
+	 * status, the blk-mq layer can typically be called with the
 	 * non-zero status and the content of the cqe isn't important.
 	 */
 	if (status)
@@ -2429,7 +2429,7 @@ static bool nvme_fc_terminate_exchange(struct request *req, void *data)
 
 /*
  * This routine runs through all outstanding commands on the association
- * and aborts them.  This routine is typically be called by the
+ * and aborts them.  This routine is typically called by the
  * delete_association routine. It is also called due to an error during
  * reconnect. In that scenario, it is most likely a command that initializes
  * the controller, including fabric Connect commands on io queues, that
@@ -2622,7 +2622,7 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
  * as part of the exchange.  The CQE is the last thing for the io,
  * which is transferred (explicitly or implicitly) with the RSP IU
  * sent on the exchange. After the CQE is received, the FC exchange is
- * terminaed and the Exchange may be used on a different io.
+ * terminated and the Exchange may be used on a different io.
  *
  * The transport to LLDD api has the transport making a request for a
  * new fcp io request to the LLDD. The LLDD then allocates a FC exchange
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a468cdc5b5cb7..97818eb1a4143 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -69,7 +69,7 @@ enum nvme_quirks {
 	NVME_QUIRK_IDENTIFY_CNS			= (1 << 1),
 
 	/*
-	 * The controller deterministically returns O's on reads to
+	 * The controller deterministically returns 0's on reads to
 	 * logical blocks that deallocate was called on.
 	 */
 	NVME_QUIRK_DEALLOCATE_ZEROES		= (1 << 2),
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5d..982abf0514c9d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2333,7 +2333,7 @@ static ssize_t cmb_show(struct device *dev, struct device_attribute *attr,
 {
 	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
 
-	return sysfs_emit(buf, "cmbloc : x%08x\ncmbsz  : x%08x\n",
+	return sysfs_emit(buf, "cmbloc : 0x%08x\ncmbsz  : 0x%08x\n",
 		       ndev->cmbloc, ndev->cmbsz);
 }
 static DEVICE_ATTR_RO(cmb);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9bd3646568d03..190a4cfa8a5ee 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -877,7 +877,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	/*
 	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
+	 * and limited it to the available queues. On reconnects, the
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b7515c53829b8..3b4b0df8f8799 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -106,7 +106,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 				      pctrl->max_hw_sectors);
 
 	/*
-	 * nvmet_passthru_map_sg is limitted to using a single bio so limit
+	 * nvmet_passthru_map_sg is limited to using a single bio so limit
 	 * the mdts based on BIO_MAX_VECS as well
 	 */
 	max_hw_sectors = min_not_zero(BIO_MAX_VECS << PAGE_SECTORS_SHIFT,
@@ -147,7 +147,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 	 * When passthru controller is setup using nvme-loop transport it will
 	 * export the passthru ctrl subsysnqn (PCIe NVMe ctrl) and will fail in
 	 * the nvme/host/core.c in the nvme_init_subsystem()->nvme_active_ctrl()
-	 * code path with duplicate ctr subsynqn. In order to prevent that we
+	 * code path with duplicate ctrl subsysnqn. In order to prevent that we
 	 * mask the passthru-ctrl subsysnqn with the target ctrl subsysnqn.
 	 */
 	memcpy(id->subnqn, ctrl->subsysnqn, sizeof(id->subnqn));
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 29a60fabfcc8a..15a579cf528c1 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -541,7 +541,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	struct bio *bio;
 	int sg_cnt;
 
-	/* Request is completed on len mismatch in nvmet_check_transter_len() */
+	/* Request is completed on len mismatch in nvmet_check_transfer_len() */
 	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
 		return;
 
-- 
2.46.0


