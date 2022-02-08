Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF260C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 14:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cp7qWZS5b024bfCjBCSX/ISvhfQqX9tPGIj99kqA3fY=; b=ihzHO50+VVWyGyocGPFEcV5HTy
	G6VnzO0BoUCsB9figH/Ee8zY6cGnH1SPjv3H4y5ZOY0bxprzKxfsAX2+FjUaKKOKVklfleBlDaPSF
	k62LTlrq4RF8x4Vpg/D6VhRVCt8vHZNF6CBS1VOFhV82N/50NspVx/eBgWRq56BlaMDW/JWf/V/xO
	53JjVX6Js8cfB/VQKsOECKvhc2uXYVveROTiPEBctwudhupoHUfryiT7qF3S2hYRJwLvnNt57UoWz
	eOY4o94La70yoPymNoTRpqdkvcVUzHyDuu/aEvzLGqz+8Zl6XbLh8oECfrqnsNrGHuxgbOQUj3ssC
	wjlHaIfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHRd7-00EI8z-Vg; Tue, 08 Feb 2022 14:38:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHRd1-00EI88-Eu
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 14:38:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CBA8768AFE; Tue,  8 Feb 2022 15:37:51 +0100 (CET)
Date: Tue, 8 Feb 2022 15:37:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220208143751.GA25260@lst.de>
References: <20220201165006.3074615-1-kbusch@kernel.org>
 <20220202075502.GA18474@lst.de>
 <20220202160334.GB3077632@dhcp-10-100-145-180.wdc.com>
 <20220204071012.GA28638@lst.de>
 <20220207160655.GB635727@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207160655.GB635727@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_063759_668794_1E08095A 
X-CRM114-Status: GOOD (  17.66  )
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

On Mon, Feb 07, 2022 at 08:06:55AM -0800, Keith Busch wrote:
> > I'd really prefer to sort this out at the platform level.  We can't work
> > around broken platforms in nvme forever.
> 
> I agree, but I'm not sure how to get everyone aligned.
> 
> How about this to resolve the regressions: if the platform doesn't
> provide StorageD3Enable property, can we just default to the simple
> shutdown method? We'd only use the nvme power management capabilities if
> the platform explicity says it doesn't want D3, making the default the
> same as the legacy behavior.

I don't think this will work, as most older platforms just won't have
that attribute at all, and non-ACPI platforms most certainly won't have
it.  We'll need more quirks in the core PCI/PM code like we did for the
AMD mobile platforms.

