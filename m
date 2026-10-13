Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F82CC6B0F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NxBdvSRldggecq/rFiqUTEMYXKC+sFJ+J9acL96OkFA=; b=BJxXy6wA4N7o96e7NC+10KonIB
	aI14fry7SkugSmmape5ibdOwPdQlQQWXEbwHWEzlmIhs0ty3L/Dl0LzoMGjS7NTtKuwUyesLPNGDe
	ofrf1iCtPb0ukqpYv5nqU1pTw96Txyt7XDEzBhLGzkU3GdeNZLpeN7oBU2I06WoU99QHuWrl820FZ
	JkOTNzxDxMsdYWlc4Ey8mlaOkBeQX7uEnu9dfwhzgV1cRDtcUNKIf+YRxDwSMs1ODhLbptFQkYR1s
	dOVt26hXVtBa680XVLak4fJWMOiKI8fmXdvdv6BRYv+SyZAUFVMi+L+jAwr6QhCGjYKRy1pOPE1c0
	U6pf1tGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdMP-0000000D4M4-0cfr;
	Tue, 13 Oct 2026 14:20:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdMN-0000000D4LB-1lrP
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:20:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB517227A88; Tue, 13 Oct 2026 16:20:03 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:20:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	gliuxen@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] nvme: bound FDP config log reads to the received
 buffer
Message-ID: <20261013142003.GA14422@lst.de>
References: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_072007_608184_587DA27B 
X-CRM114-Status: UNSURE (   9.91  )
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

Maybe we should cut the long trace in the commit log, but the change
itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

