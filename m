Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9F0C4CEC4
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 17:10:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7319620665
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 17:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PWuLjyLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7319620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rhE8vhbkXlrtHD1kJ3WV0ivM353BZgX9DApiIisepx4=; b=PWuLjyLsnP12mf
	w9ksYVGvz0n6hUV81eQ4WRqY77iY4SJb5+r29kuxgIuzgsAuuZPyOAJI1Q9NdVKQRRvOlxOizGIuy
	sG0ZHhmTQlEmYMp8+Cx8ULR9NrkC7objUVlnbV8chrzjUeVz+stNSuPTDx1zGCmDFTJAuOP93rWJ2
	jzFONcS2wp4WW8GVkmoA11rgHdNklcKV1QRDtdb/mYuij9ba4PdJ1v+2RW4ILcSPPaml4YUhbF9Gx
	cI22sZEEuQTdTZly94rMZGOrDW8HPLq4dDv7lwuBzBbGWA1mL0doag0bdpNwdyeO4D5pz8GC/7h6W
	MCq+Me0X3f8SorUjZmjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAdSw-0006HX-U1; Wed, 18 Sep 2019 17:10:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAdSt-0005Mi-PB
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 17:10:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DB71568B05; Wed, 18 Sep 2019 19:09:56 +0200 (CEST)
Date: Wed, 18 Sep 2019 19:09:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/2] nvme: Add kernel API for admin command
Message-ID: <20190918170956.GA19639@lst.de>
References: <20190913111610.9958-1-robert.baldyga@intel.com>
 <20190913143709.GA8525@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9C09@IRSMSX104.ger.corp.intel.com>
 <20190916073455.GA25515@lst.de>
 <850977D77E4B5C41926C0A7E2DAC5E234F2C9D03@IRSMSX104.ger.corp.intel.com>
 <20190917163909.GB34045@C02WT3WMHTD6.wdl.wdc.com>
 <20190918132611.GA16232@lst.de> <20190918170807.GA50966@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190918170807.GA50966@C02WT3WMHTD6>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_101003_975772_55596EF7 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Rakowski,
 Michal" <michal.rakowski@intel.com>, "axboe@fb.com" <axboe@fb.com>, "Baldyga,
 Robert" <robert.baldyga@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 18, 2019 at 11:08:07AM -0600, Keith Busch wrote:
> And yes, that bouncing is really nasty, but it's really only needed for
> PRP, so maybe let's just not ignore that transfer mode and support
> extended metadata iff the controller supports SGLs. We just need a
> special SGL setup routine to weave the data and metadata.

Well, what is the point?  If people really want to use metadata they
should just buy a drive supporting the separate metadata pointer.  In
fact I haven't had to deal with a drive that only supports interleaved
metadata so far given how awkward that is to deal with.  But based on
the discussions here it seems Intel is stupid enough to ship such a thing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
