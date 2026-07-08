Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38484C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDI6BGSEuG2t4ck5UwUYb0T8+zwpMgWKNt7HC+naM70=; b=Ax8iUtJXeyI41jD+DpRLRGSvWo
	C/LWVtU7TYMyIhpe5tSUCWOw3zenBKA5fDegcuxA1b8DiDRT5258M5aa+MAenHrT/Y4y5hVWyqAtl
	0R2gd5iX/ShEjOFo0Uu35tcf7zQrvebdbhJunVAjZW/GEk2DxObxKRCcmLOtiaYqJXlQJBm3UePaX
	ozil+6GS3zwdKhajLBQwdtps5+uL/E9mkpTp4Nql9ETzocwFgkd8wqIuv4VADrAjA1cIukhl6bBHl
	u/7dcVWs5U/nuIr6UAHa9IJnv4ciR4hN1OWb09ZfMToqFzm8QnEb7k1suaUMFbERcHky99O0z8Qhm
	6pdYjsAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whXjA-00000000FNo-3jkd;
	Wed, 08 Jul 2026 19:14:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whXj9-00000000FNe-3t0P
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 19:14:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 11B176001A;
	Wed,  8 Jul 2026 19:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAB21F00A3A;
	Wed,  8 Jul 2026 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783538073;
	bh=nDI6BGSEuG2t4ck5UwUYb0T8+zwpMgWKNt7HC+naM70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mzIBFCBQdLz1+1PQW9QcGevY3I6q2oIzVaNjatPPtHTd0ljOeeZVHWS1AKzF1pZY5
	 /9oXBqoyKG+gj7xcuL7PFoXffJetpG6p4L7Vt5eAPlb6RyUEZZo0vlsuuTskosK6UU
	 NC8Af87BGXapwDaMjZZwVhz9c3YpdLXyzFVWX/SjV7Dd9v4IjLTOexf5HbThZRwac+
	 kr9iVMOL3I6B87QuEQPIVxtcsObiCFu2YuQYYYNiFMS3lD/UUXtlcV0zL0fNUqFV44
	 YGMv+RgYOoFUGyEITdhqtu1Rphb6fiQrYiahzX5TMUZ+oOHhNGKJGNTsPSR44mHAf3
	 4H2zPHpdaHHaQ==
Date: Wed, 8 Jul 2026 13:14:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.garry@linux.dev>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH] nvme: swap synchronization ordering in nvme_remove_head()
Message-ID: <ak6hmIT89wiKXbOj@kbusch-mbp>
References: <20260707135744.1470014-1-john.garry@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707135744.1470014-1-john.garry@linux.dev>
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

On Tue, Jul 07, 2026 at 02:57:44PM +0100, John Garry wrote:
> From: John Garry <john.g.garry@oracle.com>
> 
> sashiko bot reported a potential issue in the requeue handling in [0] -
> the code there is same as the NVMe driver.
> 
> The issue is that when we schedule the requeue work, if a bio is added to
> the requeue list afterwards in nvme_ns_head_submit_bio(), it is missed by
> the requeue worker.

Thanks, applied to nvme-7.3.

