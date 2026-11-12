Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF5606A330
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=owzauMgj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=owzauMgjaG1caowRp3ymB8jP9W
	9CbTqeh5orw1woAJ2iteG4DK/zorUY7F5S/p5qCVdMgjn5wrldzyqjQEQEJotwHAReGuvm7OKcKhM
	jjhUD9RZCmftuSB8MZEBL2E//c9LuvNJmjKr07HJjmITZ8lGl7HuUxUwyJx6UAKTWP2YvIUO0OWPt
	ONrD7KisX/sViBTlO/PHTmXHogeLXABRiNdGdyOViecwozgQ5RmN7ib675DCU/sTr+mtNNa4k/0Vd
	wpe1BzZxvYUq8v6onT/Az+atxO+IwwVNxPY617Y/zH0mmHgeMQL/k2NlxltAtXYWnhQePY1rZEcZJ
	zYT5wwag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc7M-0000000B4DF-0Dgn;
	Thu, 12 Nov 2026 21:14:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc7J-0000000B4CT-2n7L
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:13:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5DE9768D05; Thu, 12 Nov 2026 22:13:54 +0100 (CET)
Date: Thu, 12 Nov 2026 22:13:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kch@nvidia.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/6] nvmet-fc: reject duplicate queue IDs on Create
 Connection
Message-ID: <20261112211354.GE11126@lst.de>
References: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn> <20261110230315189Lj-_xOlluiUEy8Ui7ZA4D@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110230315189Lj-_xOlluiUEy8Ui7ZA4D@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_131357_842730_12BE18E5 
X-CRM114-Status: UNSURE (   8.90  )
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


