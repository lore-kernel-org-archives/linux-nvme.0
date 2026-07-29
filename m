Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E66FC54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=; b=fGUPcDHp9evYk141zw3Zt6isle
	vvqxs1cIY6Cz6Kc+32cIA7nSE7ltWlszOs5bEXdmuG6woNMaJv8rLF8PTJo4Yd3o5dOx+ck5W34tJ
	wXERBlMj7fppNKh3WeDYtQDuYGAmM8u4WKcs4aBCqFjSZxLB8gF47u6tl0eD3hDjOsVJ2zTsu7OUO
	8D654JZBvFYm68BWyIZJtetuLBeDMyWoDrj2rR6HeHYOeKQmn1XmIVJf5ZPgdORPDjwPat3ReC81j
	hHVmhXSFwMhryusXGZcMfYO//nNXcBuYqbApatu9NhNpFplHKKNEVy/5rVXB3s3V8+RkcmdCqxVHQ
	mYh3dx9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp24r-00000007fzW-1fiU;
	Wed, 29 Jul 2026 11:03:57 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1rB-00000007bd2-0wn8
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 10:49:50 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so665878a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785322187; x=1785926987; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
        b=L2/JWzZ9Ng5bTzlsqnsIpDumuCedARvA1A8bGUoZ9UG/8+/q6gZ76mXiBePysngQxk
         EvWUXLvpLEsdJxDHKA1kDG/bl3u9e4WxrHTFgvUWJ8KgmDNdtOqGN3srr04kjk6Ipeuu
         gimaVQyjqceYzr9S6Cfr4GEBg0mty7fBra9T9MBqTOkrttUpAUVD/0KHF5cKPtzOTFz+
         AciTOkoOudtfAeRuH+osurrKEjJBzh+WE7rrYQwvQyiyCmjtsRrAHzWfx64q3aGz1Wg3
         aZXqMP/BvpIGQDrhyo++nLYYsZP5YwGz4Qu4mGjepgk/wbP03TS2zgpCmLTs2lNX5TgQ
         9FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785322187; x=1785926987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
        b=GymjfL4YewS24sUFjGQV8ddV/mYEg7YyN5X0k2IeXwNNwzJRtZ22U99a7I5gz+zRiH
         zQvXKT/97OK0ASYE/5X2FsIGqcT7ulJ6H6cwOCT6OLXYcuByWnhxUt/RxMyn20PWqNxs
         A3Zh0/1BGYiBHQ7hAt7TNN5ZQtK0s9788lz8YCyt/5KMHp8xszbUb98KJlYb5bymF/Tm
         bAvgLUlgsv4EYqPhjDd5IyWm1JWHrJrQ9jURJ6VIGslOlMQBRD+AKu0hdH0WifJELXoa
         c6n0WpsKzEGyVn9KVJ5PA4ldeiYvdetnyxgcob4f5+yWxY9VhxeYnvFt33C/OYQkvqVw
         vbxw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7cxkoJhvO5N2t7Jd7XdyAnBEZrXO3yBdUtHhAzwEZsfDJOzn/K7kqozwjx3HQDisJJ7Xk64ccANoK@lists.infradead.org
X-Gm-Message-State: AOJu0YyxmlcranlBEAr7cFsTVYwAIi/LjR91wXDKbcIlQKP3Cgdg1OEQ
	+/9ozdjfQqkyctXGxXbXNwXj78mOREXojg9f4yZwxQLuY90hISKtBwBk
X-Gm-Gg: AR+sD10T85bcunyk6RhEttn+7yWQL0WTabtnYDMHdxG3EJ3Ckv1fqfqq8DVj0VJRk3z
	c3FiYMXnbIID7HrvpK2Drb9ROjhfjZbXSv2opo5RuNU6uVSVVm1CqhwUvfayBYA23Ec1hCLHCRT
	zhPEoHco0ZIffmk9QmfpLSRpa3JpVQUzvZmwk4/rmGokY9Fc6ZkAgjzKmAVpt7ijVx/21Y/yYS3
	GRplpNXliV6aWuawo4HaxflQECJaa0fE9Vsy8wnUqfwUG1821PjunpZM8tOwCFzVfnF7XpqV6L0
	YCxLWxUUzvpX2SRQ1x749ZZ9pr9stZmxyJqS4Kle8NdYS+yNx101NrvsQF0c2zJXvKOKGPtAJth
	olLYPc0JVXNXdSr9pumRMEwcIM0ZS7VYyJKS3tgxdO+0LAorD1thLMh7epLlcCdlDYGO1bvJzQa
	JbiiXINVSDwQCdpWbqloqQKIabnT5S/5RMFaxPzK+F4MQO0CQPWBE7/AKwMp+rxoT6LH1tsCO+i
	2fXDNzUiIFvTukXpduyL9KdjRQU+TaKVAjiI18Tn3lqm+chfpRBMb7rXq+Xs8s4ikuJASjoQYzG
	o+KUc5iDRfmbeVf7wJ/tE49tFUybhA==
X-Received: by 2002:a17:906:fe47:b0:c15:bea2:d209 with SMTP id a640c23a62f3a-c1f7215dee1mr299738366b.4.1785322187169;
        Wed, 29 Jul 2026 03:49:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83d27f47sm97965566b.26.2026.07.29.03.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:49:46 -0700 (PDT)
Message-ID: <c81be43c-2fe3-4403-b8a9-dd19855eeb58@gmail.com>
Date: Wed, 29 Jul 2026 11:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
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
 <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <20260729071048.GH9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729071048.GH9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_034949_284777_C99E6FA1 
X-CRM114-Status: GOOD (  12.50  )
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

On 7/29/26 08:10, Christoph Hellwig wrote:
>> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
>> +				    struct dma_buf_io_ctx *ctx)
> 
> Please stick to two-tab indents for function declaration continuation
> for the nvme code to keep the code easy to maintain.
> 
>> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> 
> This should be good old #ifdef.  Same in a few other places over
> the series.

Going to apply both for v5, thanks.

> Modulo these minor nits the patch looks good.

-- 
Pavel Begunkov


