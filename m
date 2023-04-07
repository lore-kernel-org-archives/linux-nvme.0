Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886EAC76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jqyMXML+H40wHoEoi1XBTZ7vCB2WLL5i5Oy0Tx0j6vk=; b=xISQDZyyx5sMwzxj4GD/G3yTbf
	tmbCv7+tPbA+qgIgAmEytCKaStJKvRWMStwrxreEUrBSigS8AWARXfUdlRMxivh7TCRzbcAptXWS9
	JAXvgexixZfgGVbo0+uDfzTQnnihF2IGX6PRoKFf/QuJkg4zsvlVLIKRLMeqgmuoi5Ai8mvbaKeZu
	xtE+fC7az5Ne5amEtD/Uqq3QfeTGgCFiVC5o48O2R6ELbH+dtb+74pGSYrhxEEaFJIHF5WBcr5IeI
	zUC2ULBCKZA1E6jPuIdI7cE4PvvPTSZ670SOsCKaeV+cS43PRQgIeWLUg94dh8ldpWhXRNLzb+KOg
	0jEVtxKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pksxd-00B7kb-21;
	Fri, 07 Apr 2023 20:45:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pksxa-00B7kR-2U
	for linux-nvme@bombadil.infradead.org;
	Fri, 07 Apr 2023 20:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jqyMXML+H40wHoEoi1XBTZ7vCB2WLL5i5Oy0Tx0j6vk=; b=TGPO8IXFfbqNnlno8pdKCTr/o5
	3oSw8Mo1naRMD/1L0mGPdzsBJLXOi8bMfyXIvaiXtXJk99CuzHr12Jh5QRwoQN/GIscUbISpN9WGY
	CyKMQh8coV6DG45bIA8mVXVfwG3NsIbqkNmuVhjLPPVK8kMpjy//APN8DIJxnDqYx34XmYf8nm7up
	A3Zqa7VP7hDZmiAA++NBGL806OwVHfUQ7+IpFiKD8l+ZIrrLySIcvdm/6YTAgBLtYffHQcUdCIarS
	MJwTZ/7CJpMoeajEv5xV2w39gV22iXpn7OrlmI2enJFcd7BCzkf6z83r3i3YUEnp27TyXWC5jSJk7
	Ag6ezeoQ==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pksMN-00BAJp-2E
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 20:07:05 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337FwoS4017340;
	Fri, 7 Apr 2023 20:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=jqyMXML+H40wHoEoi1XBTZ7vCB2WLL5i5Oy0Tx0j6vk=;
 b=Xl9VSAV7jwEEmu/4VOBy3hg1turDi//t6GYqe8x5Hwai8fsqN0QX47dzgA8sh7VLhs9L
 Ew7RSUezyilMXyXJ/8WvNxxH+IJ1lS/BaLyzrr7nEFNSFV1qP3Y5NOOLLYAbWxLSgWHM
 YLbW7uhOsjcBAHrSw5VYp9Ip1RWhsLRi6DnWanyNMkOg2A1PPhmiAvb4A7zuymDlqfcz
 HsoIesEpC2lKXqez0mOCq3A3QOxREYUHHl62vheP6CE9CzEbDopFrda+xEd7zwU6YadJ
 yst8K/37RuAQYfvH20x/SBsglpfP6xYbYCbGeNHI8n1wewMHPtM7I7UhIuaIrv9LcAZG HA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd5wvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:06:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 337IB9al034233;
	Fri, 7 Apr 2023 20:06:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjxefcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:06:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337K5trQ010228;
	Fri, 7 Apr 2023 20:06:40 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-128-1.vpn.oracle.com [10.154.128.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjxeeam-18;
	Fri, 07 Apr 2023 20:06:39 +0000
From: Mike Christie <michael.christie@oracle.com>
To: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v6 17/18] scsi: target: Report and detect unsupported PR commands
Date: Fri,  7 Apr 2023 15:05:50 -0500
Message-Id: <20230407200551.12660-18-michael.christie@oracle.com>
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
X-Proofpoint-GUID: ksHyArDU4589RKAh5bIWhD07mahRXkYW
X-Proofpoint-ORIG-GUID: ksHyArDU4589RKAh5bIWhD07mahRXkYW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_210702_414998_D116B82D 
X-CRM114-Status: GOOD (  21.30  )
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

