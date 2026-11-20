Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E056606A8AF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Yx0GEODm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QOZNFX/nBMD8dtqCcd1YeGLtmkJUlgcuCtcg/u+IkYk=; b=Yx0GEODmSSCRbAOYusAW/kJEAx
	GC6p9RoALzjMPQ+Y+v6hsdx3raqJr1a7BgqOlgJNu2qgzgyYdLf9q4eWuUca5FoRvBCYXSQbtSCZS
	PLypNLaLzf61nuyyAFaynpSnectmgnUfKhPA6XsTQ/Kv+zgpmJd2ImhCDRNiIe1IBPAyc6P93gz1m
	ZT5Bat6FamiPS2KmoKjPgwWJBju2G5MM1m7UCksBltxUnQxnD3jM2H5w0WtWu2xECWpDdwa1ubtve
	0DRUqEIYEZs5uhpefBSfw9phjdmVS/ZSdm6Og05TprX3MkdhtEtBDTTBktL049/GtNfBsxV/0BS70
	hqE2aQLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUT2C-0000000FraJ-0tJ3;
	Fri, 20 Nov 2026 18:08:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUT22-0000000FrYv-3s85
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 18:08:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F7E36732A; Fri, 20 Nov 2026 19:08:14 +0100 (CET)
Date: Fri, 20 Nov 2026 19:08:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Moritz Hiller <m.hiller@pc-heini.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] nvme-pci: NVMe lost after S3 resume, CSTS reads
 all-ones for a few 100 ms
Message-ID: <20261120180814.GB1810@lst.de>
References: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_100825_267024_580BA6C6 
X-CRM114-Status: GOOD (  13.54  )
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

> +/*
> + * A controller that was shut down for suspend may have lost power while the
> + * PCI core still treats it as D3hot, so nothing waited for it to come back.
> + * Config space can already answer while MMIO still reads all-ones. Give such
> + * a controller some time instead of declaring it dead on the first read.
> + */
> +#define NVME_RESUME_MMIO_TIMEOUT_MS	10000
> +#define NVME_RESUME_MMIO_POLL_MS	100
> +
> +static bool nvme_pci_wait_mmio_after_suspend(struct nvme_dev *dev)

I'd probably rename this function and do the initial read of
NVME_REG_CSTS inside of the helper as well to keep everything in a
single place.  Otherwise this does look reasonable to me as it
automatically takes care of this issue without affecting setups
that don't have this quirk.

