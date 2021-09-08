Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934A8C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:43:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5394961168
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5394961168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1FxcdiB7kBiKzJeYqq0cPBVpXBGIHTY4vF32HkmiLW4=; b=x9yV1sj4b2WjhU
	s4vbj06vKAEIMjuQepAanUWhOXRx9TrJgfhXb/n657Wt0TO/UbzZzSZLA2llrU1Qhmv1KDTDq1DNa
	johPWbq7BCsYIDC+ZhO62/k4qquw0/pk53h5QSZJV/jUBNWTSsBB7cdHBWjluX02xC0vANp9oZemS
	LNW9EpMqi8n/8UFD9hXiPIAISRfwdnfeFG8C4NlhadZtfyyvkmuRH2kTzfZ7EQZO+qdYY0iECqOn3
	YeZOX2ALRLavXTJcLfG68O56o2jAfb7aKO9K7SrHQ00YuHVPusNUVOIEsHuGTiwK5YKTN7WRTUKqe
	zTojhbgPYeGDVnLPx6vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNsEb-005xvg-QE; Wed, 08 Sep 2021 07:43:05 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNs2J-005th3-Ms
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 07:30:26 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1882s7OK018373; 
 Wed, 8 Sep 2021 00:30:23 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 3axcmjaeay-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 08 Sep 2021 00:30:22 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 8 Sep 2021 00:30:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 00:30:20 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id D81033F7099;
 Wed,  8 Sep 2021 00:30:19 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1887UJpY010142;
 Wed, 8 Sep 2021 00:30:19 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1887UJju010141;
 Wed, 8 Sep 2021 00:30:19 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
 <djeffery@redhat.com>, <loberman@redhat.com>
Subject: [PATCH 06/10] qla2xxx: Fix kernel crash when accessing port_speed
 sysfs file
Date: Wed, 8 Sep 2021 00:28:42 -0700
Message-ID: <20210908072846.10011-7-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210908072846.10011-1-njavali@marvell.com>
References: <20210908072846.10011-1-njavali@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: AThJnKH7C58r7aAgqI2xO6mxV7SLvo4U
X-Proofpoint-ORIG-GUID: AThJnKH7C58r7aAgqI2xO6mxV7SLvo4U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_02,2021-09-07_02,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_003023_913952_E7D5AA39 
X-CRM114-Status: GOOD (  14.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Arun Easi <aeasi@marvell.com>

Kernel crashes when accessing port_speed sysfs file.
The issue happens on a CNA when the local array was
accessed beyond bounds. Fix this by changing the lookup.

BUG: unable to handle kernel paging request at 0000000000004000
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 15 PID: 455213 Comm: sosreport Kdump: loaded Not tainted
4.18.0-305.7.1.el8_4.x86_64 #1
RIP: 0010:string_nocheck+0x12/0x70
Code: 00 00 4c 89 e2 be 20 00 00 00 48 89 ef e8 86 9a 00 00 4c 01
e3 eb 81 90 49 89 f2 48 89 ce 48 89 f8 48 c1 fe 30 66 85 f6 74 4f <44> 0f b6 0a
45 84 c9 74 46 83 ee 01 41 b8 01 00 00 00 48 8d 7c 37
RSP: 0018:ffffb5141c1afcf0 EFLAGS: 00010286
RAX: ffff8bf4009f8000 RBX: ffff8bf4009f9000 RCX: ffff0a00ffffff04
RDX: 0000000000004000 RSI: ffffffffffffffff RDI: ffff8bf4009f8000
RBP: 0000000000004000 R08: 0000000000000001 R09: ffffb5141c1afb84
R10: ffff8bf4009f9000 R11: ffffb5141c1afce6 R12: ffff0a00ffffff04
R13: ffffffffc08e21aa R14: 0000000000001000 R15: ffffffffc08e21aa
FS:  00007fc4ebfff700(0000) GS:ffff8c717f7c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000004000 CR3: 000000edfdee6006 CR4: 00000000001706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  string+0x40/0x50
  vsnprintf+0x33c/0x520
  scnprintf+0x4d/0x90
  qla2x00_port_speed_show+0xb5/0x100 [qla2xxx]
  dev_attr_show+0x1c/0x40
  sysfs_kf_seq_show+0x9b/0x100
  seq_read+0x153/0x410
  vfs_read+0x91/0x140
  ksys_read+0x4f/0xb0
  do_syscall_64+0x5b/0x1a0
  entry_SYSCALL_64_after_hwframe+0x65/0xca

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_attr.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index d09776b77af2..cb5f2ecb652d 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -1868,6 +1868,18 @@ qla2x00_port_speed_store(struct device *dev, struct device_attribute *attr,
 	return strlen(buf);
 }
 
+static const struct {
+	u16 rate;
+	char *str;
+} port_speed_str[] = {
+	{ PORT_SPEED_4GB, "4" },
+	{ PORT_SPEED_8GB, "8" },
+	{ PORT_SPEED_16GB, "16" },
+	{ PORT_SPEED_32GB, "32" },
+	{ PORT_SPEED_64GB, "64" },
+	{ PORT_SPEED_10GB, "10" },
+};
+
 static ssize_t
 qla2x00_port_speed_show(struct device *dev, struct device_attribute *attr,
     char *buf)
@@ -1875,7 +1887,8 @@ qla2x00_port_speed_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_qla_host *vha = shost_priv(dev_to_shost(dev));
 	struct qla_hw_data *ha = vha->hw;
 	ssize_t rval;
-	char *spd[7] = {"0", "0", "0", "4", "8", "16", "32"};
+	u16 i;
+	char *speed = "Unknown";
 
 	rval = qla2x00_get_data_rate(vha);
 	if (rval != QLA_SUCCESS) {
@@ -1884,7 +1897,14 @@ qla2x00_port_speed_show(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", spd[ha->link_data_rate]);
+	for (i = 0; i < ARRAY_SIZE(port_speed_str); i++) {
+		if (port_speed_str[i].rate != ha->link_data_rate)
+			continue;
+		speed = port_speed_str[i].str;
+		break;
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", speed);
 }
 
 static ssize_t
-- 
2.19.0.rc0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
