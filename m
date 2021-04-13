Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA4AC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 08:57:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63215613AE
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 08:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63215613AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NC9lNMvf2jBl1oEsvVhw03VIfwc5DGDV82s3kPHxUPw=; b=iTy47Zh8tu6kINncHHs63ZpWV
	N+rj4AS5bgwNV1R1IKwepV8ZWTxrmvemhGcxnB9ChT9E1XWMygXNrblrmtSJPQ8mM/E0muPCdC/tw
	Zrlay0ysb3DeFHL5HhKIbY2xCzC5J1RNpgW2wOX/2j69b+6W0ux6wYI5or/dSfE17gMlPeNJjJKeW
	Bka9fZd1WWjjgRaPPV6N63VKBONNZwGPduilHOn2n+3Lf05mOzPeDwgSE80KtTelS7dRY4BomsF5h
	FqQ2uzFzLibaX3phdkIRGx7UUDsMwmdb6pJnadnScM5ASiODhtNdjcElMcl8IWaEpvok68HvPF9bs
	HBLH5cEAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWEr2-008cB7-Pp; Tue, 13 Apr 2021 08:57:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWEoE-008c2a-PY
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 08:54:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=034zy4yCs8jtPYNP+O2gdDkfdotDPhtBPZSnBJ2RVX4=; b=kr4lMCYQn3IcD97nGCY3oqwrUv
 Vk1R3NHiL7Kjl3Zo+fkzvXdibalIFffHkITaxlu+ihwPwKDLUfroo9SYsDUspeduvtGVFpvoGFBQ5
 Rb+NbIxpOHZ1QRA68OCzYhakxlUYf8S5lRFuRLv3ZMWIMBe0VlsUiYKprn5MaR3R1S6W1NymYcQb5
 rHnDzsHUfy+Z8bdjG5B4ESdTY/ocJFB3QQ24orxJvapG5zvN1gwlR1D0tC2RnVeN9FAW7GkQXUyA8
 dmDeTRwO7ekXt3qRs8xoSU14VJ9s/q6him6aq4VTrcoX+nPCxeMy9PHmu21AEurCU0+T0OQChlnFw
 /3v+1Cyw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWEoC-006qdF-6Y
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 08:54:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 82D69AF0E;
 Tue, 13 Apr 2021 08:54:05 +0000 (UTC)
Date: Tue, 13 Apr 2021 10:54:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Steve Wise <swise@opengridcomputing.com>,
 Leon Romanovsky <leon@kernel.org>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Message-ID: <20210413085404.tzam5lprtspwcek4@beryllium.lan>
References: <20210412122330.5166-1-dwagner@suse.de>
 <20210412123149.GE227011@ziepe.ca>
 <20210412124909.olui5hfhceakt4u4@beryllium.lan>
 <20210412130402.GF227011@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210412130402.GF227011@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_015408_404265_DA7DA55B 
X-CRM114-Status: GOOD (  13.27  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 12, 2021 at 10:04:02AM -0300, Jason Gunthorpe wrote:
> Basically the allocation of importance in the workqueue is assigning a
> worker, so pre-allocating a worker ensures the work can continue to
> progress without becoming dependent on allocations.

Ah okay, got it. I didn't really understood this part. So the
WQ_MEM_RECLAIM is 'just' avoiding a new worker creation.

> This is why work under the WQ_MEM_RECLAIM cannot recurse back into the
> allocator as it would get a rescurer thread stuck at a point when all
> other threads are already stuck.
>
> To remove WQ_MEM_RECLAIM you have to make assertions about the calling
> contexts and blocking contexts of the workqueue, not what the work
> itself is doing.

Hmm, I am struggling with your last statement. If a worker does an
allocation it might block. I understand this is something which a worker
in a WQ_MEM_RECLAIM context is not allowed to do.

My aim is still to get rid of the warning triggered by the rdma
code.

Anyway, thanks for explaining.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
