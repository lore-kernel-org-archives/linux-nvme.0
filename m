Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEFDC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 06:21:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 232966520F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 06:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 232966520F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+9wUu9jZEGn7DnXQ+Uwd+fvkV6ayxzV0s0ltv50hUGs=; b=GJBzEtlAZeslfw5QzNrfIwoYp
	qWrFHGEG2Ur7Y9M3FgbMOVgw298ZxYSxncEudTP7nEea6POzE/uPJM6CWVJxklcRptgdMBrnUEwNe
	838yAP/J68yhrcrUlZJNlan9YbOAJKMGzGJUAHFrX4H1NaN3I3bl0GE8kIJatsE/khg8jk3316laT
	tYnw6ex6GS+rpLzArCriDBzSY7preTstAF6s1HfezonhtheSv31ybNSqddRY8QnLzeEoJm8F7NM5u
	e/To3paSlHCpLvrwgkxDIdT9TPWXz9YjH4qyS5foomNI3Fxt9ucLppFoHmvK8TKQtL11JUqIKdZT0
	X6Aig8TXw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM35E-00HW6B-FW; Tue, 16 Mar 2021 06:21:36 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM359-00HW5g-Fw
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 06:21:33 +0000
Received: by mail-pj1-f45.google.com with SMTP id s21so10075633pjq.1
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 23:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uXnNYpQzSReTM3TOHCD2DvkByd0UHnASPS0jqf5rz3M=;
 b=t8yTcc+5gli90pIt79y3BPIjlBxOkWBXpBIr6itSXUr0tWkGn6yLv9Oq6ow1QsUxYj
 spNBu+Ned0RXMO6hJCv73mJBE1ErOnN6+y8gkF2FK2WM6PJZqZ/d7i7UGGwcFex0OZiA
 3xUmTPHOFCbIvPqsIP9NHTZwHI1f3umVY0p/VzTuYYo06SzsbUD+Hf6QK40V5o0drjiM
 HCt9oQ1djiwCmpWUVUz7i/ULLhBJ50OTArWXzmIloKPJe79dk/8eWQeOwBjMVuQJxWLv
 BnUu2gQ03fPpsn+qTTKEEZ7PlGiHJRw+B0agTtaklgkV1WTmfW5jP6PH44hZ/Th84564
 lqfg==
X-Gm-Message-State: AOAM533G5sYXMiFZUCGHVhIkXm7d2p32CH2m+Bsrj8crTkkXpBveFYeJ
 NdIdzJi6LLeZwzpYIFWVoBs/9esJnSM=
X-Google-Smtp-Source: ABdhPJxR+adAE0yWQ/BeJ3k6OqT79UtfDWINjTm2bgFdcxGyKuRE7DISnLRX+WU02Ok9PYssHKWkag==
X-Received: by 2002:a17:90a:8a0f:: with SMTP id
 w15mr3112389pjn.200.1615875689714; 
 Mon, 15 Mar 2021 23:21:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id u2sm1595263pjy.14.2021.03.15.23.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 23:21:29 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210113115152.69692-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <28156d77-5346-03f9-bc3a-2c19417aa0d2@grimberg.me>
Date: Mon, 15 Mar 2021 23:21:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210113115152.69692-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_062131_618118_BB132A51 
X-CRM114-Status: GOOD (  26.38  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Elad Grupi <elad.grupi@dell.com>
> 
>      In case there is an io that contains inline data and it goes to
>      parsing error flow, command response will free command and iov
>      before clearing the data on the socket buffer.
>      This will delay the command response until receive flow is completed.
> 
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>

Hey Elad,

I just realized that this patch was left unaddressed.

> ---
>   drivers/nvme/target/tcp.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index d535080b781f..dea94da4c9ba 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -146,6 +146,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_queue_response(struct nvmet_req *req);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -476,7 +477,11 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
>   		nvmet_setup_c2h_data_pdu(queue->snd_cmd);
>   	else if (nvmet_tcp_need_data_in(queue->snd_cmd))
>   		nvmet_setup_r2t_pdu(queue->snd_cmd);
> -	else
> +	else if (nvmet_tcp_has_data_in(queue->snd_cmd) &&
> +			nvmet_tcp_has_inline_data(queue->snd_cmd)) {
> +		nvmet_tcp_queue_response(&queue->snd_cmd->req);
> +		queue->snd_cmd = NULL;

Perhaps instead of rotating the command on the list, maybe
instead don't queue it in queue_response but rather
only when you complete reading the garbage?

Something like the following:
--
@@ -537,6 +537,12 @@ static void nvmet_tcp_queue_response(struct 
nvmet_req *req)
                 container_of(req, struct nvmet_tcp_cmd, req);
         struct nvmet_tcp_queue  *queue = cmd->queue;

+       if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
+                    nvmet_tcp_has_inline_data(cmd))) {
+               /* fail the cmd when we finish processing the inline data */
+               return;
+       }
+
         llist_add(&cmd->lentry, &queue->resp_list);
         queue_work_on(queue_cpu(queue), nvmet_tcp_wq, 
&cmd->queue->io_work);
  }
@@ -1115,9 +1121,11 @@ static int nvmet_tcp_try_recv_data(struct 
nvmet_tcp_queue *queue)
         }
         nvmet_tcp_unmap_pdu_iovec(cmd);

-       if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-           cmd->rbytes_done == cmd->req.transfer_len) {
-               cmd->req.execute(&cmd->req);
+       if (cmd->rbytes_done == cmd->req.transfer_len) {
+               if (cmd->flags & NVMET_TCP_F_INIT_FAILED)
+                       nvmet_tcp_queue_response(&cmd->req);
+               else
+                       cmd->req.execute(&cmd->req);
         }

         nvmet_prepare_receive_pdu(queue);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
