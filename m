Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D84C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SgG230UfS5EtqYgsGVB1SyixQ94t7S5caaHGZk2Lflo=; b=s+JvlU8pyAJirf4n0sPJnTmwNo
	kgUYqvkpxxUM/WRgFBPr8ywFP2rGcYklt6BqY3+gEh9SRHlpvMHd+5zXgnmccPWdAQFRHzRojJPfi
	LTQfoT23T8bXLU+1fTe2V3MGnFS+DK18zcav//Mh/2rDDvtmG+El2d+9gLlYhmlbgoWq0XCbdauV8
	vIuyYrk8OZoSVHgSEPmJsVYSRnGX4SzhrhoUs6ogBiT7FVxM04GB4Lbvmn+2p+JfUttFEzkLdZriK
	1eLvGWgtTb+YPlOYkSQVIKfAuvSOHX1Hg20ARKStjxgsp7e7UROWak49RsW9r2auqaBFQP8BhqAIM
	Vst+9jmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfmw-00000007GRY-13hg;
	Tue, 02 Jul 2024 15:51:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfmt-00000007GQv-28UM
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 15:51:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 300AA68AA6; Tue,  2 Jul 2024 17:51:20 +0200 (CEST)
Date: Tue, 2 Jul 2024 17:51:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	bvanassche@acm.org, javier.gonz@samsung.com, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3] nvme: enable FDP support
Message-ID: <20240702155120.GC1037@lst.de>
References: <CGME20240702103348epcas5p1015eafbddf4795558843cd74b0453b12@epcas5p1.samsung.com> <20240702102619.164170-1-joshi.k@samsung.com> <20240702113954.GA15325@lst.de> <ZoQZelWxFIiG5u4h@kbusch-mbp> <20240702153631.GA534@lst.de> <d7a308f4-7b1f-4136-b655-c72474992151@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7a308f4-7b1f-4136-b655-c72474992151@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_085123_712756_724DF78F 
X-CRM114-Status: GOOD (  16.43  )
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

On Tue, Jul 02, 2024 at 09:49:35AM -0600, Jens Axboe wrote:
> I'm with Keith on this one - there's no real maintenance burden to bear
> for this feature, it's pretty well contained. There's no point gate
> keeping it based on changing the spec, as that will take a long time to
> get done. And there's no reason to hold this back until this happens
> based on mostly ideological reasons, when there are actual users that
> could use it now. What do we have to lose?

What we do is a misuse of the spec intentionally designed to not
accomodate us.  I'm dead-set against this.  Please all help getting
the proper interface in.  I worked with folks on the SCSI side and
we finally got it (although with a few warts).

> 

