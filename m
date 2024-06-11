Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFE6C27C75
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/bXA3P7iTatInll+gW19jPGyQ4oUqaUdkZA65RALAF0=; b=ntvtm7+abmvHUHGrL7IsE2k8ci
	9ogPvxnZXZeteZFgJxVDYsucSpygjYBkq0zSXzdHK0hLK3XHs88pbnmUgBgE95TQXRfkedjufd8KI
	tkcYnuVUAFpiX93PBDuP6AyYUmlZ59v0Obz9b3mK0wruoJajfgcVAu6vboLAdTUYB0apaRstrukp4
	iJyfzec5z8olC+brIGpR74M9rKgkLxyIGoTxDVYyWF19w06W4ViJ9C/wUAZvyaXnOHfZ7oMynaOM4
	rk0NtpUOdUyUuxVods0kY/5L0YZowqCcSxbpwmVBHCsLU6gWD2VeU6qXElMYrq4l9aip4NVT8jHQi
	QjdXfktw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5XL-00000009hqU-2LVK;
	Tue, 11 Jun 2024 17:43:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5XI-00000009hpW-0zcs
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 17:43:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 50C3F60DD6;
	Tue, 11 Jun 2024 17:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F091FC2BD10;
	Tue, 11 Jun 2024 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718127835;
	bh=ckh65J4ZDXHqdYOWkbEuepLYJ8V0wRSgS5E79Dm0Kh0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MZCADHuxHShUbBVFGWbK1LFY6Xly3X1ALb+w3ew3wgEVPn5hlI5LpwIdTlFdGkmNA
	 jwZd1dBoRsqeNJjnT62UUEta/+FCoagQLhxFEbAmzsFP6RYw/ZRaTU7l1VaPkHHkP5
	 hFNFY5eTFuvummQbOTC/a2oK57Xh89/imv3nzdEySQUbp7qKPwTD+DYb8YogYnOFK2
	 bO62meGPxxFLOm+XRGF+tMw4v9pMAG7Xwup3NmQzMwZGpC8v4f0A/iEO0kgaTxt6uy
	 NQUmLrJppLQ902+qbmi5qJ8XaS21Ac4eAn7aVy91wIWgUWHs/jz2G8ZkSybdPXwacK
	 dWnY5AMl8r3iA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BE64CE0991; Tue, 11 Jun 2024 10:43:54 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:43:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <5339a82f-33c0-445d-91be-1ab8d8f39dd4@paulmck-laptop>
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
 <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
 <20240611172448.GA13680@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611172448.GA13680@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_104356_416341_86D591F6 
X-CRM114-Status: GOOD (  25.65  )
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
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 11, 2024 at 07:24:48PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 11:22:04AM -0600, Keith Busch wrote:
> > > Is this actually valid for a (S)RCU protected list?  If the entry gets
> > > added to the new list before the grace period has completed, we could
> > > trick a concurrent traversal into following the new list unless I'm
> > > mistaken (although chances I'm mistaken on RCU corner cases aren't that
> > > low..).
> > 
> > Good call, you are absolutely right that a sync should happen between
> > the del and the add for readers to consistently iterate this list.
> > 
> > I might be able to weasel out of this though: our namespace list is
> > sorted, and this function wants to append everything from this element
> > all the way to the end to the "rm_list": a reader should get the same
> > result either way, whether if it was torn at this element or the move
> > happened without the reader seeing it.
> > 
> > Now if there was a way to rcu split the list so we don't have to do it
> > element by element...
> 
> Isn't that exactly what the list_splice helpers do?  We'd just need to
> do that exactly once at the cutoff point and not once per namespace.

Almost.  They move the whole list and Keith wants just part of it moved.
It should not be hard to create such a thing, and Keith said (offlist)
that he would like to give it a try.

							Thanx, Paul

