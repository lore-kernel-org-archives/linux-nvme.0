Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C23FC2D0E5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 19:11:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9AB20658
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 19:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Stwb2vhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9AB20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RgziJdn61xvyvl7MvtTqIdA7cH78d9Pcsqu6ioxYuQ4=; b=Stwb2vhPj6Zyxj
	vw2L72t3pYEJkZJ9hBnYs2bQAJUeUwmly+uLpJaW88u6IZTrnRRLy3F/NwWmnwdoQzApUcKPeg5aV
	2XNsaEAV+CQ3USB4hUv5o9x6msRnuG/T2x0Lzq2wEDF5dxX5MY4uMDIP9XBfIuIWd5LvWRyfXlm21
	wkgqo9eiNUVyBwAYYRfS69LkC6Ia8rmjaqOClXax+mT44WL2t0qHtdGl7kX3wYav+95TJ3Y7jSdhw
	x7vPq943VNn0AFSKthph4p/lWP0n2e3ZRsMvyFm1w0nypbqdyPaZlPeMHeAkADlZnnNvNw5BHeHBo
	K/E2mXfWzEWovgkJYC0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHBQf-000339-AR; Wed, 25 Mar 2020 19:11:05 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jHBQd-00032z-KO; Wed, 25 Mar 2020 19:11:03 +0000
Date: Wed, 25 Mar 2020 12:11:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nick Bowler <nbowler@draconx.ca>
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
Message-ID: <20200325191103.GA6495@infradead.org>
References: <20200325002847.2140-1-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200325002847.2140-1-nbowler@draconx.ca>
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A couple of comments:

No need for the "." the end of the subject line.

I also think you should just talk of the nvme_user_cmd function,
as that also is used for the NVME_IOCTL_IO_CMD ioctl.  Also there now
is a nvme_user_cmd64 variant that needs the same fix, can you also
include that?

> +	if (in_compat_syscall()) {
> +		/*
> +		 * On real 32-bit kernels this implementation ignores the
> +		 * upper bits of address fields so we must replicate that
> +		 * behaviour in the compat case.

s/real //g please, there are no fake 32-vit kernels :)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
