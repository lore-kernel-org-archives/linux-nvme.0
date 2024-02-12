Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930B8C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KZZgwkhl76a+xv8ENcguxesns3QgTqa8k3C8ygLgnw8=; b=TXZZvux4dgAcDUnsWOnyataATb
	P1UIsePiww3nsDldspJk24LpCGxu0Oq93hFoP4JDyr2ffK5d4J8Of1/yuL/S0goEbqnFfjmgnkZ5R
	42lXF+xY8rXGgZkA1HFw68wcu0QT/T0Y2MWz7JjHxt2fldcgfsf/2rOSWfRjVNEe7nIJtLyh3+eFd
	PoGX1eow1c5FbcPB3pdNySHvZEMBkBiS0WfThVkcgw9DWKjw94OI+AjCxvJMcSoE5nXFp0qT4RfNP
	dYrfnSyydFcyP+O3OMFGOuZ5LE530obQufvvjjBebfzH0QSPyvCmLu9vJfuxI5RpyW8nhR5xnVxOE
	oD1GNDNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQlD-00000004VzN-2olr;
	Mon, 12 Feb 2024 07:29:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQlA-00000004Vyz-3Cq5
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:29:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D4F8227A87; Mon, 12 Feb 2024 08:29:46 +0100 (CET)
Date: Mon, 12 Feb 2024 08:29:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue
 limits
Message-ID: <20240212072945.GA19939@lst.de>
References: <20240212064609.1327143-1-hch@lst.de> <20240212064609.1327143-5-hch@lst.de> <e1061d81-ca74-4b56-b87d-4f6660340093@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1061d81-ca74-4b56-b87d-4f6660340093@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_232948_965039_CB8443BB 
X-CRM114-Status: GOOD (  11.17  )
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

On Mon, Feb 12, 2024 at 04:24:39PM +0900, Damien Le Moal wrote:
> 
> [...]
> 
> > +	/*
> > +	 * Random default for the maximum number of sectors.  Driver should not
> 
> s/sectors/segments ?

Yes.

