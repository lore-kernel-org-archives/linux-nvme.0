Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2183AC433E1
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:41:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F0C20714
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ao4uXyTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F0C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5ArVdBCxIurRaks3cca0n7LeWRCWwJCLslgWBqtVsxs=; b=Ao4uXyTcshQSZhApxIz5l2KnX
	c3XrpAbNYoZw+TdZkmFfc6Mizihx/Vrdby9+NoKiNeBi3i34uR4hwnXK+0FtaOugFb5ILxAbeoYKr
	/diJ1ifjMS+8h/W9SwxFsqWt+TV0gtKOBHHz0SpzfMUcXYVihimdDMWbHnuZLbVLNdd9V/zZ2qVqB
	A3tqPaBFDa9p13ZHj/zGlQn2NY0XEHuP0XzgQ5B9T0B01wbYx70wmSX54vSmLZhabXXtLrHiYCXk+
	3MVbT8iKwvlG7wWzRDh4ntfx/QXvSRY1gD+q9jpqRHp4QiPmFbknJTvFsrjLcJyj3LrWZP1BijjWG
	RCeUBofxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzily-0000fQ-Gr; Sun, 26 Jul 2020 15:41:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzilv-0000f7-H8
 for linux-nvme@lists.infradead.org; Sun, 26 Jul 2020 15:41:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BDBB068B05; Sun, 26 Jul 2020 17:41:04 +0200 (CEST)
Date: Sun, 26 Jul 2020 17:41:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v16 6/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200726154104.GA23930@lst.de>
References: <20200724172520.16318-1-logang@deltatee.com>
 <20200724172520.16318-7-logang@deltatee.com>
 <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200726_114107_720853_C5FDC6BB 
X-CRM114-Status: GOOD (  16.04  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 24, 2020 at 12:33:51PM -0700, Keith Busch wrote:
> On Fri, Jul 24, 2020 at 11:25:17AM -0600, Logan Gunthorpe wrote:
> > +	/*
> > +	 * The passthru NVMe driver may have a limit on the number of segments
> > +	 * which depends on the host's memory fragementation. To solve this,
> > +	 * ensure mdts is limitted to the pages equal to the number of
> 
>                           limited

I've fixed this when applying.

> > +	/* don't support fuse commands */
> > +	id->fuses = 0;
> 
> If a host were to set a fuse, the target should return an Invalid Field
> error. Just to future-proof, rejecting commands with any flags set
> (other than SGL, which you handled in patch 1/9) is probably what should
> happen, like:
> 
> > +u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
> > +{
> 
> 	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
> 		return NVME_SC_INVALID_FIELD;
> 
> Or maybe we could obviate the need for 1/9 with something like:
> 
> 	req->cmd->common.flags &= ~NVME_CMD_SGL_ALL;
> 	if (req->cmd->common.flags)
> 		return NVME_SC_INVALID_FIELD;

We'll also need this for the admin commands, but otherwise this sounds
like a good idea.  For now I've applied the series as-is, but an
incremental patch for this would be nice.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
