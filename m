Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18D3C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tx0uhCFDY2/OcowhcJqCjNYn2i4RGqrvQjwqliEnIPo=; b=UBjSKizicAF7Dp8Swxub/YLOy9
	RqPg3TnEI3hbkHENRkwyTK3nKR0+1DKAqqOWXZCbbGBGEeZxkF5Q8B5b7CLH7g6ziKlRAL6HaX7id
	P3kxK7DykdT9b9/SgZa2spkGqghKjtVosBGO+CRx/nCmNf+L2sED12MWl82DE5EIp4KwsgR9r7+b4
	QPW0sxy5S4auz41SUwVRmBlX0BqTTYDe8M8ODbyJ5W3KPctj2VW1PECl9vUjCi5/GmmeIF1UB8X96
	wBLbLzT024uj+YyCy6KhHMiEHa8gvMg35w9F5CO/jLbACqN2QCDIL41yY4CvJ2mFfzTe97Frr/YHS
	KLbu74rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGIM0-002nqe-0q;
	Thu, 21 Dec 2023 12:40:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGILx-002npu-1N
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 12:40:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74E8868B05; Thu, 21 Dec 2023 13:40:35 +0100 (CET)
Date: Thu, 21 Dec 2023 13:40:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, marcan@marcan.st, sven@svenpeter.dev,
	kbusch@kernel.org, axboe@kernel.dk, james.smart@broadcom.com,
	alyssa@rosenzweig.io, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org, kch@nvidia.com
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Message-ID: <20231221124034.GA21682@lst.de>
References: <20231221084853.1175482-1-hch@lst.de> <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me> <20231221121746.GA17956@lst.de> <b4cee1fc-f115-40d6-9a16-3cb00691b98c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4cee1fc-f115-40d6-9a16-3cb00691b98c@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_044041_605477_317B017E 
X-CRM114-Status: GOOD (  11.27  )
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

On Thu, Dec 21, 2023 at 02:32:35PM +0200, Sagi Grimberg wrote:
> Exactly because its odd. Unless there is any benefit of using sgls in
> admin commands lets not flag it per transport.

The other transports always and unconditionally use SGLs anyway.  With
the virt boundary we're just adding extra checks to fail certain
passthrough admin commands (the kernel will never generate those cases).

