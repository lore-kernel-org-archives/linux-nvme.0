Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6711C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n2v8v3zl2UQhDWXQsexrrbOn6/5dRDk8VjM6Wo45HZo=; b=o7w1BfAR+jPUooiSf0s7z4Xn02
	eD8zQrwnS9t0sSxhTwwVC4AAGo+eGAGyND2e3G06FI59ZH5CYQDmUOpO6jtw2sUVPM90sHdopQHOD
	yx9pihN+aNlvLcqTw3RpgyQ6uxAQ9Jhch7k8w0+aad9hihM99rRa6mtLtn+tTE1AkSiiDZqKPVe6V
	t3yJJTtvy02fdhIQ+bKyqi9LyBRw6IfdjmpKOAUB7DXduSZfSJKPArCakrRfJbzHEf/KPxbp9VLsZ
	JvWsoQMasoZyOKxXzVazTleaqERe8pb5AP35Nk50dKAeZ95day7qFfSYczp4XAiiy3TKGLXbAoKf4
	7VgRzFAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsTq-00000005dYA-0hCr;
	Mon, 17 Aug 2026 08:14:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsTn-00000005dXn-2ZbE
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 08:14:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FCF868CFE; Mon, 17 Aug 2026 10:13:55 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:13:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/4] block, nvme: use lower-level limit helpers for
 namespace heads
Message-ID: <20260817081355.GD21461@lst.de>
References: <20260806024658.4193386-1-sangyao@kylinos.cn> <20260806024658.4193386-5-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806024658.4193386-5-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_011359_806528_3195119A 
X-CRM114-Status: GOOD (  15.83  )
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

On Thu, Aug 06, 2026 at 10:46:58AM +0800, Yao Sang wrote:
> An NVMe namespace head and each path refer to the same namespace.
> queue_limits_stack_bdev() treats the path as a bottom-device range and
> applies all of blk_stack_limits(), including topology rules and start-based
> atomic write checks. These mapped-device rules should not be used when
> updating the namespace head.
> 
> Make blk_stack_path_limits() and the existing
> blk_stack_atomic_writes_limits() public when adding their first caller
> outside the block layer. Keep the existing names and parameter types.

I'd move the making public including the kerneldoc and export into
the patches adding them.  Much better than hiding that in nvme patches.

> +static void nvme_apply_ns_head_identify_limits(struct queue_limits *lim,
> +		const struct queue_limits *ns_lim)

Nothing in here feels nvme specific.  I wonder how much of this
should be in common code, and if that would be useful to John's
scsi multipath work?


