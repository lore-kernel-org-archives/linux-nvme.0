Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DF7C53219
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 21:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kL4zEeK/b6QDKO4LWVchQT9gEYx7IN427TkBw/ijwCc=; b=rvIRi/RteAsgV71SCMn3hygYG+
	tLWEJiRgPPDql9Rp0mmpU2bgOpVAnIroJjd12Iv9tXsHV0TtQlhuaDIhR6Aloj1X7ietlEqjObqTb
	GcLoS4zhtyB0KjXmxqpgwYx5HNiiS3Yc1lzirWrSM5NMFJpYu6wWEQPH2lO/FLvK3LmL9NTOZZTIQ
	8FLkwvisN+bRXTnwKkprlQcZ4uXB99zV52n6/W7rc5tEGRfCLIEm0fOzKWO3LRwO8P3sQxmS71zjf
	ifiNhDISluUL9Oi1mGXUyq9neFM1VOXViwFk0wI/AgRPv8PoSk9Cw2mPmU9WxQ18ansGtaTZrKf8u
	pxzSrTqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wop1l-00000006GAG-1yfu;
	Tue, 28 Jul 2026 21:07:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wop1k-00000006GA3-2prv
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:07:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5DD5D404C2;
	Tue, 28 Jul 2026 21:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063931F000E9;
	Tue, 28 Jul 2026 21:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785272872;
	bh=kL4zEeK/b6QDKO4LWVchQT9gEYx7IN427TkBw/ijwCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BBIAi3ZSkz4YrGEHsFClCijX63D7WbGtgtp/E0nyQq6fc01I1H6AClXlQCenVa/Kv
	 X3DITHEXwjkKs/FKtK+gwjwFyrezSc13TYLWaYFmcHr26H3ARrlQfQbWFAmBTpXfoc
	 H0m/7i62UHunp5SnTxjGmK3QGPnzul3cuUwO8jPbFT6T+Wl7Yd8lANyiFQgiVlp+XN
	 uSEnMlDRSz32Z/5zzif8AJN8kRcNszv3LiPuSa1ZYhpOJXJqg99rlMgbqVbP3LjWnw
	 ng8liEQZeU1NfX2QpwANknfDzME5I0e3yu9qqFsn8ubmmSjLSeWgO56DBY40+F3BMt
	 xo4+jGKuzg3fg==
Date: Tue, 28 Jul 2026 15:07:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()
Message-ID: <amkaJgFRImL888VT@kbusch-mbp>
References: <20260720060305.885535-1-yangxiuwei@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720060305.885535-1-yangxiuwei@kylinos.cn>
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

On Mon, Jul 20, 2026 at 02:03:05PM +0800, Yang Xiuwei wrote:
> Unlike IO_CMD / IO64_CMD, NVME_IOCTL_SUBMIT_IO never calls
> nvme_cmd_allowed(). Unprivileged callers can thus issue I/O on a
> partition device or write through a read-only file descriptor.

Thanks, applied to nvme-7.3.

