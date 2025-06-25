Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CDAC7EE39
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 06:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3xxGFe43jbz/8eazAD9uDxafkIfe3SwoU7bMbDxPHE8=; b=o6Hivf2DjBeX7bmfEun8jTEKmE
	+2CZy/rYg7QB4GcLGzNoj4GLrLdc9k3jEt++4yhdKOWCd6Lic4cFUV9n16QcYJmCFf/1gqrqhomRU
	Y3sYmgWLOzt4GHx9Uah5og/JORmGZY5aUlI3c7CaRffd6HEOuxXphbfjAunu+dUgoTJlyQW6ykioJ
	ne+EXBv8xdctbOF6jilCwip97Zt8LQqIbfLnp425xBBvsABM4CQienZsrp3AttVAsseIPx4I5iya6
	UFgpTI079PICzRDLboofnmPZtlc1COirYkuksok1vGQZ0jqoVg9IQ9F+9k3wzVkpH8CPnMw5ONMYc
	KkOoKnqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJNn-00000007dQR-0m6X;
	Wed, 25 Jun 2025 06:13:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJHu-00000007crt-2sGW
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 06:07:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13747227AAC; Wed, 25 Jun 2025 08:07:02 +0200 (CEST)
Date: Wed, 25 Jun 2025 08:07:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Message-ID: <20250625060701.GA9391@lst.de>
References: <20250623141259.76767-1-hch@lst.de> <20250623141259.76767-4-hch@lst.de> <aFlyYjALviyhQ-IE@kbusch-mbp> <20250624124625.GA19239@lst.de> <01319f89-2244-476a-be0f-ab0dd74169d3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01319f89-2244-476a-be0f-ab0dd74169d3@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_230714_865902_118BC11D 
X-CRM114-Status: GOOD (  10.43  )
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

On Wed, Jun 25, 2025 at 04:28:09AM +0000, Chaitanya Kulkarni wrote:
> Are you planning to send a V3 with a fix sg_threshold parameter ?

I'll send out a new version in a bit.


