Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C23CC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBrbJgpjroKF92elbEfX0nEf7EwnXpqdK0a2jCtYn84=; b=ePhWBFwpXmkiwn2r/2NZHNP4k0
	+HvJWAjIxYj5D30o6sCpkN5klDakF53i4iixtB0NSuVe3gHqpGeMUBpGQ9IlyjoWLWR1T49Q6JFxi
	6BzPdA+/MMHVvFmyhA2VPZRoY5t5N0GpmnbiRJayuaJxgCfFKfbLTmtqmEK3GWqja5dPiwNU05pve
	Y0+NQOce4bL7Ri4KoAk06laeNvgxox8/8q/9wGoTsshapfNlC4Ivd5jcr4bJ1r9oxy0m0hDielgSV
	gNvpfb75P9QGVEBkepc8nDC51NGyFZiNi2PT4Gxob2s/Ad2rWKT69hg+oxy468Wm6UOPTBkRGW1+d
	BWSGaBNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxTh-00000001rwd-29SE;
	Wed, 19 Jun 2024 15:44:05 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJxTc-00000001run-3ntU
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 15:44:04 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f1c7d1286so512474f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jun 2024 08:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811839; x=1719416639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBrbJgpjroKF92elbEfX0nEf7EwnXpqdK0a2jCtYn84=;
        b=mi334Fk2pLTrCguVl0HM8toTjobFRniDmDqd+i6vAfX8HNwGicvHFJHQrc0yy3V82g
         ca/tA0VIO+Hjbn2I6oj/NAfM8epjxs+hDS805IhKaVpuSo4WLwQjyMNBB1wS8yFAEfYf
         VmqvZ8xTcYMhj3SUX1UxncSfaK4uIpVe9E1dN1qrVQq4aHimUoDHbtqeRaHdyOcqbIyf
         ebMgefZ2LWuAfw9+iW1q2sd1eeT8fOsghWBYWVS9LGI4NGiXZxADI2VbtfdhZWszc/oL
         dlP/z7WLEJDEMFAfhv7fP39oqH7sQyNoD3OpaASg2GknQEL4DLe1gm1JG15PHojMw6Qd
         JUSg==
X-Forwarded-Encrypted: i=1; AJvYcCVmrJ+npbPcWplxCeP0j+z1iH5/eXepS1QQewto7yQ+7pAZWqfXJNqh5vShKpmCz3Pb2z1aEbKVnBYvn9+YBO9RdN3FE+75r/7UOLQil24=
X-Gm-Message-State: AOJu0Yw4cLPF7qXJReZt40uk6L1mBVhav52Jd4fBlWSElVfbWPnfsmx8
	P8jUzR+T9DhQlP6Xpy5PzHoB1miNhFkIu4GkodBoMjrlWWWw2LCo
X-Google-Smtp-Source: AGHT+IEx7c+jLT7XjwlW339sXTSaIWcEt8ISf7dWsqmFjCIQiUL4TD+xa7izNp1YxfOjS3ty33vWSw==
X-Received: by 2002:a05:600c:1c29:b0:423:445:4aaf with SMTP id 5b1f17b1804b1-424750148ffmr20427525e9.0.1718811838832;
        Wed, 19 Jun 2024 08:43:58 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609aa60a59sm6828158f8f.84.2024.06.19.08.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:43:58 -0700 (PDT)
Message-ID: <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
Date: Wed, 19 Jun 2024 18:43:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de> <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_084400_969110_8A4E99EE 
X-CRM114-Status: GOOD (  29.57  )
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



On 19/06/2024 18:23, Hannes Reinecke wrote:
> On 6/19/24 16:59, Christoph Hellwig wrote:
>>>       if (wq_unbound)
>>>           queue->io_cpu = WORK_CPU_UNBOUND;
>>
>> None of the above computed information is even used for the wq_unbound
>> code.  This would make a lot more sense if the above assignment was in
>> the (only) caller.
>>
>> Yes, that probably should have been done when merging the wq_unbound
>> option (which honestly looks so whacky that I wish it wasn't merged).
>>
> Ah, you noticed?
>
> This patch is actually got sparked off by one of our partners notifying
> a severe latency increase proportional with the number of controllers.
> With a marked increase when (sw) TLS is active; they even managed to run
> into command timeouts.
>
> What happens is that we shove all work from identical queue numbers 
> onto the same CPU; so if your controller only exports 4 queues _all_ 
> work from qid 1 (from all controllers!) is pushed onto CPU 0 causing a 
> massive oversubscription on that CPU and leaving all other CPUs in the 
> system idle.

I see how you address multiple controllers falling into the same 
mappings case in your patch.
You could have selected a different mq_map entry for each controller 
(out of the entries that map to the qid).

>
> Not sure how wq_unbound helps in this case; in theory the workqueue
> items can be pushed on arbitrary CPUs, but that only leads to even worse
> thread bouncing.
>
> However, topic for ALPSS. We really should have some sore of 
> backpressure here.

I have a patch that was sitting for some time now, to make the RX path 
run directly
from softirq, which should make RX execute from the cpu core mapped to 
the RSS hash.
Perhaps you or your customer can give it a go.

disclaimer, lightly tested:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b6ea7e337eb8..02076b8cb4d8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -44,6 +44,13 @@ static bool wq_unbound;
  module_param(wq_unbound, bool, 0644);
  MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO 
context (default false)");

+/*
+ * RX context runs in softirq
+ */
+static bool softirq_rx;
+module_param(softirq_rx, bool, 0644);
+MODULE_PARM_DESC(softirq_rx, "nvme-tcp RX context in softirq");
+
  /*
   * TLS handshake timeout
   */
@@ -976,8 +983,13 @@ static void nvme_tcp_data_ready(struct sock *sk)
         read_lock_bh(&sk->sk_callback_lock);
         queue = sk->sk_user_data;
         if (likely(queue && queue->rd_enabled) &&
-           !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
-               queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+           !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
+               if (softirq_rx)
+                       nvme_tcp_try_recv_locked(queue);
+               else
+                       queue_work_on(queue->io_cpu, nvme_tcp_wq,
+                               &queue->io_work);
+       }
         read_unlock_bh(&sk->sk_callback_lock);
  }

@@ -1291,11 +1303,13 @@ static void nvme_tcp_io_work(struct work_struct *w)
                                 break;
                 }

-               result = nvme_tcp_try_recv(queue);
-               if (result > 0)
-                       pending = true;
-               else if (unlikely(result < 0))
-                       return;
+               if (!softirq_rx) {
+                       result = nvme_tcp_try_recv(queue);
+                       if (result > 0)
+                               pending = true;
+                       else if (unlikely(result < 0))
+                               return;
+               }

                 if (!pending || !queue->rd_enabled)
                         return;
--

Note, I don't yet know if this behavior should go conditional behind a 
parameter, or
simply replace the existing behavior.

Note that it depends on a patch I've sent (and will need to send a v2 for):

lore.kernel.org

[PATCH] net: micro-optimize skb_datagram_iter <#>

🔗 https://lore.kernel.org/netdev/20240617095852.66c96be9@kernel.org/T/ 
<https://lore.kernel.org/netdev/20240617095852.66c96be9@kernel.org/T/>


