Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369F3C55184
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kJpsobbV6cDtzB2hYIU7sj8yXmkuFvAex2Z4hVps0ns=; b=Zy7aa10pDILK7+2SOAJ0AcYsvB
	t7vmb6X4A3/Fsm+kNfPy+OKFBFSr+3EU7xwPKoErmbuXCOC6p28UTCKfWR5wYJELiC5+ZyAMOse0B
	Z2OJ5ClOMDClQ97pavmf8HzGBUtZmTQGkg8z1EWbjFSGqatNe1j36/jE/shuExLBsufByNvV2dPey
	FAqp5zbsmXG2M/x5lCHpqfoW1E7ykOvnOdUrmEgj02FYSj2zC9MaLz0gmZVMZl1NipDDrOA39mU4d
	pkgWPgClUIxlGjivMuG8Jc+YFz2DL+2YwTLfQPI3Q54SENQnhPRKUeUAlkdXZYTGtt66TRQeoquAH
	gJMlzZqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrIno-00000002Tgg-2HMp;
	Tue, 04 Aug 2026 17:19:44 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrInH-00000002TeC-0WI7
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 17:19:12 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-47de0093c42so32985f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Aug 2026 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863949; x=1786468749; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJpsobbV6cDtzB2hYIU7sj8yXmkuFvAex2Z4hVps0ns=;
        b=NNNDqsl63wVwgZmTPkSHJnPJuw8s0Ihp/W5mV84OXklURbcYsVfj9MFAYKRH/OQUZK
         ZbEQzyPWH+IqijiKg9FqLYibYyzMSfl/pZpZx8WKUxVWE7az4bCo78IkHBy8Hu+icatG
         5KSfnQkp3TUDG2mbYYX2DVQfPfLdNLootNqDXDWJLQ3YnugQntyf0ObYPgp9u3VL2VLn
         syZBW1vAaqGQtjqf21QfLsoTph6ypsXqgNTkI3V9ee+JXOLbpHMOtvfq4LCjTqPwzBKB
         TXW46eVILMkI2rJXFKn1AYUdKAkFcRaKuWCBYiH9M5vu//TwxEeOCo3ch2hhLq7tSfA4
         jSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863949; x=1786468749;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJpsobbV6cDtzB2hYIU7sj8yXmkuFvAex2Z4hVps0ns=;
        b=hiInUXtiQh3IQOdSuFJi/F5dSpKjTImNfwAfAVYHbwZ3xzPTRb2CZS2hu7PpAbNZtr
         VzFEIgBBjLl+5n3rzGlDumeZyI7g0/N+GBlVW6V68uzG+iCCDL3Dp2J838UgbR6EnPSR
         2txZrboTkDsbgEFwatxy/D2n/2QxZHb+dm0myI/iHPzMfja+eFKjlnpKfPPbL7Ypp2QO
         6I8JetONwRZbJrOc1fzdTsQN2F5OoaHzDJTOjnAhOaWRqjzdJDFt+qtFqfgOZZPy+uxP
         N/t++2CVJi/OatRJ28ZEOgnEa9dQEkdMvTE3DXRNRkd7/qgbpf3pm0qjSiQ7kD6ZgQMh
         sGFg==
X-Forwarded-Encrypted: i=1; AHgh+RorJstGHNDSA+b/ukSsA8POhYsc9hiSOH7UyLio43tfRNu6Y/NH0+Dju0LmBfFmJ2Jn4wfyWTfiDlal@lists.infradead.org
X-Gm-Message-State: AOJu0YzbmmXaHYDiMHKHzgDYP7rE9pzl8ZuDvqenxFe5xethpfp4QRqQ
	F4GQWHbwi5EUH6YmalGixNT6vYpLfbgZNsCDHGc6gSYIjXpNtk7pO4PE
