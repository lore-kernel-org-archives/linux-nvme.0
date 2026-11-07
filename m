Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA10606EE8D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bdmYuQ4q;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbdE/Okj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=; b=bdmYuQ4q6mQeSH0RnLHAOqHCie
	NQiJu4YClJ6rcG3H3nw9A4Nbw7ZLkO52fgy5QdBcuhyV8EYyX4otfith0tq7M4FY3R3mvLv+X2KSt
	332k4VPxF78uNnNt7zUCv99BOvs8XclDZaZWHX8CehtyoUus2/OQu+LMX+S/JtWNv1o31Ha76DeXB
	1OX6h2F9M8SRMvlQof6QbE9GEVBQ7YsqGlgcbmxmZlo/5M8mCZU9MKmrxSmcq7uKNOl32O2j5rRrT
	V5nkxD077N569HXonU8IiO45vOzg2BHeHHehW1j4c4jkwIp8G2RG7FeibG+UHimG5Vrvb1rpGdUJU
	Pmt+3rww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQSnD-00000001I9J-1RN2;
	Mon, 09 Nov 2026 17:04:27 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPcFJ-0000000EOqa-43B2
	for linux-nvme@lists.infradead.org;
	Sat, 07 Nov 2026 08:57:59 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso13601135e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 07 Nov 2026 00:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794041875; x=1794646675; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=;
        b=TbdE/OkjpB0fSWDBFIRe0HHtsSC1jAYeXdJ2ME5PNrof55zylVpSLIoYF2/fyaHQ6M
         xxlD8Vguev9c+UD4eoMW7BV6CwEmZX73U+TRYxDRro8IymKlvESepOO4cRvj3cAeUJWx
         RFNe2fyki/V10BpUhFNlN234FZLwUbN3IacTRXiRPPZhaU2zd4FNaLXlsXUPZQ3bxfIt
         bronqxoKL0qdWHTNDaoIunJa8XM7NhmOCQXeSxPGXwpaoNP0Q6+LVcR7mMw5bgCmEaLW
         KloUMXn4aWhHQS+f+RPCsgEzRYSOAXgTgbjPplEX4LMg6o6NptqwLYKCfvjNBqJWXHqz
         Yu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794041875; x=1794646675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kw2zLGhVUDQnO5rFq8cwt1gUENr7fOzbT4vb4xG8V9g=;
        b=sN61HlkkUyLN+uozIjgcaN205NE2z8ZsKz3IacKW0NfT8PWyHlbrUZXcA6G77oM8Cv
         lryR0B55VvZZiSVjtZWxx9EgrDkc+K2+K1C6RWJDO6a2g19+Wx3CmZp4QS7/kLUfKScu
         KRnFGzq+bp6y9j+d2WGUJh/KJWOpy8w/qGMMqvxmfeyzFTbhjukdYxRTCYM8A7BK3fN9
         hsWMLe710QAgPMkC7AjS2c9S/htKTaoTS9qbthErPlTvN1aoDhAVyB7BRMSaU7YWF+vQ
         uJkTp9GAN2Fnk4+DxMW2fcdcIgGOz89M2sYwmgawEf8hi9r993p1xIEX2y0Te9Qa4kL3
         qTTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzixzLCB19zpx/fso415iiqX0lahSRqJpQ30JDPbNTeT9kwKrnAEop3EKghIAZmegqD+zwJeSlP7FU8@lists.infradead.org
X-Gm-Message-State: APuU4Z818F/eSc0nN6ZzmRnn+qBuOqMrk9zg+LMvc02/SRW5tvqY0XaN
	HRfvCG9vvc4F6/G0mJ6B1PAfRBzZR4eN9a2JBGfiw5CUCk+jNncv7+SZ
