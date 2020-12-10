Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0213C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 21:40:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F16A23DE3
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 21:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F16A23DE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RoJ9gLvJFYZnS9zVk+X/c5cJd5YsSkxEhiD4XNFykCM=; b=r6o9u1zKCu7SmNZVV6WoKlLuS
	nmtvL5XV3AcdNfJwA/FZgJvS1Z/QSjqEbeX/IZICQUCTlTD1/n2RZ5Rztagnn6V3ZSRNo4IBdMrlC
	fwwwj8hCnzgIcDSaFTk+qU34m6ZI6/o2FEN+FqeljcUmzgJeGRXWXwnumobpQoT32rYl1RQzJysLw
	qMeEJFpsFNN6Ph6NQkM59m0bD7qP3n+xjMpv9zff8rP2ZML8UIFsdj9wv+kmfplDXurzHES3GWSqo
	v8JdGbtQcTt++GX5zPejAzqbmlczSs1FfXRDr3RFjdS7znGgVznnzroFipBMv+wng9mVAo62GXdr3
	sv2MQpWfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knTfd-0008L8-5j; Thu, 10 Dec 2020 21:40:17 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knTfG-0008Bt-FY
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 21:40:05 +0000
Received: by mail-pl1-f193.google.com with SMTP id j1so3478004pld.3
 for <linux-nvme@lists.infradead.org>; Thu, 10 Dec 2020 13:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Xa0Z6JnothzxGaVbcOZowLXmNaWSWfJK0Sbv/ZxA3E=;
 b=kKR3kJTEKkmlmdh6EoNhKrCuBWRpeteuzgyFJV1SQGitAOvoeLO3ITbaYMhXYyeuIc
 bpKd2yBYR2l/vgpvWkmhZ9NNUO8tbg35j1F4i9SrGK8dSb5zXNdTzZddpE9YuIttfC2G
 MrvQOrHFg22pxtHw8oupbfaGAdKe2grG5CswbeIGl/saH17o8lIc8iHVPfyMAbJEc18J
 61VojgSzsqA6VenZ0eo4Y/mFAD3WC9qbsRHHqzcOcJbLecnyfjylP2RMEr4/DEoLCWS1
 YdJTQWW87qGqLN6DmMfk56CzfPt0k9qv4m8BIprya+gorivgeE8TVTR7MQpeuhKPrGAN
 1yyQ==
X-Gm-Message-State: AOAM530VPbnmADNitX6wcZso+N1UUrxE8q8IohhVGo2ijkqU/SLTkxVD
 tL9r1uKaaQA2zs1qdXAwJ4dhx2+/nbo=
X-Google-Smtp-Source: ABdhPJznZMHFFu1Q5PFWUUoSUz6aKj1XdjwnMpxycSO/sJ+GDtOi4tweEmdMagTrGgS0Bg1XD3otGw==
X-Received: by 2002:a17:902:b282:b029:da:fd05:7766 with SMTP id
 u2-20020a170902b282b02900dafd057766mr8020410plr.52.1607636390174; 
 Thu, 10 Dec 2020 13:39:50 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e186:2b8a:d435:6746?
 ([2601:647:4802:9070:e186:2b8a:d435:6746])
 by smtp.gmail.com with ESMTPSA id 77sm7553988pfv.16.2020.12.10.13.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Dec 2020 13:39:49 -0800 (PST)
Subject: Re: nvme-tcp: Queue deadlock (stuck PDU) on NVMe TCP host driver
To: Samuel Jones <sjones@kalrayinc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <253503002.21820362.1607631686785.JavaMail.zimbra@kalray.eu>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dfd08de7-afd7-d1c3-2f01-db93f53a67ea@grimberg.me>
Date: Thu, 10 Dec 2020 13:39:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <253503002.21820362.1607631686785.JavaMail.zimbra@kalray.eu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_163954_817392_655C9DAD 
X-CRM114-Status: GOOD (  34.73  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hi everyone,

Hey Samuel,

Thank you for reporting, this is consistent with what Potnuri reported.

> We are observing an issue when testing the Linux NVMe TCP host driver with a Kalray target, on Write workloads that are above the inline_data_size threshold. Sometimes the NVMe TCP host driver never replies to an R2T sent by the target, causing the command to time out and the connection to be destroyed. We have been able to verify that the R2T PDU is received by the Host and acknowledged to the target by the TCP stack, and that the R2T PDU is seen by nvme_tcp_handle_r2t(). However, the H2CData created by nvme_tcp_handle_r2t() is never pushed back into the TCP stack. We're using Linux 5.8.17 on the host, but the relevant code paths haven't changed significantly since as far as I can tell. The same tests using a different host stack (SPDK) work fine.
> 
> My understanding of the issue is as follows, I'd be grateful for any clarifications you can give me: Data reception and transmission is handled by a single function nvme_tcp_io_work which is scheduled on a workqueue. It can be scheduled by several sources:
> 
> 1. RX Data on the TCP socket
> 2. New TX space on the TCP socket
> 3. nvme_tcp_queue_request(): the driver has a new PDU to send
> 4. nvme_tcp_io_work reschedules itself if it thinks there is more work to be done
> 
> This means that the nvme_tcp_io_work can be called in parallel on different threads. To handle this, there is a mutex (send_mutex) for the transmission routines and the socket lock is taken for reception. However, different threads do not spin on the send_mutex, they simply call mutex_trylock(), and if they fail to take the lock, they just skip the TX stage. However, I believe that there is a race around the use of the send_mutex which can lead to data in the send_list being ignored, potentially indefinitely. Consider the following:
> 
> Thread 0                                                         |  Thread 1
> nvme_tcp_handle_r2t (from io_work)
> ---------------------------------------------------------------->
>                                                                   nvme_tcp_queue_rq (from blk io)
>                                                                   nvme_tcp_queue_request: adds entry to list
>                                                                   takes send_mutex
>                                                                   goes to sleep in kernel_sendpage
> <----------------------------------------------------------------
> gets queue->lock, adds entry into list
> schedules workqueue
> exit io_work
> re-enters io_work
> fails to get send_mutex
> exits io_work without rescheduling
>                                                                   sends one PDU from the list
>                                                                   releases send_mutex
>                                                                   exits without rescheduling
> 
> If this occurs, the H2CData PDU will not be sent until io_work is rescheduled. If we are lucky, this will happen soon, because of other activity on the socket (new responses from the target for example). If we are not, the H2CData PDU will never be sent and the queue is deadlocked. Eventually the block io timeout will kick in and tear down the queue.
> 
> I have not been able to prove formally that the above sequence is what we are observing. I have been able to test rescheduling the workqueue if the call to mutex_trylock() in nvme_tcp_try_send fails, which fixes the issue for us.
> 
> Furthermore, I have some doubts about the fact that nvme_tcp_queue_request does not check the return code of nvme_tcp_try_send. I believe the author assumed that, given the list is supposed to be non-empty, that there is no point in checking the return value. However, it appears to be me that nvme_tcp_try_send can return a transient failure - there is a code path that checks for EAGAIN in the sub-functions and returns 0 in this case. Surely we need to check the return value of nvme_tcp_try_send in nvme_tcp_queue_request and reschedule the workqueue if ret != 1 ? What's more, nvme_tcp_io_work only reschedules the workqueue if ret > 0, so we still have a problem if nvme_tcp_try_send morphs EAGAIN into 0, as the nvme_tcp_io_work won't reschedule the io_work...
> 
> What do you think? I'd be grateful for any comments you may have this.

I agree with the analysis.

I'm assuming that this patch makes the issue go away:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1ba659927442..9193b05d7bda 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1122,6 +1122,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
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
