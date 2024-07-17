Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2774C3DA5E
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wQxVKOZRWZH4KWipiQnJFFf46L7FDmYSv688Dpn970w=; b=YeegaL78lUJZYVLhpKt5W/xYbc
	DWHShjq5lPn9w7jFjglvQOKqSDydLXbJM6+T3I9AYan49LCluKL6gNfewyN42AfCsGhobBAMe7QhN
	923rTAugl8En2XNIuNfmwcQIyRsB2alR0WCf7tR13GwONjMXKoBxOd6/ELZh8i6CXXORLRpkAyQ8S
	zcR58IHtXcvCFExqu/TNSR3THtZse6Caavn/3OrvtLrf7tXhIV9tkbGsMVPCiM5HdCjvuhsDjZ8U0
	Uz9dbL5/3wIvTULVtouswIdxS8dIJke7aqIGdWuV97/fvIcCbPg6bPZCFgRYp0Xk48mqqIPBEhndf
	K/m34Adw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0Wd-0000000DEL1-1B60;
	Wed, 17 Jul 2024 09:00:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzTZ-0000000D2Qt-3dhC
	for linux-nvme@bombadil.infradead.org;
	Wed, 17 Jul 2024 07:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wQxVKOZRWZH4KWipiQnJFFf46L7FDmYSv688Dpn970w=; b=dL4z4W90i2hdu84YDrNSASPnHs
	/3VVdjdnyrcgw22c5tzza3tMsmpjeaOa5p2DS4G76XwidZN3syt6+iWLYnQnwFzP1+XCF3OkhzaU8
	foGo5TDRICZmyrUbKgic4+wSyPzO3hnceRJjrBRW4JtYug+bDSlCQTuTyP+Hxa82o5IUMeY7GLM48
	fi+yK8pY96oGNiSuz7SchFm1inxT/SaEIFii/LX5xa3sV0TyuWHRcr8n/P3rqZgagteDMAXb8ylLo
	H+oY853gaQzzZ47fuk3fVdENsvOPyDIZy6g6vFbMHpM6iIpRz5zDkknHr0UmpdU+Q+Ls0x1RbcYU7
	B+gLVufQ==;
Received: from m15.mail.163.com ([45.254.50.220])
	by desiato.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTzTW-00000002GGw-1dE3
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 07:53:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wQxVK
	OZRWZH4KWipiQnJFFf46L7FDmYSv688Dpn970w=; b=K25G2YbHuJS9M3WyLTE0V
	XJD8u0v6WMTYuT48wNm/EgbQqZMWYI2edYTZxtnbnEmC/M7asDbRhjjLciM4OGh9
	AU6x81b1Eumfy+YWqn/aemAFebLikHU5SeRM8fmd6IFaHbg5Oh51/ollczPsqb4T
	0Yxw2XAhJ8Hxi47UGZ+Kbw=
Received: from localhost.localdomain (unknown [223.166.237.119])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3f3ddeJdmTsbxAA--.36565S3;
	Wed, 17 Jul 2024 15:53:08 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: hare@suse.de,
	sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com,
	Ping Gan <jacky_gam_2001@163.com>
Subject: [PATCH 1/2] nvmet-tcp: add unbound_wq support for nvmet-tcp
Date: Wed, 17 Jul 2024 15:52:07 +0800
Message-Id: <20240717075208.87324-2-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240717075208.87324-1-jacky_gam_2001@163.com>
References: <20240717075208.87324-1-jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f3ddeJdmTsbxAA--.36565S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cry3uw15urW8Ar1UJw1fJFb_yoW8Gry3pa
	nxtF15Jr43J3yDKa1rCr4DXrWfCa17C3srua1xCw45Aw1FqFZ5AFyqqF1Y9r47ury8Zr12
	kFyDZr1UWF1jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zinYFJUUUUU=
X-Originating-IP: [223.166.237.119]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiSBgfKWXAmTHxfwADsm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_085323_107174_76E56DE6 
X-CRM114-Status: GOOD (  10.61  )
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

Signed-off-by: jackygam2001 <jacky_gam_2001@163.com>
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


