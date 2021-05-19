Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096C6C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:15:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6FD6135B
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 11:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6FD6135B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/C/Ea7ywAdOkAsRHfcICyHotXQwGGB1829FCXwWhDJQ=; b=X/5dQVbO89nLyv0UzUP1CJxLV
	GKnuAyK4s/iUwF3tSsovyiDwZf7S+X1DV8pYZ6zSKzWFoxXFGALemYmDz+u+egJsg1lsZfYeXbu0R
	DSiCabWYtx2s2NvX2aGXvIGz/507NX2LW/14Bp0YA4hRVpTFmzmB0l3kCP031oX45u0e8mdgxmByl
	ESZtKSHr0goluY1Ww0qoBzQw9G18dnP/4rtooqyXjWFeFKbwRL3kqyT9kt2NaHj+WzOQZmkgmeCrC
	xr2R4NaWeYLnFG2C8ukiEntZOEaJEXx45aoXeyvJWC6OflheVwRmB8mbb5d1AmoZ1vq8LmArpSF1Z
	JFanWMwOg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljKAB-003j1l-Hx; Wed, 19 May 2021 11:14:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljKA1-003j1W-MQ
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 11:14:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Eir7QMCn6xH6K+BMWXMguBGA36G5pTRiIMp3x+IptO8=; b=SGjUeuamwsnb3Ct5Fp5SWlUD3s
 Nrun9vjByrK4tppK/MWmfdbtIBvg2yAkAEWvW6wuThyz/e+pai3JR3/oZkmYyN+53/VymhYT33AmU
 0lcLnHxtjRF2ibL5m86/fK/ksp4zMEAGjFg52zlcIvp/Jlo2MKy5XGeFL7KsNC5UKwkrkAJmULZKF
 NvonTgvJMHCJ2xky44P7vpfAXB76ZbjY+F5s/Djc92a7evg5xjnRDbjiLbem3LfkABAtukMM0JF55
 6DYxmWnJJe/CknNwrVd00Zc+bOCMJuL9jhBk5By99mtSIPK8+CSIxSpuSXeqOOoudLCUhSpsLXv6t
 twU/a38w==;
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljK9y-00FOLQ-QL
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 11:14:44 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14JB9dlc020130; Wed, 19 May 2021 04:14:37 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 38mqc1hyqq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 19 May 2021 04:14:37 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 19 May 2021 04:14:36 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 19 May 2021 04:14:32 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>, "Arie
 Gershberg" <agershberg@marvell.com>
Subject: [RFC PATCH v5 02/27] nvme-fabrics: Move NVMF_ALLOWED_OPTS and
 NVMF_REQUIRED_OPTS definitions
Date: Wed, 19 May 2021 14:13:15 +0300
Message-ID: <20210519111340.20613-3-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210519111340.20613-1-smalin@marvell.com>
References: <20210519111340.20613-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-GUID: S1ZRUWidp2tuYcyCoYN1v0pxDOdTNsk5
X-Proofpoint-ORIG-GUID: S1ZRUWidp2tuYcyCoYN1v0pxDOdTNsk5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-19_04:2021-05-19,
 2021-05-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_041442_878877_1CABED54 
X-CRM114-Status: GOOD (  13.11  )
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

From: Arie Gershberg <agershberg@marvell.com>

Move NVMF_ALLOWED_OPTS and NVMF_REQUIRED_OPTS definitions
to header file, so it can be used by the different HW devices.

NVMeTCP offload devices might have different limitations of the
allowed options, for example, a device that does not support all the
queue types. With tcp and rdma, only the nvme-tcp and nvme-rdma layers
handle those attributes and the HW devices do not create any limitations
for the allowed options.

An alternative design could be to add separate fields in nvme_tcp_ofld_ops
such as max_hw_sectors and max_segments that we already have in this
series.

Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Arie Gershberg <agershberg@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
---
 drivers/nvme/host/fabrics.c | 7 -------
 drivers/nvme/host/fabrics.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a2bb7fc63a73..e1e05aa2fada 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -942,13 +942,6 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
 
-#define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
-#define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
-				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
-				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW |\
-				 NVMF_OPT_FAIL_FAST_TMO)
-
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
 {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index d7f7974dc208..ce7fe3a842b1 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -68,6 +68,13 @@ enum {
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 };
 
+#define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
+#define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
+				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
+				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
+				 NVMF_OPT_DISABLE_SQFLOW |\
+				 NVMF_OPT_FAIL_FAST_TMO)
+
 /**
  * struct nvmf_ctrl_options - Used to hold the options specified
  *			      with the parsing opts enum.
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
