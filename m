Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22474C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qomsvM6yvtBxFTmtAhVJvKsmbyIrBiZbVGfZIqbKzy4=; b=p54zken3e3QY6uEn1YLoHRNkSD
	heOl4V3WY0+xXKdHkr70VP/N/4Rf+u9HioXxuY/JLkpjZfpCIpxqM2sqzt9kN1S/EGEZA/DGgeGVA
	A65FlNDa7XMDP3apfrOj5BJ2nhy2Ot9rWtL2Xv8qxM4kWglUn5gYOYWDk8wjAFbKJlrmJFeFG/4BA
	Ok9x8ECf/vVaEAlKSYbUsoNc9qybjVyyh+a9jhd5vlP2gYpgx7t18aRtpiQs201/veDhUODBoEmAd
	CBlbW568fjHilsRS9EnUcJLY8yOG23kmCgh43BNdn6Ns+oHnSWsExUcFC/61PViKeaK3xnmI8NDpj
	abuxvHVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAz8r-00BI0H-1g;
	Wed, 06 Dec 2023 21:09:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAz8p-00BHyc-0y
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 21:09:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7015561E90;
	Wed,  6 Dec 2023 21:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F45C433C9;
	Wed,  6 Dec 2023 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701896950;
	bh=JuJgyMldVXzQChTKlWDXxmWauy6oPTyPDFAKlAkaknE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gi4LqhbyIWvY2yR0AzEIKyQjn3gXERvoRS5MMOHiszRHBwLlagGu4F2vjPH4bzTwh
	 7HFtxRxLN+ATqglH+lSvtH7FF6vF5l7qRoT+M1ozYM0z4o7ll3u364i/UpM9HRc3sq
	 XGs4MiMDVG+QEN6JTuq1Rd3591nTJ8j/y9da2fCpl33qm7YxBuTY/E81sOpnp1D1MI
	 MChBxxZmBMJPLkhF8SAF1oes4YBkpvC3OoSzCXhxhmx9hTsRc27JCAjrbbcfO44R9j
	 /z2XbS1N6HddRc64oJIL9RR3MaqYySMCtq0qVpVdCFGrP27Tq8n59EDkCFuMG2jq1b
	 KqZkiZWx9dg9g==
Date: Wed, 6 Dec 2023 14:09:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, asml.silence@gmail.com
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZXDi89EjHYYGK8JO@kbusch-mbp>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <CGME20231204180804epcas5p30002c71ae22125ae84549258d1cf6fe5@epcas5p3.samsung.com>
 <a387fd6a-7d4c-49e0-bb89-be129b10781c@kernel.dk>
 <4cc1ba06-ecfd-b351-962e-27042767657e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc1ba06-ecfd-b351-962e-27042767657e@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_130911_402459_2082DAE1 
X-CRM114-Status: UNSURE (   6.59  )
X-CRM114-Notice: Please train this message.
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

On Tue, Dec 05, 2023 at 09:51:13PM +0530, Kanchan Joshi wrote:
> Does it sound any better if this 'super ring' type of ability is asked 
> explicitly by a setup flag say IORING_SETUP_CAPABLE_ONCE.

Just my opinion: that option sounds good!

