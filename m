Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27A8CD6E64
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 09:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yrJEkQifg0J2C1CLKu0x7lO2+iFN2aTYEyN4P4AKfvE=; b=NgGRljkUX36BLfg0JTeJIC+d4w
	4blXiin3fILVLFWX9dmASwI8r5nxF+Z2EOnc7wY80AdyKUUs9v3QVW/zN6qGWTfhhZMrUqTA3lywq
	8I6xVwgaaPyWUW00/A3oE6cXVHALRLZ3mP3WtfIeWTnryODaOxz2Af4PKn9Xk1tuen+mB4+fUoQzM
	iCvNffpH2ztJEVxPrpkYx83agfEOo9GxxYK+82qarKaCNdz16v2TAlhg1qMePPC8QYfTebNyY7ndc
	p4caOQyPtuOBA8TpNSW9Ta9NU9HUwgXkP48Mf8WLVziZzohj5mx1JFkFA+db0u/QmPEJr0euj65Ja
	AsVXb1ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUi9Y-0000000EjZc-491K;
	Wed, 03 Jun 2026 09:44:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUi9W-0000000EjZ6-2Ja6
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 09:44:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A2C3841A83;
	Wed,  3 Jun 2026 09:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C451F00893;
	Wed,  3 Jun 2026 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479885;
	bh=yrJEkQifg0J2C1CLKu0x7lO2+iFN2aTYEyN4P4AKfvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B0ZsGQNQzpS2MulxgVW3eG5f0QqCw7vlu173K7LUv8nV3lp5Y2LMpuYwfafgWPHwG
	 XdCK0wjD0TPsHQdi1u5yyajI5Pwk/KIwzmVICgnxvAt2ze7mdnDdrl8i7r/cHYr6WW
	 4/w8eUw5O54aTjL8K1E+W5VVFAiMn2vpc/gvyUaCyMoI5KBFhySfOGpGcf+SRmqg0X
	 muAvUspw4FyhXpRZYaqoAAKA87CRji860+eyKwnLTBavRXzYA78h5nXQxtKueMxWay
	 RpZ4IaItyfbKNr2MXrC6PJg14TDapiXoizzjLrqmRU18RztFXJvCx/2jkgsKYKJ3NF
	 6bS6S2cN5VUUA==
Date: Wed, 3 Jun 2026 10:44:39 +0100
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 0/2] nvme-tcp: lockdep: use dynamic lockdep keys per
 socket instance
Message-ID: <ah_3h7cIS8e6QTdT@kbusch-mbp>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_024446_608656_08D21225 
X-CRM114-Status: GOOD (  12.70  )
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

On Sat, May 30, 2026 at 02:20:43PM +0900, Shin'ichiro Kawasaki wrote:
> When NVMe-TCP controller setup and teardown are repeated with lockdep
> enabled, lockdep reports false-positive WARNs. This was observed when
> running blktests nvme/005 on v7.1-rc1 with a patch [1]. Analysis by
> Nilay [2] confirmed that the WARNs are false positives caused by lockdep
> confusing different socket instances due to shared static lockdep keys.
> 
> This series resolves the issue by using dynamically allocated lockdep
> keys per socket instance instead of static keys. This ensures lockdep
> correctly tracks locks across different socket instances. For that
> purpose, the first patch moves a function as preparation. The second
> patch introduces the dynamic lockdep keys.
> 
> [1] https://lore.kernel.org/linux-nvme/afB5syZbUrppgsDQ@shinmob/
> [2] https://lore.kernel.org/linux-nvme/c4ddc101-184a-4e4f-82ca-c3123bce5e34@linux.ibm.com/
> 
> Shin'ichiro Kawasaki (2):
>   nvme-tcp: move nvme_tcp_reclassify_socket()
>   nvme-tcp: lockdep: use dynamic lockdep keys per socket instance

Thanks, patch 1 is applied. Please have a look at my comment on patch 2
and let me know if we need to respin that version for it.

