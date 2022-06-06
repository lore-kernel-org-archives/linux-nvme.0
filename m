Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873CFC43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7DktwLMmJz51uzGQWY5W75c4BoGr4wmQGiMJ9197ccQ=; b=zGKqSpOIpe1KSYggDqXgt6E+N1
	XkJ4gfA/SJMOwxrutVY0MMFa6zANN6SON+QWTzdoZuUcY/tt/tM7d69c5mvOpxuhsq588Pt0tkgAK
	UXQyTh3cWvedsQpi6s2HqdeIYGc3cFxZysuQYylBGgLXqx9Q7SGErEs56EoUJ9K4MUwlFliVm63fa
	DC15HL/Pa8WM5E+oeQc3p2TFU7HJ/tlFwrY95sqWovKk+yFZ/clNNeh8w8TAzY1E/lFKGVJkm59HR
	QWQWqt+9qxfWIIwNXAiffNmbBL1yDiglciA37yfQ9af1ARlx5j3YCBJYfGX7tsF5LRB9CCX1/SJ5Z
	oETS7IRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyE56-001bQw-JS; Mon, 06 Jun 2022 14:51:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyE4x-001bPF-AT
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 14:51:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0D579614BC;
	Mon,  6 Jun 2022 14:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1E1C34115;
	Mon,  6 Jun 2022 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654527097;
	bh=S0aBAef3fkNdG+bNj/a8vucawc0whIheUXzkEr8OCYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cv8CWJYXlaCGlM/UxtCVVtT13QYfV2Ya0YYtVRSBKcYr5n/I+kV20lWWfKQSubhht
	 bUZF7mkMe4DhmlgwT5ZIrQ6GMfPZpJFWyzF5pY0blirOduJ+jO4qGbudENh+A+LMS/
	 EYUhxzqj7SI4m5QUds6eB8+DiLeA/yIDbbpJNeYM2CXq+YkLeqo7xg/EVB8lx06uHv
	 0Je23XdnuQRoxGvpqkwCneB0cav3g+uru2dyB7xYW7gikqwLuoE2lcK9eSc4ecE7AR
	 u3nZjlwbW5DRemXaBWow9vq9JTndXKu1JjIHsniNYVH1WOfA+I8eQIk6GMpM70Jju+
	 i1Z0cFm5E9nvg==
Date: Mon, 6 Jun 2022 08:51:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stefan <stefan@pimaker.at>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <Yp4UdgApXyWTn6lm@kbusch-mbp.dhcp.thefacebook.com>
References: <6d463ee2-62d6-e36c-7059-af7fbf8639c8@pimaker.at>
 <20220606064055.GA2450@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606064055.GA2450@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_075139_438873_9719706D 
X-CRM114-Status: GOOD (  20.66  )
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

On Mon, Jun 06, 2022 at 08:40:55AM +0200, Christoph Hellwig wrote:
> On Sun, Jun 05, 2022 at 01:58:07AM +0000, Stefan wrote:
> > Ran into a boot failure on my workstation today and I traced it to this
> > commit, reverting it on v5.18.1 makes it work. Quad-nvme boot raid.
> > 
> > I saw some follow-ups adding quirks, so I added NVME_QUIRK_BOGUS_NID to my
> > drives (1cc1:5350 for reference) and that worked too - if this is ok for an
> > actual patch let me know.
> 
> Yes, please send the patch, the controller reports a non-uniqueue EUI64,
> the rest seems to be not reported at all and thus actually ok.

I am unable to reply to Stefan for some bizarre gpg issues...

But just fyi, this sounds like the same issue as the phison controller from a
different brand reported below, so it sounds more widespread than just this
particular adata model.

  https://bugzilla.kernel.org/show_bug.cgi?id=216049

The reported didn't provide the device id, though, so we don't have a viable
patch for that product just yet. Perhaps we could add the vid:did to some of
the messages to help shorten the report-quirk cycle.

