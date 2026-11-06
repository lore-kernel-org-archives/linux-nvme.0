Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08E606A33C
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Iy8QxJoO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Iy8QxJoO0JxtWu9Bvt/zAvmm3g
	0LkLq8XfL3ixOJt2FBg9a9BFHZ80QEBBokHApwOjDYiFcjJBkXu+j5PNWyZ/xiti2eDIS4H+TfW8h
	1hPu6c7hA0Fb0kyYDy0OVDCJ/hRNP/PtTeUqS603tM01pj6h0vH+vUTS7JwJhgBObuRX6Qi2AtjEu
	PtaSF3Xn7DRFWD72z/EzhejnlneUKBDUWfzYLdRDu8VgNvVVet9Ro/jwzUCOpbxA9HxJ2rZzRCodz
	yA421d5Gpb5apu0cCSztPysn+ZlMyxD+W11uhv4w8J0Z+pq1QV28MIPfAUHOTVnMGo0JKk5BlBZqj
	hdKQXI7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHD1-0000000BwBA-492P;
	Fri, 06 Nov 2026 10:30:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHD0-0000000BwAI-0IHZ
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:30:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A76E68BEB; Fri,  6 Nov 2026 11:30:06 +0100 (CET)
Date: Fri, 6 Nov 2026 11:30:05 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Smith, Kyle" <kyles@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Fix potential gendisk leak in nvme_alloc_ns
Message-ID: <20261106103005.GB5391@lst.de>
References: <DM4PR84MB1590C08CB556D28CBA707E74A0772@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR84MB1590C08CB556D28CBA707E74A0772@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_023010_252004_C79C9931 
X-CRM114-Status: UNSURE (   9.03  )
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


