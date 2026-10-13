Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6668CC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmTOPGpQZSsezT89evOrRzrwiZDrosNujgYWJI4q9Uk=; b=tQqpRvcEA28qeLUNTE8ShEI6Qu
	/ew12vksr4A5zqTglXgkZxGWIOdPZnc0MKO+W2Kac29IaiG672lzn1m/zRHADsPZiRx3pAqXQsveh
	oOaZz0H10W8NN7y8kYuEZGHDOCZiTiOLwIgmc/QKwvbvdubGfV2EmzpdRBd8tqnAPqa7kWRFf2ZDj
	s3p7+djj9gdqT/APd57a18B6UqkaID9PXzcz1bakXfO+mlxZN/pgpDuQxzpdEPgttij+PJJPNgGGw
	z3pGBiKqF3PBUno1vgNUsCyd9YROgDXb1zLthcet096hrS1DMGg5nmG8LOcXNIJJ2NR7ZP/MFIu6v
	tF/luYbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeXJ-0000000DMZb-0Sr5;
	Tue, 13 Oct 2026 15:35:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeX9-0000000DMYQ-03bm
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:35:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 719F760A56;
	Tue, 13 Oct 2026 15:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C421F000FF;
	Tue, 13 Oct 2026 15:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905718;
	bh=zmTOPGpQZSsezT89evOrRzrwiZDrosNujgYWJI4q9Uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=etBCBMfoKvFQBM2KEKSlpDuR/ieZv/8133m+fXRuDTxmXisK5wELY9LPWbndbHWE/
	 ye22TC9f5e7UMWIE3+rMZx9oxMCK6z7yBcOA+P4zRx0mc417XCRzfYIvEs6EABpveX
	 DPv1W8wz/l9re84b4SJxDmr1nyyEA4Y40ZtL7dcmJpXwTa1gz60ivynodjHuJEfZuC
	 Otvf9R6IXbbiQdfabVMgqMXRxuIbvyzFRiebURLCqB5oJ3y+fURYH9MBUZ9NZ4f5Ur
	 dT1AQ6Yq7rVVHSzcGgcwr4owpBX1wBNesz5klcewmiPHjHhdRF2QTY9qAEx0DJEGFf
	 RISgPs6hG9KfA==
Date: Tue, 13 Oct 2026 09:35:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	gjoyce@linux.ibm.com, chaitanyak@nvidia.com
Subject: Re: [PATCH v2 0/2] nvmet: passthru cleanup and fixup I/O hotpath
Message-ID: <as5PtFJNZbNT5Hk7@kbusch-mbp>
References: <20260929112751.2985483-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929112751.2985483-1-nilay@linux.ibm.com>
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

On Tue, Sep 29, 2026 at 04:56:46PM +0530, Nilay Shroff wrote:
> Hi,
> 
> This series addresses a race in the passthru I/O hotpath where
> concurrently disabling the passthru controller while I/Os are in flight
> can result in a use-after-free bug.
> 
> We were able to reproduce this bug with NVMe/TCP configured and by
> injecting an additional delay into the target-side I/O processing code.
> If the passthru controller is disabled while an I/O is still in flight,
> it results in the following kernel crash:

Thanks, applied to nvme-7.4.

