Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D58E7E0C3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 11:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G688QNZNzseecNO9s2R/4hOww/aUhIqv4CaNYmpeoYQ=; b=gy/TYFrZVf2B2H0Zn8i9SFfgna
	W5RMAUpkAGJqVCzVmsx8/YQ7HUVrACAP1OrmbRL99+ud45m4kCZ2xBKyHOP5W9k+Ovgwf0yj97elv
	V401JgPumuO9ws0J0Y8ilkgvc5ER4K+MLBMavq3cNYqlqwuGI4pYx8lPjg9zEqYemZoN+pXtC10VJ
	xcaMy9TMLIDoY2riDnd0dfM3fJ6TXgo2rsYWMOhBfJCdMODmXxcUyXj/KVOt5uxkmgB5M9OPiDUXA
	ZE0Fywa7CzG63nC3koHwwzbK/ZbGRff8Ff5Ci6oHDRZrgVXQASKXEbbaR1S6Ghi5JbHQb9suaIZr4
	42cMQntw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpOzn-0000000FGj3-2BJy;
	Mon, 09 Feb 2026 10:59:59 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpOzk-0000000FGid-2l64
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 10:59:57 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4805ef35864so36449545e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 09 Feb 2026 02:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770634794; x=1771239594; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G688QNZNzseecNO9s2R/4hOww/aUhIqv4CaNYmpeoYQ=;
        b=iPWgm5DXxcuSBD2Ayjp5XbdSc3a1KMDHdJFOHWJSVsfcNn9u6ilAq8taLH372SMy5+
         D83P4TiPct+hiXfJjoZQp8AYrEAcSO9kkX/Z8qIs6rDl8rTkSdenMnDtTEnuAZNt27J2
         H2UBv09v2J5pdjlxl8Wp3fHVbNeB0hsvmMsegRj0g9t7/yKSaMkCiwCes9YVqmghuWXP
         LlLICP570nNlld0QAXUNOcbsBO9DX2965D8oQ+kE5Ba6mngNPQBhnxNZsFJA2zsX+YEq
         ibKHKng4tcAexbYOfF0txX87TE+jE/oynUFVnYlSTcZteFoqmYFo4Jwpf/H935WbZ2rv
         EK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770634794; x=1771239594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G688QNZNzseecNO9s2R/4hOww/aUhIqv4CaNYmpeoYQ=;
        b=IQogqvQPBSQrmj7dCfTNVhO6wTX/cO4hE6fkluPa+Rp9Z2NYmLEBSXH9gb2ul6X5DN
         wTxZbaw0o/aV2UCcox4VSDEY8LdgYW7O0A0F6/uWi+qrgfFtPavI0Id7oVomDDD3HyNg
         7dZaTX6xzvSqvFoSGhcRHKI8Qf17eDuGdDXkf0J8nnliGm4r2wbhK+wVRn/xxC0N86QO
         YRNlCvZNKkkTLhD68yTMzDibkJxLk+gr4SXtLXSbC+hIQDu/PGQnKuH14yRIDbTMiiPi
         TeeUgpcP8QUei4Hr6Awk+X2LOmVZfc3CFAyNasbh/hKgCQGIVQHRg+6Ki1yeMMYPanCh
         IkTw==
X-Forwarded-Encrypted: i=1; AJvYcCWkIR4MnPUkdh/rYUTMbZQxnriv4yVFwCSZ7mOMlAaCY8Rmmnci1kKwYIfMZxxlvO6hKztNO7i+zDyj@lists.infradead.org
X-Gm-Message-State: AOJu0YyehiQR4EXgQJNnvX5Ogc7NsEyk0Z/qCeBccGEnz8AKrImfnovF
	KDQ38y8ZYR+n3fobCssf91R5HU76fLaIVxtHpmynJqoNeQXihpnKq4Ci
