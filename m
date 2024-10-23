Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE88D2E014
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 05:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0o14UPFmhT8+3zIRNxd5qxLHsoDDbIO5RH45r+WkLpw=; b=mzUK5tSKTXROLtEJ0knBz8VVGC
	SC27phYLJa/pfNpRqGSY6z8w6/kcCFYekKY3bHjrFvR1TnK7BLpt7oQ+j2vRHMc3dKF4SKLFCi+Vi
	SSS49AsYHvTVDuUBZieuJYdT26TPlGIBbA27Ujx5wnfNfTYBizQu8c5KQFPfBBYzJP9U+9aO7cxbK
	pDkmU0idhd8aQNMaqMgRtv+BJBJrp4ktyQDKK0b2449BXChI0JB5d9397IJ5egk3H4Hz+KByaKe4C
	3uxVLjqGR8OKpM3iF+el8OwBF/ZZHZcsTa4PMww+LWuD7HEhlQ7znoXw6hKgiHYNruABzPcZ3OUIw
	g9h0DMBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Tn6-0000000D1wl-28rt;
	Wed, 23 Oct 2024 05:20:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3TmC-0000000D1nj-3Ioz
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 05:19:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9AB31227A87; Wed, 23 Oct 2024 07:19:15 +0200 (CEST)
Date: Wed, 23 Oct 2024 07:19:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, zhuxiaohui <zhuxiaohui400@gmail.com>,
	axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support
 mq ctx fallback
Message-ID: <20241023051914.GA1341@lst.de>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com> <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me> <ZxYRXvyxzlFP_NPl@fedora> <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me> <ZxZm5HcsGCYoQ6Mv@fedora> <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me> <Zxb8KaoUVstRCxiP@fedora> <fe49daac-5990-464a-aeeb-c7c5f9d4d156@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe49daac-5990-464a-aeeb-c7c5f9d4d156@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_221920_992933_3F9ABC58 
X-CRM114-Status: GOOD (  16.72  )
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

On Tue, Oct 22, 2024 at 04:23:29PM +0300, Sagi Grimberg wrote:
> I agree. NVMe may have a unique need here, but it needs a tag from a
> specific hctx while the context requesting it does not map according to
> the hctx cpumap. It cannot use any other tag from any other hctx.
>
> The reason is that the connect for a queue must be done from a tag that
> belongs to the queue because nvme relies on it when it does resolution back 
> to
> the request to the completion.

I wonder if we should byte the bullet and not use a request for the
connect commands.  We've already special cased the AEN command because
it was causing too many problems, and given all the pain so far connect
might also have hit that treshold.

