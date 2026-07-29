Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D893C53219
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 15:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YUW97RbS/cuxZAvn9F7FgEb6B/w45ofSr5IJCTvWkgY=; b=W7XQbSMBrvFxdQCCcsHcxORpb6
	48SIV9qeU6IPEpHIKcQXBSLazVQJPuD53/AdRp+K8YZWW/NnAaRMNWbfWlYTNq3SoUshwf1G/VhrC
	UBeVqf9OgLtrwADsRRBIHaMuXQdF7ghiLtgLs3faNMl3VOg5kcstL0PhUoVg37l6P+77sYTjVOiaD
	WVjBMTBEL2XsanRGPgrZZHz9JkZfAc73sgeyxNVVuKcvvZ9HDF2oc3TfLUnJF4gIuaICgYcuiEPVX
	Hqh3sihqTWN9svO8hXDEciE7EIWlUuiNm3cXXsNx4GmeYS80iv3V5R7bsu15ffLBx5zzP33YuKvfU
	HEZwmozg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5mO-00000008KRA-0VGk;
	Wed, 29 Jul 2026 15:01:08 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp420-000000081qB-2qOj
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 13:09:10 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-493f75f7172so7633635e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785330547; x=1785935347; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YUW97RbS/cuxZAvn9F7FgEb6B/w45ofSr5IJCTvWkgY=;
        b=E8SrncDCYVApng/pxcVNJ39XRuOnBK1JnsDo4DYcqRXDHlAJgWyEEZYRRnVF53ZYt3
         97EPW4Kh6+PHHY2SNJ9Tll4jYWebkZMpE9e9h16enra8RSP8dD0JjKkIMVcBAf7exNMC
         RlieaOzD/mc30FejQ7Ae5v3WJJKSRKZ+xGRUkL61YcaSC5qM+Idb9zYnNekoGuK8/NHJ
         mQbHqhJoPsuEtlHrwKVq4qVH9ywkVGNj4ZLw6BSpWLga/BPDQ0jO4sKZmK652Ud4OeKj
         FI/8FCYnaLzuSXx/bZBoSyC501A6pFRqQUyJplhvBDwD96/KjthiSQUcHqAYrpPfv6Ox
         dWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330547; x=1785935347;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUW97RbS/cuxZAvn9F7FgEb6B/w45ofSr5IJCTvWkgY=;
        b=fAtUZ81pq6knUl1L0xVRz+smC0HxhPxt0r+FeT9CjLFC2ZEAVCfrWoLY7Aueg+GDYJ
         LpMfgunu1LK/X1GIDH5gAy52sINB+HNB/f8NbSRgWSJ0HofHDkQ0TdQXagn8xP7Ru1pd
         lVFG/oEitMp0gnbfCOfRWuA3yCzA2rA9cODdHdtqQVvfsbBpsxaJyHplf2rhyEHmAkFH
         9qOaXzdMEdtiLd3QPmXGTZl0QXStLycsUDsNhdbLdEaAzOXdOSFQadnpEQ+Gt7IomEky
         gaDsaDYKTFRoawRH6778dJ9DgRFmQRS4tgWixKkF4UGVNKZ2nFYugOdzx/hOb1TE2NLB
         5DIQ==
X-Forwarded-Encrypted: i=1; AHgh+RroWgmG1Nc24hyDo8wPZiPKE8C5V9tjPcOYbzH8yr7VUgyG7U0A52wOVaZW9eh1CrbvcQNIQp4Bw4ab@lists.infradead.org
X-Gm-Message-State: AOJu0YyA+kZyrXc2qRMimT6B12t/phsVvka9YtcFwF0rTvKeMn8REI8M
	PYsS/eCYP5VgDou2Q+87Eht0ngMRz6GB0V69KfQ372XG/1REot7EClcM
