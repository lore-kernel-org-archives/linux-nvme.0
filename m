Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC873CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B3y/gul6FZb1y1/DfHDuxRT7ST6aP8p4ZSKiriYwEuY=; b=f/t6cVKj+Y+Ld8+5g9K+YoLnUD
	cXWbuRp5RbHtOk5i03rTDjAok2DiminR2fJEY8zYActR8ugKSlJZxCmu7EWuIkAH+FIlAK9WkP5ya
	bo/PY/w8zOYlE6OM7LDIdN/1MH+7+pPg7ljC7QSusYblSnd5QdL2CDKGBqd3mNe1yl43OI/E+I22N
	QEl52f/I8S1yW5eZA5c4lcXO2+sKIvU/BmQw4B15RaxZr1/b7UcSDejbM4oJABXyF5V3fTjF0QKVv
	Mi+EE6NDc7VR5KQd7oYqEG2MI6n7JOqytIcZ+Ufqqj8IPWgzX/fqrOsONSKlvBs+n0Ixo74sosRlI
	2J+8u0BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0k1d-0000000B4CA-2PzF;
	Mon, 22 Sep 2025 17:08:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0k1a-0000000B4Be-2Nrt
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:08:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 796AF227AAF; Mon, 22 Sep 2025 19:08:15 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:08:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, Martin George <marting@netapp.com>
Subject: Re: [PATCH] nvme-core: use nvme_is_io_ctrl() for I/O controller
 check
Message-ID: <20250922170815.GB12527@lst.de>
References: <20250922120532.3754-1-marting@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922120532.3754-1-marting@netapp.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_100826_745752_201838E5 
X-CRM114-Status: GOOD (  11.89  )
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

On Mon, Sep 22, 2025 at 05:35:32PM +0530, Martin George wrote:
> Replace the current I/O controller check in
> nvme_init_non_mdts_limits() with the helper nvme_is_io_ctrl()
> function to maintain consistency with similar checks in other
> parts of the code and improve code readability.
> 
> Signed-off-by: Martin George <marting@netapp.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


