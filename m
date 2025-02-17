Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100CCC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 07:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fR4NFxuWiqBPtXAx9wkbxWarDCW/Qvh21Mv1E4CO5ZQ=; b=VJeuJjJr53+9RD5NJXgWif4b6q
	gKpSfPA/PIGwciBqcmLYw05DgCvORwAbGU935eaTh3eJb6IGGVrAew0Yv988uQA/Wc70BiKQtffnl
	clg8tZioakcnkKH/H6BwZ3B3izf/uD3jgpbKFTrqoK9sVBR3JsqGt5Ovmulv0vjiqWIT+SplMAroq
	2+xSBkfJmo0QsgP6wMZyoN6MT/uwFja2bcHAdlnWy72WvXf6Xr4phbWrC7/uUIbTHZ4rbXUVLjJ24
	8s0mtiLO3i2C8Lm0nj0InoFfv141ARIaCOMgS3qSmGLNY0lZS50TpoCRgTRFM8rgWhj/n1Jbr/TwN
	pWaJ3zAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvqH-00000003eQl-3T74;
	Mon, 17 Feb 2025 07:47:01 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvqE-00000003eQA-4AKK
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 07:47:00 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4397dff185fso7746365e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 16 Feb 2025 23:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778417; x=1740383217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fR4NFxuWiqBPtXAx9wkbxWarDCW/Qvh21Mv1E4CO5ZQ=;
        b=Rm0aSJn+oul6mQHx8hgJbfz1FgmrrsLk0HIccCCE/85hQOLUPiOhnj5j/T+JT2GWd2
         ZMVJKOAYzCDKmRr58ltOesjUY2DMQXdGaWetCMlf+EWR1C2ts55p+mc36qBGTeJEnznn
         +3m1881Q855Q8AvCbxSBVwhWFeSdutCD5hx2wChTE4HpHOrhAEf3wRXdqLLSrFlexTFf
         raHrwbqdMcLqaBbQShE3hb/HXbSs+8YsUqPMe0FhQI9N6vthHlIIeBGljlwKO/sesq0x
         eIoaj/YqgnF9zdsOeQI4qt4cnuz8UdVrd/73iYakE5vuFJflayFFjor7tpjWLNbFYvHV
         RI0A==
X-Forwarded-Encrypted: i=1; AJvYcCVvg936KyaJIvrU0DCWsqJJDYxON8gwJQVUl4Cljx6F6R3Nnow4Le/9+MA18bOSszNNsAXKA+u0uG2S@lists.infradead.org
X-Gm-Message-State: AOJu0YyMAQqYiISWK5yr9vfqFv9crAZIGu0HXIpueUSvYkWSNg9sgxBw
	XGhmfFRFRtcUXpEJu98C48bw/P9hW5isIU8TSvkgqyIAB7X91tAR
X-Gm-Gg: ASbGncvq10JKDcH0IUHErUXmMlv8nM9t2amrkFENFNMp/RoH2cj29Ryr2r4F7JT0OHe
	zfERqz87+cEFd5ByGquz4peoN7wyzBu6jxzFwWTda+HI/xBDnEUj805NTK8PgqBhBUWDgFgrjDA
	/fI0bs1++lCIBtHWii8ARjGAzwG+RVFiepbFijCPz8IvP+Nj4QPzvXpzyXN3JFiw7Sj8pYZZKK6
	Ym8IgNi6HTLwYufPgYEtFw5I7GAv+qQ0i0VpexfS4inXt7ML4ELJhXaI5X11mVf/kPcmnUDwshh
	Ppb72laBejarqTsNYP0FS1gbOIgwy/CB/QgNqUlEZhJyUv/0KeDVo/r2hA==
X-Google-Smtp-Source: AGHT+IFTyXYgme3ewuDw6Ewz/zTtLzn9WnLnVAoLj/JUS8cfpqVznqbExQI7kKDa0eJV3cJ1O50wQg==
X-Received: by 2002:a05:600c:3106:b0:439:6619:9c1c with SMTP id 5b1f17b1804b1-4396e6d9a8bmr80630955e9.18.1739778416737;
        Sun, 16 Feb 2025 23:46:56 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43987088ecbsm13388325e9.31.2025.02.16.23.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:46:56 -0800 (PST)
Message-ID: <aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
Date: Mon, 17 Feb 2025 09:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>,
 mgurtovoy <mgurtovoy@nvidia.com>, kbusch <kbusch@kernel.org>,
 sashal <sashal@kernel.org>, "chunguang.xu" <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <2025021015413817916143@cestc.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2025021015413817916143@cestc.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_234659_029997_A09A8FE8 
X-CRM114-Status: GOOD (  17.44  )
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




On 10/02/2025 9:41, zhang.guanghui@cestc.cn wrote:
> Hello
>
>
>
>      When using the nvme-tcp driver in a storage cluster, the driver may trigger a null pointer causing the host to crash several times.
>
>
>
> By analyzing the vmcore, we know the direct cause is that  the request->mq_hctx was used after free.
>
>
>
>
>
> CPU1                                                                   CPU2
>
>
>
> nvme_tcp_poll                                                          nvme_tcp_try_send  --failed to send reqrest 13
>
>
>
>      nvme_tcp_try_recv                                                      nvme_tcp_fail_request
>
>
>
>          nvme_tcp_recv_skb                                                      nvme_tcp_end_request
>
>
>
>              nvme_tcp_recv_pdu                                                      nvme_complete_rq
>
>
>
>                  nvme_tcp_handle_comp                                                   nvme_retry_req -- request->mq_hctx have been freed, is NULL.
>
>
>
>                      nvme_tcp_process_nvme_cqe
>
>
>
>                          nvme_complete_rq
>
>
>
>                              nvme_end_req
>
>
>
>                                    blk_mq_end_request
>
>
>
>
>
>
>
> when nvme_tcp_try_send failed to send reqrest 13, it maybe be resulted by selinux or other reasons, this is a problem. then  the nvme_tcp_fail_request would execute。
>
>
>
> but the nvme_tcp_recv_pdu may have received the responding pdu and the nvme_tcp_process_nvme_cqe would have completed the request.  request->mq_hctx was used after free.
>
>
>
> the follow patch is to solve it.

Zhang, your email client needs fixing - it is impossible to follow your 
emails.

>
>
>
> can you give  some suggestions?  thanks!

The problem is the C2HTerm that the host is unable to handle correctly.
And it also appears that nvme_tcp_poll() does not signal correctly to 
blk-mq to stop
calling poll.

One thing to do is to handle C2HTerm PDU correctly, and, here is a 
possible fix to try for the UAF issue:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c637ff04a052..0e390e98aaf9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2673,6 +2673,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
*hctx, struct io_comp_batch *iob)
  {
         struct nvme_tcp_queue *queue = hctx->driver_data;
         struct sock *sk = queue->sock->sk;
+       int ret;

         if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
                 return 0;
@@ -2680,9 +2681,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx 
*hctx, struct io_comp_batch *iob)
         set_bit(NVME_TCP_Q_POLLING, &queue->flags);
         if (sk_can_busy_loop(sk) && 
skb_queue_empty_lockless(&sk->sk_receive_queue))
                 sk_busy_loop(sk, true);
-       nvme_tcp_try_recv(queue);
+       ret = nvme_tcp_try_recv(queue);
         clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-       return queue->nr_cqe;
+       return ret < 0 ? ret : queue->nr_cqe;
  }

  static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int 
size)
--

Does this help?

