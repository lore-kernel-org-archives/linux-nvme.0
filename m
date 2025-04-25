Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64833C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8xvQpl6L56E9OzEC3BekKl76k9h6BsvgaKfroOxSzo=; b=y0iXPqHwRAeTyMr4+aC6lGY5va
	5hFH/1wuYg2lcQnCZ+wZo27psdVwEfQtNoFZbqN+Uy1gNBEsuSTS25AxTRZlryGM+fr3oXANsnt8p
	iJ5NfN1MzD7Izl7Fzoic9OeGm7hlDTZbLpQiJX51B12aWd9d+rRJ6cx8/7U8KgM0WGdoi2dr2ARim
	ybRln3Ko9QQN5SWFg7syXd6mLf5LlXDtsAoxR8OayrY23my4/Lj04d5OwYdeBWBExnuguP67s82c2
	IUnSxvcxCCrYWdHmVz0/oHLGMAADmujkhFqMM/CCATznPmOc6Q8Ta/MIub6WabWRK0z0rXcW6FbDS
	2yZrSC2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Lg0-00000000APh-47BB;
	Fri, 25 Apr 2025 16:13:20 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8K7Q-0000000HS2D-2x6R
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 14:33:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 692C8A4D26A;
	Fri, 25 Apr 2025 14:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC4DC4CEE4;
	Fri, 25 Apr 2025 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745591611;
	bh=naELMTHkQCrtNUXFtdIlhZ/tSShKnzvXwQ+JquGaDVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDeiVu1JQgvYQfaEgonm4raJYws3bevwxuuU1X9I3sWG7tMEVAbrriNsu3h8KBUow
	 CizKzmJlIB6Fub3CCH7fSKo+djz+h+4BTP/cB5nAq4kXfS6CtQ1kR6Afd9/eaifc87
	 N8A46Jti+/1DnLZVgtkW9Qax/ds5fmpWMX1pSGLE/rXECM8aeov2cTkO8osXQhhI8o
	 UyNAuCQGrGezp4qqiwb9ZSfBwUnxrQnwsHjM3zd4FBP5nalY5ib8mkr/jA9s9YIOsk
	 bqb375W0DTR6abaxdRa0RcDBd4WuFN/UkfZNcwKs5uQyOHkREPpObViI6AUHAgjojf
	 Od8GbMLGfNnRA==
Date: Fri, 25 Apr 2025 08:33:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	Dhankaran Singh Ajravat <dhankaran@meta.com>
Subject: Re: [PATCH] nvme-pci: fix queue unquiesce check on slot_reset
Message-ID: <aAudOMQi05je8ADN@kbusch-mbp.dhcp.thefacebook.com>
References: <20250424171801.2300390-1-kbusch@meta.com>
 <20250425131935.GA5460@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425131935.GA5460@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_073332_811522_C4529D96 
X-CRM114-Status: GOOD (  13.78  )
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

On Fri, Apr 25, 2025 at 03:19:35PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 10:18:01AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > A zero return means the reset was successfully scheduled. We don't want
> > to unquiesce the queues while the reset_work is pending, as that will
> > just flush out requeued requests to a failed completion.
> > 
> > Fixes: 71a5bb153be104 ("nvme: ensure disabling pairs with unquiesce")
> 
> Sounds like this code path isn't get teste all the much if this stuck
> around for so long..

The conditions that trigger pcie errors were the primary concern. Of
course you'll get IO errors, right? The pcie connection is flakey! But
we are supposed retry IO's after recovery, which we weren't doing, and
that was a secondary concern I embaressingly overlooked for many
reports.

