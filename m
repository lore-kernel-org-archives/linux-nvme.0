Return-Path: <SRS0=76sU=ZI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D61AC432C3
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2019 17:50:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5962168B
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Nov 2019 17:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F1TAzfGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5962168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lSW1zc4uaRGbf6CoXco2NE9+ZrS6JXdylM3meHs9jDc=; b=F1TAzfGoh6VLF5
	HtySnp1dhMRUy1X2RnjiZFS/FjzImErTliZjwgOSUqvnkuddUXKdqkoboqNfB8nbQO9KtC5idKm1S
	Dd3soNPjsSzkCxJUOEov/NcKCFAt4ZyFqs7M+ikI67j5Zpxli0dzAjcRKEtyZS2j8DxlGA5lOWPVD
	/L4voKXRoJyb64z2q/SQnOkuDlH/N0+RYobuC+SwpzxZsP50jv9ZX+/iYM4Nuk0PMjfJ4QU98PWr+
	gkshQrkImfGsimfPS2Lvr6Kq+HUeq3HZIdKwDYe5uZckRc4uVB5t8dq8DMExYe5LDlVedeP/sGXAf
	W9cvD63jnv6JQpYKxz6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iW2Da-0006Fc-CJ; Sat, 16 Nov 2019 17:50:42 +0000
Received: from [2001:4bb8:180:3806:c70:4a89:bc61:6] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iW2DY-0006FI-7A; Sat, 16 Nov 2019 17:50:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me
Subject: [PATCH] nvmet: add another maintainer
Date: Sat, 16 Nov 2019 18:50:38 +0100
Message-Id: <20191116175038.6105-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: linux-nvme@lists.infradead.org, chaitanya.kulkarni@wdc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi and I have been pretty busy lately, and Chaitanya has been
helping a lot with target work and agreed to share the load.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef7fa74..1e9439377485 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11633,6 +11633,7 @@ F:	drivers/nvme/target/fcloop.c
 NVM EXPRESS TARGET DRIVER
 M:	Christoph Hellwig <hch@lst.de>
 M:	Sagi Grimberg <sagi@grimberg.me>
+M:	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com
 L:	linux-nvme@lists.infradead.org
 T:	git://git.infradead.org/nvme.git
 W:	http://git.infradead.org/nvme.git
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
