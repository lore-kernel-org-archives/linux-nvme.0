Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474EDC3ABC9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 22:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NBZ+TEM0nF97W+LVkFvnIJvD2IRXUffBLbeQZyBP+0Y=; b=jA93B1Wu19YBDDYWynppGUkB/y
	GjZJ/Iryui2wOdK5JaQm/uD6hxhqQAxeX542fVN2u+A+cG2smugGDSx8BirUb8zm3+ENLJhdPD046
	cVC04/gV1MJm76TMudvzoujnbSBkFd/17OxkL6lDGDDFC/PiI7SWIB2X+9ibYJLKXmTzrtL7vZCZT
	647q0mQd5mDbvCYhjr27wKOL4PdZuZMhXPoPbTSkfHMdpwildAqDFsRIVtn/krXOE42gsWP2pxF/1
	8WQmoBAZmNMqxzQm9STmIcwZPZWXYvS2cPT1WLAyj4iqqJvLwk0/lAlt2dI9fQgz0iBTNg3A4NyIl
	liXJzlkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD9j5-00000001txG-1l8z;
	Thu, 08 May 2025 22:28:23 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD9j1-00000001twL-3VrM
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 22:28:21 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548LlD9p015791;
	Thu, 8 May 2025 22:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=NBZ+T
	EM0nF97W+LVkFvnIJvD2IRXUffBLbeQZyBP+0Y=; b=b+yjgtcjh003mjx88IKTr
	Rk2soYjEJYj4KOOjHNXykNXAbZ+O4VaHTC18UDnuoPuucIzcRL6km49vDPpruWwF
	3oQPt45ffvNKm+BkY+bWiy7tfr7cxOfbbUAEuOP0+OqcqxMCH+u2aDFRVAZIaIEV
	73NZs28xZ2oMS3oiIOv2yNPmHoS6ivzhVynw3eKtyJQ+LcchCVtngSDIjBU+TMZd
	a5ApGr1wI3t4oy+6jMLYrVc0Z6mZbDZW1ykl8XdPsl2iaQbzBoiqTe5kOjcHSR5i
	cMoHXg+CxGgocNejopnNvXBrf2vPAN/g3mYkmxNOoojOdXvVf80UcsosaHqZ5K1U
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46h4tyg237-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 22:28:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548Lw9Mm002618;
	Thu, 8 May 2025 22:28:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46gmccakt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 22:28:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 548MS5hZ030993;
	Thu, 8 May 2025 22:28:07 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46gmccaks4-3;
	Thu, 08 May 2025 22:28:07 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kch@nvidia.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Subject: [PATCH v3 2/2] nvme: all namespaces in a subsystem must adhere to a common atomic write size
Date: Thu,  8 May 2025 15:38:01 -0700
Message-ID: <20250508223802.277311-3-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250508223802.277311-1-alan.adamson@oracle.com>
References: <20250508223802.277311-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505080203
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNCBTYWx0ZWRfX5wttB8vorxnS eludr8G2uZhUtNH58+6BE22sQifC2hnHMRtpG7X7w/K2xBfQDoFe7jY0Qjjf93DsVI3cGrx7/Xa syDioB61IkxP9gSqWQWqLHpOIp0kGri3BrCa9aeAMY49LM4y8/VueTpPPDYIDRYSvRNJXtWtEtd
 4MdZzPU2kFJVRSOQHQeeYOxvMwBkVal2hexr4AyV/rJrQ5ptvMgGdjBoSDuOjIuoh/3B94zIJm+ qW6lw7X1IOrUaKasRrx/SQrqE/Vytlc81CagjQuCFOo1tvky5hn9fqWV+/3LkJxdqabqDbK0u3c UnyEQtzRWmMZxv1Y6lf+u/AOoGjd137vrD/PNQP+chv5n68Do5WcFMnmq1grnIs8nOF4qwkJsXM
 qkbImIjG/CfmjoI2Abyg4WHziAgJUx8gYpl8Ch3fM312LVl7i2GL6tdAq0FTKjr7Ug0ba3lI
X-Proofpoint-ORIG-GUID: cj9-48L8byKixcu6s8Mo9yN5lE_oktDN
X-Proofpoint-GUID: cj9-48L8byKixcu6s8Mo9yN5lE_oktDN
X-Authority-Analysis: v=2.4 cv=aJnwqa9m c=1 sm=1 tr=0 ts=681d2ff8 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=AxTn6yeNWgif7ez6_GcA:9 cc=ntf awl=host:13186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_152819_990692_938F8865 
X-CRM114-Status: GOOD (  16.29  )
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

The first namespace configured in a subsystem sets the subsystem's
atomic write size based on its AWUPF or NAWUPF. Subsequent namespaces
must have an atomic write size (per their AWUPF or NAWUPF) less than or
equal to the subsystem's atomic write size, or their probing will be
rejected.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/core.c | 29 ++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  3 ++-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cc..f34cf69fab8d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2059,7 +2059,20 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
-			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+			atomic_bs = (1 + ns->ctrl->awupf) * bs;
+
+		/*
+		 * Set subsystem atomic bs.
+		 */
+		if (ns->ctrl->subsys->atomic_bs) {
+			if (atomic_bs > ns->ctrl->subsys->atomic_bs) {
+				pr_err_ratelimited("%s: Inconsistent Atomic Write Size, Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
+					ns->disk ? ns->disk->disk_name : "?",
+					ns->ctrl->subsys->atomic_bs,
+					atomic_bs);
+			}
+		} else
+			ns->ctrl->subsys->atomic_bs = atomic_bs;
 
 		nvme_update_atomic_write_disk_info(ns, id, lim, bs, atomic_bs);
 	}
@@ -2201,6 +2214,17 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	nvme_set_chunk_sectors(ns, id, &lim);
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
+
+	/*
+	 * Validate the max atomic write size fits within the subsystem's
+	 * atomic write capabilities.
+	 */
+	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
+		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
+		ret = -ENXIO;
+		goto out;
+	}
+
 	nvme_config_discard(ns, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
@@ -3031,7 +3055,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		kfree(subsys);
 		return -EINVAL;
 	}
-	subsys->awupf = le16_to_cpu(id->awupf);
 	nvme_mpath_default_iopolicy(subsys);
 
 	subsys->dev.class = &nvme_subsys_class;
@@ -3441,7 +3464,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
-
+	ctrl->awupf = le16_to_cpu(id->awupf);
 out_free:
 	kfree(id);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..ff1d94468613 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,6 +410,7 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
+	u16 awupf;
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -442,11 +443,11 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
-	u16			awupf;	/* 0's based awupf value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
 #endif
+	u32			atomic_bs;
 };
 
 /*
-- 
2.43.5


