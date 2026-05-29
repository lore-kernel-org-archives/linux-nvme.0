Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B98CD6E49
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTri8BUQcNx5FytxVSCnFtx7e/4115rb7iA5Ei7gVqA=; b=2+eO423CBp1Vn1hNtxVNEczDDH
	xp1vS7TheWeM5lcEq2GX4BCO4ttPw9zZEI2q6bH/7oRhSbcMQWMU53bt/urNhkVaiQEWr3WbW3667
	XygQOBRMA7moMGHtAk1sbFLiC2mqZyy3R8XdzfbclNVPgpUve1JL5QunqRlM8RGTrXo2pM4KwGdl+
	j2C3vWBhYGPCKJ4/vNlNKBdggorT9G80FBSdmEBGro1u3uQ9siwHYlbrS9i9OStu13QoDqtoO3VeA
	ixA0SwG/booHOuubgsfqoOQylUr+XRU7bC0v6nmDgxPR8T9EfBsseiNW6gM6i+5gelLMRjb/AFN77
	wGCp5lGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT6Jk-00000008IJN-0eMb;
	Fri, 29 May 2026 23:08:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT6Jf-00000008IJ1-2r7X
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 23:08:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C75C844373;
	Fri, 29 May 2026 23:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ADF1F00893;
	Fri, 29 May 2026 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096113;
	bh=pTri8BUQcNx5FytxVSCnFtx7e/4115rb7iA5Ei7gVqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V1oi1wMQkhT+5vUe3xl/z/OPr9v3cjkS70bSLcTudM9itZzRgDbd5Xhi0g39+e2ul
	 5HDAtlwbq9jHySwBVJNNh1W0au5zdHczxKW6dDBOIGeCq48+NrFR1o/aB0/ZS46xbl
	 oG/lsfsTQqCt5HqNnSUoeuF3CVSGqGhY5gd06ATDRl/tZ39w8rY/MfChJPiJQvmh39
	 CRYnqufiox9SKzhelNYg/uArcaDKShGZcTRXMOjiYZxP8PaXcDKW+lhJJwXv7NjaNb
	 iDeu6nItp/AOevw0OOCIbc6QUUcBz0HxdpY/D9J8x6V5kD5xWYaCGfNsZuz8vbdwxq
	 dKgAQbVfsCRfg==
Date: Fri, 29 May 2026 17:08:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <ahocb8YRtqh5rHo-@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
 <ahiHIEhsV2zuG5vH@kbusch-mbp>
 <DS0PR19MB76965BF9FB57EA3ED8BD4586FD162@DS0PR19MB7696.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB76965BF9FB57EA3ED8BD4586FD162@DS0PR19MB7696.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_160835_770164_83EE0225 
X-CRM114-Status: GOOD (  12.18  )
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

On Fri, May 29, 2026 at 01:32:22AM +0000, Achkinazi, Igor wrote:
> Keith Busch wrote:
> > I double checked the sequences here, and yes, I think the
> > synchronize_srcu's already in place ensure every caller sees the EOD
> > error before it could fail the bio_queue_enter(), so this looks like it
> > happens to be sufficient. I'm okay with it.
> 
> Thanks Keith! May I add your Reviewed-by?

Sure, though I was considering just adding it the nvme tree. I'm giving
a few days to see if there are any other comments.

