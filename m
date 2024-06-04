Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA07C25B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jT03552+joJgoqrGEVdI7Fe6g8UVlQf4Q+uQisoEmo8=; b=kqCX1/7hywsyutnR+DMrZWtsiL
	eQvFu+lSXPk1wU2OgwBBjRz1UhxmnOQcgYU86vmflEmdbqneFLqq5TZzONuKp9plCZQTiegAGV1bz
	9oJDrRNMWxSsF20H8PZODGPtkhk86yZIjeF++2YcNxhjGJWd+lAd4lDxs3ASsHUrSTqfaaJtEhD61
	V0eJzxrqNS6JghyT2KSRMQthArtNsoHCLrhLE7hs2ZjB1d5GG+xfPj/c/+RxFIVbEj7dhisKROSKs
	hj1YAi4vgiO84jfFx/+8qplunbLJtgbzymPdFsY7r7HRxjN6ga0qE9QN3REKbxNzi//EziPknNdtS
	5hr3JYtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEPTW-00000001fV3-1JZ6;
	Tue, 04 Jun 2024 08:24:58 +0000
Received: from mail-lj1-f172.google.com ([209.85.208.172])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEPTT-00000001fTV-0Qs1
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 08:24:57 +0000
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95ab5a45dso6556331fa.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Jun 2024 01:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717489491; x=1718094291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT03552+joJgoqrGEVdI7Fe6g8UVlQf4Q+uQisoEmo8=;
        b=dDb6JIsbz8ueBU849PFeziDpR0kHuazQCWWzQCUXEIMfohxJ7jQ6475baN7i4cvsBH
         /Z4tniY37yJ37LInuh1IhusI1pwx7fBdqqGMsd50kStLarjyAAVn9/UYliilcozlAE2E
         TbRe+ii0Ro56Pja5Pxl4dHDkgxBDQFtIhyyZx4AjqF/E/zddmcQ7nSHkJYAsa4ibqPYn
         0O6HqHJuB4wNODkSZENG5hbEfzQg5x0Vu9NF5HG4HY/u3BSVhdYQhF6VwNWeADgHpvoQ
         nhwc6klwR3IwJg1ixajfcY5EcxF0dyarvoPKi5yPPjZut1buo4YdvVY6JIjkIn8kcXIr
         NfIw==
X-Forwarded-Encrypted: i=1; AJvYcCWv9aA6skl7RVJhAcc+YU97HHpQlGxm+VuIgXzsnqGaEzgvGJhUjZ9qbmUQ+5/Zq/QjTgZAxqftc0j070gFy0ydjeNmTicIfzfQ9U6ou6U=
X-Gm-Message-State: AOJu0Yx0JpYpUUFdVEzThru8Qupjk/l4EWNQlsigbmoyLr/tZqYu3tD4
	nD38er0BfNvN84C8d/uYkmfvxOgXmtsUAk74A+Hb7XQ1DamBnXIA
X-Google-Smtp-Source: AGHT+IHuXM2IV1Hvv1yo73FAtyZR/fINFEtA7+m+S0KNoMFYIA+FZgsSVFChErK9dkk4AU6gDb5/pA==
X-Received: by 2002:a2e:8756:0:b0:2ea:8442:2096 with SMTP id 38308e7fff4ca-2ea95153f82mr61441631fa.2.1717489491014;
        Tue, 04 Jun 2024 01:24:51 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4214186ccdcsm34884405e9.16.2024.06.04.01.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 01:24:50 -0700 (PDT)
Message-ID: <62c2b8cd-ce6a-4e13-a58c-a6b30a0dcf17@grimberg.me>
Date: Tue, 4 Jun 2024 11:24:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: introduce helper sendpages_ok()
To: Christoph Hellwig <hch@lst.de>
Cc: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
 edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
 <20240530142417.146696-2-ofir.gal@volumez.com>
 <8d0c198f-9c15-4a8f-957a-2e4aecddd2e5@grimberg.me>
 <23821101-adf0-4e38-a894-fb05a19cb9c3@volumez.com>
 <86e60615-9286-4c9c-bffc-72304bd3cc1f@grimberg.me>
 <20240604042738.GA28853@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240604042738.GA28853@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_012455_178555_C39D830F 
X-CRM114-Status: GOOD (  15.13  )
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



On 04/06/2024 7:27, Christoph Hellwig wrote:
> On Tue, Jun 04, 2024 at 12:27:06AM +0300, Sagi Grimberg wrote:
>>>> I still don't understand how a page in the middle of a contiguous range ends
>>>> up coming from the slab while others don't.
>>> I haven't investigate the origin of the IO
>>> yet. I suspect the first 2 pages are the superblocks of the raid
>>> (mdp_superblock_1 and bitmap_super_s) and the rest of the IO is the bitmap.
>> Well, if these indeed are different origins and just *happen* to be a
>> mixture
>> of slab originated pages and non-slab pages combined together in a single
>> bio of a bvec entry,
>> I'd suspect that it would be more beneficial to split the bvec (essentially
>> not allow bio_add_page
>> to append the page to tail bvec depending on a queue limit (similar to how
>> we handle sg gaps).
> So you want to add a PageSlab check to bvec_try_merge_page?  That sounds
> fairly expensive..
>

The check needs to happen somewhere apparently, and given that it will 
be gated by a queue flag
only request queues that actually needed will suffer, but they will 
suffer anyways...

