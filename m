Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B4606A321
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TvOMpLs/;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YTcxefK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=; b=TvOMpLs/CHOvEj
	aZSyyKKfUR+ord7WXeE1J03S5vEtAT/bMg8aREOhdzFAcR4qcCzUXk4IsXr6Jv5jvbVSWJEovwOV4
	Xkl0ZRT4b4E5VWhrK8kNtvCfw1l86znkmsQ6TSvz9Xdr2TZqPrOYofBC/wIsowFby8eGVGq8OnyCN
	EHCc/ulStXzfqBLCGALpsFjr8XMyuESgyU6A0ekLmViJpKpDvQinXuga9aBP67W0hKCCJroBiGXFL
	GJScHsZRUItgGZ5aoWeNscUy6anqKho7XoYy3Y4KIhhdCbZGDW7V0kftPL9O+cTPiPOn1Hf/i2JBU
	h/1kM6tK/6wBJvZ/SZrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWqWh-0000000F8z4-0aPv;
	Fri, 27 Nov 2026 07:37:47 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWhye-0000000Ed2M-451w
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 22:30:06 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-921276742e3so68492266d6.2
        for <linux-nvme@lists.infradead.org>; Thu, 26 Nov 2026 14:30:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795732201; cv=none;
        d=google.com; s=arc-20260327;
        b=SbV8ZCdl5H6DsT45rAiLCne8Hjwly0WR5Rbd2jP7m0rmwmIMlFGjbg3TRdHT3Lq5LS
         aIW4RUr5GJ2E7niuJx6gOghkgCYjXu85aPF72HDymFWx6nAxpa9UNzZWd5UEggRRdM+Q
         mZyf9+dv1IifEYWfhuK2PGbgtEoyxRiMr2COgTZNLnJE8yUVQdP2L32GPjOzzx4o6/o0
         nOCuqRi/lrzCQ0P5MDlinPCu5YC0UscJRNiZkYuPH0v+G1zrvWVzeeQCGQDk61j9A8jw
         HcwCtOgsY7m10/ilsHknYFHA3PGJFJrPED8QgGN9gV2pAJPqqyRiXeeS0R4apzAbL6b7
         WOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
        fh=3vO4Xxr5WE42amqn5WiI0sPOnsuIc7Pn3usVm/oIbnI=;
        b=YFnWByIEt5+DTjoGoyS14PPDx4+w6gM20GZRPtAkqnmZ/aGLIj6KTQptPkHlZCGWyQ
         TbHWhjCMHzSNGsaFbD9eU+D+5fE9uSMe9rggWeJahmYDPN/5N9A4XM2XxjDqsokaIUH5
         eo3zKo+fC5u53iKavCX4bGUHm6TJNKZbKI4gdvLI7AXHnyLBp34Dnup3kkgT7G4X7Ygy
         5aq9ntDftOHzLnYL8qeenmZdJFwrRF4nlHt984xJ7Wk3TUfiANaKhshEC5z8lt5QA2oA
         FvFxTTFiz6lHRRynsPQwZg1WKrTh7ODDoCEV6CPoniwlkEOmWSSMbIzjPZg7IUr+q/Eh
         KemA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795732201; x=1796337001; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
        b=0YTcxefKFnock6Pg3rdJE4RLQE4vQEkvwCePcJUxoK5aJ9+RkORw41tdQIKL9Sbpry
         cCyiZmR3HQ9m0IBXZbg60rYFBf+l1Ix9x/6/3YbWh9IMEnmYc7WEV4jQGl5o1VpZE/qb
         w3+iNyDu6+hIiTQ6xZivNZ9dQSCdGJwgLoDWsFoE1GSncuNOwjOafukL1pMd+FpQKadj
         xbeKSPL/5KM60p9mKsnToGV/0zzJQFUre00svTOMwetQC8OBvlC6qygDahiT66CIJAvD
         +OajFV2zi1nLgSNUxcxIFEH9Rsl/juxjw33R4+Uo3E3DMHi7ZEQKlHr6KxFTaN6Osw+O
         oKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795732201; x=1796337001;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUCXb4AyKiyK8pPk+hGYGeIEyQmwImYeURjhzfVH220=;
        b=ARuYrWExISC0CxcpVfEut6Z3y82sALWOn0tSYnJ6bffYyXjLWcICfxkBau0gbLW0c+
         3D2/P/z5NQnohc8BlkFN/rp1UxUKVwmsEn5gqny66BtYLL24oJoKLLjQqlyBBqES7pLj
         zDOMXHVSGnY8RNM2WY3ECA38PpjyYtXjSFkOpT5rZZeA2rAbdarxMt1OffiNEUmFkbXP
         3uCvYsqW1QatZCOKyxMMLQyLZrr3mmL2zbMuEmjpg8qpGLJP1jUN57tAoSeyMm9nnJ00
         Q8HsrzQvvs6U9MgKOqt/NSz+gvcL8fxhhYJTdMF1bX/LHAPqNPODGMVVNHR52w81ucBD
         J0Sw==
