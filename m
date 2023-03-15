Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2487DC6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=h8s387Ce2rWsXQ0dZlaiNWeyVg
	MH93ZXM+tGACUn4bkWzaNlgwSj3DhJGq+SM3LFTa+cxEn71s3t+jhVhM53X5Y9m3lZewLV3NEROVi
	gYU8GdmMM6f49O7FNhqTzmPlQlh7PYs3HyXN3dLkZbGl0ut14+c2r76PUs7/0CnniII4wb3WTLv2y
	mMWwhXp+jftR8OZQ2DaEapbuq8QLdKxOsUrx8cOww4hLWOIHIyex5/4ELa9ksw85EFzyOC4gamLmz
	ZlZI34UXTvML2DH7nsOJs+UmgiBoojo9NM4QavkdMZqfFxVO3CF8tXFU/hIzTBA7x9Q9Sus9vD9Lc
	s8enc8gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRg4-00DY2I-0r;
	Wed, 15 Mar 2023 14:00:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRg1-00DY1H-08
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 14:00:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B9F567373; Wed, 15 Mar 2023 15:00:22 +0100 (CET)
Date: Wed, 15 Mar 2023 15:00:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvmet: Fix error handling in
 nvmet_execute_identify_cns_cs_ns()
Message-ID: <20230315140021.GD26951@lst.de>
References: <20230314062036.25939-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314062036.25939-1-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_070025_244879_590E5D3F 
X-CRM114-Status: UNSURE (   8.10  )
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

Thanks,

applied to nvme-6.3.

