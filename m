Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEEAECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cGZLr0reqe+68/6kMB893uKKNEYzze3SSuPdPRuaEDQ=; b=4RqPIw7ZRC0MlZL39obFy6tS/f
	JESyYT2MswO0tdLIC3QUG6EZIeR5dZwJEMm8GgPqOVOBtFNOco3/fYei6j+AUWSJZXXZp3Uyn1zag
	OsPhC5vOlCZE5jxQOHE8RTjxZX4uWVwMDIkt2DjbL36hHJyt4iQZHBroe243a5eevxZ8EtAv1ta+k
	9LJElXhLBIUFhaaP0wCOxuC0gD5INA/wMbaiUOgou49AwQNylJC0PGD76yv56+XJA+oCKSGFdB26s
	JlzPIFgiTWV2dZYbMdjl+icMm6X54hVsiIAoSu5xnJId/I6V3YphibUWQ9muWcRky6ERKD6nKMmro
	uJy2krXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVC6b-0039ZO-EI; Mon, 05 Sep 2022 13:25:37 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV8gl-00Gl9Z-Nf
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 09:46:48 +0000
Received: by mail-wm1-f46.google.com with SMTP id ay12so4959359wmb.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 02:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cGZLr0reqe+68/6kMB893uKKNEYzze3SSuPdPRuaEDQ=;
        b=d82vq0xYPZeDiUEwSDWJqeaEMzclcUiq/BaAO0/1eET0WQciHS/3grgqkzSKJSriRM
         3t34bYwl85FNsnKJQiSrngB0RblLwDro/cK3tDgU3/0PUZ0gskktWmL+aCIetgDP10xN
         WL03L4AKfyuRIyea76MLpQYf3O8xmJ/SoX9JTPVXxwEikhwAYMpi7w9lWTtKP/fXJxMS
         NyxqiJKikzVaD8yWxtDDawDiDxfscFY+Pay85qx9gk6KquifIsf5Dn9egl4khEc0kudX
         s3FwBwUvrHiHVgHWDMGUPiNQ0WaSZBtqxrz1HUCsNePM2SPOqLsq/lj1l8ZDeiMaEcuA
         picA==
X-Gm-Message-State: ACgBeo3iXbGPR/k2GAJbZN7mjoECKwf5v1EHTYtxI+BSz3aQpabGKrhR
	hjr2kUjH5xzvFkI0nFFQzKvNDOh5/5M=
X-Google-Smtp-Source: AA6agR4iqijNwjFEyUgnRpo7sg1VVo0Pt2A2jPBp9CYWBZwVvMqSXM60qXu0r24/HtGJWCMiahtEcA==
X-Received: by 2002:a05:600c:a02:b0:3ad:455c:b710 with SMTP id z2-20020a05600c0a0200b003ad455cb710mr6196157wmp.56.1662371201681;
        Mon, 05 Sep 2022 02:46:41 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a1-20020adffac1000000b00226dba960b4sm8482512wrs.3.2022.09.05.02.46.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 02:46:41 -0700 (PDT)
Message-ID: <2913fc75-49a6-346e-136c-31b87d6487fc@grimberg.me>
Date: Mon, 5 Sep 2022 12:46:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: crash at nvme_tcp_init_iter with header digest enabled
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220819075117.rzvbecyvh2wuwokj@carbon.lan>
 <9a0bc2f1-b1d0-a34d-2e9f-926da3fc2ab4@grimberg.me>
In-Reply-To: <9a0bc2f1-b1d0-a34d-2e9f-926da3fc2ab4@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_024643_950594_C26356C3 
X-CRM114-Status: GOOD (  24.91  )
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


>> Hi,
>>
>> we got a customer bug report against our downstream kernel
>> when doing fail over tests with header digest enabled.
>>
>> The whole crash looks like an user after free bug but
>> so far we were not able to figure out where it happens.
>>
>>    nvme nvme13: queue 1: header digest flag is cleared
>>    nvme nvme13: receive failed:  -71
>>    nvme nvme13: starting error recovery
>>    nvme nvme7: Reconnecting in 10 seconds...
>>
>>    RIP: nvme_tcp_init_iter
>>
>>    nvme_tcp_recv_skb
>>    ? tcp_mstamp_refresh
>>    ? nvme_tcp_submit_async_event
>>    tcp_read_sock
>>    nvme_tcp_try_recv
>>    nvme_tcp_io_work
>>    process_one_work
>>    ? process_one_work
>>    worker_thread
>>    ? process_one_work
>>    kthread
>>    ? set_kthread_struct
>>    ret_from_fork
>>
>> In order to rule out that this caused by an reuse of a command id, I
>> added a test patch which always clears the request pointer (see below)
>> and hoped to see
>>
>>     "got bad cqe.command_id %#x on queue %d\n"
>>
>> but there was none. Instead the crash disappeared. It looks like we are
>> not clearing the request in the error path, but so far I haven't figured
>> out how this is related to the header digest enabled.
>>
>> Anyway, this is just a FYI and in case anyone has an idea where to poke
>> at; I am listening.
> 
> I think I see the problem. The stream is corrupted, and we keep
> processing it.
> 
> The current logic says that once we hit a header-digest problem, we
> immediately stop reading from the socket (rd_enabled=false) and trigger
> error recovery.
> 
> When rd_enabled=false, we don't act on data_ready callbacks, as we know
> we are tearing down the socket. However we may keep reading from the
> socket if the io_work continues and calls try_recv again (mainly because
> our error from nvme_tcp_recv_skb is not propagated back).
> 
> I think that this will make the issue go away:
> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e82dcfcda29b..3e3ebde4eff5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1229,7 +1229,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>                  else if (unlikely(result < 0))
>                          return;
> 
> -               if (!pending)
> +               if (!pending || !queue->rd_enabled)
>                          return;
> 
>          } while (!time_after(jiffies, deadline)); /* quota is exhausted */
> -- 

Daniel, any input here?

