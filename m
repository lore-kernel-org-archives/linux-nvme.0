Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5789CD6E55
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xCV/qxJqiKKp2PBwOK0nokY77A79DqJoh7VyY2kPoY=; b=VbXzFDR/9tXhdGwM/tSH+okP9z
	iZR7coqhlxR/bT4rbqSDt//pshBUfZiqT3J5PnCPBW3qbmcFBQa7w6vLPMgWpbegUfw7PauMj7nZq
	BpQGACAfIfN5C3oYRiHv/VUoWRPBajSELhkt5UukwjVCGWTNbfik7k4vTaesE+8zkJeK+99agVohH
	5eZ8JEimihl+m2RLbMJ3mg4YKfwsdlaA8rFX1ftvDJwspRj5TAUk7Es04bnOTmaJr3Z3bEJjkHMKX
	ciqnSUbuQtIPzM7kr5UvhvZbPEx78oUxXVpUiXzJis/g8Dyap93Nc8wZKAJZcsREvvb3cKYkl/aJu
	m/fxLKmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUiIe-0000000EkjH-3FRx;
	Wed, 03 Jun 2026 09:54:12 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUiIb-0000000EkiE-3tR9;
	Wed, 03 Jun 2026 09:54:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7B6C543414;
	Wed,  3 Jun 2026 09:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D101F00893;
	Wed,  3 Jun 2026 09:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780480449;
	bh=9xCV/qxJqiKKp2PBwOK0nokY77A79DqJoh7VyY2kPoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MM82qxf4iTqm031iiSIhaEh2ZzE5D12HodyvbRYuoARHXvhAV1vqkHt9X8WK+T0Sa
	 VbjfBRB5mb42kftUPgIcQwJ6C3Zkd+BvWG/g+e1gEPXsFQ4Z6KkAdSy56i3a9akUoI
	 TlYJiQKzI11nDSvlBJKgKL7OxUX0GtsHqFULQwWdsRZR83amm7MpW0dIxzKVg4uWBZ
	 5Ifdj0KvFaHJF5RAagFxdhva1S1zf9W/ASqk+N3NVTyfnp/z0eKyS4SI8xlPw38G3r
	 oJsx/BSrRJcgg8pEsFaLOGFt6Ds7x3Ao9cxixPAj+jXaePoZpg2BJAhEvQbmtQgYeS
	 ydOs585LONqtg==
Date: Wed, 3 Jun 2026 10:54:02 +0100
From: Keith Busch <kbusch@kernel.org>
To: Gui-Dong Han <hanguidong02@gmail.com>
Cc: sven@kernel.org, linux-nvme@lists.infradead.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, j@jannau.net, neal@gompa.dev,
	asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, baijiaju1990@gmail.com
Subject: Re: [PATCH] nvme-apple: Use acquire/release for queue enabled state
Message-ID: <ah_5utfy2oJbUCw7@kbusch-mbp>
References: <20260603072205.3291888-1-hanguidong02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603072205.3291888-1-hanguidong02@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_025409_988556_2BA5BDB7 
X-CRM114-Status: GOOD (  10.30  )
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

On Wed, Jun 03, 2026 at 03:22:05PM +0800, Gui-Dong Han wrote:
> apple_nvme_init_queue() initializes queue state and then marks the queue
> enabled. The interrupt and request paths check enabled before using that
> queue state.
> 
> The existing wmb() after WRITE_ONCE(enabled, true) orders the enabled
> store before later queue use, but it does not publish the earlier
> initialization before enabled becomes visible.
> 
> Use a release store when enabling the queue and acquire loads when
> testing it. Keep the existing wmb() in place for the
> store-before-later-use ordering.

Doesn't smp_store_release() already get you those semantics?

Also, there are a few other places doing the READ/WRITE_ONCE() calls in
apple_nvme_disable. Do you want to update those too for consistency?

