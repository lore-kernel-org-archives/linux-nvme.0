Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DAFC43334
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Jul 2022 06:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xNQhGoRsRAv8MKPVL4iXoZQpIL+NeYpLvxsgZcCifw8=; b=u45A5CYHncdNhH0oKaWTkQoWlY
	iLc3CD5ZEMDzFrVGixJ9B9j+WBsfw7KzCYvBUNiQLm9HpWhBZKm+pWyVfvoM4NjdwjQGlL3tLOCX/
	bUlekrXRJrM/bZV0VavOKqoz3fZT9LQr5e2qDFvYHTcCM1ky1r+veZ+AQXf32u9ezJwPrt7s+MD5G
	Eb+WTCpr2vfOhtYLr9yJ8IzcNXWWCI2l0zR/tnBdPV2Xe67oKdzYhm2ud6HoCaZlRcQTZxWGZg7eh
	riISmjE7/uIN7xWBKWFadH2aiFBik9FFWBm4m5bdh4/jfCUGbrnd/7f0MR8+dK6QQlAISTmqguq2H
	NYxypzYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF8TM-00GI0S-EV; Sat, 23 Jul 2022 06:18:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF8TJ-00GHxn-Qv
	for linux-nvme@lists.infradead.org; Sat, 23 Jul 2022 06:18:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B63CA68BEB; Sat, 23 Jul 2022 08:18:32 +0200 (CEST)
Date: Sat, 23 Jul 2022 08:18:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH] nvme-pci: print the command name of aborted commands
Message-ID: <20220723061832.GA28885@lst.de>
References: <20220718051357.232697-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718051357.232697-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_231842_038716_89411E32 
X-CRM114-Status: UNSURE (   8.90  )
X-CRM114-Notice: Please train this message.
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

We'll need to fold this in to fix the modular build:

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 6973c2a17c13d..e958d50155857 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -177,6 +177,7 @@ const unsigned char *nvme_get_opcode_str(u8 opcode)
 		return nvme_ops[opcode];
 	return "Unknown";
 }
+EXPORT_SYMBOL_GPL(nvme_get_opcode_str);
 
 const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
 {

