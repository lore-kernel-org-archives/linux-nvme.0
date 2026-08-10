Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2156FC5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i+HOV1eEaaj5Xwzy6dQKpZWytvQwWK7C5huS7LM3iOA=; b=fPEY01TNpv6DrTkcnkXWl1sr8+
	MSNhDeehGvOymM1o1My2KamTWdpLoTLkM6a4gz+YYnO0Kf6pFqy9siW+quzrS2fFRmetjLSZVC0Qw
	uF6NGAfQn+EWZy6WKmWJT1bGfsJ18cSI0kXDm1i6cdsq5U038O/1U6mRirNZhqahJTzb9dHHteXwr
	vnk+xEZAMBkVdZyfDdKOgznT+TxEP6EjI+pRJUSaxk9xcqeS88qP54vGNmEvlrbo+YwiczmdWD2Oz
	s59cjwbr31BrsrN/nip90/wk1aG0/3cbmvbSzMlmFr52+RO5pJzhZUvkDwnSBwX8su60fu1ZOtBff
	Dg88WmxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtYuA-0000000CzjQ-1GlZ;
	Mon, 10 Aug 2026 22:55:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtYu8-0000000CzjI-2QeN
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 22:55:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E85C040A81;
	Mon, 10 Aug 2026 22:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E791F000E9;
	Mon, 10 Aug 2026 22:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786402535;
	bh=i+HOV1eEaaj5Xwzy6dQKpZWytvQwWK7C5huS7LM3iOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WHrJnG1xQ8xt7H4vG9H/ZLbj9+U8ssXVWJ2hzkHbSIQhrA+ExeOiv2EfMWjEzuwuN
	 YiZbn1Q2+DmSRt2/x8jrIbWCYttdYkBhLLEZknRO3KvDik2fVfxl8pzZ9Y6P8+BZ6x
	 NIGL/zpZzS7AmL7UjCiwxrrkWAWlScS6AkO3r99SYYafOdBWTjkJgd1JP6OhEFdiXQ
	 AFGu1cIss/WrFNrFgDVtAkw3ngABQtBtV8/caAo28TdBi6FJaF7tzUgXsF2IcwO/bC
	 cRoRI6Uw/K/A4kAwXORFzI8umDb6FOKqBt7+qRD07DwJzc8r6Prl5qqjsbCLx50lbr
	 pS6CGE0Dvo2WQ==
Date: Mon, 10 Aug 2026 16:55:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: fix NULL pointer dereference in
 nvmet_execute_identify_ns_zns()
Message-ID: <anpW5hx_HZQaC0A5@kbusch-mbp>
References: <20260804033605.3973127-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804033605.3973127-1-kanie@linux.alibaba.com>
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

On Tue, Aug 04, 2026 at 11:36:05AM +0800, Guixin Liu wrote:
> When a host issues an Identify command with CNS 05h (I/O Command Set
> specific Identify Namespace) and CSI 02h (ZNS) targeting a file-backed
> namespace, nvmet_execute_identify_ns_zns() calls bdev_is_zoned() on
> req->ns->bdev. A file-backed namespace has no block device, so
> req->ns->bdev is NULL and bdev_is_zoned() dereferences it, oopsing.

Thanks, applied to nvme-7.3.

