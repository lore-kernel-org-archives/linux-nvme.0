Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDFBE98FB3
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FUA/1x/qz72yfMX1K98QulDckMN/ElmDWKI19IJUgc8=; b=2BdnEQfH2sQDeHbd0jEYICd8Gz
	i9xd55PhmqsPl31fbHD/Fps4tf1oL65red1fGLoaflU1OrmFeT61Bv7+0WrESAoZsNAbGopnMH2GS
	C1EFZT7rt94QaQCNpeSE84Oex5u9V1WnG0g57u5Ic357iMQ0y3jWpCP3yjpM9yMDf7jFCX2SOm7Jr
	MUedaoEun2wz4BZfIQeFbIjohq5H6m/aZv0x5J74XoEOWJXMf9BlV9IOeczKCfcX0XdR0/qJrDRd/
	kEXhsId9m0ZaHC89/au8AeLUbDxQM6ZdMtJhVKtXu9WD1W6hXamFfyKBmvQCP1Mt6Qwzysou8i3YV
	8YC/JoGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAiZa-00000009k9Q-27Ku;
	Thu, 09 Apr 2026 06:09:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAiZY-00000009k8x-2H1E
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:09:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45D7968BFE; Thu,  9 Apr 2026 08:08:57 +0200 (CEST)
Date: Thu, 9 Apr 2026 08:08:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-core: fix parameter name in comment
Message-ID: <20260409060857.GB6389@lst.de>
References: <20260408124522.2375297-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408124522.2375297-1-f.suligoi@asem.it>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_230900_725060_D364C734 
X-CRM114-Status: GOOD (  11.53  )
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

On Wed, Apr 08, 2026 at 02:45:22PM +0200, Flavio Suligoi wrote:
> In the declaration of the structure "core_quirks[]", in the comment
> referred to the devices "Kioxia CD6-V Series / HPE PE8030", the
> parameter "default_ps_max_latency_us" is reported in a wrong way:

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


