Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D76C4345F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 05:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PAELLSYDWiqyipZM5E9btis/ZO7gd0J7ISssEsRBds=; b=nECB8MSWeqqxuKKlODI1dXlN5P
	8ki4SHoFsQUvJwQOCml98aE4YFFFHsJ8xT7pfG6vuTgfwDkEJ1fAnZGcvnG6OJVnLW/RhiOAQIQ8o
	0lsyChf7s++AsLF5FGbt2KrjaTxzAAX25faImkKdvZcyhy5psBtQ95T5wz9JDYRE2hrKwPvtLYqSM
	ESIwABAhMCtIjqOaDVLqR5OWADnxnYy2R6SigB/fGPiIhFz9AjIIagIYpvdv3gncr5dkOitHBfQuD
	Wh3ofnuVwq0y+RKsV3lI+d++NiQxnWw8D1vn7kFWfVAkiRS2E0VdCzM6VzBgxSaO/F70TrwTVyNKF
	Nf+bAYOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3qya-000000069lB-1wJu;
	Mon, 06 May 2024 05:33:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3qyX-000000069in-2GOJ
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 05:33:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 711C868AFE; Mon,  6 May 2024 07:33:08 +0200 (CEST)
Date: Mon, 6 May 2024 07:33:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: make nvmet_wq unbound
Message-ID: <20240506053308.GA5030@lst.de>
References: <20240505103951.52413-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505103951.52413-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_223321_740917_50F8D380 
X-CRM114-Status: GOOD (  16.78  )
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

On Sun, May 05, 2024 at 01:39:51PM +0300, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi.grimberg@vastdata.com>
> 
> When deleting many controllers one-by-one, it takes a very
> long time as these work elements may serialize as they are
> scheduled on the executing cpu instead of spreading. In general
> nvmet_wq can definitely be used for long standing work elements
> so its better to make it unbound regardless.

This looks sensible, thanks.

> While we are at it, expose it via sysfs to allow cpumask
> control of this workqueue if a user wants to modify it.

This on the other looks very questionable to me.  It needs a way better
justification and should be split into a separate patch if we really
need it.


