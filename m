Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE48C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 07:52:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E25C2063A
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 07:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sQXBHb8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E25C2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sXFvbjQj7Py1Zq2rFgukHp9lshl88/akRfU82TlKfVs=; b=sQXBHb8BptKiMP
	mHnKFor4NvweD655CIeI/BIMzY6q+J0OSCkMEoxsSl86+YdUqkuDBWnUMVMbnEQLHIXFFIRywTkvP
	WDlIPaT3+5BJulc2tbRbGaLEEWWtvnteQ4iKokbY8SfY4mR73k7PgElBAgg+ShEpI05tak+QmEsGk
	YByDz/6CCEg8Ql+yuPFE6WflWtdVNaf+O/q3Ubxpfxzv8B+DKRgqMN1+KuUa7HnT7XOyJXGNQaGhY
	yL46OWPrBsoaCZbgJkkZbdQwOeae/x6vFvBUHTyoEXDaK//4UhJ2VjunuLVEtYL4KZaU4gxC4R0Fq
	GhGMQfLFySBBThVMzUfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJue2-0007Ni-Lw; Thu, 02 Apr 2020 07:52:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJudz-0007Ml-SL
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 07:52:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 343CA68C4E; Thu,  2 Apr 2020 09:52:01 +0200 (CEST)
Date: Thu, 2 Apr 2020 09:52:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: inherit stable pages constraint in the mpath
 stack device
Message-ID: <20200402075200.GA15551@lst.de>
References: <20200401060625.10293-1-sagi@grimberg.me>
 <20200401090542.GB31980@lst.de>
 <469eb075-2a6f-3386-f843-90525590fcba@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <469eb075-2a6f-3386-f843-90525590fcba@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_005208_065750_8C6FE714 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 01, 2020 at 12:11:09PM -0700, Sagi Grimberg wrote:
>> I think this needs to go into blk_queue_stack_limits instead, otherwise
>> we have the same problem with other stacking drivers.
>
> I thought about this, but the stack_limits has different variants 
> (blk_stack_limits, bdev_stack_limits) but only the first takes a
> request_queue...
>
> I see that dm-table does roughly the same thing, drbd ignores it.
> In general, dm is doing a whole bunch of stacking limits/capabilities
> related stuff that are not involved in blk_stack_limits...
>
> I could theoretically add a flag to queue_limits to mirror this, is
> that what you are suggesting?

I guess we'll just go with your v4 patch for now and I'll see if I
can refactor this mess later..

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
