Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53E1C4167D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hnM3jaZNA8impusrL7Dp4X+d9jMpAh0GB5+n4uPr2Oo=; b=HPDvRza8mUim3SakgTzGy7SNMh
	jJ5Cf5QJVU/nX7A3DanGG9M6GNSzixNhmgkbVyH6xRXk8tBqCFbSNlLhPfqhxKjClL1/mN9JFTlzS
	grVujJVSmYHIqkofPBZw5nreuZ2x9RSaqD2JOla1Tem+ISilr0oN6iuAfjNavm1UTVNUm8ojYnhpX
	FoB3Wcuq1qGfd86J8pbpENhKWPYjFF8Tu4qCDwyWUDKxiCzJAnUqXssNDBNFLOiHMSegs+If/g9EG
	7xa73CdU12LJiiPHFLvHo3rMCsSOQ46B8CrT+V4PIk+sDPgjD1exItbcFZkyQRYx+8J4CIDFrqjj3
	Yd7nGrqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDRJo-00FHNC-1T;
	Wed, 13 Dec 2023 15:38:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDRJl-00FHMC-0z
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 15:38:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB4D168CFE; Wed, 13 Dec 2023 16:38:34 +0100 (CET)
Date: Wed, 13 Dec 2023 16:38:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Message-ID: <20231213153833.GC7301@lst.de>
References: <20231208105337.23409-1-dwagner@suse.de> <20231208105337.23409-2-dwagner@suse.de> <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me> <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_073837_483510_57B95D0F 
X-CRM114-Status: GOOD (  17.83  )
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

On Wed, Dec 13, 2023 at 03:54:25PM +0100, Daniel Wagner wrote:
> > I think that the whole PI stuff needs to be taken with a bit more
> > consideration because if not all paths agree on the pi (as we have
> > hbas with fabrics) we can't just override or do a logical or on
> > the capabilities/attributes.
> 
> So should the PI variables stay in nvme_ns at this point? Or should I
> add some checks which avoid an override and warn in this case?

Didn't we merge the patch from max to require uniform PI setups
for all controllers that we're using in a multipath setup?  I'll
check the code after finishing a few more things if no one remembers
offhand.

