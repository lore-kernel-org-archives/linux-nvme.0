Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEBBCC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E63mUwFjemiDxyzubiYvAzEQKx406mWvj0GrGEZFzz4=; b=yGPmXCWTtiC8/CHrwobTXjmw/x
	JzNMUwa0T2eHwb/sIq8cPUX5HnJlsUO72GFmBKv/mgozhCaCtwJmx/Vf6Sde2GhiyUCdbrfuhXn14
	KSzFfM2WTrYzxPGKkOf3U9ZDeOdsFUN8vKgJVG8jZ008ZZFWKAkKnPppYrAYTZZSTto8NWZ4lGVOy
	NDGeBE8L6q1Yd+fTjQhk4j0YjyJMGzNHS+XjS5ovp2hDLdMk7sYbulQM3NryRe6L6Li4xswjn+f0u
	jdG/LKttqB8ja5Z/Z3eA+/AEfoykxV1Y8j7FZFlkUC9UsK1QY658XPXYeqBI7bOx7nxRTYZH/LYZx
	JuQtPtsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeV5-0000000DM2o-2uXz;
	Tue, 13 Oct 2026 15:33:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeV2-0000000DM2M-3Da3
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:33:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4C4C243CFB;
	Tue, 13 Oct 2026 15:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5B1F000FF;
	Tue, 13 Oct 2026 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905588;
	bh=E63mUwFjemiDxyzubiYvAzEQKx406mWvj0GrGEZFzz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O7Iac00VgukUmNt11Uv5RXPVpRARxbnIWbBhWKNvcyzszewbursSp2KErQQteW5fG
	 QLW7a26/qgb8tWmcIqpm12RHCvtUAE+MieA3ghmhiAeN4tkA5jZdHmifT+tqbuY/A3
	 uXsuWM9FWx7okZLUzNMyfBfUouQh9T2nzpUZx2PdZFKclceE1l/VAlHuxD85v+uZhn
	 YpuKYYEW5PV89KWpvh0mCTPbdVihPIRniqMxFMSt2+GxhCgx5Ei0CmdhldCeS4KAWJ
	 blVYiQDk4ZRv+gdx9QLqTdI2yBlpmDVnGzEPYiDwNLorXXEXopx35TExowJ0hjno5Z
	 9e78xy87KHdwA==
Date: Tue, 13 Oct 2026 09:33:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Surabhi Gogte <sgogte@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, mkhalfella@purestorage.com,
	randyj@purestorage.com, adailey@purestorage.com
Subject: Re: [PATCH v4 0/3] nvme-tcp: parallelize I/O setup queue in connect
Message-ID: <as5PMuAUcVRDgwUr@kbusch-mbp>
References: <20260922200718.3941465-1-sgogte@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922200718.3941465-1-sgogte@purestorage.com>
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

On Tue, Sep 22, 2026 at 02:07:15PM -0600, Surabhi Gogte wrote:
> Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
> allocation and startup"), I/O queue allocation and start steps
> (including authentication) can be parallelized for nvme-tcp as well.
> 
> Patch 1 fixes a pre-existing bug: nvme_tcp_alloc_queue() used
> current->nsproxy->net_ns to create sockets during initial connect
> while it used kernel's init_net for reconnect and error recovery
> paths. The fix captures the caller's network namespace at controller
> allocation time.
> 
> Patch 2 is a preparatory refactor: it splits the queue-count
> negotiation and TLS PSK checks into helpers so that the individual
> steps can be called directly from nvme_tcp_configure_io_queues(). No
> functional change.
> 
> Patch 3 has the async implementation: it fans the per-queue alloc and
> start out over an async domain, serializes the per-cpu queue-count in
> nvme_tcp_set_queue_io_cpu() that can now run concurrently, and uses
> ctrl->net for all socket creation.
> 
> Testing on a 64-core host with 64 IO-queues shows nvme-tcp connection
> time reduced from 61ms to 11ms.

Thanks, applied to nvme-7.4.

