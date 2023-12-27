Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B90DC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5nAmadFlepzuNaDh0UrXmc94sGbvJrJnZkij7P1Jxw=; b=vr1EIb5LJc6gHwS92GAI4sDzxf
	79qi+Ye+oiCVJ6hmodYji1gC2Zl2UZXTw0+8Z3BxPIjMWES5ZxpiBaK95PgQqVKxwh6lgj9rfVNC7
	MGWGZ+emVMKBoNzZbxCx+yqf7pLKePrZyykeyN4JQC1Ez58N/5p7Q80v0D06fnolEYfsZEwu/ASAC
	Vj88Nijft2K+JM74PsCSO5sB9mGKfjbgJ1vOGxYdQ/RMxzUy38nOailKaIvacCRnQkSPl90RC9LgS
	ghvv6rl1SPMjEXJMgVOQ+JeNUEWtG1jGsBv9FXfg/jMjJc7SnUmxgSMjlp6pikgBTIlZCznSANSl9
	vRc4EBRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIP1r-00ECRo-0K;
	Wed, 27 Dec 2023 08:12:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIP1n-00ECRS-1G
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 08:12:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B67FD68B05; Wed, 27 Dec 2023 09:12:31 +0100 (CET)
Date: Wed, 27 Dec 2023 09:12:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: introduce nvme_gendisk_is_ns_head helper
Message-ID: <20231227081231.GB21943@lst.de>
References: <20231227074959.4246-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227074959.4246-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_001235_595666_D0821FDB 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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

> +/* Use gendisk's fops to distinguish ns_head from ns */

That's pretty obvious from the code below..

> +static inline bool nvme_gendisk_is_ns_head(struct gendisk *disk)

Except for the weird holdout del_gendisk we only use disk in names,
not gendisk.

> +{
> +	if (disk->fops == &nvme_ns_head_ops)
> +		return true;
> +	return false;

	return disk->fops == &nvme_ns_head_ops;


