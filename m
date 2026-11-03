Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C121606D811
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IDjFoNUn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3TKZXNe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z7grRwM8WCPf1zlbK4nUUkkFYLNOkxsXBBTP+mvK+4c=; b=IDjFoNUnRah+KHmycyemD5kGI/
	OEu43ijHlgryAI8eCYHuG0ekbC/DfgcIAVf3U10MEJEdm93eWAVPPnIA/z49RLzjDUslpI5JCoxaD
	zzm88jHZo7ZN/OycdTuZ6+eHwpHSZ16qFtQYhUvLxFvdp1yTTaBlfKNVWelcTRbYMpdg0NbBsVJDu
	esg9fPRBNXp5Z33SEFaZTmhdt9jd+vKduJrVRVpNz/N4h0bP/4bvVz/NTIil2Ta6AvdLSoaDuVMwf
	GF8chKnrJuHei8hTvonvXOE1MmI/R3WGC/nbF+SmGID31bglL3JMucXYzx+M6BvrNeRJL3vohxEC6
	UH8UI81A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJrn-00000003Ufp-0VpS;
	Tue, 03 Nov 2026 19:08:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJrm-00000003UfO-14cj
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:08:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 690A76021D;
	Tue,  3 Nov 2026 19:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEADF1F000C1;
	Tue,  3 Nov 2026 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732897;
	bh=z7grRwM8WCPf1zlbK4nUUkkFYLNOkxsXBBTP+mvK+4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O3TKZXNecHe8eRQZymbl357ja5s5/vT3IHeQm6MhGvHFK5QPNE1fbbRac2ZmF5/+G
	 crXqtNDZShkO1BeegusGfu+7n1ivVwRJYd7HpXE0W/+QqHZNcxwf9iZQcsrSJQVpkS
	 OoXYciWFNtuFTZVcIY644I0MWCIy39JCY2sS9N3BJ54GFvYGRk5zaRrCwgcDCtcaWw
	 sfvC6rdBPl5o3owyWUMcfQQ7U7q87cNkiceT+UBGml531OeRCHvImchlNj+j2fgMA9
	 HYZ5KlXD5ffyOa430iXwFGPZQo9YwfR9QSjY6JcO1LN5KbpkF1dKrOOMvMQ++CDod5
	 uvFTiT2lPsENA==
Date: Tue, 3 Nov 2026 12:08:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Liao Xuan <liaoxuan@open-hieco.net>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	default avatarZheng Tan <tanzheng@kylinos.cn>
Subject: Re: [PATCH 1/3] nvme: Add adaptive PCIe link rate switching function
Message-ID: <auoxH197kQfUJGaE@kbusch-mbp>
References: <cover.1790134954.git.liaoxuan@open-hieco.net>
 <85a11a4085d04a2823c04059702630cf34abf6d4.1790134954.git.liaoxuan@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a11a4085d04a2823c04059702630cf34abf6d4.1790134954.git.liaoxuan@open-hieco.net>
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

On Tue, Nov 03, 2026 at 02:25:43PM +0800, Liao Xuan wrote:
> Add support for dynamically adjusting the PCIe link rate of NVMe
> devices based on I/O activity. The link is downgraded to a
> configurable minimum rate during periods of low activity to save
> power, and upgraded to the maximum supported rate as soon as the
> workload exceeds a computed threshold, so that peak performance is
> maintained under load.

Pretty sure PCIe ASPM L1 states would save more power than downgrading
the link rate, as well as have better entry/exit latency than a software
driven monitor and link retrain.

