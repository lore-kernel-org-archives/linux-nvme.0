Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09498606A880
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y40yidft
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=y40yidftjGsjNlvo1Nl6zmzuTE
	d0Utc4yqHDXynOcwhlaskD3fdFp+YcPSXpoIVIFCihX7tWSpC8YWJrhd6nJ+jA0eHZozn+luf4ICV
	SYrIUa+NBP4fKyVdm3G+iLbfpvg//kQyqUSpmuF529YN8wcm+MflGY+oh2hpY9JOOcZW/gzrcleyw
	pk/wRo09yNYHZhJ4IWNndJxioOdB261ZnJ7PtzzTf2eIvKUJS5e+UMremZizvVNWLar931Om5L1G0
	deS2hRtX0ff+wtO6NLo2QCP7ggFQ+FPwm4cVaojgVYrfw+VVDupXxJQWmIquBAoMLKT4WsA3KIdxR
	HVyEzsQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc2J-0000000B3Mx-2Bho;
	Thu, 12 Nov 2026 21:08:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc2H-0000000B3LW-0nw2
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:08:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC2C16732A; Thu, 12 Nov 2026 22:08:41 +0100 (CET)
Date: Thu, 12 Nov 2026 22:08:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: mt4022@columbia.edu
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	tz2294@columbia.edu, stable@vger.kernel.org
Subject: Re: [PATCH] nvme: fix deadlock on nvme_subsystems_lock in
 nvme_init_subsystem()
Message-ID: <20261112210841.GA11078@lst.de>
References: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-nvme-subsys-lock-deadlock-v1-1-1837b8e9076f@columbia.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_130845_385123_8584D1FA 
X-CRM114-Status: GOOD (  10.58  )
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


