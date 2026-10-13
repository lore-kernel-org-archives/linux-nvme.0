Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DFECC6B1A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ht3KL+dVHT63kyImKLUa9SErnOvImt82gs/Vf44c6SY=; b=wMQbH38zyjXfGRMpqZWyD/9n3I
	DBKY+MChllJ3qZHxc5Tiv8fPPAFc/1pUk8DePenXzyaKuckSTcEDQX0ovizugwrPLNvJ7rTVyRY6X
	H7zWBNVreGBaR3WqoiD6qaOhG1/X82R8t0QQTEOxzhvSsNOqj6m2VEBYkOXEe2Y0qi5LuVxWAt2Tx
	Wre4R7B5gZnzFjDPdgdH8VCXK3TqCjw452lAW1KzbY64Jp/hNoBpN59siqv9wv7X4u19n2UXGfRmT
	3sx/JsZclxrqos+x88wSbwKoJY4Xn0Lj8+KNKdCi7sFjOjPsNpn8I17cUQcvtyEiWc8QpUfQp0Gp2
	q/grbgcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGii5-0000000Dyde-3BnQ;
	Tue, 13 Oct 2026 20:02:53 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGii2-0000000DydF-1eSZ
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:02:51 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so28093295e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791921768; x=1792526568; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ht3KL+dVHT63kyImKLUa9SErnOvImt82gs/Vf44c6SY=;
        b=Y+OwPqZ+LKkaCT+X5qFpa0Vra51+LElskQZluOzcOmzPOVFcd9g2gCDVxSc3ntOGaD
         wB2L/k+kfJxxAch/0pJKnhMhyv5/Hyibem23g2dOEdl5RuulU+q+69AhfMI7auQuuJEg
         9tH8o2g89EjjDeQXx71GfMDn9yOguWqn2hJ/VbpZTDuXd2649gNmwUaBI+4UDOJ/Yzc0
         fZpV9rstW9ZypBblZBmST/81eLiL8HLExu6i4rTg3F/vF2EX0nfEXnsejQPicvGaFH2X
         VFyvUzHBgSJIptBsGrS/Oq9PtQNnHAyAcUZwcNIDZaAGIUvAFqgcGBNxzU+3hvdeZeIF
         muUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921768; x=1792526568;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ht3KL+dVHT63kyImKLUa9SErnOvImt82gs/Vf44c6SY=;
        b=GBq4DIcfFa6A5zc3tGpLaq3zbMIcr7e//MZx12xAmOCetrTJvwt81Vs1Rv7KdYA/uD
         RHfRGy19MVurBpEGIPgsT6iH2q6la5qR1paXLv2P8BmtoO5LvYS1TAbTPLmGr+lrnQ0S
         7VJDnK7uTyzVueWydaj5Acaw1iZHyP1luUlZovmydoFLai3cxegjLr0I6/CXIqBecyn2
         aN9LkGRyrwLYDJ6aSu/fuV0tqhXg5aF6czCey21AVowSSVpRI0vywfXUD4qQaYZAud4q
         bc3jiicsPoCJSg5zNPmpyACg2Rnz1CpeaiOTQbGroYoDK1Js0G34dCLL9RozYgTCj5M+
         ILUA==
X-Forwarded-Encrypted: i=1; AKwUvBxN44QgBHsByz004o1r6ILfEb80FKZszYPZdu0vJYJOYQ6tutjFWJSg7SgVbTEu1IzCbrsyk6V2cgMK@lists.infradead.org
X-Gm-Message-State: AFq9FYJXdPYXmOV6whjTPhCgjRWxSVz2HTANNSxUwSFKhSTkPvhcKpo0
	2B+iSatr3Jed/R3jn2DA9pcBvfwxnF5ukKkM/Am+QVBSwA4ESASg0dfJ
