Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A161CC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 15:50:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A402207D3
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 15:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SqmujV53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A402207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9pp1NEVLZxfur0meIPN3zuTdW0k3inkeykyQA5FwagQ=; b=SqmujV53omQozeOaZeMoi3s9Q
	qJ+OyPs61+ItpWOT+E/j1cVz4HicFHE+ikDT3H1nRJ/E9wjRfPB9nK/05ZBid3EtYMZ5PSCfXzIqG
	xusozCFl+vAq+JLZ6XKGG0pNPTymzB+w0IJIZDwny8Aft/7RccmLdDonoIsMZCONjPPi1EGa/j1T8
	Apbkp/w8sUP5fvXL2N6QGvF2MY0N5UNWM0i+CvuGKhDsUr34Hl55yJJKeTuq+WXPYvKpO3rti5tII
	EVTv7dr3Jvs0DNuqOCLpFj4A3uA2oPhArY8K+E38VO6bP0UEFWK/M5TH0QTcUlnKsFLP3c6T0riQa
	MPtOBC0wA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k83sS-0007wP-21; Tue, 18 Aug 2020 15:50:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k83sJ-0007va-Hr
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 15:50:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C273F68AFE; Tue, 18 Aug 2020 17:50:04 +0200 (CEST)
Date: Tue, 18 Aug 2020 17:50:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier Gonzalez <javier@javigon.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818155004.GA26688@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_115011_712992_8F4B3FB7 
X-CRM114-Status: GOOD (  13.73  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 11:50:33AM +0200, Javier Gonzalez wrote:
> I understand that the NVMe process was agitated and that the current ZNS
> implementation in Linux relies in append support from the device
> perspective. However, the current TP does allow for not implementing
> append, and a number of customers are requiring the use of normal
> writes, which we want to support.

The NVMe TPs allow for lots of things, but that doesn't mean we have
to support it.

> Do you have any early suggestion on how you this patch should look like
> to be upstreamable?

My position is that at this point in time we should not consider it.
Zone Append is the major feature in ZNS that solves the issue in ZAC/ZBC.
I want to see broad industry support for it instead of having to add more
code just for zone append emulation than actual current ZNS support.  If
in a few years the market place has decided and has lots of drives
available in the consuer market or OEM channels we'll have to reconsider
and potentially merge Zone Append emulation.  But my deep hope is that
this does not happen, as it sets us back 10 years in the standards of
zoned storage support again.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
