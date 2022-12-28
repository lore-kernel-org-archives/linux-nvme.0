Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC133C3DA7A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3AoeFvYIQTvAoHTI29283pIDAmCkiNuUQdQWte+1yJw=; b=JqhFMcqOz6L77vfcG2B/o6ah1U
	xL5y/9g0j+I8Nsmohm7DofZlKNksXRC+syhug4tmb3U2oF5Sm5iCL3fjHRlfGHcXTdGZ4n3UhkOuj
	9OPpBeGjBr0rYBHbo2tupnD1M29U3NCgt9XWDJaq477UmHNku+ntTACVdFlUMcrSxPFkd9a6iC/iU
	0Kol3LCfo1w8sJ8fDmHCDaW0IWc2hN64b9YnvHXe0FVKsqkWXMHrbPp/kvfNFWsZHVtXW/3rxPDXR
	Zg5A4St+j0WXi39mpQR746N9oEACiEFEwFGsNfxi6D4VFcYDCc3afPhybpsGv1+lHq5yQBUbsrfbT
	aB+Qx8Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAY7B-005qiY-7C; Wed, 28 Dec 2022 15:13:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAY74-005qf2-Te
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 15:13:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6013F68C7B; Wed, 28 Dec 2022 16:12:55 +0100 (CET)
Date: Wed, 28 Dec 2022 16:12:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/6] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <20221228151255.GA32138@lst.de>
References: <20221223071814.43564-1-hch@lst.de> <20221223071814.43564-6-hch@lst.de> <74cdb20e-2f38-f001-0b82-cca2b3046df9@grimberg.me> <20221227165754.GA7716@lst.de> <013abe7a-99a6-4ccd-cb62-ed28bbbc61e8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013abe7a-99a6-4ccd-cb62-ed28bbbc61e8@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_071303_118004_722099E7 
X-CRM114-Status: GOOD (  11.72  )
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

On Wed, Dec 28, 2022 at 03:49:59PM +0200, Sagi Grimberg wrote:
> That's fine, No need to hold this for 6.2

Thanks.  Keith, Kanchan - any comments on this version of the series?

