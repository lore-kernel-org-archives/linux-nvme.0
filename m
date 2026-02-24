Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A27CE9B260
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7doier/S6v57RTdBt1iVFnJdNLGw+lPl8KUgoSr5lVI=; b=BlVhnKiNOKzymms+jBvp0y1uA9
	EULdhSLMdqPdruK2mwj95NyjqpkKpMT8hXxlUDtBnjQdeEwD+WYOrTvt2zZz4MdcOrB8jPYS9irWn
	R4CMvCJPHJjdMvAx5iYJUGb8jIo/ug7DZq5kGnXwHLcSikm2XMSFFTJzohBD/bm1kelyFK93eHW+b
	cC78sK3q0Bm9bxCxlgEP+lMddJ5OmGe7wi//l5EfYvwk1XVQ3zx5Wq/WTLqMp+VloYovzP1qpoapy
	/ZfUzvFWO/oSl6W+cc5et8387wzc8dNK+ysg7W/r68VDOB8pObTtsxDO+7l6QhCx698UhL2eLX73w
	h3qybJ3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vusmM-000000029zW-2Lyq;
	Tue, 24 Feb 2026 13:48:46 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vusmK-000000029yC-1EYT
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 13:48:45 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-43988056dc3so538426f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 05:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771940922; x=1772545722; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7doier/S6v57RTdBt1iVFnJdNLGw+lPl8KUgoSr5lVI=;
        b=LoVNvhThbixGuwLOlVUDd/Zpq3zpZ/IINg/HtwGDNilEntPT4H4wSxRldgJAlj2Mhs
         Dg7/U47yDOvNkbyWqvY67qPXE8VUzki3DzZVYhAmO+NUoQcjVWCb/8N2oqzn6nJ20i1w
         b4et5uBFdFPrUATxa3GWLjp1XrSntthBKAAGte++gTGl3iogNB00UaSbYYpPkGtR2IQ2
         5U/q1alm/UQivqVRUm31Pj8007WAXsfTO/BOqhgIobiRXrAoITdqbIgEhvN3kwDvgja8
         yQ3U4avO6VQG/V4qlk5BIhP5VAC7VYbDfng6NlfjDzCZaV86tHaiHGXlPeyBb0la/ED9
         mNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940922; x=1772545722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7doier/S6v57RTdBt1iVFnJdNLGw+lPl8KUgoSr5lVI=;
        b=mqJODJtX+nMc3lBbQqO0ynwud5oPQZO1S2xsXX4of5TKcpMorVjePwL2XfYduS3ZMf
         EOVH4isHuTcr1kNwJHiehQ1QAIhxIfJt8BotlHO7Ax04ObGVHe4qwwEyFcJL3aAlTPTu
         SNnsiKOiYpg9RbA7OqNUQ6Ok2OIED5nxCLN8P4NwjoFx8kolyHqr3tPxW7Z6PBGja61L
         DmBbhDgpkpN+r8BTnEp39yaHo6nSXwOY0VqMvpia87ZqjtprD/E6xfD7XcVuqIWC19e1
         DcLjprAxuWw1jaSjoJvdH0xS4OPgclYg8bmLfBpVssdz7qXqxx5bY//c13YJYZUCjtPO
         3AcA==
X-Forwarded-Encrypted: i=1; AJvYcCX4DGyiiaTMhksauG2YShVJvUG+DMIwKzKkWzD7JJCZo2JhFG7nYzIu7ojImhnRl5OH/zR8tJl2lhVi@lists.infradead.org
X-Gm-Message-State: AOJu0YwaX050/7DJu4mjARBW+XTALmGv3f0uDr/0dvHEURVOq7NdoM6g
	A9wjJzya6Prf53I2H+qjZSwb0Gq5z7F5I6Vn6Z4rSSSfviTotQmloqyb
