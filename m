Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05179606A33D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AuCHnpjj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AuCHnpjjfTiVIt82YO4Dlur7KL
	XsA3oXNqIN2CuBJ+fKeVhfhrsen7BrHjK2/cz7SlMW7W/d/hRbLCL6uKPifH4n0XU678OJ0uOEy+P
	d62ste/lRuN/46ka+c0D1J3gYmtIcTZ2eK7Ie43s6Y+0KTDTJ3B0NvTRKyXndRatux+YYFMFraPse
	rwtL4xVNxsUKvq5bYAsywk9OBijXvAyJgppMhIsL2Sk/4OoyneoGX1QQGpNSvuMypTLtwKC+D/v4d
	k9v8PLGFnx/kSr8Hv1AIo+4m2GbhgGRjm6S0xT2uMB/YD7JS/2bqQKrZq6/Y2SBLEBKxwG++9jhFk
	47jGXEIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRcAJ-0000000B4ds-2yiS;
	Thu, 12 Nov 2026 21:17:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRcAG-0000000B4dF-3aKn
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:17:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7BD4068D0D; Thu, 12 Nov 2026 22:16:57 +0100 (CET)
Date: Thu, 12 Nov 2026 22:16:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Cc: hare@kernel.org, hare@suse.de, kbusch@kernel.org, kch@nvidia.com,
	sagi@grimberg.me, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: synchronize DH-CHAP secret removal
Message-ID: <20261112211657.GA11315@lst.de>
References: <20261110081559.2730-1-sreekuttan2156239@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110081559.2730-1-sreekuttan2156239@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_131701_044223_02016DBC 
X-CRM114-Status: UNSURE (   9.29  )
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


