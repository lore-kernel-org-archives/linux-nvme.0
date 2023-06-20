Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AC1EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 04:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+LCkNxzaY+8wKoWJKVhA5qSOzKdr+ZJkUtehxZcSxI=; b=t5y94tGHHxTNKlFuTtrJJC0rmy
	OnP9Rh4dUbeb7zvuPB5JPAYBd+UbcgIcdyjhgt1cVpIhk+RuVVS9+OyOhOw/wlY753EW1apXWrrlf
	BSSAaiY9SA9fRwBthedVd8EfgpUNgcymoM0pWpsp/Vvpuf/xD51rUfI3zRskRnRw2cEmCwWKD+0xU
	TdeodrMeaLum8WG1Az1Q1WuyrZJchnAKBrEd4gdkUkYVS2MuL6yy/Q8DOpAMgABkcLvZfWXig7umq
	CqWT7GRdjpMN6oLr9T5Izga6IlibLhQKKoGJzNpvs3Cf9LzBJPksP/54dXYYrDfrZIIU4cvVKNysy
	EK2OVStA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBSys-00A7jF-1s;
	Tue, 20 Jun 2023 04:28:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBSyq-00A7iI-1p
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 04:28:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1096D68BFE; Tue, 20 Jun 2023 06:28:31 +0200 (CEST)
Date: Tue, 20 Jun 2023 06:28:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-mpath: fix I/O failure with EAGAIN when failing
 over I/O
Message-ID: <20230620042830.GA10371@lst.de>
References: <20230619141036.1051673-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619141036.1051673-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_212836_768286_FD5D5C78 
X-CRM114-Status: GOOD (  11.32  )
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

> +++ b/drivers/nvme/host/multipath.c
> @@ -102,6 +102,7 @@ void nvme_failover_req(struct request *req)
>  	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>  	for (bio = req->bio; bio; bio = bio->bi_next) {
>  		bio_set_dev(bio, ns->head->disk->part0);
> +		bio->bi_opf &= ~REQ_NOWAIT;

Please add a comment based on your explanation in the commit log here.

