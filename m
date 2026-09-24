Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711B4CA5FA7
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=; b=NCV/7hsJZ+aGDqtxA8+/LnXDXz
	koZB+oNA5pdMRf+GjnYdDBNLCxLhcaQTXve9qagLiLudah6foFnJMPj5bzhl2W/v+Jb5HNAIF3Qkh
	BkG0iE/U9f/B4jgPBe/B+oWmdVBEpZyRQkA8SDjFEl1Ml0Q8w41oFYP7E3hD/iYcgB3+aZyD71Ann
	UOAO+Pntb2M6fZqetsc8hjrTnoVRS2sn2M6zirFKOxVf9HDoY6A1FyPyFgn01/RXC2wiHU7nT47uJ
	OUb+Vi+O9Q4+2rb4IOwvl0VcdM9Ew++aid3KWYAEghEDykp8vz7scLVulLh2JZs8tCPfrY2lrAA7c
	BoWitcjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7b-00000002jJP-102U;
	Tue, 29 Sep 2026 08:23:31 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9lle-0000000BUh8-47Wa
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 15:53:52 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6aa8d04fcddso1978668a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 24 Sep 2026 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790265228; x=1790870028; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=;
        b=nl08XWHGYBgVSUg1LQG3ZWD4O0S8WdJYc/tX/gOdwisu28x+Bn4zWGdRXpZS3ouYlQ
         PjPfmxy6lwMGVQzL0hr6ehGfZve+TMJCWWZagTIVZaEwLlOJ06RlyE5tQ9oKIfi9oqRF
         376BrPnT8SQxFAwMe6hXaQ7HOCCa8L7x8CDOybibABp1zwWJrZB59nvZl/ZszM8xd/cC
         Iaf+i/eoT4cd+WvTJDH1cj/y/qJmAMQitp8bKxwLUVmf4IKQmOe1NTWEk9Cj1/Axbe0s
         hReEBQo0z/E0YiJln9u52Tu1vxnALPYZ5Ax4Joe6x4id2vzwrxN5U6RaO571BVPINAWR
         8cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265228; x=1790870028;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GNmm9vpoKogbEkGqMdf9XAhWMEnJbsDsb3NN6zmWdWA=;
        b=iWuNnrzY1akLmwlwTOOz8emKJoDkxuIafeLX98q69RnfKa4Zm933iYfQT8nTCVWRpL
         y8t3cLAnjrXrvd+oZp2VbF6j3Fff/IsTle5m+KvbHToacrZL2VvhPE3bW88j9qgKkUAC
         Hd/ez//RN6AoPFRdvoR/eZEpG9V6V3PK0g+ybKNkGvKSq5hIsGNJ8PS/s6fU2Pb6K3pw
         H+5ksI64b9xdqOqL1Fl7WhGxClFN3ZxQU59cpiBR4T1dw11XdB/8eMmzDIe5S69k9ZhC
         l4bZSruDPIsXMGFL8Emln9gjZZdsui0mOc+brEZD5lnJx744lYOt/KMoDnQQy0pAgWUI
         Db0g==
X-Forwarded-Encrypted: i=1; AKwUvBzieMycBcLJ84JTuH86Rhg2LBeTVRIdp4j6cQi8NLrax/T6/xcYX4JVO/O7/mt+c0EKmhjuXp8X7E75@lists.infradead.org
X-Gm-Message-State: AFuF++nNeLvEhimISk23wnDzN/P4fq5LEqFF43It/AU6wfqcCHHQWD6K
	WJHd+xaUswPcCWuYVYUYOB8xaqZL7LerHm+aFeivmKT1CW/D8zOHsU8W
X-Gm-Gg: AYBFou3O2LC6ifspop532CWTIBvd/A3rTc1DyWczkHxUyvJgo9xDZV7CUfLOkeoqnyt
	9IMzLi1YPvDeznu+h/XFydMyn8YWv+9XXBTjgLoM44H6AC0drrXXqQPuh9hLSGy43EmM3LqyDW9
	riqjQsHP3sRH+iCYAiOnmgvi2ZMqscjiDzAOr/gTwwE1wSA2yHog7vwxH6TvcYRTaMgoszvj76V
	N4hSKMlx8g9yIsgPkKD0mMwSvWOZbQKRQrZVfsW7L04hlr8QGQ1GlKqoFvt5Jsn9Y4I7fVX8GC0
	dGQ/LNZ659iTDOEZR2HClwjC97IK6mYvm+If4qNuVzpPY4IGBcAy3rf/vb0DyhntIGzi5d+s1WW
	jrrKmDRwJoQdiGcwP03CvhCiagHsAw8l9X73NPtU4dVtc9c02GQm8XQ5ImQBQ3uYDM4/U1fCSib
	UxyvHuRsTMOGszbmixemcyWM5S+fRba6hNUrE7gfL+qxdFLtTl+zM5+nyXNIrGqROtlJz8oMIxz
	xfDbS217rf4Dg0so3vH05C8EgwtRGOOeoaQwD0hLGkaqp7krKa7A7r499s645PkR+7OkAU0xexb
	vcApCgOWuhDgAhWyZHAuwAwd1CQi/rr279jpUTqB36F5uE9dgQ==
X-Received: by 2002:aa7:d94b:0:b0:6a9:c9d8:b3b6 with SMTP id 4fb4d7f45d1cf-6aac8f0ae7emr1949690a12.6.1790265228473;
        Thu, 24 Sep 2026 08:53:48 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38b2fc5sm3815784a12.27.2026.09.24.08.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 08:53:45 -0700 (PDT)
Message-ID: <6d538f3d-dd83-4dfb-b091-9b84acf47c62@gmail.com>
Date: Thu, 24 Sep 2026 16:53:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/13] nvme-pci: implement dma-buf backed requests
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
 <20260922132016.GA30684@lst.de>
 <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
 <20260923045505.GB26231@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260923045505.GB26231@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_085351_046715_4EF08341 
X-CRM114-Status: GOOD (  18.79  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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

On 9/23/26 05:55, Christoph Hellwig wrote:
> On Tue, Sep 22, 2026 at 02:37:08PM +0100, Pavel Begunkov wrote:
>>> Sashiko had a few comments, which I think are correct - if we use
>>> dma_map_sg to map the data, we need to use the sync_sg APIs to
>>> transfer ownership.  That only matters on non-coherent architectures
>>> with MMU, but we need to get it right.
>>
>> I've seen that and fixed everything locally that should be fixed,
>> apart from the sync. I wonder what we can do about that? I can
>> somehow replace it with the sg variant for now, but sync'ing the
>> entire possibly multi-GB mapping for, let's say, a 512B I/O, sounds
>> not wise.
> 
> If we'd want to fix this for real we'd need to add an offset to the
> sync by sg methods.  Or move away from scatterlists in dma-buf, given
> that they are a horrible API.  All of these are bigger projects,
> though.  So for now I think you'd want to do the sync all, and have
> the people who run high-performance io_uring code on non-coherent
> platforms suffer.
> 
>> And I can think of another place that does mix sync_single
>> with sgs.
> 
> Which one?

All the recent networking zero-copy / dma-buf apis.

-- 
Pavel Begunkov


