Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3853BC021A4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 02:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bgbgx8Iw3El76iOPC4xU0SzYJ2d9jD3Am1jR2hDxHCs=; b=UBzQTWsbCmiGGKlKKhrDD7C9gp
	VWywClRslDHpcX53k6g2vOgK1R3gsRctN0tVbmu9+PxsKcgGXxMR2/ZdemubGNgINst8Sh27WEEBK
	gAnsg+Zz1Z9QIWKhFj4OIm/q1x9sSqF/nbhgQC7nZRIyOA2nhuuzqVHdeLN9eCutg9wZKUA8M2SsQ
	+OwLxw5vzcvAJpzsG9L7/RkH9FHTUJQ9tm9A/H9uDvM1zSmraXBbjwKzMRURh266TeeTdoiRD4CnZ
	EK01y9pG6IpIM4yYZ9hmSQev632+Zv/OcE9ziP6addMccsREbeR+LUhznD2kLwEGZgtr3pHUG+hI+
	1sE5cTwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmkN2-0000000FlvU-1hdc;
	Tue, 25 Feb 2025 02:08:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmkN0-0000000Flv5-3jdi
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 02:08:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E3EB35C3CE2;
	Tue, 25 Feb 2025 02:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA129C4CED6;
	Tue, 25 Feb 2025 02:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740449305;
	bh=kZmaMaiVtfjTINgoXAWymt2zUY0MMjRTHE1NqQDWCAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X69jV/6Dt6B0DMs9dwmEtW8TmuuEZnFjddyXyucs+snwKsH8Q2ttoEnbhnxK9+IGb
	 mpBXBpiqG9ahnClOlj774rauLg/5SL2nfE+0/Gx43FyNzgi5EOVomvMKegirXANy5T
	 xwD1oF6s/swmkpo10J+62D6aLSqbbr4ZE9Kwj0CSF+DzCzkk3K5bcJxti/7mvEBKKs
	 R8zk+IwwVfEa3ngDauQHbXOi3/WwHkl+ayii0yiGQTK5y+ViNa26IGTKVH9Lqr9G9+
	 96xuFKy+u+dorgJqGctY3itgFMLrTNM6pp6DUbIRxPjAgcLXrRNBPqwEweOCyS0S2T
	 WL/XtEgv5ZwIQ==
Message-ID: <b08425a1-e857-48c0-a49b-9d09f9f7a59f@kernel.org>
Date: Tue, 25 Feb 2025 11:08:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-ioctl: fix leaked requests on mapping error
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20250225013547.1130524-1-kbusch@meta.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250225013547.1130524-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_180826_978687_ECEBD0A2 
X-CRM114-Status: UNSURE (   7.21  )
X-CRM114-Notice: Please train this message.
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

On 2/25/25 10:35, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> All the callers assume nvme_map_user_request() frees the request on a
> failure. This wasn't happening on invalid metadata or io_uring command
> flags, so we've been leaking those requests.
> 
> Fixes: 23fd22e55b767b ("nvme: wire up fixed buffer support for nvme passthrough")
> Fixes: 7c2fd76048e95d ("nvme: fix metadata handling in nvme-passthrough")
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

