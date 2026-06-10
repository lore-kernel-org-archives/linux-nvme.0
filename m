Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D78CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHlNNbgX7y+jL41srViD5jpaZzL6Mq1vHt1s60R4Hwc=; b=TfAC0t4p5wl2A0HlqJZ6otxGkP
	TNoBW6GqSS27v5IAQtn0j/L7/YAT3VJXT5QyuuXtytCLg2bs2UGElY9t5ekqTWcpRX8C11+1OPXaL
	XMnjm8D3BgCGaDgpCV91sJ28qyGq7AuTO4N6o9gr/nbztvSjeNI9UefOGqHNGcWt3L4rGRiWNrpZK
	bsRHOxUbAdDV6zVe8e87Yv1Dq/alNAqlkLjPvmLfqPzzb6r3fAyZs7yCEBESUMb+FrKh7pSCNjmlT
	vDVqqnz1lSKxajhBn2wjnS+pB8vCQ2zVpQN5Rx2KdPThMoZAyNRhtq2UdREN7PmHSoVldSAJm7QEy
	DWYOogDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXM52-000000089NC-1AHm;
	Wed, 10 Jun 2026 16:47:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXM51-000000089M2-0LWA
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 16:47:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C965601E8;
	Wed, 10 Jun 2026 16:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946831F00898;
	Wed, 10 Jun 2026 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110022;
	bh=EHlNNbgX7y+jL41srViD5jpaZzL6Mq1vHt1s60R4Hwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I8wUz5djguyNY0E6IVKk3DcQL4eywHHqUgVsQWKjR3i7XDMGcDYvsTpjkTud/ysU/
	 Nb7rrRjGd0f0zY6ExhsDQ9dU+2UcTDKnPqmtAvkn2G3FzWDJgFW0DhbqslrMk81C6c
	 FuMjReoZvf39Eia3RoeoTI8j6D5CGrcezML3B4zlK8dtwoNg1BjmVPb/Cyc7OzpT4x
	 bquyfx9anTgckbtz0G6iY4CD4+bh0rZTttTuzdm+QCiyDjX1FNHyqLf1fIaloLgMFc
	 q6Wnjd3n2hPytZa63NNl05RQPAn/dXA11G7kfMYK2IZ1rKL7fe58/ompkH1PNXNX96
	 WzzRGFm+fAfbg==
Date: Wed, 10 Jun 2026 10:46:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
	elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH 12/15] nvme: add Clang context annotations for
 nvme_queue::cq_poll_lock
Message-ID: <aimVA51B7z4dsMja@kbusch-mbp>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-13-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610142743.115898-13-nilay@linux.ibm.com>
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

On Wed, Jun 10, 2026 at 07:57:32PM +0530, Nilay Shroff wrote:
> Fix the warning by acquiring nvme_queue::cq_poll_lock before invoking
> nvme_cqe_pending() in nvme_poll().

The check outside the lock was done on purpose, though.

