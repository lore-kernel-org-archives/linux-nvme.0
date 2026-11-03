Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91184606D810
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OJ7ThFND;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jV9aTeQa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TY0hZsWLPRTQMxeVW6Na0ctagqhgwKOHthul7CCfGVg=; b=OJ7ThFNDBaoI9RSXm6RjEhBT/v
	PExGJ4l1dNxYhYLL9LQkv+cNJ4LpkBvNRUHheXO+bs4Pjmk9eRqfLy+i2tkU6Nld5V+6mRgUMWSZP
	SsedJN4kzMM3cRgoypaHzflq2B73NDJRjgwrFScdxhAyl6RhLce/L70aUeXbGkVEWXZHRbaZK0X0Q
	Vaj143VX6syAUc2dsI2BI+n54SvK+7/6rkj0j5jhIUiqeo6MTEylR/fe+V2zgL4K+AZVjlST6ogHx
	lX58iA8znCXgK1VIkQY26YYgN/4ELXotTY145drSwPd6QkKXV8EWzqqENW8MVoEAJiCOB0ejqLLWW
	nvdcJsYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGXT-00000002z2V-2rK3;
	Tue, 03 Nov 2026 15:35:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGXS-00000002z2N-0Al7
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 15:35:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 83C3C43EDC;
	Tue,  3 Nov 2026 15:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19831F000C1;
	Tue,  3 Nov 2026 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720103;
	bh=TY0hZsWLPRTQMxeVW6Na0ctagqhgwKOHthul7CCfGVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jV9aTeQa3hlEbAZwz9/KVdhWMd3daljzrTB522wl/MzTlrtXvYYSSiVXm7dXb8Qe5
	 DJ4UcpYG6RqoDU8TxjVdlQ+fztueQnJcmCyDmpCfb+Pk0oNXq3pd83H64kkbg65gvD
	 g7QFuHSr3SQqlkw/sTMmH5qFqtvMZaFEhLwKhIrxReqxGZW/Oqp/w6TdqGDWXrovS6
	 peHmZC12V5BcYH1aYEYO9zXzCQNP0a4awdkhRQK16/pR9qT5kD9BBQVeSuYyLYrFoh
	 0fvEX55wK4mqlCNzL8WtvUX/Bxq4AO92HV1U2X74dmyU5v6eirZI/ciLA/LK/XYkgf
	 csMmLf6dkQr6g==
Date: Tue, 3 Nov 2026 08:35:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yingjie Wang <1075151112@qq.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: reject keep-alive timeouts that would overflow
Message-ID: <aun_JSS0cwnL9tm0@kbusch-mbp>
References: <tencent_E7828EAC883D49896E2EDD4FCCFE653E9909@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E7828EAC883D49896E2EDD4FCCFE653E9909@qq.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 04:46:22PM +0800, Yingjie Wang wrote:
> nvmet_set_feat_kato() and nvmet_alloc_ctrl() convert the 32-bit
> millisecond KATO from the host to seconds with DIV_ROUND_UP(kato, 1000).
> The addition in DIV_ROUND_UP() is done in 32 bits, so any KATO above
> 4294966296 ms wraps around and rounds to 0 seconds. A Set Features
> command with KATO 0xffffffff then succeeds but disables the keep-alive
> timer: Get Features returns 0 and Keep Alive fails with Keep Alive
> Timeout Invalid. A Connect command with such a KATO creates a controller
> without a keep-alive timer.
> 
> The converted value has more consumers that can overflow. Get Features
> multiplies it by 1000, and the timer paths multiply it by HZ in 32 bits
> and arm a delay that must not exceed MAX_JIFFY_OFFSET.
> 
> Reject a KATO whose rounded value does not fit all of these. Return Keep
> Alive Timeout Invalid from both Set Features and Connect. Validate Set
> Features before stopping the current timer so a failed update leaves its
> timeout unchanged. Round in 64 bits. A KATO of 0 keeps its current
> meaning.

Thanks, applied to nvme-7.4.

