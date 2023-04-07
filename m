Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6883C77B76
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 20:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SoHgckSU+VRtf3mtNubY6coxbJ+ZvUl9HiRVcET5038=; b=sHRXJyGFqsMhOmSZocyVJFH6hZ
	kDySbJjxE6xnRQDc/dAqh4iLJRiyZ+ARZ954MMK2WoI32dzwxlZLif6MGJYyEiHQr1xXDLpAdL/hF
	UqU431DgY/667Re2izZ9zI2NKA+EPH/MgpWRkyUhduu3RR4wzxGl81uLEL9oXvY+d5fL8qke94mdk
	q84S12fPWMAfjdN2r0HtHoDp6pLY0wqOm7+o8LH5en4s8Eu61suZirWJiuJ7NtKWf+pt1N8N5BR3l
	HCCzo/nns1Mj9wF6V9pBYjM64amtizy7IgHzPUOql91LxfM4DRzYLJm/PGjND8DeCdDcjFUzPrKUw
	NJpiYupA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLj-00B2Ys-23;
	Fri, 07 Apr 2023 20:06:19 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLg-00B2WS-04
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 20:06:17 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337Fx7uC014253;
	Fri, 7 Apr 2023 20:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=SoHgckSU+VRtf3mtNubY6coxbJ+ZvUl9HiRVcET5038=;
 b=1IfHl/D2t9szdxHJgpA+DsSyHYOEJBqKg3KZWaTL3fcZpA+dsVlOb1vfjD+/doRkjVos
 SbC546S3c8RWpCfAUJNGP8P8neooCmKu/BbA8pyu7b820a2EQ/jCbkG74FeqRHnDqwfP
 fP3TPc2QGKc15ygw7J0iLqRWstXMxuCLHNQgzOB+PmSXi6E4bVDRkx3sMappmqx103qC
 /q/7DHmYiurvpRRLHCT8uXK4S3hsGCpr60FR3zMMF1CqvA72Mx/1XytSAV3y00mPVged
 oPubYWhthW7viKRasZqOfM5lhb1UQLf5F434MzE2SgF/zV3zg0zxkuKifYEsk+hOB8mQ Ng== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppc7u5srq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:06:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 337ISUdN034259;
	Fri, 7 Apr 2023 20:06:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjxeenj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:06:09 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337K5tr2010228;
	Fri, 7 Apr 2023 20:06:08 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-128-1.vpn.oracle.com [10.154.128.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjxeeam-6;
	Fri, 07 Apr 2023 20:06:08 +0000
From: Mike Christie <michael.christie@oracle.com>
To: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v6 05/18] scsi: Add support for block PR read keys/reservation
Date: Fri,  7 Apr 2023 15:05:38 -0500
Message-Id: <20230407200551.12660-6-michael.christie@oracle.com>
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
X-Proofpoint-ORIG-GUID: ri7kDocNDKU7eQt4cxh08s2gaNx6SSJU
X-Proofpoint-GUID: ri7kDocNDKU7eQt4cxh08s2gaNx6SSJU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_130616_178414_70E0B6BB 
X-CRM114-Status: GOOD (  25.54  )
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

This adds support in sd.c for the block PR read keys and read reservation
callouts, so upper layers like LIO can get the PR info that's been setup
using the existing pr callouts and return it to initiators.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_common.c | 21 +++++++++
 drivers/scsi/sd.c          | 91 ++++++++++++++++++++++++++++++++++++++
 include/scsi/scsi_common.h |  1 +
 include/scsi/scsi_proto.h  |  5 +++
 4 files changed, 118 insertions(+)

diff --git a/drivers/scsi/scsi_common.c b/drivers/scsi/scsi_common.c
index 11bf6c275d4e..b7a7a2eea887 100644
--- a/drivers/scsi/scsi_common.c
+++ b/drivers/scsi/scsi_common.c
@@ -64,6 +64,27 @@ const char *scsi_device_type(unsigned type)
 }
 EXPORT_SYMBOL(scsi_device_type);
 