X-Gm-Gg: AZuq6aJ/SoL6vRfr8yJ9azeCqpCi2W3dF4u3L8MfVdNn1HRmfmFEUVNqe1MyeJhT7jo
	nmOkPbWFBZXXZIiVyEjmhn3kHYbPXnVmnOdAnwOZ2s7TY+Q0gNvJVGy9vn6E47T+pCPPsfls3Xc
	kdXLJAyaMLAaoPttq2uUIEj3Wdvap6BJqRAlfoKMSNJKxFD8UYGQiPuLDTSKdY3xTr0IL9BVQ2T
	Bn5RXG+6JTPVKxroVTq/KWMMXD20x6FGCfenKmAdYfZKx61luSSw4MNNPxv9Gn/E94IOjyL0Es9
	Dnw9nqb+qVkt7hUMQcwBoyPdWSahNgiT5dfuVdjSH9R9MNnQK1uTvDZX/pXBY+2J3NNw5EEnPAw
	GXBG6FumCj08bIENmdn/BC6gwi804qUtfq4+wvKGqmwTEk2gERqxKNoQrU+41/DDxH8hJ4GUG4Q
	jyZXSCWvSeGXGl6wboEZVTUAp4BMyYhBRZmnnH+O3SzRm84XDns1wuLKNLjjiZVrGAtpVYgE9mx
	CS2g1z+YA467LRwS6W9XRpMSlYaRYv7jXf8aVIhYd1aEi8=
X-Received: by 2002:a05:600c:a08:b0:480:4d37:e742 with SMTP id 5b1f17b1804b1-483201dd276mr144307045e9.10.1770634793982;
        Mon, 09 Feb 2026 02:59:53 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:9b67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48333bad79bsm196879525e9.8.2026.02.09.02.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 02:59:53 -0800 (PST)
Message-ID: <4736af5c-4bf8-4e9b-8f82-4b89a75d2cdb@gmail.com>
Date: Mon, 9 Feb 2026 10:59:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Gohad, Tushar" <tushar.gohad@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
 <20260205174135.GA444713@nvidia.com>
 <dbcc2912-e1df-491d-b1e0-7812279297de@gmail.com>
 <20260205235647.GA4177530@nvidia.com>
 <3281a845-a1b8-468c-a528-b9f6003cddea@gmail.com>
 <20260206152041.GA1874040@nvidia.com>
 <df7fe4d7-ca28-408e-bed3-bd1fa23e7588@gmail.com>
 <20260206183756.GB1874040@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260206183756.GB1874040@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_025956_830421_879CD237 
X-CRM114-Status: GOOD (  40.08  )
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

On 2/6/26 18:37, Jason Gunthorpe wrote:
> On Fri, Feb 06, 2026 at 05:57:14PM +0000, Pavel Begunkov wrote:
>> On 2/6/26 15:20, Jason Gunthorpe wrote:
>>> On Fri, Feb 06, 2026 at 03:08:25PM +0000, Pavel Begunkov wrote:
>>>> On 2/5/26 23:56, Jason Gunthorpe wrote:
>>>>> On Thu, Feb 05, 2026 at 07:06:03PM +0000, Pavel Begunkov wrote:
>>>>>> On 2/5/26 17:41, Jason Gunthorpe wrote:
>>>>>>> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
>>>>>>>
>>>>>>>> The proposal consists of two parts. The first is a small in-kernel
>>>>>>>> framework that allows a dma-buf to be registered against a given file
>>>>>>>> and returns an object representing a DMA mapping.
>>>>>>>
>>>>>>> What is this about and why would you need something like this?
>>>>>>>
>>>>>>> The rest makes more sense - pass a DMABUF (or even memfd) to iouring
>>>>>>> and pre-setup the DMA mapping to get dma_addr_t, then directly use
>>>>>>> dma_addr_t through the entire block stack right into the eventual
>>>>>>> driver.
>>>>>>
>>>>>> That's more or less what I tried to do in v1, but 1) people didn't like
>>>>>> the idea of passing raw dma addresses directly, and having it wrapped
>>>>>> into a black box gives more flexibility like potentially supporting
>>>>>> multi-device filesystems.
>>>>>
>>>>> Ok.. but what does that have to do with a user space visible file?
>>>>
>>>> If you're referring to registration taking a file, it's used to forward
>>>> this registration to the right driver, which knows about devices and can
>>>> create dma-buf attachment[s]. The abstraction users get is not just a
>>>> buffer but rather a buffer registered for a "subsystem" represented by
>>>> the passed file. With nvme raw bdev as the only importer in the patch set,
>>>> it's simply converges to "registered for the file", but the notion will
>>>> need to be expanded later, e.g. to accommodate filesystems.
>>>
>>> Sounds completely goofy to me.
>>
>> Hmm... the discussion is not going to be productive, isn't it?
> 
> Well, this FD thing is very confounding and, sorry I don't see much
> logic to this design. I understand the problems you are explaining but
> not this solution.

