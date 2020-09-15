Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA980C433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 06:24:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE9620732
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 06:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b7ATIKzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE9620732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fewWvP+J2ij+54n4qVcLvd/RyIwIkaq4QaVx5OAql7U=; b=b7ATIKzFax3qKI2BE4gFezy9o
	3lshpq/xyUglk5Mp8U1T/tLvgFby0CVVnj9iO3NiKTTRCqVje6kmNNJqJH++IqCrya/+03nuEL+W5
	QqbIH8aJQEb1b2rorG8halSiMpqIQpcsHEuRX4575HpbmefG6MlQuzw4Rr34TFzMz6UxpyPaTbk1G
	wn6BOW16UoqlFKoKX2VnZN4jEhMFc10FURAaQ6Qia2T/VS9QfYTRSmwgh2ulSrTzXFeGDXl2CQLFD
	GpuGItlNPrxBfDTdnuu9KLO6Q7lrUdN0+A5RIpyl4oDBraGydsp05Xo4SnzIxwUXRlOum2ia08OCw
	u9/MTCm7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kI4OC-0008SK-Hb; Tue, 15 Sep 2020 06:24:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI4O7-0008RW-Kl
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 06:24:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C06E96736F; Tue, 15 Sep 2020 08:24:20 +0200 (CEST)
Date: Tue, 15 Sep 2020 08:24:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Message-ID: <20200915062420.GA19022@lst.de>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
 <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200911061022.GA21597@lst.de>
 <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200912064104.GA19223@lst.de>
 <20200914194421.GC10507@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200914194421.GC10507@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_022423_834397_8B740015 
X-CRM114-Status: GOOD (  13.67  )
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 15, 2020 at 04:44:21AM +0900, Keith Busch wrote:
> > Yes, you need to pick a new error.  I don't really care which one,
> > most of the mappings are pretty odd anyway.
> 
> Selecting an existing unused errno feels a bit arbitrary for a status
> that is currently specific to NVMe ZNS. Could you provide a little more
> guidance on what you're looking for?

As said before: most of the errno mappins are pretty arbitrary, e.g.
take a look at the -ENOLINK, -EREMOTEIO, -EBADE, -ENODATA, -EILSEQ,
or -EREMCHG mappings.

So I think just picking a value like ECHRNG or EBADSLT or EUSERS
should be perfectly fine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
