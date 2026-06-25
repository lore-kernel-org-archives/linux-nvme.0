Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAD4CDE00B
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 20:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f3fZrNlOuQ3bmippvymiqUka8ZXELB1zwP/Z4jmtZxQ=; b=RC5OBdVfQMcDPlsXk6tVtsvCtX
	N+XrDocXz//wkLs0NGObJkuDgklafvrJaZX9hnXJpgME7hDqmSebXNjE5vYpY4N6HZgdaXZA6E/7T
	88Jf6rYUxYVG8/3Dg3bFhMKQ4g0IYT1T7av05VcQTILcer1LjJ1IxsRi9PRVrIwdEg2sLOacZLZXR
	Gt5aUqsfh/3K44aarHnBp/Y8RAVALRTP8n2jFBdC7VmHu1cfElvbWqtRlfaN8Pgatv5qs4EolmXuE
	kWgXSsPicUJ/LnNcRwqnygDZTZwuzh6f4XXXg0bfQ7r7aLpTNF43prqCV9ER06vvPbo0VkEJO2F8+
	Z0QD1jeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcqW6-00000009ms4-1KK7;
	Thu, 25 Jun 2026 20:17:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcqW4-00000009mru-3yic
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 20:17:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AAB5A60098;
	Thu, 25 Jun 2026 20:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C6D1F000E9;
	Thu, 25 Jun 2026 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782418659;
	bh=f3fZrNlOuQ3bmippvymiqUka8ZXELB1zwP/Z4jmtZxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B8tC+7/YZb8RcTEoQ/5cWlPL9lj5H6f2CzNa02Mv0pY93VfgylwXhnsWBfbEJdZqP
	 u5Wlo1R4fT7HuUxAQVjQGf3NptkLZ0KOA8+dRa+wrLuF/0CkWtj86OTo4Twipu/6+L
	 NWCkxmdJHc/dRXsQKJXwz8vKsnVSjfjFP83NmX7A=
Date: Thu, 25 Jun 2026 13:17:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mm@kvack.org, Vitaly Vul
 <vitaly.vul@partner.samsung.com>
Subject: Re: [PATCH] mempool: optimize mempool resizing
Message-Id: <20260625131738.b7c10540e5c598cc9b60e19d@linux-foundation.org>
In-Reply-To: <20260625194915.387663-1-vitaly.wool@konsulko.se>
References: <20260625194915.387663-1-vitaly.wool@konsulko.se>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 25 Jun 2026 21:49:15 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:

> From: Vitaly Vul <vitaly.vul@partner.samsung.com>
> 
> Resizing mempool to a bigger size currently requires a new allocation and a
> data copy to a new larger elements array which doesn't go well with the
> idea of having a fast and deadlock free memory allocations during exreme VM
> load.
> 
> This patch introduces a new parameter max_nr for a part of the mempool API,
> which denotes the maximum size of the pool. With it in place we can avoid
> any allocations in mempool_resize() since we can either grant the resizing
> request or reject it basing on thr maximum allowed size of the elements
> array. For those few users of the mempool API that actually use
> mempool_resize() it is a clear upgrade because the maximum number of
> elements is known upfront.
> 
> Derivative APIs (like mempool_init_kmalloc_pool()) are mostly left intact,
> substituted by the new mempool_init_kmalloc_resizable_pool() API where the
> pool is actually meant to be resizable.

Thanks.

It would be helpful to have a description of what inspired this work. 
Presumably there is some observed problem in nvme or in zone-blockdev
use?  Can you please describe the problems and also describe what
effect the patch had upon them?

>
> ...
>
>  int mempool_resize(struct mempool *pool, int new_min_nr)
>  {
>  	void *element;
> -	void **new_elements;
>  	unsigned long flags;
>  
> -	BUG_ON(new_min_nr <= 0);
> -	might_sleep();
> +	if (WARN_ON(new_min_nr < 0))
> +		return -EINVAL;
> +
> +	if (new_min_nr > pool->max_nr)
> +		return -ENOSPC;

Seems strange to return -EINVAL if new_min_nr is too low, but -ENOSPC
if it is too large.

Also, (pet peeve), ENOSPC means "No space left on device".  If this
errno ever makes it back to userspace, the operator will be running
`df' and wondering what the heck happened.

Also, AI review had things to say:
	https://sashiko.dev/#/patchset/20260625194915.387663-1-vitaly.wool@konsulko.se


