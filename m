Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353EAC25B7C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eTPAPFuFOI6BKyer+lzE3tT9r9N9XS8wjowt0DZL/7A=; b=3a87RW5vez1GQ+JHFHSuC64SQr
	wCDdTcWM7TOy+2+LHJh1z7VxFEFZMVwPU4qcUWF3AdY3VE/ijNNRSEAZGdHpTabiAZ27IbqhSoKtt
	RlzdLg75ZQqOLY5YvU3+vl4nkPN+kwSQFe+4DL+aF/iEB1F66gjzy0cRViOxVi9b52Dvgr5/yz5lU
	tqW3kKmJof539uLwfCPJ9hR5jw/BlLI1v2AfJuE5QUzu9xOWwz2ws8riXwPLlxNv2eM9FRl1ubnyc
	5LXNEoiRtsvdCNoyxKi+1RBwlTttqc7QBVUse1QrrNBgTY6fnuvMuiYqyWPNaJb0/LUz7tcIyK6H1
	skiF7SxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAY1M-00000009PGu-12tT;
	Fri, 24 May 2024 16:43:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAY1I-00000009PG8-2APW
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 16:43:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D33868B05; Fri, 24 May 2024 18:43:45 +0200 (CEST)
Date: Fri, 24 May 2024 18:43:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] nvme: use srcu for iterating namespace list
Message-ID: <20240524164345.GC21444@lst.de>
References: <20240524155345.243814-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524155345.243814-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_094352_723849_41873D0E 
X-CRM114-Status: UNSURE (   8.44  )
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

> -static inline bool nvme_get_ns(struct nvme_ns *ns)
> +bool nvme_get_ns(struct nvme_ns *ns)
>  {
>  	return kref_get_unless_zero(&ns->kref);
>  }
> +EXPORT_SYMBOL_NS_GPL(nvme_get_ns, NVME_TARGET_PASSTHRU);

What actually needs the export in nvmet?  AFAICS the export only grows
a new user in ioctl.c.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

