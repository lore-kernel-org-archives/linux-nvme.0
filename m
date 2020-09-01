Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF6C433E7
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 16:53:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A5B8206C0
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 16:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BJ8p4V2m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qp7cO1c6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5B8206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oO6TWI25rl+l1i7IACbMK42i1H/0AL/Ijg641hF5+bc=; b=BJ8p4V2mRkeN2n4Wg+I0vl9Gm
	KvWE5d8Rhhx7s8k01NNqxES7rAYw1uNb6VMAJQ8iDN2hdAeLKeqPkmB3qBJXs/auyvrNnVju3dQ+W
	qf96OjD91n9Cq/ir93Q57a1eghUW/dv9utpwOEvf6mpw2MvAs6G1T+Ss6ojz+QyVHHv486ivY8O3p
	4Vtf27bzecyJUOOSASPLsCpQnLdYQbhGDYEstgvdqnv7/krQIN4v6qcb4p7LNSuHDApg/EGUSndft
	UEQLM9ZaeOPI9nsYp+O6GbtmENSMNyZa3VuK+TZVH+kWwNA5bt+J9IltqBZsfcmrbRACiVDfFu6NW
	UpEwe1Yxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD9X8-0007mK-ET; Tue, 01 Sep 2020 16:53:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD9X1-0007iM-2I; Tue, 01 Sep 2020 16:53:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mr+spIm0j102sxFcc3WXz2mCLWqWkBrKAQyNQoZhMH4=; b=Qp7cO1c6obl/HbURjQhpBiYPQG
 zMVpdHyURqSWTczQUMKFJAjOy/TiFuPuIO99chev9Opx0LZ/TLT95QaNoVyb4m6rgj02rzNms21bD
 l/OJj+Pn3H4e3Mzua6ZOGdf7TbV7b19zK1HK8PwPz1sPjHOWtXsWoQGxS7DBoTJGYTbRtUYGJqxI7
 8CsalzSoTglaLhiOvz2SYPVRp3wWJsHM/wtbu2DlirQcXKmjLD+1CJIvyaMBTnf2S3HPWyMsavtNt
 3tJ7WFYYYteWuJLPBqd7P2w3N7flwqDEkXxZ8pD/Jd3z/6ksKCRHFQo9SY2r/QQ5XzKyjmUUHgPI3
 osL/2N3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1kD9Wy-0001ZZ-0r; Tue, 01 Sep 2020 16:53:12 +0000
Date: Tue, 1 Sep 2020 17:53:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 07/28] 53c700: improve non-coherent DMA handling
Message-ID: <20200901165311.GS14765@casper.infradead.org>
References: <20200819065555.1802761-1-hch@lst.de>
 <20200819065555.1802761-8-hch@lst.de>
 <1598971960.4238.5.camel@HansenPartnership.com>
 <20200901150554.GN14765@casper.infradead.org>
 <1598973776.4238.11.camel@HansenPartnership.com>
 <3369218e-eea4-14e9-15f1-870269e4649d@gmx.de>
 <77c9b2b6-bedc-d090-8b23-6ac664df1d1f@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <77c9b2b6-bedc-d090-8b23-6ac664df1d1f@gmx.de>
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
 James Bottomley <James.Bottomley@hansenpartnership.com>, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>,
 linux-scsi@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>,
 Ben Skeggs <bskeggs@redhat.com>, Matt Porter <mporter@kernel.crashing.org>,
 linux-media@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Pawel Osciak <pawel@osciak.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
 linux-mips@vger.kernel.org, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 01, 2020 at 06:41:12PM +0200, Helge Deller wrote:
> > I still have a zoo of machines running for such testing, including a
> > 715/64 and two 730.
> > I'm going to test this git tree on the 715/64:

The 715/64 is a 7100LC machine though.  I think you need to boot on
the 730 to test the non-coherent path.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
