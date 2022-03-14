Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C8EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QO+zk38ZoBrEDOXXjYShXzJ703xkw/r1+5pRfV43OyA=; b=r8NemsJPd9BTnAZo/d4b6SJFhQ
	gpJit9H3rVa5oabPgaFop2ydAie7oxQdWgVeC/3ZHsyRU5Ft9UM0G0NXuCvRpVjX3WW6kc7LZsUW2
	pyJQE10HahdnlzHzeY00rkv11d7biKoQF5eyCoxIbQ1YK9/tBQIlQ/Q3p/LjHrueGV/GOEm3c6qaD
	FTheX3vLJRmOZNjcnwBmKrgaPK6diVH/EDGO4w1AEX/hd1w4rCYMgGVbg6FDShTyNdztjChe3yaID
	CicV9Y7acy+t0gqa9TEwFZPVToh1YRyxcr5ljtHXWEJQRT/lZDcd1zYHXrxTq9V9IPjCf9hJuW90Q
	Vn9UArIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTf2G-0043RG-NH; Mon, 14 Mar 2022 07:22:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTf2E-0043Qf-9Y
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 07:22:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A6B2068AFE; Mon, 14 Mar 2022 08:22:26 +0100 (CET)
Date: Mon, 14 Mar 2022 08:22:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: Re: [RFC PATCH 0/2] nvme: nvme_setup_cmd() cleanup
Message-ID: <20220314072226.GB4059@lst.de>
References: <20220309170437.4448-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309170437.4448-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_002230_501254_D9A8D69C 
X-CRM114-Status: UNSURE (   9.10  )
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

I don't really see the point of this series.  It adds (very slightly)
more source code, and generates larger binary code.

