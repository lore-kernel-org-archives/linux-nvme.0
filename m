Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3FBC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y287czHF/J/dWFrBtF189OmJCQGAVzMwcw2a2GsKcDc=; b=F4HBamic3gol/25iXb/jPOZ/mB
	sVOzYw7Wwxi8CNi1x2cHur7apmVyG0jB0jl3jEccuzLSClGQvJWxu6J9pVFnyvoNawSmj7Wx8PkP8
	fDMTQuKD5DYSIv2059gJN6M5PHx77F0DKqWynHRiyErGA1cArzuZuUSp4xGYnVK/J8cbgCqHRK0Kq
	2gDlzgxYhNqV0O62J/JFdHvgctKPTHGnQPf9EJv/adjp5Gqg95qt7EphKonhYCzsbQ7E+CMOFYd5a
	olkCFrXy1xWL7OSawbDfiCCj9pQdGhB8TKWK/rV5mSb1TNGBeDrU24ZuSdTEyjKmCv3H5ClXQ/Uhz
	8o02+y5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwnF-00000001hWp-0Duk;
	Wed, 19 Jun 2024 15:00:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJwn7-00000001hTi-1Syo
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 15:00:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27CE168AFE; Wed, 19 Jun 2024 16:59:59 +0200 (CEST)
Date: Wed, 19 Jun 2024 16:59:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
Message-ID: <20240619145958.GA2254@lst.de>
References: <20240619145553.89736-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619145553.89736-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_080005_671267_35997027 
X-CRM114-Status: GOOD (  11.56  )
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

>  	if (wq_unbound)
>  		queue->io_cpu = WORK_CPU_UNBOUND;

None of the above computed information is even used for the wq_unbound
code.  This would make a lot more sense if the above assignment was in
the (only) caller.

Yes, that probably should have been done when merging the wq_unbound
option (which honestly looks so whacky that I wish it wasn't merged).


