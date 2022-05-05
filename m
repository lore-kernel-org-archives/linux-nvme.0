Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E734BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GFRL3ix/UPm8SMm593rYrUUeWtJXduBSS44WUgj2q8U=; b=QLjG4V9jam58I82N36ZuuJOi+1
	QkUvYiwiLHLpJQRKZEnZ4S1WVnGLX4X0uMj3TWconNwobk+rj2fmQvHPszqbA+pCd63admzWjYS9X
	K3Dcz1A+Jktkh08ifN2qGoWa5xT9XF9psuYEyCsrSjSYplX2jhhDwKDJPDY/B89DHD4Qr17XWCt/K
	KmGlje9k+1yUqYB7Vky7m9Aob9pGBgDWy2N3wtGPN4QfrvpffNu7Tn3umPR49IGA0Z8O98WTQbDjD
	nVNoFqmoTiJzCbYmh6+lZFLfmLI0NkD/BfqVX2v89Epc1t90a1zmtRRE9QpVQhsi49O4xcdt/1Q0y
	EwLwjFhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmbng-00G7z6-1q; Thu, 05 May 2022 13:45:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmbnW-00G7u2-5J
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 13:45:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 58F3168AA6; Thu,  5 May 2022 15:45:34 +0200 (CEST)
Date: Thu, 5 May 2022 15:45:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: set dma alignment to 3
Message-ID: <20220505134533.GA13926@lst.de>
References: <20220504184325.1439476-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504184325.1439476-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_064538_376796_86654B2B 
X-CRM114-Status: GOOD (  14.60  )
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

On Wed, May 04, 2022 at 11:43:25AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme specification only requires qword alignment for segment
> descriptors, and the driver already guarantees that. The spec has always
> allowed user data to be dword aligned, which is what the queue's
> attribute is for, so relax the alignment requirement to that value.
> 
> While we could allow byte alignment for some controllers when using
> SGLs, we still need to support PRP, and that only allows dword.

Can't we just turn it go up to eleven? ;-)


