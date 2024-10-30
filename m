Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DA8D5CCB1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPAc4LNdaNZua/aqc9YfKFj5ODylECAL4/Crzpnrmfs=; b=eYg5D/ukHbF0plomSug3/4i6k3
	GuAT9rvnTqvqbkVcHr+Ds4ptyzIRY/MKjMKpfVq1LQj7g4BuT5frqzKIP5u2Q9qn1hsrdtgpwyK0V
	C/HdvjTBcEbiKfHugj4ZfUL3eF7lSK5eRIX/rfketGRJDmCOTkUyLMqhv+htUnnI5oQc24eajM70r
	zNaija/FkjH1nDGAxg2uEFBf8kwPjPUqRm1ABYN6nCgDLEgTuxcTqgGqRxpo5k4vWw50XDU40MTAW
	1MX3oM1ZqpwDWPRpGozZuTR07kODJLrkZ31Rmx2HUzYVjCNuKxar86LbvWyzSBVf/asN9WbZnIojR
	YPvSRpKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t69GQ-00000000aEa-2ik7;
	Wed, 30 Oct 2024 14:01:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t69GO-00000000aDk-1Bla
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 14:01:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E708AA4144A;
	Wed, 30 Oct 2024 13:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6BFC4CECE;
	Wed, 30 Oct 2024 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730296890;
	bh=6+7m6bYb0yRvXggvjkGS4Ftl7KoswgwqALAkltkMZJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hl/5rLSk8xUWrwa5SZ9zEWoxtXYayiw4h5biVEPfkCNe1PLnhhaIxlW7qoL1s8OvN
	 lD8SC4/7kV0u6BKKt+J0ggTHKjCaCm8kqrcnYoUE7uiI57FDwlBD9I9r+6tVFnJaHy
	 accUAztW4Uo0lmN3+gxRYD8e3vOMBeicVCSYnBAoriaqNy875wtOvS1h+3eQihnzX9
	 qntUNReqYZOF5Rgkm1bP4MmaSHEVtTgWRQDWG91zV6teHVvZrbgGBH0enCSv5vVvfg
	 ZTQpRNSdgz/X4yuQh0+r8lHIyn3krgUmFK36eScMwEq8FmIUj9krmQ+FapM4B1AAoO
	 mFvR+YY3QzoEQ==
Date: Wed, 30 Oct 2024 08:01:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <ZyI8N3HpC_2ffxsS@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20241016201337epcas5p33625af2c67f92092078b0b43874d67bd@epcas5p3.samsung.com>
 <20241016201309.1090320-1-kbusch@meta.com>
 <5220b70f-13e9-4f73-b611-97235db87ed5@samsung.com>
 <c156bc1f-da5c-4522-8e5d-b138a94cb7d2@kernel.dk>
 <75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75331d62-fb0b-41ef-9a47-2bbe78e09f9f@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_070132_410703_2945F33A 
X-CRM114-Status: GOOD (  11.38  )
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

On Wed, Oct 30, 2024 at 07:50:12AM -0600, Jens Axboe wrote:
> On 10/30/24 7:47 AM, Jens Axboe wrote:
> > On 10/30/24 7:38 AM, Kanchan Joshi wrote:
> >> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> >>
> >> Jens,
> >> Please see if this can be picked.
> >> Helps to reduce a dependency for io_uring metadata series.
> > 
> > Keith, is this queued in the nvme tree?
> 
> Doesn't look like it is, picked it up.

Thanks. It has block api changes, so I usually don't presume to apply
those patches through our nvme tree.

