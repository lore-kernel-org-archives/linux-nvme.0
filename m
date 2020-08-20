Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E7C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:53:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F17C20738
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 06:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lhOnRAFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F17C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uK4rD7qRy8UAX92SJNputKKEe8zFVTn9eM3OYtDSc2U=; b=lhOnRAFIM440eh74oD1FHzH5v
	AcKM25bKCXntHoioKYL7aYKbKbH3VD2JpM8LHXrBLNNdilqcPQwPUhGUTG1cTL9VER3WmEXhGzsuF
	pEFYfYvMZokwatCJ0fejtfpSv9r3bdt+eaeB73TBszoSF7VlKR+DveHzJkyOlR1MfJwLnlJr6gyLS
	vnSSQSuvewZ5OHkBsRjB1oWmgPVuQlTFuNmIGJAfmylrLe7kINynMm/EVpmA6P63+NdioIAM+6d69
	ZnSOXUhd97tRhgkoJ/PZURQkstN5GfrjiLFfenLwcqxgW++y7tFSzROui8+xflG40qDcHlh34qNHD
	jJ4aZJa6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8eRU-0006Et-NA; Thu, 20 Aug 2020 06:52:56 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8eRR-0006Dv-2y
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 06:52:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4C3FD68BEB; Thu, 20 Aug 2020 08:52:50 +0200 (CEST)
Date: Thu, 20 Aug 2020 08:52:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier@javigon.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820065250.GA6885@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <20200820063719.q6wftb23op45wigk@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200820063719.q6wftb23op45wigk@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_025253_322256_65A2CB73 
X-CRM114-Status: GOOD (  12.42  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, david.fugate@linux.intel.com,
 "kbusch@kernel.org" <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 20, 2020 at 08:37:19AM +0200, Javier Gonzalez wrote:
> We will stop pushing for this emulation. We have a couple of SSDs where
> we disabled Append, we implemented support for them, and we wanted to
> push the changes upstream. That's it. This is no politics not a
> conspiracy against the current ZNS spec. We spent a lot of time working
> on this spec and are actually doing a fair amount of work to support
> Append other places in the stack. In any case, the fuzz stops here.

FYI, from knowing your personally I'm pretty confident you are not
part of a conspiracy and you are just doing your best given the context,
and I appreciate all your work!

I'm a lot less happy about thinks that happen in other groups not
involving you directly, and I'm still pretty mad at how the games were
played there, and especially other actors the seem to be reading the
list here, and instead of taking part in the discussion are causing fuzz
in completely unrelated venues.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
