Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D1FC27C79
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jun 2024 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9gD0BW4PYyC6q11JW9+rvy3YDr3tCLx5+h6y7y2wSy0=; b=VJUHiC/7RdN7eHc8ITruxEuvHH
	3iP/Tij65pzQxcRMF14LStgYNoPMLm886y1mgPQ7R0B4uIzvVzEvL6z+6BeBB/vwOfPJVetuI7LFg
	urPkCQeFVWo8punjns7JAwRTEosdX7Yewmbg1MYimZ6Kc4wKv2Px7Nr9DJxyb/pCOGoCgTp8VE3DL
	RJpV9x7E4WBrne0CN9sGO4zg/KRHTHUnp0CXtynEsAnOjziG1iyJR0Rcc0Kvh9WMwwfNvGxdn/aiR
	q5Me0Mw8BsTAU9cbuxszQFvLRH55HSVblLtKwmpljr8D+QFT+lPd503w3RnhNwaVuhBNypJTZPv8v
	2irJN+vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJH2W-0000000C9zo-1adh;
	Mon, 17 Jun 2024 18:25:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJH2Q-0000000C9xf-19iI
	for linux-nvme@lists.infradead.org;
	Mon, 17 Jun 2024 18:25:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7A79561462;
	Mon, 17 Jun 2024 18:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C743AC3277B;
	Mon, 17 Jun 2024 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718648705;
	bh=7/AQgtSakvxJsoFB1zXH5OrpQ4h9ofFWZ5Z7vKtezpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/gbUHQcHic4V4eBg/C8OOdCv+gi//8lkX59yhFAuQOJcBVHqpN8bAD9VPFwUoPPv
	 qSjYd3owVdsiFb2rQPq06nm7W1tCwK9hEDuYfZVqKUjjPlL02QEPvUsSBVF6ergHCp
	 QWrydLRf2S9/N5jdMyBS3BwJxtpe4Hd7xR3td1PBTK0wUha50273OUvWSscF5HJYEg
	 02i1aaaI7V/oMfj0hkbNHEK0ap5uwqe7PAPDAYS5GcnQDvMAxsel7COHe1dbZt2v+C
	 vPniVeNeQRL5nK81zyJbU073bS3NueRShAMMrh6vhgrvdsfTAx7B3nTkmYrAvbxwVl
	 xUh7RxRcqNxeg==
Date: Mon, 17 Jun 2024 12:25:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Boyang Yu <yuboyang@dapustor.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix NVME_NS_DEAC may incorrectly identifying the
 disk as EXT_LBA.
Message-ID: <ZnB_fo-chyiCsvaL@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240617131354epcas5p189a78f2cedf7f3a3552df5e881e547c4@epcas5p1.samsung.com>
 <20240617131144.48955-1-yuboyang@dapustor.com>
 <90f3cedb-7553-9007-6ab1-38e1562c8f33@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f3cedb-7553-9007-6ab1-38e1562c8f33@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_112506_407640_FA5C71D1 
X-CRM114-Status: GOOD (  10.34  )
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

On Mon, Jun 17, 2024 at 08:00:00PM +0530, Kanchan Joshi wrote:
> On 6/17/2024 6:41 PM, Boyang Yu wrote:
> > The value of NVME_NS_DEAC is 3,
> > which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS.
> > 
> > Signed-off-by: Boyang Yu<yuboyang@dapustor.com>
> 
> Maybe this requires fixes tag [*].
> Looks good regardless.
> 
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> [*] 1b96f862eccc ("nvme: implement the DEAC bit for the Write Zeroes 
> command")

Yes, added the fixes tag to the change log to help stable-bot. Thanks,
applied to nvme-6.10.

