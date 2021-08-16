Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF8FC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 12:47:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087E963275
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 12:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 087E963275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WnlR2TD9WXDF4dz16lCTMv7W16BTRi3Lqb/XessJoFE=; b=w8VRtuHUbRAuLK
	1KdvE6iblB0CKoHLDvgfVXa2hwJj3VG6A6V+Tyr9Z1WT8HqFn/AK0muAvMC7eLqO1mjVwjFvDlWlz
	0th//u9iG+jENmhAZa8D/hRRlSX0+Uq05UJcbQ7Qz3/WEaTRbIErIQvWrtxH7VgUM61eJjQZmRQrL
	4ZlK+XhjPsVMkHQF2HEzBahKGjxfQfi4/ad1wk0IKLXWZn7UPCDPnnfJLH9TlSzc0fsgw7V5HTp/z
	pkbWP7NWJwfae9SE8WiaikXc2UTk+ZV5Qyl9s1eBR6hxHFCrudxOEyTaNHuItwLpODzatgQGlLrzR
	Rk6qw6MuzVd/URFdj5iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFc0y-00Gy8p-4r; Mon, 16 Aug 2021 12:46:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFc0x-00Gy8h-Jc
 for linux-nvme@bombadil.infradead.org; Mon, 16 Aug 2021 12:46:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=pZJQWRNaeVFWH0U25GaqYuL/ar2kiCCHhwmmguVKxI4=; b=HiSE7GprPhUY1JQ5d6vR0/pWPu
 THdiW8O5GDBRfTPLgSb4u2mCcRXc231QXAD8VZAa58uC1+PPj9T/WkC/qDxgE0qByQsSNagaevFNn
 outW5MO4AN5K77GfegmY+2QX/yFDCKdZ5KK+O0OilTcjV8WDyyIHbkcPhYkU4ZMZHSirHOypqTWzH
 eVUPnDEmJ4WoV2oxjkkckLvw4Q0nRHf2ZeK2ShUIb5CzHl3im+1ydf0SEZcCrlZpODWNsPTq7mOS1
 VteZ2Y7pFt5hCFhPc3RTmwmwQXOmJP3OB2RoQdC3w4LWWrXvTjL8tm9uoWW+stOeer5j1jAukm7W5
 yd6oQO8Q==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFc0D-001M7o-5q
 for linux-nvme@lists.infradead.org; Mon, 16 Aug 2021 12:46:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: remove the unused  NVME_NS_* enum
Date: Mon, 16 Aug 2021 14:46:04 +0200
Message-Id: <20210816124604.606056-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

These values are unused now that the lightnvm support is gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/nvme.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 57d2ac00a6bd..086dc4199630 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -47,11 +47,6 @@ extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
 
-enum {
-	NVME_NS_LBA		= 0,
-	NVME_NS_LIGHTNVM	= 1,
-};
-
 /*
  * List of workarounds for devices that required behavior not specified in
  * the standard.
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
