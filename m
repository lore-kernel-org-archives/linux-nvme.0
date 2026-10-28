Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339A60A2613
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NStW0BkP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NStW0BkPALl8+9+Qc/jPNIPKUE
	sVRSCru3nFdrnQLGNYbiqka6pdYcZjczkH+AREH1r5rJ1pu1dlCFKUtv019DFv2UHkLlKQ44QFqGJ
	2UvrSJf2/i0C49ZRFP3NXuwHwRzS051vZ/+zKVOQ7/VsQUShTP7JwwNrsksoaNhykCdJPkNoqszWQ
	Tsj2Tm5C7Unc9rUivF8HoGANBSarvOJTg7/X+DyD09sn5fmMOX1A6VWMW6onrTl2CURSzTPpwNrXU
	IXca5E6w15HuRRJfh2eoQ+IoV+acJnOWt4BbUl/l014VaCJvx5bqUOHBGswByJswbLvzrJ3lruaPx
	T4H5EyBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4lb-00000007DcG-0xXs;
	Wed, 28 Oct 2026 14:36:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4lZ-00000007DbV-0yi8
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:36:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A381B68AFE; Wed, 28 Oct 2026 15:36:33 +0100 (CET)
Date: Wed, 28 Oct 2026 15:36:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yingjie Wang <1075151112@qq.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] nvme-tcp: validate the TLS handshake timeout
Message-ID: <20261028143633.GC13429@lst.de>
References: <cover.1793188633.git.1075151112@qq.com> <tencent_BFD509CFBFC7E76F10959593270DD1CAA506@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_BFD509CFBFC7E76F10959593270DD1CAA506@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_073637_412672_EB8A7276 
X-CRM114-Status: UNSURE (   9.16  )
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


