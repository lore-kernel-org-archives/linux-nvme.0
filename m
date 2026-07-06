Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2480EC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQmZC8XSGU7d7u4Up6pxYk0RmHqY7ku8v476tIPEZNc=; b=eGsvoSCvjAb30FNkym4bg06fD0
	vGzxDm10JrQMiTT55+ZWr30+UNB1VXFyAMf3UpLzF4RXJUv9ALbCGqtFPk0KZMatluA3x3ZeV108o
	4aQAcvS6pfsr7S16CEExxpNonVtuJulp5xhLhcPi7KCFYkQ55a3A6c/xNUmKAJ8zfgNTtIqgPvl7F
	mCDqyZhPcLT3cF3B2M4svbGpFSqwYkxHVEk3QO9TKasRuK79q7KmflVqnJJM6jst2n/Z03PB03+NU
	LiTWpkGmpaQ4B4e4uEv3wQ4Mk2GcE2J3ZLKbnuDaok2lQKP2ChSojaTLNlhyRuYTrKabJnvCXyKt4
	XTZoVh1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoVA-0000000DOVj-3ipk;
	Mon, 06 Jul 2026 18:57:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoVA-0000000DOVX-0ELd
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 18:57:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D57A600C3;
	Mon,  6 Jul 2026 18:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0503C1F000E9;
	Mon,  6 Jul 2026 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364227;
	bh=tQmZC8XSGU7d7u4Up6pxYk0RmHqY7ku8v476tIPEZNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mFFG7CaqcULiBW8ygtZyMdT9J+nFC8JTMfk0iBHfrXycDt7GXFn7Jz165NdqGqNzu
	 VtOg+qCSqT+TDayN7ucKHjFZx6pbfMSGULVCGL7qs1OF6ZJsmlQfWu935aGAfUtiU8
	 1TWHSdTb3fappLiaDyjIFLjGLu5ISxHWeiJM+ou7TW9WEMrz6qP2lFRVfo7pzBIt+j
	 EAfaDuS9DvSNbLMfhjyRavjOCkBCaUsDn86iiw3N7CBo9TgjQ4UBF6A4SRB19kw3jc
	 yTXKUuaSwBBnLexkYDDxwTm2NXD66sgRM1GJEFc1M+vMZX81A4dvSSTfyNNz+PdCPY
	 OYC+omtMuKQNg==
Date: Mon, 6 Jul 2026 12:57:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 0/2] nvmet-rdma: fix response resource leak on queue
 teardown
Message-ID: <akv6gcd6-mT7lyw9@kbusch-mbp>
References: <20260629051529.810925-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629051529.810925-1-shinichiro.kawasaki@wdc.com>
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

On Mon, Jun 29, 2026 at 02:15:26PM +0900, Shin'ichiro Kawasaki wrote:
> When an nvme target with rdma transport is removed while I/Os are in
> flight, a response can be posted but its send completion is never
> delivered before the connection is torn down. This leaks the request
> SGLs and the RDMA read/write context. The leaks are recreated by
> running blktests nvme/061 with rdma transport and the siw driver [1].
> 
> [1] https://lore.kernel.org/linux-nvme/ajtk1CaN1pBreS4O@shinmob/
> 
> This series addresses the problem. The first patch is a preparation
> refactoring. The second patch fixes the problem by reclaiming memory
> objects on queue QP teardown.

Thanks, applied to nvme-7.3.

