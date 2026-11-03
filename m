Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3003606A329
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=26IfZBSi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=26IfZBSiXSkIvTPAC5XL2icz3x
	tCii9QIKBLZ9Pp+WbbV8SBF0QFCFPW1AeCyE6FXxpr5NkwRI+yt0W6OXM8PTsR2fq/UjyAkESxGnd
	2xsfbYvjadngvkW4berswSJvG1+UvRd6e4yjwWo//fo1hkMFUB9iwLV5Y7QkCkGo9/Y5cAsYi+3tW
	WxpiYqCoVW86rI8NHFcl2U0Aon7FGeE4VQuy5QSEBEqjZw+pTeP/44x0xN/1hRAdjWkxwUJCCFSkR
	QnMCYBN5hXia4KSB4SqLGviAjmPVRumSxeqgFd3fj3PPK2hJbGJuJHNy1AHseEYLwOPwn97my00A/
	fC6BYTgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7GQ-000000019LN-2HNm;
	Tue, 03 Nov 2026 05:40:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7GN-000000019L0-1g9o
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 05:40:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6C34268BEB; Tue,  3 Nov 2026 06:40:47 +0100 (CET)
Date: Tue, 3 Nov 2026 06:40:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kyle Bader <kbader@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Kyle Bader <kbader@ibm.com>, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Tushar Gohad <tushar.gohad@intel.com>, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: only fail dma-buf bios that need block layer
 PI
Message-ID: <20261103054047.GA1559@lst.de>
References: <20261029155821.2983229-1-kbader@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155821.2983229-1-kbader@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_214052_053330_8BE392B6 
X-CRM114-Status: GOOD (  11.06  )
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


