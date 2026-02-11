Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E83EB271F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iVozGTMLBH+QW0gQ/pLldYDntrrUjX/mSjF5bSs9Yqs=; b=znKtyMZ+wQwfCEMTYKLVLW5ogE
	e8wJxGh70RtaaZLi7RFbHvShWLbB3FHfP4AQv/UydenK6ADkxMkEI8qcoqLyqecVtav9wudSZ2bt7
	zK/1wfSzAJT1cgewpnen6/YWw78I+QBa2EUDjOscJfi4XtDuoqqNYQTGezNnA5wILo0mZJ2WGVEkQ
	8KBsgmQOaB6YZ/mya9Ua+9AkR0m1xi+We43z6infFL+ndzFBheznOIpirTzwmSWGxX1Fqfc2TrXwe
	GoiA+FJ9txgpcyGkMu901EJLddvc9TZvOYRGopt9vGRwGwad26iFn8FixSVuM6sHXgZx/tqWQ3VVg
	ZlNdmPXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqCaA-00000000oTq-2uOq;
	Wed, 11 Feb 2026 15:56:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqCa7-00000000oSx-3wGD
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 15:56:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8820668C7B; Wed, 11 Feb 2026 16:56:44 +0100 (CET)
Date: Wed, 11 Feb 2026 16:56:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme-pci: cap queue creation to used queues
Message-ID: <20260211155644.GB11325@lst.de>
References: <20260210193715.2543091-1-kbusch@meta.com> <20260210193715.2543091-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210193715.2543091-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_075648_119348_2F3CE6D8 
X-CRM114-Status: GOOD (  12.44  )
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

On Tue, Feb 10, 2026 at 11:37:14AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> If the user reduces the special queue count at runtime and resets the
> controller, we need to reduce the number of queues and interrupts
> requested accordingly rather than start with the pre-allocated queue
> count.

Maybe add a comment as the code isn't quite obvious?

Otherwise looks good.


