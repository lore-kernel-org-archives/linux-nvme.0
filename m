Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF4BC561E6
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 17:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=; b=ngxNvAyPntWfGxSUgNSYcu4SPd
	z0m7wOdkcfw8RhNUCPsHk/NRJHkPOIFVGfAbKz5uvpocCwaLa7zCCEhkq0kbfe6i/KRZdUaWHsRtE
	v6NjsPmG7R03ZYbNUW6OfaYOrzDSB7eVS1wNerjzZBQklG+htsmiBmagkxFGKUVr8oOr2qZy6jc/U
	RlxTC/gUpQcpUqE35pbkulr91yRSWwu2lHU/h9coj7LDAHoOSLwIxPArCmRCxLHEer1gxXHlIHUU8
	U6UK+tSalw4xMdjoNeLTMnzw1MyStHIzQAb+asEhbHa840LG7wJi881i/gwk6DXeGj2yEKlaLddnX
	pSy/Eh+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrIkW-00000002Ssg-1JBN;
	Tue, 04 Aug 2026 17:16:20 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrAit-00000001Ml8-0dgn
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 08:42:08 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-8486ac3f347so753602b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Aug 2026 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832926; x=1786437726; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=;
        b=hrJEJpTc00CGQ70Olgg9qFN6Ljrm9xKb1ptbxJGAGimP/yrGa5itJn5XTtjE3g6YEi
         OE+QYN42MmrLMyuAEWFwg3ONgsjSFMoBATYCCRaPPK+VCvMqAgc/+8rUpgPET0adxBh8
         hLkhDbuGm1L7DhxYpX6pK0SKkAdxhC17T2T1Wb2DUDtwE1pNf8yaKw1YYSSOLvS8F0Zm
         GUMxatBg4BqDXGAdrmhOXx7/SqhL3XAJzMJKWxdwzRwJSlJASteilkavJSeLU+0sVEKj
         cDGgYiMW69ghy31y6XmHEdP0wX96WHVsmOf9AjeB8CqU8W9C6ZEiq/qgxcuqoRMIxUZs
         ABzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832926; x=1786437726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=;
        b=aJ64QfRCBmzNZ/97IE0CMpikWHNZdhCHoQXUsZ+WQjQSLUMH2gI5P809F1d73DO4Df
         N/oQTIC/eOVT+emS0CnBpA2tCdJe03SCFtQbJEZaxozf/7YogMpECbSPrvKKy1jQmQeI
         e9q73zH+Difzl3v1pWdlWfn9nomxblfQ5XwEK/G8YnUI5EnduW+ttWGUAxjxzoyc8vsA
         +WT6LzK3aa6qh5l42jNxS1nHxsSmm6g6KG9i2xMmZSV5psGa8NQLXDg2UHRoSzX+RfBs
         rG1a22aMVmMmN9dfvQaSFULN86CKnnVTDnZX0DIkJjuHWlOkZljnH3hfDcxkSMNRBTVc
         344w==
X-Forwarded-Encrypted: i=1; AHgh+RotvBqLf1ZSRmm6IRc8zRWR5XiX2uJvmnr4zMyoQStLurwoQoKJl7PC79LmfPtcENueqQUPITrmPoc/@lists.infradead.org
X-Gm-Message-State: AOJu0YzhbQV8bPvG8D9SxUMVtvpe3RffiXTSksL8njaLftYB15azOgAK
	Rq/NY/w8os2n77ElpDAtlNQMRa1RrRPjiLmEr/M5pPCZqzUgdbxtzjir
X-Gm-Gg: AR+sD12tE3nlKEyZMebRyJ70eEEUXlt/4lIMNHQg+vxDyiAhn1vjsXhKMDLqXeDC/lS
	6SLflc7G5TQBn0Ct8wkxLp/0U/pb2tpR93D4IK/ytMGVyojNy061keaAQhXVZIXnR6/vRoBdYYd
	u4e/csDk56UYiY5HleslYkwfWN1llUX5T9xwe2oa9PmIv1X0csBCZ+8cMh7aNCNyi/ttiMbiTzx
	w2QnIwQzjPWlXWzJ7v/Ue5fUShTAtBAfu9Cdo3dKf0pEqpSXXAcErz6pxoNIFxVETLXB9mBY9gc
	X543FQceU+0HBT6YtyCSkU4Q2EOtzoXTBblZ53bxLWhpw2CuOjfGIG5gfVsTFybGdNGnUZFt3Qu
	vdqyfGxMw7Vrt18GxtVj8CcCCWlPCeClcfjCJ9tZWyibAFk8HG1p6HvwH8dRDgycZvujHOSyXDT
	Lb0b0HBTFw220Bxruc1zM1om5N4SVfuhtM+B7Lsgkrn0aDomjz98qfXXUtnF3PllZ9jYiyjVmYs
	eKehX/NAa/aOhUUbd3FT4oFPZkmP//zyCxbZC6XJMTx2aWhvmbC5PS+4U5cHB3yc9j/EbcfShXr
	KHa5x68tEELdSrXdF72f
X-Received: by 2002:a05:6a20:9188:b0:3bf:6c27:38b with SMTP id adf61e73a8af0-3cb6c937c3amr2601207637.29.1785832926102;
        Tue, 04 Aug 2026 01:42:06 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:541b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea0a73sm4753273a12.23.2026.08.04.01.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 01:42:05 -0700 (PDT)
Message-ID: <53c9cf90-4284-4b6a-ab2f-1686c7461bf8@gmail.com>
Date: Tue, 4 Aug 2026 09:41:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] nvme-pci: implement dma-buf backed requests
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785596451.git.asml.silence@gmail.com>
 <CGME20260801155005epcas5p4ecdcdf532aa2c2ff4e94638eedaa435b@epcas5p4.samsung.com>
 <9e3dd1b2d71dc0f9bd556b6a6d6e48fb6a8d727b.1785596451.git.asml.silence@gmail.com>
 <c4cec417-24b8-428a-853f-4e1ff1e29a6a@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <c4cec417-24b8-428a-853f-4e1ff1e29a6a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_014207_201670_3BA59919 
X-CRM114-Status: GOOD (  11.52  )
X-Mailman-Approved-At: Tue, 04 Aug 2026 10:16:17 -0700
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

On 8/4/26 08:29, Anuj Gupta/Anuj Gupta wrote:
> On 8/1/2026 9:16 PM, Pavel Begunkov wrote:
...>> +	if (WARN_ON_ONCE(seg_shift < NVME_CTRL_PAGE_SHIFT))
>> +		return ERR_PTR(-EFAULT);
> 
> This should be 'goto err;' instead of a direct return. If this ever
> triggers, it leaks the map and already established sgt mapping.

I can change it as I'm going to respin the series anyway,
but it doesn't really matter here as it's a warning and
shouldn't happen.

-- 
Pavel Begunkov


