Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C016606A682
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=19Q4UcYP;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=F/nXOW9p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EFVYxWaHZcfOFQ3BpTu3S3Fo2WDIpYYjIvIe38jWEXE=; b=19Q4UcYPUmbAAt/+31Kj5GR3zd
	Q1bkriGHc7t35PeH9AwT1zGdKx/AUCdKyVmg1CQDPfnJAWeFCPGbGNQ6+so1YbIHW7FFTzkhWAU7J
	OZy7au/CKPWB9vEp6lsEckTdFeu2eMfHRlzNGcg6BEEGOC5f6XOjXlYul4AwypuXHGICuC0BfkSRF
	bCF8rxIXHuR5DH2SB/QcL3P6EJtr6Di6S27poUPKepWHiaN+1bGjJ8dhquv0NfjeQhxdSpMyKAZtQ
	THSbWbjZPzzbGThuPOSpNgl5/swnk2UYaaWmttyzuh8E0oWrqzv+UWEEdomp+Xw8qa+gbTTM6xe5M
	ExlwBobA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFyJ-0000000Aaeo-24EL;
	Wed, 25 Nov 2026 16:35:51 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFLm-0000000ASnH-0e1U
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 15:56:08 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-55c5b6584ceso44443371cf.2
        for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795622161; x=1796226961; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EFVYxWaHZcfOFQ3BpTu3S3Fo2WDIpYYjIvIe38jWEXE=;
        b=F/nXOW9pKTQqZ84OTZmS1AHBtJCxyrX+MIZs5paRp7yPiBWRpAjPDQ2SNXsTtfP6dR
         FqXdiq1fVMEytIn4I8YkEIKjnZKy7fr0rXEh9kXwch2G+AaWEUk9rPW8FGd4mYLADUrP
         U/rvLzwDNIBe1QmUpgNaYENb0Dl9xAuneeiyjK2IyQMMfZggzAsPCepb0lMTdM/YqCaK
         qlLs81ct6x+JBDoBVhIYvD3ksdOozhweBIsoK8EWwLFUb/tUp6lU00Y2ymElhvl5HePE
         ENWKweWJ8LRzWNjuiF4tFt3/Rt/L1FTODTTxZBbbhEEvZ8iqazQXM3rfEHBawUP0GhxF
         nwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622161; x=1796226961;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EFVYxWaHZcfOFQ3BpTu3S3Fo2WDIpYYjIvIe38jWEXE=;
        b=KT/V0ldIUkhu2VUFtXjFOY1kpTmMUGHhEpfjlVYa1G7AGJnhWLVwyGFdCJf6sZKo6x
         ou4tcCZkK72yeXtL/1YWgJB9vzCKBubFYC5wkXVdjNNz9NuBdAI6y2jHT2J4gISxxKiO
         C5qvdQ5rNd+fbAwqSGh7wi94jlUUNVN0N5SFKBBo0pjNTAKjKxc304gO0AJddIGrUzio
         LVxK1S82HsZ1s0rDOAtXZyM5FtoFkUxN5NPKM9nxhWvMLOJ+VVmQEK05FYixG8s5+kcr
         OoQ2MAK8In6SNNfIpDGycSsBTd8R5bgqREABkvcMdCpoYAhkMqP4AL0IVpQpBIMo/cxf
         e00A==
X-Forwarded-Encrypted: i=1; AL+hErFoWuVl2ZoMsWgIZpI+o4opvK6ck10hThaH8oLr47yNUa1oFfYYG/pK86A/ZfOlDdkEWEujP/Vhb5zl@lists.infradead.org
X-Gm-Message-State: APuU4Z+DgBoOdDIZ22LYAGzvGW56ZhBOpFe+mkR1zSphtwHDEKOLBYpt
	l7c0GIBB9HwjmH4fsAmmbznij22K+WgxE6aBtjNk4XSHLCHvKvuoZp3pIXF81lOow5s=
X-Gm-Gg: AZFdTZerU7l6gv8ZV0bESzMfnCCIG7mUboeu9lj7EiRs//2UY7R4wfZVIiGzwvT/TkU
	eAV5FICuslNRSZq6SMxWAA1YvQjyeSaWOo54Q7oLhfvAnFOPxyNZy32tDNm5HQn/AaH5yPUzMWN
	Zs/itXDkbbtGfhuLh842e9QziStkF+RO1M6cFI3YZkOOpvE5urrQ+3vtTz4WwhJtopVyyzqI8R0
	LLXQ9cmVIxEPP69vPPfuZP2vzzDb5p8dy6fek8CYlh3EZlGECiK+PExk5dV/24mr2AV21fAq/ri
	wR7kdupVYevuEKXEYBQrHaDSWw7oZjR5nOB7y/8urH8Ep/bdW206T4OleV+7oJJHNpocvaKm8Ca
	UQbzMlRGieQ2koAfI0bjwk19JH/2YuUwZuUtUDK+HMYx5bVPkBPHvW/CpH2uaVXjosqh5kq88s7
	w788GK3tTFxUWmLgYOxhOSbGdvW9J+dEYZ5ZwzWXgz+USmwR9MwpQXVpsYYpaC7juXhRi1iiYXp
	n0//Uo/l3P8tL+9CRQf9nCgy+8W5YrVIUZMh2HgnY49zwuwsLI/kcZ73J9jP10+oZUDMHo13l0I
	4/2djvZi/OFnAybvlmv7YxzPj+Y=
