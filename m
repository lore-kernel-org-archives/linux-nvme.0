Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAA606A332
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=x8/9eMr1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=x8/9eMr1WaDUFeUe9dlLbYS/cs
	8gGRI46ZaMQx61kXoVm7kjNYprUndr6LQLrMZmZvhtDTFLHml5S5BU5Qhf0AymqEZH30jlsIosWbh
	TrX7tC278ss8VGWQ/iRN0WQd50ouXDZnTaER9MHORK6hR/7uSrda00mPa2AtfrHqoKdSOxEj/ymfd
	aU5T73fWFOfqWPTt2In919lK2bubB4fuPucnWJ/3MY+UGZgrYFQctgNlZr7Y7ImSGHgnhJqcfDvsK
	PKShHv79heOiQ/T7RkJufMv8inT8jADCSiuWYsu8qay9EeKIg7cTDggaN29o8B15yJ7hLv8Vgj5HH
	1o+y0RzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7D8-0000000192v-05FW;
	Tue, 03 Nov 2026 05:37:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7D5-0000000191z-3uyF
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 05:37:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E17368C4E; Tue,  3 Nov 2026 06:37:24 +0100 (CET)
Date: Tue, 3 Nov 2026 06:37:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj1072538@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, asml.silence@gmail.com, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, anuj20.g@samsung.com
Subject: Re: [PATCH] nvme: return -EOPNOTSUPP for unsupported dma-buf I/O
Message-ID: <20261103053723.GF1382@lst.de>
References: <20261030120300.4161174-1-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030120300.4161174-1-anuj1072538@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_213728_118857_45ADB06E 
X-CRM114-Status: UNSURE (   8.84  )
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


