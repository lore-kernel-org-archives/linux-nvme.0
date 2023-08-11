Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D78C0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hL47jFFvDt7OXD+hxa5Uxt7WguECwOQyvoULO24VUWQ=; b=1EkJLl0o7aDXfaltEutOKek+lP
	xpKpTq/z6hEUV9X+WPEqfA9rE+8AKgMOZag8nPxZGRveBp8Z75XN9twQX1ICehEURD8vMJjd1R/tH
	Gvbi9JtwX/I1m0rLcvOmqsdck6W7dMjfyzppDy5aG3cCEpliftZJb0WY3+LEFaaxx0cdRw/0bHE9x
	Od5AlGagk52j6+PptJqvvMDZfqYrLHHrjkPtoNmKNJhSOKr21wYwbJe0uGt2gLg8K9Ojm43u8TT/L
	sjBWvTZ9zFLiZEgtIJa5UGhXsdehtZApSWTfwUsYmG93cFM9YkT/DiS3XslnM2Mf09MHjnSwgR+Qs
	ty6AQU4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUZlP-00BhHr-0c;
	Fri, 11 Aug 2023 21:33:43 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUZlM-00BhGa-1p
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 21:33:41 +0000
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1bc73a2b0easo18533135ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 14:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789618; x=1692394418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hL47jFFvDt7OXD+hxa5Uxt7WguECwOQyvoULO24VUWQ=;
        b=lLBNWWD2NnaRJukKdwSkxW78/eZDgXeJvHP04JNq2X2f5U0rTScuALDHIeisGnXy9p
         9ICYfyFN+q56n8PbaZGjzrWEmowC+Ik9pkuJP1oMf5h0QVFsYBr0UtCdGAR15iuBxrz0
         hR4WWe7pBV3QTBz1blMZPjt+c7qDW83fjo8MIEBEUJUXOQIsIfbASkt1+QApID5VfHSX
         9Cv0U/EfZBynU47nsLw1LmS7jHtG/1ulO357gem871p94V2GaGXPvrY5wArHnXp1smda
         7XJdNCXeFv8rY1PdcKb8NWj5cbjbCfJwS3HNfIv6saO1+8gvk6KnpbILAdNBPqHAeN9E
         4c0g==
X-Gm-Message-State: AOJu0YyMvUvi9jGX8nZElkDAG87Xi/7PrAgLgEPEz7qGWfQPb5m8woZI
	ccz0PCCu4c93XN/pRQU/Unw=
X-Google-Smtp-Source: AGHT+IGAmnk9VKQD1Jo/hqmiveT5ZuVgUoMRBZbu5CA4433fTlsSPS9CN76yfuE6JEcmMaoZvr7xdA==
X-Received: by 2002:a17:902:e809:b0:1bb:de7f:a4d4 with SMTP id u9-20020a170902e80900b001bbde7fa4d4mr3429993plg.61.1691789618406;
        Fri, 11 Aug 2023 14:33:38 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b001bc87e6e26bsm4378373plm.222.2023.08.11.14.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:33:37 -0700 (PDT)
Message-ID: <0899ddc3-d9c1-3d9a-3649-2b1add9b2a7f@acm.org>
Date: Fri, 11 Aug 2023 14:33:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 03/11] block: add copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-doc@vger.kernel.org,
 gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105659epcas5p1982eeaeb580c4cb9b23a29270945be08@epcas5p1.samsung.com>
 <20230811105300.15889-4-nj.shetty@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_143340_628891_D02637FB 
X-CRM114-Status: GOOD (  12.21  )
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

On 8/11/23 03:52, Nitesh Shetty wrote:
> + * Description:
> + *	Copy source offset to destination offset within block device, using
> + *	device's native copy offload feature.

Offloading the copy operation is not guaranteed so I think that needs to 
be reflected in the above comment.

> + *	We perform copy operation by sending 2 bio's.
> + *	1. We take a plug and send a REQ_OP_COPY_SRC bio along with source
> + *	sector and length. Once this bio reaches request layer, we form a
> + *	request and wait for dst bio to arrive.

What will happen if the queue depth of the request queue at the bottom 
is one?

> +		blk_start_plug(&plug);
> +		dst_bio = blk_next_bio(src_bio, bdev, 0, REQ_OP_COPY_DST, gfp);

blk_next_bio() can return NULL so its return value should be checked.

> +		dst_bio->bi_iter.bi_size = chunk;
> +		dst_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
> +		dst_bio->bi_end_io = blkdev_copy_offload_dst_endio;
> +		dst_bio->bi_private = offload_io;

Thanks,

Bart.


