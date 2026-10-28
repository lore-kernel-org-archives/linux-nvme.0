Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67B606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c0cN+Lfm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=c0cN+LfmenmJniAjM3UvQorvCU
	UHKRsyCNsp/6JnRd/jhTy24VY92hR96btmO7JXdY05B3fZFa61bib55vBgssrgnh/lOSjgrynEgiZ
	SYQV2zyO6H03SPGiq/ryquOW21bqK/sN8UJdScevJd+6xM92rpmVxpPiuws4njiANAQbmnyGmxLan
	orKKMxCE6ovI1XeVrCqYG0XkxGVuXkwNxwRCdHDSx+zVSsTF2AxjuEpb6agj8ycssOZhVBjrNZnsd
	zVMR2TmA2u8TDA5oOYqyWJvjXb0t8WBaR5VrLRBrhBOh9LHUBYZUlLyF1t8qPvHIM27ldhr8G99+4
	sVLKxKpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6YL-00000007Xcj-1gjw;
	Wed, 28 Oct 2026 16:31:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6YH-00000007XcP-3TI5
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 16:31:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DFE5968AFE; Wed, 28 Oct 2026 17:30:54 +0100 (CET)
Date: Wed, 28 Oct 2026 17:30:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj1072538@gmail.com>
Cc: axboe@kernel.dk, asml.silence@gmail.com, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
	mkp@kernel.org, bernd@bsbernd.com, joannelkoong@gmail.com,
	miklos@szeredi.hu, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, fuse-devel@lists.linux.dev,
	joshi.k@samsung.com, anuj20.g@samsung.com
Subject: Re: [PATCH v2 4/5] block: map dma-buf iterators in
 blk_rq_map_user_iov()
Message-ID: <20261028163054.GA22862@lst.de>
References: <20261022144501.2478417-1-anuj1072538@gmail.com> <20261022144501.2478417-5-anuj1072538@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022144501.2478417-5-anuj1072538@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_093102_041118_F0301BA3 
X-CRM114-Status: UNSURE (   8.68  )
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


