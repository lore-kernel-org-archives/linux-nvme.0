Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B43CA9ED0
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 20:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=; b=RQ1dErIheMzNfqN4mFUe3sHo2t
	cYDRdB/chEL7P1MSvwN5atRNe/flIWH/Egaxfllquy/4YE8J53XarJX3nAMc9cjOdho+TBtGat+NY
	o8lAOKU4ZyC2vlWWTd9v8OiYPvVUWA3+9dmtQi4zTm4s+xIUijj2ADitpIb34momE2KM4XZhmk06P
	N7hX52YFij8tERrN0lOWaBtcuTiggd7EVR5sJLubohbLjPE5png0KGMGRWHiMo/p6VGyFhClbBTF5
	TsmeUlawmyETCYtm7d3vnL0tpdbDfd3VuYcUWv798PwsYZ01apbGWKBdJmF0Bx01ReOShdlu9Q8ad
	1+PC6eWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGMWr-0000000BSnu-4APM;
	Mon, 12 Oct 2026 20:21:49 +0000
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGMWp-0000000BSn9-3LOe
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 20:21:49 +0000
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-821b5c73292so1636473a34.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791836507; x=1792441307; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=;
        b=Z8C/XjKOuGhdWCSe40pdscyfBOlNZnNuM5VoTsCorF0B8GywKpBL3jgKaFanBZ4iFi
         KCYg7dG4pAIxNBC1yTYqOeNRAM2DMjSAMoRfTitwk0bGi67w5P0RPjXlza5yP6GMyNix
         QHy6oH4h4fg50ZRjgCOk1EH1LYZ+feLjwmsd7r1+iSTl56K5+N34Wt4Ta1F7TqUqUcqB
         CopM+nxp/KmjaXhkGtJzIg7PFrpiisfNzS8qQzIPd+j126PlFF9V0vFxOqw/4piPC5C4
         +se/Or6jfx0IDGm/wlukS4seClwHKy098lSA23K63JDMMIJQgNstNisoFnD/pUIqT2+x
         BqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791836507; x=1792441307;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6hOwSLR8cfh8cDplIOaHfJc8wiTVy6P5jX2Jl3fTgI=;
        b=iWBqxkuMp3S8UemJasCeju5PvSN3d1p7ogaQxv7UiT7+T9skOo5EvhMxHYXFyzRVdc
         fawbSyLmnwanJAhxadGGFaqA5Ok0bdtb5RWH4eVodNYQYfeNTufeRwFHJwgpKeW72BF7
         ZHZzg6OdwFywhxZlQBm+XC47nqgSyikhxZuz4IZ09hZnCxgthYB50WUeluTgLCSnv878
         QWP6A+0SPushSUtS97bEOnS7R5mmXtArHVlIt6+IiaXVpoPGCeLUSRKDC+E7yoBYph1T
         iuPGp6fXeJJZFlQmcxeU3tFdaPmUnbDQohpx0D3gf/EO+6OrXSFc7vjKYeguq7HXxhuY
         0cRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwh58qZYQ0/cHIO3Tpfkn04C7O0vjSHKdvpXN3s13qo4PrYbi+DZBVUagHc8wJBjto+mBuKTcV54/8F@lists.infradead.org
X-Gm-Message-State: AFq9FYIlXF73Z1dpLsPWzYcJvkZluf0LPX5MRbo9HyZhwH/6IZjMeYDW
	5zgg0jFyT7/3PMfDVsWp4UkKddQQUIj/P2x3o8TOWVykCQZdLPuR0wVlsJa10ktTjwQ=
X-Gm-Gg: AYBFou16e/e9stJJtYoIpI/QWRshrLltUGSv4bKYnEFJ6wXk4bbt/6UcsvxBPLhhbvQ
	+zLG4HfEdTJ1p/nGT0TT0jaXnJshg7XvvkLdt5NInMBbmXm1xusPOeM081zFPPzhE5TMYIa+FfB
	cHJUoIRKgq8Wjv3jH0Klpb0FA+g/wt4tQ5eR6b5EBbVxFobu2OauQZHAsu4RdvlsM+YmLaQ8fSL
	IF2j6pV21rI8M370CnuF/o7ndmvRWAvjiklMrPIIcYCcIVwMd59GiSVoyFxiTxClREOBrwmiPGc
	16JdMX/0UnhnRFCpsGdNtPXeZ6KjpGfdQgrM1Y9MKySesK/cqZmPUQnIZoSTUYYz/AbS0ZLj96W
	RkB4prZ2yaVOPRqhte8dkKNNndm7NyL8iqWuMqV2wBDj7MBa5j0ofOjHrC3qgxnleAHhvwLb5kj
	WMgalbFZhibrlSOJTiZqRl8Hv/gnFaZZbrvdNszBClZWFyycOxdl72RsmnGkK7F4MSTn5OSap9G
	b43uSq70wHOFbZ6Gnx/Xa9LEMZZ2g0JIWt0gIguezGDB8J1j4BTpjShTA==
X-Received: by 2002:a05:6808:f88:b0:4d7:17d5:6c9b with SMTP id 5614622812f47-50c40a3e034mr9500602b6e.9.1791836506735;
        Mon, 12 Oct 2026 13:21:46 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c167544b5sm12396143b6e.3.2026.10.12.13.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 13:21:45 -0700 (PDT)
Message-ID: <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
Date: Mon, 12 Oct 2026 14:21:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_132147_848503_9B487751 
X-CRM114-Status: GOOD (  20.04  )
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

On 10/6/26 7:42 PM, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1],
> from where I borrowed a number of changes. Later it was brough back up
> to life by Tushar and Vishal.
> 
> It's an opt-in feature for files, and they need to implement a new
> file operation to use it. Only NVMe block devices are supported in this
> series. The user API is built on top of io_uring's "registered buffers",
> where a dmabuf is registered in a special way, but after it can be used
> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> requests. It's created via a new file operation and the resulted map is
> then passed through the I/O stack in a new iterator type. There is some
> additional infrastructure to glue it together, count requests, manage
> lifetime and implement invalidation.

I've queued this series up for some testing, in a separate branch. JFYI.

-- 
Jens Axboe

