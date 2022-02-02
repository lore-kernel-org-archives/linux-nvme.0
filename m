Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B09C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6XkiH89BFAt4/492F9X++/706Zq2uZH5dDA8v0O/gg=; b=2gsFx6Duv7J+08zwja16mtcqoy
	VvazitmYlsLrM/QdTy6ddhFYhpUxNI+miNDqSRAE8rKgbRhF7ctZMBsdwQvnfSq8nSVwADIWh1GV5
	nOYRrfk9uZfTEwcuHxnl05EQEEQU0wKaLpzHrhMmkH6fQZbmCfoP6iefJSyFm5vXPlKnWH5QTAy1f
	yWRH5EvwHd3sHYLyTLW5rRTP5YxdHGHqLwPTh+dcRfUrq6Ymsk2fNY/FNcPGwH4/oCMnnadaGAwil
	q5xG3jksxg/Qe6rFgYBW2NU6secSjdGWFj/a1FBM54lqujS56EKaqTZa71TZGQ3d7dBQqMLPmh2A5
	2Z7xlOJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFIJ4-00GDtc-TB; Wed, 02 Feb 2022 16:16:31 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFI6e-00G8xT-AO
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 16:03:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0F597B831B4;
 Wed,  2 Feb 2022 16:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37661C004E1;
 Wed,  2 Feb 2022 16:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643817817;
 bh=zcm0wOCJqc/Eh8wkaaFERa8EhKfQ4Ow/MQdDAoMrTkM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PyR8AvGPI/FRxEqo96uue00SnCe+2s1Ua1clG2y1LDbKr2lwcXLV4LwPHT5E+Y2eN
 CWgxTOzpOrbU4jOYXupJpeNnltpdGKSRWtxp/1/sHuNEfpQYAjgDFwzgL2sOJIORVk
 oh34ie07BZDXhrmjX55uQkFF5Gx4mh6/jQ8tz4sTiEiTj6WinTbHsWTYq940zVmP+X
 1/+2XxEz/mrVF/iX3v5LKj3vDMJ4bCizFo2h9KXH56pkMvLg/KBXrHPeaLnNdUgkxn
 za1pKjJxQCBLpIuNxnyTRUj7NLbGY6O2onuEuGYly9aZiWZgjvopJOM+o1Gw91j+oT
 rrXDOxYfYpE9Q==
Date: Wed, 2 Feb 2022 08:03:34 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 Rafael Wysocki <rafael.j.wysocki@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] nvme/pci: default to simple suspend
Message-ID: <20220202160334.GB3077632@dhcp-10-100-145-180.wdc.com>
References: <20220201165006.3074615-1-kbusch@kernel.org>
 <20220202075502.GA18474@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202075502.GA18474@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_080340_544621_0F83EBCF 
X-CRM114-Status: GOOD (  20.19  )
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

On Wed, Feb 02, 2022 at 08:55:02AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 01, 2022 at 08:50:06AM -0800, Keith Busch wrote:
> > There is no complete set of attributes a driver can check to know if
> > nvme power management is the correct thing to do in a runtime suspend
> > situation. Every attempt so far to optimize idle power consumption and
> > resume latency for a particular platform just leads to regressions
> > elsewhere.
> > 
> > Default to the simple shutdown since it is the historically safest
> > option, and provide a user parameter to override it if the user knows
> > it's safe to use for their platform.
> 
> Sigh.  The platforms really should be asking for a explicit D3cold if
> they need one..

It's too late now, but perhaps the new property should have been
inverted since preparing for D3 was the previous default behavior;
platforms could have instead explicitly asked for "no-D3" if they wanted
it. That would have been easier for backward compatibility.

