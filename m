Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A9DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 06:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1VHFeVKHAwsvUapSFRr2ozVTuglopLIBem2+9x3EOw=; b=xeNP0HGuOuJ9jh/DFBGT6nhvb9
	cF0FyfGUU1En1CPrcYvEL0WsV5e2x/Qeh/JwWjCof+2MFiVvMWAC1PA5S5i2Q6UwPBdavVw9JNnJF
	bBOYCGdX978L7vfOoXkzrx9zJjoQ8b88Nsp8IKeEChTpLf9W10y0JXpIvpUEtf49L0WxlYxfonp4h
	4beP95CYk/dZo091YzHy1RsyY96SwP254fQ6FT7f/ZjA19Agoy2tLTLilJj1f6xyew1oWRmznKzGh
	gp3djaXOUzoJj7jEBlTLMq6p2Ponjk5c3sU8gGzwJcBjPLIjtEET9A735Js0ctA5Gd8aGqNrWPI/y
	zsh2e0ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq7ZV-008VWp-O3; Wed, 02 Nov 2022 06:49:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq7ZT-008VVi-48
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 06:49:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 623586732D; Wed,  2 Nov 2022 07:49:52 +0100 (CET)
Date: Wed, 2 Nov 2022 07:49:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: per-tagset SRCU struct and quiesce v3
Message-ID: <20221102064952.GB8950@lst.de>
References: <20221101150050.3510-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101150050.3510-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_234955_326272_E2F62843 
X-CRM114-Status: GOOD (  11.12  )
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

Looks like this version is acceptable now, which brings up the question
on how to merge it.  Most changes are in nvme, but it adds a new block
layer interface, that we'd also like to use in scsi.  Maybe the best
thing is if Jens picks it up directly?

