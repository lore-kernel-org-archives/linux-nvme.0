Return-Path: <SRS0=+1uq=AT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AEAC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 01:25:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D00D20708
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2020 01:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="As6mafFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D00D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vtY5ALqC6AcIg1yN9hkn4IkecgqKjJLPMA6a4nsevoM=; b=As6mafFatg1XgTyPxsvNFvx/EX
	f53VZNySnhh7aBnJf4yUPLoDIgLK9YLp3pt3kyJ/8s8amk4BRrVxoOWLOd3OZwAYVoexcD/UsFUCv
	IfUnnwMzDW1KnKnvIbanDg4EDMopOs+SZhhx+19zmMiIMto6AwTiAtQS2TFTCKwl+44GCik6zV9rr
	iKE+1SbPygPf+jrndEfY4ZotkPqsAYOLJiwPgdz/hpcUBaTosBR2I9LksX5a1ly4X6RipATv8pztd
	jWVF2BlZdbXxCtlFymHRBYiapYw4Y870XpkpyDeHw6fYKjqUH4Kj3Porxo7AKYn/2Hdvsn8Laqu+B
	f2uS+j1w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsyq9-0001BS-OB; Wed, 08 Jul 2020 01:25:37 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsyq5-0001Ah-4M
 for linux-nvme@lists.infradead.org; Wed, 08 Jul 2020 01:25:35 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07484;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U243BBC_1594171524; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U243BBC_1594171524) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 08 Jul 2020 09:25:25 +0800
Date: Wed, 8 Jul 2020 09:25:24 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/5] nvme-pci: Use standard block status macro
Message-ID: <20200708012524.GA117160@VM20190228-100.tbsite.net>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
 <20200707190123.GB1997220@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707190123.GB1997220@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_212533_398234_FAF2EFD6 
X-CRM114-Status: GOOD (  11.23  )
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
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 07, 2020 at 12:01:23PM -0700, Keith Busch wrote:
> On Fri, Jul 03, 2020 at 10:49:24AM +0800, Baolin Wang wrote:
> >  static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
> > @@ -844,7 +844,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
> >  	if (dma_mapping_error(dev->dev, iod->meta_dma))
> >  		return BLK_STS_IOERR;
> >  	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
> > -	return 0;
> > +	return BLK_STS_OK;
> >  }
> 
> This is fine, though it takes knowing that this value is 0 for the
> subsequent 'if (!ret)' check to make sense. Maybe those should change to
> 'if (ret != BLK_STS_OK)' so the check uses the same symbol as the
> return, and will always work in the unlikely event that the defines
> are reordered.

Okay, I will send another patch to convert to 'if (ret != BLK_STS_OK)'
validation. Thanks.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
