Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95DEC982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 15:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vWbnyU0SIgiw4rSTlOVLNiUE31FvcrcAMlwh1SgQDVU=; b=lXEHZFWiIk9Y0h23MI68Wjqz8c
	3yote64vQuUeuC62h9RK55A0pY5eOrrMIInQ7Y9KSaHgDi7LBYzfPGzJg2DCacoS1/6aY0dr0F/ZT
	QbEUT+kx1A2oWTTQ2uTZCb6MkRi95T+E2YjDUXxbtaMOyEdrp0CYobQ2ddN1Oitl8EwjXgSWQIF3F
	mEpgu3RwqsO72Spk11cr3iMebIM5AnsnLrHxpDn7SadUcW8bUFkwXHYxsLyKDQCuNYzfyhynBWUY5
	F9MCJb6gam9PuOMwHq/e42KS9sqsHHiN3K2MQsh7E3JyRK5s4NK7wwSC8JQvFbnL5DtMBGmiKnZXT
	6aqd672Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aHC-0000000EqJ4-3s7B;
	Fri, 18 Sep 2026 15:13:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aHB-0000000EqIc-2YSM
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 15:13:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 12837436EF;
	Fri, 18 Sep 2026 15:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D36E1F000FF;
	Fri, 18 Sep 2026 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744401;
	bh=vWbnyU0SIgiw4rSTlOVLNiUE31FvcrcAMlwh1SgQDVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=miVzFX9igZ3PVWhA03s9dixOyKMPS4l18Vo4R3UZHusUIIo5y72rf7ft8SXbvbra0
	 5H1oR4Ae9sXBOHiavSgXlY5Q3lGSQWC22Ypm/wERkDEhpz4M/53jSw5I8cO2MuCukJ
	 zXOrNcmM63/vDw3ty7ZfiX75v0lh5KgF8Tt7YS1RqcWvg9Uuk1Z2bBvSyjkk39KuDv
	 vEV/FUpUPgojJKQvYqw4JOTmTDrXwVhD1NDwPT2077zT1Z0fibKdz+RNjECMEc9ZTI
	 VGwQ6MBFc9L7eBpf/FDWvo5Bg2rOub6CgPMnrMr0zdcUv6GMp07VUYzJm7TGEiubuX
	 vfBUfzFJFaKKw==
Date: Fri, 18 Sep 2026 09:13:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-multipath: fix underflow in ANA log bounds checks
Message-ID: <aq1VDfSe-YJU73Nh@kbusch-mbp>
References: <20260915021956.3142320-1-4ncienth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915021956.3142320-1-4ncienth@gmail.com>
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

On Tue, Sep 15, 2026 at 11:19:56AM +0900, Daehyeon Ko wrote:
> The number of ANA groups advertised through Identify Controller sizes the
> ANA log buffer. The ANA log header and group descriptors independently
> supply the number of groups and namespace IDs to parse.
> 
> Both bounds checks subtract an untrusted object size from ana_log_size
> before comparing the current offset. If the object is larger than the
> buffer, the size_t subtraction underflows and lets the parser read beyond
> ana_log_buf.
> 
> Check the current offset before the first subtraction and compare each
> object size with the remaining buffer instead. This rejects inconsistent
> ANA data before dereferencing a truncated group descriptor or walking an
> oversized namespace ID array.

Thanks, applied to nvme-7.3.

