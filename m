Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079ADECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 06:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aI47YyjJC32EjJbI+iMmyjePU/FHIg8bqrrmINUOUCA=; b=qAXHMQA0VvkGaVGGyjzf/Lt6Dc
	jNsicH4x2lLlM2KsWJ9c/OU+8owchY+sIuh22BEfObtGCyyOgEWiZI7sEUHco2xPrfj1SCL+NdMM/
	E1jP36RVFkczVpItUKJ/Kq4R1cLPDuEQXo80Q2WcaA36xuZUR5bixD0q2ySzHap1sffZ7TQ3NYz36
	Ee60FKMWQ/iNjCJrSOE48vFbt/fuj8biG2BV5p0Tct2jVZdnr7/paTZtJLO3uBoA8RYyEIRRONLzn
	GCw/oyQ1+VWXoG85XC61PaTziJ7yOPgEsN3q2w6Wblk2iyVGgWckVhG6Gr4zZtCBCNI8DNbNj5pqs
	9h+sDRnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVoZ3-003DMA-6g; Wed, 07 Sep 2022 06:29:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVoYz-003DIx-78
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 06:29:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73FA567373; Wed,  7 Sep 2022 08:29:19 +0200 (CEST)
Date: Wed, 7 Sep 2022 08:29:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: linux-nvme@lists.infradead.org, niklas.cassel@wdc.com,
	Filippo Sironi <sironi@amazon.de>
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com, Inc.
 NVMe SSD Controller" from 5.19.y (issue bisected)
Message-ID: <20220907062919.GA21266@lst.de>
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_232929_445989_0A977E9C 
X-CRM114-Status: GOOD (  16.51  )
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

Filippo,

can you help figuring out what is going on with this Amazon controller?

On Wed, Sep 07, 2022 at 08:05:05AM +0200, Jaroslav Pulchart wrote:
> Hello,
> 
> I would like to report a regression issue in 5.19.y in NVMe driver.
> 
> The issue is reproducible at AWS EC2 instances with local NVMe storage
> like "r5d.*". Kernel report "IO queues not created":
> [    2.936641] nvme nvme0: 2/0/0 default/read/poll queues  <- EBS volume
> [    2.939493] nvme nvme1: 2/0/0 default/read/poll queues  <- EBS volume
> [    2.940797] nvme nvme2: IO queues not created              <- Local volume
> with 5.19.y (kernel 5.19) and the nvme storage cannot be used.
> 
> I bisected the issue to commit
> "aa41d2fe60ee2e4452b0f9ca9f0f6d80a4ff9f9d" (nvme: set controller
> enable bit in a separate write). Reverting it makes the nvme device
> working again:
> [    3.025599] nvme nvme0: 2/0/0 default/read/poll queues
> [    3.032467] nvme nvme2: 8/0/0 default/read/poll queues
> [    3.040040] nvme nvme1: 2/0/0 default/read/poll queues
> 
> Best,
> --
> Jaroslav Pulchart
> Sr. Principal SW Engineer
> GoodData
---end quoted text---