X-Gm-Gg: AR+sD11C5RiG/Sy+/fibq0mHl6FKnOctSBqm7BSaZ596qUxFq2Xkv6RCCbDX+e9KrFO
	CkmzJZnUA/6AbaBJuIGerXybdK2m6RLMeAhfeeYOnwOeO93/+p0j7w9Zc7KNP4Y8llFMpPrqL6X
	ANCekVuTFL2So8vnE4s9FQuyGJG3FrAvha14ZZ/4fztNYpyhRwoCAWbqz2fuiHH7E13M/2/RFhp
	9vi9dAeD8TPHxzeJNElqhfcreNXJQobocTr7MLs6lp+k9JCnHwe9jOBpHcM9UBihJXzJD1Y9Fqk
	id1tFN54YPo8YFD2IUyiTg23FePw2rFGIf8rFNg6Nwjrw/+z3cK/yFZXdB4LzM5nlnANqBTL+Z7
	AgLiCaGptsrDnEi0i1panRoKphBjKyOI/Tvewp1wiVd1lvWG2naH4w/M9RBKo9Gh7zBegXdg0Hz
	SriGhy0Ps/ZRcq0+7akfDlTt7kSqPUuuvCmaIFpBvSVZXK9mQ2lH4Iq3desah6E5jB2/+/l0iSl
	kaUYf8HnSkYbB2M0CUGc4+hLjyvd0q7+ovgm8SGbznie8tSuAJ/RkUKVGBqBiXWAsVjfYekQwPe
	PrDwjVi8n7zl5Hx7z5g=
X-Received: by 2002:a05:600c:348c:b0:495:4fd4:f7b6 with SMTP id 5b1f17b1804b1-496c659f7e1mr79358045e9.37.1785330546620;
        Wed, 29 Jul 2026 06:09:06 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d70014sm93438595e9.3.2026.07.29.06.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:09:05 -0700 (PDT)
Message-ID: <8160ce17-6f14-4946-9146-3d261e8398d3@gmail.com>
Date: Wed, 29 Jul 2026 14:08:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, cpgs@samsung.com
References: <cover.1785274111.git.asml.silence@gmail.com>
 <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com>
 <CGME20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc@epcas5p3.samsung.com>
 <20260729072117.GI9534@lst.de>
 <81412691.21785320403945.JavaMail.epsvc@epcpadp1new>
 <20260729113108.GA31120@lst.de>
 <b03bba6f-0a8f-41fc-af59-2a69d271f28b@gmail.com>
 <20260729115540.GA32573@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729115540.GA32573@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_060908_912800_84B2DD9A 
X-CRM114-Status: GOOD (  20.19  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:01:06 -0700
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

On 7/29/26 12:55, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 12:45:47PM +0100, Pavel Begunkov wrote:
>> It was exposed in early version as I was passing a [{dma,len}, ...]
>> array, but we moved from that. Maybe I should put the minimum
>> segment size in the map structure, and (possibly over) split using
>> that for now? Keith had this chunk in his patches:
>>
>> +		int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
>> +
>> +		nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE) >>
>> +								PAGE_SHIFT;
>> +		if (bio->bi_iter.bi_size > max_bytes) {
>> +			bytes = max_bytes;
>> +			nsegs = (bytes + offset) >> PAGE_SHIFT;
>> +		} else if (nsegs > lim->max_segments) {
>> +			nsegs = lim->max_segments;
>> +			bytes = PAGE_SIZE * nsegs - offset;
>> +		} else {
>> +			*segs = nsegs;
>> +			return NULL;
>> +		}
> 
> This seems very pessimistic, especially for the case of the registration
> only having a single segment, which I'd expect to be fairly common due
> to P2P bar mappings, huge pages or IOMMU coalescing.  So at very least

Agree that PAGE_SIZE is too pessimistic, but I'd calculate it from
the sg table on registration and use here. Not ideal but should cover
most common cases like huge pages.

> we'd want to special case that, but in an idea world the caller would
> be required to provide a useful nr_segments for the I/O.

Not sure we can do it in the straightforward way from the abstraction
perspective, mapping are hidden from io_uring, and there could be
multi-device files with differently shaped IOMMU mappings at some
point. We'll surely need readv/writev support later, so maybe we can
improve while doing that as it'd mean passing a {off,len} of some
sort from io_uring.

-- 
Pavel Begunkov