X-Gm-Gg: AR+sD13bBAl5AZ/5TzZ6BzxOsGyLqe3LiJaQvW1K/d92fmJYKWUaXZWI5NrAOUzkos0
	XA3GyZLfq/x1JybD4WxNmVQbpdeUclx4iv+mHGBumVOpfQQDBfGOXoFSIY04Tk9P1zc+0HpOK4Q
	ADKMiZXmczaihATlxCgP29hil1utTG06MpDtCk9D3FZsUB+B1HCOjza/MKFwgoPoBdKy9T2WeZu
	2NCRfIPgbpdhVpw5g7L1zfAihHUd48yIokIhrQAPfsXyLwyX73+ObLUJ0VRlboxq4zkB1QXsi4U
	VwRPArVoIZW8xV4vXE1Xth6W3+h+aP2Y/Nr0X4L23vTfhMSO8c8HIlZUtJcI0xyj7pziAxTpBC3
	FOCe1sZJLVGkl8mNlTr+Y/syglVHs/h9CaSVxTBPJ0qcytEZMkokq/Zd7Am+1cK4mJtJkkEzf4g
	/RijjxhmNKqDvABV0/8T2so3FUC7aPfRQQfzReryEuWnVWUszFSVz+cbg2nrAVhIRPFUlCQp9qo
	TZHftUPpFqo2tLPKOOmZUAkT/sfHmwM5mrvITjneVTwEHj9sKSJc+L6M+RFu2a3Uyw1qqbqsHyf
	3FMYdl9aO1wpi9bvGToSJAfPDW6zwUbgiJNTGwA=
X-Received: by 2002:adf:fe49:0:b0:47f:941a:796d with SMTP id ffacd0b85a97d-47fec4fa3admr1381301f8f.12.1785863948785;
        Tue, 04 Aug 2026 10:19:08 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febfda6afsm1357370f8f.3.2026.08.04.10.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 10:19:07 -0700 (PDT)
Message-ID: <38163009-770f-4596-abe2-249efc113f59@gmail.com>
Date: Tue, 4 Aug 2026 18:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/16] block: introduce dma map backed bio type
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
References: <cover.1785596451.git.asml.silence@gmail.com>
 <e26aefbcb383be7092dc76343ce745013e671334.1785596451.git.asml.silence@gmail.com>
 <20260804162440.GB12292@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260804162440.GB12292@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_101911_183014_971F9448 
X-CRM114-Status: GOOD (  19.70  )
X-Mailman-Approved-At: Tue, 04 Aug 2026 10:19:43 -0700
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

On 8/4/26 17:24, Christoph Hellwig wrote:
> On Sat, Aug 01, 2026 at 04:46:19PM +0100, Pavel Begunkov wrote:
>> Premapped buffers don't require a generic bio_vec since these have
>> already been dma mapped. Repurpose the bi_io_vec space to strore dmabuf
>> maps as they are mutually exclusive.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
...>>   
>> +static inline int bio_split_io_at_dmabuf(struct bio *bio,
>> +		const struct queue_limits *lim, unsigned *segs,
>> +		unsigned max_bytes, unsigned len_align_mask,
>> +		unsigned start_align_mask)
>> +{
>> +	unsigned bytes = min(bio->bi_iter.bi_size, max_bytes);
>> +	unsigned seg_shift = bio->bi_dmabuf_map->seg_shift;
>> +	unsigned offset = bio->bi_iter.bi_offset & ((1U << seg_shift) - 1);
>> +
>> +	if ((bio->bi_iter.bi_offset & start_align_mask) ||
>> +	    (bio->bi_iter.bi_size & len_align_mask))
>> +		return -EINVAL;
>> +
>> +	/* single contiguous range into the dma-buf */
>> +	*segs = 1;
>> +
>> +	bytes = min(bytes, ((unsigned)lim->max_segments << seg_shift) - offset);
> 
> I guess ->seg_shift is some sort of encoding of a max
> segment size?

I'll add a comment.

We rather need the minimum segment size, you can always split large
ones. I calculated it even stricter as the least common multiple
pow2 to avoid divs here.

If the device supports N segments and we know that each segment is
at least M bytes, then we should be able to issue IO of size N*M
of full segments. The line above truncates the bio size using
that + offset adjustments.

I guess it might be more straightforward to calculate the worst
case number of segments and then adjust the splitting size, but
since we don't return the number of segments it's more
computations. E.g.

seg_size = 1U << seg_shift;
nsegs = (bio->bi_iter.bi_size + offset + seg_size - 1) / seg_size;

if (nsegs > lim->max_segments) {
	nsegs = lim->max_segments; // unused after the block
	bytes = seg_size * nsegs - offset;
}

-- 
Pavel Begunkov


