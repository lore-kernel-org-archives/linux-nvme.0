Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD75CA0FFA
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZWQ5ZTUnw8Vxzt+OHX2UN9mh50fRkE9nQiRn6m/MtM=; b=rBLfFH20YTyIXmIORZRhgN9Hpe
	sMVzLVV50qkze3UrvcLGJZs9CaWGkm50X1EOodIG9/BPTh5uTUVHmRR5Y9BhIsNWp2bjKfTcoPKVl
	LDXuvQrFsRxedCkEHslzvuZB3VCls3p0c8siOPvD//RGfYkGsXd2l5pCjWFDKReSiYDRD1XCvhkkY
	Pjegyuu37EohJPUiA32m9qz2301LvlmH2O7ecM1dubrXNfIrGfg1AvCsYmU8nCibJBxOl28OdeFkd
	u3RqgEnJzSb3J4dTa4z+QUifokGwpjtmWHcZhR0JwDkZdCwZRiPlWHhUd605sDbEjP5bIosupcEju
	Bn2ogXrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdaTq-006VJL-06;
	Tue, 05 Sep 2023 18:08:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdaTm-006VIu-0R
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 18:08:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ABAC460C56;
	Tue,  5 Sep 2023 18:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFCDC433CC;
	Tue,  5 Sep 2023 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693937324;
	bh=DsJzk6xx6CavASRR1dxStG5SMWcoSQ3cSGg9aSgEsew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJWseShIE2CRSSnEGQPhm8lnyYoee/AxQWutbrjDl/Q5jMyc8tB/zNPKECius25hF
	 2jCY0NENG1CTC/r8lGG+lzMtFmEAerhu4dkFT8Hrl46e9Aq9M0j/XV3FsfdHyKNobk
	 /X6CeJ4wjmtgyp8KGZRGItZqdOuxdU60H+DwJeabNuZ/1hyi2dbw/Wf00R4uDMigGu
	 vVtDebVlcdyuMu4BsrnD9buyfytqGOVNy+WsEgF/0ShIDgT8FKsp5R9KA420wBR1DK
	 d0eTERRe9TvmKExfQ1DJ7jVKkQLikMgfc8ukLrbscG9+nIKK8oQIy3VXIl2Yyd/AQx
	 kIQwfStEgwTVA==
Date: Tue, 5 Sep 2023 12:08:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v2 1/2] nvme: fix memory corruption for passthrough
 metadata
Message-ID: <ZPduqCASmcNxUUep@kbusch-mbp>
References: <20230814070213.161033-1-joshi.k@samsung.com>
 <CGME20230814070548epcas5p34eb8f36ab460ee2bf55030ce856844b9@epcas5p3.samsung.com>
 <20230814070213.161033-2-joshi.k@samsung.com>
 <ZPH5Hjsqntn7tBCh@kbusch-mbp>
 <20230905051825.GA4073@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905051825.GA4073@green245>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_110846_270746_FB61EF56 
X-CRM114-Status: GOOD (  28.57  )
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

On Tue, Sep 05, 2023 at 10:48:25AM +0530, Kanchan Joshi wrote:
> On Fri, Sep 01, 2023 at 10:45:50AM -0400, Keith Busch wrote:
> > And similiar to this problem, what if the metadata is extended rather
> > than separate, and the user's buffer is too short? That will lead to the
> > same type of problem you're trying to fix here?
> 
> No.
> For extended metadata, userspace is using its own buffer. Since
> intermediate kernel buffer does not exist, I do not have a problem to
> solve.

We still use kernel memory if the user buffer is unaligned. If the user
space provides an short unaligned buffer, the device will corrupt kernel
memory.
 
> > My main concern, though, is forward and backward compatibility. Even
> > when metadata is enabled, there are IO commands that don't touch it, so
> > some tool that erroneously requested it will stop working. Or perhaps
> > some other future opcode will have some other metadata use that doesn't
> > match up exactly with how read/write/compare/append use it. As much as
> > I'd like to avoid bad user commands from crashing, these kinds of checks
> > can become problematic for maintenance.
> 
> For forward compatibility - if we have commands that need to specify
> metadata in a different way (than what is possible from this interface),
> we anyway need a new passthrough command structure.

Not sure about that. The existing struct is flexible enough to describe
any possible nvme command.

More specifically about compatibility is that this patch assumes an
"nlb" field exists inside an opaque structure at DW12 offset, and that
field defines how large the metadata buffer needs to be. Some vendor
specific or future opcode may have DW12 mean something completely
different, but still need to access metadata this patch may prevent from
working.

> Moreover, it's really about caring _only_ for cases when kernel
> allocates
> memory for metadata. And those cases are specific (i.e., when
> metadata and metalen are not zero). We don't have to think in terms of
> opcode (existing or future), no?

It looks like a little work, but I don't see why blk-integrity must use
kernel memory. Introducing an API like 'bio_integrity_map_user()' might
also address your concern, as long as the user buffer is aligned. It
sounds like we're assuming user buffers are aligned, at least.

