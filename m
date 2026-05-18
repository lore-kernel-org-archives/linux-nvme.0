Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C89FCD4F49
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=; b=G3i/c6Gqoshfg1sUSMsw/BXlP/
	nch3MGRoRNW07CI4IPilCs4PMXZpmaJkx4EMChx1Ow/GFA+rqpdzkfA13+DH+U3e7Gawi8XdtqL2G
	KAFR8eXJg6PhBjFByXs4NXWq3P/hDVAJFiBr9inOH4zrDLydV5zT5QGUfh3zDt6jOKBCYPO0dgHqq
	fWlMBP+N6VAXwoJ1wO91JxCog1ajfHhpy8Q4W/mTAaGTFO7oAI6VUaQo2a3tvbT6kF2Tryu2P2ajG
	XLMKHTtCtnGcgKaT72cPYNcuBzj2p+/NCLURimJt5Qk2gm247JWxqmXJog1D5rUgdMummmX8rFUta
	T3MF/OKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOyt0-0000000Fy02-0VOz;
	Mon, 18 May 2026 14:24:02 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOysx-0000000FxzT-1Ozy
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 14:24:00 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-bd3d7c29b4dso345026466b.2
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779114237; x=1779719037; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=;
        b=l+LmftYKb7X1Pu+XoA+qmL5hwp6XpJHWbXftuTRQUlJqWlW2s6mtbp0sEQEDupNKjL
         2He2sV0y52uEMr2uUZdWIUplN5dMnc5wyuTdNQcjyBkz7gn+JS76q1BatCStt/VJUhnD
         JxoVl52Imk/Yauc2j91Neqisq4Dv5CMRwfvcBwi3RYDGxaTTUKlp2qZWZfBjY7tbKnmS
         Jt1zNHzyeTmSGJVAveGDbvErPQWpCjttCvi2SVctTE53FQqU+KqrY2W66LQ1k6xDMNs/
         IeYLLqNvPPLcHN2rM1Tx/jlCwh34w0b8wY6vAknE9RO6GtI1aY6SEoLwt8nkaQau1jS3
         1B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114237; x=1779719037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m58bYDJ543WmyZ11IWytLuY71YuFJ2Bw6ePCWpryz/I=;
        b=VsVfUYshTQMDAAWd5XxI5ntTkVV+YiB/hwH+VdoVPlEePX/5T8amc+coskwXBzk/K+
         SJ9F1t+r4VOJ7r+8Aiw0zgPvdOQGoNbpO8/lcMUHdKRw7W333vqmJcVElR5VTd7eYCWe
         bkHSkarHoYBUSis1NYCZ1CTnipN6m4CoHZ6qqYxjHbIfxZXjPhthIS1oi7S3XSnqEmm2
         R5YT46RSTa+PNriHWLsVexvQYJyPXSJ4VQUgA7h52OamK23iJXjK6zPoVRHZY8JCxYd1
         0acElFHb3Q3NKW/e0A6nrr0brFtqlrlEOU5xWzkLug+pBfrcnrHIu1PXqpxnrrknLAnX
         oA+w==
X-Forwarded-Encrypted: i=1; AFNElJ+zZphPu6j9ol/ybl7lbHAGWjO7bo/op7KNOHCpr7sQ56YVLVyGpIR+99pnvQyKr6A6Y4Nn4f6GE3ek@lists.infradead.org
X-Gm-Message-State: AOJu0YwCurPTXILkITWshy7qcyGtYcIyV0r+uhMNBwFpZK4SUuiZpVQz
	T80VwQIP8eLdiClPabO3hyIuLBFe3CRsDCsqpZel+R3URRS14kGKeQ9h
X-Gm-Gg: Acq92OFH2lL3Y7JBLuV+Adrp/W4DpCzoWtk9S4i21AxGegRWM0IBrhEexTRiYzZdy5G
	QjaJ+DD+t0bqw+mNldatwjQJdFFYhADBMTb1vl7xckWunRuSARglgc6xOyZKENhFwjlJx7K6MGe
	lyJTx6/mACNc3OLn87gx6Mo8tzvDk9rd9Ehj6SxShRY11U/3RkaQEdxMP94b1pg/Th0oBkFdAuF
	1YBD4T+RZK3jHT63D35e8CLFnL+q5UjSJOS/f9BjUnM3aU3qf97ikBbaFzK2JIRfVSAcgMPDQEP
	POmspI3IEMx6Ql3Iuo3jpFzIDoYXGiz4K6+IQXfPQ7ISPlriV7f0J0dIDO5D8FkkLZWdQ24CKst
	ouln+vI+6UuVPWtNRxJ+w+UBvb0nO149P31vEJQkCf/1fIPpzyxUDVu8aMgwNsT97Szj+IkSLzD
	5EDMpsY0+q59NXy3ZUg7RAJoR83Pv/5W2M1e6gnAEjBFec/qxWmjfyacTQk4aNrUXo5gvfD4QRk
	sxWix2fKltr5OJ+bmSeKwoJadj3TfCw0JdqO4uXtoiD5UEuHvxaGq/FrI5i/57ev9/7BoDk4pC6
	3Q==
X-Received: by 2002:a17:907:c291:b0:bd5:7a3:a58b with SMTP id a640c23a62f3a-bd517994249mr821357066b.46.1779114237152;
        Mon, 18 May 2026 07:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68310d58c79sm5325464a12.12.2026.05.18.07.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:23:56 -0700 (PDT)
Message-ID: <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
Date: Mon, 18 May 2026 15:23:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
 <20260513082431.GA6461@lst.de>
 <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
 <20260518125326.GA5754@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260518125326.GA5754@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_072359_405319_31870BC1 
X-CRM114-Status: GOOD (  22.70  )
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

On 5/18/26 13:53, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 11:14:09AM +0100, Pavel Begunkov wrote:
>>> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
>>> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
>>> But I'd like to hear from the dma-buf maintainers about that.
>>
>> Looking at what Ming is saying, it'd make more sense to keep some of the
>> parts like iterator and the file op more flexible and not automatically
>> imply dma-buf even if it's the main and for now the only medium. I.e.
>> ublk/fuse can use a similar interface for mapping buffers to the server
>> even without dma mappings.
>>
>> I don't know how the API should look like, maybe passing memfd, and dma-buf
>> supports mmap, but I think it's better to call the op something like
>> "register_buffer" instead and keep all it in lib/ for the same reasons.
> 
> Let's get the current version landed.  If we come up with some kind of
> non-dma dmabuf in the future we can refactor it and move it around.
> I'm a little skeptic we'll be able to share code as long as dmabuf
> is allergic to physical addresses, though.

To be fair, it's not that dma-buf specific. This lib/ code only
does some resv locking, fence waiting and queuing fences, otherwise
all the attaching is done by the driver behind callbacks. Switching
it to some memfd could be pretty simple. But The main thing it'd
need to share is iterator handling like forwarding in the block
layer, and it should be fine as it's already passed as a completely
opaque object with no knowledge about pages / dma / etc. for the
middle layers.

> lib/ is most certainly the wrong place for something that absolutely
> is not library functionality but directly interacts with a few
> subsystems.

It only interacts with dma-buf, and even for dma-buf attachments
are created by the driver. Block, nvme, io_uring are users, either
using the helpers or implementing callbacks.

Ok. Let's assume for the argument's sake it's not dma-buf
specific, if not lib/, where would you put it? I was also
assuming that dma-buf being under drivers/ is rather a relic
of the past rather than the desired location, hmm?


-- 
Pavel Begunkov


