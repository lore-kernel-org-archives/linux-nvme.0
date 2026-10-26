Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E6606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=LT0iWrli;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZhlpQ4N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eZAP7Nz9rXRWZhVSYPJ/pbBpkrnLzpAj+W5fvtEnIBg=; b=LT0iWrlirVcTm/k7V0aqtJi1lU
	TeWNhbk97b7VfT/15wDXvf1CzVlDisqTPiCCKWEynytUbZntGSVQeX0HyT5X7Iqx68Y6xKV/XWKqH
	XR+ujq5rmKIFYGtlajr6X/RKshNhmurFph1wC6lqVH2nhpUSEENulU6jTQ7AACHLOHt1VUxjG4zQi
	9MY62u76FAGhRHTtoSuQbhzqQaLfYpARZH8zLkKYGW3/MdEzWjmJ+5yhZIGpt3BQCIdzwogYeTx4g
	wJwrpfv+C4ADrieIpwXbeLREnn1oCZChhMelkSnjGqNBI/HmPvafXEwxXXLpqLixRJD7Ro05m41up
	YGffsd4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN5y-00000002nuq-1VcE;
	Mon, 26 Oct 2026 15:58:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLN5w-00000002nuf-12Qd
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 15:58:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E8BCF43643;
	Mon, 26 Oct 2026 15:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AFA1F01825;
	Mon, 26 Oct 2026 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030323;
	bh=eZAP7Nz9rXRWZhVSYPJ/pbBpkrnLzpAj+W5fvtEnIBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IZhlpQ4N5DCp/PmhUmxzRbgq9jO+mfSoW1UQ1VvC5j5CmzacXCjiC1v2VmxZ2GWTN
	 LcyGxJ07ckVqTLeU/4sI3D9k4fp9qMrSxaUS9Of3Bq6nIsVEk+gJAXlkWcm6lvh3VQ
	 b4dCTbR1BycywQqPcBSJylYzfiKEShKlU6EzzqwgUZioQP7dXfaYNfOSEFVa7zfdKU
	 /PpGAWTKIU0eHorMa593v84AAqgqKIH25WOIQRmQZCreyWVRkFGSEISCLlzMDEEkNC
	 LamIDbM/x92K1NTCfdQX6tzpKEsrGt0t4LuBPIOKlcuwGCuEcGNn8Q1frbIfhzREnc
	 J1J5wvdT2BwHA==
Date: Mon, 26 Oct 2026 09:58:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: use the enabled transport when disabling a port
Message-ID: <at94snlz2OrINQcC@kbusch-mbp>
References: <20261023191851.5316-1-testwrzwrz@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023191851.5316-1-testwrzwrz@gmail.com>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 24, 2026 at 03:18:51AM +0800, Rongzheng Wang wrote:
> nvmet_disable_port() looks up the transport from the current
> disc_addr.trtype, while nvmet_enable_port() records the transport in
> port->tr_ops.  If trtype is changed while a port is being enabled, the
> port can be removed through a different transport, passing the private
> data of the original transport to the wrong ->remove_port().
> 
> The same mismatch is reachable with loop and RDMA: loop add_port()
> leaves port->priv NULL, and RDMA remove_port() dereferences it.
> 
> Use port->tr_ops for removal and serialize trtype changes with
> nvmet_config_sem in nvmet_addr_trtype_store(), so the transport that
> added the port is also the one that removes it.

Thanks, applied to nvme-7.4.

