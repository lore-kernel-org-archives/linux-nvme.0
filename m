Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E372EC98308
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 04:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ufPZGPSZBLf6/pwvKrChnuajCoyQv+QtMvUQGkdovhk=; b=a5NuZcuSuZNOSw85F+SBc0YKfe
	5ncIrGRwa9+znOVLnMhHG6nuYkuGjvMhVfDunjNGvLiQ1JA5M4LaR9qPwCtJHuBExEGyXyEIJmw2i
	j1szYuoPgoZkQDzQERuKSiTxE+L/JJfYOBonRWNWF7Z1xJjesZwH48J9qiH3ivlMcOVsxPLYr84NB
	dUVpDZCfO3L6SlK7MEZORtRwEGDjplOKr+YaUJPnE1ZdjOCeFi0+0FyJPoxWmeZfX91qrmg7/nNW4
	Onf0oV0CdoAyLLTTPYGEe6ccn4V1Orb1Axwl4bc6E11cfljlrvlqoPa/KH18cjn308nAp8L7hfI/j
	D4DF+FpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9F1v-000000078SK-05lH;
	Wed, 23 Sep 2026 04:56:27 +0000
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90xG-00000005bvL-2nM5
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:54:43 +0000
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso640407166b.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 06:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085280; x=1790690080; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufPZGPSZBLf6/pwvKrChnuajCoyQv+QtMvUQGkdovhk=;
        b=IFYDlEvjJTJcruEWdWYnMHE0SK0n0w2nqH36h/H1j8Oy7gde9i5m7DLfwZJ9b5Y0Z1
         MxHZQk2c228mHT7gA/gQ1kOY5nJSSYbAHgsPe/UVR8JVqr4PGtK1pB3vQavRU70z6BNc
         3S6/rpn27ck9xbq1hyt7WT74H+L8V85EPpSPM7+F22NPYq/swO8rGRrd26uPLEAz5BJy
         wXF3WLTHz6NMB79Zdxwz9f3NwzUpmaV79vUO+3s/NWGsHoXGY7ruuFLURerzMYpjA2EX
         0bEJZiaIWDtC7+W5fd6Ac0Ea44BSvrCT1DcH/GyFKXChh7q3OzJOSvfe0vPj2P/T9crI
         bYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085280; x=1790690080;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ufPZGPSZBLf6/pwvKrChnuajCoyQv+QtMvUQGkdovhk=;
        b=QW05yag+XkEzr7A+CUHl8r8RU7m0m3VISYYp4NR1o74rvCJ+nt8saJy/tZpRFEpomr
         QEHv7KUQc8L5vQlnQVA212KmbAMqFOaDWdyZNqioWLS1r97nHwB+vHkCXEB6MmiZPm/R
         ReWCutJoIvCLHxy5+XE4d/jPo6RflNvswMu4Yayf0JG6GNKaUvHRTTaDd1TZoQ7qqQcP
         /rMUYThytI6/K1n8qMzHgaryu+nscweYPcDf0TM5o8EV5ALDmym+lUsI9Wf32uJ3DaO1
         UnMfJ7tVKi4t2ONQIq2SlkfOcyEINJ+QyxkklLvKBRPvky71AWpD0UJtqMLiREmhrLoE
         LCuw==
X-Forwarded-Encrypted: i=1; AKwUvBxnn3O3CdBk885nxAo9JUSzAGAd5AafHtY4Xqp3UDRFOIqguouqmu2X/M3KX6z69/DA98wQJX1yU3z6@lists.infradead.org
X-Gm-Message-State: AFuF++kC6WEl059GLrKeQgV1tZnz/WjPxzSjapIKAAlCud1evsW7QHup
	eCpR+OfNLgPC09daNfFRCdcGf61nhIY59/6Wusedy+HzkJOoQ+wOnPo2
X-Gm-Gg: AYBFou1gBMlDuvn7hSUJ+xJG0PrYsN0UQSa7b2Dr27hmB9Ss+kRhIet4nuspwyqfP+y
	i860dw1LHFqBZXjrgaDDN2aqS+kQnnoX1/Gs+hoAIDhspK7zR1hHec+qoJuUD4oz4RmxvmCGM4d
	yf6oz7FKyuRvQu/hlydfXGKVeCqKG6ubbrTdwVY1Aq1gdxHOsdOX05vodyARgE8BDueuyHubcaG
	SlIS/mCNe0lOU+3aGXKqY0mTAb3A9+WASs8Bj7z8gPvAkkEo65H264vrND0COHQmY204oItWahe
	hCrODGwRE6bxnGOavbOlNVJasfxRfyKQzfs/Dh8pRPNMdE7iAUbqJKh86oAWDK0Q0JETENs4BtJ
	uICj/fnetaELY3jVJ10o2LNKxPILoFQkpeJVQXYY4Em2T4xinSzL9ZzcxyRH1dqhc5QTH38vwWr
	j/0WwFSu8csdpQKfaD5xbCFFlv43IG5WA2uQy9vqumhYDNAOWwxpUPPwjBP+Ny9yP9jM27/XpKD
	MFnQ26IklF1goc/g0GLGCGzdHfeeoWJ79/+kzBLf6e3gCYPuEuHQxtY+uAnzBmanB7wHQz7ohrf
	Hc5MDJYOIujhvyUue7AXY4Q8IFg7
X-Received: by 2002:a17:906:c111:b0:c29:f5d8:9c6d with SMTP id a640c23a62f3a-c2a15802eb7mr1217098966b.28.1790085280498;
        Tue, 22 Sep 2026 06:54:40 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-197.dab.02.net. [82.132.213.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a9c5baa1bsm93202166b.39.2026.09.22.06.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:54:39 -0700 (PDT)
Message-ID: <cce62c72-278a-44d1-9cf7-e0beb0b72688@gmail.com>
Date: Tue, 22 Sep 2026 14:54:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/13] block: introduce dma map backed bio type
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
References: <cover.1789997898.git.asml.silence@gmail.com>
 <a3ee719abc440ca139f1a945fdaf43a45f0c6b57.1789997898.git.asml.silence@gmail.com>
 <20260922131610.GA30468@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260922131610.GA30468@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_065442_724423_364764AE 
X-CRM114-Status: GOOD (  16.16  )
X-Mailman-Approved-At: Tue, 22 Sep 2026 21:56:25 -0700
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

On 9/22/26 14:16, Christoph Hellwig wrote:
> On Mon, Sep 21, 2026 at 02:38:48PM +0100, Pavel Begunkov wrote:
>> Premapped buffers don't require a generic bio_vec since these have
>> already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf
> 
> s/strore/store/
> 
> Can you please expland on the splitting considerations a bit?  Preferably
> both in a comment for the details, and in the commit log for how we
> arrived at them and why they are fine for now?

I'll add something to the commit log, but not sure which specific
details in comments you mean. Do you want me to expand the comment
above limiting the number of segments? Maybe I should add there that
it's stricter than necessary and might cause more splitting than
necessary? This one:

/*
  * Limit by the number of segments. We don't expose the underlying
  * mapping layout, but with a known minimum segment size, any I/O
  * consisting of N full segments should be able to cover at least
  * this much.
  */

-- 
Pavel Begunkov


