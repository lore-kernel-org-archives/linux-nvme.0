Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61134C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 07:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x5j/j6JHqBhV0YBpBhQsmkWvXY2j88KFvqwyTe/YRz8=; b=HNfed2e6sEDMhAUsnYDbeo6dvI
	Khhp3a78ZrmbpJYRXCaygDJsVFfTQLktPu4Zb+vuesCVqPt+dmXZY1Myeor+m5g5iTKFbpJle2d/O
	YTwAsoM0E9xHH7Yh7ocoSkSLLQKNBMjHnXLtQTWzSNTk7IVwg/0tvHkZ/2BwvarxlNUXJmYDjyJ9n
	RuH3r1b5wyJ3VZyRogiI1c3JuHryj79evvn0GRam+NDhGa6pdWSoHt2PfXtGhzPqRzMgxmBNz18GF
	XDc4asuLfnhA5tW3RXlrOGCmZP/OZjcunMkSUdFb5z2d2rf1ZSqUy+Hk4bEwBXde6lz1N7owglOtS
	wuWNx/BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHhig-00GWlh-KJ; Wed, 09 Feb 2022 07:48:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHhid-00GWlN-Bt
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 07:48:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1C71668AFE; Wed,  9 Feb 2022 08:48:46 +0100 (CET)
Date: Wed, 9 Feb 2022 08:48:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220209074845.GA9540@lst.de>
References: <20220201165006.3074615-1-kbusch@kernel.org>
 <20220202075502.GA18474@lst.de>
 <20220202160334.GB3077632@dhcp-10-100-145-180.wdc.com>
 <20220204071012.GA28638@lst.de>
 <20220207160655.GB635727@dhcp-10-100-145-180.wdc.com>
 <20220208143751.GA25260@lst.de>
 <20220208171421.GA1168214@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208171421.GA1168214@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_234851_601748_C50268A3 
X-CRM114-Status: GOOD (  15.57  )
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

On Tue, Feb 08, 2022 at 09:14:21AM -0800, Keith Busch wrote:
> > I don't think this will work, as most older platforms just won't have
> > that attribute at all, and non-ACPI platforms most certainly won't have
> > it.  We'll need more quirks in the core PCI/PM code like we did for the
> > AMD mobile platforms.
> 
>  old platform + old kernel -> simple suspend
> 
>  old platform + new kernel -> nvme pm
> 
> This inevitably introduced regressions. Why should we need to quirk old
> platforms for a feature that didn't even exist when they were made?
> Shouldn't the quirk be the other way around?

Because they are broken?  If we do get a suspend request that does not
explicitly asks for the device do be disabled we need to be able to rely
on that.  Where we is not just nvme, but any driver.

