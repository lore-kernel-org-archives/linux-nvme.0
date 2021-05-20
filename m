Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E83BC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A13610A2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A13610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iXlrTa+S8J5JHDXEe7e04g4BxrmmATi465+AU0/duI0=; b=TEMLyWqdeOnTtFNNHL//do4pf
	KkKXnbMvoxQZs5LyVIbhQqal6f4Fx1s67taclzjse5tTLgtPb7lc8Eq5ZYP68LB+GQHZAiVz2dgrd
	x2f0PzUxXG4uBFclgb/m3liOKY3w/XB1XWNTZBwnYEMWT//CAekUgMbmSNGqXq4tOgElpzSONC+Km
	nrN3BhT3mGpCtjEgS8doCfl/TwHr2C2Q+Zrx29VRKHCwUcDH66AMWZgLzM5YkswwYK30DJqKMTnJl
	Eqds2AN70Mh26h2HL01o1SwkrRDwqX9zYJlGJDmlCbl+mwY71ncKCYDJMqT45HwRhmLhouqNcqPl4
	JAEkCTOqQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbUn-005ykg-4K; Thu, 20 May 2021 05:45:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbU9-005yds-6C
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 05:44:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=qwyifvlOTI7dd/zclI8mOFjZs4jgKkvJSIi3DIjsnmI=; b=SubfWjJuOeXifP48yfx5IBDy1X
 JNLjFaaj6qfLqkhBuw8UXSV5FoZ7orzvdJPxbXmVotAhOOu8XF/3KLfRDkXr4JcHwEo2zAmSErSPe
 leu893KWO3sRYCNZcoidAQlzO4oNTSCvfNKMCoe9HhxnT8+n6VqGCRHKQgFUuS7uZjE7QJKn3b8Mm
 0vk7o2QfhKkFa0Mjwa+/CW+wXkCdiTPrFyyBYOx+kxnpfAQGccCN0m2wmKVHo6BccfrHKdvIJwX6V
 yx//fsd+wCEMpED93IhpwmqbS4Kvyq24TqWlve4CEZPDAAPAuQmmdUaxr9Q4sQvwVi3RTukDKWwmC
 XyWstuww==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbU7-00FxMY-I6; Thu, 20 May 2021 05:44:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/7] nvme: add a sparse annotation to nvme_ns_head_ctrl_ioctl
Date: Thu, 20 May 2021 07:44:23 +0200
Message-Id: <20210520054426.567241-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520054426.567241-1-hch@lst.de>
References: <20210520054426.567241-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

Add the __releases annotation to tell sparse that nvme_ns_head_ctrl_ioctl
is expected to unlock head->srcu.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 2c6969ffe85c..2e7780ea0354 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -372,6 +372,7 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
+	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
