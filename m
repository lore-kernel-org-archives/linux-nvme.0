Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E85606A32E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Vy5XgjAt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Vy5XgjAtEvlZCcYLQb1eBVaOMb
	pgV+8t1d51kFnQBjBgWAGOKL7ZdsEbkNnVcnir/AVod76HCsrPY1R6fnWwQbcG1KoRme4btfAB7QD
	gVyYyxMge/7hkvQt5cNss9hk79cddwQK/PdpnsxwKXM0MplOeqQnPZlumdE1vWTzi6v8Xn5+yioJg
	RNux/Gkm/9VG7vj9G4zgOTP95JqVVgBIFxmYdWvPboQDvtuNYRIv411cLxX5pbLF/bn///KQoXvQ8
	kh4ULMPaUBIDXn2qoSWRmVFT0Kb9xO65Khh53WRbSf4AlJ8SrWAcgcY9fKrlVgca7GnGbBjBtrMA2
	r24GW2Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBRm-00000007Eeh-3PR1;
	Wed, 11 Nov 2026 16:45:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRBRe-00000007EaL-2Jl2
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 16:45:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A280A68D17; Wed, 11 Nov 2026 17:45:05 +0100 (CET)
Date: Wed, 11 Nov 2026 17:45:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Platon Miller <platon.ksenzenkokk@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me
Subject: Re: [PATCH v2] nvme-pci: merge duplicate 1d97:2263 entries in
 nvme_id_table
Message-ID: <20261111164505.GA18355@lst.de>
References: <20261111000941.105115-1-platon.ksenzenkokk@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111000941.105115-1-platon.ksenzenkokk@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_084512_047235_982B44B3 
X-CRM114-Status: UNSURE (   8.69  )
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