X-Forwarded-Encrypted: i=1; AL+hErHA9W34oaRifYFZ1YmNCMHZ5ORkOYOvZVCkk16rdFFzzTuFHEpkk77Ur3kfRk6Ige9Yum3p0d4qTeyi@lists.infradead.org
X-Gm-Message-State: APuU4Z8/DbXWnW7IXS7M6567y1hIzzrR8LSwoPcrSHi9s+uLr4zdMZo4
	6VsATD0B1k1Y3w/M/sk+67GMBbIz1Q1ioQqctOkUfY+Auq5RQ4Q/HEE6A+h/xrr2reVDFAP2gop
	QcM1IjZc0cRpcnjF98SiBwNL7+q9/gPs=
X-Gm-Gg: AZFdTZeyK1xW6JjSIYIWyeFmCWUI+zCmWhXhOnkHIRox880kQDHETGMFqS3+9YWGfRe
	+CIUopt7SPy3b+u8x53QDj5EURH0C5dnosTpKS8Dgv9UrpqJEoeiLtdWxvu+rYF3n3mBvw+KReM
	KqfKTH1zGJP7zXjP97lBFljzkBF+u14LLMNnMmsDEI1IBvHSxaZ6LltBgYazaxeNTfP1OdHFOTy
	Bc8oCqqt69cvPjhmJK8s8kKO/OJ9Vze5GekdIpgfiVcb2Ll0chTY0w13nxnAvDCOS8QqNYi5nut
	MlmA775lpT+xGQIiXRPVa4Cw19T+DVbz+jh5ZW1/9jQdVb7iwOHdIcQQx8I6r5PIVw0dIi7xysB
	nbxuJlSVLF6qlPOUCAeKy0B196+MBbNyvo2aMONMR9I3+z9vVCcCl6eDs+IONvLSXZu/X40rEnS
	6QqlL8GSe7Oxm9vnYoL0BHYQ==
X-Received: by 2002:ad4:5d61:0:b0:91e:8bb3:82 with SMTP id 6a1803df08f44-92134988818mr432424486d6.4.1795732201165;
 Thu, 26 Nov 2026 14:30:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com> <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com> <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
In-Reply-To: <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 27 Nov 2026 08:29:49 +1000
X-Gm-Features: Aa3M54rvnH00v1NCtGrc73zPMs4ZrSy5Ip3saymlbe4-GLTg5bt7TBC0zEJEFjg
Message-ID: <CAPM=9txheaE3=fp7=n4fYh-xshxOm+Tv=eQn9wvHVAc-b1JKDQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Dongwon Kim <dongwon.kim@intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
	chaitanyak@nvidia.com, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_143005_051036_87895395 
