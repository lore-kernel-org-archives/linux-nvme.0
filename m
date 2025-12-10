Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84C9D3C92B
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ajtU3yfJbX06BLmikcUePQ/6Tt1KKMvvS1DqwC86HA=; b=blj939AtpAJHzl+HCrp30oPR9c
	R5SowqHBABGWeaMWMXRcCA1wy/wvr+pUyyPbQri8vLLDX6FwSRxKzuKdH+8UT2Ppc/ZXaMBsOy/ZE
	hVCwnuiE1Y01mImdze7KbjtjVIi1eZXoUBoyNaur+XbRgQueDtx5rrdIp1DX70ZJcPfnZX3iIb1I8
	LrNrDQDPAsKLMPZXC8uH225nd0U0APv7UFt8QVGIy2/nbgVMp8tVeGDrQXdZ2BWvYi520wtuoMqj7
	eHlh8vqFhX2mAAYLhBpgP9D30kcX8EOekYEY4V4JJ/70O562O2rW5dXRFay2ayX4ci0B2iaFec4N1
	kyaP64NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTNjX-0000000FgEf-14HE;
	Wed, 10 Dec 2025 17:12:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTNjV-0000000FgEG-0Ht7
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 17:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765386727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ajtU3yfJbX06BLmikcUePQ/6Tt1KKMvvS1DqwC86HA=;
	b=Gj8NJPiPKDfH0N5FXvbMQb6AeFJ72bg0PgYvBXPSt7mFPKX1RlsEZKEgQ/7g6hMLqJLaQC
	pXTmzoL8JAatgNfTyAvg4OoDXl2ZUU9dAHHMr8qlDyu5kH0b2PSWdG3fJpTF8uwAYJD0qj
	jHR1OAynO37daDTuD4mKzBGg5p/vIj4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Vv6xF-hDO-m-1unujqmufA-1; Wed, 10 Dec 2025 12:12:06 -0500
X-MC-Unique: Vv6xF-hDO-m-1unujqmufA-1
X-Mimecast-MFC-AGG-ID: Vv6xF-hDO-m-1unujqmufA_1765386725
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2ad2a58cso2929177f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 10 Dec 2025 09:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765386725; x=1765991525;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ajtU3yfJbX06BLmikcUePQ/6Tt1KKMvvS1DqwC86HA=;
        b=wjGlKQMp96oSyXQcBlAlC6tYWrJWI2ekLyRJV87lOYzxH+CmgROjWn4Korjd8fwFhu
         1COsT6V3DgXv7UzO4s8+9QvnXUcvsxuoh3FkYmIjAo++B//1wqXyY5jPKCNt6Y7skqk5
         iX5S0hg4XX7M7Ylp2uazPzgSw5L53RHCZ/3MqktsMy3c6okzLYNff9bRaj/jBk/npXC2
         pgvEfah0f/fKG6nDuwpnayglQzU2ZGPHUZ3R8my5/Cl1g8BC+aHf0ji+YcX1XqU2ao9N
         Sf3iFzamY1GqURrXeWVIafj177CKH54O5YwQjqEF9hHIbKaok4NJFjarJuWNK+mdpxUy
         rBjA==
X-Forwarded-Encrypted: i=1; AJvYcCUuc62sCSQoNgboZW6su00fpHLy5R3n2Nrg5eCDvs3pBEDCGo2671qEd3ABUZrg+amIJHM63AlNHLfF@lists.infradead.org
X-Gm-Message-State: AOJu0Yzr7zs853inj1IK5M1E0q69vnv0ZVCAzwLVF0CCTtls/0XAk6Ah
	crupUmB8E2KCTJwP0MWWAfMiSjKgKfnds3HFlDrzgFUhI4InkoNDRQ8eWZIA/qWPMCAf+i/TWa3
	sXYG+UMUxvPeSDIBu6uR9k7Z4u2i4Q1y5dsR5g+4M5RLcEvV6DBhhOeAh1nnOnATEIgqN
X-Gm-Gg: AY/fxX7lfldX/Axot0t6SlvfHUf+c8yAobHVOxsKMa3AYkrQ/ZNeP6j0HZIepudXtJV
	ZPJHNoJfyfJahYVb0TZ6hsL08L97ggNydP8yNTD00faFDZqEWmQlU0KFm3OjvAKU3luSdrIbJ67
	Uauhlg94gxsY8AhRtQ0sFEb9UMpPGU+XjoaboQ2rI8ayD6IjiNj2cIziaZ6cHKZ2SSYNNvJmYiQ
	t0FJnT5AdkN4BQoE/3WApTuJmj7KnzoA8wilIKCUfoH6n6KkEJR3LgSuMrhwF5NimUdoeX/i8ni
	YWTCbluIgz5Qrk5xbWs17zuVp375dM7hhM19ln0q3DCgHAjaGvGTPkKZDfo4IhHpzbW/8XR0Yzs
	gFAuCInoQRrSyhfYiOSSCqItNXN8+g1aFquf8gQCgzkIQ52ofrqb1UB+xJuE=
