Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC446C61CE2
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fFUnUD2PSYg4bX4Q3b9OOzDwXzWSfr57LRsGrlQRamE=; b=11XAFDMqTLKE16pLHmOW68Ldz/
	sX2l1DoPqMozyop4mouFEE1hXccGgbfU7776JnngXWlEYWAvUYNt6aFSBcxF6L0wCYsMK1R4dgBWz
	sFYjFyl3BCTAU2SIUgCf0f2jyjB3AW6ltA7gecRC9QAuNmmwI7AWwW3xKVfmvr7JeHI8wQFfPpU/S
	aqBhs4v8OwyhpaM+9ChdSC5p4sqM9U61Oz/L7ClQG6G1Y1NXySiv4C3h/JTakFizzxbhg1Vr46eZU
	kvDBNVBS75t0IPG09bEJvihzthwYdYj8msEunyvLq5b+Av2oH9g1mQ88cAJU2ryZzb4Zo/2bjWEF/
	xL3/wl8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydbH-0000000HTNC-0Jbd;
	Mon, 24 Aug 2026 22:57:07 +0000
Received: from mail-pg1-x563.google.com ([2607:f8b0:4864:20::563])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wydbE-0000000HTME-1yPk
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 22:57:06 +0000
Received: by mail-pg1-x563.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso3371157a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787612224; x=1788217024; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fFUnUD2PSYg4bX4Q3b9OOzDwXzWSfr57LRsGrlQRamE=;
        b=Us4ItQCNaD0fOnOfZ8qXK5lZfSHweMnBYCUcZBOhmq+Qxz7KGF/8fSVJZIGcHgZRWr
         kf0tS+/9uFA31h8sPulzUnSQoyNQFlIeXXla5zwGBNLuE4wU8DTHNT3ly04lDcUg3Hj1
         3gw7XXafi+3lM+CnSTNuHPhhZrNlR6/Q3eBV3gpm1roujuUHOx0QqGE3D/vURIOrCUaF
         6nVl+Pd+mYcHn0oLbwsP2d5ztyup2DdFtEreqsVwRWSHyR7ybw7qD2zQhT8vVvAuAuPO
         fgKPqOlV8OA+X41gap3/gXsznFAxuV/YP5mUMFIJPadtZHYrtbLaRMlfR0KQ5zfqOW1c
         TrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787612224; x=1788217024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fFUnUD2PSYg4bX4Q3b9OOzDwXzWSfr57LRsGrlQRamE=;
        b=P8uBjRZ/NlJ/bzvNhLwaE5LCLuAZtd8GLiFKrgmp8ybzMli751fpOgcawxvKXCBaN0
         a1ZGSTuzva2iDoQaOdvtIWKnYVSy/V9ELIx5ng0TaizhJChEdIV+HYB/+vg83c79cHDr
         FfVvALKtMow17ge9UX2X2xtUOzbo1CYGR1mxZgS5Bbrp4dfUPkwx6Ovb3ArQNJmJGIqb
         y5WTJh4hRMd23I+zl6y+EJBLoBjSPNAAqfZByso9/vax71blQk7OUDMNyTDP4iHYb/Yx
         qdyWG+1Iq9T9HX9Ahx91VLdLRILF5kOUcygFLtzOY1nO3TabU01IBNxAver/xLbSZ0zc
         uQew==
X-Gm-Message-State: AFuF++nsvn+UUb2Etx7H6wcCvI3N6fk09FpTifj2WCawcmXXA2zJSsKJ
	M8sjOEZPgNA8yCbk19IRZBDQZ8DmHcaYuiZo6p9zh98CEAjFPvZXwloZb9j6NeU8rnN/tUJxbqI
	m92vWc9yUJ+B3nLmzzrJlhC+nwvbEJV55oMxffstrIAuQTUEM4Lpq
X-Gm-Gg: AR+sD12Tqx0yMBmb8Dj9jlayhTKtAU+5HjY25lI+IwTTJi+Guxh9zEqjSLOxLysEU32
	SxfgDxDqE4e2W1IUZb7YeeoAjm/LwrNkYhfQAb0By9O/6ER3BECm+Rr7eN6/DYOGBCxGMt15qh8
	aN0wabUTj6+jWbgn50PDwswxk1aBqWJdd1hbBBBOcvRzjxvV3TfXoKBBkQMMkML9ZZ3TYkCyX3W
	cOTbSzghIjMKulFAkG9TKP9SZp3z4Xejxp/l/2p+qTyo0lCSa1+3ShaNzCDgGSMD3h03APV+JKU
	OQBChrLh0EkDXSP4i4tECsH4mnA6W9ARlw9v4C7EJaJMiWEy+xaGH48feldM6IatihXE14xECS2
	eXU3yBJH3V19392Q=
X-Received: by 2002:a17:90b:4ed0:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-395dee539f3mr43171924a91.3.1787612223567;
        Mon, 24 Aug 2026 15:57:03 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39645b43d8asm400989a91.13.2026.08.24.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:57:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E386F43660;
	Mon, 24 Aug 2026 16:57:02 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id E0E0551D05; Mon, 24 Aug 2026 16:57:02 -0600 (MDT)
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
Subject: [PATCH v2 1/2] nvme-tcp: refactor I/O queue setup path
Date: Mon, 24 Aug 2026 16:56:47 -0600
Message-ID: <20260824225648.316962-2-sgogte@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824225648.316962-1-sgogte@purestorage.com>
References: <20260824225648.316962-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_155704_959632_869D1D32 
X-CRM114-Status: GOOD (  16.54  )
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


