Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411A0C07E9D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKhpbCPeH5MLBQY101+PTVXam1b8J9RE+nxEuQcLsKU=; b=ROErxBizfNerpReKqYb9U18D5I
	7CSfLKAYNCN9UDemf8X3HtqoprzJ7vBCpAsxPfG4qSoufv0g8Vy0qUmqdXWmjcTt+bfRB53iH7P+s
	orlrdIz7BW3/jXuIrmMhw+6i71jlVx9xe/1Xj+ZOlK8PNyIZ8cpyzZV4D96GcejRuAKYPT558DwWl
	ZEv0Bg5gZycp6z3FeAZCCfLje8zxKcg8OSKy7FRzj978fAgcTTDpL+ZUoWCMvUiVctMdFY3M2LGe3
	X1HdJI+C4TTwIL9CaEmDinwJlrzrFVfLB6O6xp1Snv9eaHkRElj0BOhz3pEI5Kh1QsuASbJRRBAWK
	6d3Xzgxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocqmk-005qfh-87; Mon, 26 Sep 2022 16:16:46 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocqmi-005qf3-E0
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 16:16:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D7D9EB80AE2;
	Mon, 26 Sep 2022 16:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F290C433D7;
	Mon, 26 Sep 2022 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664208999;
	bh=T/7+/g2x34GmooDLA4SqsGYXTN4EyQUnLOW/YHHUqvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FySrRr7DAbkSYNPovyJvyFIVSJNwFQFPSdA5logehP9FMS77D/5Qr6MPT+hnwQQUj
	 co8iJwuUkbA9ePYqyOSkhWWnCtJ03R1uIVw0F8cEPTxqNAZkR1G/WDV/sEhJETklek
	 WO9mv95GzW9NBrY7JCs24yydX6NBJs2D9k0oo9wiiYCbjsPmh/kvy8f7ibhFdQoulb
	 e1g0ug8mbuJT+HfR0SAttudDS5UWxcYpN59lGnwB4eMEGeaOSMWqKM8um+t3vOdxr7
	 8RighctQ4dVRdkf80pOFKxR/HmdhCYopwbhWp5Tw5jcIDXCLxbayRNZBxXUKSqskPA
	 ZjzTV9ieljudQ==
Date: Mon, 26 Sep 2022 10:16:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	javier.gonz@samsung.com
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <YzHQZO/SPOIln/Tu@kbusch-mbp.dhcp.thefacebook.com>
References: <20220909163307.30150-1-joshi.k@samsung.com>
 <CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
 <20220909163307.30150-2-joshi.k@samsung.com>
 <20220918161917.mrfruzz4zd44kreu@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918161917.mrfruzz4zd44kreu@localhost>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_091644_662871_291E0DCD 
X-CRM114-Status: GOOD (  13.42  )
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

On Sun, Sep 18, 2022 at 06:19:17PM +0200, Joel Granados wrote:
> On Fri, Sep 09, 2022 at 10:03:06PM +0530, Kanchan Joshi wrote:
> >  
> > +bool nvme_io_cmd_allowed(u8 opcode, fmode_t mode)
> > +{
> > +	/* allow write/read based on what was allowed for open */
> > +	/* TBD: try to use nvme_is_write() here */
> > +	if (opcode & 1)
> I know that this is an RFC, but this would eventually be nvme_cmd_write
> instead of 1.
> right?

'1' is the data direction bit of the opcdoe, and nvme_cmd_write is just an
opcode that happens to also be '1'.

