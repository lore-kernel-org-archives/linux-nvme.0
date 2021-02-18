Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E3AC43381
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 17:10:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B8564E92
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 17:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B8564E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f448FI2pAEKE6dLtAVfAwkPFzAklAJ0uhOtvPwk/1ws=; b=Pd1vYLdSdXEFZn6cwB8DGNm5J
	Qhdn36KDqUXvKI2LnuaztCxs6KNmNCHlp1Mrgvo7RBPhfXr6Y9wsp5PL1+KQ/Js+r7RJq614LDGkn
	CC5wQOokgSt7G2nqZqh8cwW4OL3YL8H6Kltc5YcCzOvtvxvF5xB3ZQhJpqay6X6UEpvArrgFTcUep
	ORiy+PZPgH8PsiNd2+X5VoEr/1CsxN/NEpQwfxntOu52X2tmruHem/vtNfGwsczGJJA6RBMy0tzh3
	8lNM6xg77dgl0513HpijRRdrdTOfysk55Rk6qUu3Hfr8OZAo4VSwGhoGHI0hQCxs2MzYNckwFmCWV
	J8CuEaZWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCmoS-0005Yt-Pn; Thu, 18 Feb 2021 17:10:00 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCmoO-0005Xb-Vw
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 17:09:58 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11IH34jm001491
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=9S4EC0xwqnAuwOEUZFswsiYg05kZ0oxFSLtqtPENi9c=;
 b=mH10P6/xSjA8mClUuLApG77HEMm2865s7WZF/JRj27oPEhm9Qa5KmkCBNGuVsGIBjxS6
 Yeo7n9c+Z3jj2JGupeddUFwsiHm860vXVbl/VbzMeL+gGRXxtT/ZTuUyIkLehjmzD2W1
 pA136SOTpEv7Z5lJo/ocWseOrJz++Oz/3e1unJ/N4lSEStzSYo1JMiSwHTH7JvlynzYW
 iVyEZpk3wQWGslyOeef7wPSwenJnK0FcUZvcZwJ/HUhUrHGOJbLHBs2o8Lr5T8+kcJ+I
 x0LhqE6TSqbSKmD0YgXd3hnG1VmGGHtjXiBQxTCBwTrA9hQMUUVX3GriZkW8EIL/+AD2 /w== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 36paq993x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:53 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11IGxSX1045130
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:52 -0500
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com
 [143.166.85.200])
 by mx0b-00154901.pphosted.com with ESMTP id 36pw0bvmbv-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 18 Feb 2021 12:09:52 -0500
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.81,187,1610431200"; d="scan'208";a="1047578354"
From: Mario Limonciello <mario.limonciello@dell.com>
To: Keith Busch <kbusch@kernel.org>
Subject: [RFC 2/2] nvme: Use CAP_FIRMWARE_UPGRADE to check user commands
Date: Thu, 18 Feb 2021 11:09:47 -0600
Message-Id: <20210218170947.15727-3-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210218170947.15727-1-mario.limonciello@dell.com>
References: <20210218170947.15727-1-mario.limonciello@dell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-18_08:2021-02-18,
 2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102180144
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210218_120957_232500_9734A583 
X-CRM114-Status: GOOD (  19.15  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Mario Limonciello <mario.limonciello@dell.com>, campello@google.com,
 Richard Hughes <hughsient@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 jorgelo@chromium.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Software that is running with CAP_FIRMWARE_UPGRADE needs a limited
set of opcode access:
* Identify the disk
* Download firmware to the disk
* Commit the firmwware to the disk

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f13eb4ded95f..80be3d6b7437 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1593,13 +1593,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
 
+	switch (cmd.opcode) {
+	case nvme_admin_identify:
+	case nvme_admin_activate_fw:
+	case nvme_admin_download_fw:
+		if (!firmware_upgrade_capable())
+			return -EACCES;
+		break;
+	default:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+	}
+
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
 	c.common.flags = cmd.flags;
@@ -1637,13 +1647,23 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	unsigned timeout = 0;
 	int status;
 
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
 
+	switch (cmd.opcode) {
+	case nvme_admin_identify:
+	case nvme_admin_activate_fw:
+	case nvme_admin_download_fw:
+		if (!firmware_upgrade_capable())
+			return -EACCES;
+		break;
+	default:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
+	}
+
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
 	c.common.flags = cmd.flags;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