X-Gm-Gg: AYBFou1kops7lgsl9zdGsUvcahxp7ld9T7cbzu/hc+NfJNAIxUoX0VhgASJKhu2EUrl
	ojDKsdDbzpVWzZCG/sX8Es0xHf6SSn5ir0dHqne8f7dUKB4XyflkOC0cNgsZkQdTO6vh8oalnJ2
	+Z5jzIAFpUglRqDkfWV1NUQ2jLNyFHdwBc1ietODZ6h1II0oBK9zpFqPDwRNn/zWq+WJk+X7CgF
	M8oP6kRwyvuzWw8x6AyLBRsixxR7cHfwVvpl70XhXP7xy8LNUZWL9TgbCP8vvOx6YpfGmxvSEei
	/WhiuLzfnIQ/lionOvjdTrrqcNUcM4kXwqtwedHkCjDmxIutRkIHp5NSb+SRqbfQE0cmXtsRXsU
	XQPSGmmygVSxiP8mTedOi8Wkr1YjNQlA1gDa0WFigq/eLPz4jdAMoNXKCfIB9HU/4NVmWtUgfwx
	tYDhbU2BSr8xEQiFbsifZuSVaYln1FzkEj1eBlhTNAjal5+YXv/dJXad4ViK5HtQ07BkvSr7DXT
	5LA+B4+S0JtQDj/ECxyb6s5IHKZMMHCNlPCdOLk/OcWTpV86PUsnZiY4gn1JNi8jZ+rTgmAxy8B
	WFiEYYRGg40gAPFfMz/UTodihR3TNzfADyIKHLkgtpNjCuh7s3MTPsj1Lk7Mq9BOKFfGBBk0nU1
	4hmO48B65tkUNybcVmxGQOtzwYtaPeBTigIv7YV7h//GCJuoQA+s8YIAw6yna777Z
X-Received: by 2002:a05:600c:a015:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4b6df028f04mr88902585e9.14.1794041875269;
        Sat, 07 Nov 2026 00:57:55 -0800 (PST)
Received: from unknown748F3CBA5068 (dynamic-095-114-115-226.95.114.pool.telefonica.de. [95.114.115.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7701af6sm8597238f8f.38.2026.11.07.00.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:57:54 -0800 (PST)
Date: Sat, 7 Nov 2026 09:57:22 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Matthew Brost <matthew.brost@intel.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org, 
	iommu@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>, 
	zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 06/23] dma-buf: Let the exporter select mapping type
 at pin/map
Message-ID: <au7mBMbRC8q6NILj@gmail.com>
References: <20261105-dma_mapping_type_v4-v2-0-78b8dc9ae80a@nvidia.com>
 <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-dma_mapping_type_v4-v2-6-78b8dc9ae80a@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261107_005758_047170_6A0BBEAC 
X-CRM114-Status: GOOD (  17.08  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Mon, 09 Nov 2026 09:04:24 -0800
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 05:40:41PM +0100, Alistair Popple wrote:
> + * A pin or map that fails after dma_buf_mapping_select() may reopen the
> + * choice only if it was the one that made it. A selection that predates the
> + * call belongs to a live pin or mapping and must survive, otherwise the next
> + * pin or map would reselect under it without an invalidate.
> + */
> +void dma_buf_mapping_unselect(struct dma_buf_attachment *attach,
> +			      bool was_selected)
> +{
> +	dma_resv_assert_held(attach->dmabuf->resv);
> +
> +	if (was_selected)
> +		return;
> +
> +	attach->selected = false;
> +	attach->selected_idx = 0;
> +}
> +

After dma_buf_invalidate_mappings(), attach->selected is false while
attach->selected_idx still holds that mapping's entry for a pending
unmap. 

If a pin/map fails before that unmap runs, was_selected is false and
dma_buf_mapping_unselect() resets attach->selected_idx to 0.

A subsequent dma_buf_unmap_sgt() then uses matches[0].

>  int dma_buf_pin(struct dma_buf_attachment *attach)
>  {
>  	struct dma_buf *dmabuf = attach->dmabuf;
> +	bool selected = attach->selected;
>  	int ret = 0;
>  
>  	WARN_ON(!attach->importer_ops);
>  
>  	dma_resv_assert_held(dmabuf->resv);
>  
> -	if (dmabuf->ops->pin)
> +	ret = dma_buf_mapping_select(attach);
> +	if (ret)
> +		return ret;
> +
> +	if (dmabuf->ops->pin) {
>  		ret = dmabuf->ops->pin(attach);
> +		if (ret)
> +			dma_buf_mapping_unselect(attach, selected);
> +	}

dma_buf_mapping_select() sets attach->selected = true before ops->pin()
and the map callbacks run.

In patches 14/15, xe/amdgpu migrate a VRAM buffer to system memory
during pin and map when the attachment does not accept P2P.

That migration calls dma_buf_invalidate_mappings() and clears
attach->selected on every attachment, also the one being pinned/mapped. 

When the callback succeeds, the attachment stays pinned or mapped with
attach->selected == false.

A later map/pin on the same attachment can then reselect without an
invalidation.

Thanks,
Karl

