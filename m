Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7801CCA5FC7
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6C6Fqcl7JBjpTUHBHO+U+uYrchMJCAF5saUsMOGnSk=; b=0FGjRypmfzFI0ZFFyBgLxo+KYV
	HZJp6asjAZ+PM81pvtbGDrnR+QAAc35qkqTRH/fyGtYu6cGJTZL1o821hjdxspl/3cno2HR0zddIO
	4LSs9nsmYyFw83VDrv2fGNzFu6JGx7Hhr0xbAdW2qtQJ+voqpL+O93dB/MWN/ZNPYJieIivSJk3bN
	MFHDQfXy8uVn0tfD5gtwspLggqBHtbe44in9nsD7gdfsWjG65pG2Oh3NUW8lkdxxkb7lyK9poQLJ1
	BrTHgI3KQOiKd7ChA3x124I95V40vSuFeeSXf/m5wgJ6Y2WKt6d0Kgs1RvdqHjEv1rtj1REmbDjjy
	Gd0se/PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBvxG-00000006R9f-1Y3f;
	Wed, 30 Sep 2026 15:10:46 +0000
Received: from mail-ed2-f12.google.com ([74.125.228.76])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBrEV-00000005fzK-0Ixs
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 10:08:16 +0000
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a8038a9f10so7111503a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 30 Sep 2026 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790762892; x=1791367692; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6C6Fqcl7JBjpTUHBHO+U+uYrchMJCAF5saUsMOGnSk=;
        b=FVAUQ+JPI6Pkucx+H7bu22Bz/4G1E66ZU9yANMojxGADdYIpJkCZIg4xkRzR/5EGjY
         TbP02l3OPVFEBVF+h9dBj0Or1h7NStmTn493nb1FbcQ5aSsYv9785UElBHb+8ApVqkRg
         hONEysODZmRVpTpcpVmKXuacs66A8zDgPpfjZMa/DiUEHdmmZVkucMIn7b6K/zf/8g9Y
         5UTAvb8AT1j+3IFPMd8GKDE56186KffMH/vIVjFqlbgx2OiXInnrnfppuKcBzX0fUtfo
         4NSqRo9MV7Cc6/uBEWzzK3SMrnd3NGfdXoZos0wFKGOued+1zRVC+kNa6iS6ZuLVG5H1
         PpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790762892; x=1791367692;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L6C6Fqcl7JBjpTUHBHO+U+uYrchMJCAF5saUsMOGnSk=;
        b=cB01frgco5G6itWlpFr1X/qj+dMArCGhPyKGue7+vS/K9em0KtXPUSGdUlYhWWpPmd
         nNwWpaA3a+BD2xNSJtdWGJ88+YwTGtH0lp7+2j5ldn/GrNOwd0ArSxRvh6Po6GuzlLSL
         Hxjt/s7YqIutIByRSb9+P2T1E804u4ozNa0TUncNUSAI2eMEumTrTTB5B4aYzGz/wIVa
         vwRFHOyqIDRVq8Tgaq+5wDoBOyDXPcF1mntJzxLWcarVTIxDNv2ZmgTMxpabAYQMJvR4
         bMA510d42d2/UWG4uN9GdXww7f5cGeOkw5rMARr1D1QCIua4pD3dhfifKZSysZ3Ju+/c
         6Gog==
X-Forwarded-Encrypted: i=1; AKwUvBz7PBL0/9383tTUJvV5++mUmYXreQRjzj0ImvsEIQFBIzxNLbcC6cajAogyGM8oeTB4Lm2qz1gFjbL8@lists.infradead.org
X-Gm-Message-State: AFq9FYI7SJ5USE61dYN9B2Y+VNb2uTngQFukkb9skJYQR+87M4Cdf57o
	LayWc7hJVeeTK667Jbjq72k3+7qPIGc37x7HodjBCNAUzU83X6y9WTQ3
