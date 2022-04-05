Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4197C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X2kLzyhPl7ocuIg09vZDmsAdE0WcEUYn3bQQ/6QsbCU=; b=KY91ERsaWDZuSzvcn/z5IVyFG8
	cA3qCGL0i5TjJuOt+dydydwu/J2ClFAna1Uv7sjAdwTyRL1qumWQiuBKhwJ0jWb4+qduUCR2Nr+Nf
	NNcPv6B/IkyBzKtZa1jF3tfgRtpuXoEWQG94h5tfY7BG+B7emV5yfYIWTC22j6pRl0Wk46PbuI6wk
	KltzuxU4+mTboh79/W2XnI3mu2yF3p7y/aCX5lq8ydhgSIsWmRCFHlTA1aifvCK7e9MyRoP7qHXyx
	/gQ5+qCpxn7qySUBmnE358Dr6A5ZRmfxIEJCKM6afj4zh6JfGQTA57eclRNyI4dmbRmEZPhLTGPfw
	6mKjQ8UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbdi8-00HZwb-7e; Tue, 05 Apr 2022 07:34:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbdf0-00HYIm-GI
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 07:31:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4782B68AFE; Tue,  5 Apr 2022 09:31:22 +0200 (CEST)
Date: Tue, 5 Apr 2022 09:31:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery
 log page for unique discover controller
Message-ID: <20220405073121.GA25524@lst.de>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
 <20220405061941.GA24290@lst.de>
 <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_003130_719251_C1CA0333 
X-CRM114-Status: GOOD (  12.78  )
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

So maybe we'll take a step and think about what we actually want
to support.  Here is my understanding, which might as well be incorrect
and/or incomplete.

 1) support a uniqueue discovery controller for bidirectional
    authentication to work properly

The only thing we really need is to have the existing discovery log for
the well known discovery subsystems to be able to also show up as a
unique discovery subsystem.  Either by just renaming it like your earlier
patch did, or by supporting an alternative name in addition to that.

 2) (optionally) make the well known discovery controller go away

Just renaming the subsystem will make the well known one go away,
but while that can be useful for some use cases, I think making it
always go away has the potential for breakage.  So maybe we need
to not rename but be able to create an alias and have a way to
disable the well known discovery controller if not used.

 3) Actually have a different content.

Can you explain the use cases here a bit more?

And maybe add anything else we'd like to consider.  (Everyone else
on the list please also chime in)