X-Gm-Gg: ATEYQzxU2TAqHTFrEt4YgouCoNjlz5+PQEa4lbOSGe/EVZJEG8vYttqU5AgAziGfwuj
	WO71jdcQaYbIEt3zsNFCAPaSI2JjBRIHb6XqZtKX/+DZtesOy3oljtl72ClE6zipwOUilZG6sUA
	kZJtNY4I6GJv67+L2zzCVrUvkI1ZD3eRrfKadvtv/bAUW+83sfqM6tyV3V0ucyvl+stJR4ndwi+
	TfNDvHAIu4vNVPTx20MiJ6xAnM+XdIDj45Z5vm4gHliv2RpKjzSwjYriEIuqnm3fFK7SwM0IbC1
	C2dQ66UWOz2/imzsFYApEdjXAOgqqhrLnNrKxSQ7hVE8uD59pzQUC7jCd9ZE+dflcovSlLrHE44
	jJEIwtwcpp3crIUM1YkJtNdLWpbGL1kstd3ohnmpjZBlLS8soZU69sLWVcv0w/NS/P9RcBK0eZ2
	KENaNqt5d21AntTSydFs14SSf99uULQc2Moi0CCefYpWf3MpD2eez0wecTLKB8+v11XuGdDixjH
	xUoRDIdGs5LJAwqW5x9z345jTM45iDHI7ZN3tjQH0NTLh2qKwlFqNji+/ijb6i/eTxd5j22uikO
	QA==
X-Received: by 2002:a5d:5d84:0:b0:437:69c0:9612 with SMTP id ffacd0b85a97d-4396f15af1dmr21713147f8f.13.1771940921895;
        Tue, 24 Feb 2026 05:48:41 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm24786376f8f.24.2026.02.24.05.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 05:48:41 -0800 (PST)
Message-ID: <b091a8ae-4767-4ca4-a1b2-09cb525c4ff9@gmail.com>
Date: Tue, 24 Feb 2026 13:48:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: "T.J. Mercier" <tjmercier@google.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <CABdmKX2+OiqobQKf5G0ABiTeW5oqXS0p1dH7wRe2H7Gwdroi0g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CABdmKX2+OiqobQKf5G0ABiTeW5oqXS0p1dH7wRe2H7Gwdroi0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_054844_351795_5B572D69 
X-CRM114-Status: GOOD (  19.32  )
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

On 2/24/26 00:13, T.J. Mercier wrote:
> On Tue, Feb 3, 2026 at 6:29 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Good day everyone,
>>
>> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
>> and there is growing interest in extending it to the read/write path to
>> enable device-to-device transfers without bouncing data through system
>> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
>> useful to mull over details and what capabilities and features people
>> may need.
>>
>> The proposal consists of two parts. The first is a small in-kernel
>> framework that allows a dma-buf to be registered against a given file
>> and returns an object representing a DMA mapping. The actual mapping
>> creation is delegated to the target subsystem (e.g. NVMe). This
>> abstraction centralises request accounting, mapping management, dynamic
>> recreation, etc. The resulting mapping object is passed through the I/O
>> stack via a new iov_iter type.
>>
>> As for the user API, a dma-buf is installed as an io_uring registered
>> buffer for a specific file. Once registered, the buffer can be used by
>> read / write io_uring requests as normal. io_uring will enforce that the
>> buffer is only used with "compatible files", which is for now restricted
>> to the target registration file, but will be expanded in the future.
>> Notably, io_uring is a consumer of the framework rather than a
>> dependency, and the infrastructure can be reused.
>>
>> It took a couple of iterations on the list to get it to the current
>> design, v2 of the series can be looked up at [1], which implements the
>> infrastructure and initial wiring for NVMe. It slightly diverges from
>> the description above, as some of the framework bits are block specific,
>> and I'll be working on refining that and simplifying some of the
>> interfaces for v3. A good chunk of block handling is based on prior work
>> from Keith that was pre DMA mapping buffers [2].
>>
>> Tushar was helping and mention he got good numbers for P2P transfers
>> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
>> previously reported encouraging results for system memory backed
>> dma-buf for optimising IOMMU overhead, quoting Anuj:
>>
>> - STRICT: before = 570 KIOPS, after = 5.01 MIOPS
>> - LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
>> - PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS
>>
>> [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gmail.com/
>> [2] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.com/
>> --
>> Pavel Begunkov
>>
> 
> Hi, I'm interested in this topic. I'm guessing this will be in the FS track?

Forgot to mention, I submitted it to the storage track, thanks

-- 
Pavel Begunkov


