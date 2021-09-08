Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD4C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:37:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AA561168
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 07:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61AA561168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3bgEs+3AXNe7uWRwxzGY5mmi2ZHix/YjvnVKtHiBwQo=; b=MkfxLON+kTb0d2
	zNm2yK0w9xFsPwaNH68sAkwjcnWORgoS+eAEylKic/+cC3BmU73bJJwXv/yf5K4ZdJJiinmljZMa+
	1o8l+s0lPHB/Gn4SgiM/hRVu5vsrRQarETTqsmLRpLCNbToAjJWe5aIkE7MunJ+3+CVPWcXy6wWcp
	B4RwK7N9XdQDVXZAo3hu7ZXGs3eqE/E2kH35Mr6xUWDT6dGMcQvCJu5No31D/3l2n/3tqatR5alpf
	ISEaFTP4I/M2rF9L+lwa8i1nnLt5npOZnegEA5MnJgD3ASMam2FLR5WX7tYe1OvdD+uPioVH596Rr
	FtxToKOBVSjxJDNJGQTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNs99-005wKw-Sg; Wed, 08 Sep 2021 07:37:27 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNs24-005tZI-LU
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 07:30:10 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1882wkjP019224; 
 Wed, 8 Sep 2021 00:30:07 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 3axcmjae9n-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 08 Sep 2021 00:30:07 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 8 Sep 2021 00:30:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 00:30:04 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id 940B95B6947;
 Wed,  8 Sep 2021 00:30:01 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1887TuIc010070;
 Wed, 8 Sep 2021 00:30:01 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1887Tp6J010061;
 Wed, 8 Sep 2021 00:29:51 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
 <djeffery@redhat.com>, <loberman@redhat.com>
Subject: [PATCH 02/10] qla2xxx: Display 16G only as supported speeds for 3830c
 card
Date: Wed, 8 Sep 2021 00:28:38 -0700
Message-ID: <20210908072846.10011-3-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210908072846.10011-1-njavali@marvell.com>
References: <20210908072846.10011-1-njavali@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: NBatiPJl5db767Ntk7JsmRNQfeT0iBcR
X-Proofpoint-ORIG-GUID: NBatiPJl5db767Ntk7JsmRNQfeT0iBcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_02,2021-09-07_02,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_003008_901089_80F5E370 
X-CRM114-Status: GOOD (  11.30  )
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

From: Saurav Kashyap <skashyap@marvell.com>

This card is unique and doesn't support lower speeds, hence
update the fdmi field to display 16G only.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_gs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index ebc8fdb0b43d..28b574e20ef3 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1537,7 +1537,8 @@ qla25xx_fdmi_port_speed_capability(struct qla_hw_data *ha)
 	}
 	if (IS_QLA2031(ha)) {
 		if ((ha->pdev->subsystem_vendor == 0x103C) &&
-		    (ha->pdev->subsystem_device == 0x8002)) {
+		    ((ha->pdev->subsystem_device == 0x8002) ||
+		    (ha->pdev->subsystem_device == 0x8086))) {
 			speeds = FDMI_PORT_SPEED_16GB;
 		} else {
 			speeds = FDMI_PORT_SPEED_16GB|FDMI_PORT_SPEED_8GB|
-- 
2.19.0.rc0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
