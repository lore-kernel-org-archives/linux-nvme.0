Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECB4C433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:06:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A5420FC3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8U6uSat";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jZd0L7aT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A5420FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0wTIP95IImc4+DS0wHYIKD8AAhcoFE3zEYoOku4l2r0=; b=G8U6uSatDZmwKo560Rw1ppmWv
	AWhHafZHzZo6c2W0d3Bd1ltkKB3vUMIpTIFbNy55m8HGYcjsE0VaPsXYvJzxk6BecPAjhAPOgXyPP
	pW8mzjtuqEHoBPqQGWnRdWiD8y9dxBbd6i0/gbWM7c9442YyY0VeK7g9O6bCsos6KRZsePLZM2Icn
	EsDi5/zov3haF84L2RijvA6vzEf0jkGTNZxn6BU48G6+IQg0RuKJoGh6/wUkJtoYxmxcr9PXJVipe
	mUu0rnpITGfGmXlMRpbXaRRFnu0sH5s2oTq7ZgSAQ5Gx+V2DryHzW4vPnpgbYcoLRGE+muVu65kKp
	OQL+stleQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD7rF-0005GU-2W; Tue, 01 Sep 2020 15:06:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD7rC-0005FP-DR; Tue, 01 Sep 2020 15:05:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TQLSoH0xPQ3SjLQOZr/hg2RXQ7cUeDg7DQ8wAuWlnPY=; b=jZd0L7aTlxDR248PzMNlW27wkh
 U5RPUon6By39MJmZf0ctObEI9pE6t9/Rga1EYLZwsrKYL9QKBtSzQY4MensUyVRxNASrX33Pl6ldS
 zbXRi9/lO7DOPWfK1zGncHVRI29r2AMThiNWFyK5BL0hKgOTicHc7ljMttBaeAT085JBU3dfIIkhB
 i2DXKzLWz59dGh9/sp69/KBXolj/SaGGtRWihBzzh4x4klX60zoq5kB/U7R9cVPhcDeNn5gerBNkJ
 glYPLWys77T11Ln0t8j7NNm/ySZOphISgDrR6WnPzsdkVah1bi4+EBuWuom6AkSHomcEJms18cORZ
 5mRx4n8A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kD7r8-0008OT-59; Tue, 01 Sep 2020 15:05:54 +0000
Date: Tue, 1 Sep 2020 16:05:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 07/28] 53c700: improve non-coherent DMA handling
Message-ID: <20200901150554.GN14765@casper.infradead.org>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-8-hch@lst.de>
 <1598971960.4238.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1598971960.4238.5.camel@HansenPartnership.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org,
 Joonyoung Shim <jy0922.shim@samsung.com>, linux-scsi@vger.kernel.org,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Matt Porter <mporter@kernel.crashing.org>, linux-media@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Pawel Osciak <pawel@osciak.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 01, 2020 at 07:52:40AM -0700, James Bottomley wrote:
> I think this looks mostly OK, except for one misnamed parameter below. 
> Unfortunately, the last non-coherent parisc was the 700 series and I no
> longer own a box, so I can't test that part of it (I can fire up the
> C360 to test it on a coherent arch).

I have a 715/50 that probably hasn't been powered on in 15 years if you
need something that old to test on (I believe the 725/100 uses the 7100LC
and so is coherent).  I'll need to set up a cross-compiler ...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
