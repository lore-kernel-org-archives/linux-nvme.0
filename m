Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE66CA5FCE
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CiogbugpChE2nuDY1/c0G9NHgdsv6JGGhiKd4//mw4Q=; b=2Y2s5/1EhUqaCjokP4cGSiTEVd
	M5cl6hzJFWW2++2q+YeJZQwRaQ1BOv2nDS3bMkOF28eORb/3xL/Og/wM8/b8lFfm+UhQTToDC0mMJ
	pjSIX/vSk9cJFgnlHKZv3q5n8b6goiDaLytJMtYh1uinw71nrRS9AsuiY0gEx52SoqgOCLA32GI4h
	dNjweFCAWe2V1QQnyAPjHbCga1IOZgQ0jc/3zjSas9fXUDwKiL/nt3r/Und4RkqfkMaS9khfcG/MO
	DFTz++ZvywnU2M5fsZYkU+VyOl8fmQ6sR4M3Bc25qA2LRO1/W98i26jQSRpkXhvHiK+kyRF3IECXn
	UvZCREAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDh9x-0000000GMGt-1y3z;
	Mon, 05 Oct 2026 11:47:09 +0000
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDh8c-0000000GM9q-1OZO
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 11:45:48 +0000
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-482f6351831so799943f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2026 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791200744; x=1791805544; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CiogbugpChE2nuDY1/c0G9NHgdsv6JGGhiKd4//mw4Q=;
        b=g/JzrWpEDk1nBkQKIBJpa/HHVRe12jKL+yxuCzWdn/U0SMyqTMMOjizGFfuOlFdzw5
         o+K0bwpTIU+813KQVCTuIKqujyqkE1+7Rmig9HaL0xS/yoq7R53DyjLAaMu9n3eCMrpA
         vMkwdQRrxeOBpxTqXsfiEqE+i8NT1fgeeMDRaMT0Yk/RBsPID869E2RhShvn3q+f6/w0
         KxKNhnxsyFQzyvggaQZuhod9+wHKiy3/EeMKpsBeO3yUHJHm83aJRh0vKnkYhWJETUia
         DJyl7jhkSeELp+2aDXUZGNFfUeAPjs5RUTDDDvbY1yhlgIDA1vpooArZUEM3IKPdykF/
         Mk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200744; x=1791805544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CiogbugpChE2nuDY1/c0G9NHgdsv6JGGhiKd4//mw4Q=;
        b=xh4lR5u8JztjR1b76ZkUkkgD9tE2R4nP7qCjmHtfQgtQlwMchZlQHFhBc0rGEf7AA1
         fKynJeW8kZFA9LnHqDIFsxvKbEoh5bIqlKfYa43fDckC4IJWGkN46F9ESb4oJY15GEbW
         9JXt70mXGYhdnh/3wGiIce0mggjUNUNhXaFLNdK0wxNgln+uRrwOL8tNBLZu5pIY6dIZ
         qlUASgBkJNvsyGBsSXhpZNbGMD5NYeX3yMFDS0b0jb2iMx3GJut1vdvtQtqXD6bBG87o
         DTrCn71vQ7cH9rlDcq3KZ9VsOyj/RCSWb/E4FTtu7kfHqiQG1X0xsiIG7I8ZBEXYtsRx
         ev/A==
X-Forwarded-Encrypted: i=1; AKwUvBwb2jtuBI9UhdOiRWtzR3JeG5SDdx3AJUaeDmmWyfPY/78FJ6lFQedvSMAC9koJohuV0tQa5kNvmdwA@lists.infradead.org
X-Gm-Message-State: AFuF++kofx8bq6HgbEfnirE/UKOkb1OUZP0MdhbALKwzKoEPQt1ntBl0
	hKcK9nkoNs7F2r+BT9WBM9Bd47r3u0k/SwilJY2lAW6GTywEMPI9SsW0
X-Gm-Gg: AYBFou1mZQumHlCcbQkbR8PIUlMml/2iwacwKH1EosWM4Tr9llKLcmiY/qRQk0jJNsq
	fw364FV2pmdnD9PRHorT3XtQZxp+wk7NP47SXfL1ReMl54ckVj6nzVbQ3VYNSR14vjRlUuLn7QU
	hHZN7/CK9A+nbtp38OOxKVs7bBLwMAJU+2yAXw7/6jjV9caDIRLtF5fW+PELxkl7Aoff8EJEzAP
	1VxESweedhquUib/cUip+Si3yHnD6Z/gi9JkT/FkVZdDOYAr+2dBnlLaaf0TYBNzdHBffMhK65C
	VuQ3MBT1l7Im2G+Pa7qoQLkx6OONqXi04UjCHR17KGEVwZJK6Pol7FQCLDQBHKa8CouLkkDzeSD
	LZSdiWzc2SjDgrjcb79gYzUbuvNm76heK3h76rPlBaXZQLDXHly29eA6XdQy3wbUP9fPMtUoRZq
	dZMoH1jK0VZBGS4d59LuRzvjehgzyvSHS6MYU9gaupf5GZgewA+c6uBQ98BJTyjBRGCC4FYhbP9
	GMoGLjy5zvvlGK7YnraIdL6m8VtBw7eU/GczPJRLr12vIHrnU+NLEUAmIhIVn2vH3aqfjjpJo8=
X-Received: by 2002:a05:600c:c165:b0:4a0:108:3b54 with SMTP id 5b1f17b1804b1-4a02758e674mr183842705e9.32.1791200744219;
        Mon, 05 Oct 2026 04:45:44 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027735be1sm472096485e9.11.2026.10.05.04.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 04:45:43 -0700 (PDT)
Message-ID: <cc7fb229-7e6f-4ccf-bea4-864ddbd36a02@gmail.com>
Date: Mon, 5 Oct 2026 12:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
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
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
 <20261005091554.GD10727@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005091554.GD10727@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_044546_391936_7FEDF72B 
X-CRM114-Status: GOOD (  13.81  )
X-Mailman-Approved-At: Mon, 05 Oct 2026 04:47:07 -0700
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

On 10/5/26 10:15, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 02:32:22PM +0100, Pavel Begunkov wrote:
>> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
>> +		struct request *req)
>> +{
>> +	struct device *dev = nvme_dev->dev;
>> +	enum dma_data_direction dma_dir;
>> +	struct bio *bio = req->bio;
>> +	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
>> +
>> +	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
>> +	dma_sync_sgtable_for_cpu(dev, map->sgt, dma_dir);
> 
> This can use rq_dma_dir in the argument.  Same for the other DMA API
> calls.

Will change

> Btw, given how larger the dmabuf code is now, have you considered
> splitting it into a new nvme-pci-dmabuf.c file?

Let me see

-- 
Pavel Begunkov


