Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A131BC3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gy9HVgAqiTT93SKE8bKXr4MPqzUW3HMFdupOLC9g/6I=; b=Fq/TFHHlv2fY7RPTXe0UxZEcui
	lBPurmoTRZ3t/17ouflUgdQ5X2+X3AMcdiPr0FZD/106Uj+PcXGudAk/QXEoffkS5oG9wCHJ2Rich
	N0ELhjbfQw8mL7Xw48b/yMHqT6JOArtOYKJGKBDLHuSZ6awq2IENXFrmLmYcbXxDUfknXtRUuZJnh
	jcJknV9GxfuxPd+B0PxdUcNmwkWXTsoy6nij7MfKAVqE64MMPF8I2krfY7MHjAVgAp8Qd7wm2GqyS
	xHmG0kq68XTXjW+bOJENN3XASlhYcBdwxr1l1O5bYMG1iAgqWIGGlRHoDPSJdombz7CZOE4MuzUT8
	ftZnwY3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkFr-0000000BeOo-3w5B;
	Tue, 13 May 2025 07:40:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEkFp-0000000BeO0-2usk
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 07:40:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4CCC667373; Tue, 13 May 2025 09:40:42 +0200 (CEST)
Date: Tue, 13 May 2025 09:40:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool
 allocations
Message-ID: <20250513074041.GC2521@lst.de>
References: <20250513070025.830930-1-hch@lst.de> <20250513070025.830930-6-hch@lst.de> <20250513073950.GJ22843@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513073950.GJ22843@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_004045_873964_4615A0C2 
X-CRM114-Status: GOOD (  12.01  )
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

On Tue, May 13, 2025 at 10:39:50AM +0300, Leon Romanovsky wrote:
> > +static inline struct dma_pool *nvme_dma_pool(struct nvme_queue *nvmeq,
> > +		struct nvme_iod *iod)
> > +{
> 
> You probably want __always_inline and not inline here.

I avoid that if I can.  People trying to use non-optimizing compiler
flag deserve what they asked for :)


