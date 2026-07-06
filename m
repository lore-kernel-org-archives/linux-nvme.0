Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685D5C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wTgQPbKFntBvJOTC1pS5QrCHYOxXbIPVe3K+h3Tn0pU=; b=nGUZAsJ3bBKK972MLpUpJ48dT8
	L6XEz6J+tLdtNn3o1f+bmt6ioynB+7BVN09NIFMLT6qW2fX1LO06Q6RrhEnkfQyK+hHBIeVlgbsni
	tXTsSwGLeB/c6sYE2cpY87Ssu4klpiV8gYXdLn1PQbF42bjhydKwCRAPvc9MrZs+INmkZaUo0IGVJ
	OwpNsPswGnu4ijprlAb2cDG++Ez4xovcdx4jyqGDXVDUwnEllTmG9jZPVNHHpFdC2Nl/BWd8JLATW
	O+6QbYc/MVkV8/T771YHDRGJbktaUfCMTdzp22SHZao27XSvn+uDua6WMBMbRprFVWSfRKU2U0MW9
	iyic4fsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoVy-0000000DOeC-0f8y;
	Mon, 06 Jul 2026 18:57:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoVx-0000000DOdv-02FR
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 18:57:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F9AA600C3;
	Mon,  6 Jul 2026 18:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72DA1F000E9;
	Mon,  6 Jul 2026 18:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364276;
	bh=wTgQPbKFntBvJOTC1pS5QrCHYOxXbIPVe3K+h3Tn0pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bDcJYo6AoMYJz5q5L07dBnNCy3eUuL85TGC0ojzzIusCVFvKiJL3PA1BiX2SpRxAN
	 x392b6fsdU4p0UF6rhgjc2zuF1ofaZLyEd9lgCrKdu6YtfWgsCV1eiNnq+nNt7+yNA
	 KjpbTpeGAqzQh+d8G2WcCwaIj/9O07nyHS6AAuWAXw0ypPiYYp06EzkJU4+C/sAD3o
	 1iqHCSmFu0cDF+pEl8Zpa6nBLNNB7RxM5TLZyAKt/BujirkCWsStfZj1WDjBWOSZj2
	 /oaVsXOMrO5rD2veRNsMsjIFLyraTrKJCAyAfnw/BmE/d1rrg7SRdM7bJeMX8QlaCm
	 BwMQ1qPU41kdg==
Date: Mon, 6 Jul 2026 12:57:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: hexlabsecurity@proton.me
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: zero the AUTH_RECEIVE response buffer
Message-ID: <akv6siYknndH0Cr-@kbusch-mbp>
References: <20260702-b4-disp-127414cf-v1-1-e5395cc0f9ae@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-b4-disp-127414cf-v1-1-e5395cc0f9ae@proton.me>
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

On Thu, Jul 02, 2026 at 03:45:14AM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> nvmet_execute_auth_receive() allocates the response buffer with kmalloc()
> sized by the host-supplied AUTH_RECEIVE allocation length, but the
> DH-HMAC-CHAP builders write only a fixed-size message into it. The full
> allocation length is then copied to the wire by nvmet_copy_to_sgl(), so a
> remote initiator receives the bytes past the built message -- up to nearly
> a page of uninitialized slab -- during the pre-authentication handshake.
> 
> Allocate the buffer with kzalloc() so the unwritten tail is zeroed before
> it is sent; conforming responses are unaffected.

Thanks, applied to nvme-7.3.

