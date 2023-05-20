Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20EEC77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 04:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hGOFNGYCeYwI0lunVJB1W2R0F53UNE3eb85hS9nFVuM=; b=rXxEkmqnwRHwzl5SETCH2jspwj
	3v++olzCTEg++3ZztTiKsZH+dx4CdND8oduUciA6+m3maqpvtUvXY372F+gTE8viDpHlN+X4Soo8v
	RuD1H+K7AORqfh3sRB0yrjPdRNGjusz3U6IfxWGF0sr84pHOX57IvTdzOmQ5gzYhHm2f/Q9+BmB+Q
	lR3oRwLlMsUHho0L/noc4nkgNYGIZuRw2UIHPlGq7iA9Jvc1rnnDk4MZTURI3XPBeiHCTaPOTfL2v
	KdbX5+0UFcYwz2GUzKED9H5nT9O7PMSMQzgha1yEiBcNC8QIS5ikq9hp/D9drLUIdD4nyVvyYhRqO
	MNJHZl7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0E8g-000euC-1f;
	Sat, 20 May 2023 04:24:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0E8e-000etM-0A
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 04:24:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F7CE68CFE; Sat, 20 May 2023 06:24:13 +0200 (CEST)
Date: Sat, 20 May 2023 06:24:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Irvin Cote <irvincoteg@gmail.com>, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-core: remove redundant condition in
 nvme_ns_head_multipath
Message-ID: <20230520042413.GB31780@lst.de>
References: <20230518221054.56378-1-irvincoteg@gmail.com> <20230518221054.56378-2-irvincoteg@gmail.com> <147b8893-10cd-27dd-eb48-3a5128de8f5d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <147b8893-10cd-27dd-eb48-3a5128de8f5d@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_212416_236546_2DCA1F57 
X-CRM114-Status: GOOD (  11.49  )
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

On Thu, May 18, 2023 at 08:12:23PM -0600, Jens Axboe wrote:
> >  static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
> >  {
> > -	return IS_ENABLED(CONFIG_NVME_MULTIPATH) && head->disk;
> > +	return head->disk;
> >  }
> 
> Might not matter for this case, but this changes something that'd
> compile away for !CONFIG_NVME_MULTIPATH to now needing to read
> disk->head instead. That doesn't seem like a good change.

Exactly.  That's the reason why this helper and check exist.

