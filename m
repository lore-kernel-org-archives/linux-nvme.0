Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F8606A32A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=18J7BONS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nY1XDZR6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5dEcbX5s5qmv2wurBmT8xVbkW814DN6IZmvbQ6LWlL0=; b=18J7BONSn0xBvrMvixGAKMvsHW
	N1aIwPst8+Yb1e2ddJlUexwbu+7OJ4DQgIm1vYqzXdpvZa3dY03UCOJbwjX/OlwN1pEYl2Bl5mdYI
	WQpLmBFae100yxTQ8VrkrtzMI93vLSIBgg4g2QVx8x4drL4ZjLdr+zX2r5HEkIRyF0jVJG5Bk5uiE
	To5eYetvo7bV2w0jTNQ0y3aNgBNFZHbYZpn28lBD6DXKMeZj2N0KdSlEhHeQJiWcTjw1t2nzJMgMW
	3Lu+Nz/SVsQcS4YJ2Cptu3ceahTThS1WiPMrA4cczVvO8dxVCFYrGkhPItZmigHbiEiYWERO2eC4G
	AAOsuFUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJuzY-0000000EQid-3LqR;
	Thu, 22 Oct 2026 15:46:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJuzX-0000000EQiU-3Cxc
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 15:46:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D000B601F8;
	Thu, 22 Oct 2026 15:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F66A1F01825;
	Thu, 22 Oct 2026 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683966;
	bh=5dEcbX5s5qmv2wurBmT8xVbkW814DN6IZmvbQ6LWlL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nY1XDZR64LxKf1GSKvNKfUwY0gPHbOhxNN/mfJoR55AVkeE9TeaaOPh32uVx1ENR6
	 7sYzDZURPkfHTfv6W9dEHciPmIRFCvzcnt3325FXI2jGfIP6sJ/6ti2W3l+JBZsrMB
	 ZU8ERgDPWz7TRTpkiECuJ2U8hSXE/VJMO5bG8cyGlT4dDzqiX1M2Kju7CaG5kIsgV2
	 H8SsJKpQTcmiO/uZQ8vLdH15PhhL+zs071cEx930jbRHijm4W0BTw/VU81s1b3j++x
	 b0Ka7gPSSF+3hVM1FZ9pzIy9DgcPOzcfwNQ3joIb2xH60LoQKgv4Pzx9S/PioKZOQO
	 E3A0Pnzlv5Kgg==
Date: Thu, 22 Oct 2026 09:46:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prevent double-free after metadata SGL allocation
 failure
Message-ID: <atovvKM7kjv296F6@kbusch-mbp>
References: <20261022062923.3761399-1-thnkslprpt@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022062923.3761399-1-thnkslprpt@gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 09:29:23AM +0300, Avi Weiss wrote:
> If metadata SGL allocation fails, nvmet_req_alloc_sgls() frees
> req->sg without clearing it. The RDMA error completion path later
> frees the same scatterlist again.
> 
> Use nvmet_req_free_sgls() instead so that the scatterlist pointers
> and counts are cleared before response cleanup.

Looks good, applied to nvme-7.4.

