Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83297D1171F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zpuXqg53pK8ECCfc3aX0M5fERflUhal+Qolybuh8kzg=; b=z+n+JHp4NrlBV7IQUpsodtbHr1
	3F4wlm82/02ByMMdtdsrgCff4zh1znKPknVXkUmDBMkBkNhOMyGD9004tIeExpovt5819qbt6oa7J
	aGMPYAva9aARLbdR95Op3tzMRGMsB59vpR19oEgqW3mmlYoTUYTl+L2ZQvuCRlH+BSpmCokeZdi42
	rUp+m3uqMYI8E/2abT3Rvd6Nn4+g9YFvW/YhqFYAt2/u/pu1toR4CoOFd8BKcEGHwRQoRxWa/NDfB
	sKv+XbDWoMPbBbR0cFnxte6m0GOAl1kn0IcdQR4N3MWjLN/TiuOROKq5U7brlnsXggulJm2Xq7g07
	6/I/Phaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQULN-00000005g6t-0STx;
	Tue, 02 Dec 2025 17:39:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQULK-00000005g6a-49Ld
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 17:39:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D88B960153;
	Tue,  2 Dec 2025 17:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467CBC4CEF1;
	Tue,  2 Dec 2025 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764697153;
	bh=RNXcKa0/kxYrBJCsHyydpFEke2NwZRooOqMEFxmZEzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pa21I66HNsU4RwhgGbggxOWWMnXuyk+AXBjM9LuE0U1W5hkzGDojRlqS+awPNhCkv
	 XU1XlpPXIJaPyoBViAQJU+ZxA1hxDjTWl2W9yBR+7CttruYxA+uj2eCPux7EQiUhkk
	 tuRJxcsKwpMhWmGY3N2oqNEQU3rHfEmzGa4RaE8Ql61CrwB+NtZz3PyffWWDYb28ad
	 HWxg0xUXHPVnO8Hlw10LpzFgr5dNwZZ7GkmrXRGMtCoBBTwzSKsvFxpUSAYeNlnNjt
	 65vlnm9nTGXvIAEGLvhLnpqhDpD7IhwhUmWOFnJgFjL65/03ppuRk74BDs3WA8CKNC
	 GS6SAxCkhPz1w==
Date: Tue, 2 Dec 2025 10:39:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Let the blocklayer set timeouts for requests
Message-ID: <aS8kP-bfOmZ-3W9E@kbusch-mbp>
References: <20251202-arrow-debris-c25524e1@mheyne-amazon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-arrow-debris-c25524e1@mheyne-amazon>
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

On Tue, Dec 02, 2025 at 01:58:19PM +0000, Heyne, Maximilian wrote:
> When initializing an nvme request which is about to be send to the block
> layer, we do not need to initialize its timeout. If it's left
> uninitialized at 0 the block layer will use the request queue's timeout
> in blk_add_timer (via nvme_start_request which is called from
> nvme_*_queue_rq). These timeouts are setup to either NVME_IO_TIMEOUT or
> NVME_ADMIN_TIMEOUT when the request queues were created.
> 
> Because the io_timeout of the IO queues can actually be modified via
> sysfs, the following situation can occur:
> 
> 1) NVME_IO_TIMEOUT = 30 (default module parameter)
> 2) nvme1n1 is probed. IO queues default timeout is 30 s
> 3) manually change the IO timeout to 90 s
>    echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
> 4) nvme zns report-zones /dev/nvme1n1
>    This command issues IO commands with timeout 30 s instead of the
>    wanted 90 s which might be more suitable for this device.

Does this example really use 30s, though? User space commands should be
going through nvme_submit_user_cmd(), which overrides the timeout set
from the nvme_init_request with whatever the user requested (usually 0).

The code change looks fine, though.

