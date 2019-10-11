Return-Path: <SRS0=FTT0=YE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C0ECE58C
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2019 14:28:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85AC206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2019 14:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L7qs0fkc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alatDqhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85AC206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=heeoXZf+eMSnZQMyW1ZQlwkNXGM5GDHjMh6gdDQDX38=; b=L7qs0fkcrR7jIg
	xyb+bv8LBg33Dt6BIVWuU172dVjuTBm2rIO6uUevVFCCn7pR/Kt87UFgISKVr3umYrZB01/0cqO/H
	Iwjs77Y5m5x5NmE3t/08LwPqgvPl0dY4/CVw4r5R1T6SIpiF9tgCIp2E0bQmFWkwNOujr4qgPZw0/
	wYru9qgtrNrQ8WBSN+6liBuA/ijJRpXsH8VmuT/4s3yNiJoXNalQdKJV20t5zJ436PVpuK5M+hnyi
	9dKUaVNNVTI+XYpJdR63lxR0iTNTPRzb1i0N7+Jr6cxRkN7+TIX7Xjk6XM/TfsoM5+VVtC5GjvuKI
	MN43EtZvftk5PVwHY34g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIvtl-0007b3-L3; Fri, 11 Oct 2019 14:28:05 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIvtj-0007a9-5W
 for linux-nvme@lists.infradead.org; Fri, 11 Oct 2019 14:28:04 +0000
Received: by mail-pf1-x441.google.com with SMTP id h195so6200503pfe.5
 for <linux-nvme@lists.infradead.org>; Fri, 11 Oct 2019 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=257hMeqCamzbbh3bCGJdrEkZVk68CgIbMh75UBs1WyM=;
 b=alatDqhFt5qYMWtu8p2HtA42LJCNzzpxv+F/8p7DGB7P+OF7GEboQbehZZYCqJ70v5
 tl16WGHI5sbslcJkJhQqhl2H+7XMJ+JwdtWSznA2FqRCz+hYpE4w2acQ+fgg8X45YNfy
 6IxEyHA8sNZ/T11he5b68yEoGoMa2mjIAcX+2pabcUizZzOHrdcPSq1iex8mx1z6qJic
 biMeHYJhqfW4EUbVnmKNPkuqpsPw79VKlkPTQhN0NQBAXDbplv6VXY4Q0jEeXSAlZ7uD
 n9zM5iJ5KbVx99eRqZtqUm23cbjkhSA1/wCXbTikXLC5QXrH1fEjA051Ob265f/VeBq9
 alAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=257hMeqCamzbbh3bCGJdrEkZVk68CgIbMh75UBs1WyM=;
 b=LE1kuPYmHyMzEAfMowM4kiaB7aU2xRCgS/yD/+mK8rq2H5et1B50/H3OTVl6lT/Ad6
 ozfBcx5NIcmw87REgFi2q4RTwytu1+JRuPIPBcUtedN3dP1FmlvYfQ4Xb7Ya0lU3iBal
 mMoboCwgLinluuVybnDIY12ft930V2UUKQRB8xv5ul3H+5PV/73lFFNzomfawytojyzM
 JQ9dM58lDH2PUpUuep1PKMEGYh33EjlbZ4UcPM1nRKJDo0yDuY/GqghWKYfogZlzypvj
 i5XpGHw/gKFpR7r7GT/2xsKRwVVFZ6gqyxnwFYy0ig1nGdehwaPvorwEu3OLISBM9GC9
 0Ptw==
X-Gm-Message-State: APjAAAXMNXHTjE/fB4VQ42+Td9MWgraw6Wupni04Bcu/c+tQobh4+XcI
 nuykIvdHcv+6FTjyXALEkyVjV8/usJo=
X-Google-Smtp-Source: APXvYqxhBdYLOfZiYIY8V8b7fwKAGkGMDgypTdHaUxh8KxomikAXdnZL/iKs1pMk1PXnomV2S9dUZw==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id
 h1mr17776852pjs.96.1570804081983; 
 Fri, 11 Oct 2019 07:28:01 -0700 (PDT)
Received: from Serenity.amer.dsc.local
 (cpe-2606-A000-1125-4300-3224-32FF-FE82-DC91.dyn6.twc.com.
 [2606:a000:1125:4300:3224:32ff:fe82:dc91])
 by smtp.gmail.com with ESMTPSA id m22sm3752460pgd.45.2019.10.11.07.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 07:28:01 -0700 (PDT)
From: Tyler Ramer <tyaramer@gmail.com>
To: 
Subject: [PATCH v3] Always shutdown the controller when nvme_remove_dead_ctrl
 is reached.
Date: Fri, 11 Oct 2019 10:28:26 -0400
Message-Id: <20191011142826.8497-1-tyaramer@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <7042458bf65523747514c98db36ceaa5fa390679.camel@amazon.com>
References: <7042458bf65523747514c98db36ceaa5fa390679.camel@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191011_072803_213300_219DDDE2 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>, tyaramer@gmail.com,
 Keith Busch <kbusch@kernel.org>, Balbir Singh <sblbir@amazon.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_timeout() will go through nvme_should_reset() path which won't
shutdown a device during nvme_dev_disable(). If the reset fails, then
the controller is bad and won't be coming back online, so it makes sense
to explicitly call a full shutdown during nvme_remove_dead_ctrl().

Signed-off-by: Tyler Ramer <tyaramer@gmail.com>
Reviewed-by: Balbir Singh <sblbir@amazon.com>

---
Changes since v2:
  * Clean up commit message with comment from Balbir
  * Still call nvme_kill_queues()
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c0808f9eb8ab..c3f5ba22c625 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2509,7 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 {
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, true);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
-- 
2.23.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
