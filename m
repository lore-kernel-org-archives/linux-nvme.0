Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF3EC7619A
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x3uKOPhzjBliaUe2CRdGOSzC70ISYEsiEVpkoN7N97k=; b=E5ov4s69yvMcLGzCPW9NU+Wi45
	oG4nN4767+T/zifEVIqgDe8vgi9EyBhkBBiKIpKW0jFf17Bo+U8gSFNtklBXgYiOI0j2bjcOPEYhb
	HoZZZXVhT3yaGmLyzsWnRBg52QAm3HS8Az1AxIgPH413M1fY5RmnC3wgteraNXWM4UbfKUYZZGXZT
	agtalb0YrT6AtVjMoY7/tJsbnA8VUiRoPlq6dgI79kFoRkEquoa50HygPPDtQp3mTO0rrYgfv58mw
	zTB0VlT/AhuUqKmsgddyx0zU6Oz4mnQpT/FgqOICldLfq3FOyqJ5CUIXxLcQPN1ALJv9fLj68mTHG
	5NK3cIjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4wL-004qNe-2C;
	Wed, 05 Apr 2023 15:20:49 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4wJ-004qMx-1o;
	Wed, 05 Apr 2023 15:20:47 +0000
Date: Wed, 5 Apr 2023 08:20:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-core: Fixing ctrl de-referencing in nvme_init_ctrl
Message-ID: <ZC2Rz2Jr7kqf6LKs@infradead.org>
References: <ZCoguA3gBUw1CIdd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCoguA3gBUw1CIdd@archlinux>
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

Thanks.

I've applied this after splitting the cleanup into a second patch
and rewriting the commit log to describe the changes a bit better.

In the future please try to split fixes and cleanups, or generally
separate changes yourself.

