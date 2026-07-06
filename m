Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF64C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4zluGVeKdD4Rc/Sqmk60Q7TxGgIc5ir2G9jBeTb0LI=; b=eTl39iCP86/zo+T/cYEScglygV
	xnmufxjSeQ9JvY8ojyYBmcEcnOJoYLnGoYtUcz/eRL8myplDvDQmi4XWIiqcCaJoX00e00g26Qgb7
	Sj33hApkHi44sAgaHD23nqumuVPrYZ69Lj1tRNMCGeKmHEHFK4JkOCLjLjlsaHM07TbGoYUIvUCVm
	slJakVrsytFM7F7ZVs6TqeXO06siZrBTzXOy+0mwIaubAi7eBSwP/MnKVIPpt2bKWKxT1NoWhdgHF
	cVC7w+zthe+a7z31/E3ZNDvuMEAVocacKCAS+WmdycFWfuP7sNVHlwijyQxi7M9l5Fy+l1NGIXwq/
	HdjDfDSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoUc-0000000DOQH-31sP;
	Mon, 06 Jul 2026 18:56:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoUc-0000000DOQA-1JnD
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 18:56:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A65B436FF;
	Mon,  6 Jul 2026 18:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921601F000E9;
	Mon,  6 Jul 2026 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364193;
	bh=q4zluGVeKdD4Rc/Sqmk60Q7TxGgIc5ir2G9jBeTb0LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hgtx63RfWAQ8Ja1qDXSR75yrN4PWDRSFz9QF0MJFFHuW8Yc0gQZbAT+LwkoaB0hJJ
	 tmo4t2G8ZDwnnChxkEbXk2Qg9K4nRMLScOs+gNByw/oDBwU+y5qtUpJafasgKyggcY
	 n4wlJOZ3q9jQmr2IuB23aaqlCFDHxESDwlWGOjQN7g3X6q3Kvv8NWwgPLlNAWIEV3/
	 wHR/1VQDrMCGVWaut9G9tWXFoTs8fWRBaBEXL2dQVply9fl4o+SzYCK3IqlJg0i/zL
	 aGqiK8Tm/gyk+yPkfXSIL+b5OXorjARoeJtsQ7vHQVSQYgStxyNS7l6s+LfYtw8BJW
	 S3ajH6qI2yktQ==
Date: Mon, 6 Jul 2026 12:56:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com,
	randyj@purestorage.com, adailey@purestorage.com
Subject: Re: [PATCH v4 0/2] nvme-rdma: parallelize I/O queue setup
Message-ID: <akv6YJ2-GLFwwzGn@kbusch-mbp>
References: <20260627041551.1981256-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627041551.1981256-1-sgogte@purestorage.com>
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

On Fri, Jun 26, 2026 at 10:15:49PM -0600, Surabhi Gogte wrote:
> This patch series parallelizes nvme-rdma connection and reconnection by
> setting up I/O queues in parallel instead of sequentially. Allocation and
> startup of each queue are combined into a single per-queue async work
> item, so per-queue connection latency overlaps across all queues. This
> matters most on high-core-count hosts with many I/O queues, where serial
> setup dominates connect time.

Thanks, applied to nvme-7.3.

