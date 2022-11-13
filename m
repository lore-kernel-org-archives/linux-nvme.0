Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA07C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ed0kJaVsW/B5O8TsOItG4+BuXa8gRp0G2ju8CprlRZ0=; b=tDJTVngsjKfXT6kBwQgaVKubkQ
	iXXZrqwZ/b5SphhWoqotzm0Q/vKCvrmEcMah1XhF+W8wsB1EwAA+iN0oxKi77pzJJHa6nRWOrfcT8
	O9WpZb64gYYv5cW2BTwXtMQtKApTIR4++y8YTslEkTYFMMSFk3QsHdL9ExNSZj6g2yTcJGlATxkUu
	/lp52Tb1l+uWVvjR0vwmjfilDl1gIPk+cTi81b+9MeB1ZLuD9WeDjKuNYuXGI5Xd9/jgFU7wYYz61
	GJqzILbEX5cghrtah+Lje6lUjJ1B0V2X5Zc/82zOc7RC1pSGXrxsIhTKDAm4uOEBL4Iz3ebL4FGKJ
	2sPEeXPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6Y-00B6Vr-IC; Sun, 13 Nov 2022 11:24:50 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6H-00B6NO-No
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:34 +0000
Received: by mail-wr1-f48.google.com with SMTP id y16so12383160wrt.12
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed0kJaVsW/B5O8TsOItG4+BuXa8gRp0G2ju8CprlRZ0=;
        b=GjESVH/s5eiLTjqW4SrrM8lJr7yWaIJ3vmZrJR10uHwqy+2zZ840Nun/p5zYsf5WfX
         KtCtr20lI8yLlN++qoWhktbwSWCC1Q+nIJIndF4/0QhDWdwCaPEQj2aHcb+Dcnd+8BuV
         se3KjLoAAY+lENj07dhAThZUZnavDwTzMH2meTTVEDg8uHZBkHcM7saL2sevhWWxX6y+
         D60Hnur8BZkarucj5Xh5yrUHLzPz+Yb4jxbsXaxh8uwjVkpv3kS4F7s2i0FAfns9NFQI
         MrW1QixGVu/dj8ubRXwSOfUnXlSlwD+6lBpguirmPPo0iFPT0q5N3zLZNd4c2qR0sram
         KBxQ==
X-Gm-Message-State: ANoB5pmBYc7vHfjY+EgYrnzeZmxUyGDP097LIN3ySlJ4i//7tCp3yF0d
	Ai1pHpkSg0PkZw06/lhR4/ZvKlK3pGw=
X-Google-Smtp-Source: AA0mqf7HT1t5naqMPHPQQr/6qG11d+tL8qI8ikcal00xHpgxTLSGnHIv/dEZvrdycLNU5P5I53sZHg==
X-Received: by 2002:a5d:564b:0:b0:236:6613:afe6 with SMTP id j11-20020a5d564b000000b002366613afe6mr5074111wrw.702.1668338671730;
        Sun, 13 Nov 2022 03:24:31 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:31 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 04/20] nvme-auth: don't re-authenticate if the controller is not LIVE
Date: Sun, 13 Nov 2022 13:24:08 +0200
Message-Id: <20221113112424.1049834-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032433_794749_4F1CC6D1 
X-CRM114-Status: GOOD (  11.59  )
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

The connect sequence will re-authenticate.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 2f823c6b84fd..4f2c8d0567bd 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -939,6 +939,13 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, dhchap_auth_work);
 	int ret, q;
 
+	/*
+	 * If the ctrl is no connected, bail as reconnect will handle
+	 * authentication.
+	 */
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+
 	/* Authenticate admin queue first */
 	ret = nvme_auth_negotiate(ctrl, 0);
 	if (ret) {
-- 
2.34.1


