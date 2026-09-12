Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3980AC88E5C
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 03:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fAOw7eoVc0zYvL/f6e+XZRwdegk97u7KcjQYPN92otE=; b=j8y4Bi0Uopvp5cxDAWeyfBw9Cm
	MMKbSER+T+r1QBr+T6b0mifbElfbIq4HgWYf+gdUq2Xp+0DTcDAi0qcL9p9J4NjM/+/zADWh2g1hF
	6vkf/6SW6Eq58ueoYVLfG9vJrRq+lbEQwQ1jaYt0aWsUyPNMkv+TrcTPqZbXYEZ3VrB5gZYIdVaIu
	vB7AZU+dZOq+ZTfF5HMeSUEwRaaz7RoHKEm6eh8ewHkIZnQWkKMC3J3hJJIg6C9XkvE8MKj647B94
	XUYlpSztEzeE9z1cIFthzyALHs+6I/14D2nssdC4WC3SEgyXvTj3c07aIsIANKqdWFAtiYgZs8Cqk
	IjMQy9vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5xAg-00000002Fg3-0pqs;
	Mon, 14 Sep 2026 03:15:54 +0000
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5NIf-00000000tEK-25uO
	for linux-nvme@lists.infradead.org;
	Sat, 12 Sep 2026 12:57:46 +0000
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-482f6350f88so229098f8f.2
        for <linux-nvme@lists.infradead.org>; Sat, 12 Sep 2026 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789217863; x=1789822663; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAOw7eoVc0zYvL/f6e+XZRwdegk97u7KcjQYPN92otE=;
        b=JtdLo6XvrmBmhuHfJdtfCC+V30+Nha4OP33NKmOqyd9TsbM6/CyeFu9udaUMs71V5p
         vtOE5m6uSb4ous7snrZMdNjGKohtluED9ZwBASmVteN/rT4Twq2qWWfQ7cuPX3P83OuC
         QmUPOyltbMLrFNPVFGBHcSLV0JIZPxHwwotsgyUG1oOEKEXojGcFBkHav7wtnFw0XoJY
         /2s4aMIH7v7/lubXz4rviZoaqw0hdowS1/RytuZ3x5QyLDuwM6VUKFaMN6/Cv/lfc2zE
         JK9DvN5X/S0vmepvY4CY3bvxwola+TvAwKaem3UwI6MBHYoOZMkfYnpMFp3gRXkcnM0B
         ZBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789217863; x=1789822663;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fAOw7eoVc0zYvL/f6e+XZRwdegk97u7KcjQYPN92otE=;
        b=eAQHXITLcufzVsBdm70mJz5HxEFQ4wQ/HCrgN6aj613ldHSY14x1xkIFFY8mttzqNF
         B0fZUXcuTGgMhiKSgXWQPVaHjHS6oGRHWqBFDYHUyLV//Rsn2OtaZh2Yuup4LVqrOyso
         jIped62Ihq6txUHMiNXlAUTgBGuZp/a1bz1hVi0Yc88x3V5ivSm/679QhEaWL0gkVU/H
         M6G/dme4HlFVPf38pt2zFDiUO3e0SjLn5qNPK3rnb0jvrQ0HuwJk5HJ2xOZO5P9UokAX
         2uT886IqiZsCQO/rMleCftBRBEgG52dpyd/gKoZTOQHuPtzENdtQrjJM/h3U2umFMU5Y
         8A5A==
X-Forwarded-Encrypted: i=1; AKwUvBwfnyZtsoLJlb0kvB5KJLOn3cr5tLsacau5pyenN47+xJoF/1D2/jnNdS/nGK+RY4Abc7XnVLxvcLqF@lists.infradead.org
X-Gm-Message-State: AFuF++l6/c9zEkdOkdlEHOOoRsaZhmGeHFHjr6S+JTbUZkhe1Bn3+tWm
	GJI/RAu3yV4P8ilwUXAGS802jgXLtPMUlYARwuM++188fiHez+N8g4a9
X-Gm-Gg: AYBFou0LVnc+aN7kpHJAqW93PLxqPjXYUwDnX7iRN+ZMHB8h1KrABMyfYpwMWkkziSR
	45HQxG2B2wKwZr6auG131gU6AU1UbiNbTKAQGzViO8Ix7NbtT+Z5OBuSnK7ZFuorXHUoqmBaC0o
	dmZnn18eoFe+ig2Kz2iB83gMDi7FWrCBgrpKeMGafEuVFn/0Wbx5dBWjzYVBn404CFk5p/Ty0kp
	B4PyO7dKN7ZQ43hfbqooYiZxprqxF/ft6huhSRGwrgRqxqh2NRzfQ0VkaPobsZ/1aCtgqLB78BB
	JHtkTqE2sDBe7kuqlJH7UfNc5a2JLeoM1r96Sg1KfjlCdWlhHaGgiK+OoS/apUNeJA+9MIOhdI8
	o1VR4YqHhCktWoLRhRvbrksp1cB6AvSp/EQKb8IsOw2Ytt8tt2JPKnrJIydWU7JGOeYhU91zVlr
	E7AD30k57L8jPzi0FCtE9gDX9Z00WUEX7M4NnXwh66EWmXmKmd13LBXPoryQHW/HiW3gMozqEnI
	XAv0LQjIrJTnjMZuYm74+Su3492vnLUJlBbiB6elAWSJ9Vw6BhOdH2xo4NysQi34OCJJ6Uj4ii3
	4YW6AcSrxyJtTz3SBRjgj+KvwEw=
X-Received: by 2002:a05:600c:6812:b0:49d:1d7e:4085 with SMTP id 5b1f17b1804b1-49e6cbec30dmr21535245e9.22.1789217862965;
        Sat, 12 Sep 2026 05:57:42 -0700 (PDT)
Received: from [10.192.161.217] (82-132-213-27.dab.02.net. [82.132.213.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm12751635f8f.9.2026.09.12.05.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 05:57:42 -0700 (PDT)
Message-ID: <0c787163-dd07-4389-b9d5-916b8753f388@gmail.com>
Date: Sat, 12 Sep 2026 13:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
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
 <eb469580-509a-4895-a819-e7f3e4fa0b0a@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <eb469580-509a-4895-a819-e7f3e4fa0b0a@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260912_055745_563546_B7907A64 
X-CRM114-Status: GOOD (  16.15  )
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:15:53 -0700
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

On 9/10/26 21:58, Jens Axboe wrote:
> On 9/10/26 2:55 PM, Jens Axboe wrote:
>>
>> On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
>>> The patch set allows to register a dmabuf to an io_uring instance for
>>> a specified file and use it with io_uring read / write requests. The
>>> infrastructure is not tied to io_uring and there could be more users
>>> in the future. A similar idea was attempted some years ago by Keith [1]
>>> (from where I borrowed a good number of changes). Later it was brough
>>> back up to life by Tushar and Vishal.
>>>
>>> [...]
>>
>> Applied, thanks!
> 
> Eh no it is not applied, was just looking at the series locally and I
> guess it got added to the b4 ty pile.
> 
> I am, however, wondering if we'll see a v6 of this soon? I had some
> comments on the nvme dma mapping, that can be improved, but I'd rather
> defer that to post getting this included.

Working on it

-- 
Pavel Begunkov


