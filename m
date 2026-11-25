Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE0606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 05:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NPeAw+7p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NPeAw+7pwxqiR2GTvYgdiW7cGE
	mtjhWgcjcum+04GQMLW0QDqzmYglJjoSmmlv7t1z673SvyRhtNvqP4cY4LlDqRVPigQJ6jm3jPuYw
	jMrROocELkFPB8xjtKzcmyUarqHCTSShsBbYSMI7leNX+kumxRaOdQNmw7ppMlY9cemPE8+GPau3G
	ws55+4x3n8+WTGmtETwLTQ+L1qsUHgZGVJ1WjMqgStpnLvK8a0j+vZNIMnyqPuLjfNNgSDQmTlHcf
	jFWO14U85BguJLzRb9zZDR2wASJpK0Fe4omlCSl/R+Vda9xJp7kbzJTKlARQh/KcWGy91xRXQBx3i
	0q4bPr/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5Vw-00000008Skq-396D;
	Wed, 25 Nov 2026 05:25:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW5Vb-00000008Shu-3tqN
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 05:25:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A5DE468AFE; Wed, 25 Nov 2026 06:25:28 +0100 (CET)
Date: Wed, 25 Nov 2026 06:25:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Steve Wise <larrystevenwise@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fabrics: limit nr_write_queues and nr_poll_queues
 when parsing
Message-ID: <20261125052528.GC20248@lst.de>
References: <20261122233951.8912-1-astellman@stellman-greene.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122233951.8912-1-astellman@stellman-greene.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_212538_397172_E494A86C 
X-CRM114-Status: UNSURE (   9.94  )
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


