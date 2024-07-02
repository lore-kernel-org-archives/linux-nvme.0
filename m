Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D89C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ka/7u/p9ENHBdStpLxiX0zhRuapNYRxlGvy7UsI47i4=; b=m2IXV/nwOJ92vLavokEb38IXS0
	qO7VNYu4YOuonk/1K2yevuLZ+UlfOnITUVXvXQ2g9yWFoMwG1f4/iezKo70S/zlMdUM6RJtOMMM4U
	0CYbF7as8qfBQngtVeioQWvBpdt+aRp0Pk+lGLAHDSRt//z9VXM0rio1PSjgoLShFj8otaOf2Xxzd
	RJ8dwVOB8iw5KegNenTQx0+e37/jh0EuxbNmX9TBPCk8/XuaH+Sb+2p8KxwgEO8vjA52xJlv45joS
	RvuRZbDawUYRVACr9W4s86wDhrXoF5gWJiDI31amttOxPepdrdLTd0wzSRHUmXBOMZ+q8yyIC41Al
	3d8L2Nhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfDw-00000007AGM-3Yn6;
	Tue, 02 Jul 2024 15:15:16 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfDu-00000007AFg-0eIs
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 15:15:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 223E4CE122C;
	Tue,  2 Jul 2024 15:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC10C116B1;
	Tue,  2 Jul 2024 15:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719933309;
	bh=ka/7u/p9ENHBdStpLxiX0zhRuapNYRxlGvy7UsI47i4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEnHsCd2aZp8wkpUWwJ7ja9kaewmaoLQ0se954mp+eElMX5/aQTsc4Ox2UdRhtXyW
	 SWFnIPLs35+OnI23YyEEwjDh0sgtwuHC5r4W/3cUi3EaeVefeGoqhSbPdvFB5OfU9j
	 0TzgbIfd7osSi3MnGz5MpT2eiZ/iABQIInF37+WAvb89Aa0anVCUWKr/Stbs7VVVuD
	 WDCOlgt4seOKhA0YXCreI6pTJRwJDUbuatQzdSFfm3YuKHWEbyZwtg1mx6UEWql1sD
	 k8/2aTu/NVoV1SS2DDpdx1C6ukKL4cfTB/fmNV+Y9/7C9XkmpkxACbntmYIpPz5bAZ
	 NKlOfiU4iaAhw==
Date: Tue, 2 Jul 2024 09:15:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, bvanassche@acm.org,
	javier.gonz@samsung.com, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3] nvme: enable FDP support
Message-ID: <ZoQZelWxFIiG5u4h@kbusch-mbp>
References: <CGME20240702103348epcas5p1015eafbddf4795558843cd74b0453b12@epcas5p1.samsung.com>
 <20240702102619.164170-1-joshi.k@samsung.com>
 <20240702113954.GA15325@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702113954.GA15325@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_081514_393935_A91CDDC1 
X-CRM114-Status: GOOD (  10.77  )
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

I like concensus on features, but I don't think we're going to get that
here. It's my opinion that FDP is just arbitrary hints, and this is just
one way to map it to other hints. Not a perfect match, but I don't think
it needs to be. It is not realistic for protocols to target a specific
operating system, and Linux's write hints are not exactly a shining
example of an interface for this purpose either.

My first concern for applying something like this is what kind of
maintenance burdens does this create, or any potential harm to users who
don't subscribe to the feature? Nothing here looks alarming to me, and
there is a clear demand to be able to access these features like this.
Maybe it works out for some workloads, maybe it doesn't, but I don't see
a need to block this at this point.

