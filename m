Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76C7C7EE32
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bjktR/RD3nKV6RAF7/x6zKQEXMdzlQX6Yu1VUhmGeZE=; b=OwFrFDqjCigmWzyIQ/YP1HzWW2
	awEfP0IeaaOkgby7+6sbKqajOZ1Y4/8QRTKaFDaza/M7umo6UMLzDHrnrA/OTbIHnxSAlWzmxox8v
	wDlVvFGBF2HKlDq30VGBXNEQAKrXWC0nN5JAh5IC1PGK8CgNtox0KY2OLYrCVq2HLlGOS9O9wmyWr
	GEslegZ9fMBnS/9NSAHzgD52qndzaOXEj5EBf/bX0xfvKVKGT016sBF7AcMlHUFyEPI5y2BC7OIEM
	aoEYVsPcjf5742HfAYlqx2HbWoQpDaW+3EblSYOnV/tbxXt7INOjHtJ1g+GSCR9ySW+WVHZj0LZ3Q
	KtuyC1zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUm1j-0000000Ba3a-3yhe;
	Thu, 26 Jun 2025 12:48:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUlQE-0000000BVvq-0xC0
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 12:09:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 326305C5700;
	Thu, 26 Jun 2025 12:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3849C4CEEB;
	Thu, 26 Jun 2025 12:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750939781;
	bh=wDu6DK6om89UHsDxdNM4D1owhSt5H2XUW7SJi6WFSHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ed2tJ64HyLjyqBtfWX46LN6YmqdzKpAhYnfsOdUnqAJzVMfuL8Ao+TKzA1e4kQUlg
	 NdXBzS2VLs43bhONw8sg78vNSB4feOelHyIPXbS8r2Yi9AdT6cXJHWvYshkqba/Wm1
	 O0ik3td3284y3aytXMzTE3VCD1Z7fh8ZWCB7RW70RFe8AvplkMzaMjmD6RiUwZLLte
	 KwC4rDFwIWxBHHlGkXDZRBTtoAswdhedRCkj0elfOy7ngRejiDyD3W+s+2lpw4VDt1
	 i+b6CcZWqQzFVP1o/MPHOqQwGuTtSnJ2bW9pUSiQY9husffB2xrK/R6nHlL1D563Qa
	 l1ufoCXJUSzHQ==
Date: Thu, 26 Jun 2025 06:09:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme updates for Linux 6.16
Message-ID: <aF04g6_dk0uWq4jy@kbusch-mbp>
References: <aF0p8PlTkmFvfDeW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0p8PlTkmFvfDeW@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_050942_306700_038EC7DD 
X-CRM114-Status: GOOD (  10.13  )
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

On Thu, Jun 26, 2025 at 01:07:28PM +0200, Christoph Hellwig wrote:
> [note that the commit dates are very recent.  That is because somehow the
> tree the ran through the build bot had me as the author for the commit
> from Keith, so I did a metadata only rebase just now to fix that]
> 
> The following changes since commit dd2c18548964ae7ad48d208a765d909cd35448a1:
> 
>   nvme: reset delayed remove_work after reconnect (2025-06-26 13:04:35 +0200)

Your 'request-pull' used the wrong starting point. It should be the one
before this commit.

