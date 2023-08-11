Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6238AC04A94
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=prWD167naOCUGhV8W2UI57hYvdDYVXZgEtS8e+7g7BM=; b=tTLO0AGlpgTq5vtb50KdsDSq44
	sjNEsnSKNAIDkCSEBGDpm/324pgdPN+dwbO1tOfaU1yJb/ss+xApSEvyP6NAQQ/eyLQel9TOHqZA6
	MLoEb5C3y4ufTzrUb/ApyiWaFaHAKIqFfhQ+HcIJhZsHK1DKXGyX5QuQGrNIRkqIDW9t6xx/oEuGT
	/IhZW7IJIyyOCCaL1FW1GkqvgYHsi1bf9w6bvCpWJaRCNvGeY3LD6+bOdjNlzcBbfMOyna28TiYE+
	4hnJhWvWQPwV1AntvBPVj/VEsnMfvHJDhapk3AzcAhqhxVzuJ6Y7Li8vwwl+c3Hd9Yvd6qjZ5KuPI
	EpLcqB9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUa7L-00BjaM-1t;
	Fri, 11 Aug 2023 21:56:23 +0000
Received: from mail-oi1-f172.google.com ([209.85.167.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUa7I-00BjZc-33
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 21:56:22 +0000
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a78604f47fso2245284b6e.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 14:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691790979; x=1692395779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prWD167naOCUGhV8W2UI57hYvdDYVXZgEtS8e+7g7BM=;
        b=TevXMCckc/VLcZ4QkXd1nVlNBCPGW7uD1IRMVhhsbziidGCCKoMLh1wax8A4P++011
         xxFa1uJ6GSQMxvecbTxFxfqyCdqFGEa4TqavZfDlD9Qbtp75fE5PAS/uD3leVA8k7BtQ
         UqEs6uCRsG2hBeupFtSyEAZY2JZyXKRtJBLcFyQAVfKx9kGnq/I2r9FXBarjlOjm8cnI
         QTYG9xDMElxA1VDGiR4iMtHcpSbV1cnjAn41zx9nN5Vub2rbWkFtExBxO4F3PYeQfDBr
         qbA8r4cwh6/fnVjHvBE8q63zU+AN9fkp+Nz2wmeF3an12G0RsddDJSWqtHO5VKD+jJRd
         Vu3w==
X-Gm-Message-State: AOJu0Yzn5vuSaw7Vz1SD4roC+fqxSi4GPZfuxh5uWzOaaT4mn+CDm2jA
	HgTehUuOs3C5KTCeBmzK4Q60pADsGlM=
X-Google-Smtp-Source: AGHT+IFRmGiyvXV1VwlJ9tihqgTvBvrZ8iEiMT6ZbT0wpIrAxLL1zr/ocUv96iLtdTj5E+o7MmHKDw==
X-Received: by 2002:a05:6358:290f:b0:132:d07d:8f3b with SMTP id y15-20020a056358290f00b00132d07d8f3bmr3326632rwb.28.1691790978966;
        Fri, 11 Aug 2023 14:56:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id c6-20020a17090a674600b0026b25c05495sm1808427pjm.20.2023.08.11.14.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:56:18 -0700 (PDT)
Message-ID: <170b68ca-b24c-0723-cc54-7fcdc9004bcc@acm.org>
Date: Fri, 11 Aug 2023 14:56:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 01/11] block: Introduce queue limits and
 sysfs for copy-offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
 linux-doc@vger.kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105638epcas5p4db95584b6a432ea4b8b93e060a95e5f1@epcas5p4.samsung.com>
 <20230811105300.15889-2-nj.shetty@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_145620_986222_525350CA 
X-CRM114-Status: GOOD (  10.84  )
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
> +/* maximum copy offload length, this is set to 128MB based on current testing */
> +#define COPY_MAX_BYTES		(1 << 27)

Since the COPY_MAX_BYTES constant is only used in source file
block/blk-settings.c it should be moved into that file. If you really
want to keep it in include/linux/blkdev.h, a BLK_ prefix should
be added.

Thanks,

Bart.

