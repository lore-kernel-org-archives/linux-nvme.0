Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF30C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 13:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2TJfwJxVH9pxJRpJoYkzQT/UWIx7orj3fphRfol+Mo=; b=JZMy1EO5hs7VmoMsD2PgYvmF6d
	cYFWgqK/DfyUIe1PJhjIUm79M9rqf9/8y9dFFOUs1+2XU6vF0Iz8d0YTshrfyL6cdC7WFmQYiNFM0
	omsK0HMJEaBifIa/Qcc9PAFFjTF3wBpQyLm4gV/2/y3Vdq4AuZ0XYK1PFKv4bt2RA77hQX0FRWrED
	VGQMcJIs7Q/jvH6qZfKt/B2k5kvlf+JCpzDCaQHERbLisqkLMGQXU0AlNioax4K7Ejfdu/z2cQ0yv
	6S+CnAb7gczVyuMB1kQylPBQBEgOcCcZEufo6AtXjJm7Zd/p7x3GDNfHnQiNJeNbGF/uYKQSl4N9g
	QtrKUoNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDd-005WhC-0j; Tue, 25 Oct 2022 13:43:49 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDU-005WdI-DC
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 13:43:41 +0000
Received: by mail-wr1-f54.google.com with SMTP id y16so10637061wrt.12
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 06:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2TJfwJxVH9pxJRpJoYkzQT/UWIx7orj3fphRfol+Mo=;
        b=1uYcnvDuePmS/DuvmHqoryLZwxwSSOt08F9WycFzdGjhq52IFPjdEoheSSU+3+VI53
         /iVHxQtwqdJBozzEfSG2LQbHAYRg2iWyfkloHXZvCQbB1zoSnYr4mBEZkACxZtv5L9ee
         mZOQUGMLrlXrFglzd35JiFBpJ5QKRg8Cvy/jzxDcbeLbWc1ujmNMHKdnMw99wmO3ekJi
         wi3fIoannnZ78ehPZ1a8IWoTS8Stf4yJpTaNmUZeY7iaMrfSCOEqkrSALn+fd4ObRBw6
         jhgpJREDwOulBm5k0h7CSjScPGHIPz092l6vfX1iKjtHhJe+NNoZZ1szJnXoSHBOgu4q
         ahLA==
X-Gm-Message-State: ACrzQf1BfzGcQ4J8rDoiwP3nC17+ifASzEDZXQ9gDI9b4ZKvqQ0djd0J
	WDNipW5jbibcBsltqCufxY0T7FkbqfM=
X-Google-Smtp-Source: AMsMyM7qOpZGfNQJuDIOpXgx6HT7N9i0521LIXIjAJoMFlvTuI489b2g3HcPM4ZF5Ssbcr7NsTbrtA==
X-Received: by 2002:a05:600c:3044:b0:3c4:8af4:ecc5 with SMTP id n4-20020a05600c304400b003c48af4ecc5mr26449111wmh.52.1666705417602;
        Tue, 25 Oct 2022 06:43:37 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6c1686b10sm11442239wmq.7.2022.10.25.06.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:43:36 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/6] nvme-auth: remove symbol export from nvme_auth_reset
Date: Tue, 25 Oct 2022 16:43:26 +0300
Message-Id: <20221025134330.1028352-3-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025134330.1028352-1-sagi@grimberg.me>
References: <20221025134330.1028352-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_064340_459862_B3F34506 
X-CRM114-Status: GOOD (  11.27  )
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

Only the nvme module calls it.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index d45333268fcf..734928282d3e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -932,7 +932,6 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
-EXPORT_SYMBOL_GPL(nvme_auth_reset);
 
 static void nvme_dhchap_auth_work(struct work_struct *work)
 {
-- 
2.34.1


