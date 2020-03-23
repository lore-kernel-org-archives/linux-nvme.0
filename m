Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6DC4332B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 22:10:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6677C2070A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 22:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tCzf4atE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6677C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ygKovI+YubH7uAY2SVBMA07XyF8rgpllYkPqjDJJlXM=; b=tCzf4atEAuZJvfv9KogA7uAab
	NlUDAb+ni9vJKF43lzshVNhIz2flybLiGpR9TsNZ5GefYfevoDMj+pPl6Xg7+dSvdYCsBKLqaKKXO
	C6c1MpM48b+oGdHjZYuT6BQ9NRfcXP9uJVYvBd65K1qMmu7YMU0TxXAqZ9VJ4H5dho21H6TMiLiUa
	mUimkVICoo+ZYA0hWvVdSjQT66V8oyyPhw1jAc1/gIiTtajO79/Koxb+nyxAvfq/APZ9yfHQl3Gxh
	PJhEPS73CWu9ju4NJvEVYhRlNIEJKIBnD5cOievPe5mYHA7iR0uRvmpBd90lc2Nx/oiWZDfrkqgve
	ZKF2LAp5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGVGh-00026f-7d; Mon, 23 Mar 2020 22:09:59 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGVGe-00026L-6T
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 22:09:57 +0000
Received: by mail-wr1-f68.google.com with SMTP id s1so19122150wrv.5
 for <linux-nvme@lists.infradead.org>; Mon, 23 Mar 2020 15:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=N083mCU/+vZIm8oV5am+dngLZ0aVGPnEFqKPf/5QMPY=;
 b=jtRIyN8rtTv0iEhCtfzCTGh7mDMbIc34jzQMWQTL5OL7PSQzsRSvk3b5VtlfVHFfnA
 vFd9s+dJsj1rObCmfImmFJ1dZSdkZOdHv+bKhQmqLhW83/FL13/9/RkkXLC1/jPZ8iGx
 qJEM81H67dHWQeTCpk6TezM3+dOun+99c8MQddnXn3fxmlIjQLZvZrmISca5aaliN8uN
 ABJSmkU0V8p4ds8O93VfUt251i7Jm3fsYK6aBPjIr+VrLhEhZQeW55U9Vod0iO0YOu8a
 Rna+69kSq8dcmmZXTIaL6DL1rxiYmV+LUa9nWUq8P8QKd5cUxXbQs1sr95oGx5eC8pmR
 ESTA==
X-Gm-Message-State: ANhLgQ3Hn7K4rHEpocw108X2m7/dTPp/8zqYlTlqGitQu2FNlyuRtQK0
 5vSKqo7VY+KakleRuOa9rkU=
X-Google-Smtp-Source: ADFU+vu2Pwmy/4np/n2ipXrR8QNWjhP3HuBm8Fr/BzJdF53aKoQtckYFKHozCZpI7JdaaJT2p6d8HQ==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr27137652wrp.230.1585001394594; 
 Mon, 23 Mar 2020 15:09:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45a4:15de:f2dc:1149?
 ([2601:647:4802:9070:45a4:15de:f2dc:1149])
 by smtp.gmail.com with ESMTPSA id u13sm9345211wru.88.2020.03.23.15.09.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Mar 2020 15:09:53 -0700 (PDT)
Subject: Re: Sighting: Kernel fault with large write (512k) and io_uring
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
 <4eaa3e21-833d-f6ec-3b14-58dd2022a381@grimberg.me>
 <MW3PR11MB4684AC746EE60B9E5D0D46E1E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
 <82255be7-fb89-c66c-442e-6fe04239768c@grimberg.me>
 <52ce2f94-e11b-c537-63d2-e9b72cf1b00c@grimberg.me>
 <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <092f6922-ab29-c2bc-04b8-0d0c95c14ad6@grimberg.me>
Date: Mon, 23 Mar 2020 15:09:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MW3PR11MB46844ED6C11993D7F5D911A8E5F00@MW3PR11MB4684.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_150956_236815_43BE4538 
X-CRM114-Status: GOOD (  14.79  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Mark, does this patch make the issue go away?
>> --
>> @@ -2326,6 +2328,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx)
>>         struct nvme_tcp_queue *queue = hctx->driver_data;
>>         struct sock *sk = queue->sock->sk;
>>
>> +       if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>> +               return 0;
>> +
>>         set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>>          if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
>>                  sk_busy_loop(sk, true);
> 
> Do not see the fault (on first attempt),

OK, this is a needed fix then.

> but as part of error recovery the initiator is not
> able to reconnect with target.  Another separate issue?

Possibly,

> 
> [  304.395405] nvme nvme0: queue 5: timeout request 0x41 type 4
> [  304.395407] nvme nvme0: starting error recovery
> [  304.534399] nvme nvme0: Reconnecting in 10 seconds...
> [  314.636262] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
> [  314.636323] nvme nvme0: creating 102 I/O queues.
> [  378.117435] nvme nvme0: queue 5: timeout request 0x0 type 4
> [  378.123398] nvme nvme0: Connect command failed, error wo/DNR bit: 881
> [  378.123790] nvme nvme0: failed to connect queue: 5 ret=881
> [  378.124338] nvme nvme0: Failed reconnect attempt 1
> [  378.124339] nvme nvme0: Reconnecting in 10 seconds...
> [  388.357615] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
> [  388.357670] nvme nvme0: creating 102 I/O queues.
> [  451.848084] nvme nvme0: queue 5: timeout request 0x0 type 4
> [  452.096044] nvme nvme0: Connect command failed, error wo/DNR bit: 881
> [  452.096428] nvme nvme0: failed to connect queue: 5 ret=881
> [  452.096762] nvme nvme0: Failed reconnect attempt 2
> [  452.096763] nvme nvme0: Reconnecting in 10 seconds...
> 
> And of coarse this does not explain why we have to initiate error recovery
> In the first place.

Yes, this is with nvme-5.7 tree right? which is currently based of
5.6.0-rc4 correct?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
