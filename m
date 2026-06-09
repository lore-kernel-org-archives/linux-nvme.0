Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1344ACD8CA8
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V9w5gs711UCSXeS2EY2vTrWuTnDtwk1iyZbBn9SnfCo=; b=kliCV2NS4rzAZZWp9hq8tgiVaq
	wkqw6R0KZ0AczKqfMEkmAcrX77R17iPLwaVxZUt8NlnC6yuUPDFx8ELB632vdr1X2g56NWSk6tnN+
	tNXSMwEO8IQZBlrKtndxVeoBOvQcqzmsGZNV2d+6IAWVvhhv6ewVnwAReT1/p2QU1gxsftuDMBy7x
	Mw2eQPWJdmZPMpMiaQVokFT5KJ6j1wYSB5pm9fL1GyrkDJb9BNUJAkX1ki7k1Bd7uvVy3qOZm3S3H
	pTOXQ2RRaftzUAnGm6WCdU9uPaUJM6nCqkgMDswmbWeC3WmgMN6Bk2NS+9ouD5C9wJXOPHTBop4gz
	knW5+Jtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX2jZ-00000006L43-3cLC;
	Tue, 09 Jun 2026 20:07:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX2jY-00000006L3x-2DvX
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 20:07:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 975B06024D;
	Tue,  9 Jun 2026 20:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17DD1F00893;
	Tue,  9 Jun 2026 20:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781035655;
	bh=V9w5gs711UCSXeS2EY2vTrWuTnDtwk1iyZbBn9SnfCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KbThtSC6yGNFVLNdkjIErdeOxddOR4UABWFDKcsD281GD8LVZLWopWKr5L9EC49nZ
	 rD356upeKjIBf+a6BlqoTSPmDRn3sst4h+fnqWvWpL3rEy9/Ld88UKSv/SIo6XJj7H
	 3JnTQQz/DS7HfT05I2QOTgWdt79zQEAjeiQJuKbxosZzM1Fl0eB0EihGoByu762G0r
	 LeIbs8tvAHrXYV6wjm5S9jqUywj1nTVwocMBydozOrG4ckcztBhZeFyrRpxFGRHh4f
	 U8bWzickN2Vrd3kZqiF6/RkPEcg7uqEmSKsVO9yHE+FshqAuqBmN45yG2kHRcJVBhn
	 Ksmm1mBAldiqQ==
Date: Tue, 9 Jun 2026 14:07:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com, randyj@purestorage.com
Subject: Re: [PATCH v2] nvme-rdma: parallelize I/O queue allocation and
 startup
Message-ID: <aihyhdXtMyn2_T7v@kbusch-mbp>
References: <20260604195321.2232838-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604195321.2232838-1-sgogte@purestorage.com>
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

On Thu, Jun 04, 2026 at 01:53:21PM -0600, Surabhi Gogte wrote:
> Refactor nvme rdma I/O queue setup to use async API, combining
> allocation and startup into a single parallel operation per queue. This
> reduces connection and reconnection setup time when there are delays in
> establishing connections, which is especially important for
> high-core-count hosts.

Mostly looks fine.

> @@ -16,6 +16,7 @@
>  #include <linux/types.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
> +#include <linux/async.h>
>  #include <linux/scatterlist.h>
>  #include <linux/nvme.h>
>  #include <linux/unaligned.h>
> @@ -125,6 +126,7 @@ struct nvme_rdma_ctrl {
>  	struct nvme_ctrl	ctrl;
>  	bool			use_inline_data;
>  	u32			io_queues[HCTX_MAX_TYPES];
> +	atomic_t		qsetup_err;
>  };

This new field serves only to propogate an error from a local context,
so I don't want to introduce a new field for it at this scope. I prefer
you declare a special context struct for it to use with the async usage:

struct nvme_rdma_setup_ctx {
	struct nvme_rdma_queue  *queue;
	int                     *err;
};

And then make that the cookie passed to the async setup. I don't think
it needs to be atomic here either: we really don't care if we see the
first or last error, so forcing a cmpxchg for the first one is a bit
overkill; you can just do READ/WRITE_ONCE instead and accept the race.

