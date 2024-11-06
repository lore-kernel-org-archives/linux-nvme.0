Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7E4D3E78C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5d0NtvshvHxaZSGQ+U0x6j/F4V7rqwtelPsOb6mvGj0=; b=Wwep+UKNR9rZUDsR/x3nFVS507
	gA0OySIAlBIWzNi5Jl4iZl09kzPYz7KNztQi0sT2hYGZiWgg1VRHsdF0Ap2luNSJrQSnDpA7JbjJR
	Jqw0SMfxjOEZmHEQoG3b5HG/KP42YavSV6F7D2c9oG9U2I/REupoKM9CuZdxN/u41AGKO+HT31Mq9
	lHcBcVXprX2DNMwLULHK1i88oHt6tWBuSAmZIUr6wy34ttoY0lR/4vcQYww6ECr7ep5vQlU/EjdaM
	B7X+2qXI+KFmLuseqPFdMcRppXnfj7Nem7pKjHg3WHeoF6rUxSaYJWtg2dwQm/nqL5bqQoYoOroQV
	qX2cIa8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Z33-00000001uwK-00Uk;
	Wed, 06 Nov 2024 05:57:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Z30-00000001uvM-0nWw
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:57:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A6D2068AFE; Wed,  6 Nov 2024 06:57:39 +0100 (CET)
Date: Wed, 6 Nov 2024 06:57:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 10/11] nvme: make independent ns identify default
Message-ID: <20241106055739.GB31699@lst.de>
References: <20241105174904.3612888-1-kbusch@meta.com> <20241105174904.3612888-11-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105174904.3612888-11-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_215742_414519_B22849ED 
X-CRM114-Status: GOOD (  10.72  )
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

On Tue, Nov 05, 2024 at 09:49:03AM -0800, Keith Busch wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> The NVMe 2.0 specification adds an independent identify namespace data
> structure that contains generic attributes that apply to all namespace
> types. Some attributes carry over from the NVM command set identify
> namespace data structure, and others are new.

The subject could probably use a little ammending, e.g.

"use command set independent identify namespace if available"

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

