Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DA3C282EC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IjOh92ttxTznBzh5AsV7MWfBFmP+Gh5SZdFe1e+Fbc8=; b=y1L9P2ux+nJWl22LHzl4RlK+mk
	pXToS1KOKB3Dl+SivLLFgmlfYtkFOuVKjerXgEYxMXfq6rae+zR57hNL11jD3MsFZwwFin6wbK6kJ
	NvhL/MwD1qTOkry4n7QU6SglH1+bNS88kZZJ/i2LnRcgzUSx2cMbG5ixwk4c93YMvK4vNKFoMYu3+
	7o/iSa6cDH4Ma/0WpwTLVGXFrcxoF0TjVjMGQ48CHBxD4Wf+ZA93T5igtPkxMAGccM+IYeI3dvOgb
	V+RPq8VjoEQS8wfoFtOpokHjFvgGAcVp0ggRz3obsI6IPSeXug32+GR73M1GREWi79MzjSzYW/ti9
	i95TAibQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trgeq-00000003Sfi-2bse;
	Mon, 10 Mar 2025 17:11:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trgSt-00000003QMU-0jPB
	for linux-nvme@bombadil.infradead.org;
	Mon, 10 Mar 2025 16:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IjOh92ttxTznBzh5AsV7MWfBFmP+Gh5SZdFe1e+Fbc8=; b=QTsTRewzvSD3yCbRvdqTDKJK0I
	DshTDZVLaNGS2zbOTO+gHafKCW0mR0D78PerZf+SowpAVL6n863HRMZnb9xEGe78y3Kc0cHACT5MF
	/gr7zqug1/HK9enhjho12x75tN0JRW77+IN6S2O1rPQaInkPhiwYRtgQmMnSzHF7EAy26mNWmnrjX
	s7/o5ZtN92y5LT3pwPM9uSN1qooXIkaxDr7QXpcZq3z048sVfJbMCCNThvSCTgdw5X2JQFew9uAZi
	Z8okITh4A+xxZraxJ2noNwUAIs0mpW56bNgReh2IlDzl0gP5RuYJjL91P+soo81Wo1V226w0c7kTx
	3OlXlExg==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trgSq-00000001xPT-14Vw
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 16:58:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3ED845C65F1;
	Mon, 10 Mar 2025 16:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB80C4CEE5;
	Mon, 10 Mar 2025 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625928;
	bh=gvhMWpgJECBLHsa0YvEDKB3j74g+sYRpOsZes8lhFSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nn/FsdnMWtQHyQkBm865Z5IwjtHEWL++FITXB23XyTxfqsbzkgxCXekJixoYYvptL
	 dVnZnNrr0fMKK4ULJw9U0SmQpESabuSg1ug9Hi3hI9C0qOZ1IndkCMcPRBcrrd8agS
	 2MNvg0TmYFz1nNCRBzM1f7NV07MkVL20Xs397bVQ5WNuhPClx1LvobQy0LpsSzLc4z
	 oyTgWh6MLfxp6Ot1cTo76QFvES6lP9V7NBRE5bL0bcn3WaUtFnghvnohABg8XALPO7
	 vUBDsIxSvsyQo226KATJjUNpz7crRZk9Fu8AR9rXnd2msbNdjd1gFFRD/wf/IJYDfp
	 8PZLGeiIz5uEQ==
Date: Mon, 10 Mar 2025 10:58:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jianlin Lv <iecedge@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jianlv@ebay.com
Subject: Re: [PATCH] nvme-pci: Remove NVME_QUIRK_BOGUS_NID for device vendors
Message-ID: <Z88aRU7Bq3SYtyyO@kbusch-mbp>
References: <20250308141102.34101-1-iecedge@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308141102.34101-1-iecedge@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_165852_529796_5A2839AC 
X-CRM114-Status: GOOD (  12.09  )
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

On Sat, Mar 08, 2025 at 10:11:02PM +0800, Jianlin Lv wrote:
> After commit ac522fc6c316 ("nvme: don't reject probe due to duplicate IDs
> for single-ported PCIe devices") merged, vendors no longer need to use
> quirks in the PCI ID entry to work around the issue of duplicate IDs.
> The NVME_QUIRK_BOGUS_NID flag changes the format of device attribute file
> names under /dev/disk/by-id/.
> For example, /dev/disk/by-id/nvme-eui.xxx -> /dev/disk/by-id/nvme-nvme.xxx.
> 
> Considering that naming formats need to have high stability and
> recognizability, it is more prudent to make changes only for rare,
> sporadic cases rather than implementing comprehensive changes. Therefore,
> this patch remove default setting of NVME_QUIRK_BOGUS_NID flag for vendors,
> and the flag is added dynamically only when duplicate IDs is detected,
> as implemented in ac522fc6c3165f.

Setting the quirk on demand lets the first scanned namespace export the
"unique" identifiers as their own. Scanning isn't deterministic if you
have more than one, so you wouldn't readily know which actual namespace
a particular /dev/disk/by-id/ link points to.

