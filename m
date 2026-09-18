Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98514C982DC
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tMbox1gPjKZqJpdNohq4VuohgH
	EoVdRIKhj/6oz9/1c3V3SowFj3Qxe21MxzOq7Ypv4y3HVj6WXdkCarT7dw3WBt7wpuBPaContiUix
	qVgxaPNHDgH89GyStSOAMPEUKFKB6NGKlxCyeEi1QLlnwTVMpogyBEuNOM/QhEnRhYjSD0MS7xdBo
	e91m4rcDrW8ZHw/Zi4fHenYFpT99+OCDrhljEAPwwuvM6CudaIqHhMgxzScJu3CluT1Ljmg9VfcKT
	/YdpNUf9cCz0AMC+7bD3vOcRBHY17ydDmhP54WmH+kVduuf2peluEQcQIy/LnuyvqginaHxz2FuKH
	tEoffwfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XkR-0000000ENFQ-1ASc;
	Fri, 18 Sep 2026 12:31:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XkO-0000000ENET-3HbQ
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 12:31:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06D4D68BEB; Fri, 18 Sep 2026 14:31:15 +0200 (CEST)
Date: Fri, 18 Sep 2026 14:31:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	co+77553a7fc66ac133@bugs.sh, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: fix out-of-bounds write in
 nvmet_auth_challenge()
Message-ID: <20260918123115.GA17110@lst.de>
References: <20260912171009.1513289-3-bestswngs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912171009.1513289-3-bestswngs@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_053120_962546_6C22495D 
X-CRM114-Status: UNSURE (   9.24  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


