Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCBBC9830D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTcaE95a/3+N/f3jbsGpYgEIfRtQ14Ob9bGG7niBKXA=; b=YQ3YC8ErQMxi3VdxzrI2gou51N
	Wr30bqArD/nKc8xU6oYHw070VMxoyLDO0feZfbZV0Sy0hhKmjlEFQ6p8pDEASXzfltNqmVKTUGM1f
	PtIsVvC+Hcrfcaq1PtVuh2UwuUug4h0jfpILympfec45FMawPSq5jTbMnAaO5+DEZGMmA+k94aKae
	2NSkaLox0RN2AjWbXjxE+LBk8eiKmtvLPLwzRdpr57WCQHlYwvv8jpm3JsaDQSa1iUHS7WbGPZUvN
	r9Zm5duqrJyCFO2AV3WBmezpZ0MBKggPlCTsuSV6gnHWm93xGV0mZjS0+sTs4XG0U6TdYVWzYiGHB
	kQV53ULw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9zs5-0000000CmiI-3Z3H;
	Fri, 25 Sep 2026 06:57:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9zs3-0000000Cmhk-0Efd
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 06:57:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 963CB68BFE; Fri, 25 Sep 2026 08:57:14 +0200 (CEST)
Date: Fri, 25 Sep 2026 08:57:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: "Ing. Alfonso Kuen Arroyo" <gerencia@idkmanager.com>, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet-tcp: fix stale comment on NVMET_TCP_MAXH2CDATA
Message-ID: <20260925065714.GA4457@lst.de>
References: <179013720383.9364.11263428288753603011@idkmanager.com> <DLMIXHATYR90.4RUG08AMWH8U@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLMIXHATYR90.4RUG08AMWH8U@arkamax.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_235723_273052_2200BE88 
X-CRM114-Status: GOOD (  18.96  )
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

On Wed, Sep 23, 2026 at 09:39:59AM +0200, Maurizio Lombardi wrote:
> On Wed Sep 23, 2026 at 6:20 AM CEST, Ing. Alfonso Kuen Arroyo wrote:
> > The constant is 0x400000, 4 MiB, but the comment next to it said 16M.
> > Use SZ_4M instead of a value and a comment that can drift out of sync
> > with each other, as suggested by Christoph Hellwig.
> >
> > Noticed by Maurizio Lombardi while reviewing "nvmet-tcp: report a
> > bounded MDTS instead of "no limit"".
> >
> > v2: use SZ_4M instead of the raw hex value + comment (Christoph
> >     Hellwig). The file did not pull in linux/sizes.h yet and had no
> >     other SZ_ user, so the include is added.
> 
> version differences should be put after the '---' separator, they are
> not part of the commit message
> 
> >
> > Signed-off-by: Alfonso Kuen
> 
> The mail is missing, this should be:
> Signed-off-by: Alfonso Kuen <gerencia@idkmanager.com>

Agreed on both.  Otherwise this looks great, thanks.


