Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7599CD31A0E
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jan 2026 06:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=58Ty7TClJ+QeBsgoKTO0/8ykFjzXjuiPyWifbxa5cVI=; b=0fWXsTJpkWZxVF6Qrmh9euAXVi
	485ZcQrDSNcwEAcouLcQa9g2NUBVijDOzGDSTm8UNGAXfkVDNjVMlNoNPd9neFB+zxkvJMLIEfvd5
	X6znQX6kFuHw7767FaaLtlcXc/F83aSMZBbuNI+fAIRXpETcOuIJSriIXV5YS80Op83W8F9ovqhUa
	amw5WVQ7hQiZgSCy+gqegLE6CsGMWOJj6AXFeFZNFlwMD57f/BBqh9vtG2A1rrJGWhk3dlMSN7Iup
	Xf38MCzNykZ+TaOEVgGg9TWVByz32B+7uOBQHaSLmoIamz0ldIKDBlHgNOap3A/aMLGbESCeskZ57
	onJt2Srw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfuY2-000000088Si-41CJ;
	Wed, 14 Jan 2026 06:40:06 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfuXs-000000088RB-0jV4
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jan 2026 06:40:01 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-81e7477828bso277348b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jan 2026 22:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768372795; x=1768977595; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=58Ty7TClJ+QeBsgoKTO0/8ykFjzXjuiPyWifbxa5cVI=;
        b=Nc+HGRgmh3yzPlq8QC8bCw6VG7vuMkhyaFxzaYkd5dKcbYyIVzEnUPYQVMbzVSwCDB
         76EbdR+xpo9ut6m2+k0dK8TOJk4rXKCA4Yp3JVYLxLYK7CuqNbahC++XjIVhp+cHuoxR
         7b+0Ty05feIWK66ikUZSchPtq+J9jpqAS8cMym2sbVDxnJINsLFctAXUZpa1xL+PwAuZ
         6JESokNwHcOt8xQB1/X+Cgs0/zdtvYHnkhYXOTaObpTasSQRyZbNWV0dbLeWLB7jc/NJ
         Dww12odZs/WzXla5sfFPkf6hD9kvAHd6XhXRAC+kfMaSurUs2ul40AKJ7EmAAOCnogWe
         imtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768372795; x=1768977595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58Ty7TClJ+QeBsgoKTO0/8ykFjzXjuiPyWifbxa5cVI=;
        b=bcZ4+exBp3khvWtJcHvWlBsewZoCzjoUTniZWN1MjP+gG7m+8U3ej4ZhZZrMRxgpDs
         Z2xkOBL/juV2QJS+yIFyC0tkjd4Kgit/wsuFU1ETyu1wqYkYVdF+4sxqvyxOdUbVmP0R
         Dbj0g/kKoZAsdPgmY0qrdTKIB3GwOtfZuQoKIgV7nibvJtL7JSw22ZOwHPcrpOBBAhR6
         GjpEEAJClbLKjPy67HtlfrsmtbxC4D6zn7h4OzMZcMnggDRh1sAmsItYpBup8mCAejzB
         7iL0B3noCLA2AFEzyXAmEKkWNfZLlZzMidp+bRBaQqjPEJF3UzwxAM0bCShGowd49lJ8
         tvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm37S7dY1MHQiK6D20kF960oB13yhbMPUQ1/xbX5uM2J9xBAJ4WVf8B0W0wCcOXy0YppCR3o8f021D@lists.infradead.org
X-Gm-Message-State: AOJu0YzGfjn0Piv0WYXX4klFD8nZIHPewDQz8R+QQhRq0QWlaKuOGxyk
	TgQM1BUrEYkDuElLY+lvapV/4dyULn3nXRiqLR9VvnOcbXDIA9SbiJkB
X-Gm-Gg: AY/fxX7uS8I5IaYKjzkdYBPsY1VPDzL2KGhdBwPJlPyANbd++eS0EYyCTVUuwhTkA5Z
	6TirAOHM9dupucR2RHWR8Bk/AdQ7tKywMg3KTIGp8q8U9nTTjQa4CjbZqu6tlLD3YSnmpkFu/0e
	Y/q/1u6A4doXEOKWxjB+1pZgxBtsd4sLbMJXNpXcGTaoQTl7LZFQQWC4InPInkVnrPotdJYFgzk
	WpcErtNXRC3O79NhVsVOsifj+91bA5f+BNFgGCOVr7cWrom3gYRQ0m0etuVUPD7qkqbodrEqIpJ
	BEd50QLGWKV6UGsvAlHRmBwJUJjc7YOEeZKl2scFTRkTXVJLkcSWhkl/IwzoIQ42d0wBNc0zyCV
	Pu60AE9pI2Wq1H8UWau9+yJnKIwN8qZ7A0iRaislScDLDpAEmyFqhkAzfR0m7YZHmZhjaErrcok
	8PvH8o6DrWG3tkkAgU
X-Received: by 2002:a05:6a00:a90:b0:81f:804f:af26 with SMTP id d2e1a72fcca58-81f804fc40dmr1916152b3a.19.1768372794847;
        Tue, 13 Jan 2026 22:39:54 -0800 (PST)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f73785b79sm3618062b3a.39.2026.01.13.22.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:39:54 -0800 (PST)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v4] nvme/host: fixup some typos
Date: Wed, 14 Jan 2026 16:37:24 +1000
Message-ID: <20260114063722.68846-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_223956_214461_7B8143F7 
X-CRM114-Status: GOOD (  14.33  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Fix up some minor typos/grammar in the nvme host tcp driver and a comment
style to conform to the standard kernel style.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
V4:
	- Minor grammar fixup
---
 drivers/nvme/host/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..6658a5806dd9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -25,7 +25,8 @@
 
 struct nvme_tcp_queue;
 
-/* Define the socket priority to use for connections were it is desirable
+/*
+ * Define the socket priority to use for connections where it is desirable
  * that the NIC consider performing optimized packet processing or filtering.
  * A non-zero value being sufficient to indicate general consideration of any
  * possible optimization.  Making it a module param allows for alternative
@@ -926,8 +927,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			req->curr_bio = req->curr_bio->bi_next;
 
 			/*
-			 * If we don`t have any bios it means that controller
-			 * sent more data than we requested, hence error
+			 * If we do not have any bios, it means that the
+			 * controller sent more data than we requested,
+			 * hence error
 			 */
 			if (!req->curr_bio) {
 				dev_err(queue->ctrl->ctrl.device,
-- 
2.52.0


