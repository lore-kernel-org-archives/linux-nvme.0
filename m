Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0595BCD5BC0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CTW4q8fTPbqcgNmx04tkXqZ20YCrEoBS9IH8kvn93k=; b=TdbckIolnfx1G4tVb/oVx+1unt
	Aki2b1FT1sfD/nE4S/Qz2qvWmndAlpIz2Tl3WfSW2CQVbVtGSKvFAiU4jUkqzsfnX0tWX/N//oyiv
	dtFidAyJNG68QlNoxWJc+69XeIxLbwIlKCt+xsOtb3FvexnjK1TetrD9iAaP1PrzSHzbVK4eF37pC
	kYMaf9cvyd9d1M4tHdELM09dzpykM0KQr1hVDxN88bvWAJsJ2Ki+lEnYT3azADLaiPx/ckjJ/80bq
	y/Ao7CGvvgIqZyghwapefEMlaw/8iT6c6pV5C05EKdUvw66YPwjdRejfuiS+g5Ah4gQgyb3KqRdr1
	H/zLAznw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPqn-0000000GXc8-3CtR;
	Mon, 25 May 2026 07:35:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRPql-0000000GXau-3yqU
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 07:35:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E30668B05; Mon, 25 May 2026 09:35:44 +0200 (CEST)
Date: Mon, 25 May 2026 09:35:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block, nvme: export and use passthrough stats
Message-ID: <20260525073544.GB5305@lst.de>
References: <20260522151537.1509784-1-kbusch@meta.com> <20260525073219.GA5305@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525073219.GA5305@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_003548_131937_14C5BAD6 
X-CRM114-Status: GOOD (  15.24  )
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

On Mon, May 25, 2026 at 09:32:19AM +0200, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 08:15:37AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > So stacking drivers can also report passthrough workloads through
> > iostat.
> 
> Except that this patch also wires it up in nvme.  So please split
> it and write proper commit messages for both parts.

.. and while we're at it - it actually is called from the lower nvme
drivers, just conditional on being a mpath request.  So this is
in many ways a bit weird, and the comments / commit logs should
probably explain it a bit.


