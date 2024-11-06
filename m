Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B97AD1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/UceqE4yzTQxm2TJ7m4vwSfp/qzBUbHsCyFtdUXlKoU=; b=SQ6mfTVQsWaAEmx64cHO+8YajB
	WdP45r3N6+BrZqkQIJzCfoMaqreP9jlah9mMB9nI2rFNUY2TB01WuhJhvXtCs3nvJmaW5NinRrwUV
	BoljVTsst1vbP318enRPllu5ser84AYwi1sg16Xxq8/zA0O1xjBSjD0iiU6gwwMP2M9XsonsDcDhY
	bWwJGIwHw7OcWIIhCAtnEl0Xrbw0wxlElRoN7o96tIHRYSYQHTAyR6Ca4oBvm5O/jUL/y+H3KXwV6
	ECREOtRze412YEAnkEp8V/G/E/QQbTCfFleDsZClueEVnIPF5nY0twqEIk+x+6eu7uJTGMB6DhnGz
	fFSm+MrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Yqu-00000001tn8-1xLF;
	Wed, 06 Nov 2024 05:45:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Yqr-00000001tmI-2s3z
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:45:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 074FA68AFE; Wed,  6 Nov 2024 06:45:07 +0100 (CET)
Date: Wed, 6 Nov 2024 06:45:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 06/11] nvmet: declare 2.1 version compliance
Message-ID: <20241106054506.GF31330@lst.de>
References: <20241105174904.3612888-1-kbusch@meta.com> <20241105174904.3612888-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174904.3612888-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_214509_905352_BA6ADC34 
X-CRM114-Status: GOOD (  10.69  )
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

On Tue, Nov 05, 2024 at 09:48:59AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The target driver implements all the mandatory logs, identifications,
> features, and properties up to nvme sepcification 2.1.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Most unrelated question: do we need a min/max supported version for
nvmet_subsys_attr_version_store?


