Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED5EC3ABBC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=surZ7M8NCzq7OjcC8z9PcNH4wK7DGHe4VMXlBtJzd8c=; b=vo4Ahn0NyRUl5WnPLa8XdvlDOb
	YC0AJI+25Qh5h2FCbRyhXSo0AlahzuXK+pCbVakBKf65DbbUIh2FFpA71tzHLx9LSGnW2zVc57Plm
	YCW5ANuaY6JTEAzUCRsEU4QJuNSxJUwqhqxz/bmeWhiVtbLSGY+gPf/Qj4KmLplYVKAeZXbwsbvU0
	zCRCIH9eaXZbEtRJ2MeElKDW+K27ALg/Ulmngph2QkHHu1MYPLTPRmLD/JZwi5lCzcKxXqL9L6vpo
	6ac4RRUsKuTig9Y1UwVLmRO+X5Q0jLw79p+4wlcY03gdvN5enV1Pujb078kdL+lpD+DZBo5Y6IF8H
	gw8oPc8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRJR-00000004PdG-25Bj;
	Fri, 09 May 2025 17:15:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDOt8-00000003y1d-4APE
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 14:39:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B51468B05; Fri,  9 May 2025 16:39:37 +0200 (CEST)
Date: Fri, 9 May 2025 16:39:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: always allocate integrity buffer when required
Message-ID: <20250509143937.GA1955@lst.de>
References: <20250508175814.1176459-1-kbusch@meta.com> <20250509041949.GA28563@lst.de> <aB4SHKuSiuewRltB@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB4SHKuSiuewRltB@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_073947_171828_DF20E6D0 
X-CRM114-Status: GOOD (  19.47  )
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

On Fri, May 09, 2025 at 08:33:00AM -0600, Keith Busch wrote:
> It looks like tag_size just refers to the space for the "application
> tag", which can vary depending on if ref_tag is used or not. But it's
> always going to be smaller than the tuple size.
> 
> I think you mean 'if tuple_size == sizeof(struct {t10|crc64}_pi_tuple)',
> depending on which csum type is used.

Ah yes, of course.

> I introduced a new flag because I
> thought that gen/strip property was just an arbitrary decision that NVMe
> made for PRACT, but if it's a universal thing, then we can totally use
> that. 

There is no other protocol supporting mixed PI / totally user defined
metadata.  But strip/insert can't be supported if there is more metadata
than the PI tuple, so I suspect anyone else picking it up would have
to treat it that way.  If I'm wrong and someone will eventually do
something else we can still go down the flag route when needed.

