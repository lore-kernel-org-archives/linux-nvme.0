Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7781606D830
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=06U5dO4e;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xyk+97AE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/c1zn3KVaeuftBM5pLVbJS/I9Crh6BPkLRgI1SFz9DA=; b=06U5dO4ej26jRFglCH86YpC3/g
	2CzonQ/IagM4lIPKIf6krEraF888jvikB8icsmY2uDsVS+yrWNBgog0PcinUrmprJZHVorp5e/hlS
	vXUyrMWvJv+C8E+KDwGiYTn5YWQVD/mlrwwDAUiqvR5N2fL49Oec0iDbeVKgY2X3g0yNRhLBvCPt1
	fmwbF2CLXDlrchrc41luaOqC842vKrvfLqXornq93MK21FfjswoB3b1CTK2CDPlrp7ATygbno409z
	Bdtx5XCwQ+AsThZ0DHAoWMuhx3d5rSb2YcSAkH3Q+Mn3l0OSjWgLpoxSVxHvq+QaBtr1XQLTKZuE5
	0hgt61uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMrn-0000000D4Be-1p8D;
	Fri, 06 Nov 2026 16:32:39 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMrm-0000000D4BK-0cmR
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 16:32:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E353C4327F;
	Fri,  6 Nov 2026 16:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADF31F00903;
	Fri,  6 Nov 2026 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982757;
	bh=/c1zn3KVaeuftBM5pLVbJS/I9Crh6BPkLRgI1SFz9DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xyk+97AEiRwE50kVeWNdmLo7y/RwBMQZnw1PIDz0bYK16NncoArO1pRV/YMsxQ6pn
	 oDwmLUfb/81vfzC9lu+OikICRNHzmUaX0fYjq/QKdAOQtT1UJuOLXqo1qeSkbTDfxF
	 OQie71djoQzTm5WSTdJE019NZGcLtGHLuQ9o7+ec59EccABjVutZRqfh6lyOAQGJK2
	 AH8Ql/sh+TtO5mw4V2k07JqawjKNqkJrJs6+OoHRedVSNhNxfsjnS9d6lz1VTgN+FJ
	 m+iQ0Kp92WsehzYe9p3je0Ri/9TbZB1lE6LKCVRAwWckShfOjJaKGrPtsk918MR76n
	 +SfQ/F3o9sSuQ==
Date: Fri, 6 Nov 2026 09:32:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chengyuan He <channinghey@gmail.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, Chengyuan He <channing1ne@gmail.com>
Subject: Re: [PATCH] nvme-pci: add NO_NS_DESC_LIST quirk for SSSTC CL1 SSDs
Message-ID: <au4BIz7NMY0eMWky@kbusch-mbp>
References: <20261105134526.95382-1-channing1ne@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105134526.95382-1-channing1ne@gmail.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 10:45:26PM +0900, Chengyuan He wrote:
> Signed-off-by: Chengyuan He <channing1ne@gmail.com>

Your sign off email doesn't match the patch's author. Which one should
be used?

