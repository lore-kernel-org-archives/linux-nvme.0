Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855FAC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 14:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=btRU0Xa1oj4RqSvvO+Bx2ys+cdsKmJF6E/VPdGis9pg=; b=CpRwkqd8J9MVhVNuVLxvfORj8a
	TGv6kiUtjXx7WLrHjxm2Mx2tTE0OXSHQlz0a1LA+TProheCeHR8l2D5DiM6NgPShkfRpgAkBNZ7aM
	CDm4X7BnMNhJD3pIZldgGQtxexwlkKLdjN6SuRC2MrLV7PMEXSUNRpbM446C7lyWUZdLffvB6C6rq
	vqtyPJUJZpITOer4agf120sSoob44sbRepr4CEwEoubziJz0okcv6UzGXvx1xzEoYEsYsBKXGmc8F
	uPywoljTn6/hPe8VyrRyqV6oSFAwjcn+hrfHHeEVX9WgJIBgkfr1SZSLGCAkDvcqvzEU7Cj+9uY02
	ks6nsXCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrL1J-002bcF-Jv; Wed, 18 May 2022 14:51:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrL1G-002baW-Jt
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 14:51:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 59AE268AFE; Wed, 18 May 2022 16:51:15 +0200 (CEST)
Date: Wed, 18 May 2022 16:51:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 sagi@grimberg.me, james.smart@broadcom.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme: set non-mdts limits in nvme_scan_work
Message-ID: <20220518145115.GA486@lst.de>
References: <20220518064944.4228-1-kch@nvidia.com>
 <20220518085602.GA8066@lst.de>
 <YoUFurG9sH1Qhfue@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoUFurG9sH1Qhfue@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_075122_835198_BE38B8AE 
X-CRM114-Status: GOOD (  14.78  )
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

On Wed, May 18, 2022 at 08:42:02AM -0600, Keith Busch wrote:
> On Wed, May 18, 2022 at 10:56:02AM +0200, Christoph Hellwig wrote:
> > This re-reads the limits everytime a namespace is added or deleted,
> > is that really such a good idea?
> 
> The limits are reported in logical blocks, which is dependent on the formats
> that attached namespaces have.

Well, the Identify controller limits aren't really supposed to
change randomly.  But ok, maybe that is a reason to frequently
rescan due work around this broken design.  Can we add a comment
to explain that?

