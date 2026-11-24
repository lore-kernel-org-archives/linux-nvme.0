Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B3606A683
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KPNLk45v;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oWrZac2G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=; b=KPNLk45v4ka+M6uJcm0yqLlK0C
	kg3jmeFB4ACxlbW1Jr2pp69D14cmziFs8FKSA9n+mw6rYKoI3jY3nk1OkIduiH5nsrVeM7naOEqH/
	w4ue1ft8fTXgqU+oC+KpgXe3fBEfkCKrGkLCK2Me48ENMnUBll0PHBqK/ZH9c4B08B0Bherw+7p6I
	lVfaGkWx230u7w/LkYHJkdbBaJ60o4TglhwAgG9LgzaHI0AjpyFjM1cS6ZfzkkFFbcBZniJhOePbL
	rr9rxg8/lT3pLQwpgs+m5iL69ULOlNxfzrmxY6oKKCVqjg3FPa+ywh0dllMsSjg6tPsAUcJnkjtrN
	RJthFRng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVt97-000000074l9-0lon;
	Tue, 24 Nov 2026 16:13:29 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVr4c-00000006hYE-0o8t
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 14:00:43 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso900440266b.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795528840; x=1796133640; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
        b=oWrZac2Gd2w/Y8y1afsdnpb/7JKT8hg1bgo1XgnZj7nUpa52e/pcB+FvMNLgv/cvke
         WYjWQsndPKgX0Vh3Lr3hBcFcM97UVCh8RPwg9rMU1OQ5VCKsTs5ViKSMWWB4M9+djx08
         8mI4RNH91VaAtnT5HWxdNLaurQGDlGugJgurc8fxOXocAGOhuel3NA8PGjMIR34l3l7K
         QSednLo6Ro6tRP36oO6ZDU9G306Apw3PQH18kFbeGWetbptoreVjAjh+ctk1eCK86T97
         4GhEmncDagjEH3w7QdjH4AHn4DvHozYskoGi6DWe9U/8enqoPvui92T2TVkQPQKRad/6
         tHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528840; x=1796133640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o+7iSwGfMjtzT2Y6Ygii4nLjUX3g93NcfuA7HOwwEkw=;
        b=QdwDgp0p6ejZDXHnXPPmPf8qki+RrHzD0WT+Q602UU9FibJuA1EnK+B2mLtAM9khQ9
         kSemYNXqNQGBRvzIRtjxas8fmSA0ZKFs1Sp4JG5n1i3GHAK9Wb5VOOnLMfkcN/iNy4He
         PEewbMJLpAjM1K/qmhSGZ+EATVdRaO9zYeLlz2XMwkUNV5m6s+y2j3/iwyHKSdVX7MUX
         kp7Bqg7P7SjddjEQkRNvVU+rUST3jeKwIOTPWJKCHZcAGFlbwfHg7dYrlXXEUidkd48t
         gDfDe2OyBdZJhlwVeHgWf2j26dQYbyrJnoC3g8gJCzMLt3TYVLRu4PXNkGRdGHcPOEom
         7Gvw==
X-Forwarded-Encrypted: i=1; AL+hErEuuNsk8CR1+e9V/70jOTlreL7Fw6GNl8JqIuZ+fynpT0+JTiV14jwxn29ylXP0nr37HZL6w1VNqWe4@lists.infradead.org
X-Gm-Message-State: APuU4Z/Nzw4PFVdRhzOQPEWgGy8DyEMW1kOAwqmy60J3+rP7VHQt2DNw
	NqcKvlw9wIjZdSH0keGD9lBsCqpFsARo1/yYID2HrkR478lFW3+LUuL3c8nKHxgYA/4=
X-Gm-Gg: AZFdTZdjuARmiQuVp8lc0zUEMhpoHqrv9dW2ZLJrTVbqWSbyJhDGKXsjc/wD0f3k0sW
	0KV+PbXoMdOnH0OMUBRxvxY/NUL9GBm1T0Hm7VSlAk7ZsOUDRtjv1xsEQ6a9BG2n2bknuZSCGmY
	Q4+piZird+A1g4+eSkXybbHlWIU8U6X/nlAXpp1ZNcUHMczYHMbQw0KXKAEArou8h+BNZnKSk6r
	yXFDCpXCuUhlNrRSz8pMwunMSD/eLFQjEnfJqI9jd/j3UX7iT/G0fUfk000hfRY1ZYF8HVZu0gN
	6TpuyikD1w4hClTtFUtJL9BQvROFvdD94t1IedKefg4YD1YZTPSSU+WRxAJH0cs/VMrxyTKQwVO
	g0myF+h05hep9z/wnPjsjR4EMp3vSkpkApM6ITDqh1EqzKXJAY5ZKPFyIwFkknldyqCmT8S8CGZ
	HaxkCqGXjMT+0UnCkiSa4acV8zjY1/xEu5okNtrOU/hSNeCfjk1+7Rc9IBnDZjI8YPmPqT65ejN
	TeBKrxwRJP9i7Y2ZE79Yuri2RJcnadb1tWgZw4YONkwuksoZfmnLPrXogNxL3YsQWkDFEO/jsp6
	00r7tw==
X-Received: by 2002:a17:907:3e86:b0:c36:777f:824c with SMTP id a640c23a62f3a-c51315851d7mr1405271066b.4.1795528839874;
        Tue, 24 Nov 2026 06:00:39 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370cc257sm6492195a12.13.2026.11.24.06.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:00:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVr4W-00000000QnE-3MAi;
	Tue, 24 Nov 2026 10:00:36 -0400
Date: Tue, 24 Nov 2026 10:00:36 -0400
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
Message-ID: <20261124140036.GM9566@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
 <20261123165716.GM179082@ziepe.ca>
 <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ac7edd0-5c38-440a-b26a-21bcbb6f4702@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_060042_265887_6C2A23B4 
X-CRM114-Status: GOOD (  24.57  )
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

On Mon, Nov 23, 2026 at 07:37:41PM +0100, Christian König wrote:
> > Part of the design of this series was to allow the conversion away
> > from SGT to be done incrementally without breaking compatibility.
> 
> Do you know the joke from the hitchhikers guide to the galaxy where
> the dolphins are happy for exactly the same reasons?
> 
> I'm pushing against this plan for exactly the same reason because I
> think it will make the conversation away from SGT even more
> problematic than it already is.

I think it is well proven that trying to do big bang conversions in
software doesn't work well. :(
 
> > So it is effectively this:
> > 
> >> The framework should then either connect the SGT directly if both
> >> importer and export are using the "classic" interface 
> 
> Yeah but that should not be a separate mapping type, it's rather
> that we just convert back and forth from DMA addresses to SGT for
> compatibility reasons.

The mapping type is to support ualink/etc that don't do "DMA".

Only DMA API can create dma_addr_t's, you can't reuse those types for
something else.

And you still need a scheme to negotiate exactly what kind of
connection you need. Focusing on the SGT is missing the big picture of
why this was organized like this.

> > As this is actually quite complicated and needs discussion exactly
> > what it will look like.
> 
> Actually that is the easy step I think because quite a lot of
> drivers already convert the SGT to a DMA addr array outside of the
> DMA-buf framework anyway.

Given the importer an array is not so bad. Getting the sgt out of the
importer will be a debate.

Jason

