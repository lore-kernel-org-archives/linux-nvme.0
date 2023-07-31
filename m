Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45167C001DF
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8kc72/PbxRHNBUihnBKsuffD34wFIUW06T/xiMdqXQ=; b=VuduOCIsvNtpXtroTa6n1vJ+st
	zR6mLj0BM1kcbPbWU1aV18UqeaGcdiWbNGf3h5+XcV5jVeDHzOT6v6wPqfO/AWcktsfDfr5wF5xRJ
	9cA0YkdEjpZlHjT9TF9LFtjFYsLbOfcSrBXKxcT5MgoehMJBqLCKaLOybhSvnKrym5r6lzMcaPCnW
	ht4G+40GVf/3NPZ8GwDuWasXiqQIiGCt5pFTgnrg0zIj9SxTUXaWkQ3ZNKWD9EVMFfzizA5cGlIU+
	8MffQnOaYZZwYUGrKQ2hdmHiWUW2KQzLAJfPMC+Wm+RZDYz9aNWZRIaJv8DcbPh+wbnhiYsnalL7B
	2AWrC5iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTqs-00G7Q0-0F;
	Mon, 31 Jul 2023 14:26:26 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTqq-00G7PR-2T;
	Mon, 31 Jul 2023 14:26:24 +0000
Date: Mon, 31 Jul 2023 07:26:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Message-ID: <ZMfEkFBT7D7fizuL@infradead.org>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
 <e0f88870-73a8-05a3-024d-52cefcdef71d@kernel.org>
 <ZMe8XvFDDdAom97/@infradead.org>
 <3a827ef4-4143-a7d4-f3b1-6b50837f6fd9@kernel.org>
 <ZMfAA0yDhgvekjb4@infradead.org>
 <8da417c3-f505-ebfc-c92a-509fee68cfa3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8da417c3-f505-ebfc-c92a-509fee68cfa3@kernel.org>
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

On Mon, Jul 31, 2023 at 11:12:43PM +0900, Damien Le Moal wrote:
> max zone append sectors limit indicates the maximum size of a zone append BIO
> that can be built without ever needing splitting.
> 
> So if we fix the zns limit, zonefs does not really need a fix, eventhough the
> code would be a little weird as-is.

You still need to fix splitting due to I/O layout and not just size.

E.g. if your do a writev() with two non-page aligned buffers (you'll
probably need a arm64 or power box to trigger it), you need to split
the bio even if it trivially fits into the size limit.  Similar for
things like max_segment_size.

