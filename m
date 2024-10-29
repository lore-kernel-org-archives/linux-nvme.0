Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411D9D2AB3F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5H1OlWnX2Ky22v1qL4NAaeeQjxN64duIgPly/jUmP4=; b=FWxTKLB0f8AmqUxukY7S1UdmV0
	pkAzlut0svbX5xlooBvBF853SxvnUqQP5dMMj238gF8p3G0VV1hF6Y6a+5sLLeaf5gDOz48maHAri
	6XhR+62zyVNk5O3pIv2kgTkWGhdXNfmav/xjdgunH9C8INKWVmLy51QJxYgjCFtxMvHxaQr0jnF7Y
	v3Nt+FuXQmk4ZXmB40dkCG6uDGMxYV6gWFAkNf6XAOIGjQ7VmhD6PPTZ4rdmo0Ce81/cfZxI78Mh3
	PXcptlCRTPH3nbwKJc43lvCkCRWRggsixjTZvIEfhZWJjrgFx3AmNEDjaf3CvTlaLzl6y/Sdq+Nf4
	5pbXGeIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mmc-0000000EfDq-27oM;
	Tue, 29 Oct 2024 14:01:18 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5mY3-0000000EcQp-1md6
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 13:46:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B4364A4210F;
	Tue, 29 Oct 2024 13:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01F3C4CECD;
	Tue, 29 Oct 2024 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730209574;
	bh=sv54OmCpstl5fNhPde/IyJRPPd1n/h+lewt310bVSwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grr8DLyaAuqnoDhc02kO+ktwTvLqY74ySZ12nrgz8zvNqGk6Z/gLCIktm29Mfn5zB
	 3ipRrtv4DqjUu+h1jV0KRjwrKxKrT0tjb0y5mbxKnn8RkLCPF2SLdTW04cUFiVKp81
	 NmnjWTtCiT3cPfPuMklp68AMMpxuUlFm+YUg+PLFLkYY3c8kbfDNQTNow8oh4LncAl
	 16cXnrrCinCeOSAm1xVRFvDBLLHmrIHrt7usMUfvy+lGwj2OxPGxrZNubHzY2dMncG
	 /fba394EPkXn5s5nRtv0QCd0kvwcror0FodO8QYEdCn2fIAAX7bOm1oGIRGp4cKGiK
	 lWXLNlapyySyQ==
Date: Tue, 29 Oct 2024 07:46:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, anuj20.g@samsung.com,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: re-fix error-handling for io_uring nvme-passthrough
Message-ID: <ZyDnI9IAp7JLNqL6@kbusch-mbp>
References: <20241028205253.2054407-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028205253.2054407-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_064615_550997_A05A077B 
X-CRM114-Status: UNSURE (   8.20  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 28, 2024 at 01:52:53PM -0700, Keith Busch wrote:
> @@ -422,9 +422,13 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
>  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>  
>  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> +	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {

There should have been a '-' sign in front of that first if statement.
Fixed up and pushed to nvme-6.12.

