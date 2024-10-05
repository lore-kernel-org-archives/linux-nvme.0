Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FD9CF8868
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUj5Q8Oaq99Jq3sBB6jeIQ4hAZm7itRv4sV13fDobkk=; b=zout20xhQ/WViw/R2jJlQWBLt5
	Xf37K7q1FHLETnHPnW5buxk03Tv+e0xHbfo0Ky0+TSG0KKU8MWO7TPUrTgz64TvsbyzTF/BsCnI66
	2KhpalYZk7V1AbPkypdt4zo37ih/iRlRNwW+FZyc2tL/5pQRIKHSOMZ+gTzJ+oW3egCA9HauoYn3u
	xdx98iq2NCujU6nbul1UhX6juyVdUAsRLVojr62r0Q52ZZ2mdxwHoTIpKXqAdiL6xv58ce14BMCQV
	eCqudvJ6Qcg6TbuHAr9aXZHDWfXatGrDaDvIyvrkAJ2gjpjakoak/UyMJS+Rs3D3qhyq9D5WrHQsk
	6R69umYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swtnF-0000000EbYx-39bs;
	Sat, 05 Oct 2024 01:41:13 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swtnC-0000000EbYV-4Bwe
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 01:41:12 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-7e9f998e1e4so134141a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Oct 2024 18:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728092469; x=1728697269; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IUj5Q8Oaq99Jq3sBB6jeIQ4hAZm7itRv4sV13fDobkk=;
        b=QXam70w3zMNsqsP2k99rtZiPTbon91+RsXZI9imSFvCJvQEw9BU29eZy4z0at95TE3
         hqmNP/6bkEG7ZvrGoc3GMx5+Tf32PwUC+FaZ2olVhw/3iCrpZMSY8PV4LOIlTu5sRKNn
         QC+an05NY9YATUi6pH48q5JB2VgHJxUauYAkzU4oPWoiH7yj3//8ScuvJp84UZV52Ohg
         r9QdzQfT30FjmxjAz+/4vrXcB8YSxbzv7sh1oLErRnXjt1X3yPPexNwUZon1DQAU7DO3
         5fsoO+fQGBAkZyJok5QxXUwG+fJr76dOiYSXHDqpVFzMeXMvNd/IoUr61MKmIWjSGEfH
         2Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728092469; x=1728697269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUj5Q8Oaq99Jq3sBB6jeIQ4hAZm7itRv4sV13fDobkk=;
        b=nY5c7i0cJp6cy20Q8XVVMVP0avxVv/2M/smGt6+1/4p3/Wi+OeYRs7Nl9289uDdhzU
         vCU3z7pMlOiEZE/Sz1KDV4WyGJP/NA2n7leNYi0NF8wb6TLWKcEa66v8yAgKUVBuLpxz
         3EwqRGNFAhvq0WYmPXJ7HyHzkKRr29TPHW/nKRxvtGLJGbLS1djuTonHEdhQgdEZV6PC
         qZ1nMMsE53CEj27zQE0Xd1OHVS79/7wwb+gvrSHeWq0tdkcCGFRqro6cggHG+xKfpJJD
         ZPPdTu5UkwSd3LltD+ObcgbgYqxBhPzcetfSFXkXP+uZdgUOh9BAPJ4woA9MAvvC7XlS
         vB2A==
X-Forwarded-Encrypted: i=1; AJvYcCWfrNa04JP9mvL5HIz87muBJiIylek+WV383oLYTKGEF3Y/98efR1x3o5eO48rmkn79PNElyTt/QvTp@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1p+qlHdzUWiLj0j/jBeKJ4ZYFV74z3rTTYziEihCvktWNPnS8
	U1ZCOE6IutlxZhJB2pvb6gtTC2gmrSbEHzRvjTGtnzXvBCDkc/xEWIfPvsnJcuI=
X-Google-Smtp-Source: AGHT+IHvZWO7L9pO25Kvnfy0cJ2v4rBQB23dVFBbTWYiGKsJlCF/PSI0q+ybt7P6TqG0rO3g149Q5Q==
X-Received: by 2002:a17:902:fc84:b0:20b:a6f5:2768 with SMTP id d9443c01a7336-20bfde650dfmr59873175ad.10.1728092469699;
        Fri, 04 Oct 2024 18:41:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cff51sm4634235ad.87.2024.10.04.18.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 18:41:08 -0700 (PDT)
Message-ID: <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
Date: Fri, 4 Oct 2024 19:41:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
 <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
 <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_184111_075896_8CC43F79 
X-CRM114-Status: GOOD (  13.59  )
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

On 10/4/24 7:26 PM, Zhu Yanjun wrote:
> 
> ? 2024/10/5 0:31, Bart Van Assche ??:
>> On 10/4/24 5:40 AM, Zhu Yanjun wrote:
>>> So I add a jiffies (u64) value into the name.
>>
>> I don't think that embedding the value of the jiffies counter in the kmem cache names is sufficient to make cache names unique. That sounds like a fragile approach to me.
> 
> Sorry. I can not get you. Why jiffies counter is not sufficient to
> make cache names unique? And why is it a fragile approach?

1 jiffy is an eternity, what happens if someone calls
kmem_cache_create() twice in that window?

> I read your latest commit. In your commit, the ida is used to make
> cache names unique. It is a good approach if it can fix this problem.

That seems over-engineered. Seems to me that either these things should
share a slab cache (why do they need one each, if they are the same
sized object?!). And if they really do need one, surely something ala:

static atomic_long_t slab_index;

sprintf(slab_name, "foo-%ld", atomic_inc_return(&slab_index));

would be all you need.

-- 
Jens Axboe

