Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636CACC6B19
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=; b=0mSjOY61/73nh+09EwkvKQnaV5
	k13Qb4lkbRYGVIfObwrxnznFynQ4udLYnzkxmSYYgUV2s29pFn6ZDwquMOyhoGgVwMsntO8EDsW9p
	3BrJB/+BP/zFEJl/8xBtTrBQzIMPDk9Lz8wx6zUnUqQwlrvRfBMB8OsK4yna+ZD+wTpmT0JbYzJnS
	PZCNEEcKawSJJ4AuV/nYfbwSavaZAA8JHK629OpS/hR9qe5Kqt+LOE/oblpFPpn9RgVu3ZrKfrnUm
	WZzaN2J9kUbjilzNrpIqvF63DAUOQtSNjADGfc48okAUK8ra95pcmBbC5nl0ETMZJJFIzl7oxr1RH
	W2HdQvAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGizE-0000000Dzlf-2c06;
	Tue, 13 Oct 2026 20:20:36 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGiz9-0000000Dzl8-0B2y
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:20:32 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4a1ad2e2391so8616515e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922829; x=1792527629; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=;
        b=CM6c/qkqJyvkvY4DCWYsJPab15bKY53waCBmNDo4AaggIH3H1akzD7GfC5jhB0xc++
         bm17+Am7qTp8xgWtdhL7JRR3AxwKmNhZRobCF4N3mAjCKRQI9bxlAdcNcyVP4h/Ia0Tg
         QDlciyVC1h5omSzt6Wt6UUyCgJgGz2beGCFXd+bSRm4ouw2joYTm1LO/VI4d4mIGP3x7
         P3A8tgy5yBTK2s8OC0pHIUsbZnYZUpgyVRYN7URPbQV3AFd7E0h2+egG3BgZIrm4q9wO
         9FH8iRyh+VQBJKIsTay20uLR3FebkBlIejS4DX/PAodSNbc2TovVXWsLAGMTwlbkU3uM
         wM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922829; x=1792527629;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFWmLiUqCazwiWkaP/d2QvvXVbxF3nnToJUN5Fd7XEc=;
        b=UOZgAW9Bz25Db1blpWH/jsH0GPces5Vv0tZ7btbZoKRf6iLoiDMcFypvtc30KcoChs
         MtC/+OwUxlo2cjI+b/6P0qfvxmyDPKHBfGAgaIQJNenGplk89aoaJqd32gYm3444iMNP
         tt1k7U4FvhPpLdkGheGbHJXRXCTqiaEhaY0u3Wqh4eEf2UgyE8GA5VhTRwo+llOCq6is
         o6vuGeilhqGrxMBTdfLn39ZcO+wdCi4RXyl58l/s67zcF1ME0yNiQ5gM2lvCS4ti5n5+
         BmM2X93v15qk8qEvmAU+bzaZ47G5JL2be4KWHHKUUVwyBdYZ3NfbxmeH1v/65tLDJlu4
         62mg==
X-Forwarded-Encrypted: i=1; AKwUvBxJKooHtpHtkAddVXTTDtmb3w/+2qrg9mC8auNmTuTBqNhf/lkLXXfF9swQHvtirTkHT9GM1mH4EU1s@lists.infradead.org
X-Gm-Message-State: AFq9FYIde5kmDn3vk7e/1VAIj8CkMyfrEqAgXtuQUIBSva/z753CSoaj
	hcvrkbCpVauqcCJkEDijg5gXLNgSFbeEAkoq43E5F+w4niHQRP3Udsis
X-Gm-Gg: AYBFou001DdyUgzwYZPKj4MHtE7ehdEzXld9mIAriWWx81KU6nbb0UCXb1vj31XawjR
	AKRrnYRFWVoSHRNTxyrHuhtbyEiciKRlwsFXBc7BmCzOSTEXHT4EmjqyYEag+/ZK6XEHsvjyYkh
	lZl2mMyY+5FIIKpRT/Gi1WR6ndpqnSOANp3bVgL3+cKwBm20wFMx8iWh1cyv47JKEMdfxF7vMZc
	ISMQ7RkoadlEZYVlD86sqmYV8VlXQGFvMPh5cZFjX42noFFbE5Yh5OfXvzdpfFgRXWduX7a5pzX
	iDpqkeOg6/tRpvJYq8/ugPc7spq8Z9mWimVKO0wHjQeWizqHbE+JQga7UzCGAjUF9yg4m/tUroH
	Rwb6fcFGRFzhHvmvWef5U8ubA8eAfolx5Qb7rphoPQmum+ouaDF0S1fOYagspxxoDaMj7L+Yd+9
	wwiAKWSw5P+fu2OkknB8XsC8htqisiCAVRsMB3/KW/BRFYu7m3BzT+h+SbHzQ94A1ZUdllv/hxL
	Y85bC3MKFE1xaxco+TOp+yHLtRRscdtwC94YEFKbfHRAk32zCgVB7zJ4E56/4oXmD3DcO9knjvT
	tZX2rl2HcZ2yxp8lnkI7MJdttpyGeXNHBtb9Bp5F3Nd4XHU0
X-Received: by 2002:a05:600c:4594:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4a18e4d6ac3mr267044135e9.26.1791922829049;
        Tue, 13 Oct 2026 13:20:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf2caf4sm426025355e9.10.2026.10.13.13.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:20:28 -0700 (PDT)
Message-ID: <32a70bda-de28-416c-84d8-a56c261063dc@gmail.com>
Date: Tue, 13 Oct 2026 21:20:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
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
 <d00e43fa-8f5b-4a8b-8b83-421d637ba519@kernel.dk>
 <20261013141046.GA12680@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261013141046.GA12680@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_132031_104906_B667F88C 
X-CRM114-Status: GOOD (  13.63  )
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

On 10/13/26 15:10, Christoph Hellwig wrote:
> On Mon, Oct 12, 2026 at 02:21:41PM -0600, Jens Axboe wrote:
>> I've queued this series up for some testing, in a separate branch. JFYI.
> 
> More testing it obviously good.  I've been waiting for addressing
> of the Sashiko comments on the nvme patches before doing more ACKs,

The nvme array out-of-bounds one is sashiko getting confused, we
check all sg chunks on alignment, and seems like sashiko ignores
it.

> and while I can't really judge the code those in the dma-buf code
> also look somewhat serious.

Should be false positives as well.

   So it would be useful to get them addressed
> and the series reposted.  Same for folding in the PI vs dmabuf fix

I was going to repost, I guess Jens staged it before. I'll send
v10 anyway, should be less confusing this way.

> from Anuj, although making the combination work would of course be
> even better.

-- 
Pavel Begunkov