X-Gm-Gg: AYBFou3WZ+0llz1pUh/YiGuWgUM2a1vm503Cwjp8i9clz9cA1OkuatpIyOomlBV7RIs
	CsIgmg+rvgiWVoBSS0uYDPu2pMpGZwNzlR9lugGDa6q0M7yvV7jWpijRy2fAmoE8MT7zYmhlTS4
	R46TtzKu5FtNBbYmQja59RFoV5yAa0mGffvgNxVSTWg8oqu1hnTwmP20Pe8dQGsLaJyGHU0/Aso
	ta8uwCdxskRQWznSsYqNodddIFKsuE8LvwRbEEE6GLtuYe/15mC2rNFUhDH1//gAndg+GGpXt9Y
	6PiemqoNXL8a7ptIsg13Vs9j7sMlPyGxFPLwGL1+eI8mFv/SLpnSWuf0Bi24/3Li5jLltkaahes
	EfugYt4ikZclnuNchBELohkX+UzzUCuJElaqc588JxWnhVWHs/Dwft6fJeiKsDZN3yFPskIhzO6
	iDD8E4HB2fd1ubxUMMjLCaicdVL0FO7TaJWf2agjTzfOah/zgTEf9z5pq1CnKmFBB4ZqLhVSuRY
	D8vXx0jMLk/RJhsIME8OI29k4PVX/ji7G4ZCB+cJSZ8ft3nARWbqS/tJoMfrJ5HeEfOAsyJbJPY
	yFHQGIb0C9Skvks9FThPVfR+Sw1i51FkpWMo4Nrr1Ftnwtfn
X-Received: by 2002:a05:6402:42c4:b0:6a9:a362:4646 with SMTP id 4fb4d7f45d1cf-6ae198f0fbfmr582772a12.14.1790762892209;
        Wed, 30 Sep 2026 03:08:12 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae156adf4fsm527943a12.32.2026.09.30.03.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:08:11 -0700 (PDT)
Message-ID: <447c04dd-6bfa-4c45-99e7-37d25a7ab539@gmail.com>
Date: Wed, 30 Sep 2026 11:08:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/13] dma-buf: introduce initial file I/O
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
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1789997898.git.asml.silence@gmail.com>
 <5490ee42c4452fd4198b245ead20fcf7438c066e.1789997898.git.asml.silence@gmail.com>
 <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <arx7ZQ8o9aeHsAqS@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_030815_137713_07853AA7 
X-CRM114-Status: GOOD (  20.16  )
X-Mailman-Approved-At: Wed, 30 Sep 2026 08:10:45 -0700
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

On 9/30/26 04:00, Matthew Brost wrote:
> On Mon, Sep 21, 2026 at 02:38:45PM +0100, Pavel Begunkov wrote:
...>> +struct dma_buf_io_map *dma_buf_io_create_map(struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct dma_buf *dmabuf = ctx->dmabuf;
>> +	struct dma_buf_io_map *map;
>> +	long ret;
>> +
>> +	guard(mutex)(&ctx->map_create_mutex);
>> +
>> +	scoped_guard(mutex, &ctx->map_mutex) {
>> +		if (ctx->maps_killed)
>> +			return ERR_PTR(-ENOENT);
>> +		/* recheck under the lock in case it has already been re-created */
>> +		map = __dma_buf_io_get_map(ctx);
>> +		if (map)
>> +			return map;
>> +	}
>> +
>> +	dma_buf_io_wait_active_maps(ctx);
>> +
>> +	ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	ret = dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>> +				    true, MAX_SCHEDULE_TIMEOUT);
>> +	if (ret <= 0) {
>> +		if (!ret)
>> +			ret = -EAGAIN;
>> +		dma_resv_unlock(dmabuf->resv);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	map = ctx->dev_ops->map(ctx);
> 
> I'm playing around this code now.
> 
> I think you need the dma_resv_wait_timeout after the 'map'?
> 
> If a device doesn't support p2p ->map() will typically trigger an async
> migrate to system memory and data will be moving but the map is valid -
> Xe 100% does this, I checked AMDGPU and fairly confident it has the same
> async behavior.

There is a wait right before because I read somewhere in dma-buf
comments that I need to do that, sounds a bit odd if I need to
wait on fences before and after. I can add it, just curious how
come that other dma_buf_map_attachment() callers don't need to do
that. Or maybe they wait somewhere else?

-- 
Pavel Begunkov


