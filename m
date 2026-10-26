Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B263606A32E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ICiOIeBD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mOGIq1VT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eK15j6nYIXOPiZjB7jAdCpv6Ohy0hKTb3TgQ9YuqeA4=; b=ICiOIeBDdMAsm2CfOnlRvJh2Pa
	GTGIEMcQttikLHPBRP8MKNmEmhWf7nW/ou6/das3q9jmMS6cEtfxUuIaZmA9auWCm68vw+4rADlgJ
	pOZr3dsvR3250Z7FCwCyIV/q9eNV6tdhWy2NYTHwOjjCb+QzK3CkAsBk96FEZQ9+hG5NOzml+O0dq
	81rXJd6/R/0IYxwybykdLDjY/zJKAPggjWXy269ipl2DnyuJIaZfEyoTRH7OwXwATV+qPxjYua06S
	XzhkM8ehYH0iSdCHLjlbEGez6/d3n/J2s5m7qdp8wmhZmmZ4Q6Adn8uwfDSzjVU66wz4StcqZDeH9
	pRvocBuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN6j-00000002o3A-2q1m;
	Mon, 26 Oct 2026 15:59:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN6i-00000002o31-2DAZ
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 15:59:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BEC340E19;
	Mon, 26 Oct 2026 15:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68771F031E1;
	Mon, 26 Oct 2026 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030372;
	bh=eK15j6nYIXOPiZjB7jAdCpv6Ohy0hKTb3TgQ9YuqeA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mOGIq1VTDMxKZ1VNoZmgx6FyhpJWHgRv8gl/GuFLQ6RfwogCNgdE6pSMSfPrA7z1o
	 0aA09lBxujUN9hy8sWTFU67xP35y0HbYu4Hqg6ET0+9D6cDmtZKODSEDZtjAx8ePzz
	 O7FA/ie+ebCTTgUCEX98/I4auUF99+dmvWpgB3E6KNFQtfr5o4uHvosXHRIUrUfxMc
	 qASQmDsbQH5Tuy12wed2xd+6Mhl6Rkx82kVj55Mr6D9p8KX9eW/Q5Z/VB2V4d7FSh8
	 5iC6x6TS2qJecw1EhAtStfAQ/u7NfULEVq2IXXP4QrOEevLj2tZHnEiVT34vGh2MJi
	 UlwEi6NwEzHRQ==
Date: Mon, 26 Oct 2026 09:59:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: hare@suse.de, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: fix error handling on CHALLENGE failure
Message-ID: <at944v_Bp3g336kE@kbusch-mbp>
References: <20261026164526813_4KvPc2SI-CEJ2Mzh7HN3@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026164526813_4KvPc2SI-CEJ2Mzh7HN3@zte.com.cn>
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 04:45:26PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> In nvmet_execute_auth_receive(), when nvmet_auth_challenge() fails (for
> example when the initiator-supplied allocation length is shorter than the
> DH-HMAC-CHAP challenge response, or the challenge nonce allocation fails),
> the error path sets status = NVME_SC_INTERNAL and breaks out of the
> switch. The unconditional
> 
>     status = nvmet_copy_to_sgl(req, 0, d, al);
> 
> after the switch then overwrites the error status (nvmet_copy_to_sgl()
> returns 0 on success), so the AUTH_RECEIVE command incorrectly completes
> with SUCCESS and the initiator proceeds with a truncated/empty challenge.
> 
> Fix this by freeing the buffer and jumping to the common done: label on
> CHALLENGE failure, skipping the copy_to_sgl() entirely and preserving the
> NVME_SC_INTERNAL status.

Thanks, applied to nvme-7.4.

