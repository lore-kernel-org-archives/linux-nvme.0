Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334F9C7EE26
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TB3IaHojI0kiFfUCF8lOY9Oc2AGPx+Cs1Qczy+ZI024=; b=WssoIkRKy9FeDTu5qyNXRFR0jy
	xKVP0GTVUJREXVK+vTXVwAQ15UkWfoJwqUWnrlgRX5zmUxCilkfO/3x5srIQJ8pRdN0dOKT83fV6i
	KNAGTLz10Qpr6Twx/mhAKPi+Lr3M9G5RvG1uZZhG9ttzoQ2OaHKalZ0VVjn5dV3/SY/3Xx6sSf/fy
	GI1s5eqVtV/4hUnu7tlFLpAdKwCWA1YX530iMALYtnk53kY11oo73zDDOJIm+4geVASGZi/WsMcaU
	K7/cREOPNVm2HnAvThycpXrLvHXnxBiCBqdkZbm/FVA64oXgYHsaHC/uaAS/MrrStpaXsNaNcZrgq
	Uv3YunHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1WkB-00B6oe-1O;
	Tue, 23 May 2023 18:28:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1Wk9-00B6nv-0a
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 18:28:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0EEB761172;
	Tue, 23 May 2023 18:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D9BC4339B;
	Tue, 23 May 2023 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684866499;
	bh=whVz3CRsD3wwwzUZWpPeMCHSk27FLUf7aoxGz/4IABE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOll17MhgP6cz5AQPKcFmni9DHNr8S6ngjHpITn2CVequbxcJ5y2B8pIX6t4vbmca
	 W7u4KdhZOUCgbzcJ7l3gJ6Q5WkwgID5dpFw239z+pAdwMY/RbSMmDLJ1ZDKZHXBhN3
	 udHtDmuAVjYX8QAG4MzMgbP8BjwsktA8Y4HNGtpxl7jl5FljBahS76JtrVPEz3Z+uc
	 GCEmTDNvTYnwBahDGAkegTwizSaczNJVqtRUZMDeIWILKghdzy9cY7SmUqwTaSH5FZ
	 nlVsY5mdmwjlSPVeAA+ptA0KPlm48ERCL0vIrFK9qkOnGQrk9C4qVmQk2E+bDCTPQC
	 tLvBepmwDz0ow==
Date: Tue, 23 May 2023 21:28:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org, parav@mellanox.com
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without
 WQ_MEM_RECLAIM"
Message-ID: <20230523182815.GA2384059@unreal>
References: <20230523155408.48594-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523155408.48594-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_112821_276910_A764B9C6 
X-CRM114-Status: UNSURE (   9.82  )
X-CRM114-Notice: Please train this message.
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

On Tue, May 23, 2023 at 05:54:08PM +0200, Maurizio Lombardi wrote:
> when nvme_rdma_reconnect_ctrl_work() fails, it flushes
> the ib_addr:process_one_req() work but the latter is enqueued
> on addr_wq which has been marked as "!WQ_MEM_RECLAIM".
> 
> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
> [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_core]

And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
needed.

Thanks

