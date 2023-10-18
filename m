Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741FACDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgeImjFyZJvEDEIyeQJ9FyrgZWy56AJMJGKok47jdVY=; b=nSV1myDl6bChi/7S3j/fcZx7kE
	EXevjPPiEYUiKTG2HNDzt7V9BHDr9u0EGo5Bmy84kJStys9aqlR28oqqWgVY6gynY2glP97acCjOo
	EDEa5NPh88jYSzNqFP1VyyXkB3qVbbqvcUoLBw6gqcQYKWQliek2sibaxP+47TWSzq53EMfmcVc1q
	l9hc/+GAF6eA92w+CFSn0BtY3c3lbcVVrytsGtQcSP9fem9QQYHcUNKqH4BK0deWrKJYAlUVoYChm
	JG3qByuYj7LV8cqVspCqnzkxMbzr4aIEt1V5Q9oskX2fSdwAyUZgOzXWKO+MgdainAjeGAarLVdj0
	SBzeelYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCK2-00FYGc-1G;
	Wed, 18 Oct 2023 19:35:14 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCJy-00FYGC-11
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 19:35:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 21CD3CE268B;
	Wed, 18 Oct 2023 19:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7848C433C9;
	Wed, 18 Oct 2023 19:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697657707;
	bh=L43JPKpoCPtRsTJ8rF7ZtW5M8jo9RA9sNDg+kg50M2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCVI01Z9K8trdcekZpjfsfnnPSToYG4L9SsCSXCRA/04LjuyT1avdU6Sx9tXwupc8
	 q3YXrB7Ox5K5QVtCm+OVphEwN9pa1UfK0CastukDLK9yIV7qohIhv0x6+Oq5zHkLSS
	 9Mg3BROUyQ1agQvLqsdSIkoplik2wz0yxQyoevaZ/lYkxud4Fb29awsIz1eiycC6SY
	 HCkkiviYXmkitfWm1/T3BxOotIG1/soTk2ccOTJmaNLpYZej/9LIrx8yLkfaWofAL5
	 K8Ko0MS2UARAKiLytDe5X4ty8TH82d5jYDmoSNerfCfmFzY0IQrZOv7DYRaVHETp5H
	 7WfedzYGBS96A==
Date: Wed, 18 Oct 2023 13:35:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
Message-ID: <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com>
 <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_123510_547902_955EEBF5 
X-CRM114-Status: GOOD (  14.60  )
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

On Wed, Oct 18, 2023 at 12:40:35PM -0600, Jens Axboe wrote:
> On 10/18/23 12:30 PM, Kanchan Joshi wrote:
> > Patch 1: Prep. Adds the meta-transfer ability in nvme-pci
> > Patch 2: Enables fine-granular passthrough with the change that i/o
> > commands can transfer the data only via SGL.
> > 
> > Requirement:
> > - Prepared against block 6.6 tree.
> > - The patch in uring-passthrough failure handling is required to see the
> >   submission failure (if any)
> >   https://lore.kernel.org/linux-nvme/20231018135718.28820-1-joshi.k@samsung.com/
> 
> I didn't have time to follow the previous discussion, but what's the
> reasoning behind allowing it for SGL only? IIRC, we do have an inline
> vec for a small number of vecs, so presumably this would not hit
> alloc+free for each IO? But even so, I would imagine that SGL is slower
> than PRP? Do we know how much?

SGL for metadata is definitely slower, but it's the only nvme protocol
way to directly specify how much memory is actually available for the
command's transfer. PRP/MPTR vs SGL is like strcpy() vs strncpy().

Similiar to Kanchan's earlier experience though, I haven't found real
nvme devices that support the SGL mode for metadata. The scenarios this
enables might be pretty limited. :(

The other hardware "solution" is turn on your IOMMU (eww).

