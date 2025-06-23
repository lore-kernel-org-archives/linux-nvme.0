Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC7FC7115B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 06:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g2naBwBA3G+O3GEJB/ulr/ONewyhwzZBhqV3XhDjoTY=; b=TaAnUIP7uECM7BQ8ita4y4Ba8F
	bMTh0qr3ndnQNoNbsd+WcuaQTXiDXnWH3zekLVZSjk2RCIB8vyjOZ87gLLIx5fUZw+uPjB098vhwN
	ItXLJxaFpkU6K48xYPskdlZmmZiavoHrc+QNQ6LX377KsjB8koZLGv7GYcaaYa39sDctfOf6h2Jir
	1RfgLj287sKGksFc506YCu5l1NyvQ7AqBvvCBTdMQ85trxranb5rAo2RPY+hCA9OCD+HV0LSozg9C
	t3/ApumsQGyOnuDTFw+yjuk9tezAFq3q+Q09hpvJCL5OwZjmAi4ZNc9LEXLk3D6g70g659Z8lFK+i
	Bbyxr1jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTaxb-00000001mjE-3dCc;
	Mon, 23 Jun 2025 06:47:19 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTarq-00000001lPU-1w16
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 06:41:24 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0Qra0017624;
	Mon, 23 Jun 2025 06:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=g2naBwBA3G+O3GEJB/ulr/ONewyhw
	zZBhqV3XhDjoTY=; b=XOIFv/OSXZ77glngyqj7QGQubb0hZ+gXWOBApkdLJqg12
	/PJQLse8TqwmQAtXI1kvd6CNv3wDYfQXfCSEfWK85vszO+sYSaItlYIJIkUw7PVR
	KMcPRETSMjPJOWkGtrfLXLFG6YD3lfqDyc4JG1Co0KVa0VLpVzB+5Pm/hvE87chZ
	0qdKUhYks7ZMfVPbTocReq9SNRHC2/LXw/n7w7X5YKo5CEq1Pd4EiAKWMhKfB0Ww
	GSlMHQE5jW/+hrCgKQGZBHKsdB8UljX898U9DlsuukD+Fo++SuBONcXK3XWnSIrH
	yJJPDk3OKz8C133hNCFv0gzWVip+nhQWk0jNznd+g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt78ws9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N4eXZV028818;
	Mon, 23 Jun 2025 06:41:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpnfdtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55N6fAjq006422;
	Mon, 23 Jun 2025 06:41:10 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpnfdt5-1;
	Mon, 23 Jun 2025 06:41:10 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, nilay@linux.ibm.com,
        corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] nvme: Fix multiple spelling and grammar issues in host drivers
Date: Sun, 22 Jun 2025 23:40:19 -0700
Message-ID: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230038
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzOCBTYWx0ZWRfX0DifAvF23UYb 8wLORX+ht7cgk1WXgW67B1qAKvLpWZGTzlWN3+vd2Wr375cQo5wcYpEQhk4nR1kW4nrLYDtqWyU IzpzGny/lreQHhrZKKvXJmtkClRO5yPk3/BJtcNAulqHeM5ov2+z4LqH0qnA5wQyItIS0ekG1KH
 a0BO7vymVa1vm1xZK3irXYM5vC9VEBxKzofv1pmBy3fksDZybE0UQB2V1XKyph6pNb25A+8nLl3 mH1wxIXawCZaebG5BF9b1cfyC6jLIkFUNdToB6AMzXwcwlkc+kJ9EozpVdKtFmP++pLSPL+MDOy jQohBcCJnrTtsc6Uv7KpAKrn7clK2UMC9/s1OQydLMdxwl1nzbcJsiquLt5SumdtkrOjLFNMCDP
 ggLfMFV9x72SbF4X9FIoa1Wy9hXMFUAUsgyXAkPQ6T2NMAKHh49/zK7G6x5oSmc5Ta22+dKI
X-Proofpoint-GUID: emh0IzNMSXV0yf8nC13SRzxBZW5xluan
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=6858f708 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=XhBexOnarudRnIWOcXAA:9
X-Proofpoint-ORIG-GUID: emh0IzNMSXV0yf8nC13SRzxBZW5xluan
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_234122_627973_13B4D2B0 
X-CRM114-Status: GOOD (  28.03  )
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


