Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902A606A31B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aHN4mY1l;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WCvT85l+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X+hgZpi6s8zitINqxdtV3NY32G2toc0s1ujAuu40Bds=; b=aHN4mY1lWYU4Gr65/QbLcsv26N
	JeFtI237cYUb/ULGMEMfIOO3EO09TQZhp5HILvzyfbcnxegarXk8Jf6e1lRFCVMzjBDvoDaHaeMGf
	PUzOKmxcMHE090DB/KciZlNpDyebWJP5eLmHPlICiDIaKUylDLv8aCTcBig2vreIQ7vx/st58VvrS
	geUIZw3WqaqyAmlQYWm0KGxwROu01diGDGSqaiDXujsH+cG1j/h1iybpu/UVSoO4itjDEHebx+JWq
	YwWbDfhP15d+GAF0vXwd+Gl4Cn0LzJ4bxAfsLJmSZIb4IdawcMNjR4nEkq9Zp5Hoot8ht0RW6SUsH
	ooFrNZJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJd9X-0000000Cr2m-2QQ9;
	Wed, 21 Oct 2026 20:43:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJd9W-0000000Cr2a-0M4u
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 20:43:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 808C243A1F;
	Wed, 21 Oct 2026 20:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56C61F000C1;
	Wed, 21 Oct 2026 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792615393;
	bh=X+hgZpi6s8zitINqxdtV3NY32G2toc0s1ujAuu40Bds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WCvT85l+M7vTXVdOSjvWu80mi6GWub+PZZf3lI8wNnsP/A/vd2Xa6CnSvLHJF1lYJ
	 ldFG4vYTZ4hx0b0/Uu0Iz19+/9418gCW0jP79P/LMsCtGL4YnMULwet2uEGibn1jh8
	 pbjUcYUH424ZeWdOvaP0RHhndcc6u7bQnNKyzAOAunAUt8/xRIqQHYbc77/eKe46wD
	 o6b8akppup4YR0drKqecUYAaRet3P9REgqiSo+CzN/r7TUHmdZe7HSFqvCkxbnpCoZ
	 KCp1zteSv40HEZNvYL+U6u4dhQtinkxeKoHLjN1O0P0bB0gduZ9PAAMY0MAfPrUb2v
	 9wOy2B/bMwq0g==
Date: Wed, 21 Oct 2026 14:43:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Lee Duncan <lduncan@suse.com>, Hannes Reinecke <hare@suse.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v6 0/4] nvmet: avoid recursive configfs open
Message-ID: <atkj3yg7e_ff1vt2@kbusch-mbp>
References: <20260926092148.128937-1-runyu.xiao@seu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926092148.128937-1-runyu.xiao@seu.edu.cn>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Sep 26, 2026 at 05:21:44PM +0800, Runyu Xiao wrote:
> Several configfs store callbacks open user-configured paths while holding
> the item's frag_sem.  If a configured path resolves into configfs, the open
> can re-enter __configfs_open_file() and try to acquire the same
> non-recursive semaphore again.
> 
> Add helpers in configfs for opening non-configfs paths, then use them in the
> nvmet file-backed namespace and passthru paths.  The series also pins the
> target-core db_root path and uses the root-relative helper for ALUA and APTPL
> metadata, so the helper has its target-core consumer in the same series.

For the nvme changes:

Acked-by: Keith Busch <kbusch@kernel.org>

The bulk of the series is outside nvme though, so probably should go
through a different tree.

