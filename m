Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8ED606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TXEkpLIQ;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=I2y5OoTn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cCMOaZdag+2OcXEDMl2EbRqTcxfKhXeKWu4Qydoaad0=; b=TXEkpLIQlHHwG5HuW1Osbejeqc
	uLE5agHKfClOVSMy7oOwgd1JFkRFXtGQykvJ6A4bW79zmSKxWO7lz69noskAdbtzpjjSCObsITzcm
	+bJ9Qdfhbw/+EkKNXMCFcR98mAlzyI2lC+/XkhF6Un0NHkRvb1BQlY96qMjhLFv+CsHGZH3aObGwA
	x5Uz52bQzvKGNoKpKJ5Vv9xZaAbixS1G863xtC3P5WPV2fUnrAQWkwfOoVvNqxYB55Zsl5TiTzrLG
	Re6B8YpJvgLKYqPwXGxIvthKMhPG1ukWq0yUW8dJIhnJ1nYn/WTyJL3igwjVb+Ji/549ZMQuc29FY
	bRkbpGjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW4E2-00000008Ml3-34GU;
	Wed, 25 Nov 2026 04:03:19 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVwT7-00000007cGf-2yDl
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 19:46:24 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-55ade1de0b4so58632151cf.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 11:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795549580; x=1796154380; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cCMOaZdag+2OcXEDMl2EbRqTcxfKhXeKWu4Qydoaad0=;
        b=I2y5OoTnJnLkoQ4Pz8S1lsK+eK0MXZ06rG4f+tIOBnifemhwRrfVZ/eZNaHwX1EflL
         2ACFGsOh3sSy/Nm6ClDN78KxcR8t5ISsmyuhXB/C6Q0Eld9mRmiGyC/Ftr0x33zf5nfx
         1sGk2RZ2DBhutX5cio6QczbkEz8kghVQ844cKrGfjwVup9okLGtar47icqpu1vhOf+9c
         j4cqGgzcppZll5Pe1Aehl8H7xRZLhtmrl//YPtMTfmcPbwkj2+2rM/HLPl+kK1ZK7jDB
         VU9RxmI7LuJ3YkJT8QFP5Rd3h7N9CV9WEf/ExyaD1APyDXMbkrFceJrgzwJSYv0W2UZ3
         yjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549580; x=1796154380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cCMOaZdag+2OcXEDMl2EbRqTcxfKhXeKWu4Qydoaad0=;
        b=J7AbJDdrj91vYyDgbMQJZmazToZvBAFGSwhSPbRwpj66BOCljZ2x3P3W9VDr/D3YC/
         5Iq6LGOg19MVEQ3XtjeMozT7XnYf/eVPCY30upl1nrCVEa93hgdHUUUmHaYldFxgQORZ
         STEgvo9JWPgLzheJ/6WGMT3h9Pco8L48QHMDwtsFgXGF+5WxjaC5QhSu37icCs1+zwob
         il3u2LLBBuoO4VwLM1DWYs7uxw2j4Hk9D4N0C8KQXyULI1rcJ8LMkvgtQtDJAIXIf6Az
         vpvuOLP7ElnGwVdpjKTAPgCfXo0VswkmiNZSVFJ7ZFh1LgiVnUlykCuFfosLCL8/bDvJ
         wIQQ==
X-Forwarded-Encrypted: i=1; AL+hErFx8PkChD3ZEogaR+cwOKR3/0YTI96DJTL+b1JEofhbd/17hmlVTWRUriWH1Gm2I7SKikbrWn/fVOOS@lists.infradead.org
X-Gm-Message-State: APuU4Z/rZgAPl7UKLMznKDGS8Pbhlp3M0mbjCTCt2hJ/6OSGIMEVm4ZU
	NqM9+VfV/esp+F6szmVxokqI0gFtcM/b8T+Jb57UQrvjSCKWP4i8rufRPf3BcutDLKI=
X-Gm-Gg: AZFdTZfKuNa0vflISMcJ2OZZhhLys7T31hv/8XhU4hbnE3j4tWIAyE7cfF+vxzHJwmq
	ey01Fm5eIeKyiUWuezcLycFXHiNBQeQVRsiV7kLHbiZsE4DsxMCZzVULm8dEGKsVpj6p+mNj0cU
	zzInQpbaQe2LnhV4/SHxnJ/bF9z59OG5x/bix8zixcwMIhNc6ebWmlwXwGc7Uut/U/QkeZhYTqj
	f28HDWlvQH/6exF80yrTYRTVwscjsLJtHzPmPpXzmynCqB9Wz4KXZILBr91kmSHPkGYMMSTOuAF
	osW/9bF5/J77iVA1TVFDfi3rFOx5YGGxCYTHNovYzNTNwP6ehKQ2ti8LD6oTCt3E7nHCxJBiRL+
	S2QPJonHtqURa4OoRKXbvtB8DwUFoNtXzCGM2fvRauJMEsNktgw52gRq/63OZuSpkzXcPyINN1j
	5q9HL+L35g/WzFpvLQAN//CtVec+pE7Eltfs4WimumgwCzXSPX0Vd5rZ5TJNsoyT1uAJQK+uecu
	wLdhbI/OFoWt2AtTwhKn7OCqru6KFeGsH4+lgZILWVcMlQ3DTdHA744fx8xDVf+UrjpwbLpIfNa
	ovpNBg==
X-Received: by 2002:ac8:5c8a:0:b0:55c:66f0:5bfe with SMTP id d75a77b69052e-55d76a6f55fmr288174681cf.22.1795549579924;
        Tue, 24 Nov 2026 11:46:19 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882ea2dsm135596661cf.15.2026.11.24.11.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:46:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVwT4-0000000113s-3B2s;
	Tue, 24 Nov 2026 15:46:18 -0400
Date: Tue, 24 Nov 2026 15:46:18 -0400
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
Message-ID: <20261124194618.GC114530@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
 <awT8prWsj11TBdmP@nvdebian.thelocal>
 <63eb7b6e-e0a8-4443-a434-0301ed59beae@amd.com>
 <20261124142032.GN9566@ziepe.ca>
 <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a5a2d3a-e42e-4dc0-8d22-8dd1bd249501@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_114621_753472_0FD93FD4 
X-CRM114-Status: GOOD (  15.91  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Tue, 24 Nov 2026 20:03:14 -0800
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

On Tue, Nov 24, 2026 at 05:02:31PM +0100, Christian König wrote:
> The whole conversion from phys_vec to DMA addresses is something
> some API should provide based on the data the exporter/importer have
> negotiated (e.g. p2pdma_provider for example).

Yeah, probably, and this is exactly why I think it will take some
time. Building a new something in lib/ like this is not a
straightforward task.

But also, this:

> > You need to negotiate the actual C data types too, especially if you
> > want to do that nasty idea where dmabuf populates an iommu domain.
> 
> Yeah agree as well, but to be honest that task is negligible. We
> first need to figure out where to put the code.

Means you need to get the phys_addr_t into the dma-buf code so it can
do this conversion.

I'm still absolutely NAKity against allowing any DRM driver visibility
to an importer's iommu_domain if we do this hack.

I don't see how to meet all these concerns without making dma-buf into
a "converter" framework...

Regards,
Jason

