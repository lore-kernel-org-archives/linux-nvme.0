Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFA4C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5BskQSEsu0S13Dmd+9R2ClfPhdCtd7GoLnJEXOFVUaQ=; b=InW9Si5e50DbuGDwh8hpoXLp9z
	eQG/st9Jc8C+iIbvxpIAMjagpK3AfzMwyMB/uboJcUki82X7+zczqcU/Qy4AAFjzAvBIpfbZQBBlF
	PH6sTPB+J6Tx18B70FSfYL3jCgWspBjyC2283+ZW20Qbuko6/tq03/pS0cvS7ah46eJF0aU4DbvJP
	i8WauknxenH4QgYLZprB/1KXz8LZVcuQOITtnqYg9g3sb8b4I5STbquj6CUxpO1WSUIx/RMXfR+Yj
	C+CLBtFRspaCnCinwTmpGY1v96rhDzshpC+Ch+HNMMl4e4RWcAMvAz5+Qmnn4Oj/dKWcvoDczEazp
	lqWFx5WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovISa-003vKj-2E; Wed, 16 Nov 2022 13:28:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovISX-003vJ1-95
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 13:28:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73AEF68AA6; Wed, 16 Nov 2022 14:28:05 +0100 (CET)
Date: Wed, 16 Nov 2022 14:28:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, lengchao@huawei.com,
	linux-nvme@lists.infradead.org, Gerd Bayer <gbayer@linux.ibm.com>
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Message-ID: <20221116132805.GA8496@lst.de>
References: <20221116072711.1903536-1-hch@lst.de> <e5de54b2-4906-9902-c150-732718a77571@grimberg.me> <20221116132225.GA8071@lst.de> <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee364d8-4aef-acf6-1cf9-38787ddac288@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_052809_484405_DF958199 
X-CRM114-Status: GOOD (  10.77  )
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

On Wed, Nov 16, 2022 at 03:23:55PM +0200, Sagi Grimberg wrote:
> All the other drivers check that they have IO queues before
> quiescing/unquiescing them.

The core firmware activation code does not.