X-Received: by 2002:ac8:5d89:0:b0:536:5696:e8c8 with SMTP id d75a77b69052e-55d769e4561mr347501161cf.28.1795622160509;
        Wed, 25 Nov 2026 07:56:00 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882bf70sm160274901cf.11.2026.11.25.07.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:55:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWFLj-00000001uyg-0aUM;
	Wed, 25 Nov 2026 11:55:59 -0400
Date: Wed, 25 Nov 2026 11:55:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com,
	treding@nvidia.com, jhubbard@nvidia.com, chaitanyak@nvidia.com,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v3 03/24] dma-buf: Add the SGT DMA mapping type
Message-ID: <20261125155559.GL246011@ziepe.ca>
References: <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
 <20261124194618.GC114530@ziepe.ca>
 <awZ_Os1pXelOGaFP@nvdebian.thelocal>
 <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb9a6b12-c134-4e40-86a5-dbcb59c0b91b@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_075602_204471_95FF5A46 
X-CRM114-Status: GOOD (  35.13  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:35:50 -0800
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

On Wed, Nov 25, 2026 at 12:19:08PM +0100, Christian König wrote:
> The low level API which talks for example to the IOMMU driver for
> creating the information how to access the buffer is simply not the
> task at hand for that framework. The stuff we already handle is more
> than complicated enough.

No matter what name you give it we need something in the middle that
can see the phys_addr_t and the iommu_domain..

If you don't want DMABUF to be that thing, then I'm not sure what you
have in mind.

> > If I drop the type/placement negotiation for now and focus on SGT removal I can
> > simplify things a lot. Plan would be something like:
> > 
> > 1) Introduce a new C data type (dma_phys_list?) for exporters to pass physical
> >    location info and context for mapping.
> 
> Something like this maybe?
> 
> struct {
> 	u32	mapping_type;
> 	u32	num_entries;
> 	union {
> 		dma_addr_t	*dma_addr;
> 		u64		*generic_64bit_addr;
> 		...
> 	};
> }
> ....

"phsyical location info" means phys_addr_t and related, not
dma_addr_t. Step #3 has it as the *input* to dma_phys_list_to_sgt().

The flow today has the exporter get a phys_addr_t (ie a struct page),
build a scatterlist and directly invoke the DMA API.

The primary issue here is the exporter *direct* call to the DMA API!

We cannot disconnect this from the DMA API, ie to use an iommu domain
or ualink, if exporting drivers are hardwiring calls into it.

Fundamentally the need is for the driver to get the phys_addr list,
exactly like today, and then pass it to an op which formats that into
the right data structure for the importer. Be it dma_addr[],
iommu_domain, or some ualink_addr[] - or whatever.

This is the main issue here, disconnecting the exporters from being
hardwired to the DMA API.

That's what Alistair is explaining. This sequence:

> > 2) Introduce two new dma_buf_ops - map_dma_phys_list() and unmap_dma_phys_list()
> >    - which are replacements for {un}map_dma_buf that converted exporters use to
> >    return a dma_phys_list instead of returning a sg_table.
> >
> > 3) Move dma_buf_phys_vec_to_sgt() somewhere other than drivers/dma-buf and
> >    rename it dma_phys_list_to_sgt().

> > 4) Update dma_buf_{un}map_sgt() to call the new map_dma_phys_list() ops and
> >    dma_phys_list_to_sgt() to create an sg_table for unconverted importers
> >    importing from a converted exporter.

Effectively converts all the exporters to produce a phys_addr_t, and
then moves the DMA mapping action into one single place in common
code.

With one single place we can figure out how to replace it with a call
that does an iommu_domain:

> > 5) Add dma_buf_iommu_map() taking a IOMMU domain/iova/offset/size to be called
> >    from iommufd for mapping an attachment into an IOMMU domain.

But that relies on iommu_map having access to the dma_phys_list *which
is true physical*

> I think a whole bunch of other drivers would be really happy to use
> that interface as well, yes.

Right, that is clear now, that it is not just iommufd that wants a
dma_buf_iommu_map()

But I don't understand at all how you imagine to implement
dma_buf_iommu_map() if you don't want this in the DMABUF core code.

> That totally sounds like a plan to me.

I'm confused if you agreed to what Alistair said :(

Jason

