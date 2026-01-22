Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F13C44500
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jan 2026 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/c04FssyRzWAvFZbUZZ5iSwy4KaO1b4NaDQ9GK8JLME=; b=21LZiDQPVE22vBx8guQafAlC8p
	N5mRHxKEaNbeT+CG+T1duT6cXv86oI7WGjX7E+F8wWkITeqzcgSuai6eU71xbWZ5s+3o0vRTMK2Jc
	bmu0/iqkSg3RwNySAjt/ZeFjnRJJtfrRBXVMdUWorXq4BCVun3ZqA2tyd+SYO1l+h/kgW2IURb0jc
	aOl4a0eu00YdoZOdTt/++2vvtpp1W07r2IQtbADKqJqsNWB9CB5fSno3VvdOyPgW4Erjgcmm/kSlc
	qL2TV5l89h4owJ0pogmTyvM4l7xj4SU6kdBM/zgYraSfTaR03gAkk5LEsXhM95n8qA0+Sbh878sxh
	pmEZd5NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vit9Y-00000006zcV-2wzk;
	Thu, 22 Jan 2026 11:47:08 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vit9V-00000006zbO-3Ius
	for linux-nvme@lists.infradead.org;
	Thu, 22 Jan 2026 11:47:07 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so613034f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 22 Jan 2026 03:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769082423; x=1769687223; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/c04FssyRzWAvFZbUZZ5iSwy4KaO1b4NaDQ9GK8JLME=;
        b=UiD6JqGV682jFRBMwkIDQUtHudqLMJyzl1np6qCZwbfQyAAPH2+FnIaGl7i6GSw9rl
         t1U/byBSDGOapZ1a5VegW9iim6iaVNZAtJBdfE//P7XnJR2lVwXhDLcBp9M91hqvvfn6
         6pBtRxQDdja0CFxE0D2bkmcwnqWA4OjfpK7UYk3/AHPIgGcEecpDjM/w9T3ykPoI51hV
         dfVlb1kLoQJrXOrtSt/d63Ed31PddPrvv0k5/zv4VOeo2r0wIaCJ/lWezHTQfSYCjy0M
         4Q/qmt0MaJzv7jhrUqSgfkbfhrv5pdnBBdviVwpY3wyf+R4TP7fHD/X5zQB9sg7awAS1
         dNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769082423; x=1769687223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/c04FssyRzWAvFZbUZZ5iSwy4KaO1b4NaDQ9GK8JLME=;
        b=P7aoNvum2hmwtNxDVfo6ev4BWTWpmR1C/Fd2aeYnzgBh/N0LtfWIEDm2ecIT5zZhMF
         wUHdnBotNavnFWdlR0pkasC+mBxPvvi1IPkqudrpUMh2fXA4GNnF4Cz/OO5v6O1f5mi4
         CkqG5w3bjbIQH/dKHtDmIz0eaczoXCySFuxorqKgBpcEIigovetAX8XI2Td3w4JYb99V
         EYr9vgyhbWPtmQryepcnud6DLhkmZ0hgrBtnB7bNm1P3edacBccTZ8rypMLwhNLY8z7v
         wJf0i5namarIjkRCPZgegY7CyGjQu1Tq5ABzWbsh4E/riZVFVOeehHyp6OVqmXjaV3JV
         7RiA==
X-Forwarded-Encrypted: i=1; AJvYcCV03DBEkef16fnGUUw/hh+i9fIFUaPvUB2T0zbFx4XNn+HU+OTjiHmfgKdtMPEastiFTJDB2+miDSaK@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/T/cpU4SS/N3UM8VBkQexz+tCKRKOJkXw1FgV4GhvHHFuhYCH
	1vxInl+q1Ool8KUT7erEgBtgN1UM1K9R2qbL+I/5FFwuRRZcZD+E3Wlp
X-Gm-Gg: AZuq6aLJFcaBctFe8tXL6bP/MKJTyNfJoQapg8t+2VyhPi5pgRe7rELLgx1c/7wFcZq
	79988zDV8wzJKUhYwCFth+WvgMICWkCQ4MgwiweROyD4I/VrYn1FHjM1UFDFcrabVGegbc89XKB
	jHfbzNIuWBs1Ed/bv/NwVxYMlD2aEj6ohFYXlBGHu754MYfgaJF0KZZN5VqgHD8o+KQeyrMmJfQ
	8d+CQWm/hA9nmuMu9wR8tP1DlxFb2ZwIsxZevCNoHB0/sbD0YuwclRxaPgMwUPEaXCRkwnSRXFx
	z/9yzBFQKN3y3mrW+8coTFMvN2A44tRdlvv0AlWdSTXxmuCLPKLIdbNiTojzSFeCEmTSwQcGaVq
	274BViOsRqaJMpwd7llyFbdKYfhI61Q1JcxfZYbko44t4+Gxi+Bqixz81vedRfqE+IKNdY/KBHq
	qFdUo+JJOxUJdEdaJHtjYuQ+go2w9dJdMBCGueJ/PrzXhod6PNYvrAdKg4r3hL+4O2+keh/xnh6
	3Hd+YIjYgNyogDbGYsGMpR4fJDQvnkIgnuuy2Wr4QSx/l0=
