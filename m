Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71546606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BmOuTJva
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=BmOuTJvaa+RQocUTEqLcAlNSDq
	QF+jhlObe/d8j7GV9C1vgJMCPsYtgSeG7hDlbdLOuBlLtyYyitx+hDtwUL5NRNaMK5BiAylzn3rzW
	y1w40+vUtb8OldcYG/TlPklp48cEYMtT/3yNRUkyzqRKJAcZA9p99B/+o2Ix3HbbU0zLGBW8pqBJ6
	OMQtNARFi1DO1hOeE7MsFbeiNF5GItGHpv8a84OlYJjydRWhIX6vyS/sHa7Y/k3ZyryyNaX5NGqrC
	Q7Pfsx9ATc5UjydPmJ1qeQzC4ZDJa9dzh7axYFHmnM3OdSZabsjkAwPbIlYxx4Tn88qH0ERlfXdWC
	L0LfnfXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7YL-00000001AbV-0dQX;
	Tue, 03 Nov 2026 05:59:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7YH-00000001AbD-2EZY
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 05:59:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DAC568AFE; Tue,  3 Nov 2026 06:59:18 +0100 (CET)
Date: Tue, 3 Nov 2026 06:59:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Josef Bacik <josef@toxicpanda.com>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 04/19] nvmet-auth: keep the old keys if the new ones
 fail
Message-ID: <20261103055918.GA1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-5-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_215921_734030_BEB0568A 
X-CRM114-Status: UNSURE (   9.58  )
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

