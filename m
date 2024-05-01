Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F234AC10F1A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t22IjlAL6E7qJSKpHEFijZCdm52foYQyGWTpe9z1ucM=; b=vZTByVf6jLOMpDFuxxlj4IZ4XL
	IlLkzdvxMXC8gD6qCb81D6OlHSU4RfaRBLSO4o2YcBtovcfhaN9LkqqStc591zI/cZu9xLx1JwFZ/
	qbjJg0e1On+p9TUKbz5iEMwS6dPDKYFDDMzhmhqMDwKZLoZR7V1np//KcpDbxlZF2PbZ+K2TQ3GJb
	V3QDWtobjMbQ+MG6Q6LXaLTl9AU9nwwZKay5MXtwK3ML2bM/bJeqlmEoEE3zszk18ELkK61hZ4Z3K
	QCLELRxcT7HS8efqj/JTR/gFAOF6VdM/DfYF0J2Hb0Q5hwFGUPXlRP38B44FW7w7+Vm5QW5rhkpwj
	FOLyO9lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24fB-00000008m70-0x43;
	Wed, 01 May 2024 07:46:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s24f2-00000008m54-13TM
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 07:45:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1D9F227A87; Wed,  1 May 2024 09:45:45 +0200 (CEST)
Date: Wed, 1 May 2024 09:45:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, martin.petersen@oracle.com, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 01/10] block: set bip_vcnt correctly
Message-ID: <20240501074544.GA2325@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184651epcas5p3404f2390d6cf05148eb96e1af093e7bc@epcas5p3.samsung.com> <20240425183943.6319-2-joshi.k@samsung.com> <20240427070214.GA3873@lst.de> <Zi0I1Aa7mIJ9tOht@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi0I1Aa7mIJ9tOht@kbusch-mbp.mynextlight.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_004554_852455_1E99DEE6 
X-CRM114-Status: GOOD (  13.94  )
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

On Sat, Apr 27, 2024 at 08:16:52AM -0600, Keith Busch wrote:
> > Please add a Fixes tag and submit it separately from the features.
> > 
> > I'm actually kinda surprised the direct user mapping of integrity data
> > survived so far without this.
> 
> The only existing use case for user metadata is REQ_OP_DRV_IN/OUT, which
> never splits, so these initial fixes only really matter after this
> series adds new usage for generic READ/WRITE.

Well, it matters to keep our contract up, even if we're not hitting it.

And apparently another user just came out of the woods in dm land..