The backend modules don't know about ports and I_T nexuses and the pr_ops
callouts the modules will use don't support the old RESERVE/RELEASE
commands. This patch has us report we don't support those types of
commands and fail them.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/target/target_core_pr.c  | 17 ++++++++
 drivers/target/target_core_spc.c | 75 +++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index e16ef7d676af..7a3f07979a02 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -3554,6 +3554,18 @@ target_try_pr_out_pt(struct se_cmd *cmd, u8 sa, u64 res_key, u64 sa_res_key,
 		return TCM_UNSUPPORTED_SCSI_OPCODE;
 	}
 
+	switch (sa) {
+	case PRO_REGISTER_AND_MOVE:
+	case PRO_REPLACE_LOST_RESERVATION:
+		pr_err("SPC-3 PR: PRO_REGISTER_AND_MOVE and PRO_REPLACE_LOST_RESERVATION are not supported by PR passthrough.\n");
+		return TCM_UNSUPPORTED_SCSI_OPCODE;
+	}
+
+	if (spec_i_pt || all_tg_pt) {
+		pr_err("SPC-3 PR: SPEC_I_PT and ALL_TG_PT are not supported by PR passthrough.\n");
+		return TCM_UNSUPPORTED_SCSI_OPCODE;
+	}
+
 	return ops->execute_pr_out(cmd, sa, res_key, sa_res_key, type, aptpl);
 }
 
@@ -4082,6 +4094,11 @@ static sense_reason_t target_try_pr_in_pt(struct se_cmd *cmd, u8 sa)
 		return TCM_UNSUPPORTED_SCSI_OPCODE;
 	}
 
