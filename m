Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3890FECD995
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=idtwUK6BtIsEhpc3TaDCHUqHeRjM5Kpq3rLxxa+LHTI=; b=hDn7W6FbNA220KbI5OfqaojsZN
	mdWo1GJkUprUsVZHy0ZG+KKylTIOuifEJrMCSMaPM9Bboc1E4ZMjX5rmTKKONgVtFlpuEAaWuaYO7
	KjFgtdHC8xfn8nQGQygYwcdjkKNfUva0yPdW+jWPFWXn0Ltepq787NCXe+uQXs4KBeteV9XaNHiZw
	sZQE6YhwT5ufFM/BaG/PzB3S5M6UwtZf0QBQT8RrTQoH6TkYiRLyQcOx62TJhJrMThPIeRmXEo4ER
	XhUGUiU6NQ5EJuZ03yJPfrjv/Egh16vNLtbSEmrduJkPSAuuoy9DaewCg5dukrRqt4T1OXSpVGpvO
	fxfN0ArQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo4gE-0000000APIf-1YlD;
	Thu, 05 Feb 2026 19:06:18 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo4g5-0000000APIG-42BM
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 19:06:17 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso8723625e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 05 Feb 2026 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318368; x=1770923168; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idtwUK6BtIsEhpc3TaDCHUqHeRjM5Kpq3rLxxa+LHTI=;
        b=kx4S2EQbVx33gm+0i9YZVE2ebChKv0hFRdSgvaKe1AqLoUDQzy8Etm/ol4CLAUEuVP
         yKaBUSyYusUCdMKYY/YMNZNi2ySS5D+qPzMNPntbwLuiZcrZJEAWWB/X7a2CJrXsd9jI
         iR+ZpgNmFIwhqGcNu4EYHqWdPNLfzYnGGIbUQ+YwQJvNeQArtKjFTpb4qyi9NQshG8qU
         oZM9oWCunotC3kL0xPu0MYKanvuWVz/0RSmuqZW0LLgkxqFfs0qRE9y8SOnIP0Jh9c+B
         DGxVBtmN3+qbhNfHgwAy/k2n5SAPrsLRlRuAWLyj6HbEZtneI1vw9lSvGZDLKWVmabdv
         9K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318368; x=1770923168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idtwUK6BtIsEhpc3TaDCHUqHeRjM5Kpq3rLxxa+LHTI=;
        b=mhZePCDkGCgWzek9WRDm8ZlArQ5VQg4VYPii+/WqSQByAJmM8IsUXVG4VOtC1iUqKH
         JJJrb5jPr+2+CY6Q2rTjwUmTk8RK6xvdc6sLlQrQsQa4KMQBXfqqy7q/XKnSPni1QDNP
         Icm30HiV5b1L88qI5Y3Dx5rM55qfJ053SN5hR3C321avPZV1QrplhQXnQyfrK3Lp/2Ci
         WwaZWcrDp/ONl/n9QG1JPE8PUKbdNfAS6B5TjyigX5SCbEq5oPPl5eWUm6jn2KzgYKJ7
         T86dSxsOrY0+3HO/0OVxNqjor1lzQaFFo59QYwoe3g9tBZqJ4L39VGA2oWJwR0p2bwSW
         13Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWVR1RUkJxPKARU5MDTtYyuJqannktIMPAzf7mLPcdd/h5RSx8wZ1YNEL7WKucvZj8OuhDSYSNq0h/B@lists.infradead.org
X-Gm-Message-State: AOJu0YzHSal2Q4bPgPnlLMdwEhunZDrYRyzZ7C9FIKDRRn6EZjq18E0n
	6WC7Zq5ElHeJcrd8jQsKlrPtxRjMMPwL8mFygzP4WTrYPuAUvGgaC4hI
X-Gm-Gg: AZuq6aLLmG9Vos8xsKOoBXXAo9ivCQ+B1s3b82kJTsad3Q4Z561Gz+MCeEwExSxegps
	0xNWucxtQ/aWoxlSAyNMFagVRi7R++ySWD9VQ4oKOFBXAqC0V3VTDVwt8fB4mZDXAXeGIwNeTVH
	D+iSQbi6ncbtB19p9afaNwh1g9eR5KH3yM/SSwkrFRdYFzAjiUDdIDBSWg8vNeRdwdsdL9nCbRM
	wbIjW0zNdxT7UiyIShi2TwC6ylSW6K5jU4B7Ig6qFiWIbFczQwVS2Pl5nIzE7genVhcsJQctRUJ
	XWtrY8d92ZAPcuHkVwqvlnrxN6Fn+Fm9CFlb4+UHZbFh/L1CP2eFby0W+8lOiu0mhMpI5yTqz6H
	HKQzeoPSHWGsG/9joJFZeiRDHwhV4o+vWeYMBqHAFEAJoKC30Zzg61Dqr6M4UnDCjj+TvmZARpD
	nwWZtjzQVTE5WjoIwWJGbWfwZFx3DuAxi+iegSeY+rZCS5vYXzwdAfDB+Hx88FTbuvghPhy9mS6
	KfHk7JwbVdvQK8V81BKcS/LJPd4NzjbPzwcehry75Zb2Qbzb7PJLdU7Ss83Ojgasg==
X-Received: by 2002:a05:600c:5253:b0:480:1e9e:f9b with SMTP id 5b1f17b1804b1-483201eead3mr7164205e9.16.1770318367919;
        Thu, 05 Feb 2026 11:06:07 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203d5ef7sm2743825e9.1.2026.02.05.11.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 11:06:07 -0800 (PST)
Message-ID: <dbcc2912-e1df-491d-b1e0-7812279297de@gmail.com>
Date: Thu, 5 Feb 2026 19:06:03 +0000
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260205174135.GA444713@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_110614_607948_96013396 
X-CRM114-Status: GOOD (  17.81  )
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

On 2/5/26 17:41, Jason Gunthorpe wrote:
> On Tue, Feb 03, 2026 at 02:29:55PM +0000, Pavel Begunkov wrote:
> 
>> The proposal consists of two parts. The first is a small in-kernel
>> framework that allows a dma-buf to be registered against a given file
>> and returns an object representing a DMA mapping.
> 
> What is this about and why would you need something like this?
> 
> The rest makes more sense - pass a DMABUF (or even memfd) to iouring
> and pre-setup the DMA mapping to get dma_addr_t, then directly use
> dma_addr_t through the entire block stack right into the eventual
> driver.

That's more or less what I tried to do in v1, but 1) people didn't like
the idea of passing raw dma addresses directly, and having it wrapped
into a black box gives more flexibility like potentially supporting
multi-device filesystems. And 2) dma-buf folks want dynamic attachments,
and it makes it quite a bit more complicated when you might be asked to
shoot down DMA mappings at any moment, so I'm isolating all that
into something that can be reused.

>> Tushar was helping and mention he got good numbers for P2P transfers
>> compared to bouncing it via RAM.
> 
> We can already avoid the bouncing, it seems the main improvements here
> are avoiding the DMA map per-io and allowing the use of P2P without
> also creating struct page. Meanginful wins for sure.

Yes, and it should probably be nicer for frameworks that already
expose dma-bufs.

-- 
Pavel Begunkov


