Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B126BD4335B
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 01:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZJsiZe/XqcKJjkVqYeKzXPFPwj1/tSmTc15CXhIwXUk=; b=WE57lvfqSYcApnf6tN931kboDX
	EmEIL5EL6M1ddwiyFnXu8H1WuhCbR1RAi60iZVCER+TvxuVti3yiVXlkC3P3kUIAf4cd7XGPbLpUq
	P/8F6AHGAe58yPl87tmSLvm/rcGqY7hpvCgM55bpDIhYaDzYd9TI4Ou0VQCLaBz6qBcFNrr4wLc/p
	DD4IQ8lGsL1zpXhYvQGpq3ZU2qApWYrMAJMOQomSvFZSJaSLLlBbHYTgjMEZN0w+SaUED8iFexnEU
	ABX4l/OwSA5wCbFH1Yh7fzghBC/69qH6uQGh8yNO++EQeLAMXiwo4j2QCKvSRt+vwcjjEe7clgLac
	fZF4n/rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTsOF-0000000HVZ5-3Ci2;
	Fri, 12 Dec 2025 01:56:15 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTsOB-0000000HVV0-2rRh
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 01:56:13 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-29845b06dd2so8562655ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 11 Dec 2025 17:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765504571; x=1766109371; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJsiZe/XqcKJjkVqYeKzXPFPwj1/tSmTc15CXhIwXUk=;
        b=bR/ebhaGlEax8AkYCgB3saJUXRf91eN6iI0cMrvM9bidYY2WYmHGtIbIosRtYMiWVJ
         29xt2Wla3/XrnjmarUzcObl/giK9cEvtVnnFCW0CodVD6FjgFD8aKXOn4HTriRk0ErG/
         Fq3ckUQR6N4cJ85yi4WMYzyqa0lY0UvL0VeJSYm4diH4rvwZbWPeJJ28eS1Q8eh83C4x
         Jr6IacMbeoDeFktB/qXFUUQ67dfWs/0oKSK36rS2aBv7wBMt6KdKOW0LaVGsIu4+kU7C
         Tzsps/6UsSH29C4baX3Kw60MO1V2Beumq0aannNwa1+UJ3b6VNU/Q4Ii/AWKbQCx6itd
         hkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765504571; x=1766109371;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJsiZe/XqcKJjkVqYeKzXPFPwj1/tSmTc15CXhIwXUk=;
        b=J4gapYX8NOC4mR4A6O04u9/wHtHcQNtFpvVylHjyEAE8DFElaCows/gg5r6uNkvNdC
         WRz1VfIt5qCgT7zeK7tYBBMiwfH4XrfeXWw8gBhtzK7NPGjEP+hShj4dFGgs3NNU6g8Q
         vckuYDIcwwQ40IsAz/W0mjTVoHZPC1QchJglKj1DEElx2ktECa3CioseW+wGmSgqPZA8
         g042Q65wV1uziu514hQb7HpiuNSh6vTFJIFzJ2AeKNcYmjhIasWqqv05iG8AVPWj5NgX
         o47FA2QAXP9vx31cwHDb/8oyNV1tSN16ALOc25hu8BARWqE+d0GEXwKDyFZHtqZ5bULm
         Cn0w==
X-Forwarded-Encrypted: i=1; AJvYcCVfTgbN98Uq9V0eTaumfZk7CSWKX32V6IuYhsBlXELQZXV5n/+G2MJmYR8cooyGAdfdnLVYm7VOKuiE@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2xXdeIQJBWBY8ZlLBeetTGCrvIWDh4050ahr8rpWleMRAFvlB
	L8xhLSRGlDvskuiK9pCEVyXFhBpWHBiNiIOR+KtmYZgg/0bIvWUg62Y4
X-Gm-Gg: AY/fxX5EA6vnoBtOM27WLEqk5rRzvMYOlf6kf/BelSgJ2Kj3PG6/o1wRHAweFvlI08j
	5Q+zLvICM+AJC7dZxSLqUpmgZH31t5ckLjBFrulIohfo7O7e/9+qdcRnWMXbiUWePU0Ze+LLHRw
	E35GKclUfTgyeA43HVs7Q9zWx/Vsv0n3QRudWQy/IPDN08K/Wh8UxuTUTZeOB3aTvF9q2KUcHKK
	nVbl27UW2pWyHILhtWpRoWuft/0xovjyGCaIOg7ZcFYlkY2Y3Z44vObxH/WfftzrWPj7lmK8BeL
	fKM1X0rglrrTMw3FqQRIEJkSBVMpkFYZALHGILppNGvjb9Wke9XuWDKZlc9aPqh2CFIQlEe/5eZ
	LGNlF51IO5/U5xbZ3lHeTKnAiFawvKtR4Yf7A6Z2YcZmJNWSiC/7Drth7iceitn05Hs+5nJahQE
	mP12DBE9JJlEowj33JmOwP8XTMn4itdmORh6JR76HdUccoUrEEl8DE1sYuOXIGXpxs+lcibYjEf
	qHv3jIIrx4Hde8f2sTC+0oAgjJlVUifD3I082c466puCi+AaTY=