X-Received: by 2002:a05:6000:144b:b0:435:95ce:836e with SMTP id ffacd0b85a97d-43595ce838amr11818024f8f.55.1769082423045;
        Thu, 22 Jan 2026 03:47:03 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:46c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f138e26sm19447555f8f.17.2026.01.22.03.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 03:47:02 -0800 (PST)
Message-ID: <d3389449-f344-48ae-ab13-697e01d1cc46@gmail.com>
Date: Thu, 22 Jan 2026 11:46:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
 <CGME20260121074135epcas5p2eeb621d6acc9b4b73e6d45f5a40c078d@epcas5p2.samsung.com>
 <20260121073724.dja6wyqyf5apkdcx@green245.gost>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260121073724.dja6wyqyf5apkdcx@green245.gost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_034705_853516_971392B7 
X-CRM114-Status: GOOD (  22.46  )
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

On 1/21/26 07:37, Nitesh Shetty wrote:
> On 23/11/25 10:51PM, Pavel Begunkov wrote:
>> Add blk-mq infrastructure to handle dmabuf tokens. There are two main
>> objects. The first is struct blk_mq_dma_token, which is an extension of
>> struct dma_token and passed in an iterator. The second is struct
>> blk_mq_dma_map, which keeps the actual mapping and unlike the token, can
>> be ejected (e.g. by move_notify) and recreated.
>>
>> The token keeps an rcu protected pointer to the mapping, so when it
>> resolves a token into a mapping to pass it to a request, it'll do an rcu
>> protected lookup and get a percpu reference to the mapping.
>>
>> If there is no current mapping attached to a token, it'll need to be
>> created by calling the driver (e.g. nvme) via a new callback. It
>> requires waiting, thefore can't be done for nowait requests and couldn't
>> happen deeper in the stack, e.g. during nvme request submission.
>>
>> The structure split is needed because move_notify can request to
>> invalidate the dma mapping at any moment, and we need a way to
>> concurrently remove it and wait for the inflight requests using the
>> previous mapping to complete.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>> block/Makefile                   |   1 +
>> block/bdev.c                     |  14 ++
>> block/blk-mq-dma-token.c         | 236 +++++++++++++++++++++++++++++++
>> block/blk-mq.c                   |  20 +++
>> block/fops.c                     |   1 +
>> include/linux/blk-mq-dma-token.h |  60 ++++++++
>> include/linux/blk-mq.h           |  21 +++
>> include/linux/blkdev.h           |   3 +
>> 8 files changed, 356 insertions(+)
>> create mode 100644 block/blk-mq-dma-token.c
>> create mode 100644 include/linux/blk-mq-dma-token.h
>>
>> diff --git a/block/Makefile b/block/Makefile
>> index c65f4da93702..0190e5aa9f00 100644
...
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index f2650c97a75e..1ff3a7e3191b 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -29,6 +29,7 @@
>> #include <linux/blk-crypto.h>
>> #include <linux/part_stat.h>
>> #include <linux/sched/isolation.h>
>> +#include <linux/blk-mq-dma-token.h>
>>
>> #include <trace/events/block.h>
>>
>> @@ -439,6 +440,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>     rq->nr_integrity_segments = 0;
>>     rq->end_io = NULL;
>>     rq->end_io_data = NULL;
>> +    rq->dma_map = NULL;
>>
>>     blk_crypto_rq_set_defaults(rq);
>>     INIT_LIST_HEAD(&rq->queuelist);
>> @@ -794,6 +796,7 @@ static void __blk_mq_free_request(struct request *rq)
>>     blk_pm_mark_last_busy(rq);
>>     rq->mq_hctx = NULL;
>>
>> +    blk_rq_drop_dma_map(rq);
> blk_rq_drop_dma_map(rq), needs to be added in blk_mq_end_request_batch
> as well[1], otherwise I am seeing we leave with increased reference
> count in dma-buf exporter side.
> 
> Thanks,
> Nitesh
> 
> [1]
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1214,6 +1214,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
> 
>                   blk_crypto_free_request(rq);
>                   blk_pm_mark_last_busy(rq);
> +               blk_rq_drop_dma_map(rq);

Ah yes, thanks Nitesh

-- 
Pavel Begunkov


