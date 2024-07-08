Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7106C3271E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z35RK8TAQjLCsA+23Av4KMYJBvRCuGf7veXypsmN3BE=; b=ki4nxIL9+3kVFjUyH5tDwuobCV
	UJg5J1CIKxJecd3ZJHuNMVO6iXBN5AbYmwXAUOc8usxnbfrFH7sb5RSyJ8KBD8ghtLKNGnIrtxBRm
	nr6fNSNiI7HOeWTm0Ypyy10I5nbiyRM3j3bF8GXFlVwNrNgjiAGZh4OaLIYvotP90OiPtu1OuFI+x
	fZGHK7TjcDgkPw9z9/iKvuVBKQXYNC4X2XyNb5PoKxKJlzrd+jG4colTW61Io9DY3uawZw/guDrPn
	f9iEHdzXyqU47yqxD3t00TG7fgCgzZ+3/nsGCjavapjsfasKpBZmUEvpKzYU0vlptQaCEI9VofH0f
	LvLIpFOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQsV2-00000004d0W-1NQQ;
	Mon, 08 Jul 2024 17:50:04 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQsUz-00000004czQ-0sfl
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 17:50:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 33337CE0EAA;
	Mon,  8 Jul 2024 17:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F763C116B1;
	Mon,  8 Jul 2024 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720460998;
	bh=Z35RK8TAQjLCsA+23Av4KMYJBvRCuGf7veXypsmN3BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceH2R6mcP7HjvQbzziGPgaxmAiOmZ+7kBlzIWhvj/qUevsREO2eGH9j0lF9wnRq4a
	 msBgUrpvdxoeoU9PJApoIgZHw3SYO8GNfI/h+s6a75wCGHL9bIVS3mgWU6DtnJQ4bu
	 /5KSeNUPxG2ltPEabmX7HYysjPm0C8V+2iYqHTsbJ0h/C0m80MD0YxCanCL+MYcPjU
	 EYyeteqMPDJScFtPMOsaUEAvm3XrjhgfZje1UQ4RKEvTsNVk78gwIMaGatYRwaqNQw
	 fwxxpi2c0c92I59/grX3g4Iiwt30QoTWpQS7B2hvo1s/3dAPsUyXG8GQOJI94qmP2A
	 /sRt5pLC3yIGg==
Date: Mon, 8 Jul 2024 11:49:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	axboe@kernel.dk, linux-nvme@lists.infradead.org
Subject: Re: [PATCH -next] nvmet-auth: Fix the error handling path in
 nvmet_auth_host_hash and nvmet_auth_ctrl_hash
Message-ID: <ZowmxJUOkyud0Dyb@kbusch-mbp>
References: <20240706064625.447744-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706064625.447744-1-cuigaosheng1@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_105001_448906_57398034 
X-CRM114-Status: UNSURE (   8.79  )
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

On Sat, Jul 06, 2024 at 02:46:25PM +0800, Gaosheng Cui wrote:
> If we fail to call nvme_auth_augmented_challenge, or fail to kmalloc
> for shash, we should free the memory allocation for challenge, so add
> err path out_free_challenge to fix the memory leak.

Thanks, applied to nvme-6.11 with a slightly condenced patch subject.

