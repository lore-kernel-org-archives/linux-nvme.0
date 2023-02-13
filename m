Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97451C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 06:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1d2Vt8yhqEL6LpHlInmXKo/qDvo425TmjR6FX5KhEf4=; b=A4HjLzL+iWoxYeSzopUHsIdWgZ
	Lsd2w1a9yW2LvUdojzd6Lghb4WsWP3WW+Uana2xBEJEAEN4iXteiX+WItg24ZLonjzlIoCksshqn3
	cfw2kdvCXmiTPBGdmzMzRq2wDoc3qAppRHNxexawT5zdi9Wfx+QI5nuYKCXQus07v+1qiNv7yje3R
	g1ujLdEoD4J0qaZwWlVZGztqzVXRn+m8IVUSvEAX41klFY7TGwcCLTG6ZuyqnbVKYPdDcg3mOwH0u
	eTi59yu/LZDa90Mb1+tIkp60Vl1dX4AvzPH55MIQud+Foi1nFTgeVnf3sGJ2lG7641VaBECNK5NOp
	r57uiszw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSDr-00DKWh-Ta; Mon, 13 Feb 2023 06:21:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSDo-00DKVu-TU
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 06:21:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4B2D68BFE; Mon, 13 Feb 2023 07:21:49 +0100 (CET)
Date: Mon, 13 Feb 2023 07:21:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: make blk_rq_map_kern() to accept a NULL
 buffer
Message-ID: <20230213062149.GB14223@lst.de>
References: <20230209143820.118097-1-hare@suse.de> <20230209143820.118097-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209143820.118097-3-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_222153_114238_D4E43FAC 
X-CRM114-Status: GOOD (  10.46  )
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

but you really need to Cc Jens and linux-block for this one.

