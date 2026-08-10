Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303DFC5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWqTwBnJcyyHxygQYXwmOQn9vbdfi+K5tJjxD/t8eiU=; b=kyblkILIbwSNv640ujg/yFjRyB
	xLYXJcIV3QwGzEe0JLdTA9d6ib6gHlO7gNGpaH/b6Gp6UWWtY+osnMWVnEW+nsH2WoNzT4B0XqJOA
	hSuVCngXasfeRppO68JYX3S47yI8CqrfmkekknfGE/YEC9ege3gHvDayBhmO4pET80PWp1rAI+ykS
	LGxzl/yzlOy4EVTchMqRHg4ZSGVsVML/MMlQlYICTf8GSAah4FjB5XCNJQ/NexsKs5tirF18ypwxU
	gFxC5/zHFaoFbj5kNMSR/Oeldq89+HenAdPjhg/8ewGYEh5Nwc15oLPLNDn1rQ76ocrVpitclRv/C
	PXoHG/dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZbX-0000000D2aZ-0lql;
	Mon, 10 Aug 2026 23:40:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtZbT-0000000D2aT-3w0Y
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 23:40:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4A57643AE0;
	Mon, 10 Aug 2026 23:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A711F000E9;
	Mon, 10 Aug 2026 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405223;
	bh=YWqTwBnJcyyHxygQYXwmOQn9vbdfi+K5tJjxD/t8eiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DB6c3Wp32ELm8yxhz/eaUk3lfa3kE8R0VHKNN7qioenAZIgzLrKUkYJgW2fbIZoyo
	 oWoU1KZOoknsJo058WAL8Dhh/pfmBruYFBq9c5pQRF0lP3UvFUteXMRqtMRQ5eCiWb
	 tZhO9kq/zNskaS2tJGcob7vWNSayFQzavga/32D7BUgGR6NEYWSWKKo2LKdAQy91zK
	 QuBxwcCuIZ6VKQjMdEv4taRc6nFa1rM7C6akiXQFJkCZnFiG9pt7RrLfXZa9IzINWN
	 Csn3JtF+XvIvQl0J6LUAadB2pN7sq1zyYr7U6wwFK7LEknFsBqe3x9Lj7CZPNq07pi
	 BljMqQx4/b9AA==
Date: Mon, 10 Aug 2026 17:40:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <anphZRzJvg0zSE6g@kbusch-mbp>
References: <20260716-nvme-tcp-page_fraq_cache-v1-1-ea660828cf93@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-nvme-tcp-page_fraq_cache-v1-1-ea660828cf93@kernel.org>
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

On Thu, Jul 16, 2026 at 04:42:19PM +0200, Daniel Wagner wrote:
> From: Dmitry Bogdanov <d.bogdanov@yadro.com>
> 
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.

I was struggling to see how the nvme_tcp callback was happening
concurrently for the same queue. It's because you're using an io
scheduler, right? I don't think this applies if you don't have one
enabled.

Anyway, with that understanding, looks like a safe patch. Applied to
nvme-7.3.

