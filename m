Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D07C5DF81
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fFUnUD2PSYg4bX4Q3b9OOzDwXzWSfr57LRsGrlQRamE=; b=H+kltI4/kvcUJO2xbs43EOPDN+
	ZV5cl93N78wQgtTTO/T6SdE6kXIcU2bWaUbgKOgQlvnHQTqEc3epn4VaUv+2hML5o0MlgpawWFUbG
	wCD6206pLxLo36D/JHGxBeQodCJFf5pKOBmJxXEhyOaDa38EJDVtIbAp1xFL05XodfKL/YNU2h7Ft
	YwqmDIkeK/+SP6fRLonyWMR/2HXen8L+gCSoAAapHY2rn8FZcMMqClMZjDM72TktlMfK93I2smPSp
	IYeb/3NotBgLAJHhhMFiWZSGdUOvRtFuVqzHKPFUAlIsCBxktyhN+WCs4HNjWK69I8IEMvlIGYIAo
	MxfafBYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydB3-0000000HSBm-2YrI;
	Mon, 24 Aug 2026 22:30:01 +0000
Received: from mail-pg1-x561.google.com ([2607:f8b0:4864:20::561])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydB1-0000000HSAS-2yza
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 22:30:00 +0000
Received: by mail-pg1-x561.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso2418761a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 15:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787610599; x=1788215399; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fFUnUD2PSYg4bX4Q3b9OOzDwXzWSfr57LRsGrlQRamE=;
        b=RhscZxAKGyYG5gBdg6j3gwZUQtM8sRTncLY9LmTACW9L1hnCjBbJP1k1W1WsiYZJnY
         C93jpHNg5aUozCsB4q9BceoYRs+e3TbSh2uMqrSgfaOQYtwoLsXvFirjzc2laKFcHwBQ
         IJzHrANmRhWHG4CwiK+FZaQj9Xt5unNuF/QOqcS1KkA2wUR5V+pt+SHYpBugBX9GCp/K
         8EpLJM04yCtRAhgyndFmYMooWpXHbOcQGoESswii5zJDNo8hl3b/l1ChXaSQ9J3FipJc
         UxGCVLiwl315FX4gtmATzgllh2k/0cX+ibmoQn9dJPNs/ij7n+Uo3XMsZraiA78nsHY3
         S9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610599; x=1788215399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fFUnUD2PSYg4bX4Q3b9OOzDwXzWSfr57LRsGrlQRamE=;
        b=e2P2YASLeomUSFNyZlD7YJBmnz5YsW+lgq0FbHcy3Avs3XKx5azFDb6Od61V0+sPgL
         x30sVOKlO95fK8cHjIfhhaWrRUIv6x9l/q/bllEmbOR5Q8N8+FQZF6/8SZ+6Clt8Q8Pq
         nJuL+e/ZcgHgAey3v2T8bwO91Ox2VxWkgdE6NVlSte3CgsuwUaYjjyZ/q3Eamfj02+Ei
         9sfCDgX0Zj7Y2mkY5D4hahwzqfAGMFLbrxc/T4mMFyQExBsbk1JSZiCVzQ5y/8mllMdJ
         FlDEZr2VjDiH6DBFunlQqrrPFCtZ/2Cw8hPQx73QUe1JUo+3qa7x1waK2f0g515NGz67
         MyjQ==
X-Gm-Message-State: AFuF++khHGn9+DEuE4PmH5PqIjjLtJDA/y02I4m6NM0jRelswJqGCSi5
	Qe6BEqWbXrtnTGHoltTAga5y0W+y8qhnIDHgRK3mY2R/l+Sf/YBG+ATT5IXvLxSzb5/ifGedDXD
	U9CUuDqekoYmGxKRgnKSmyPSP+8N4IkijkjSW
X-Gm-Gg: AR+sD138h/iwsPrRtOVda1wJhayeTrbDB4z2OmUTCNsYiGgT9+h84GG1MG0zn+kSDaY
	E/eAjbMAqJoxm9yjwGuMSvFaGPuAspBkme5P0PkMcL6NbP60+XilYw9vZYzSikhPyKKaF0/H1z1
	ItuedollyF6x/pi0ZdS+CQSEr8+yfOjM/+mjzdPLEPTRR2t45V9uZhSH94VUqTBOJkuUUZEZ3ig
	XWcP38zNV+EOsmgCzOFIADlBblOKGr4e+t9NEQrp3+mppXdt4VZgOQNpekYmZxNcIMXZFVFe77o
	vz6VxCD45XhX6lT1tKRhapIkuDRclAPMX5GduJ5tp1SV96pZJmsb5pCNqITz4xNrSQ9WFfqOO5f
	/5wHk6HocPqv2QArMKt6TNaF/CirG5so=
X-Received: by 2002:a17:90b:3bc6:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-395c354da4fmr55156438a91.10.1787610598726;
        Mon, 24 Aug 2026 15:29:58 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39645b346ecsm385635a91.12.2026.08.24.15.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:29:58 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 1B996402B2;
	Mon, 24 Aug 2026 16:29:58 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 181B951D15; Mon, 24 Aug 2026 16:29:58 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH 1/2] nvme-tcp: refactor I/O queue setup path
Date: Mon, 24 Aug 2026 16:29:38 -0600
Message-ID: <20260824222939.301887-2-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824222939.301887-1-sgogte@purestorage.com>
References: <20260824222939.301887-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_152959_756609_C864A8E3 
X-CRM114-Status: GOOD (  16.33  )
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

Split the I/O queue setup helpers apart so that the individual steps can
be called directly from nvme_tcp_configure_io_queues():

- Queue count negotiation moves out of nvme_tcp_alloc_io_queues() into a
  new nvme_tcp_io_queue_count(), leaving the allocator with just the
  per-queue allocation loop.
- TLS PSK validation moves out of __nvme_tcp_alloc_io_queues() into a
  new nvme_tcp_tls_check_psk().
- nvme_tcp_configure_io_queues() now calls the three steps directly in
  the same order as before.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
 drivers/nvme/host/tcp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5fda9661bdb7..354668ad29ac 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2171,10 +2171,8 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_tls_check_psk(struct nvme_ctrl *ctrl)
 {
-	int i, ret;
-
 	if (nvme_tcp_tls_configured(ctrl)) {
 		if (ctrl->opts->concat) {
 			/*
@@ -2196,6 +2194,13 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 		}
 	}
 
+	return 0;
+}
+
+static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i, ret;
+
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_tcp_alloc_queue(ctrl, i,
 				ctrl->tls_pskid);
@@ -2212,7 +2217,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static int nvme_tcp_io_queue_count(struct nvme_ctrl *ctrl)
 {
 	unsigned int nr_io_queues;
 	int ret;
@@ -2234,14 +2239,22 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 
 	nvmf_set_io_queues(ctrl->opts, nr_io_queues,
 			   to_tcp_ctrl(ctrl)->io_queues);
-	return __nvme_tcp_alloc_io_queues(ctrl);
+	return 0;
 }
 
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
 
-	ret = nvme_tcp_alloc_io_queues(ctrl);
+	ret = nvme_tcp_io_queue_count(ctrl);
+	if (ret)
+		return ret;
+
+	ret = nvme_tcp_tls_check_psk(ctrl);
+	if (ret)
+		return ret;
+
+	ret = __nvme_tcp_alloc_io_queues(ctrl);
 	if (ret)
 		return ret;
 
-- 
2.55.0


