Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DE2C54F4D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8TesSH3bKrX8E4xIp3jx6Hc1Ou7h92YXc7rtITwjWs=; b=uz5bLEAuE89J8MPfWcSp1JU/fj
	rrBPi/Zmzlsq5L05YBZkiqduqUB45/cElrr7urnWVIBLr2CH8IhwJ27mpp44goM37Bp+CucI9aRCc
	U1MXQPjX3/rPvEzFNXps9m/iv8Njfq36xYBJjZNJWaJmTDAnAxMUaSOrFwfZR90LG/Db/YzOertre
	GfzeWyIL6bBOww22gBC8As3kwHwbQxKlB0e2qG3/9JsKyLoWnEB0sTG05xx53ZyHhr0VD2Ov+Z8FC
	rNBs+oQqwQAcFMcP7D/wx5QlCG427MUV3iG1p+cL6AOhzlVR6EHCT1eVJDnOF69YS5sGpyT3N/rIm
	sTe11Fgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woloV-000000060hP-0JsV;
	Tue, 28 Jul 2026 17:41:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woloT-000000060gF-3YGh
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 17:41:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DFA960A58;
	Tue, 28 Jul 2026 17:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7443F1F000E9;
	Tue, 28 Jul 2026 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260516;
	bh=k8TesSH3bKrX8E4xIp3jx6Hc1Ou7h92YXc7rtITwjWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dthcuVVhWa1tT7qwAeA8vlPp03ym0WtJP54qDqhhty+pq2PzQaSTXMDHgzS4F0GLI
	 J3NJ0EhG9OuYhm05RZpbNy+5iJdhAuMOwRBnD1vGd98m0gdth/WYyejGsApcr2THnn
	 Skeoc6rvPe7fmtC/Gdb3xVyc+Xg/61dagqJ2e2cUE5kCUA+lP2DFkhLdNTlhzf1uUe
	 YwcwxJQ9UjIOAy4WwsQta53rORpF8X49wblSwoF1CE0IOuLBtrjqFo1W5kO+d1/709
	 D0MkDCC02ADDxF8LDtLNnDL0YW1G2FJYrchGz1R0N777tNSMRCXDp16G31Er+kLce9
	 aPIiboFCQT5jA==
Date: Tue, 28 Jul 2026 11:41:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, elver@google.com, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v4 00/20] Support Clang context analysis for NVMe host
 drivers
Message-ID: <amjp4ymLa-u9iO_U@kbusch-mbp>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
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

On Mon, Jul 13, 2026 at 05:24:01PM +0530, Nilay Shroff wrote:
> Marco Elver (1):
>   list: Permit context-unguarded access with list_empty_careful()
> 
> Nilay Shroff (19):
>   list: introduce LIST_HEAD_GUARDED
>   nvme: update nvme_passthru_end() signature
>   nvme: add context annotations for nvme_passthru_{start|stop}
>   nvme: add context annotations for nvme_ns_head::srcu
>   nvme: remove redundant initialization of nvme_ns_head::requeue_list
>   nvme: add context annotations for nvme_ns_head::requeue_list
>   nvme: add context annotations for nvme_ns_head::current_path
>   nvme: add context annotations for nvme_dev::shutdown_lock
>   nvme: remove redundant initialization of delayed_removal_secs
>   nvme: add context annotations for nvme_subsystem::lock
>   nvme: add context annotations for nvme_ctrl::ana_lock
>   nvme: add context annotations for nvme_subsystems_lock
>   nvme: add context annotations in fabric.c
>   nvme: add context annotations for nvme_queue::sq_lock
>   nvme: add context annotations in rdma.c
>   nvme: fix context analysis warning in rdma.c
>   nvme: add context annotations in tcp.c
>   nvme: fix context analysis warning in tcp.c
>   nvme: enable context analysis support for nvme host driver
> 
>  drivers/nvme/host/Makefile    |  1 +
>  drivers/nvme/host/core.c      | 14 ++++++++---
>  drivers/nvme/host/fabrics.c   |  4 ++--
>  drivers/nvme/host/ioctl.c     |  2 +-
>  drivers/nvme/host/multipath.c |  9 +++++--
>  drivers/nvme/host/nvme.h      | 44 ++++++++++++++++++++++++-----------
>  drivers/nvme/host/pci.c       | 22 ++++++++++++++----
>  drivers/nvme/host/rdma.c      | 25 ++++++++++++--------
>  drivers/nvme/host/tcp.c       | 15 ++++++++----
>  include/linux/list.h          |  9 +++++++

Looks good to me.

It doesn't look like there's a single source for updating list.h, so any
concern with taking this series through the nvme tree?

