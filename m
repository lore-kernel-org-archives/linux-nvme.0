Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959AD606A321
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UfaPEnoT;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=c2UFkE+k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Hoa2uDGRiz+jXLxbcD4HBQF2SzMfWsHt0csEQeOTfAo=; b=UfaPEnoTKIKlfWaq3m9OsJsxcF
	mf3PlvzSiS2Md6OiwJ5KiJhOD6/l8sCfRI95OpdBgl3+Y88FEVYiFBc7CEsNd0uLrNHM9Io0UT53+
	306Z0e00xEWAWSTW/nKpYlV3B4kbmbWOupGkvMgXBjCX6ImSAsVKgh98mD9FXHeT7CqGn2tFrFd8O
	Sc5uvbBaKM1DxV8tTXaTTIbSNDxDT4U9w9K3YA3ylnNHRGJpAMJWIjMVmA8jril5Vktp1CmpclWc3
	SEg4vZGMVxZBLHvbvimNdt3sFsoZBAhJzQoqzJEeQ78Hsv82xbjnG11ZukKcFXbn01z+F9EN2ohCK
	Z6lbWlyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVt97-000000074lF-1DFH;
	Tue, 24 Nov 2026 16:13:29 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVrNt-00000006jK5-0Q9W
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 14:20:38 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so744871266b.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 06:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795530035; x=1796134835; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hoa2uDGRiz+jXLxbcD4HBQF2SzMfWsHt0csEQeOTfAo=;
        b=c2UFkE+kpmARZpAEyElVuoAFOy+6DOPbXiEVcx2COUo0IPx1E801js4mnGsp3fcZJ2
         rqKd1MwWiVcKxifdhg7iEiJU/BFGD3ITB0wzRXFnwuftZVyAeHMREeS08K38SkowyorP
         zBHjVRiS2/wkb/XR1Oj2z9I5JD5sij4MRbfof1T3CQiYELvxYMcwGfc1dvnUz/sblPMA
         8TuP40N7ZokRNuX36rofHIyI5SICue0X3WNq5od4NKo1kwbf4YNldkKE3y8HwswOuhFs
         fGBPMIsALnqpFFB2dWQwJVaxSoz0AiW5AAEJpPMTLnyN4BKbPHsgSfDFhzsJzA/fSgcu
         irjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530035; x=1796134835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hoa2uDGRiz+jXLxbcD4HBQF2SzMfWsHt0csEQeOTfAo=;
        b=ePKW41wOJpEqa4v4Tydc/rlI2BBp5maJGvbiOhkZg+/CPFI8wD+2EOzyyZmhbRBgSK
         iCUfUx+jrk5f8suXJ8dVJA+L4MjAREeK6KlW/587xOu97ADyY5xzeYnnrt8LNfWZk0DL
         jh+nSEkeoUq9E1Slpyf7V4Zf8ICz1LFTmnbFVJGXFrMLwlRlllW2NGw9RwT+lup1AfyA
         yLKRKn60ThUfNrFvhwX7vUZKOuJDlpGFYNMo4O2GtfyDG+urExMMGXcrze1O4wbVHMLW
         6TWKs8PzDc0RuBRk4R8w8u7+mFOYXoJ3KjckZQ3sQsVvAMhXhaR+aA1TmqaZX4w0eupF
         tQIw==
X-Forwarded-Encrypted: i=1; AL+hErFRzPnx+50rCc6kXGoJ7sfgqNDZ38yzw4HlDmCpnDhi69Dwz8xZrJZi7aM053Qlscz1fXH0VcnhWeAT@lists.infradead.org
X-Gm-Message-State: APuU4Z/igKBekdJC5HEIhwSnPCTMyJGatg3NHmFOUXZsNW61NaNAvZN4
	9WdVbrdRWVfp3Gbln8grsKwHk+TzbveKiQxXh9W5zly3bYgs1m6kBw7iaUMddR7+kfo=