X-Google-Smtp-Source: AGHT+IHrNZHNZ799rRWGx+LvO7XaRwwtcVkWXSf4q+3pQ1pJSMCA4DafAXljIyZfD2BV+qpIbTHyew==
X-Received: by 2002:a17:902:d4c9:b0:29e:ba45:350e with SMTP id d9443c01a7336-29f23cd48c2mr6283765ad.44.1765504570758;
        Thu, 11 Dec 2025 17:56:10 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016ac2sm36260535ad.49.2025.12.11.17.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 17:56:10 -0800 (PST)
Message-ID: <eb72c089-a6ba-48df-a215-af35d5dd808b@gmail.com>
Date: Fri, 12 Dec 2025 01:56:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
 <aTFo-7ufbyZnEUzd@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aTFo-7ufbyZnEUzd@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_175612_438766_DD465059 
X-CRM114-Status: GOOD (  24.62  )
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

On 12/4/25 10:56, Christoph Hellwig wrote:
> On Sun, Nov 23, 2025 at 10:51:25PM +0000, Pavel Begunkov wrote:
...
>> +	struct request_queue *q = bdev_get_queue(file_bdev(file));
>> +
>> +	if (!(file->f_flags & O_DIRECT))
>> +		return ERR_PTR(-EINVAL);
> 
> Shouldn't the O_DIRECT check be in the caller?

If the interface will get implemented e.g. for net at some point, it
won't be O_DIRECT. If you want some extra safety for fs implementing
it, I can add sth like below in the common path:

if (reg_or_block_file(file))
	// check O_DIRECT

> And a high-level comment explaining the fencing logic would be nice
> as well.

I'll add some comments around

...
>> +static inline
>> +struct blk_mq_dma_map *blk_mq_get_token_map(struct blk_mq_dma_token *token)
> 
> Really odd return value / scope formatting.

static inline struct blk_mq_dma_map
*blk_mq_get_token_map(...)

Do you prefer this? It's too long to sanely fit it in
either way. Though I didn't have this problem in v3.

  
>> +{
>> +	struct blk_mq_dma_map *map;
>> +
>> +	guard(rcu)();
>> +
>> +	map = rcu_dereference(token->map);
>> +	if (unlikely(!map || !percpu_ref_tryget_live_rcu(&map->refs)))
>> +		return NULL;
>> +	return map;
> 
> Please use good old rcu_read_unlock to make this readable.

Come on, it's pretty readable and less error prone, especially
for longer functions. Maybe you prefer scoped guards?

scoped_guard(rcu) {
	map = token->map;
	if (!map)
		return;
}

...
>> +blk_status_t blk_rq_assign_dma_map(struct request *rq,
>> +				   struct blk_mq_dma_token *token)
>> +{
>> +	struct blk_mq_dma_map *map;
>> +
>> +	map = blk_mq_get_token_map(token);
>> +	if (map)
>> +		goto complete;
>> +
>> +	if (rq->cmd_flags & REQ_NOWAIT)
>> +		return BLK_STS_AGAIN;
>> +
>> +	map = blk_mq_create_dma_map(token);
>> +	if (IS_ERR(map))
>> +		return BLK_STS_RESOURCE;
> 
> Having a few comments, that say this is creating the map lazily
> would probably helper the reader.  Also why not keep the !map
> case in the branch, as the map case should be the fast path and
> thus usually be straight line in the function?
> 
>> +void blk_mq_dma_map_move_notify(struct blk_mq_dma_token *token)
>> +{
>> +	blk_mq_dma_map_remove(token);
>> +}
> 
> Is there a good reason for having this blk_mq_dma_map_move_notify
> wrapper?

I was reused it before and reusing in the next iteration, maybe
v2 wasn't for some reason.

> 
>> +	if (bio_flagged(bio, BIO_DMA_TOKEN)) {
>> +		struct blk_mq_dma_token *token;
>> +		blk_status_t ret;
>> +
>> +		token = dma_token_to_blk_mq(bio->dma_token);
>> +		ret = blk_rq_assign_dma_map(rq, token);
>> +		if (ret) {
>> +			if (ret == BLK_STS_AGAIN) {
>> +				bio_wouldblock_error(bio);
>> +			} else {
>> +				bio->bi_status = BLK_STS_RESOURCE;
>> +				bio_endio(bio);
>> +			}
>> +			goto queue_exit;
>> +		}
>> +	}
> 
> Any reason to not just keep the dma_token_to_blk_mq?  Also why is this
> overriding non-BLK_STS_AGAIN errors with BLK_STS_RESOURCE?

Yeah, it should've been errno_to_blk_status()

-- 
Pavel Begunkov


