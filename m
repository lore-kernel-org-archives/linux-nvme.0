Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7EDCDE016
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6k3fQVC+qIgFARB6dW3l9yTJWf/IbrOgrh0FoNgXjQM=; b=u/3lEbcPqhDscnefCcRKDo7xeK
	EE4U6fTwJ4eobCNeG/8FQlE3VY7InMVBfw9yJ+imnH23stHo+0SaIul+9LCJbvfpLfW1DDy78uV69
	fWB4KfPIWOso/4soNsya5mr55zHmLuvMw59Y5UdoHiF1fx3rSPYItbLYGJhCsqNORWEaeu++PS5/d
	VDVbNyatcD87owE0toK2ssamLFDty0dPfYUjMaYZQ8+o9dx8+vSMQoWDk3Ldyj6ASbGxACa8KJxDy
	2fLorz8mJJygeS2Q1Bam2vB9mKp/yQ3D9tNdJdwWktuKhc1ugWhZoDpV839I07B+BaojKKDR3cUZ0
	yfctXx3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1OE-0000000AjLf-2MZd;
	Fri, 26 Jun 2026 07:54:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd1OD-0000000AjKL-1ehT
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 07:54:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D071D60122;
	Fri, 26 Jun 2026 07:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42B31F000E9;
	Fri, 26 Jun 2026 07:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782460455;
	bh=6k3fQVC+qIgFARB6dW3l9yTJWf/IbrOgrh0FoNgXjQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzJIT2W91FVcT9XVbDeoCo+LkKsZ1kVB2vFyPuBgYqfcQ+t41n9x7hsN5vqdt7TM7
	 b+JzwPpi9JYUopKu28gRHMY6T0XR7G8veUqMoz/B/BnNwe3lWarmN2Cqw/ZUIk8xhK
	 7HzxBc9YfbT2h80DuwoqKnkoZSxs6T6BSaIxqkxk=
Date: Fri, 26 Jun 2026 08:53:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: replace sysfs_emit() with sprintf() in configfs
 show attrs
Message-ID: <2026062614-outthink-drool-fd81@gregkh>
References: <20260622025915.1294806-1-kanie@linux.alibaba.com>
 <20260626070117.GB11368@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626070117.GB11368@lst.de>
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

On Fri, Jun 26, 2026 at 09:01:17AM +0200, Christoph Hellwig wrote:
> 
> Adding Greg to see if he agrees.

Ick, no, sysfs_emit() should be just fine, and safe, for configfs to
use, please don't do conversions away from it.

> But if we add churn to change this, we should probably switch to
> using seq_file for memory safety, and have some generic
> configfs-level infrastruture for that.

seq_file() would also be great, but really, sysfs_emit() should be all
that you need to use here as you should only have one-value-per-file
with no overflows possible anyway.

thanks,

greg k-h

