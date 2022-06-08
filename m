Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31AFC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jun 2022 06:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iCzJMq7eevV497DbRS3Wcvak7mFtIA/4hs5DEFptzrw=; b=YxnEqPAbN0Rp/0O9Jq0icr2yy7
	KBqIJ4AVUuViJS3HLp1Z3ZvAAlMddPYkAia4dPD6Y9O1FPpmDHbd4Nt1iDrzyHIwjZ5r1A+X4maiZ
	YCwnxchXVfFSdm1zgvBk/fReVWsA0xdNzqMG3MqhFm/s2UjXYXRvQaiD4PPOnIBwNdFv1xU0GhQ0d
	k5hhnT4Wh4J4tuPMIS+KRHTLS6bsNpOrTW1DLNBp71SAtDPemNdzYe7Dj6eQID8pp8Vj1gXibZJSh
	oW9f0GhJgVNtLf4T48tQkJlpi22wPsFgiLMSZTPKdaU3rmHr85QPrbuGaC9Vxd8J7CbGv2nAjcLZC
	MYTKjokA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyoqX-00BEI4-J8; Wed, 08 Jun 2022 06:07:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyoqU-00BEGu-1t
	for linux-nvme@lists.infradead.org; Wed, 08 Jun 2022 06:07:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BD2168BFE; Wed,  8 Jun 2022 08:07:00 +0200 (CEST)
Date: Wed, 8 Jun 2022 08:07:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme: Implement In-Band authentication
Message-ID: <20220608060700.GA7453@lst.de>
References: <20220527080457.90855-1-hare@suse.de> <20220527080457.90855-5-hare@suse.de> <20220607104941.GA26223@lst.de> <711d65c5-230f-32ab-4f5a-5594e2b3b7cb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711d65c5-230f-32ab-4f5a-5594e2b3b7cb@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_230710_281932_F8C1C882 
X-CRM114-Status: GOOD (  12.62  )
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

On Wed, Jun 08, 2022 at 08:01:22AM +0200, Hannes Reinecke wrote:
> That would mean to create another nvme module (nvme-common.o?), which would 

Yes, same as we do fork SCSI with scsi_common.ko

> need to be pulled in by both, host and target code.
> And really it's just the one file in drivers/nvme/host/auth.c.
> Sure I can do that if you think that's better ...

Yes, we need to keep our architecture reasonably clean.