X-Received: by 2002:a5d:5f91:0:b0:429:d1a8:3fa2 with SMTP id ffacd0b85a97d-42fa3b17092mr3315988f8f.48.1765386724823;
        Wed, 10 Dec 2025 09:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExCXlgcWY7yBdco5ZpK1NFXlvlTRlygsYWJNZD8Qo0xz2z2qNLT3h+7nj8AJhe/t1VfpQnNg==
X-Received: by 2002:a5d:5f91:0:b0:429:d1a8:3fa2 with SMTP id ffacd0b85a97d-42fa3b17092mr3315940f8f.48.1765386724378;
        Wed, 10 Dec 2025 09:12:04 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8b9b20dsm27930f8f.38.2025.12.10.09.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 09:12:03 -0800 (PST)
Date: Wed, 10 Dec 2025 18:12:02 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
cc: Keith Busch <kbusch@kernel.org>, 
    "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
    "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
    Robin Murphy <robin.murphy@arm.com>, 
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, 
    Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
    Will Deacon <will@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    Leon Romanovsky <leon@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <2fcc9d30-42e8-4382-bbbc-a3f66016f368@nvidia.com>
Message-ID: <0eec3806-c002-54d5-95a9-7fa201c6b921@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com> <99e12a04-d23f-f9e7-b02e-770e0012a794@redhat.com> <30ae8fc4-94ff-4467-835e-28b4a4dfcd8f@nvidia.com> <aTjxleV96jE3PIBh@kbusch-mbp>
 <2fcc9d30-42e8-4382-bbbc-a3f66016f368@nvidia.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7NZfON1ZTO1hlGB9AIcjJoXmhvE897WttHCsW388Gqw_1765386725
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_091209_193325_F3DE8A40 
X-CRM114-Status: GOOD (  20.00  )
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

On Wed, 10 Dec 2025, Chaitanya Kulkarni wrote:
> (+ Leon Romanovsky)
>
> On 12/9/25 20:05, Keith Busch wrote:
>> On Wed, Dec 10, 2025 at 02:30:50AM +0000, Chaitanya Kulkarni wrote:
>>> @@ -126,17 +126,26 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
>>>    		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
>>>    				vec->len, dir, attrs);
>>>    		if (error)
>>> -			break;
>>> +			goto out_unlink;
>>>    		mapped += vec->len;
>>>    	} while (blk_map_iter_next(req, &iter->iter, vec));
>>>
>>>    	error = dma_iova_sync(dma_dev, state, 0, mapped);
>>> -	if (error) {
>>> -		iter->status = errno_to_blk_status(error);
>>> -		return false;
>>> -	}
>>> +	if (error)
>>> +		goto out_unlink;
>>>
>>>    	return true;
>>> +
>>> +out_unlink:
>>> +	/*
>>> +	 * Unlink any partial mapping to avoid unmap mismatch later.
>>> +	 * If we mapped some bytes but not all, we must clean up now
>>> +	 * to prevent attempting to unmap more than was actually mapped.
>>> +	 */
>>> +	if (mapped)
>>> +		dma_iova_unlink(dma_dev, state, 0, mapped, dir, attrs);
>>> +	iter->status = errno_to_blk_status(error);
>>> +	return false;
>>>    }
>> It does look like a bug to continue on when dma_iova_link() fails as the
>> caller thinks the entire mapping was successful, but I think you also
>> need to call dma_iova_free() to undo the earlier dma_iova_try_alloc(),
>> otherwise iova space is leaked.
>
> Thanks for catching that, see updated version of this patch [1].
>
>> I'm a bit doubtful this error condition was hit though: this sequence
>> is largely the same as it was in v6.18 before the regression. The only
>> difference since then should just be for handling P2P DMA across a host
>> bridge, which I don't think applies to the reported bug since that's a
>> pretty unusual thing to do.
>
> That's why I've asked reporter to test it.
>
> Either way, IMO both of the patches are still needed.
>

The patch Keith posted fixes the issue for me. Should I do another run
with only these 2 applied?


