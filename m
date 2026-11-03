Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5D606A33B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=N+QM7Yim;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwHjcn84
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=x/wJ3DGTD4aXi5Mbef/zMqUC6tC0zT5pgWi9hfdwqBo=; b=N+QM7YimtVa9Yl7LEhBaQIWSKl
	COhNstYC0WEmU2f6mdwa5hgGVc67LE9bg+Hm7XYr0sVbDEZtHaFNiT6XRpUCyiPUlSEUMx6C0pUAS
	9+Wu7wZf0ZVIJ3zJFfnOm+dZR6EsrSu8V+CYS/vJvppATscZe8kja8/wNAqZx3ndqvtC64sTba9Cl
	f6QBp2tpqzztffa/RXwgdkRyi2OXrw2iN/YVP8LLUWQtFfiZ6GeD46E4k93F0ep5V9mScoSZGsg70
	RzRiDKj9On+FtEPjEXb3aB8UdSDiBnyOXDkECAlMZe1irF68NstyXzJVvbgF1cd1shn5AII8qAVIj
	xS2xUZ4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGZT-00000002zPz-1oc5;
	Tue, 03 Nov 2026 15:37:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGZO-00000002zPL-0Aug
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 15:37:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BB1FC41B63;
	Tue,  3 Nov 2026 15:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568101F000C1;
	Tue,  3 Nov 2026 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720225;
	bh=x/wJ3DGTD4aXi5Mbef/zMqUC6tC0zT5pgWi9hfdwqBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cwHjcn84RS/VnBrF7xVdgMFmbL6710fBbcek1OEjy3HGkO919GSPcuNjeO8MS28na
	 UcQ5AXYwXMR0Qh1DphgOg+qxLHcs7KG7IreeCGwJRI2/SMVplYJ+/XRPFeRCeNSTYP
	 4Baz2B+xYcosKiMGOx1ql58uVvHum6MAUNu4pJ8Jx+UEkrQq7VMX7kO35n1jQe0BDB
	 l5eXVsVKs4q0+96BD/E0kOxCf/zcMRjr1xxerle/4DgYRldZjFKvIG4aJaZNoluRx3
	 EUBXbLc/87HuAirUcCNTEOvsG9nebdrn7ZIp2pKW+umP9ueoVN9JQEXL08G+GpK83N
	 o0LdC9KG7qZvQ==
Date: Tue, 3 Nov 2026 08:37:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: pci-epf: Constify struct pci_epf_ops
Message-ID: <aun_n7DKm3Xc86hN@kbusch-mbp>
References: <3e4d3ffc4e3ec822759782afbaac1279c4a83135.1793482573.git.christophe.jaillet@wanadoo.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e4d3ffc4e3ec822759782afbaac1279c4a83135.1793482573.git.christophe.jaillet@wanadoo.fr>
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

On Sat, Oct 31, 2026 at 10:36:43PM +0100, Christophe JAILLET wrote:
> 'struct pci_epf_ops' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   90026	  19680	    768	 110474	  1af8a	drivers/nvme/target/pci-epf.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   90090	  19616	    768	 110474	  1af8a	drivers/nvme/target/pci-epf.o

Thanks, applied to nvme-7.4.

