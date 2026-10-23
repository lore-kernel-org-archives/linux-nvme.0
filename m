Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2857606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K3+Njezr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EmWIX7py
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JIHnvuzaQ5ZaIF1NU0SJfDmZPDxAaZcX5jQwqu9v+jY=; b=K3+Njezrs/Pd+xRnsqZMoOrU2v
	4YEUAFHmxV7EDB/SlyZ2mcBSKfizgwvKOM5C39CZRPWF2+se2LL1nkechL/RlSfOpiGm2VAX5yCqw
	s6NJr2Fowh1zpcR4FrHCrGMzBQfcGm20X09scVqvb8J8cbjfOWOTFLb61/6RIWi4i0VXaI0051OZZ
	/T0lHgI2ZclKo/oyIYEsh/TZIO/mRrFTOEQRRPceQPGAGI8bY2hcWcWtafDPJqn3a5oFlzBhMPMEJ
	iYCCcnv7sBoQ5wP8/kF8CDQnzKslOEiU94zI2Lt//9tr1pvj/XVzMuSrzqK7OabL4UyqX/OWKR9Xt
	1NeO8m+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKNPZ-0000000H2Fz-197n;
	Fri, 23 Oct 2026 22:06:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKNPY-0000000H2Fq-3D8g
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 22:06:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AFD11601F6;
	Fri, 23 Oct 2026 22:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417711F01828;
	Fri, 23 Oct 2026 22:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793211;
	bh=JIHnvuzaQ5ZaIF1NU0SJfDmZPDxAaZcX5jQwqu9v+jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EmWIX7pyji4pSwQGWA3G2hvYBOj0LV0M8FQZuLnQy04MbRBq+TF1UOOhsZ9jBiWm0
	 IOjQYamTDPLbi3cWrp/eAuZLOhsmTmg+uQ5T42I31cziSoH4ai6c/oGb9PBMFrQPNY
	 DAkxMLHVmBrm1nVr0L1ECGdyi8/VU99xAkmiDVt55E481/W1BXfuyrwzE7QGQ1NAci
	 cRoi017zIhdcVFHURrPx23G9gkkQzmqwVzIpdKOY9Ejn7I0JJ4hVeyMe4ys2/VXk5T
	 JWmZAT1dBArCpICe9IdPjS/p4wIXR3z6QynJf1Zg0+9LEzy0AeQmuJUbRstMjrgWYT
	 9IO5CPyj9ZUrQ==
Date: Fri, 23 Oct 2026 16:06:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Martin George <martinus.gpy@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme-fc: fix reference leak in
 nvme_fc_nvme_discovery_store()
Message-ID: <atvaec8QBbeb6IAj@kbusch-mbp>
References: <20261023140057.6045-1-marting@netapp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023140057.6045-1-marting@netapp.com>
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

On Fri, Oct 23, 2026 at 07:30:57PM +0530, Martin George wrote:
> nvme_fc_nvme_discovery_store() takes an lport and rport reference before
> checking whether the rport is already queued on the local discovery
> list. On the retry path (goto restart), rports that were queued in an
> earlier pass are skipped by the list_empty() check, but the references
> taken for them in the current pass are never dropped, leaking one lport
> and one rport reference per retry.
> 
> Check list_empty() first and only take references for rports that are
> actually added to the local discovery list.

Thanks, applied to nvme-7.4.

