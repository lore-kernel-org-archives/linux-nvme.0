Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DCFC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 13:58:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB7920848
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 13:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M/NELD9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB7920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fuI9XDFPg0Zt9e8nbd+XU4F+D8WtDOJ9d9X7QK5fFZE=; b=M/NELD9TfGWyB+oq5Y7HnL9X8
	iiOfbFRo09B97VTEqc+7SB/z4WvOdlBGj4OtX3K0ehZW0QDOJo2IY0v8Rrp9eLWShPYLsGehYlwHV
	92IYhgm6aMbGKPt6RZJEC5EwWEdkWGaAy57rCo25w0uLQ2qmcTDwveqx2UjXYasxHZ8vx5jHgLh1z
	QIhGnbxnhMBeF2cddQ4FiT6mBe/o7p74BNkEXt/liAbrZvUpnBvUgc79chUWnbKev63gkIxzte/oT
	pf2lMj8blIMKrYLt8n2J029BNUZj6FE8Yu5ruwUm6UYj/IF6nsIOx65kqoLr4OfTmRSWYykZrK65f
	9I4aRmlyA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTQFH-0003rq-9R; Fri, 16 Oct 2020 13:58:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTQFB-0003qN-RA
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 13:58:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 153B767357; Fri, 16 Oct 2020 15:58:00 +0200 (CEST)
Date: Fri, 16 Oct 2020 15:57:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
Message-ID: <20201016135759.GA4685@lst.de>
References: <20201009231816.1524-1-logang@deltatee.com>
 <20201015075640.GJ14082@lst.de>
 <bc51aadc-eee3-cf52-0623-b3f82e1958f4@deltatee.com>
 <20201015180148.GA23377@lst.de>
 <b798e7f6-0afc-551c-f6d9-f7900b400137@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b798e7f6-0afc-551c-f6d9-f7900b400137@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_095805_999311_5D6AED96 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 15, 2020 at 12:40:52PM -0600, Logan Gunthorpe wrote:
> > But those are entirely unrelated to the bio size.  BIO_MAX_PAGES is
> > 256, so with 4k pages and assuming none can't be merged that is 1MB,
> > while max_segments/max_hw_sectors could be something much larger.
> 
> Isn't it constrained by max_segments which is set to NVME_MAX_SEGS=127
> (for PCI)... less than BIO_MAX_PAGES...

nvmet-passthrough is not limited to work on PCIe controllers.  And even
if it did relying on an implicit limit like that is a time bomb.  I
have work pending for one of the next merge windows to lift that limit
for example, and I would not have thought that nvmet-passthrough
relies on it in any way.

> Would the NVME driver even work if max_segments was greater than
> BIO_MAX_PAGES? Correct me if I'm wrong, but it looks like
> blk_rq_map_sg() will only map one bio within a request. So there has to
> be one bio per request by the time it hits nvme_map_data()...

blk_rq_map_sg maps the bio chain.  Take a look at the for_each_bio
loop in __blk_bios_map_sg.

> If you want me to send a patch to future proof the MDTS limit with
> BIO_MAX_PAGES, I can do that, but it doesn't look like it will have any
> effect right now unless big things change.

Yes, please do.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
