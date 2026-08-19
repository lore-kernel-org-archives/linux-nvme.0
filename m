Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4350C5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ft0TIVIhK6YqJWjdjM4hVMOESHGBcv8kDRRUI2xbzJA=; b=gCC30fVocSw0xyybYOkffntg08
	jLHO6DlSep3hNGaww5P9bJfflyAJjkuI8D+4EcXC7EreIvnTHE833W6xekuAbqyKyK4AS8qhbBx3m
	BQUCzmEo0T2SIjYoIlxzbgpvuT7QTPiZRrF+LPzdffAXiVzv+lD7Girv8cw09iUWAObD6ASsLHgIg
	PXy/UArJKBQog7orQZVEfWmidQPyW9DjNYNLmJpj0+6hXZ/Jcwr7P1Qgz7Z9CPqB4EjzLdVYmKX0h
	2bMJ3EB6VLXQItC4GY+iBVj2/qrmqUblztP5y9WAsON+QvbaUHi3pdLN19cp+fUduDjoZVICnG6Mv
	WXkjCTDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiGR-0000000A5oI-0XMf;
	Wed, 19 Aug 2026 15:31:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiGP-0000000A5ni-0vTa
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:31:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B897E43CDF;
	Wed, 19 Aug 2026 15:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2A51F000E9;
	Wed, 19 Aug 2026 15:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787153496;
	bh=ft0TIVIhK6YqJWjdjM4hVMOESHGBcv8kDRRUI2xbzJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FYEH1DrqsCq6I+Oy1IuCybqPUnwn5wv3cwkagbn94vxpYdIiY59WGVFSg13DHcUNW
	 Y3hqjAwwnD2FaKf/0yDq9UFSWDETwsubhwlJMtGWpZxyvWrWNJPv6FQoQqmfQRiN5M
	 9S3B7QQAOzhO9YZbPDU0S3bvBOkyH0KUrbC1tNlnzVmhJKqfheAZ5Fjvrldr0qfbAL
	 3OJhpHdcnO0RyvHtGRZR4BzTfD4F8/7F8CvhBsB6Kd+LMSojTVPrS3l6w+jf++jt/f
	 9JZ8s9lrvafFq1rSxPw1W5UUTQg9mI8HJK7TDZs3f98zqO1KahRqtFjARVm5ldpq/q
	 am/Cbv2piClug==
Date: Wed, 19 Aug 2026 09:31:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: check the data direction of a C2HData PDU
Message-ID: <aoXMVth65hKTNjXk@kbusch-mbp>
References: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818110405.590548-1-yhlee@isslab.korea.ac.kr>
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

On Tue, Aug 18, 2026 at 08:04:05PM +0900, Yehyeong Lee wrote:
> nvme_tcp_handle_c2h_data() finds the request by command id and checks
> that it has a payload, but it does not check that the command asked for
> data to be read.  A controller that answers a write command with C2HData
> therefore reaches nvme_tcp_recv_data(), where _copy_to_iter() hits
> WARN_ON_ONCE(i->data_source) and returns 0.  The receive path turns that
> into -EFAULT and resets the controller.

Thanks, applied to nvme-7.3.

