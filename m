Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E1ECD4F5E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 20:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SKUHEGmFld29+rVgmHT4hiu8JBAXU45/uSi6kAd11uc=; b=CWIzrljMDMUO++sKBlda3D62ja
	utuOYhffWqcCVaQjtCrMKu5jISByzEM7novjfOzukZZi9L2HQ7jLCsFiDilVGlCLIoGmBFLZSGR39
	u9BRPJMrOkJ7/IYUvHKU/VzpRotcy0LO6ChmpPhnMsBEJNVnS2iJ1bcjTufYyhbLU2Gto4jAOqmcR
	IHOKJPQfLvY0ZoRc6xBgdkTzOpiJBBK/qRjULWng3WzBkMGXb3vwrZdrgzMuYYZY2oO2njDGpHQvv
	l+PKcIil9U3B1zpV2vhzVMAjzQeAt2dCp3Xps2NnL30Y9aeAlmYmd9M9UFiPeUqSHFCnp2NxD2m9b
	u/SgLc9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPnUg-00000005igh-1h95;
	Wed, 20 May 2026 20:26:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPnUe-00000005ig9-3G0b
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 20:26:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C114E600FC;
	Wed, 20 May 2026 20:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D3E1F00A39;
	Wed, 20 May 2026 20:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779308775;
	bh=SKUHEGmFld29+rVgmHT4hiu8JBAXU45/uSi6kAd11uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O2Vvs0+USgI82kc+yDnUl28xx41SMb9gWDhOXPWlfHbKhqOxS49tVxQF2Tmo9POT4
	 aTffPacRNG8mMwBWqsx1Ab7392u9SqZ8d97dVzTqAivR5YGMfOe9WkcEk2wbb3A76L
	 YtLGKPJdU6Ip2NQrLfLDFQC40rSuhgTOTUdGJOHvTGQCILgEwgyerRglfSYmh5bdiJ
	 aBdFIcJafPhIclr97uIPusPi/K2FUdjAsFYQp4XNOBNMjYLANdno7Ch0VSJcam9j6R
	 pzrd6DGFIl3w19tUiX+o0yTNpCpEdKCIhhAu8K7t3FqByLNH7sHEI7qhFwrnLkYCqS
	 qJO1VH5C8LmqA==
Date: Wed, 20 May 2026 14:26:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] nvme: reserve a keep-alive admin tag for all
 transports
Message-ID: <ag4Y5R1X0gkZbU-g@kbusch-mbp>
References: <20260515071248.2689513-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515071248.2689513-1-coshi036@gmail.com>
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

On Fri, May 15, 2026 at 03:12:48AM -0400, Chao Shi wrote:
> Per NVMe 2.0a section 5.27.1.12 and the transport binding wording,
> PCIe MAY support KATO. Reserve one admin tag on all transports so
> the host is ready when a controller accepts the feature. Fabrics
> keeps two, the second being for the connect command.
> 
> A quirk-based approach was considered but no PCIe controller
> documented to declare KAS != 0 was found (two enterprise SSDs tested
> locally report KAS=0), so an allowlist has no entries today.

I totally get it's optional for PCIe, but that also means it's the
host's option on whether it wants to use it, and there's no requirement
we have to. We just need the driver react correctly when someone tries
to do it.

I am skeptical anyone would produce a PCIe device that supports it, but
let's say someone does: what is the use case motivating enabling this
optional feature in this driver? If it's just because the option is
there, then I think we can just reject the user command submitting the
feature for PCIe transports, like I earlier suggested. Requiring an
active command will just harm idle power states.