X-Gm-Gg: AYBFou3D/X3ggc3K3FrHH7BpLSKpwwoS610fmepuFgrTxh5QRs+1iIS9NlQ3OWjCgqv
	XztGsVnkW956NpFt2uT9Em47efg8ssSzL0IcKmxu3lLiLrTWwD7HmbdECq6/WE17fa74q91tjLA
	io0X5D9AFV7GszLo58ILCaXxEhj2l/XbaIitKMlWj/1Ozs2X4JtSXshjlmlvRFtaNYIiHLtr4W4
	Fhe2T9R1UBgeZvfBHrOu33D0QLNRlkdErUXTLhffVyb71ujfK4RmLPljkpMGlK/0g4uAw1wfpfc
	p5tvQyk591kfbaMrPC3cxRtwYlJN/yd3gu4r4LD1AfWM19opLebtydDNUDO13BR5CQWxT3DOWJo
	8r7aCcnwCZW+x+RxkQ8DORehvgUEYtWbdqFnaFWxOjiSKa+AiGSEMMzcHUUUrXwAfxkQUOw0HBD
	7A7T7M9wJEKP6wnDwwJ4VLN1gYLZ3+LXQv3X8K5XGxAuwGRdNmTcZ8/juwjOFzXaL3l1g8/gMnQ
	xQuxQQf/GYw4xbmpjeyi9Qd1GB7OF0GvTXnVEBJC9MDf38zPgdyKk8PYBfWvGtYvhn2XIpsbvty
	btFOiL/sMH7kmsjwkq8absQ2thKRgL/Alpk42AoqIQ5qkX17AJAdCohQOP4=
X-Received: by 2002:a05:600c:46cc:b0:4a0:8b1:f5c with SMTP id 5b1f17b1804b1-4a18e4b583fmr268480065e9.22.1791921767928;
        Tue, 13 Oct 2026 13:02:47 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm384426465e9.13.2026.10.13.13.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:02:47 -0700 (PDT)
Message-ID: <63fa3e64-44a8-4539-960c-946cebc8fce5@gmail.com>
Date: Tue, 13 Oct 2026 21:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/13] dma-buf: introduce initial file I/O
 infrastructure
To: Matthew Brost <matthew.brost@intel.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <b44df9fed6e346110c504ee312bb0083c7e75574.1791336930.git.asml.silence@gmail.com>
 <aszbv7TgDOPHBEem@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aszbv7TgDOPHBEem@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_130250_476706_14AA70B4 
X-CRM114-Status: GOOD (  22.49  )
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

On 10/12/26 14:08, Matthew Brost wrote:
> On Wed, Oct 07, 2026 at 02:42:44AM +0100, Pavel Begunkov wrote:
>> The goal is to be able to natively use dma-buf in the read-write / IO
>> path. This patch adds basic building blocks serving as a glue and API
>> between drivers and upper layer subsystems providing the uAPI. Later
>> patches implement it for NVMe raw block devices and expose it to the
>> user space via io_uring.
>>
>> There are two main objects. struct dma_buf_io_ctx and struct
>> dma_buf_io_map. The ctx is used during initial registration and serves
>> as an interface between the upper layer user like io_uring and to the
>> importer subsystem / driver. The map represents the actual dma map
>> established for the target device[s] with dma_buf_map_attachment() and
>> stored in a device specific format. The context is created via a new
>> file operation ->init_dma_buf_io_ctx.
>>
>> The ctx-map separation exists to facilitate map invalidation (see
>> dma_buf_io_invalidate_mappings()). A ctx can create
>> multiple maps during its lifetime, but there can only be no more than
>> one (active) map attached to it. Invalidation drops the active map
>> if present, and any new I/O request will try to create a new one.
>>
>> The primary task of dma_buf_io_map is to count requests using it
>> and wait for their completion when we want to destroy the DMA map.
>>
>> [un]mapping and any work with dma addresses is delegated to the
>> importer driver via an ops table stored in the ctx, see struct
>> dma_buf_io_ops. Only the target driver / subsystem knows about devices
>> it wants to use the dma-buf with, especially in case of multi-device
>> filesystems or stacking in the future.
>>
> 
> Full disclosure Pavel incorporated some of my ideas wrt to locking
> cleanup which I shared off the list.
> 
> So I can't in fairness give an RB but:
> Acked-by: Matthew Brost <matthew.brost@intel.com>
> 
> For the series - I can give this and I have pulled to code + have Xe
> nvme + IGT setup showing this working:
> 
> Tested-by: Matthew Brost <matthew.brost@intel.com>

Thanks for the suggestions and testing!

-- 
Pavel Begunkov


