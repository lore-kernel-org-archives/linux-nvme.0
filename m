Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EC8C02193
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 08:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jqAlTEwav17I8RuBsiv4sqCdYRrJ7WOllLr3rsZc9+c=; b=mqS+wfV/e1oba19kfvqIRn2ak3
	XsBEDSaWZPFrrFA2T70vqBrsFNmfKCb8qRZlcvML5S95v+mWLqhqa3/J6P5GPeuAZwCDVB1tHxa2b
	CScRuEKUjyFQyN6fvl4OpJq803tkgqx/BDC4XA/qE+oHuP4v0yMw9uhREmAj0WkxRRgoR5hz0cgM0
	yvmjwzF+v3gs805/qpvendGdXzzteITNuLcoWGH6fcZ2HQSM6s3YUDmIInsq/xXNUDGMO6NQQXNVw
	3S4rqiHv7zxOzyLXRdnKrJHD+ksHxH1Vt4GRbsrjDLx54UyDaZ4O95UHl4zasjCs3c+V+a2PCl0R2
	RSTU0H6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1terwT-0000000ErWe-3Qyt;
	Mon, 03 Feb 2025 08:36:29 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1terwO-0000000ErVg-33EJ
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 08:36:25 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3863494591bso2039797f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 00:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738571783; x=1739176583; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jqAlTEwav17I8RuBsiv4sqCdYRrJ7WOllLr3rsZc9+c=;
        b=DaIvTuI25+GoBnHduAd5qhquctS4YOeww+cAsIhCOoJ7GtJasCpQ3SW3dOlM9K5HiZ
         5FZf0B5JMxpmPtgkM1g+q/E76UvEiEMgdQWK2puniwhPLkINr3nf2I0MCR9HBiZxFgHS
         TMVgYVCHHq+oW/ZbOndFhrjvGY3ejPBdVLSxb1+Ms9LTiHhfq16QosMQqeNDdp2coHKE
         Aaxvt94fzAm9ncORxjAwnFffjTb5P/DQBjry9s+cbAGAzhvyfhnGJFwJanC1xUaPcBHp
         3vkeNb6MqRWzYAldfWApffElI+0DIv3Qh4t7sT3e2C17y4ku+SN6M+2MKgZYbDcL7qLX
         Yw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738571783; x=1739176583;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqAlTEwav17I8RuBsiv4sqCdYRrJ7WOllLr3rsZc9+c=;
        b=IPlqrBcDwGsJrKJ5ybiu+a5VWbi/SdHjsKuSIwBZRFzWtN0/DR4aZKQFo/UEn7BL83
         41FMSsmPlLrdOsQXhsXNW9nLFzWDIefULYXF94Kz/Ix1+USL8PL6a/aEe/Baw92/I/nY
         8k6CYpjk9qYFsDcalLWgW9+yuPxWScHAVJMuWT5VzPcB0ZntEZcGYGJ9LCRvJpoS6b7k
         wk3nCsK9j8T9+C6xyOsyI4MdqlpaPlSrVCQrf/HkPNkldgapYoOMUT6wSaY6tOYxm8sZ
         /+Zga1EV02GmnsZevgZ1SrfUAusA6ZcDtjsF2eM+4V/NcW9Zz+GA8hxwf5hRo6/KpkoK
         nSXA==
X-Forwarded-Encrypted: i=1; AJvYcCVfcPmC4wA2zzl4hdQsGtpzF+2t87EwkPMYC48tzpN9ssX3/rH+7sAO0ukAoMm803A9eHFkJWA9NFTo@lists.infradead.org
X-Gm-Message-State: AOJu0YxHV4W+DIjTnu/L9490tz5chBxbEGrd6OgK7ugrzG6NF7+etWlU
	atLbu2C5Z5qsltowRxEtp3PxIhWmvM3MXrHP5XXKpqbpK3Ax/VlbTibe8U0giA8=
X-Gm-Gg: ASbGncuM5ej1V5/GUZoJgRxfklad6Ti5RimCeE3ZP+cJNhGIh+K4k82TBByGIwvwwuB
	eL7ZdI9FwZ/9rw7Iu8hZriRLelHdaAjQ3Zj0Xf8p0ykAsshHv1niZcDEk8Ke+IDfYkiongnYcm+
	Wg4kZ2FrhaIwDmdtp31VgBO/rmLG2hVfNe8f/frPLtx9hc1GjbplegyNxOmQMQNzt6EztP8n0Fi
	n/N6Z/NslkNFx0CJq45tHQ3ivkCXzhiHfAiVvyjLFq/sGMc5WTQZGwDg65w+re2rCq4dpk+RKsg
	AGJ9zd7Cth6feC/9O9Mvwrz4jBPpNoOPyGU5YxubNfM=
X-Google-Smtp-Source: AGHT+IExiCnr5bhzGChI/EAcZsdE4WZTkN1CKPEFyjA/pkaaGS3fOIRYJD3Somr3OcHZ61kIy6L4pg==
X-Received: by 2002:a5d:5f56:0:b0:38a:36a5:ff81 with SMTP id ffacd0b85a97d-38c520a3440mr19499172f8f.40.1738571782709;
        Mon, 03 Feb 2025 00:36:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f830a3d74esm3719298a91.2.2025.02.03.00.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:36:22 -0800 (PST)
Message-ID: <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
Date: Mon, 3 Feb 2025 19:06:15 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: "hch@infradead.org" <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org> <Z6B-luT-CzxyDGft@infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <Z6B-luT-CzxyDGft@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_003624_763492_0DBDF478 
X-CRM114-Status: GOOD (  14.00  )
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



在 2025/2/3 19:00, hch@infradead.org 写道:
> On Mon, Feb 03, 2025 at 08:26:33AM +0000, Matthew Wilcox wrote:
>> so this is a block layer issue if it's not set.
> 
> And even if the flag is set direct I/O ignores it.  So while passing
> through such a flag through virtio might be useful we need to eventually
> sort out the fact that direct I/O doesn't respect it.

The example I mentioned is just an easy-to-reproduce example, there are 
even worse cases, like multi-thread workload where one is doing direct 
IO, the other one is modifying the buffer.

So passing AS_STABLE_WRITES is only a solution for the specific case I 
mentioned, not a generic solution at all.

But I would still appreciate any movement to expose that flag to virtio-blk.

> 
> Locking up any thread touching memory under direct I/O might be quite
> heavy handed, so this means bounce buffering on page fault.  We had
> plenty of discussion of this before, but I don't think anyone actually
> looked into implementing it.
> 

Thus my current plan to fix it is to make btrfs to skip csum for direct IO.
This will make btrfs to align with EXT4/XFS behavior, without the 
complex AS_STABLE_FLAGS passing (and there is no way for user space to 
probe that flag IIRC).

But that will break the current per-inode level NODATASUM setting, and 
will cause some incompatibility (a new incompat flag needed, extra 
handling if no data csum found, extra fsck support etc).

Thanks,
Qu