X-CRM114-Status: GOOD (  37.42  )
X-Spam-Score: -1.1 (-)
X-Mailman-Approved-At: Thu, 26 Nov 2026 23:37:45 -0800
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
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 at 03:26, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 11/24/26 07:23, Alistair Popple wrote:
> > On 2026-11-24 at 05:37 +1100, Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote...
> >> On 11/23/26 17:57, Jason Gunthorpe wrote:
> >>> On Mon, Nov 23, 2026 at 02:36:46PM +0100, Christian K=C3=B6nig wrote:
> >>>> On 11/20/26 06:55, Alistair Popple wrote:
> >>>>> From: Jason Gunthorpe <jgg@nvidia.com>
> >>>>>
> >>>>> The SGT (Scatter Gather Table) DMA mapping type represents the exis=
ting
> >>>>> sg_table/scatterlist based DMA mapping. For now it continues to use=
 a
> >>>>> sg_table for map/unmap, but this will allow a future patch series t=
o
> >>>>> convert to using a different data structure for importers without h=
aving
> >>>>> to convert all at once.
> >>>>
> >>>> I strongly think we shouldn't have an SGT mapping type in the new DM=
A-buf mapping API.
> >>>>
> >>>> Instead we should have something like either an array or an xarray
> >>>> of DMA addresses.
> >>>
> >>> My plan was always to get there, but I don't think it is reasonable t=
o
> >>> start there? There are too many places all over the place that are
> >>> just hardwired to do SGT right now.
> >
> > Right. There are around 70 drivers upstream that make use of the sg_tab=
le handed
> > down via a dma-buf import, so I don't think it's tractable to convert t=
hem all
> > in one go. So obviously we will need some way of phasing this in to giv=
e time
> > for each driver change to be implemented, reviewed, etc.
>
> My suggestion is not to convert all drivers in one go, but rather to come=
 up with some sane representation of the DMA addresses instead of using an =
SGT in the new interface.
>
> > Obviously some of those will share a common structure/helper and conver=
sions
> > will be similar, so that is an over-estimate. But based on an initial p=
oke
> > around there are plenty of drivers that bake the sg_table more deeply i=
nto their
> > data structures.
> >
> >>> Part of the design of this series was to allow the conversion away
> >>> from SGT to be done incrementally without breaking compatibility.
> >>
> >> Do you know the joke from the hitchhikers guide to the galaxy where th=
e dolphins are happy for exactly the same reasons?
> >>
> >> I'm pushing against this plan for exactly the same reason because I th=
ink it will make the conversation away from SGT even more problematic than =
it already is.
> >>
> >>> So it is effectively this:
> >>>
> >>>> The framework should then either connect the SGT directly if both
> >>>> importer and export are using the "classic" interface
> >>
> >> Yeah but that should not be a separate mapping type, it's rather that =
we just convert back and forth from DMA addresses to SGT for compatibility =
reasons.
> >
> > Right, I think this is actually fairly close to my plan, which is to pr=
ovide a type
> > for each address class an exporter can produce - either a CPU physical =
address
> > or some device context + P2P/MMIO address but in future could be some o=
ther
> > interconnect type.
> >
> > The core then negotiates compatible types and adds converters between t=
hem,
>
> I have strong objections to that plan and would potentially NAK it.
>
> DMA-buf should *NEVER* accept CPU physical addresses nor provide conversi=
on between different address types.
>
> Keep in mind that DMA-buf is solely a container for DMA addresses, nothin=
g else and it should not provide any mapping functionality whatsoever.

Is that because it's called dma-buf, if we just called it's shared-buf
would that alleviate things? I just feel like there are use-cases
where it containing CPU physical addresses might be what is optimal
for a certain scenario, and re-creating a whole parallel
infrastructure that ends up being 'I-can't-believe-it's-not-dma-buf'
would end up being bad.

If we need to shared object backings and have clearly typed and
negotiated on what the backing contains then we should allow it.
However I mostly agree on the mapping thing, I'd want drivers to
negotiate and natively support whatever backings they can rather than
having an intermediate trying to handle the conversions Not saying the
code doing the conversions can't be a helper, bit it shouldn't ever be
autoamtic or outside driver control.

Dave.

