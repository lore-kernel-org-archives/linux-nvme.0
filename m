Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EFDC77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 06:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+B9hmCNQRFOAldVOsQen2RDYLT06PehCxRAWkH/zp0=; b=Ap8gUkBFC0ZphUER9aDYuuoMoG
	kLL6GhQfuCCpvfUhOGeGQ8YPIaJIGzE2nvcYT212qLOH2wB7tovVq8SpXGzuPiVDK65SziteICBW2
	1hCpi559WtyyfVCAQK4RAGkDlBnfKe/NeL5biWmr5oc48wejt51mQVptQSI7moAyvn1Ff/h+EK4wE
	kSTgHO38ff8iuw7JBD/fT4othgyIDzQud+kP5f5XeI2Po/2s98KN3KKyST/Q4aSocwLRH6FSQ4eN5
	iz+wqw2mvht9NtcEWoo/T9GmIpV1OFQD3L80dOmZLnp0GRdDiNtRPwwYO90Bsjw8gBamAmpgT3CNU
	pf7X6exA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmUQJ-00228A-0g;
	Wed, 12 Apr 2023 06:57:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmUQG-00227b-18
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 06:57:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D18CC68AA6; Wed, 12 Apr 2023 08:57:36 +0200 (CEST)
Date: Wed, 12 Apr 2023 08:57:36 +0200
From: "hch@lst.de" <hch@lst.de>
To: Jinyoung CHOI <j-young.choi@samsung.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	martin.petersen@oracle.com
Subject: Re: [PATCH 2/2] nvme-pci: fix metadata mapping length
Message-ID: <20230412065736.GB20550@lst.de>
References: <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8> <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_235740_550487_6F9EE604 
X-CRM114-Status: GOOD (  12.46  )
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

On Wed, Apr 12, 2023 at 02:24:43PM +0900, Jinyoung CHOI wrote:
> Even if the memory allocated for integrity is physically continuous,
> struct bio_vec is composed separately for each page size.
> In order not to use the blk_rq_map_integrity_sg(), the length of the
> DMA mapping should be the total size of integrity payload.

Hmm, looking outside the bio_vec is pretty nasty.

I think the problem here is that bio_integrity_add_page should
just add to the existing bvec, similar to bio_add_page and friends.


