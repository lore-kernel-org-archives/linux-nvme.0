Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE81606A6AB
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aMZobCvV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HglSa+HVG1CdmAqrwHc8qHzUvZ9E4XCWCFHhGsOghHQ=; b=aMZobCvVxGBuZoxaQ1ZihQkVex
	xm7xlYSzHCapNeID8BBJc129oCk/hV8+rUWNIAKv3UfpNo8JHF9IlBT4T5fCW6bmFy/yIRuJMLDf4
	/qMiBVP/JsrlQENn5snXgBeedoM49Otu++ZfbtKP5HgQYS69efAf+5yX/MQJoVmGZwecNaIdDfUCW
	cACpBYehI2ktl398/T/HjHo+5QrIixKujAKYhUL+z2iddh7IL5mKLaaeDh+8Z2fcEHKjFtjIDWUO0
	/NNLwaDPquznaYJXc5xNQl9FnlrCoy1GKKUudoNf8MlCpabT1K/VRjsGuiSa5ytS6L/7fpFIm9mFd
	Si/uj0Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUZ6p-0000000GXNF-22CZ;
	Sat, 21 Nov 2026 00:37:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUZ6l-0000000GXMW-1xEu
	for linux-nvme@lists.infradead.org;
	Sat, 21 Nov 2026 00:37:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2CDB6732A; Sat, 21 Nov 2026 01:37:30 +0100 (CET)
Date: Sat, 21 Nov 2026 01:37:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	jgg@ziepe.ca, leon@kernel.org, asml.silence@gmail.com,
	nj.shetty@samsung.com, joshi.k@samsung.com, anuj1072538@gmail.com,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC 4/4] nvme-rdma: support dma-buf backed requests
Message-ID: <20261121003730.GB14598@lst.de>
References: <20261118103327.1788667-1-anuj20.g@samsung.com> <CGME20261118103457epcas5p17770752b910960b84cc259d007120965@epcas5p1.samsung.com> <20261118103327.1788667-5-anuj20.g@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118103327.1788667-5-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_163735_757319_762716C0 
X-CRM114-Status: UNSURE (   7.84  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

How does this work with rxe/siw or non-PCIe based HCAs?


