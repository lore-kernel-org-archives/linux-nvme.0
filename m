Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65D5ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 04:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=RFmDVSOUOa87zlqUiKU+USHsgv
	i2nNgYOCirUM4txg5zDgTGsRhWGHfB9YYOZnR5yUpu3rpmYNOo3bR404ghTrrMSgB9eTdIOIwu8+e
	CE1K/9Ge4RN/ZgYO3+F2xjQv442exaPYIT2dJHy85Rz1oQoZGVO54iRwfjPTRc84H8oump5O5GXjw
	ePd1GRn5l4V4LYxvLLh1e5Fvj45gQgajfV/H3NDTJZMKeQ6cfr/nbTaRySTEsMNGU4+TVS8BJutKS
	JDS1d5ZHtdCRHMSZXe/Hm/oP5bC1kkdugito7Jtj/pSsNkiy0SffyPC9A5DRTGatmI0PRHy8v2L7z
	MHXugxxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTFoO-003o4F-4h; Wed, 31 Aug 2022 04:58:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTFoL-003o2W-DO
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 04:58:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35E8B68BEB; Wed, 31 Aug 2022 06:58:34 +0200 (CEST)
Date: Wed, 31 Aug 2022 06:58:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Shyamin Ayesh <me@shyamin.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Lexar has bogus namespace identifiers
Message-ID: <20220831045833.GA18042@lst.de>
References: <20220826165140.249418-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826165140.249418-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_215845_639975_1AE93DFE 
X-CRM114-Status: UNSURE (   7.67  )
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

Thanks,

applied to nvme-6.0.

