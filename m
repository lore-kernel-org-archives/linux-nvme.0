Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831B6C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Feb 2022 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TfCPficEdFefhXJm1eKbYAz0frOjIg8qKGJkgKRklr4=; b=oT5iWK/4Sbi/39QUc3KkZ/DKPe
	yRneq8C03rb9XqHwOpMktpUGi9kww77Bh11FGxEtBakU3PNJmxoWfEnUe8bMJAQO/2py5Yf3a3pWq
	mvTr7sE8B4pvE5LY5/FQKZGnT+fl5xz9KEPdMyRj6P12ik6YmSxaoiJkYu+TNkoRquTfzTf6gx41x
	4JOFWPrfb3W1Mgj5kVPJKiLVp3OTFMMu5/w74mfNczTiRaYVG4LI6Iw49ZgmX2NLDha+o3/BVzTDn
	JmXlKSSeXQpcFebI6cvfFH5SnPB+UP14wXSs+vrntO+MkD6qfTd+9a8LpBeFZuazquABVf2vpA96A
	FVDI/YRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFsjb-003cVi-G7; Fri, 04 Feb 2022 07:10:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFsjY-003cUz-KV
 for linux-nvme@lists.infradead.org; Fri, 04 Feb 2022 07:10:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1407F68AFE; Fri,  4 Feb 2022 08:10:13 +0100 (CET)
Date: Fri, 4 Feb 2022 08:10:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220204071012.GA28638@lst.de>
References: <20220201165006.3074615-1-kbusch@kernel.org>
 <20220202075502.GA18474@lst.de>
 <20220202160334.GB3077632@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202160334.GB3077632@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_231016_850026_FC75BA93 
X-CRM114-Status: GOOD (  24.27  )
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

On Wed, Feb 02, 2022 at 08:03:34AM -0800, Keith Busch wrote:
> On Wed, Feb 02, 2022 at 08:55:02AM +0100, Christoph Hellwig wrote:
> > On Tue, Feb 01, 2022 at 08:50:06AM -0800, Keith Busch wrote:
> > > There is no complete set of attributes a driver can check to know if
> > > nvme power management is the correct thing to do in a runtime suspend
> > > situation. Every attempt so far to optimize idle power consumption and
> > > resume latency for a particular platform just leads to regressions
> > > elsewhere.
> > > 
> > > Default to the simple shutdown since it is the historically safest
> > > option, and provide a user parameter to override it if the user knows
> > > it's safe to use for their platform.
> > 
> > Sigh.  The platforms really should be asking for a explicit D3cold if
> > they need one..
> 
> It's too late now, but perhaps the new property should have been
> inverted since preparing for D3 was the previous default behavior;
> platforms could have instead explicitly asked for "no-D3" if they wanted
> it. That would have been easier for backward compatibility.

I'd really prefer to sort this out at the platform level.  We can't work
around broken platforms in nvme forever.

