Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F1BC83000
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 06:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xE0j9n72gctkZuppa2bHDilGxHLRS9I8mZtoIfCbiws=; b=zJIMMVCAoFa2lKnRbdXXaI/JOl
	EoVyBwXUVqMK1TvjccR15h2PEdzPTxUam9NT5OmtmQrxA2tWh8BE4CwbqfB0m5qkutRS4WRBQ4O1p
	aP6oherCujWipi8t/n6FVPS5SnuYjNgjRCsBfEjEI9PQWIEOfCaTDj9naeCXrr6OyTTQDUObi7GmV
	WQP1wSwsqbw1sz2pYma1KFgPD90fgYIlljY7xrfal40lDA6Vn/5BwkpxLVVytOfbIxzGLS+MrYfh5
	EoESQKOs4iJ00cNj2uf39rfMmQr2KsKTuYhkBn85wPevZuTPI0cRDNoR1DEakBIsR9+HHgKNpI6dw
	pWlVzD2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW87C-00000001LYT-1UJ3;
	Mon, 30 Jun 2025 06:35:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW87A-00000001LXz-0VOl
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 06:35:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C814268C4E; Mon, 30 Jun 2025 08:35:36 +0200 (CEST)
Date: Mon, 30 Jun 2025 08:35:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, darren.kenny@oracle.com
Subject: Re: [PATCH RESEND] nvme: Fix incorrect cdw15 value in passthru
 error logging
Message-ID: <20250630063536.GA29624@lst.de>
References: <20250628181234.3978844-1-alok.a.tiwari@oracle.com> <20250630063430.GA29582@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630063430.GA29582@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250629_233540_300964_46B2D77F 
X-CRM114-Status: GOOD (  11.98  )
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

On Mon, Jun 30, 2025 at 08:34:30AM +0200, Christoph Hellwig wrote:
> I fixed up the commit message to include a Fixes tag and drop the
> mailing list reference.

Please ignore this, it was meant for another patch I applied.

