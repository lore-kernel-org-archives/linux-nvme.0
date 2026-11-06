Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB1B606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kd6GAQjZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JRtwqFrJiTlcH7IlUnfhdcgVF0fHLiXHFqm+d54kneM=; b=kd6GAQjZ3zwAHllz63kh1vuW2t
	JroTKrLVkm2hqFJmj4pu6vb5QILgctoybiqs3DGf7v54TvO+B5xv/wYOuXoLxNdwHBYa5X0TCfR9j
	RQVJyHpWliDJ71KisKriIEQ5mdOCKKdmCrB4A00H+7D0rfB+ClaLzG3WnCDRjhZU5OtlweRX0dgi5
	lvKOrZShPrtbP/jsxRwrjHz7HP/ce3GOPhIY4jgYgOGx8RHz75PFQho+Fo4k7g/uuXlzESvuVe28F
	YGpOOMhKTl2gr9NiCQnmSzL7CM6H/rIaB6tdlYfSL5mDiHgOYFowLbD1yefpCmyt38XOnM1wKafUY
	VF5sjRMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHCK-0000000Bvw5-3IV5;
	Fri, 06 Nov 2026 10:29:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPHCH-0000000Bvsx-1MYs
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 10:29:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 42F9D68BEB; Fri,  6 Nov 2026 11:29:16 +0100 (CET)
Date: Fri, 6 Nov 2026 11:29:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	mkp@kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: stop asynchronous event work before ANA
 teardown
Message-ID: <20261106102915.GA5391@lst.de>
References: <20261105114149.970315-1-shunsheng1218@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105114149.970315-1-shunsheng1218@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_022925_512492_8B23AD01 
X-CRM114-Status: GOOD (  10.93  )
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

On Thu, Nov 05, 2026 at 07:41:49PM +0800, Yaohan Li wrote:
> NVMe ANA work has several producers, including ANA AER completion,
> namespace scanning and failover processing.
> 
> An AER completion can queue ana_work for an ANA notice and can
> separately queue async_event_work, which sends the AEN uevent and
> submits the next asynchronous event request.  These work items access
> controller-owned state during asynchronous processing.

I think we can cut the commit log after this..

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


