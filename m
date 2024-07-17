Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34424C3DA5E
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDA8DefekoXWbxjlJxep/Z5r+jMeXIenya8RpdthsfM=; b=ZraNjN5rhlfSqa2StYLRvlebGn
	/s/eIsmjggzxspn6Fg1ugMKjIg3svGPumdckTV+ZRSTibS8cHemgwPnuJ8u2wsODEJXxVTVFt4UML
	C5/HsYuJhkwJpI/dqMiMmgoxq+cm6q0szF1yId6S6n0Mofp4p3ejNiqH4p5fA342QZ5jQVDbI2orP
	m7Fe5vKEDEcFvxNWghtWDJDjzOdGHAUAgXjYVGLNaV/aH3/xnVXGCPPqC3xX9hPTXpCWmiClyQ2px
	EfVAut72A2SB3VV56Qvno0Xst8+xO0I3LBqxxyLHGSZt9Qnyun2gHyEJHo2zl0YIC4413odur32dh
	R2g3lplA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0li-0000000DHZ8-3ShZ;
	Wed, 17 Jul 2024 09:16:14 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0lf-0000000DHXx-2dXB
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:16:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iDA8D
	efekoXWbxjlJxep/Z5r+jMeXIenya8RpdthsfM=; b=jmk9kOWTKOK9LVWQ6WiXA
	j17WmzLmQMyw5ryF8r+tjkHLsiVid7GfLByd5uXIeTLRvfEs0e8jN4UoGfZhVNjs
	2vISev/5RcYdrl1K0U5Y3yCczWu4p6azuroBBsahgmHl56za+8vc+82ZcUhQnlq7
	wCRQk0xeQOgUKBECid9BME=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3Py3Ki5dmGNFmDQ--.41698S3;
	Wed, 17 Jul 2024 17:16:00 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH v2 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp
Date: Wed, 17 Jul 2024 17:14:50 +0800
Message-Id: <20240717091451.111158-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717091451.111158-1-jacky_gam_2001@163.com>
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3Py3Ki5dmGNFmDQ--.41698S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry3uw15urW8Ar1UJw1fJFb_yoW8GFy8pa
	n3tF15Jr43J3yDKa1rCr4DXrWrCa17Cr9rua1xGw45Ar10qFZ5AFyqqF1Y9r47Cry8ZF12
	kFyDZr1UWF1Yy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zinYFJUUUUU=
X-Originating-IP: [223.166.237.119]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBMfKWXAmTj9MQAAsF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021612_128153_C78E8C5D 
X-CRM114-Status: GOOD (  10.65  )
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

To define a module parameter use_unbound_wq to enable unbound
workqueue to handle TCP's IO.

Signed-off-by: Ping Gan <jacky_gam_2001@163.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5bff0d5464d1..f71d56843e1a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -73,6 +73,10 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
 MODULE_PARM_DESC(idle_poll_period_usecs,
 		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
 
+static bool use_unbound_wq;
+module_param(use_unbound_wq, bool, 0444);
+MODULE_PARM_DESC(use_unbound_wq, "use unbound workqueue to handle IO request: Default false");
+
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 /*
  * TLS handshake timeout
@@ -2196,9 +2200,13 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 static int __init nvmet_tcp_init(void)
 {
 	int ret;
+	unsigned int flags;
+
+	flags = WQ_MEM_RECLAIM | WQ_HIGHPRI;
+	if (use_unbound_wq)
+		flags |= (WQ_UNBOUND | WQ_SYSFS);
 
-	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq", flags, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.26.2


