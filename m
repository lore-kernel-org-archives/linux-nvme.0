Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CEEC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 06:03:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34AE0207E8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 06:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="njFMDtJf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UNIoczlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AE0207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bRZye+Qv6jJ5Npi+PIWiUvPW5T1pWsCQC/KtT2hz4tQ=; b=njFMDtJf3TZAbPNw7lgHAADVU
	fir8o23HfOHdLmO2FytZRwNERYZK8bjM7BwGBeijWEMCeyDngcYBqWmSFty+AQrdIJrvE8V0j00a2
	B5lwDSbXtrJbTNGaxoZwjeXv2OML7tAfq9gTU1SBY6eQ4LCslvtzQOJK7smvpAFv6F9HonpdN9w3l
	JjnQLPTzwXcfFh/Y1/yQJiLgbTyQ1VMOy0kUjK/BbzGh2aHdh4t3fzgFj7xlRRxPj7qPXsaNaMPFf
	HZ+YRM5c5lzTltpi/ifZsbZZR3vMYFRJ4XhkWimabm1IML3hyLYDBRHuHfWZ2UBQFvvGcQa/MIeDZ
	kpS44De5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMmGB-0008Qv-Dh; Mon, 28 Sep 2020 06:03:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMmG7-0008Qo-5P
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 06:03:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=H1jCAJMm4J8LmBRHVdZbbYlzCjgFbz5dqsdyvaDkPKY=; b=UNIoczlfB/KWNLph2sfsB+HeYn
 yQr5ThHJmagmUubfYlw5aSwJ4wVNbQbrzL0o9hgzRjU85p5fC6VNj8m2YtmHKhFXuionDHxs6FwHZ
 uWIl4a1e/syqb96cpUnx99effABKPl71VtLxgtuWMXxZrFCxHYBgyoZkymu3oqlwLt1J9HzQz1+hM
 GUWPtxSNMceEGOtD7r25C2qUwxw628r0bKUoKr1Y7Vn7JyLqXiP1xKOpVedeCjO66dcGfW3tLBNbU
 uF4L8BhZLvh0iiI5C4PORqnVBAuW9vsQTQm2RlDi9IKPajxryP2zbiv1Wg4jjPTtkw2vx2HWW2TxK
 3fCiugAg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kMmG5-0002DK-Fh; Mon, 28 Sep 2020 06:03:33 +0000
Date: Mon, 28 Sep 2020 07:03:33 +0100
From: "hch@infradead.org" <hch@infradead.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [GIT PULL] nvme updates for 5.10
Message-ID: <20200928060333.GA7431@infradead.org>
References: <20200927072343.GA381603@infradead.org>
 <CY4PR04MB3751593431168AD25F312A1CE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751593431168AD25F312A1CE7350@CY4PR04MB3751.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@infradead.org" <hch@infradead.org>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 28, 2020 at 01:53:46AM +0000, Damien Le Moal wrote:
> >  - support ZNS in nvmet passthrough mode (Chaitanya Kulkarni)
> >  - fix nvme_ns_report_zones (me)
> 
> Shouldn't this one go into 5.9-rc7 as a fix ?

It is a fix, but not a critical one given that ZNS has just shown up
and does not have any real products yet.  I'd still go for 5.9 if we
didn't have dependencies on it that are going to shop up for 5.10.

So 5.10 for now. 5.9-stable pretty soon.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
