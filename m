Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2072C61CE8
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jun 2025 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vU+LAc68FmDbZCh0hX6g3Kjf+vhcNPEMK5ugiwXW3vI=; b=n9UyCFsghOQxgJTssgFJKH+hzW
	hfsNq73dD/XEHAPfKAvldWyX9Ax7x5n5q5ZNivgZXxMK8bX73+WYhcEfQFRcuctf2eIVV7jYgWcOg
	LH4O8v6d+kHnCOtnJyC5gCFmyrSLfUcK0UjdEf7/OCEojzR24l/XY+tB5KfydHhGGburAWNTM0CJ5
	mCRgEvQGZ8AqxwSEm/z966fRHF9kumBTwqt293VaJ7Vmive/BUOyb6A/WLzTQQIFH28ORouAKBsqY
	j1VQBlI3QER3gDctVyt/8VACnKbin5TGIJwB9Vz420vLFiCGcgNA3IqjCw+kTF67UbGlr86KzTqhA
	cK2/NYYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOgBu-00000004nOr-1PCf;
	Mon, 09 Jun 2025 17:21:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOfFK-00000004eM6-0s0L
	for linux-nvme@lists.infradead.org;
	Mon, 09 Jun 2025 16:21:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E947F5C4074;
	Mon,  9 Jun 2025 16:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1E8C4CEF5;
	Mon,  9 Jun 2025 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749486073;
	bh=ocnXfKRRY1/JzsSYRy7Q4liaaCzUPUUWU4ctHb05uDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhCP6M+D1wNZ1t8DrgYq1i4xXsSznjR4pU/I6yWfZ1sHPPp72iP9irwTcpASDx1v2
	 lzBRRALx8w4/DfvejRn1C52HaiwExUIA1EaEGljUcdreva42iwt4lZ2uuf7077rUoS
	 VUmXvYxPz1Tx2gGKXc97/Xyyxezkf5WS0oanFN4bt+dcPUxD61Wv5hq7eL2I73Pq2A
	 zaqSOJ5Vm65W8O3D6fxByVsRUWHCIic/9BcArkX0rqn1nWzxLFJRs8enIso3bxmV9o
	 1dyrF6PYn5QvCctetdZPchbc7brNQbndkKxMJC6kr0/wUEDWcIO3BzSAuLBH3/HXgC
	 7e/O8aL0jADJg==
Date: Mon, 9 Jun 2025 10:21:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kanie@linux.alibaba.com
Subject: Re: [PATCH] nvme: Support per-device timeout settings
Message-ID: <aEcJ96o3Jue_g1XM@kbusch-mbp>
References: <20250530073121.26683-1-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530073121.26683-1-yaoma@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_092114_301009_CB98EC71 
X-CRM114-Status: GOOD (  18.04  )
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

On Fri, May 30, 2025 at 03:31:21PM +0800, Bitao Hu wrote:
> The current 'admin_timeout' and 'io_timeout' parameters in
> the NVMe driver are global, meaning they apply to all NVMe
> devices in the system. However, in certain scenarios, it is
> necessary to set separate timeout values for different
> types of NVMe devices.
> 
> To address this requirement, we propose adding two new fields,
> 'admin_timeout' and 'io_timeout', to the sysfs interface for
> each NVMe device. By default, these values will be consistent
> with the global parameters. If a user sets these values
> individually for a specific device, the user-defined values
> will take precedence.
> 
> Usage example:
> To set admin_timeout=100 and io_timeout=50 for the NVMe device nvme1,
> use the following commands:
> 
> echo 100 > /sys/class/nvme/nvme1/admin_timeout
> echo 50  > /sys/class/nvme/nvme1/io_timeout

We can already modify the io timeout using the block device's attribute.
If you want 50 seconds on all nvme namespaces attached to nvme1, you
could do this today:

  echo 50000 | tee /sys/class/nvme/nvme1/nvme*n*/queue/io_timeout

We don't have a good way to do that on the admin queue, but I'm not sure
if there's a strong need for it: all the driver initiated commands
should be very fast for any device (they're just identifies and logs),
so a module wide parameter should be good enough for that.

Any long running admin command is almost certainly coming from user
space using the passthrough interface, and you can already specify the
desired timeout for that specific command.

