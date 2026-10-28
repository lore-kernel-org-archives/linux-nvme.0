Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47361606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=I+Ydc44w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=I+Ydc44wOUoMVIaT3mK6lJpmXo
	LfYvpC70kUMDdVytp6uDAJo+XydHdvurHYRu7vUwTKvgMUHzhKqqOUjRm6baeuni9n5yVcApzXF+/
	Ail5BP5b9L/b5indvBqzEUzqjSzTjGMHWfdgm9jXFSW2fhk5irOE8KCI2KO42cKTYpxDUDZrU+GEB
	JIzgVAhfalqHRhTwE7z6sE9vlp0+lRU1nQu/cNC/3v2yZISIWQEU6mWbAzidyBVsH94oWQIKJ/EbZ
	/uSmfjjNw0a7LLlwCBsG4ylBHM2pgiYYfWn8w/tZkIcFP073A7LpNyskrlDfSVffaxkRpxJFQFa1I
	697VQs5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4kt-00000007DSd-3wlv;
	Wed, 28 Oct 2026 14:35:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4kp-00000007DRs-3hBF
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:35:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7421168AFE; Wed, 28 Oct 2026 15:35:37 +0100 (CET)
Date: Wed, 28 Oct 2026 15:35:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, hare@kernel.org,
	sgogte@purestorage.com, wagi@kernel.org, kanie@linux.alibaba.com,
	nilay@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme-tcp: fix NULL queue->ctrl dereference on
 reconnect
Message-ID: <20261028143537.GA13429@lst.de>
References: <20261028143343.221936-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028143343.221936-1-christian.aurichzm@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_073552_065434_2DCF5D53 
X-CRM114-Status: UNSURE (   8.79  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


