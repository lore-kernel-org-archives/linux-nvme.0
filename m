Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D64CA0FE7
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lLSNMrFWKyzK+jRbmttyoG9PbRDuEuLRpCZAdzMu9i0=; b=fQOVSITNS0KYS/xy352W6NzGDL
	vDmdRxvi113pTL7QOoIUjVtMdFLWzhYpmjvlVZgW9fNzcDtNTTvbd8wcoYnO4MjNIvZ9SEe6nMdkQ
	D6AOgv9GBAMZOipYQVoctsATpjwniVj/gl7GgcquRYEkpZItVxUYE0E5F8H1wLiMYsAE0Ij++ePb0
	RKuEWfnqYOFU3UxZgn6VkHJ2YpNYp2rTQvgTbUE60jAtE7hAmxjGtL49wP4O/YybBOF6KFxRJ2l5+
	MIQW18IFpUGjSQsUHB5VUDBepLvgStIiFVjoqZba3z5wWzYjCGdWy50S9uimbHWZiHHv3fVyPX8xh
	TpbISS4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqYit-00000008Qeg-2vv4;
	Mon, 25 Aug 2025 15:03:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXl8-00000008BNN-1L0c
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 14:01:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 573AE601F6;
	Mon, 25 Aug 2025 14:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567B8C4CEED;
	Mon, 25 Aug 2025 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756130476;
	bh=7hTqhKRJtZs0aN5EraWq+wLgo52pS8rdsF1tDMIt2r8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDIXXiAfkGCe1Gg7N5K7ioYFebJDtPgDASTd+sR2bieePNL6LETyFVQXOCGGWsOLi
	 ae3nPVw/aJsuL0QVnLYW2IktsI8b3u10kobGi+6XTr1dTENTbEhiHHgJ8bLyEc1nM6
	 +rE6yfMihQD+JH6iwfg9XJfYb8BVMvhtnXZj1mcdK/Gp5sBcH4QzUDa47HOBEaDzIf
	 h8nZ0g/4kOyaf0Heh9qIaB6ejmn18bFx0SspEZpUrfswy7cse+j74aPV2G337QsvXC
	 kRM97fDKzOvyLxkZFeuC/OR5xNyx7BWlFawhbzCAUzaA5jb7A42S8KMMxIivtFUoeq
	 zGKRDL6U2WJFw==
Date: Mon, 25 Aug 2025 08:01:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com, joshi.k@samsung.com
Subject: Re: [PATCH v2] nvme: fix PI insert on write
Message-ID: <aKxsquWeJNrAE5E_@kbusch-mbp>
References: <20250825133327.518741-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825133327.518741-1-hch@lst.de>
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

On Mon, Aug 25, 2025 at 03:32:49PM +0200, Christoph Hellwig wrote:
> 
> So we need to set ILBRT field, but we currently don't.  Interestingly
> this works fine on my older type 1 formatted SSD, but Qemu trips up on
> this.  We already set ILBRT for Write Same since commit aeb7bb061be5
> ("nvme: set the PRACT bit when using Write Zeroes with T10 PI").
> 
> To ease this, move the PI type check into nvme_set_ref_tag.

Looks good

Reviewed-by: Keith Busch <kbusch@kernel.org>

