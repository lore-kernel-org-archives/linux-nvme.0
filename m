Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AFAC63798
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474D322226
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fu5ZQVgR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GuXGUnRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474D322226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L2eL/NNgALdu+4aO9CE9t8jK7DFnhmumxm55O9/V+OQ=; b=fu5ZQVgRM0hgQc4VBWpzwGOGD
	nacsX1dm1J8gGUd2hPjIJKZnG0kpEF3rgckddx8YRUXacR3KcU9yRE+Bx32iX1zsC2rGAgW+YpseG
	jbiTw1U4vVaKh1qsaHUKpnaEO9hQRivFNj47z8fv8EhhK0Ca6ETjX88G5/lVzCXUGRh0Pux76cDn0
	JtGknSdNkzC78Qv4bfM8uAXplyGAFsUrPDWt0ClqIOOvQoCwfSzDMvDqdVt/dvknqKa+7cQTPz20k
	3QeFzDsReryH21aFirbQtOUno9DL+Q5/5SitpAcXIpUWthfwJIpBaGjjXRBvv4ZBAXEFtMQaABEEA
	3xGy4JUhg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfkp3-0004IN-G4; Thu, 19 Nov 2020 14:22:05 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfkos-0004ER-5k
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 14:21:55 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AJEK0aP007962; Thu, 19 Nov 2020 06:21:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=B9aqEn8XwfK9WbN/g9aazFumOGp7QDr/6K9lvVFTdiM=;
 b=GuXGUnRzEkjyjkN1yJ824bK4VqR/BA8/17s//xX/8JAvp0IoXWmf3HqWf7k5BrSNm4Ty
 6rGfb493GWIWq//sanPJAMktSg6z/7QeQQ6+twYqK2atVtopHwvwKCANcILBfYX7qzU6
 PF8o3orPyfyJtNbG8iiiGfAXgORpilzbTrd9ie/r8JWjBDvz6DgOc9EVzUeF5XrZEUOS
 IMeIbHHwdwvmpyyZq1b7tNpY/wKkYEtva1ofotpOghkByINjRugLSc1ir2DG6KK7d9Qa
 rLAqbbWmUq7JXgS80WJ3n5ojoF5GX8v4Ut2rnUv9RR2F9wpRXYUq+GTazlRvkAWcBP3o 2A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0b-0016f401.pphosted.com with ESMTP id 34w7ncurft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2020 06:21:43 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 19 Nov 2020 06:21:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 06:21:41 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id C36D93F7043;
 Thu, 19 Nov 2020 06:21:38 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [PATCH 2/7] nvme-fabrics: Move NVMF_ALLOWED_OPTS and
 NVMF_REQUIRED_OPTS definitions
Date: Thu, 19 Nov 2020 16:21:02 +0200
Message-ID: <20201119142107.17429-3-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20201119142107.17429-1-smalin@marvell.com>
References: <20201119142107.17429-1-smalin@marvell.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-19_09:2020-11-19,
 2020-11-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_092154_399825_2F1CB62E 
X-CRM114-Status: GOOD (  15.12  )
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
 drivers/nvme/host/fabrics.c | 6 ------
 drivers/nvme/host/fabrics.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 4ec4829d6233..f5af440b1751 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -981,12 +981,6 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
 
-#define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
-#define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
-				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
-				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW)
-
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
 {
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a9c1e3b4585e..0a8712a2462e 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -58,6 +58,12 @@ enum {
 	NVMF_OPT_TOS		= 1 << 19,
 };
 
+#define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
+#define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
+				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
+				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
+				 NVMF_OPT_DISABLE_SQFLOW)
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
