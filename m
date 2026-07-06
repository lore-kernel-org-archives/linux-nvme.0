Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B48FC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsSIAjOLnABNJqBtgqhHACXixeIdT+xpQPDENfSL7hQ=; b=DTE5HRYkQ8JgYbCJdZ8Y7bP3n1
	wRzt3ZrBXDsAry8MXUUAX2UbjLcl0/OkhMNFSDPi9hrot7Clv8tEgURYAA/QvVMjvTcdTh6FPqoNH
	SUwLY/KzWCJXhmlutHf08WhFON3DpidIJS3iJ5vbv+Ag2huctXec6wrSSrTN2gM/kKuXQG9a15Uk/
	/AcX6iLFBZe2PkyCHTh/CPBLEpAJlAQVTt1MYLFvo8ByCL1EVqSCRb/bbupRFkHOaob9VbGEJ9Fua
	pi+lY1jADJsbqCAGAvJZKKX6aCrTRQGfg334eAgkoPbUCSjOBv3k2FU3ksHWm8ruZhNbwk/akjGBT
	TJgJeVMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoSq-0000000DO1Y-0pGI;
	Mon, 06 Jul 2026 18:54:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgoSo-0000000DO1F-3Kli
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 18:54:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 472CA43720;
	Mon,  6 Jul 2026 18:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80F61F000E9;
	Mon,  6 Jul 2026 18:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783364082;
	bh=tsSIAjOLnABNJqBtgqhHACXixeIdT+xpQPDENfSL7hQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L8AInBKa7y9Cz4KmyEDk59R6K4HOZc1NM/nWXxxdJk1+U6cNOIWeCrblcM0JKE+41
	 R3Kcwgcck449HTy/Mci5VL18TsoCzvc98BFL7CbYJ+0ZBi2+BjQFtV0owQjmr5kdTf
	 TGQjPuH7yX8mT3upgVsiekeHRQZuTJkLnBgXw8SZlzf/icizRRAH/gOqQi2MnUxEYA
	 Sh8M3UjQeFewrK6aUnebkOqQqOct+f1GWGIaDV7o/Asr40qgsAVbRLDSXf2h8GGMWr
	 eeDcZFBum+RGSuKYR3qUknu9u76zmoK9H2ureeBhW2EtovCHz+9B9vPdP2yeg+Sz/b
	 6QxhwEjXcbi8g==
Date: Mon, 6 Jul 2026 12:54:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix typos in reservation related constants
Message-ID: <akv58F9AZSvxl1BC@kbusch-mbp>
References: <20260622033254.1350917-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622033254.1350917-1-kanie@linux.alibaba.com>
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

On Mon, Jun 22, 2026 at 11:32:54AM +0800, Guixin Liu wrote:
> Fix the following spelling errors:
> - NVMET_PR_NOTIFI_MASK_ALL -> NVMET_PR_NOTIFY_MASK_ALL
> - NVME_PR_LOG_RESERVATOIN_PREEMPTED -> NVME_PR_LOG_RESERVATION_PREEMPTED
> - NVME_AEN_RESV_LOG_PAGE_AVALIABLE -> NVME_AEN_RESV_LOG_PAGE_AVAILABLE

Thanks, applied to nvme-7.3.

