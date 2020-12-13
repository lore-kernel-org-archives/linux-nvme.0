Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068A6C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709E4224DE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709E4224DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7APYY7zhfPtZOIXyIN72jk6oS8vVIZYcZo98W8rynxU=; b=CzN7Zi1x0Nh7RnC7dg/XkJ2zE
	CHXrbqKSomO3fSm0ulonMH/XFQROXY3yHMRXSPRIWirQNEmLv1HPgGrQ7DyAcMuTzd3fHATDnMy7g
	DcYikLYJu3Q8lh2Ojuz+sA5GHO7Lda2WDxlGsjNzB88AUqHuj9r5nmW3abqCXsiVy1r+8xsRGgBUI
	Vm2PEG3PVae4EuNwAfce9qYluvxWaYpwWWRpgzuiTJFjX0ITIMfm784xrCDcGQ0fpqwOUZM0llxaY
	g7IaMY22prk6PgGhBHLDw2xyxdXDVBMeSPHBZfutj+5Jnnt4koAXMsv0Efb39TVLXpi++NIGU1TZt
	Zq8NTr0zw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koWpA-0004lO-Og; Sun, 13 Dec 2020 19:14:28 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koWp7-0004kT-Tf
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 19:14:26 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BDJB8Yr010897; Sun, 13 Dec 2020 11:14:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=NTXY6ZHTD7cVSg8noMlPAN9qaqK2KKLouOphWnIZC4U=;
 b=YPu0W7SS3iMte1RU4HH1c6YpDD2G6OmwErksX7BvWYEULEOIj2EO7mPew7dmbE8McHIO
 Y3FZMZb4Gdg5KqYsDMWWbru9gbkDO+/waohmwbclm1XHxrHnXUux8Qqdcz1mAgli+ioa
 +rqUCKsW3g/M2vLcu3QRUdZ94tGI3rC7VmSKxf3MoM2mHztvuCK0w2rxw6xukqAlUM4d
 VPWqnUo/eJAwLcHHS+ApqwlJtHaZ2SrXR0xXOl73WTF4kTvCNrRefOdxLECBoTGtJs8T
 qboSZpZLG84wWXnzrklWm56DZZaApVNIkVUZt8xVh0zMAZ9ngRu+kZgcND+d5DGzxcNI kg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 35cv3stjk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 13 Dec 2020 11:14:17 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Dec 2020 11:14:16 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 5F8103F7040;
 Sun, 13 Dec 2020 11:14:13 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [RFC PATCH v2 2/7] nvme-fabrics: Move NVMF_ALLOWED_OPTS and
 NVMF_REQUIRED_OPTS definitions
Date: Sun, 13 Dec 2020 21:13:56 +0200
Message-ID: <20201213191401.22734-3-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201213191401.22734-1-smalin@marvell.com>
References: <20201213191401.22734-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-13_06:2020-12-11,
 2020-12-13 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_141426_109063_56D02061 
X-CRM114-Status: GOOD (  14.28  )
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
Cc: smalin@marvell.com, aelior@marvell.com, agershberg@marvell.com,
 mkalderon@marvell.com, nassa@marvell.com, dbalandin@marvell.com,
 malin1024@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Arie Gershberg <agershberg@marvell.com>

Move NVMF_ALLOWED_OPTS and NVMF_REQUIRED_OPTS definitions
to header file, so it can be used by transport modules.

Signed-off-by: Arie Gershberg <agershberg@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
---
 drivers/nvme/host/fabrics.c | 7 -------
 drivers/nvme/host/fabrics.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 72ac00173500..ccc626cbf6d0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1002,13 +1002,6 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
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
index 733010d2eafd..e44955ed6fa9 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -61,6 +61,13 @@ enum {
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
