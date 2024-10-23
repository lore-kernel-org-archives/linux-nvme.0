Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3367CCF5366
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5RAtLI3CGjwDIDmQeL6J3Bs/jIuvBIlLwEZZ8mw2/sQ=; b=3DTMyhhhXgOcqijt26PkF23IG8
	2Mss308iYI0VclzJ1z1h6XjPCA9q1WYxK6H460ACd/KQasjnsASnL9FLHHNAeAfD09GUVQIsyqq04
	Bgw44xRe0fg+/eJGsbN7JysLpYduEFXrB0phnyoGoBpa7e3ir//M6OobVV7A+Qbc4dvd5h+TlD89b
	Pvo2cdCK10qD+htk2kZK8uPIv7Znl7CYn1A8tlHIIaHOEL8vvNsixaz/Ks/P4IXqs14QORMmq6I+d
	KixOhaUXorsfFaEvZofvYwDqyQLAvYydRD+GK6EDA+vEcbBRmXrn93yl9aQaMv1UAkS7VrnpV8beW
	Q/CKAXEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3aQC-0000000EKJV-1oyL;
	Wed, 23 Oct 2024 12:25:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3aQ9-0000000EKIB-3Wyn
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 12:25:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C9855227A88; Wed, 23 Oct 2024 14:24:55 +0200 (CEST)
Date: Wed, 23 Oct 2024 14:24:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	kch@nvidia.com, shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
Message-ID: <20241023122453.GA29256@lst.de>
References: <20241021110331.125962-1-kanie@linux.alibaba.com> <20241021110331.125962-3-kanie@linux.alibaba.com> <8dccff09-2eab-40a1-abd3-b3759ecdc1ed@grimberg.me> <20241022142039.GB17410@lst.de> <75748d86-5ed2-4310-b02c-500984e6feda@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75748d86-5ed2-4310-b02c-500984e6feda@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_052502_082495_7CC7A61D 
X-CRM114-Status: GOOD (  13.23  )
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

On Wed, Oct 23, 2024 at 03:35:03PM +0800, Guixin Liu wrote:
>> Guixin, can you test the code with lockdep enabled and see if there
>> is other fallout as well?  Thanks!
>
> You mean use semaphore to replace mutex pr_lock? If this works, I
>
> can send a v18.

That should work.  Although semaphores are kinda frowned upon, so
better write up a comment why they are needed as well.