+enum pr_type scsi_pr_type_to_block(enum scsi_pr_type type)
+{
+	switch (type) {
+	case SCSI_PR_WRITE_EXCLUSIVE:
+		return PR_WRITE_EXCLUSIVE;
+	case SCSI_PR_EXCLUSIVE_ACCESS:
+		return PR_EXCLUSIVE_ACCESS;
+	case SCSI_PR_WRITE_EXCLUSIVE_REG_ONLY:
+		return PR_WRITE_EXCLUSIVE_REG_ONLY;
+	case SCSI_PR_EXCLUSIVE_ACCESS_REG_ONLY:
+		return PR_EXCLUSIVE_ACCESS_REG_ONLY;
+	case SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS:
+		return PR_WRITE_EXCLUSIVE_ALL_REGS;
+	case SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+		return PR_EXCLUSIVE_ACCESS_ALL_REGS;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scsi_pr_type_to_block);
+
 enum scsi_pr_type block_pr_type_to_scsi(enum pr_type type)
 {
 	switch (type) {
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 256c582571fd..95fa0a486572 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1723,6 +1723,95 @@ static int sd_scsi_to_pr_err(struct scsi_sense_hdr *sshdr, int result)
 	}
 }
 
+static int sd_pr_in_command(struct block_device *bdev, u8 sa,
+			    unsigned char *data, int data_len)
+{
+	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
+	struct scsi_device *sdev = sdkp->device;
+	struct scsi_sense_hdr sshdr;
+	u8 cmd[10] = { PERSISTENT_RESERVE_IN, sa };
+	const struct scsi_exec_args exec_args = {
+		.sshdr = &sshdr,
+	};
+	int result;
+
+	put_unaligned_be16(data_len, &cmd[7]);
+
+	result = scsi_execute_cmd(sdev, cmd, REQ_OP_DRV_IN, data, data_len,
+				  SD_TIMEOUT, sdkp->max_retries, &exec_args);
+	if (scsi_status_is_check_condition(result) &&
+	    scsi_sense_valid(&sshdr)) {
+		sdev_printk(KERN_INFO, sdev, "PR command failed: %d\n", result);
+		scsi_print_sense_hdr(sdev, NULL, &sshdr);
+	}
+
+	if (result <= 0)
+		return result;
+
+	return sd_scsi_to_pr_err(&sshdr, result);
+}
+
+static int sd_pr_read_keys(struct block_device *bdev, struct pr_keys *keys_info)
+{
+	int result, i, data_offset, num_copy_keys;
+	u32 num_keys = keys_info->num_keys;
+	int data_len = num_keys * 8 + 8;
+	u8 *data;
+
+	data = kzalloc(data_len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	result = sd_pr_in_command(bdev, READ_KEYS, data, data_len);
+	if (result)
+		goto free_data;
+
+	keys_info->generation = get_unaligned_be32(&data[0]);
+	keys_info->num_keys = get_unaligned_be32(&data[4]) / 8;
+
+	data_offset = 8;
+	num_copy_keys = min(num_keys, keys_info->num_keys);
+
+	for (i = 0; i < num_copy_keys; i++) {
+		keys_info->keys[i] = get_unaligned_be64(&data[data_offset]);
+		data_offset += 8;
+	}
+
+free_data:
+	kfree(data);
+	return result;
+}
+
+static int sd_pr_read_reservation(struct block_device *bdev,
+				  struct pr_held_reservation *rsv)
+{
+	struct scsi_disk *sdkp = scsi_disk(bdev->bd_disk);
+	struct scsi_device *sdev = sdkp->device;
+	u8 data[24] = { };
+	int result, len;
+
+	result = sd_pr_in_command(bdev, READ_RESERVATION, data, sizeof(data));
+	if (result)
+		return result;
+
+	len = get_unaligned_be32(&data[4]);
+	if (!len)
+		return 0;
+
+	/* Make sure we have at least the key and type */
+	if (len < 14) {
+		sdev_printk(KERN_INFO, sdev,
+			    "READ RESERVATION failed due to short return buffer of %d bytes\n",
+			    len);
+		return -EINVAL;
+	}
+
+	rsv->generation = get_unaligned_be32(&data[0]);
+	rsv->key = get_unaligned_be64(&data[8]);
+	rsv->type = scsi_pr_type_to_block(data[21] & 0x0f);
+	return 0;
+}
+
 static int sd_pr_out_command(struct block_device *bdev, u8 sa, u64 key,
 			     u64 sa_key, enum scsi_pr_type type, u8 flags)
 {
@@ -1804,6 +1893,8 @@ static const struct pr_ops sd_pr_ops = {
 	.pr_release	= sd_pr_release,
 	.pr_preempt	= sd_pr_preempt,
 	.pr_clear	= sd_pr_clear,
+	.pr_read_keys	= sd_pr_read_keys,
+	.pr_read_reservation = sd_pr_read_reservation,
 };
 
 static void scsi_disk_free_disk(struct gendisk *disk)
diff --git a/include/scsi/scsi_common.h b/include/scsi/scsi_common.h
index e25291bbbe9b..fb58715fac86 100644
--- a/include/scsi/scsi_common.h
+++ b/include/scsi/scsi_common.h
@@ -20,6 +20,7 @@ enum scsi_pr_type {
 };
 
 enum scsi_pr_type block_pr_type_to_scsi(enum pr_type type);
+enum pr_type scsi_pr_type_to_block(enum scsi_pr_type type);
 
 static inline unsigned
 scsi_varlen_cdb_length(const void *hdr)
diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index fbe5bdfe4d6e..07d65c1f59db 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -151,6 +151,11 @@
 #define ZO_FINISH_ZONE	      0x02
 #define ZO_OPEN_ZONE	      0x03
 #define ZO_RESET_WRITE_POINTER 0x04
+/* values for PR in service action */
+#define READ_KEYS             0x00
+#define READ_RESERVATION      0x01
+#define REPORT_CAPABILITES    0x02
+#define READ_FULL_STATUS      0x03
 /* values for variable length command */
 #define XDREAD_32	      0x03
 #define XDWRITE_32	      0x04
-- 
2.25.1