We won't agree on this one. If an abstraction linking two entities
makes sense and is useful, it should be fine to have that. It's
functionally the same as well, just register the buffer multiple times.
In fact, I could get rid of the fd argument, and keep and dynamically
update a map in io_uring for all files / subsystems the registration
can be used with, but all such generality has additional cost while
not bringing anything new to the table.

>> Or would it be mapping it for each IO?
> 
> mapping for each IO could be possible with a phys_addr_t path.
> 
>> dma-buf already exists as well, and I'm ashamed to admit,
>> but I don't know how a user program can read into / write from
>> memory provided by dma-buf.
> 
> You can mmap them. It can even be used with read() write() system
> calls if the dma buf exporter is using P2P pages.
> 
>> I'm not doing it for any particular driver but rather trying
>> to reuse what's already there, i.e. a good coverage of existing
>> dma-buf exporters, and infrastructure dma-buf provides, e.g.
>> move_notify. And trying to do that efficiently, avoiding GUP
>> (what io_uring can already do for normal memory), keeping long
>> term mappings (modulo move_notify), and so. That includes
>> optimising the cost of system memory rw with iommu.
> 
> I would suggest leading with these reasons to frame why you are trying
> to do this. It seems the main motivation is to create a pre
> registered, and pre-IOMMU-mapped io uring pool of MMIO memory, and
> indeed you cannot do that with the existing mechanisms at all.

My bad, I didn't try to go into "why" well enough. I want to be
able to use dma-buf as a first class citizen in the path, i.e.
keeping a clear notion of a buffer for the user and being able to
interact with any existing exporter, all that while maximising
performance, which definitely includes pre-mapping memory.

> As a step forward I could imagine having a DMABUF handing out P2P
> pages and allowing io uring to "register" it complete with move

Forcing dma-buf to have pages is a big step back, IMHO

> notify. This would get you half the way there and doesn't require
> major changes to the block stack since you can still be pushing
> unmapped struct page backed addresses and everything will work
> fine. It is a good way to sidestep the FOLL_LONGTERM issue.
> 
> Pre-iommu-mapping the pool seems like an orthogonal project as it
> applies to everything coming from pre-registered io uring buffers,
> even normal cpu memory. You could have a next step of pre-mapping the
> P2P pages and CPU pages equally.

It was already tried for normal user memory (not by me), but
the verdict was that it should be dma-buf based.

> Finally you could try a project to remove the P2P page requirement for
> cases that use the pre-iommu-mapping flow.
> 
> It would probably be helpful not to mixup those three things..

I agree that pre-mapping and p2p can in theory can be decoupled here,
but in practice dma-buf already provides right abstractions and
infrastructure to cover both in one go. I really don't think it's a
good idea to re-engineer parts of dma-buf that are responsible for
interaction with the importer device.

-- 
Pavel Begunkov


