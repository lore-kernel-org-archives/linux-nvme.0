Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A49D6C2AF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 22:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vd731iJDxBDGO7qcQ2DUvocBpFRluX1lID/nOikR0xQ=; b=jL9OBuTRWAIHr19nSdaRsO5rc9
	Wz/Qs8Jj9BXly0EluGYvDqyVDt1AHdORB3lwQP2RGMImiiHWntK2AgxfONIbIPkY5uGGrAF/OifbD
	00jiMSy2vT0c1AW5goPpxSSkos13e9QTen5KAMwh3WSEbl94WYQI8dMFlMPa1FYVdpNuOs1VozcXW
	U1zCGQf+QpzS9OHNoDo7NCFlvqhNuKqkh80skjgAg+YknoquEajZTkQyIzqGe/2WMYibrP7hioNjr
	c4a5enkWfJ2pxI4UxfARrz+IEsc4mAdG0ef/yeAwxgZNfkYRcTUbpySIvGsVZ6UPKWe1nnvpTxZrk
	+mczSVSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDX28-0000000DvLm-3tJj;
	Tue, 19 Nov 2024 22:49:20 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDX27-0000000DvLM-0YwP
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 22:49:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B3412A42980;
	Tue, 19 Nov 2024 22:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD82DC4CECF;
	Tue, 19 Nov 2024 22:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732056557;
	bh=da9J+92L3X12EP6GZGUAqszUOKZLRzsWW/faOD90Lhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQMYYfAvgBdeCX3/hPmuzjpTYLWV6cZlwiM+NkrUuDw11qmQJVftoDRGF+8WiAuPd
	 2MUbbSjfZ3JkSEYD02t6VkNyS4o0+G0Iu69z+h4Fb/R/QEme9n6tOqLymU6OJmIL1L
	 2EcOjQvM+6By+fq6prjX3SGHshpSCT86qrBmwr73sg1eFcCSlKYc2PARlcko3AssaE
	 XQQtkxykStWspXRy7UmNUb/UzQNL5U5hC9/5IA+8m48JjiokbdJ4XTn8+93yLpXTkk
	 5hSXLYvEdIzftE6p37qgfiAQXeYTSBysScW8nhxW6VpH3nvLeMizLivSCA3bwus0E7
	 qOptCU2Po2Cww==
Date: Tue, 19 Nov 2024 15:49:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>, Jan Kara <jack@suse.cz>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH 14/15] nvme: enable FDP support
Message-ID: <Zz0V6qv3oyKV_Kzp@kbusch-mbp.dhcp.thefacebook.com>
References: <20241119121632.1225556-1-hch@lst.de>
 <20241119121632.1225556-15-hch@lst.de>
 <ZzzWQFyq0Sv7cuHb@kbusch-mbp>
 <20241119182427.GA20997@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119182427.GA20997@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_144919_240913_1A734F1F 
X-CRM114-Status: GOOD (  16.03  )
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

On Tue, Nov 19, 2024 at 07:24:27PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 19, 2024 at 11:17:36AM -0700, Keith Busch wrote:
> > > +	if (le32_to_cpu(configs[result.fdpcidx].nrg) > 1) {
> > > +		dev_warn(ns->ctrl->device, "FDP NRG > 1 not supported\n");
> > 
> > Why not support multiple reclaim groups?
> 
> Can you come up with a sane API for that? 

Haven't really thought about it. If it's there, it's probably useful for
RU's that are not "Persistently Isolated". But let's not worry about it
now, we can just say you don't get to use write streams for these.

> And can you find devices in
> the wild that actually support it?

I haven't come across any, no.

But more about the return codes for pretty much all the errors here.
They'll prevent the namespace from being visible, but I think you just
want to set the limits to disable write streams instead. Otherwise it'd
be a regression since namespaces configured this way are currently
usable.

