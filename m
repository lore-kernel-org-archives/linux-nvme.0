Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F013606A32C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hX1Uzf2j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AQ2NoHNfE6JuTHElpIAm4hcefTgCPppw1N23euXgdyE=; b=hX1Uzf2juVNYY8VPwzXxjvYskL
	6dCZsBKprKPVY3TXFY2CTucUV2EOg+CINQsynB1ztAT1ICfrfNwsTulw1n7hwpfFrYD2I1eOPfim8
	ah1yqhSq6Uh4yiTJ41CTroWhFyXxlOHlXQiPCssLE09FCrmFoWcECnO/wkzrjd1cyattGzDLKtHud
	ddklnpvhLW1yxnjibqWaOXNMvCDlFOXVtUbIoxoV3Q8/UvlAikoR7KO5vxnU3hq+vtWX40beRuV91
	BzxNOzA9u/e4BDum4cFn9aTsZ1SGGk68zE/raY3tvw7g9sJ/ucHhYfI2GQ0nGSWZdARbhHLqyR25r
	DWPWFYQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqVv-00000001Kzr-3V0m;
	Mon, 16 Nov 2026 06:48:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSqVs-00000001KzH-1yxm
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 06:48:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAFB168B05; Mon, 16 Nov 2026 07:48:20 +0100 (CET)
Date: Mon, 16 Nov 2026 07:48:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 07/12] zloop: take freeze protection when recording
 write pointers
Message-ID: <20261116064820.GB2964@lst.de>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org> <20261114-work-fs-frozen_writes-v1-7-f5ae61c898b1@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114-work-fs-frozen_writes-v1-7-f5ae61c898b1@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261115_224824_673379_7C95BCCE 
X-CRM114-Status: GOOD (  10.19  )
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

Can we get some kind of debug check into vfs_setxattr to enforce
callers have taken the write protection?


