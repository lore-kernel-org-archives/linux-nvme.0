Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36A6C2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ehjLuXqFnajEAnMqYQbIbv7hqIOEL1lJlHHthV3xaH0=; b=BKe0LN6vaFK4n9Pp1z6PEcRuXS
	UVRrRA+VMW2hQfUxlMsEt4bNTBE35CVkm/Uw4hiCAk8bOemZDsCJwvWUSQ9liQlwWErdDi2rFpJ21
	LBdhKGh4yHQ1YnuOPaVT8r50Z1rrzXAsio0DVa1oTai/USXyxYSz4ciuub8W9FgnzcGSx8oyqwO6r
	vYxdKRjDXFDpEeDH2Mg65b6EoCkuOnpHYAmFgA9IWulNT2Z9bPxLBNOf8tmKK2E/Upbik4J0A+7QZ
	fVePXi3LkzIe9ds2PAurpdC/O11lLYeoWUIjcYZ8lWFigcTlD20SjOISPUeGqZDtC8MTQrIpeLZ+3
	rcTXRclA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1bM-0000000AcP5-2PVb;
	Wed, 03 Jul 2024 15:08:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP1bJ-0000000AcNq-2fQF
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 15:08:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB86268D0A; Wed,  3 Jul 2024 17:08:46 +0200 (CEST)
Date: Wed, 3 Jul 2024 17:08:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, bvanassche@acm.org,
	javier.gonz@samsung.com, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3] nvme: enable FDP support
Message-ID: <20240703150846.GA1028@lst.de>
References: <CGME20240702103348epcas5p1015eafbddf4795558843cd74b0453b12@epcas5p1.samsung.com> <20240702102619.164170-1-joshi.k@samsung.com> <20240702113954.GA15325@lst.de> <f79cc36c-cd03-bb5e-2eae-3612176a474e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79cc36c-cd03-bb5e-2eae-3612176a474e@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_080853_840444_2D9654B6 
X-CRM114-Status: GOOD (  13.53  )
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

On Wed, Jul 03, 2024 at 02:10:24PM +0530, Kanchan Joshi wrote:
> That was not the design goal of FDP. It is ludicrous for any storage 
> technology to have that as an intentional design choice.

I think you missed out on the development dramas.  The Meta
representative for what became FDP absoutely rejected any proposal to
make it useful just for that reason, and anyone outside a small
circle got explicitly excluded from the development for just this
reasons.  This is probably as much as I can say without getting in
trouble here, but I'm happy to provide more details in private.

> People need support for what we have in current spec and more 
> importantly in products. It's not a Meta/Samsung only thing. Many 
> hypsercalers and enterprise customers need this.

Then let's design something proper.  It's not that hard.  No one
needs to support anything, and between all the major design issues
in FDP and all the political crap thrown by Meta and Samsuns at the
interests of Linux there's no way I can support this.