X-Gm-Gg: AZFdTZehjyQ79gTSadx8HROLwKr8dsw3/XLvJcm7pv5INFEnT1WvMYAwWr/oIW5m8vZ
	81je319IQob2scVrynOF3+Kl8J1s2MHQx909Q3wrKLOUTuMYStu4UFfMKEKQ3/cTt36TdsC8STm
	RfslfdYNU7affnghNsKnlIN0T+OzR6t/2jIZCL4a37mBocJ7EtfZephavNTkCxCcNJGiJo3zskE
	cKM1QW8Fb4RgIofGsUMNKTW0SsAK8m68Smsx0weTT2OXLl8ORojpY26WpMxxk+ztG2CO1W0HU+E
	rtKk5603gqs/uoR8Kcs68ztvsUbFYlZZ8iXlDcmFF1LfpUco3InKa9WQPkZnd94rkDYUOIrPLQJ
	m/6m84WZSvSKdeuzjNO0B/LET7COgzKfyz9FK5zd87D1VWGvAnWRAJ4hkfBWix3HjSpki/A0KBy
	abvgcYfN4aWzIKvBpvSbk4ZjZ9ihCfcQqqBnR0Nf8EjyNDCkAetenrXa7r8Bv+Gr+idH4iVpFnD
	6zdP7VyLDaKoq8Sf9M4gMhKI6TfUKUzEyXX3sAXhVmprHfyPIbT2xCTCW7Ov5bcq+gqxbw2gswd
	Fj5kT5lDxns73cpupFiVew0eug0=
X-Received: by 2002:a17:906:eec9:b0:c51:5589:35a1 with SMTP id a640c23a62f3a-c515589d211mr891019366b.5.1795530034479;
        Tue, 24 Nov 2026 06:20:34 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae8dc60sm518286266b.34.2026.11.24.06.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:20:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVrNo-00000000RS3-1UVp;
	Tue, 24 Nov 2026 10:20:32 -0400
Date: Tue, 24 Nov 2026 10:20:32 -0400
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
Message-ID: <20261124142032.GN9566@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_062037_173569_5F4B2BA5 
X-CRM114-Status: GOOD (  23.58  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:13:27 -0800
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

On Tue, Nov 24, 2026 at 01:36:21PM +0100, Christian König wrote:
> > The core then negotiates compatible types and adds converters between them,
> 
> I have strong objections to that plan and would potentially NAK it.
> 
> DMA-buf should *NEVER* accept CPU physical addresses nor provide
> conversion between different address types.
> 
> Keep in mind that DMA-buf is solely a container for DMA addresses,
> nothing else and it should not provide any mapping functionality
> whatsoever.

dmabuf needs to provide support for drivers to help them use the
interface, and going from physical to dma_addr_t is absolutely a
common task every driver must do. I don't care how you call it, but it
is a service that must be provided by *something* and matched to the
needs of dmabuf.

I will definitely NAK any direction to open code dma mapping in every
driver again. If we are going away from SGT then we are fixing all the
DRM mistakes, including the wrong open coded DMA mapping, sketchy use
of SGT, and abuse of P2P that seems to be endemic in drm.

Meaing the exporter constructs a phys_addr list, gets a P2P provider,
and some common code constructs what is passed to the importer. I
don't care if this is in "dmabuf" or some "dmabuf library" or
*whatever* but it must exist as common shared code.

dma_buf_phys_vec_to_sgt() is the template how to implement this
transformation.

> > and having SGT as a type is what allows that. It only exists for unconverted
> > exporters and importers and eventually goes away once everything is converted.
> > The idea being we don't have to convert everything all at once, whilst also being
> > able to add support for different interconnect types. Are you ok with the SGT
> > type if it is just transitional?
> 
> Not really, it just complicate things.
> 
> What we should do with the mapping interface is to add the
> information in which domain the DMA addresses are to be used.

You need to negotiate the actual C data types too, especially if you
want to do that nasty idea where dmabuf populates an iommu domain.

Jason

