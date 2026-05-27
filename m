Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE645CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 16:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DAOqfSQvs8G5RQT5spINIn2IhJZUSKLhtYEwu8PRHAg=; b=oa4gYGnwsKwFASIqo9dBZyOI9v
	HwZ41tS7Z9ZzLsd12B/4D83MwAYwKfZx9Mq1lpiVWmxV9t5Z1ypO699cmS5aCV8BHQaKTka2xAXGm
	yl4wgwEOqtrmONChF3EQvd2PuUyrotsBcg8zk/h1oLdCQ70dw5ygc0uYHrxkBij4d92eBB1DBmRZr
	8c4g74lm0ybY8QhmXegWXmZbECJBOAFgIVT1oPVq6bK3v2BpRAAgen8+3KyvYhJIHyZdXodsVnams
	9JQQzdPa1z6/ycav5b0tYy5/kYQTSK9CfG49XqM4yht0t8PSl7cJQI2AqgUCpBeDixJuHDIVJRMMV
	JKj6kY2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSHCv-00000004WAS-1rPT;
	Wed, 27 May 2026 16:34:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSHCs-00000004W9m-3v3o
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 16:34:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 131F34331B;
	Wed, 27 May 2026 16:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A60C1F000E9;
	Wed, 27 May 2026 16:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779899650;
	bh=DAOqfSQvs8G5RQT5spINIn2IhJZUSKLhtYEwu8PRHAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f9jlQrzSeysdBTkJ9Bli6zirNjFzt0NbrlCnY5Q+QX13ta2a+gFcqTUbFhB70q/Zo
	 GaN/c3W30jjZAVa3n+KbzkWyXpB3ckpic07kDALOIVeW+8A5vKX3L2pE/gaVgqeThL
	 g2fhpATepAJSYLxp+hwIspcimHT7uqhh+6xYGDW2bOcMroo6idlNCFXnKRTYaN/PFP
	 y1b6sbe27IQIbCPRZPXGoOIxvX9qC5/Q8Qj61K4fnRk8ZnDycQEVWlxzkGjNcqAGGF
	 WsjCISZnph4MP6Dqjsw66wJoHU5yarX4S/7k9IZCD3qEIxMzTE1i7WbXM98vzffaZb
	 4efwF0I7GJUvw==
Date: Wed, 27 May 2026 10:34:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Sung-woo Kim <iam@sung-woo.kim>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: fix out-of-bounds access in
 nvme_setup_descriptor_pools
Message-ID: <ahcc_7RJQSqx7GXi@kbusch-mbp>
References: <20260522150628.399288-1-mateusz.nowicki@posteo.net>
 <20260523082751.20453-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523082751.20453-1-mateusz.nowicki@posteo.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_093410_990820_263DB8A7 
X-CRM114-Status: GOOD (  10.62  )
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

On Sat, May 23, 2026 at 08:28:16AM +0000, Mateusz Nowicki wrote:
> nvme_setup_descriptor_pools() indexes dev->descriptor_pools[] using the
> numa_node forwarded from hctx->numa_node by its single caller,
> nvme_init_hctx_common().  On a non-NUMA kernel hctx->numa_node is
> NUMA_NO_NODE (-1).  Because the parameter was declared 'unsigned', the
> value becomes UINT_MAX and the index walks off the array (sized to
> nr_node_ids), faulting during nvme_alloc_ns() and leaving the namespace
> without a /dev node.

Thanks, applied to nvme-7.2.

