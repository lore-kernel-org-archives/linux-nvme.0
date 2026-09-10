Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CD1C88E45
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2026 04:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=; b=29d6IdFExqxnmCJ0+2dXDxVRLX
	0Rx+KkQnVGAXyunxfurjh1Xoms/ed7L2wkaACvWcm0ziDHTydJB9+P8BWXkDZ4fkkPW6XoNTXHc3l
	FoxPColvRge8ZXaGOLBVpwQ/2aro6ueQJyn+W3CaoUw5Ur6Kvkdi/m1UBFsJ2+/ZoYvyEB/I/GQUA
	YXeDpO75eqHK5g4U4eCJXO+Y+N6zxPoq09unu50xYCXbhlNlLmUlksZh/tdGPecN4aXe30RYBndZk
	vEXFdM6GxZjqq6tcW059ELvtkePYlSZcgmIhhgUM6Nw5xeiBxgikBW2CADNk8RqKNlXFJbgWeNA+R
	YlE5xuyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5FbP-00000000X6w-1Fce;
	Sat, 12 Sep 2026 04:44:35 +0000
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4lqy-0000000FNlw-3FBR
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 20:58:41 +0000
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-6b1b766bf01so199931eaf.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Sep 2026 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073919; x=1789678719; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=;
        b=iAaD+zpQiPtHXi81k2777BnljqhRtrNgIQFKBX5y/TUpTmLxR2SL3xl1SGqE7+mrbQ
         QwQ3dG9nAXqcqy8DfCzRKMIUS7O6snn0zw6Kd9FK1fcuFxVkCo6Caeivg9sxoFKmg7mZ
         PXRtmXI4Z38WYq4xF6Sej0iLPmSVgAdse1l9pOSKsUbkgIVbDw9aITzxOYGX0ZEsB70c
         eFqU0VxshMtgtNHg+3HevDA/ypwvX4smS6O7DF1KFf1GyI3yb+SXrTerCnY9j1IThOCn
         8F7XoaVf+CHreYzZc1g/h4uPKfxDgOuzaOMF/D2SjDbHwplXwUERNQ8cSB8SsciQoOr8
         fBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073919; x=1789678719;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=;
        b=JtbUWtxdVqq8/7owBTGQsoLUT+/ONu7+bJlVX3S3vXvSrJRk07D4p9rtjzzWfjCOY/
         NoyH3h69wzT4DkLKrXda5uBgc9L8eL21my1QsnIHJRJB5y92sK3X7o6Pc/jcTWvg0e0E
         rBW1dumIujAJwz9dhTaF4HFXzVLonGayhetqkSJ92Cbb4SamB/kU2Qv9AJ1iM8KZCKin
         oAz43FWU6SOraA+WNCVncmY7cnQ7srtF844pCtdFtXDWe8NmJ9UQz7bsgXOJACLQ43Sv
         WrH5vgojrAYFxWYqWxcG3idigVCSjK3HaZYVwAQFG9PcCGoXRIph49jTbmEIEtIQGEXr
         gjHA==
X-Forwarded-Encrypted: i=1; AKwUvBzHqV8W/LPKRZqbdboSOeuFcbeJ1sqUOb8KABkWHXX6rE7PADGsP37itv07goIgIoMg664DBWeZ0i50@lists.infradead.org
X-Gm-Message-State: AFuF++natjJscGJapvIfgLrSPuDzAUvynpIm3qy+hr2k9vN/uoFg65Hd
	Es/Mh+Bvx+VmTIGjKNXdSYsXU/X7DIRFnh6QWTNdZYAAkZoyfLvemDfq4qHE0kPRpBQ=
X-Gm-Gg: AYBFou1Dbgzvi7+/JkTVHhtqgqMw2HoRkEFId1ZW9SkNh0un1jo00VqSYZQ9YXGAZxh
	z9HG6UX4iUJTOmw8tezHV+Csx1suod0Z9RvGMKW8/o5aI0XOskYVyAU0vJg6FYS4swLRrQOro8S
	BXgJyjYfD9jzAsbs7+KEB5/ritZlFIjmjt0v5Yk7P4Kpv2n7GWFPxmDoFF5XLpgDKddCzm0kc4S
	HkYLxW0khfxNQEzKpajR7T5A2Vb6HL7+1tsqaHo/XZn0+ZvMjGlwYX1+9KxqyvoOPpOdQcmtKyP
	T60p7l/GTfXKrZlhENHYITr/acEwQ1dTsJY1I/IwHiP8t29lzlKxkoRH5RGzRBF9dUlGsfGgKTq
	/yGGWvUJlhBxb8G1O99Hr9J4w76TalEibxZCakEY1CEUfhgtbTBGnZRGMdNUOi5NNkwRW2QObBf
	E1OK2M+EA4g03VMEf1aPpKs+aBvVM+NBFRc/VT3eM3ek+JdnYzb31qk1ayr4I/mZJK8xsAbcxxy
	8mDH26J1M8yptpAW/EcnuFzxmBr6fGVLXfSW6qGcFoVW85Eg+M/2Sim
X-Received: by 2002:a05:6820:3411:20b0:6c0:5630:bdef with SMTP id 006d021491bc7-6c0bd97850emr353461eaf.67.1789073919642;
        Thu, 10 Sep 2026 13:58:39 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c09a122443sm1108879eaf.9.2026.09.10.13.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:58:38 -0700 (PDT)
Message-ID: <eb469580-509a-4895-a819-e7f3e4fa0b0a@kernel.dk>
Date: Thu, 10 Sep 2026 14:58:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <cover.1785596451.git.asml.silence@gmail.com>
 <178907372259.484803.15807864431748251506.b4-ty@b4>
Content-Language: en-US
In-Reply-To: <178907372259.484803.15807864431748251506.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_135840_828703_64DEC243 
X-CRM114-Status: GOOD (  16.42  )
X-Mailman-Approved-At: Fri, 11 Sep 2026 21:44:34 -0700
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

On 9/10/26 2:55 PM, Jens Axboe wrote:
> 
> On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
>> The patch set allows to register a dmabuf to an io_uring instance for
>> a specified file and use it with io_uring read / write requests. The
>> infrastructure is not tied to io_uring and there could be more users
>> in the future. A similar idea was attempted some years ago by Keith [1]
>> (from where I borrowed a good number of changes). Later it was brough
>> back up to life by Tushar and Vishal.
>>
>> [...]
> 
> Applied, thanks!

Eh no it is not applied, was just looking at the series locally and I
guess it got added to the b4 ty pile.

I am, however, wondering if we'll see a v6 of this soon? I had some
comments on the nvme dma mapping, that can be improved, but I'd rather
defer that to post getting this included.

If the series is dormant, just let us know, and we can pick up the bits
and pieces.

-- 
Jens Axboe

