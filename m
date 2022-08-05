Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC44C25B0D
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Aug 2022 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/DqADyM3sQL00vGbUB26CuaAWBmO6y2rTbxXW/U54A=; b=ETNzUMWqSJmk0y9VBvwekl4Ff2
	s+VZatFbTRoMB+C3hAh3JRpU0/BQXLolHlnFSJMLN2eNGlMePyQ01C/slwB4h0Xb8+JdkawFbhB/7
	CUL/qI1+FR4JXDIdyGPRecrHnFFAoacBdpGUBbAV1TAi7fRH4dGqOsGrBL31tDtWHXPFWWP27JL0u
	77GerNRyKiq1HJqnp0eKoTaGdvAZi/zE8+CgkFAZPJu6Zxj+rh4fUaLUhLrimfJpHWqgQRPfByDrc
	j6j60g1XhoIANTxEpFLW8ay3GwIcwV7hEwKqoQ9ER8Tm6O5D0sSWrtM5SKWMTaCR73hd8Rnrbln4R
	MF+3Pmjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK0yA-00GzxF-Ib; Fri, 05 Aug 2022 17:18:42 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oK0y8-00Gzw3-NW
	for linux-nvme@lists.infradead.org; Fri, 05 Aug 2022 17:18:42 +0000
Received: by mail-io1-xd36.google.com with SMTP id l24so2332227ion.13
        for <linux-nvme@lists.infradead.org>; Fri, 05 Aug 2022 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6/DqADyM3sQL00vGbUB26CuaAWBmO6y2rTbxXW/U54A=;
        b=K4Ws868YsLAywh1TYSuPdBFWw1OHzTF4oRD3ojGV4ls1+9JqeThR8AT4u8dur7vr6r
         JUJwUMgxXrlL2OusvJHSE9LRwX2aZmW+1Q8t0nLQoDaE5RJo+DD3XU9xNSbbAph4Z/Zi
         mBUFiqpsPmtx/jKr9pDWU9YpBIAyA2w6wR7jrOtTD4HLH9Q5+LguDT1LkCv081QKdgZ7
         IWd+c43VlfwQpq8lSAUnxQUCRdUQ8pnA8QZBzco0rv8PQXMVBBRLInP9hYQachOP33G4
         rVwOZG6Y/EEvQXCXc6R+xAjGVpCsNewi1NcE/lb9IA3U4QvP6CCD3inQfLT1c2E2GypM
         yC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6/DqADyM3sQL00vGbUB26CuaAWBmO6y2rTbxXW/U54A=;
        b=RJ99LXxa7ZniNItdyc4PavQJd4CZMsi/T5Dr3t1VNFh1NIZBsFCbAEqD+hwJkx+F5t
         8LH3WeSE3J7IJ3UIvaZB6W30Li5NgO2jnMn2fjPvn/y1il57SDxnRgoKvpE57oba2DfJ
         U6gIqxJPpPGbE42zRd3ZcsuFYxMhciNBiTIrQTwb3jEUH5oOsAjL2EIajHG02Gu49Ibf
         mneiKidjSQT2cDGlrZWZDGt3Jx+khouIAxQQNa0yIXK5K0WhTFtZKckaAXxJZ79rRvMS
         AJMti7Nom9wfMKmZoUbEBZdbjBquu3Z3bpuEpczPvmr/qZCcmFo+Hn3wGljsNi0uQxHJ
         mViQ==
X-Gm-Message-State: ACgBeo3M9VImRgCncQ++AW0jeVeew0PaJ90PvUnucZolwDhpcDYsoy0/
	BXvngby9RSOljdKZ77KKQUinpw==
X-Google-Smtp-Source: AA6agR55dbbtqPssP7l2tXFfNISN7x+xN1v8y2BsnPEQiP22QyEVvoTIOhvxc54whmXNc9sfXWaxxA==
X-Received: by 2002:a6b:3f85:0:b0:683:7d5c:dccf with SMTP id m127-20020a6b3f85000000b006837d5cdccfmr2391543ioa.48.1659719919519;
        Fri, 05 Aug 2022 10:18:39 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id i9-20020a056e021b0900b002d90c9077a2sm1822759ilv.57.2022.08.05.10.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 10:18:39 -0700 (PDT)
Message-ID: <a2a5184d-f3ab-0941-6cc4-87cf231d5333@kernel.dk>
Date: Fri, 5 Aug 2022 11:18:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/4] iopoll support for io_uring/nvme passthrough
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, ming.lei@redhat.com, joshiiitr@gmail.com,
 gost.dev@samsung.com
References: <CGME20220805155300epcas5p1b98722e20990d0095238964e2be9db34@epcas5p1.samsung.com>
 <20220805154226.155008-1-joshi.k@samsung.com>
 <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
In-Reply-To: <78f0ac8e-cd45-d71d-4e10-e6d2f910ae45@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220805_101840_796038_2007355B 
X-CRM114-Status: GOOD (  13.44  )
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

On 8/5/22 11:04 AM, Jens Axboe wrote:
> On 8/5/22 9:42 AM, Kanchan Joshi wrote:
>> Hi,
>>
>> Series enables async polling on io_uring command, and nvme passthrough
>> (for io-commands) is wired up to leverage that.
>>
>> 512b randread performance (KIOP) below:
>>
>> QD_batch    block    passthru    passthru-poll   block-poll
>> 1_1          80        81          158            157
>> 8_2         406       470          680            700
>> 16_4        620       656          931            920
>> 128_32      879       1056        1120            1132
> 
> Curious on why passthru is slower than block-poll? Are we missing
> something here?

I took a quick peek, running it here. List of items making it slower:

- No fixedbufs support for passthru, each each request will go through
  get_user_pages() and put_pages() on completion. This is about a 10%
  change for me, by itself.

- nvme_uring_cmd_io() -> nvme_alloc_user_request() -> blk_rq_map_user()
  -> blk_rq_map_user_iov() -> memset() is another ~4% for me.

- The kmalloc+kfree per command is roughly 9% extra slowdown.

There are other little things, but the above are the main ones. Even if
I disable fixedbufs for non-passthru, passthru is about ~24% slower
here using a single device and a single core, which is mostly the above
mentioned items.

This isn't specific to the iopoll support, that's obviously faster than
IRQ driven for this test case. This is just comparing passthru with
the regular block path for doing random 512b reads.

-- 
Jens Axboe


