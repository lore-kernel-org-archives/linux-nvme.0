Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E9606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tKuTKYYg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DEBevRNOcYMuj6l5g+4qkrZH9IigR+qd570WgCXwR/A=; b=tKuTKYYgm6pZCdV2cSdXexrgN1
	u6y4zTtrTt/Rh+AfaqR4nMHHDFNylCFnR8QpVx0WDGb9Cfo34HZPBy93IqubzFs3Mvs2i3grsjAJl
	ywKewQNXdGSAN5X9NaIe+KQ2+Nr40bx+R3iouA2KybwcajOog5nWzUB28IXCmgWzxy13e/nkdZSgg
	Mosvnxnz2+BudeL8mQ5KrJCnonA29RXkv8RjMYTeD7yEqKC/phj4+cwk+ZUijHIntyDDeHorvFz/V
	M+kU0tM92A9ECd1MdJdCYkSwm6XcnbWRqJV6B8/ThiYQLpWefLyb2d1g5gVU0G1G5hhJVMwWx6VlG
	pPAnx70A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOWuD-00000004p56-2WVc;
	Wed, 04 Nov 2026 09:03:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOWuA-00000004p4A-1mx3
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 09:03:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C611D68BEB; Wed,  4 Nov 2026 10:03:32 +0100 (CET)
Date: Wed, 4 Nov 2026 10:03:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA
 XG10d
Message-ID: <20261104090332.GB30750@lst.de>
References: <20261103224114.1657779-1-sashal@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103224114.1657779-1-sashal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_010338_612970_F339DBB4 
X-CRM114-Status: GOOD (  10.02  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Meh, more broken devices.

Can you please provide a smaller, to the point humand written commit
log?


