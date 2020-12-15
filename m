Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B3FC4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 01:53:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F10122483
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 01:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F10122483
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jv8ZeS2gfkXnT4Dp0MS18ITHWd+8fXs622j3q2WBzIs=; b=ba7cmsDUyYC9tM0hw8KAX/Kcl
	m/20sdf09Pjs2Otj11Daua65mICu7Y5ZVb5hL5ynNlid7TdndZ6EQ6cIgvdRQKx9VBup8OUAKytgg
	DDIuS6FacF3x1Qnl3Xk5QvxEeOCTIaFj9rks9uR79TEX/sRB8+TDdPxmdwqcjxVp6ikNBvTv9tA02
	wenKSYimxXNkKiMAY28wcPn1oKz1WSpNvNgwYZ4O+5HWHFDrxLB5gTAxqAdwEfQvP5KDFo8tN+v3n
	YPdj5dT6ArbGnWypbY2eZXWqPDKJTvv+1vyz5kYsWhzPV/cat5NPH1Agc2iNZBXjhaAezgryWjoWG
	AF4Edw9CQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kozXC-0007cM-PB; Tue, 15 Dec 2020 01:53:50 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kozXA-0007bz-7q
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 01:53:49 +0000
Received: by mail-pf1-f193.google.com with SMTP id c12so13478195pfo.10
 for <linux-nvme@lists.infradead.org>; Mon, 14 Dec 2020 17:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tUxNDETj9tZBTd4kjdqQePsAnL+hglxSw0dmcL49Q3I=;
 b=IBolH2pJ+tAVe29J7bRH5IhlWuAU/Sej5OprC3NLVHRKWVIAY6CdvhO6kIa/PyB6Fq
 Qfc34irD+1I014qESezzIWfrp2OJypup6vZgbrlFfv9fDQuXvUHBxCWuaEB0i9nf/hbz
 ITcCo8qXeUbOtXImTZ/AAvh7TVCdMvA89twtrjnwqL3owPP+LbywWQ0XXD+CLaqGaQeU
 uIQIOPOGyyXRNUzfG0/bbGL7A2TcKfHbL9xPYbQqR/lNKsxpMiqQQkUgDz9HtX48lSmz
 4ZiXHd+rqJzjrY7LaYYV9qwfh9VPyjSNG/rZNWUvYug81PWLR3iySaRrFAyihfTlZEPA
 zjrg==
X-Gm-Message-State: AOAM533bSw4Tsc77YX+ThS0XhNDrFQY1ZkNYi/4LdJ+izJnCA/K0ZQie
 H315+cRK0yR/e7EPne9m4NygRlkkXso=
X-Google-Smtp-Source: ABdhPJztZ0ylDbL093ztD6NDXOyeRvepdKR6u2ggBob2OW8r8VzBloWi3Nd5usRnps4Lv0aCSKNaqA==
X-Received: by 2002:a63:4504:: with SMTP id s4mr7961502pga.284.1607997226523; 
 Mon, 14 Dec 2020 17:53:46 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:b6ef:7a90:5c54:72f9?
 ([2601:647:4802:9070:b6ef:7a90:5c54:72f9])
 by smtp.gmail.com with ESMTPSA id m8sm1196591pjr.39.2020.12.14.17.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Dec 2020 17:53:45 -0800 (PST)
Subject: Re: Request timeout seen with NVMEoF TCP
From: Sagi Grimberg <sagi@grimberg.me>
To: Potnuri Bharat Teja <bharat@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
 <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
Message-ID: <a204cb8e-6f3b-b5dc-9972-54651c9c75cc@grimberg.me>
Date: Mon, 14 Dec 2020 17:53:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_205348_333170_DF75F4C9 
X-CRM114-Status: GOOD (  21.59  )
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
Cc: Samuel Jones <sjones@kalrayinc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hey Potnuri,
> 
> Have you observed this further?
> 
> I'd think that if the io_work reschedule itself when it races
> with the direct send path this should not happen, but we may be
> seeing a different race going on here, adding Samuel who saw
> a similar phenomenon.

I think we still have a race here with the following:
1. queue_rq sends h2cdata PDU (no data)
2. host receives r2t - prepares data PDU to send and schedules io_work
3. queue_rq sends another h2cdata PDU - ends up sending (2) because it 
was queued before it
4. io_work starts, loops but never able to acquire the send_mutex - 
eventually just ends (dosn't requeue)
5. (3) completes, now nothing will send (2)

We can either schedule the io_work from the direct send path, but that
is less efficient than just trying to drain the send queue in the
direct send path and if not all was sent, the write_space callback
will trigger it.

Potnuri, does this patch solves what you are seeing?
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ba659927442..1b4e25624ba4 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -262,6 +262,16 @@ static inline void nvme_tcp_advance_req(struct 
nvme_tcp_request *req,
         }
  }

+static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
+{
+       int ret;
+
+       /* drain the send queue as much as we can... */
+       do {
+               ret = nvme_tcp_try_send(queue);
+       } while (ret > 0);
+}
+
  static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
                 bool sync, bool last)
  {
@@ -279,7 +289,7 @@ static inline void nvme_tcp_queue_request(struct 
nvme_tcp_request *req,
         if (queue->io_cpu == smp_processor_id() &&
             sync && empty && mutex_trylock(&queue->send_mutex)) {
                 queue->more_requests = !last;
-               nvme_tcp_try_send(queue);
+               nvme_tcp_send_all(queue);
                 queue->more_requests = false;
                 mutex_unlock(&queue->send_mutex);
         } else if (last) {
@@ -1122,6 +1132,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
                                 pending = true;
                         else if (unlikely(result < 0))
                                 break;
+               } else {
+                       /*
+                        * submission path is sending, we need to
+                        * continue or resched because the submission
+                        * path direct send is not concerned with
+                        * rescheduling...
+                        */
+                       pending = true;
                 }

                 result = nvme_tcp_try_recv(queue);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
