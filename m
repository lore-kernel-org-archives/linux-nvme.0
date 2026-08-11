Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEEEC5AD55
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 00:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aP42WPQ5fnOZBn7zm5ygaXsFvMPeFOfcuO2bfOX+dSI=; b=hwFgnQmZYPlmmmxsvLCSQ7PndI
	B3KU5loOUAVJMwIvr1PpjTkuFTxyfAcbmYJ3mVzfaO5aaoVKr6SKu5Gq/RevjOsmFD/83tpB1hkNp
	PaERfKCfbz5W66mNqC9ZAWEPAZOfa6VjyhHhtwSrL6jblNKO1+odDjjOmylfUBx+CNrgX7IZlvsUx
	43iYKjMOe/T+OtmieDWrtPgHKhPRROH7OflmuKECWG8bywuRZAh/gFQj6ldbPIiYngviktAA6FUn1
	XyWaStbPopdd7zLgNQ3SOM8Ly0aDOJdEuhGKEp3HebmMdnt91WMiwYe9IaAVh/9Me/rTEPIqPOh6/
	ixjUc0ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtaWR-0000000D59t-12og;
	Tue, 11 Aug 2026 00:39:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtaWQ-0000000D59n-2SUV
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 00:39:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 07BFB41AC8;
	Tue, 11 Aug 2026 00:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3F41F000E9;
	Tue, 11 Aug 2026 00:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786408753;
	bh=aP42WPQ5fnOZBn7zm5ygaXsFvMPeFOfcuO2bfOX+dSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D2ocvKcaCe5xCXYtSMig0h0SmK8f8HHnfxBJh8qGi5Re68hpkkGtIZD9zCZe8VKDd
	 ZEmCTx9D6w0TK0R8OEc/2c9X7pZ6gnu9KacOr8Ht5Uwb1dPQr+dKYqydETVTOIDqJ8
	 xQThJIQcYHVp7+PuLAS5T5/Z6wEttt0fahR08/GMsTIm04agCpMgoTbmGc2Wo7eH7a
	 jah/X/D4QQ3o4TG39+KBK8ZRlKc4TQc0dFnU3Fei/MB0wnvkUG2ACnbUz7JegS1gky
	 qR5g030Y0k/t9GsUIJulVfrPBK+wq91B7KJVmKs3Zg79Px2E7ZUrOjriJsFrT0nOx2
	 vYOYKrJ6SZUuw==
Date: Mon, 10 Aug 2026 18:39:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Roy Shterman <roys@lightbitslabs.com>
Subject: Re: [PATCH] nvme-tcp: fix host memory disclosure on R2T for a read
 command
Message-ID: <anpvL_lhBNSiMqgW@kbusch-mbp>
References: <20260729054602.1237120-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729054602.1237120-1-yhlee@isslab.korea.ac.kr>
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

On Wed, Jul 29, 2026 at 02:46:02PM +0900, Yehyeong Lee wrote:
> nvme_tcp_handle_r2t() does not check the direction of the request the
> R2T refers to. A malicious controller can send an R2T for a READ and
> the host will answer it: nvme_tcp_setup_h2c_data_pdu() builds the
> H2CData header and nvme_tcp_try_send_data() sends the request's data
> buffer. That buffer is the READ destination, so its contents go to the
> controller.
> 
> The command then completes normally and nothing is logged.
> 
> Against a test controller that answers every READ with an R2T, a 4096
> byte buffered read returned all 4096 bytes, split over two R2Ts. The
> pages contained stale kernel data, including an array of struct page
> pointers.
> 
> Reject an R2T for a request that is not a write.

Looks good to me. Applied to nvme-7.3.

