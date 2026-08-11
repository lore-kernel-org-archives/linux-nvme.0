Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5E3C5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E08UpFHu5hxN+1hMKTZjWNxPsM8o+k329eLQADLj7n8=; b=TTW9D5Y7dN/fE3uvbgSmGlGMnp
	t2mv21QP718Xqj766znmyCshg6tOU8Jp9LQ4MoZHiKS8I2DxLBge2uKj6VT5d6ijLZBU8gjyM+2pX
	BMI6soiFRcgSLIn54vU0N1phRs/Mr+b+WwG/9mLdu2gx4RS03d5EhXqrMwtRzJIfumlNJyMK4qhtU
	e0V5t6zynJo3k6E7KSHthdv1tKa/vETrCTVkyASDmplPW0z/oneTofxG7P1eDXORD0Vvqa29dtE9U
	ApaCPw1UqlnpNOtTeqB+UXxnUaNVJW2GeNkx7wZx5ZEKkUVZM7IfxfljgRGsubr//azrRYC0+E1Aj
	fF6PrxCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtpwN-0000000EbIT-1Fz8;
	Tue, 11 Aug 2026 17:07:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtpwL-0000000EbID-2Kt5
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 17:07:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E1888600AF;
	Tue, 11 Aug 2026 17:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7E61F00A3D;
	Tue, 11 Aug 2026 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468020;
	bh=E08UpFHu5hxN+1hMKTZjWNxPsM8o+k329eLQADLj7n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gTb1Y+yRm4yxZejz1qKhXcxRERX6ulEq62BRGc5FlNYeItDtwXvhH6VXq9B8sKa/H
	 zYtWJKIXLoFQjyPxlirwZX2dG3cx7Iz0+2aUvE5h4336QhJ4aMaPJinBTCyDBWzuEO
	 CXYqhQCdxemlx3b5sPFtCwu7ODGVW8BaX3C8ci/z6tuog7PMBqLyknNzvjc/C0ccR9
	 YTZa+10zFVBN7q30xyiQN0ZADj39SkZskcqaWXM66L8jQrOOF52dIHY8Uok+2UF0Lk
	 O8vJqEBdYBfZ31ZimZ4dcYVl4x5/kJGoQ+kIwpURkKsN0DVKSt08zKoJwJ+Haa2oW2
	 M0x4uXlgFr5VQ==
Date: Tue, 11 Aug 2026 11:06:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: ratelimit the completion-path messages driven by
 device data
Message-ID: <antWsjQGe_C7YEi0@kbusch-mbp>
References: <20260810220258.1960208-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810220258.1960208-1-coshi036@gmail.com>
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

On Mon, Aug 10, 2026 at 06:02:58PM -0400, Chao Shi wrote:
> nvme_find_rq() and nvme_handle_cqe() print an unratelimited message for
> every completion queue entry whose command id does not resolve to an
> in-flight request.  Both are reached from the completion interrupt path
> (nvme_irq() -> nvme_poll_cq() -> nvme_handle_cqe()) and the decision to
> print is made entirely from device-supplied data, so a controller that
> posts a stream of bogus command ids drives unbounded printk from hard
> interrupt context.

Yeah, if a controller is so badly malfunctioning that only garbage is
getting posted to the completion queues, then we don't really get any
more information by dumping every single instance compared to rate
limiting it. So applied to nvme-7.3, but with a minor fix to an overly
long line.

