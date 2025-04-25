Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F92C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 17:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jHIoy0J3e9V7oV+fAqv3mF2R7OeGK1wC3mkChCR83BA=; b=uvKslgWm+G/tTPUlcf/0oCxdzB
	0NdlgQiTytcJszuGKkfFF+rwImWmfgWK5etF5Lp82NkhWnYsSByBWugH1oXQq9z/ZDCfeQfiMbaxk
	ppsJg5N9LAaAGcd6N7SoBM9vP2IfUwvfsEWk0e/Mp3Bm7PMhcHtUO+yW8xTEbJOFWuM3eE+3Ws4TN
	cAxXMqe1Dv7fok8PQ6UngHzBBnLWYIkVGwAGBK489SUiQSXea7M4q9Wlq5oHYFyB2vZNCDkrcGuM4
	FzGSC5HraIzvQCZJkPm48LX30OVkVjRXoY6s4sYiSiUShVofn8FlduwJ3y8tlO9qnJOJa1RgtsPZu
	Gt5yjLSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8MUK-00000000KVe-3b2M;
	Fri, 25 Apr 2025 17:05:20 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8LI9-000000006Wm-44db
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 15:48:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 21ABEA4D466;
	Fri, 25 Apr 2025 15:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50668C4CEE9;
	Fri, 25 Apr 2025 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745596120;
	bh=jHIoy0J3e9V7oV+fAqv3mF2R7OeGK1wC3mkChCR83BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KLt2Z0Cqo18tNfAokvOVAu7zOvIjrqY8T7/SIdz6CTGHQA8YTMXSEBcwAfBVStXTB
	 FUaSX/NgdNL7CuO1+d/CJaHydpMFSTwG6Qd146rDi23xZdFj4BzPal9TofLLigY56K
	 XPCmrSTzZmHkPXQ7O3FTjVvQDkFzg0zaxcdsUsLcBBFjbDutRh3E/FBi4gtZy5g71n
	 iU6oQUTk+D52PE6ATlFA7g4R4WqoOw4G6e5whjR9PdGvgQThCnBiRBLPj7gp7FYeHN
	 qwZUZgfI6FVFi+HRsZloSIUlH8VONgPt2S0X+ZyipYHGVe9lIfY356YXddSI0lzfZc
	 o6iAJFrn2qung==
Date: Fri, 25 Apr 2025 09:48:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Linjun Bao <meljbao@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: avoid missing db ring during reset
Message-ID: <aAuu1RvgwyfXI3AL@kbusch-mbp.dhcp.thefacebook.com>
References: <fa04f3d5-56ff-62bb-0afd-ad94e961ddee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa04f3d5-56ff-62bb-0afd-ad94e961ddee@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_084842_072511_B12D7EB5 
X-CRM114-Status: GOOD (  12.62  )
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

On Fri, Apr 25, 2025 at 08:01:45PM +0800, Linjun Bao wrote:
> During nvme reset, there is a rare case, when user admin cmd such
> as smart-log and nvme_admin_create_sq from nvme_setup_io_queues
> happen to in the same blk_mq dispatch list, and the user cmd is
> the last one. nvme_admin_create_sq is dispatched first in
> nvme_queue_rq(), nvme_write_sq_db() is called but immediately
> returns without writing the doorbell because it's not masked
> "last". The subsequent smart-log ioctl fails fast hitting
> nvme_fail_nonready_cmd(), skipping both nvme_sq_copy_cmd() and
> nvme_write_sq_db(), so no doorbell write ever occurs. The
> nvme_admin_create_sq fails timeout finally.

The block layer is supposed to call the driver's commit_rqs() function
if anything in the dispatch list wasn't successful, which should notify
the controller of any pending SQEs. Is that not happening here?

