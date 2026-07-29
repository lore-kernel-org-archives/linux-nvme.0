Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D18C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=; b=IlrUZkGwusDdYEEuZ6lZnGeKZV
	g7QGF1mGrQNs67nDMteKuRozkACBu51w6XwaqDA1f+JKirngM+ySfHF4ynmNLqUQlm94SPKKvQ2C/
	Bq238CCVXfxWU8Af3H61uyvgUDRxq8NcDN4JAdUw9HWelesVGvRHWFRERrsWqVczhLX3YnDkyjmTa
	NXPn/Svj3RyD94PPbDWTYyy3dPlTCUamPu2J1QJYedYl3CRPAhqnHUw6TmtDEl1alyCHoP1UgWsbN
	rUTzQm1xPC9Z4pznTCT9K27mUH75RLajMYgyu3LDRFrnEtpq86aeJsdCjoUMCmklvFm1a7X6iY8L2
	kiY27M9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp24r-00000007fzP-1E7j;
	Wed, 29 Jul 2026 11:03:57 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1ie-00000007ZVJ-1gtZ
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 10:41:01 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-69ffbd2a277so1212889a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321658; x=1785926458; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=;
        b=D4TrxzfuzCx8nJDzoj2H0OncXHq9KtIGHj2dP4ZF/Q+BiwA11WMeDRm0hzrjscEj4R
         tZYKpa71KekKLQSbUd47SOWZJOQFF0MatIuRAVpZkOPpTvhkVvGSYNs50WlK8jOW53LR
         KYE1JKvFA7SSGrgN7NXFIkyGGkOQP83iwg0LRvIqgNE5NIqeKPZMfavfmqCQHSb80gmP
         Uf/KBozUlpy8L1E68eVKtjJhEXAUoWtrm9R5Y5fBBuZVUIi1TgqTGLm68eEYDg8kPf73
         u+uRLGlzSLqpZiLg2HdPi2Kx/1oj5wDRjbOTvOIzRS22GxrVPqZGxJHXkQce36FQ7yK2
         WxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321658; x=1785926458;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=;
        b=VAMu1k/dQTI8dbGfovqnmWcWOvPZ2zSRNAH3NImjtAgfSxzhuTmQg433AlvhEAo3vN
         I6KjSvxk0dYth8LXj/EDP0C3uL0A6LnxEqfrGnehjWrPgMDFZz0E7J92cheNJlo+Y3bj
         wmQ6VaPTMqyPUmZ5hjvaTsubSHd0165fHl5N44YetlO9BiO4PY0mrquLVN9Xgj2OZfDd
         WrQcwhD+FBHWXE9EXODByaa/ODD5HOsEFPUKiBveTyF6X3ISZg2RiBWTpbKPzxdfJa0r
         weL3HRLNLONlf3VHDwbLXc/IzEHJhT5vc7bEoN+lF48A+TpLnMDPJoKUGFAvwYKP06ej
         5r3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq7vNQKs4be18eTen9aa+aFmpnX37jmKKbhS0Kq/zDxdHr0N81ej9yneG4d8Qoc0UlUSASZa8FE9q7p@lists.infradead.org
X-Gm-Message-State: AOJu0YxBZN2SoWDVSF5IFMSaKInP+e5Ls8NkuLafzCiWVeB3FuK5gHjK
	PVhs39jyN4dtVIPk0PfK3oWo1CqcxkgEe1b7WOPrfjMYU+k62lB5SiTk
X-Gm-Gg: AR+sD10PxzRvTyDqrLIjNMUcnq9HsPSTM7duuEShFm8pxwjPiNV14lwzAQfLReSjTPJ
	+CN4jOsElXTJCNotSYC8HqrSUAYQ0FeGSXxOglGseMwXlw2dqfmFtyveExQGjOivTwrezMSvkBM
	6yL3PK++DZPtUweZvo7kis1rT+KjaYbfptyPqc6ddDN9N57AZgw03feci/azMXnJ0rj1HT7mg7e
	S/HuDc6vyFg9LS7IZ0wcNmg9HS34KdST957PeYt7sNmbszxqvXOZMbi984MNAlX6OC9YCDTw1iD
	XgTSKK5NG91BMbI7wMdh7aJa/JXjbZfKCvUd2M+rHqzagYzBbLu/8tq4Kou5heYxNHRVuNwlcIc
	d7N4Y1rVvJfmbcuiHugmNSsypdXx/OzJtwuBjlyCnRb6U7tL+0bVFUS9VLDua35MzT0JpXoaQ+s
	qirq5TutApZkCI3CFoH2LNZk2nWxoLJXD9sRGT/xAs3A1XEur0O0G8wX+8I7xilAqKBRNJXpgfX
	64tL2FPA9TKRj4Hkrp8cvTVaTuNkJ6B3xplrsf+ywUDRLiXAZXhIfz5nmSfirtB4SvutDKHlw+D
	+77N1oN0wJxRbIZzuHE=
X-Received: by 2002:a05:6402:548e:b0:69a:596f:ba0d with SMTP id 4fb4d7f45d1cf-6a034a7f6camr3086746a12.33.1785321658080;
        Wed, 29 Jul 2026 03:40:58 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf0bsm661299a12.23.2026.07.29.03.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:40:57 -0700 (PDT)
Message-ID: <7217c204-786f-4fb1-9c09-fc1ac7c8a249@gmail.com>
Date: Wed, 29 Jul 2026 11:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] iov_iter: add iterator type for dmabuf maps
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
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
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <132442812a40277a5904cb2a8ca1e02f4f6e82a2.1785274111.git.asml.silence@gmail.com>
 <20260729065953.GB9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065953.GB9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_034100_461603_D5D11C17 
X-CRM114-Status: GOOD (  16.31  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:03:55 -0700
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

On 7/29/26 07:59, Christoph Hellwig wrote:
> On Tue, Jul 28, 2026 at 10:29:14PM +0100, Pavel Begunkov wrote:
>> Introduce a new iterator type for dmabuf maps. The map in an opaque
>> object with internals and format specific to the subsystem / driver, and
>> only it can use that subsystem / driver for issuing IO. The task of the
>> middle layers is to pass the map / iterator further down, maybe doing
>> basic splitting and length checking. The iterator can only be used by
>> operations of the file the associated map was created for.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,

> I'm also pretty sure I reviewed this and vairous other patches
> before..

There was a lot of shuffling, so I dropped the tag after a 10th
amendment to the patch as I didn't know whether you want to keep it.
I'll keep it all for v5 unless anything conceptual changes.

-- 
Pavel Begunkov


