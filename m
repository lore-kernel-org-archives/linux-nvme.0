Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B62C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:33:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72EE21655
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uv2kkKqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72EE21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZnX50qDroB1x/CoEoN1A+p7IOSXKEn+/9FzJlIhdBew=; b=Uv2kkKqPM7AnMT
	xSqJw2s4g65kYHlZkwduWZ+K/WXNpvCnQeH4zfSPd6m9163UmTPu2K8Spb0RF4kPyE5Q+V/LaR6VO
	/EswFKVCNNyl5+qYJbZ5q4Z5nLr/ov0HVE8wn7r10AyRW2WQagjgLtFhypV65n4f78SdY9PHMJR6x
	PED63lfBj+0uL3ZiEzTSdJplf8/8cGV7IN49oNlaRrsg092IQSQWTLiADqD/ainM7hJjs1pqiiUMz
	As+M0zQZN+JCsvTIMm+kd6Mo5e4x1W8bHhw8V8UZaEWAMgSJZos1rS33G32i1U9F/M2z0zeFzcK4H
	5D4x8GXzSSmWV+KvGmkQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifKqt-0005kJ-5w; Thu, 12 Dec 2019 09:33:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ifKqr-0005kB-Ca; Thu, 12 Dec 2019 09:33:41 +0000
Date: Thu, 12 Dec 2019 01:33:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Talker Alex <alextalker@yandex.ru>
Subject: Re: [PATCH] nvmet: fix null-pointer when removing a referral
Message-ID: <20191212093341.GA20683@infradead.org>
References: <34086421575664793@iva7-8a22bc446c12.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34086421575664793@iva7-8a22bc446c12.qloud-c.yandex.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 06, 2019 at 11:39:53PM +0300, Talker Alex wrote:
> nvmet_referral_release() was called after item->ci_parent
> and item->ci_group were set to NULL by configfs internals.
> This caused oops on older kernels and possibly on the mainline too.
> 
> Tested on CentOS 7.7 (kernel 3.10) and Ubuntu 18.04.3 (kernel 4.15)
> by means of MLNX OFED sources.
> 
> This patch is mainly wanted in Mellanox OFED as in-tree nvmet.ko for
> mentioned kernel behaves proper as the bug was introduced about
> a year ago.
> 
> I haven't found information about bug-reporting into the Mellanox OFED
> but after taking a look in the mainline I thought that it might need
> this patch too.
> 
> I have never before sent a kernel patch so
> feel free to tell me if I did something improper.

As Sagi said the commit description can be shorted, basically just
the first paragraph is needed.

>  static struct configfs_item_operations nvmet_referral_item_ops = {
> -	.release	= nvmet_referral_release,
>  };

nvmet_referral_item_ops can be entirely removed now.

Otherwise the patch looks good, thanks a lot!

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