+	if (sa == PRI_READ_FULL_STATUS) {
+		pr_err("SPC-3 PR: PRI_READ_FULL_STATUS is not supported by PR passthrough.\n");
+		return TCM_UNSUPPORTED_SCSI_OPCODE;
+	}
+
 	buf = transport_kmap_data_sg(cmd);
 	if (!buf)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index caf8d1325007..053bd2eea0e6 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -1672,7 +1672,41 @@ static bool tcm_is_pr_enabled(struct target_opcode_descriptor *descr,
 {
 	struct se_device *dev = cmd->se_dev;
 
-	return dev->dev_attrib.emulate_pr;
+	if (!dev->dev_attrib.emulate_pr)
+		return false;
+
+	if (!(dev->transport_flags & TRANSPORT_FLAG_PASSTHROUGH_PGR))
+		return true;
+
+	switch (descr->opcode) {
+	case RESERVE:
+	case RESERVE_10:
+	case RELEASE:
+	case RELEASE_10:
+		/*
+		 * The pr_ops which are used by the backend modules don't
+		 * support these commands.
+		 */
+		return false;
+	case PERSISTENT_RESERVE_OUT:
+		switch (descr->service_action) {
+		case PRO_REGISTER_AND_MOVE:
+		case PRO_REPLACE_LOST_RESERVATION:
+			/*
+			 * The backend modules don't have access to ports and
+			 * I_T nexuses so they can't handle these type of
+			 * requests.
+			 */
+			return false;
+		}
+		break;
+	case PERSISTENT_RESERVE_IN:
+		if (descr->service_action == PRI_READ_FULL_STATUS)
+			return false;
+		break;
+	}
+
+	return true;
 }
 
 static struct target_opcode_descriptor tcm_opcode_pri_read_caps = {
@@ -1797,22 +1831,13 @@ static struct target_opcode_descriptor tcm_opcode_pro_register_move = {
 	.enabled = tcm_is_pr_enabled,
 };
 
-static bool
-tcm_is_scsi2_reservations_enabled(struct target_opcode_descriptor *descr,
-				  struct se_cmd *cmd)
-{
-	struct se_device *dev = cmd->se_dev;
-
-	return dev->dev_attrib.emulate_pr;
-}
-
 static struct target_opcode_descriptor tcm_opcode_release = {
 	.support = SCSI_SUPPORT_FULL,
 	.opcode = RELEASE,
 	.cdb_size = 6,
 	.usage_bits = {RELEASE, 0x00, 0x00, 0x00,
 		       0x00, SCSI_CONTROL_MASK},
-	.enabled = tcm_is_scsi2_reservations_enabled,
+	.enabled = tcm_is_pr_enabled,
 };
 
 static struct target_opcode_descriptor tcm_opcode_release10 = {
@@ -1822,7 +1847,7 @@ static struct target_opcode_descriptor tcm_opcode_release10 = {
 	.usage_bits = {RELEASE_10, 0x00, 0x00, 0x00,
 		       0x00, 0x00, 0x00, 0xff,
 		       0xff, SCSI_CONTROL_MASK},
-	.enabled = tcm_is_scsi2_reservations_enabled,
+	.enabled = tcm_is_pr_enabled,
 };
 
 static struct target_opcode_descriptor tcm_opcode_reserve = {
@@ -1831,7 +1856,7 @@ static struct target_opcode_descriptor tcm_opcode_reserve = {
 	.cdb_size = 6,
 	.usage_bits = {RESERVE, 0x00, 0x00, 0x00,
 		       0x00, SCSI_CONTROL_MASK},
-	.enabled = tcm_is_scsi2_reservations_enabled,
+	.enabled = tcm_is_pr_enabled,
 };
 
 static struct target_opcode_descriptor tcm_opcode_reserve10 = {
@@ -1841,7 +1866,7 @@ static struct target_opcode_descriptor tcm_opcode_reserve10 = {
 	.usage_bits = {RESERVE_10, 0x00, 0x00, 0x00,
 		       0x00, 0x00, 0x00, 0xff,
 		       0xff, SCSI_CONTROL_MASK},
-	.enabled = tcm_is_scsi2_reservations_enabled,
+	.enabled = tcm_is_pr_enabled,
 };
 
 static struct target_opcode_descriptor tcm_opcode_request_sense = {
@@ -2246,12 +2271,22 @@ spc_parse_cdb(struct se_cmd *cmd, unsigned int *size)
 	struct se_device *dev = cmd->se_dev;
 	unsigned char *cdb = cmd->t_task_cdb;
 
-	if (!dev->dev_attrib.emulate_pr &&
-	    ((cdb[0] == PERSISTENT_RESERVE_IN) ||
-	     (cdb[0] == PERSISTENT_RESERVE_OUT) ||
-	     (cdb[0] == RELEASE || cdb[0] == RELEASE_10) ||
-	     (cdb[0] == RESERVE || cdb[0] == RESERVE_10))) {
-		return TCM_UNSUPPORTED_SCSI_OPCODE;
+	switch (cdb[0]) {
+	case RESERVE:
+	case RESERVE_10:
+	case RELEASE:
+	case RELEASE_10:
+		if (!dev->dev_attrib.emulate_pr)
+			return TCM_UNSUPPORTED_SCSI_OPCODE;
+
+		if (dev->transport_flags & TRANSPORT_FLAG_PASSTHROUGH_PGR)
+			return TCM_UNSUPPORTED_SCSI_OPCODE;
+		break;
+	case PERSISTENT_RESERVE_IN:
+	case PERSISTENT_RESERVE_OUT:
+		if (!dev->dev_attrib.emulate_pr)
+			return TCM_UNSUPPORTED_SCSI_OPCODE;
+		break;
 	}
 
 	switch (cdb[0]) {
-- 
2.25.1


