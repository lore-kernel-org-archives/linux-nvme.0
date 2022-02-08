Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE495C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9wv+yUlyFy0QmdT3W9fSYH0X7UD+WhJiqMIMWpV4GQ=; b=INGe6vAi5gEFmA3gMDr/mkWK/4
	26J+TZi6dkSGTv+/yzd02UEjDWPHnT1vMSUXkzc0tV8wt3f4nnzxmZeR4El3C3KpyNERxbaIPSoKw
	cJ+qex5rPnWxD3FtoGyXwrCIvLUg/hay+gjaN+8KPFT0QT4kwuL/OGGOtatSC5gTscVQF5eMvUEd2
	LO8ykXB3jxx2RvVz+lLBURhG5gVLZQux+cDpxflxPGSttsIOgZ+6WO+cPzrOeTKEpZpmgOSrdKtyP
	Kf8T1fy40qrnGq4l3452syPXIo7PF1ED5DoyOOa4ZLvykWO+Yl1pTunlAeq7a3Ozik3Y/gp2WaEDE
	w7PwJZog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHU4R-00F1gW-DZ; Tue, 08 Feb 2022 17:14:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHU4P-00F1g7-7P
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 17:14:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3EEFD61629;
 Tue,  8 Feb 2022 17:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473BDC004E1;
 Tue,  8 Feb 2022 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644340463;
 bh=s+gEO4eNmt91N+r+Lnp4jjYar7PWUjtTYra5wDXpsmk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RyrJ9s4G4xEgrjbkFmNSW2M2YlTyEstSK8CbfeH8PKweztVUt4umZ8VdZ69XEC3rg
 GS5V0UZJYAd5486jVpPEAS/oQ0hrl/rkfl0vf5J9U+Ro4UfgplMwTUf0+JF8VoAJNm
 XA5ipD8bnBvGOshGQNlQVicp5XiT0Be+FaF2IjOWdgbIYKuLre0qlqovpwf8SrhUc/
 7NcvQtsboBGwPei3W78Nu6kjvemCARJevAO9q/wVcXvddW+fcyiGRJ7eCkhk8Nv2t5
 kfO+nkpPzYurpHzjKUgVa3V3gNaDnFZbrXr5F9Qd2Hhlny36h2H6rhPWaGHFG5gQA/
 i53B7PPpbsNOg==
Date: Tue, 8 Feb 2022 09:14:21 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220208171421.GA1168214@dhcp-10-100-145-180.wdc.com>
References: <20220201165006.3074615-1-kbusch@kernel.org>
 <20220202075502.GA18474@lst.de>
 <20220202160334.GB3077632@dhcp-10-100-145-180.wdc.com>
 <20220204071012.GA28638@lst.de>
 <20220207160655.GB635727@dhcp-10-100-145-180.wdc.com>
 <20220208143751.GA25260@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208143751.GA25260@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_091425_345619_45AFCD93 
X-CRM114-Status: GOOD (  20.80  )
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

On Tue, Feb 08, 2022 at 03:37:51PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 07, 2022 at 08:06:55AM -0800, Keith Busch wrote:
> > > I'd really prefer to sort this out at the platform level.  We can't work
> > > around broken platforms in nvme forever.
> > 
> > I agree, but I'm not sure how to get everyone aligned.
> > 
> > How about this to resolve the regressions: if the platform doesn't
> > provide StorageD3Enable property, can we just default to the simple
> > shutdown method? We'd only use the nvme power management capabilities if
> > the platform explicity says it doesn't want D3, making the default the
> > same as the legacy behavior.
> 
> I don't think this will work, as most older platforms just won't have
> that attribute at all, and non-ACPI platforms most certainly won't have
> it.  We'll need more quirks in the core PCI/PM code like we did for the
> AMD mobile platforms.

 old platform + old kernel -> simple suspend

 old platform + new kernel -> nvme pm

This inevitably introduced regressions. Why should we need to quirk old
platforms for a feature that didn't even exist when they were made?
Shouldn't the quirk be the other way around?

