Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0DAC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 02:07:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8534021556
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 02:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aynQx2Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8534021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gnCbPYPwCbXBjTvppwOva021kMchTOyYOPcJy3o/htk=; b=aynQx2RuNpzcjFZoOqX8c76VZq
	WbWhF5g5gF+rv0sSWhmKFP5Y4cvjcZU9r3ZJQYXzs+l00LhVZ8GdYwWahXBVDdGDK6qIUle+kiTG3
	GzB1VxISAbGhG/c2iN6uRkkDtzFmmOXIWGNCGwxsRL7yNnW/bHwQhYAS7i+YzYeI+tRl6c5EAMxtI
	ogICBhzYaxM6lcAgUSVDc2oE34/8svT8gw57tODexM1DGO2wMnNEcFGef/jLj15Je7kFh7XP8a/it
	2vr0K0F/3xsb6Ubo2l5m7gB9HVo7WnWEK+RJsfinj4fp0yEXYg8J2mLQwI6FvgBKWkdEKz/7BErPe
	ZCDuz9ng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnuoz-0004jh-89; Wed, 24 Jun 2020 02:07:29 +0000
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnuou-0004ht-FM
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 02:07:25 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01355;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U0YisOY_1592964436; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U0YisOY_1592964436) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Jun 2020 10:07:16 +0800
Date: Wed, 24 Jun 2020 10:07:16 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported macro
Message-ID: <20200624020716.GB40094@VM20190228-100.tbsite.net>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
 <20200623162751.GA4846@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623162751.GA4846@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
 kbusch@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 06:27:51PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> > Introduce a new capability macro to indicate if the controller
> > supports the memory buffer or not, instead of reading the
> > NVME_REG_CMBSZ register.
> 
> This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
> a backwards incompatible change, as the CMB addressing scheme can lead

Ah, right, I think I should add another version condition:
if ((ctrl->vs >= NVME_VS(1, 4, 0) && !NVME_CAP_CMBS(dev->ctrl.cap)) ||
    dev->cmb_size)
    return;

> to data corruption.  The CMBS was added as part of the horribe hack
> that also involves the CBA field, which we'll need to see before
> using it to work around the addressing issue.  At the same time we
> should also continue supporting the legacy pre-1.4 CMB with a warning
> (and may reject it if we know we run in a VM).

Thanks for your explanation. I saw we've added an CMB sysfs attribute
to get the CMB location and size if we enabled CMB, so should we still
add some information in nvme_map_cmb() let user know explicitly?

dev_info(dev->ctrl.device, "Registered the CMB, bar=0x%x, size=%lld\n", bar,
size);


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
