Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3B8EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WZrdYlfzMm+sdbRQ/2bGevPkPXjUKRBs5ccrI0nSIh0=; b=OVxhNBSycgpqqgkFw47yGKNTRh
	eSAKY6jTEm0X2wjRBhwLBNQsyHM3WWPirQkZl4ceAipT7pmj+0ZAcO1SUCj1Elh+f4LqNZse6Q3/v
	30MpuS29r/X0bg5+bsFK7uJbfVZ8go2D46nyedGkG8FZJy16ZtRbBUD63CCNHr3WVU9F3ylytxmpm
	uFx1OlDnfOlp9GECgYUAgokbgGvD2EIpp0FoeTSyZZAruwXqxT/805GeoObn05ad2v+2ITuGiTrEB
	UE+DWKREvDKyeLXrMWxA+utYjN1Wxano7d3OJmaOOPkdeJue2DYOXJk46558McZxVwpgOkuAB2Vkw
	PRGZSZTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qC3YJ-00FYed-0M;
	Wed, 21 Jun 2023 19:31:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qC3YF-00FYdv-2f
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 19:31:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 61676616A0;
	Wed, 21 Jun 2023 19:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED7AC433C0;
	Wed, 21 Jun 2023 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687375893;
	bh=aSUfMQ+z77ChqbqenDG0JSS6hcwr+vm4UXaeb8jHlQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jPdLqHqn54FUNrjYTKlMEhYzJ2+3WHygEcp/pUrvVCrm6TzKFKRnEfBnXscl5Tfqd
	 Bx+63S5vnrPzLODXe88YpmryxodiMFU9kZrGgbgmACzJs3mWRXuiw7n7V4jcqbyKkm
	 vjBo9u2m/KxD7S5gEsohpjaxj4gy5wdyeXTcO3JNN3PI0sLycmjATqbY5455tacJvq
	 HgXoQHkE18uqbc0qfadsJzUyARsKtBUvyZoYwZ2+mOgHhw+Ez3heqiFJANWoA1YLIF
	 +IoTejpDR8Ov9HzTLufaWzgvWjUBuX+85eTHAvNuLbLROMGzWwtPRbn9FApqsR3Jsg
	 1O1z+mT2SvLEw==
Date: Wed, 21 Jun 2023 12:31:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Message-ID: <20230621123132.2e0b487b@kernel.org>
In-Reply-To: <476d2cd9-ae32-a4e6-4549-52c3863d4049@grimberg.me>
References: <20230620102856.56074-1-hare@suse.de>
	<20230620102856.56074-5-hare@suse.de>
	<5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
	<20230620100843.19569d60@kernel.org>
	<bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
	<35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
	<f8d789df-8ca7-9f9a-457d-4c87e2ca6d0a@suse.de>
	<476d2cd9-ae32-a4e6-4549-52c3863d4049@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_123135_925933_3D12214D 
X-CRM114-Status: UNSURE (   9.85  )
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

On Wed, 21 Jun 2023 12:49:21 +0300 Sagi Grimberg wrote:
> > Good suggestion.
> > Will be including it in the next round.  
> 
> Maybe more appropriate helper names would be
> tls_rx_reader_enter / tls_rx_reader_exit.
> 
> Whatever Jakub prefers...

I was thinking along the same lines but with __ in front of the names
of the factored out code. Your naming as suggested in the diff is
better.

