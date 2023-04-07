Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2516AC76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 20:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9pmVPD6b3P7+1yxXPt0GWm3eG9nQG6vdgffOi8t1hbk=; b=o/2mlsEaDlmQ0wf6LTxTRhw3R8
	gzIxtaS2kC5XJxLd5MxEaVnTStUWnmV3a0Zvfibnm6okXMvu9GxMzRVLwLBbAEdcuvVKJrN3uHHxs
	4Vts7zd8NPNaF1sjOYDmL0xSMCLPVfpVRnM/HScH0shwm1FW4xqs6QlVxGw3DzuIKNVzGLsoA7Us3
	8HVp2fU2mpPJYwyVEZpYhyYxJWiq3vDg3YLtKlcY16ciyUmXFnsmwtaLaJb3ZJ+kEWZVxyXCqSLrt
	oXmtWcbLtX2dqm/eJlQZeYt5SPgjPs+O3lnUEtgLSLUi2I4ridEjGw5vptMavoc3ZcDv8tr6aCzTZ
	AOAIrujw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLv-00B2jm-2m;
	Fri, 07 Apr 2023 20:06:31 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLs-00B2ff-18
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 20:06:29 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337Fx2D5018342;
	Fri, 7 Apr 2023 20:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=9pmVPD6b3P7+1yxXPt0GWm3eG9nQG6vdgffOi8t1hbk=;
 b=LFCm08eEVZzeEComXaCAQKvmATGWaE6c9BmgeRjhSU4v0O1s3w8EGjsZJ/oArLkusBF9
 F9P6Ql3cul3XyB9xxfsOaOuzzxAA7EUyxC+2qSqVbwamebh0YNtnAWFSLDRCwz4n/9SD
 6yK9vKNcOtsFr9OjHKrTX8Fy9ASQC5g+6oDf1laflZasUv2+Z6d4B4o2oaAK6qSyUzX6
 5fpn9IrvX7hqFJMux+ZwBHLfzzNdb9vsgSIDDJWYDlHpN491ZB3wJfvEozx9DqXy9t9t
 5iOCHC7xzbK+spTX8tiVfNNssEF4h9UCNkOBnquZJP7h4jVVgYy0TI+4OLm7BhJ7N0I2 zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1dws08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:06:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 337J0SXs034263;
	Fri, 7 Apr 2023 20:06:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjxeey5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:06:22 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337K5trC010228;
	Fri, 7 Apr 2023 20:06:21 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-128-1.vpn.oracle.com [10.154.128.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjxeeam-11;
	Fri, 07 Apr 2023 20:06:21 +0000
From: Mike Christie <michael.christie@oracle.com>
To: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v6 10/18] nvme: Add helper to send pr command
Date: Fri,  7 Apr 2023 15:05:43 -0500
Message-Id: <20230407200551.12660-11-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407200551.12660-1-michael.christie@oracle.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070180
X-Proofpoint-GUID: dQ6TViI8gL_Ro_6O9DMW_rTxKHmTPDpB
X-Proofpoint-ORIG-GUID: dQ6TViI8gL_Ro_6O9DMW_rTxKHmTPDpB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_130628_504747_E6820E5B 
X-CRM114-Status: GOOD (  18.90  )
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

Move the code that checks for multipath support and sends the pr command
to a new helper so it can be used by the reservation report support added
in the next patches.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pr.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca7a8d531a23..cd93d2e5b340 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -30,7 +30,7 @@ static char nvme_pr_type(enum pr_type type)
 }
 
 static int nvme_send_ns_head_pr_command(struct block_device *bdev,
-		struct nvme_command *c, u8 *data, unsigned int data_len)
+		struct nvme_command *c, void *data, unsigned int data_len)
 {
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
 	int srcu_idx = srcu_read_lock(&head->srcu);
@@ -46,7 +46,7 @@ static int nvme_send_ns_head_pr_command(struct block_device *bdev,
 }
 
 static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
-		u8 *data, unsigned int data_len)
+		void *data, unsigned int data_len)
 {
 	c->common.nsid = cpu_to_le32(ns->head->ns_id);
 	return nvme_submit_sync_cmd(ns->queue, c, data, data_len);
@@ -74,6 +74,17 @@ static int nvme_sc_to_pr_err(int nvme_sc)
 	}
 }
 
+static int nvme_send_pr_command(struct block_device *bdev,
+		struct nvme_command *c, void *data, unsigned int data_len)
+{
+	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
+	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+		return nvme_send_ns_head_pr_command(bdev, c, data, data_len);
+
+	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, c, data,
+				       data_len);
+}
+
 static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 				u64 key, u64 sa_key, u8 op)
 {
@@ -87,13 +98,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	c.common.opcode = op;
 	c.common.cdw10 = cpu_to_le32(cdw10);
 
-	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
-	    bdev->bd_disk->fops == &nvme_ns_head_ops)
-		ret = nvme_send_ns_head_pr_command(bdev, &c, data,
-						   sizeof(data));
-	else
-		ret = nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c,
-					      data, sizeof(data));
+	ret = nvme_send_pr_command(bdev, &c, data, sizeof(data));
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1


