Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2232DCD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 08:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BvqgnkRf+aKzqJ49qoawoRqNG0mFdAfF6OiDAA1omn8=; b=D2mWNfJSaa6Nwqc+B6RbSFUJmt
	pMb2AotNEtc42p/hL3HuTpsVCQGGXe3o4CHHohL/jSpgY5O0rze6nAI5F1PYiZ2O3Mvnd99dQuCck
	Cm9goGdDR56pX+iEDeEuDxkBanSXaLn7/zeGxzAAxjfzg3QvD1FG2bC1+FmTs+ijbqQalOxlvGtKw
	zeUHN6cOwSEl9aJprS8YtqJVjkWtDlkefE4mvTv9WRmgfsBI+3dDcP5PaUiR5HxqmZyQUfOkB/L8e
	tKf6Rt2+64i0H7lJXM1RLyzRgR3wrd4ZeAAP/aGOOlL7qQDpjWBz2VNI50tWeUMhS1u7mJ/TSQlxa
	wQtUZjYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV3Ra-0000000GNJc-3KMG;
	Thu, 04 Jun 2026 08:28:50 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV3RZ-0000000GNJS-3fDR
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 08:28:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1745444543;
	Thu,  4 Jun 2026 08:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58B71F00893;
	Thu,  4 Jun 2026 08:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561729;
	bh=BvqgnkRf+aKzqJ49qoawoRqNG0mFdAfF6OiDAA1omn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JGZKXsYQlnoV/OZgfrE8KNT8P5A8KDh60Ifbo/TDvq4dHQrlgyKkJ1y4oPDozNuwi
	 z0jmPqO2zeNyTxYzlExLH7hyTMJuQly2OeS/2Aa8SxE5YxwiblgbgyLzdk5MiZFLsd
	 MNvHmWG63uJu2rr1+iSvkEnYFbKk7vvjLOapzfncAv3FqDpwE47M0O8+O6MsqvvLt7
	 C0uMruyn5JCezjstu+TjEOtQakVGLRG3iR1RdlH3XbnQrWtdeN8e/QMLvj9QKxNghH
	 nbLJYexsRXgZOgNPDdO0ndh2q+V4XlG8FBbdKVc6xpJ3YN1fxxFHtZK1mMMAV4aipy
	 sA488pE0UXZ/Q==
Date: Thu, 4 Jun 2026 09:28:43 +0100
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v3] nvme-tcp: lockdep: use dynamic lockdep keys per
 socket instance
Message-ID: <aiE3O8a5RHiGI7-V@kbusch-mbp>
References: <20260604023208.388157-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604023208.388157-1-shinichiro.kawasaki@wdc.com>
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

On Thu, Jun 04, 2026 at 11:32:08AM +0900, Shin'ichiro Kawasaki wrote:
> When NVMe-TCP controller setup and teardown are repeated with lockdep
> enabled, lockdep reports false positives WARN for the following locks:
> 
>   1) &q->elevator_lock        : IO scheduler change context
>   2) &q->q_usage_counter(io)  : SCSI disk probe context
>   3) fs_reclaim               : CPU hotplug bring-up context
>   4) cpu_hotplug_lock         : socket establishment context
>   5) sk_lock-AF_INET-NVME     : MQ sched dispatch context for the socket
>   6) set->srcu                : NVMe controller delete context
> 
> The lockdep WARN was observed by running blktests test case nvme/005 for
> tcp transport on v7.1-rc1 kernel with a patch. Refer to the Link tag for
> the details of the WARN.
> 
> This is a false positive because lockdep confuses lock 4) (socket
> establishment) with lock 5) (socket in use) for different socket
> instances. The locks belong to different sockets, but lockdep treats
> them as the same due to shared static lockdep keys.

Thanks, applied to nvme-7.2.

