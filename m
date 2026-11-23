Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424EA606A321
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w2vadRlM;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RbkBtLds
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=; b=w2vadRlMFG1xFSRagST3Xl9mSO
	bXNXNUqH7NHaOaYDo06rl5peY2cOvZaQti7FQsRJzbV2V7YUlFAxxhezZ0/1VhGJ3OdhBZGCfcVES
	2bphNxYBy6ogg9uOQjBc/t4zR7My2WoOqhicxqgwmFq8DE+pxUZ+NiDAJOkZ+cYXedDjLFkzUNB0z
	aw90B2gGqBnlBLDns+PqcMpms1jO39z14t1qjjhukL8s19Fb4S4v1yA7T737VgTM1o4ZfbP3pvA46
	kKgTR80i1EDXEpWZt6jQGxAsczAtE+EemLgWgQEwNwkSPMpf23B/EtLAyVtAouE/xBGnvCK/VQzyq
	HHhpnINA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xViKE-00000005Y9s-3rS1;
	Tue, 24 Nov 2026 04:40:14 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXLy-00000004GsR-3vVa
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 16:57:20 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-9213f004a14so42977586d6.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 08:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795453038; x=1796057838; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
        b=RbkBtLdsx9bfOPVW2okarUJjwm3SckBqCeApjMqqwDXznY5O8FO4hPO9KPjbTHafrY
         01OLFWEJGdLTB2vT1WUdUo7XTg8ZWRkO9fBOqw7gyAIvIuEmPVcxe9IrjzVHKQznA7W2
         uq5Uiq9Ymtd0BV2gW8K7BbSMus788zJ/nN8wKS6MvJxkJqa4Q/z0vFw9CW6fJTV2EqEj
         5nolqoHZhjP1uZcQZcM9jSahzYmWrpLJ7xe4FaHYW1wANz5tdK2RsoZJjKfJHJJzJRjr
         xcdHqPaRVqFd61z+mTd722eAA1GHwrEOmDPYoXWrRlvsxNzECu+/+DQDp4OisoCcA0lG
         ByWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795453038; x=1796057838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j5i4WU3qjrhh//MRl3wcVLLT33h5NdpwdC0V5dWlBjs=;
        b=MVEEB2tdcDcXQpteU3zPwlfbA+a9LL1CuYnHPQ8FwYHCT2jk1Ove1G6YxP0dzhxfbN
         s3AkpqoggjkoKHzN5NFJ463AWMlzptULHRQ5NaNiRmeTyqycdsNHgzNkbFKwhvbubwJ3
         nFVowjeIYPEY1lYrVoohEEVbTxKlK/VqJ7dKopiRTGAvh+Pqx3iwKX54eP5rJp5DKpX0
         8Gbuf6YZ1haPhxTSJk9xp4appohiLeKwThBvDc992JKS/tF52D+oDLHv0fWC4JUO0zup
         ik64Fp0FSq7eNs1GVE72s+SCKMmIcRxOZlfZTZ3mNMCkljcMOxkycMVygH7ks1T45RFJ
         PCjw==
X-Forwarded-Encrypted: i=1; AL+hErHmEKs/Vnfk3r2cPfp6gvlS5HjwyxIc+Fd6ZrToImirzFgjnvQVyFxNbtbeVCdgk4kD+DoWTMYvfzls@lists.infradead.org
X-Gm-Message-State: APuU4Z8POSjy315Gq74AIhq80m5T9SaII/OA74NzYKfVqMwULr3D0iKb
	WtA3GO4RrQOVP2TwRQy3LXwMN7t+yXpD7RvA3YXdZt6yb9FWfVP1tmVyOBebkOXPhdY=
X-Gm-Gg: AZFdTZd+TiVlFRxVN94MIToRSMmAfz7YMkEGT8Ak5Ei/P3eC+Q36hqbe8miHqp+ZcQt
	Mn0dxAv9+Gduaig27QhcngJvQgcNdrqOkeDBsNjAgU6ELRdcLH21CGEJ/r/KChzX/1Bp80NNNL7
	Rf0C96jDRL5tff4uis/yf98KZCt3yRsvEV90j7JTeGdrE3JIyp3hGzopzJ8QQUCsotMN+SXC5JI
	O+SZR9LkMe6t2iyOmj5QlPeNQ2iHdoSDl96ndvV58QhLmCwcGEJchH3SpvB22fWN9oEaf0sEsrN
	IS514NgXsJckZ+IZLq1GbuQ41XDmpVXkl3anAfliD/96x98mnel62taKxxvqsISjmNxovGlCFKl
	eqvdWYP9ltNC+SkTy9GQSj6RSpti6agcvMsf9ml06cq0Ut/Dsazyeggblk0l0sTN2JT40p9w/jV
	DuqCCzsFHQLT6ugvdrXrjsVCoM9LbAwKKiMErodinwGhJQAGceclofdWO9NdBmcDGQ/dzxxXL56
	RnJplF8PcaiiWktOpHq88i2cHfSgXTPA+XHtm2sveh4nKtB7Ou9SYjUJpYjwt/7AC735ESc9DxP
	otsTsNa8elDVbBoN3vq/Iu3pKQC2GUMsxSfOegoRUNkbaGIoIEg6W8BY5eSi4ZB/equ+0QGKVCu
	x5GSzdFDC48KPr3Zmh5BAluTr
X-Received: by 2002:a05:620a:270d:b0:949:8109:8bcd with SMTP id af79cd13be357-949bab6d24dmr1950593985a.77.1795453037117;
        Mon, 23 Nov 2026 08:57:17 -0800 (PST)
Received: from ziepe.ca (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.142.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb031601sm844162485a.6.2026.11.23.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:57:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVXLw-00000000woc-0Jy7;
	Mon, 23 Nov 2026 12:57:16 -0400
Date: Mon, 23 Nov 2026 12:57:16 -0400
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
Message-ID: <20261123165716.GM179082@ziepe.ca>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
 <20261120-dma_mapping_type_v4-v3-3-c0183a409bdf@nvidia.com>
 <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad46d60a-189d-4dd5-9ad8-ecfd3c90f9d9@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_085718_982937_CFE94198 
X-CRM114-Status: GOOD (  22.38  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Mon, 23 Nov 2026 20:40:10 -0800
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

On Mon, Nov 23, 2026 at 02:36:46PM +0100, Christian König wrote:
> On 11/20/26 06:55, Alistair Popple wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > The SGT (Scatter Gather Table) DMA mapping type represents the existing
> > sg_table/scatterlist based DMA mapping. For now it continues to use a
> > sg_table for map/unmap, but this will allow a future patch series to
> > convert to using a different data structure for importers without having
> > to convert all at once.
> 
> I strongly think we shouldn't have an SGT mapping type in the new DMA-buf mapping API.
> 
> Instead we should have something like either an array or an xarray
> of DMA addresses.

My plan was always to get there, but I don't think it is reasonable to
start there? There are too many places all over the place that are
just hardwired to do SGT right now.

Part of the design of this series was to allow the conversion away
from SGT to be done incrementally without breaking compatibility.

So it is effectively this:

> The framework should then either connect the SGT directly if both
> importer and export are using the "classic" interface 

And this:

> or convert
> from DMA-addr array to SGT and back if either of them are using this
> new interface.

Is something I imagined as a followup series.

As this is actually quite complicated and needs discussion exactly
what it will look like.

Jason

