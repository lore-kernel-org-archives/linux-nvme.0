Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D876C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnHAzUmYmHyiou7htb9izLcLP4Hb0p+wQ9+wsknUGE4=; b=Nxg0zRqSZ4rhujw2ur7RXi8DNt
	or5wKcikWX0FFm6W4ZEU/BNdzjAC/Zxe0XTnGSDU9o5m+TJ0D9I2X9ULNliQsk9/nBwWZSt2kQSQH
	Wcc2GHHW5jn4T8C6fJlu/r/MjNo512kcfLs1Uy1dfwQdAiCWbAvwzw21abbTa9t8p0GFW+2+jYpOn
	qSNCc9qw5hIlsWSjhWzmk/kQDPaLJTMFsSkGbDVGSSc7und5ZfQPAkfCb6cRU8jtb/xqreOU6NtPC
	8KeH+KG6eRFU+NLB4Kd0x0vprSs8juC1diBv0JlUESTaWXsMJJgeilL7b2VP2tJnmgVBrNHFi4UY2
	RWVQ9Z2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpRfX-001Ovn-SL; Tue, 23 Nov 2021 09:00:51 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpRfV-001Oub-9a
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 09:00:50 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 p27-20020a05600c1d9b00b0033bf8532855so1347718wms.3
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 01:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OnHAzUmYmHyiou7htb9izLcLP4Hb0p+wQ9+wsknUGE4=;
 b=modslTBNjNAa0II3bc7P2vNYECpeEYlVB8BjkoEizKqAMaqL95HPRc44kIz77xODpF
 JSI/4UX49dVrly0RcaDA3t0eGqguzuPK5gHNmjvd/TtmgEPX7VOl+R97SesQXk0GmzJ3
 aKBPrEVig/8EhhqhMJ6PJoEBU2ia30FfJqKE82AxcAZ6pCyYm77odLGVvElhzj9n6KZW
 JRUmHbFxcmIUzmbruLhg94ix2qLxJPBjmJRdJhsUbX732b1V2zzLVX8OkepqZdjFOOVK
 FZTXSmFWV+33K+Ze8fgQ902wdTevdbgFeAfncQW5/b6zu4ebVocg83IQEQ5SgPvQmc0n
 24xQ==
X-Gm-Message-State: AOAM533rPUvGAir3HbDyG+21W0EUUnef76W8EyLIkTX7nEY+OsiJmPKo
 XTUEWm8WJWbLxsvnJEJUIzs=
X-Google-Smtp-Source: ABdhPJwoOdRL+1nkU4Ok1N37YLzlgzH2jXbsbn+xRIeN0SH5D+6MY87SVdPsc1gbpEjJ16zy+tlbjw==
X-Received: by 2002:a05:600c:511c:: with SMTP id
 o28mr1122946wms.96.1637658047316; 
 Tue, 23 Nov 2021 01:00:47 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g18sm614107wmq.4.2021.11.23.01.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 01:00:46 -0800 (PST)
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
 <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me> <YZuagPbZJ6CjiUNi@T590>
 <38b9661e-c5b8-ae18-f2ab-b30f9d3e7115@grimberg.me> <YZwzEBtFug6JEmMZ@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a3ea006a-738b-af69-4dd5-f33444e3559d@grimberg.me>
Date: Tue, 23 Nov 2021 11:00:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZwzEBtFug6JEmMZ@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_010049_394199_8FB3DE8F 
X-CRM114-Status: GOOD (  18.13  )
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


>>>>> Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
>>>>> queues in parallel, then we can just wait once if global quiesce wait
>>>>> is allowed.
>>>>
>>>> blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
>>>> obviously it has a scope.
>>>
>>> How about blk_mq_shared_quiesce_wait()? or any suggestion?
>>
>> Shared between what?
> 
> All request queues in one host-wide, both scsi and nvme has such
> requirement.
> 
>>
>> Maybe if the queue has a non-blocking tagset, it can have a "quiesced"
>> flag that is cleared in unquiesce? then the callers can just continue
>> to iterate but will only wait the rcu grace period once.
> 
> Yeah, that is what these patches try to implement.

I was suggesting to "hide" it in the interface.
Maybe something like:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8799fa73ef34..627b631db1f9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -263,14 +263,18 @@ void blk_mq_wait_quiesce_done(struct request_queue *q)
         unsigned int i;
         bool rcu = false;

+       if (!q->has_srcu && q->quiesced)
+               return;
         queue_for_each_hw_ctx(q, hctx, i) {
                 if (hctx->flags & BLK_MQ_F_BLOCKING)
                         synchronize_srcu(hctx->srcu);
                 else
                         rcu = true;
         }
-       if (rcu)
+       if (rcu) {
                 synchronize_rcu();
+               q->quiesced = true;
+       }
  }
  EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);

@@ -308,6 +312,7 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
         } else if (!--q->quiesce_depth) {
                 blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
                 run_queue = true;
+               q->quiesced = false;
         }
         spin_unlock_irqrestore(&q->queue_lock, flags);
--

