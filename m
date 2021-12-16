Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB50C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 09:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=re27eGzcjzb3eMw+GuwuW8YytbX+lZz2SxXAAHMfR/c=; b=KkXwH5hiQEc4n4i1ocaYJ0FpgT
	559h9bePtIPLSC9bwhhVOKpHqW7B1p+8YULsFIKtTxdTY1V9KUhpwtXg4TJIArpYOwGhPHswFq8n+
	Hx9LIJFMcXDVW4uUAgMjrJSckStMnBWaz5rFW40cYNO78V/6DwFckDgkk1wF0ddYpv7/kv3zbYDoK
	uEp0l4EgUKsKqgUEKeAMHqJsmZJWjppNuymqM0bx5IziDkawf+LBpt08KkPc/RBi0LCwaGFmqShMz
	KLf0kAepuCZk0TRNlMic0a+i3GmiIdBmlOZ6U3QATl/wk3nVy8DqqdBUqDLc8h0IGiMyAT+ajMzo3
	SWdQRSvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxmtu-004Ntp-Pn; Thu, 16 Dec 2021 09:18:10 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxmec-004GIH-G7; Thu, 16 Dec 2021 09:02:22 +0000
Date: Thu, 16 Dec 2021 01:02:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/4] nvme: separate command prep and issue
Message-ID: <YbsAnrPMkxmOGc/O@infradead.org>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215162421.14896-4-axboe@kernel.dk>
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

On Wed, Dec 15, 2021 at 09:24:20AM -0700, Jens Axboe wrote:
> Add a nvme_prep_rq() helper to setup a command, and nvme_queue_rq() is
> adapted to use this helper.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

