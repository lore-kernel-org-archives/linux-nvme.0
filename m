Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E57C7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fseJLh0s4wRO8NUaIPlXod9oMTQhV6Es9zj48ztLADg=; b=AY/szkgDZ08FCDlBuzBhMGoM+B
	Oz8dUtcy4bnhrK+V0zf+yglHC1fDvlI1td5QDlil3w3u0chz8fQaw3kZA9zzUXY3Qwwer5F2iPZlT
	K3k+8tvtumnAvVh1DZVH1ORNxvuPRmHXZ9JnNsZPIYA2oP+cad7apv4xEbrYIidYhC7ll0ynGG0j/
	lj/V+9VSgCfSZfntZXJW3+n546vmMaXbH6KfCo6q3SaZi+Q9vyT6EweRU8vCn3hgiDCHKQGXet2HK
	xUhKHsnovkqrYtgwI9SQRNR2RyJ7vaTJgJwE9xjz4rhxEqQ0af7XXEyueMuDkus+VXjc7b3x1BCTZ
	t9oiPrKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqqUD-00FYvD-1P;
	Mon, 24 Apr 2023 07:19:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqqUA-00FYtN-1K
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 07:19:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52A536732D; Mon, 24 Apr 2023 09:19:37 +0200 (CEST)
Date: Mon, 24 Apr 2023 09:19:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH v2 1/3] io_uring: Create a helper to return the SQE size
Message-ID: <20230424071937.GA13287@lst.de>
References: <20230421114440.3343473-1-leitao@debian.org> <20230421114440.3343473-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421114440.3343473-2-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_001942_595703_1975E03E 
X-CRM114-Status: GOOD (  10.64  )
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

On Fri, Apr 21, 2023 at 04:44:38AM -0700, Breno Leitao wrote:
> +#define uring_sqe_size(ctx) \
> +	((1 + !!(ctx->flags & IORING_SETUP_SQE128)) * sizeof(struct io_uring_sqe))

Please turn this into an actually readable inline function:

/*
 * IORING_SETUP_SQE128 contexts allocate twice the normal SQE size for each
 * slot.
 */
static inline size_t uring_sqe_size(struct io_ring_ctx *ctx)
{
	if (ctx->flags & IORING_SETUP_SQE128)
		return 2 * sizeof(struct io_uring_sqe);
	return sizeof(struct io_uring_sqe);
}

