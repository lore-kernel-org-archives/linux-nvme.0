Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF43CD37AA
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2024 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6xzdtOH97a7FGScCclkyRcbP8/KIMWtg6cwuIC0XFk=; b=MrlP6fFADnqb4FkZwL29Fhl3oT
	VlMcZLl3+BmTnv7ll6ma1hrvby+eULmwjTX1kMEKFDJV9zh0znb5TmIFIiTZZt1jQXLznmuC6MGYq
	ZdmmfIcAaSfUL+HPYY8HKWCK9HFn2+PoaMD3GExmXjvQcp98It0a4WLUj8uU7qkzGLjIVAYlde1g6
	BVfceiQVek5Lkp/n2mAVs3Jz4CjHY3wKJE4Af3qn3089rkSJhdw3/p8R0D11bSVaIIcm7dlXwwIgQ
	NExi2LZTmNz/eoqo0xrMS8M/4vZoaonrDUfb1XIC/mxjQ2fRhIy/ANct26Bz+ICbs3sOs75N7kOjY
	X/QIKA2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWxK-00000001EYC-44bq;
	Tue, 03 Sep 2024 17:04:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slWxI-00000001EXX-1jBI
	for linux-nvme@lists.infradead.org;
	Tue, 03 Sep 2024 17:04:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 422CA5C5A20;
	Tue,  3 Sep 2024 17:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1418EC4CEC4;
	Tue,  3 Sep 2024 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725383075;
	bh=oda0MCfJ4lh5WS56odZH70h3+VSLcRLZ+BgHDyJktpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ls0XwnbxeurpDZVjc/Pt+dk5G7KjMud0OhmCcgfx6vJWpxvPbGYGlemSjGHw0myqx
	 bO6cdonsVWG7tJU9b0LGBwoJkWURYaM1ytOyQBSp1F9o7NGjaChhhvkAsXClSd+Q7I
	 HRwYML/Qx3DUOjGAXpmvtxv7lJV/IVriRhFZPZZ44vxu8FeDojtcbv0bwp+N+WlIAZ
	 sA7+MVqtAFbLIvE9yQqge4uVd+Q6/TjFH/YC8HJN+FEpNeF0KAYG1GcwWdz3rKY2lT
	 yXOKoX2erKhb6NANCsQi0+DcZT0TjYuAf+i+scnu00goeVQhBYhyYbIG4szSOVo/RU
	 M8ZqkBkaBLmeQ==
Date: Tue, 3 Sep 2024 11:04:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: set BLK_FEAT_ZONED for ZNS multipath disks
Message-ID: <ZtdBoJXkaZhIpx4B@kbusch-mbp>
References: <20240829062437.2045604-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829062437.2045604-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240903_100436_537697_C2E1E81F 
X-CRM114-Status: GOOD (  10.37  )
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

On Thu, Aug 29, 2024 at 09:24:37AM +0300, Christoph Hellwig wrote:
> The new stricter limits validation doesn't like a max_append_sectors value
> to be set without BLK_FEAT_ZONED.  Set it before allocation the disk to
> fix this instead of just inheriting it later.
> 
> Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits")

Applied to nvme-6.11, thanks.

