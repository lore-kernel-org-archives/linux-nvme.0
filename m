Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36455C3ABD8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 06:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Nlt9/4135T4D0vircx++glsUBcW07iUUxenPSOo4Sw=; b=Sk8FB6l9IogYqacVW6q2kW31+g
	p5JnKfBVJ/56OrxejhwU5T4p0We4KPa6Eo8tvXR4pXghwzL6cBEOzBkwzbUHI7FiZuVa0VlUlrJ8c
	64kOJi65mHzo3ghKDFo8HOY5ZFS4AshWB7EIMenRSZSZ9a6Om2EjCuhT3KiVT4bhiZQOlhlSiKE0c
	CNH2FO5yff5oPpGv5zR4/G2DSfsc2wzUzLksT3A8I/KsQB1wvJSIfQ9Ips4jPkWvXVqLlf0VNqE0z
	9WV8YohcNObw+EMBouSR36F1LhyOZYAeIiqt9zmWPlPojB4v0NDyiAXxS/t2Y3kALHONiSq4daVdL
	UmYvUd3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFoDj-00000002YEC-1KGR;
	Fri, 16 May 2025 06:06:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFoDg-00000002YDl-3XSv;
	Fri, 16 May 2025 06:06:56 +0000
Date: Thu, 15 May 2025 23:06:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
Message-ID: <aCbWAFNoBUjci7HG@infradead.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <aCbAsCkTPMNE6Ogb@infradead.org>
 <20250516053100.GA10488@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516053100.GA10488@sol>
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

On Thu, May 15, 2025 at 10:31:00PM -0700, Eric Biggers wrote:
> +static inline __le32 nvme_tcp_hdgst(const void *pdu, size_t len)
> +{
> +	return cpu_to_le32(~crc32c(NVME_TCP_CRC_SEED, pdu, len));
>  }

This drops the unaligned handling.  Now in the NVMe protocol it will
always be properly aligned, but my TCP-foo is not good enough to
remember if the networking code will also guarantee 32-bit alignment
for the start of the packet?

Otherwise this looks great:

Reviewed-by: Christoph Hellwig <hch@lst.de>

