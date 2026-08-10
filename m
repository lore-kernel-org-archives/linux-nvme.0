Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FB0C5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7SE9gv2aM6fWpoyXgXSsOOxYcYEnmi0qWr+Oq1tEGko=; b=vN875/inLq6v57E+qey5jyTA/g
	fSKi0xOrsoJQgBLYuJGd9unwIgPN7/ohg0JUJ49N5KHAzVBXRYy3so+431uriEEPegSAAHgqUgtLq
	9RqbSGWk7NI3kyeKJkHcVyJNEDixJ/X/xiLJMCTzcZm2dib7DEyzG9OwoPwM8Hm8CcF7IXMmWDznW
	gsaG/xfqdvXB7tOmnKlRtpF/1Hci8YtuBf1JKE0JHve1cIRfmcN0noA6sNdy/WS7UslY6x0EQyNYc
	ebUbkAA+uAiGkAAIkl9YWpgxvxxvvI0exqQm0JhbNHA1946lggopZucimb+SBDipLzcqmI6h73762
	BGSIvx5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZBc-0000000D1D7-2eZh;
	Mon, 10 Aug 2026 23:13:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZBb-0000000D1D0-3yv9
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 23:13:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E860E6001D;
	Mon, 10 Aug 2026 23:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3840A1F000E9;
	Mon, 10 Aug 2026 23:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786403618;
	bh=7SE9gv2aM6fWpoyXgXSsOOxYcYEnmi0qWr+Oq1tEGko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jdFLDosdz76V9vUvd1dj/4PrgTk0HhoisBmUzrN0DelsXKCRVWDMywuv/DJv0EjNh
	 Hkpb74aUKmo96WI6HgwTbiBGTHo+Yj+7u3+H+xH/FypNGGN4jMG7P54qo8j8nyXBRW
	 NkP+e5vcJMnoum3vPk0G+xIJUZrTfNHNSi6Ry/Q6J+OCzT8Ciq3M5ns2+Yr3+4U2eb
	 0cEtP/12h+kST98ZiSrdXO2o2MOTtkBomnNWBrby/EdQJZJfCfVnQgRmzGtqS+hza4
	 DUkaaA3Afyfcc9a79NT+0oDwSeNzURhacekUKUjiXaNfjWXySvUIHQ3LvEZZGIM+xQ
	 bZFvJ+m46rTRQ==
Date: Mon, 10 Aug 2026 17:13:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v6] nvme: reject passthrough of driver-managed Set
 Features
Message-ID: <anpbIKTNY3SeZxSq@kbusch-mbp>
References: <20260715155752.3363247-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715155752.3363247-1-coshi036@gmail.com>
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

On Wed, Jul 15, 2026 at 11:57:52AM -0400, Chao Shi wrote:
> Since commit b58da2d270db ("nvme: update keep alive interval when kato
> is modified"), a Set Features (KATO) passthrough command lets userspace
> start keep-alive on any transport. nvme_keep_alive_work() allocates with
> BLK_MQ_REQ_RESERVED, but nvme_alloc_admin_tag_set() reserves admin tags
> only for fabrics, so on other transports the allocation trips
> WARN_ON_ONCE() in blk_mq_get_tag() and fails:

Thanks, applied to nvme-7.3.

