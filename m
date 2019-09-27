Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBF7C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:45:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721752146E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="efgf8qDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721752146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DilJU/vWRCw7nZlMv3W8qrVGq91vt2PTCKx4XoCAPXw=; b=efgf8qDyT5JaU3
	S3F496kRbd3DeKpQ4qgBwcLhLkFdr/2vibZUJ9pFSo2XMPXI/jMq5biqhOLKX/zR/HRLhb/vX5hxe
	R2HaslWlrzOq1ZhSZRRbJ12U2Qg6zXW44UV/d0I/pqpCwbmWaBoI7hLw/dp1LrjiPCKcrUvSmaVOp
	oGTnVcpTzj07MvRJsIJNqGVxOP9VksedytgZDDKv3uGr3meDfvEnV7ajDewmmJoDtNFuUCN10E4Mx
	9UYwulFb7/uackwSQaGkrUYgqBT/dP9zdzK1FBF7jCrDGadHdwLpHnSRTeB4MQwl82efFo5YZ9Oio
	r+7ghCh5LGD5NuFbkJeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDy38-00075X-IE; Fri, 27 Sep 2019 21:45:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDy35-0006cI-6T
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:45:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7069A68B05; Fri, 27 Sep 2019 23:45:08 +0200 (CEST)
Date: Fri, 27 Sep 2019 23:45:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH v2] nvme-pci: Save PCI state before putting drive into
 deepest state
Message-ID: <20190927214507.GN16819@lst.de>
References: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568830555-11531-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_144511_388130_85BD552E 
X-CRM114-Status: UNSURE (   5.06  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Crag Wang <Crag.Wang@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
 sjg@google.com, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Ryan Hong <Ryan.Hong@Dell.com>, Keith Busch <kbusch@kernel.org>,
 Jared Dominguez <jared.dominguez@dell.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks sensible to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
