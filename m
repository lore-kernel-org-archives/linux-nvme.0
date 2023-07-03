Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A81EEB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ehUXf2LNnInGH0Vqogp/lrUNeW1dVzwZ4KWyqlQvQjw=; b=GJ6k2mzExuCcmCRLAep1/qX4k2
	W7rHqkyDHbCiV3Kwc/NDS13QRPSqHWJ6pnahybfEJ+dh/6GhDp+gmSZVqoy4wUZRyILL7v+/5atQu
	srHC5xCm25X2WgtPqVTTEvMexr3DnroRjO/dzx2KqURj8chdONPzw6E7dqEkQ6XkiDc6hDKWxwG97
	zvtn7mxYTTTIbOwIwf1+3Ue7TmggEegy7xRm/OWXXHMzR42R3BN7NjH3Yaixlv7iobBIQAas83D11
	i7St3FYMfqioKCtC7aEhBu28/wu31UdSFyfrkiIX4ODR9Qby943W9MsUkuIjhTStdTQ2wrXXKY79A
	YILG4RCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGKFo-00Aj20-34;
	Mon, 03 Jul 2023 14:10:12 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGKFk-00Aj0x-0Q
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 14:10:09 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso13033685e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 07:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688393405; x=1690985405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehUXf2LNnInGH0Vqogp/lrUNeW1dVzwZ4KWyqlQvQjw=;
        b=SQIIOxhH2a+cJlAzwKsi0X/XCNbU5HbP+20AEZeTA1WQyjLt4i+kuMjS1Brk1E9NV8
         iFasPgKStoLfKP6kP/8ujmpWR+pMnj/3YWX9r9J0th8aQQWpXsZTu9Ah0fTo4QZFnz/N
         zZRwp0eWYFaTnrLDOIdCzzhhvNSjnISuV3cmUglxM4jRXmriNfgunSwJgPzzBShWqO1W
         AJ81S+v7ygLt8u1KLvWYeLmY0nupIOV0R5obkOu9UyyL0hFketfpP4HpW/CJtjoORn9g
         1AECZvb82gcp1Ph+eNgkYYE9kv8EhOr6xbufKUIuSlIUYpQdkGEOD4nqb4NDCCL6mleK
         4Mdg==
X-Gm-Message-State: ABy/qLZwxsjMwzLmMYth1YpLXhk9GthYf8UmUCwxKB/JP+V5R3rb1uFD
	0QF/qMMSiLJ4ySlg01SQUDg=
X-Google-Smtp-Source: APBJJlEbzcp+DsLfYrf5pTIlP/GB3g8HY7MTBgbpx9cZ7Hoofv7LOlgy5ET3UYJql70nVsK3BwaBPg==
X-Received: by 2002:a05:600c:1c0a:b0:3fb:a982:8f41 with SMTP id j10-20020a05600c1c0a00b003fba9828f41mr6654288wms.3.1688393405189;
        Mon, 03 Jul 2023 07:10:05 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r3-20020a056000014300b00314398e4dd4sm1812292wrx.54.2023.07.03.07.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:10:04 -0700 (PDT)
Message-ID: <40509bb4-3ca4-3bb1-3c28-1b0e90aa92be@grimberg.me>
Date: Mon, 3 Jul 2023 17:10:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
 <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
 <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
 <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
 <0ceb62b7-c310-cc4a-6b90-651e6b0c09ae@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0ceb62b7-c310-cc4a-6b90-651e6b0c09ae@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_071008_170668_5F0532D9 
X-CRM114-Status: GOOD (  13.94  )
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



On 7/3/23 16:57, Hannes Reinecke wrote:
> On 7/3/23 15:42, Sagi Grimberg wrote:
>>
>>>>> Hannes Reinecke <hare@suse.de> wrote:
>>>>>
>>>>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>>>>
>>>>> Can you be more specific about the crash?
>>>>
>>>> Hannes,
>>>>
>>>> See:
>>>> [PATCH net] nvme-tcp: Fix comma-related oops
>>>
>>> Ah, right. That solves _that_ issue.
>>>
>>> But now I'm deadlocking on the tls_rx_reader_lock() (patched as to 
>>> your suggestion). Investigating.
>>
>> Are you sure it is a deadlock? or maybe you returned EAGAIN and nvme-tcp
>> does not interpret this as a transient status and simply returns from
>> io_work?
>>
> Unfortunately, yes.
> 
> static int tls_rx_reader_acquire(struct sock *sk, struct 
> tls_sw_context_rx *ctx,
>                                   bool nonblock)
> {
>          long timeo;
> 
>          timeo = sock_rcvtimeo(sk, nonblock);
> 
>          while (unlikely(ctx->reader_present)) {
>                  DEFINE_WAIT_FUNC(wait, woken_wake_function);
> 
>                  ctx->reader_contended = 1;
> 
>                  add_wait_queue(&ctx->wq, &wait);
>                  sk_wait_event(sk, &timeo,
>                                !READ_ONCE(ctx->reader_present), &wait);
> 
> and sk_wait_event() does:
> #define sk_wait_event(__sk, __timeo, __condition, __wait)              \
>          ({      int __rc;                                              \
>                  __sk->sk_wait_pending++;                               \
>                  release_sock(__sk);                                    \
>                  __rc = __condition;                                    \
>                  if (!__rc) {                                           \
>                          *(__timeo) = wait_woken(__wait,                \
>                                                  TASK_INTERRUPTIBLE,    \
>                                                  *(__timeo));           \
>                  }                                                      \
>                  sched_annotate_sleep();                                \
>                  lock_sock(__sk);                                       \
>                  __sk->sk_wait_pending--;                               \
>                  __rc = __condition;                                    \
>                  __rc;                                                  \
>          })
> 
> so not calling 'lock_sock()' in tls_tx_reader_acquire() helps only _so_ 
> much, we're still deadlocking.

That still is legal assuming that sock lock is taken prior to
sk_wait_event...

What are the blocked threads from sysrq-trigger?

