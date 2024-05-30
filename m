Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C085EC27C43
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lhSLUuVNqjiDmktdJWSfLXpp+bg7l6Q2pdgWhJT8hYY=; b=bUgHt6ugTk10z6zfL3729T803v
	5wfC27pyMby7iwmcIvXFq7ahd/UjwqTjOtSApzJShRHU+nqUxiQSGTwkebiWBdGYqX9NMcQuNvZUF
	PEAR8VpNs86ojAQNpCEA3CNVVQO8RVSoUTehFs+/CXpj6aGqUVo/06Bx99/C8X/p67aP4wwNOh7+U
	kQydSjQ2LOmjNmaDfjk16Denq6UHe7M+RxpzIzKLs2sbBY+9TU3JuLvb/pzz2MNUQKjEWRAsIJorz
	Qr68sVGib5RvzpDNhbi7uOmaK/R0mvD5p6VHliX+aU+GEH5OXhG7gnZ7odujKB0Y3f0CEu2mG3AxZ
	op08muEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCfyK-00000007Oes-2laI;
	Thu, 30 May 2024 13:37:36 +0000
Received: from mout-p-102.mailbox.org ([80.241.56.152])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCfyG-00000007OdB-21UA
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 13:37:34 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VqnNz2ySQz9sdm;
	Thu, 30 May 2024 15:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717076243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lhSLUuVNqjiDmktdJWSfLXpp+bg7l6Q2pdgWhJT8hYY=;
	b=2Fb1zSwl1ifK9IHElUi0fyzMMIXiqi8+dUXDEONu6GzbWFdMX8snFLfdzQ3/XAKW57EsO+
	N4P+xzQGcad6EJRig2GUSXg4xzaXreZA6wxp3CjbQXAeKcDaQ24+kgaMcAvd7p6lwRi7Wo
	OKAE0VW5MA2Cqpw4Xkznp5CljgT6DwEd/9q14TuhoGP7XyOrGdfnaXTYkaRrxh111rXw3c
	D3k3fKqqzUT2gEsdru7kCeMM8u7Zm4L8EamtK87b6dPs3YqyT4kWtb511RpnVfE2zPLijC
	+5tPP71ca+TgfdToJUdu71u1IliAv/OpWbkJQ3/axoUxNmcA8ob9D3Y+oKCn+g==
Date: Thu, 30 May 2024 13:37:21 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] enable bs > ps for block devices
Message-ID: <20240530133721.jqbr7jkknnkxdsli@quentin>
References: <20240510102906.51844-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
X-Rspamd-Queue-Id: 4VqnNz2ySQz9sdm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_063732_684006_223F12CF 
X-CRM114-Status: GOOD (  15.09  )
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

On Fri, May 10, 2024 at 12:29:01PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Hi all,
> 
> based on the patch series from Pankaj '[PATCH v5 00/11] enable bs > ps in XFS'
> it's now quite simple to enable support for block devices with block sizes
> larger than page size even without having to disable CONFIG_BUFFER_HEAD.
> The patchset really is just two rather trivial patches to fs/mpage,
> and two patches to remove hardcoded restrictions on the block size.
> 
> As usual, comments and reviews are welcome.
> 
> Hannes Reinecke (4):
>   fs/mpage: use blocks_per_folio instead of blocks_per_page
>   fs/mpage: avoid negative shift for large blocksize
>   block/bdev: lift restrictions on supported blocksize
>   block/bdev: enable large folio support for large logical block sizes
> 
> Pankaj Raghav (1):
>   nvme: enable logical block size > PAGE_SIZE
> 
>  block/bdev.c             | 10 ++++++---
>  drivers/nvme/host/core.c |  7 +++----
>  fs/mpage.c               | 44 ++++++++++++++++++++--------------------

What about fs/buffer.c? Do we need some changes there?

One obvious place I see is:

diff --git a/fs/buffer.c b/fs/buffer.c
index 8c19e705b9c3..ae248a10a467 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1121,7 +1121,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 {
        /* Size must be multiple of hard sectorsize */
        if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
-                       (size < 512 || size > PAGE_SIZE))) {
+                       (size < 512))) {
                printk(KERN_ERR "getblk(): invalid block size %d requested\n",
                                        size);
                printk(KERN_ERR "logical block size: %d\n",


