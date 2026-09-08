Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA71CC79F99
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2026 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wwsTLPSXpbgPa5EM9nw2ZxHsxM8nj96DOKEohHwv5s0=; b=L8P5GvJNVKbYFRzSmaq675p99n
	h9DBp/buEyGYHj3em7cJzEZC1FOuVoZisxa87RVhLmH6ZG4UA+EQS23h+MOJ7DrdHkn+N+r50gAum
	AO0HtonXwmuQpSWnbiOzBjAbfQxKZeUEMlgCbY6fQMCu2E1pXBzwQSq4gkY9kuhNBrHKuIItRpa21
	/U1+m+dtHTLxw1Cn4AbysFyLKrbk/VCMKWBdrDYfbNdZxFY9Ry9EPwpbbZQ7pL31qksWPRgKhGuxG
	GpGdQPwUm4oCYe5Unl3zOgsM1lJcw+A1iHxLAp3yAPKFj0x1DmGUCoiFwHiFJfPOyPvWyTbKs0QRn
	2LZjSPFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x41yK-0000000A7hT-2IBT;
	Tue, 08 Sep 2026 19:59:12 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x41yI-0000000A7h7-2C8w
	for linux-nvme@lists.infradead.org;
	Tue, 08 Sep 2026 19:59:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F2D80601FA;
	Tue,  8 Sep 2026 19:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6088C1F00A3A;
	Tue,  8 Sep 2026 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788897549;
	bh=wwsTLPSXpbgPa5EM9nw2ZxHsxM8nj96DOKEohHwv5s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RplUWoqHCzYy0DGGAm6wyAXKUeiWmD8JfC/p5iNk8tJN1l/NzXXV76TohSsP/GDnM
	 KZv9Xn5wU7WuggB9z1mu10FSu8Gf0Hv4tnQm2Tdpgk4kM1f6xO1hWVs8Dq+uXJgFCH
	 Frnefumnc5X/2/0YT4cYUMk6rtvRxnFU3ctKqB4W7kwCH0Mbjv3b0q37KnL2JBbaSh
	 RRyvCf8UIH2lt2/prmFkXHgjaVuALIGUXAlHlHes2ENDZ4m/jhTNQnv1UDZAtokOO+
	 3LYehBAG+ah9RLzfYzhwKoP2nX2BDGhnHCaWL3nHhse91w8pjeS3DVegMD67iS7qdv
	 EoY+x42gsLlXg==
Date: Tue, 8 Sep 2026 13:59:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yifei Chu <Chuyf26@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, roys@lightbitslabs.com,
	yhlee@isslab.korea.ac.kr, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-tcp: reject C2HData for a non-read command
Message-ID: <aqBpDGHdRAAyAI4u@kbusch-mbp>
References: <178730451245.442148.11684394617763960186@linux.alibaba.com>
 <20260822014037.1978918-1-yhlee@isslab.korea.ac.kr>
 <0a6b07e8-3ea6-4458-95eb-4a63b6108823@grimberg.me>
 <178842720109.1034236.7954869548413684234@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178842720109.1034236.7954869548413684234@linux.alibaba.com>
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

On Thu, Sep 03, 2026 at 05:20:01PM +0800, Yifei Chu wrote:
> A malicious or buggy controller can send C2HData PDUs in response to a
> WRITE command.  nvme_tcp_handle_c2h_data() accepts them as long as the
> request has payload bytes and a current bio, which is true for writes,
> so the receive path ends up copying the incoming data into the
> request's iterator.  That iterator was initialized from rq_data_dir(rq)
> in nvme_tcp_init_iter(), i.e. ITER_SOURCE for a write, and
> _copy_to_iter() refuses to copy into a source iterator: it triggers its
> WARN_ON_ONCE() and returns 0, the short copy fails with -EFAULT, and
> the connection is torn down into error recovery.  The write never
> completes: every reconnect reissues it and a malicious target answers
> with C2HData again, keeping the controller in a permanent
> reset/reconnect loop.  With panic_on_warn this is an outright crash.
> 
> C2HData carries data transferred from the controller to the host and
> is only valid for commands that read data from the device; write data
> travels host to controller in H2CData PDUs solicited by R2T.  This was
> reproduced against a target modified to reply to a WRITE with C2HData:
> the host logs
> 
>     WARNING: CPU: 0 PID: ... at lib/iov_iter.c _copy_to_iter
>     Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> 
> and the controller cycles through reset/reconnect without the write
> ever completing.

This is already closed:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f83af377c148f6ad94b41c0e8313f12adf45e1c1

