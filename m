Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF9FC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 06:12:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A396191B
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 06:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A396191B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p2OhkNGue5elxLDBQrGJlIclQ4v5pR26PEVnVN3wGE8=; b=JGQl2Uh3O06xzylG+v5s5N+qr
	h128Db13Y+KFdGwquycqeeCawbvzuKIxOJKqEW2HlQudR7cPZrTncI8JoAn08GKhqKpeLzpRXKMLY
	XeaKxSZFg9fmCIOmghGaGEiXw9sI3OyZmKZzGPDoeEh7xxnhtucQpZDnALtiRo56PZZTSWrRr4nzT
	jwK6izt8abn/Zlw2GHEezeW2xSqyHnyPHU8Vl7w214O99xu3mzL/4j4OLetmWyWdH8/EpSITcsiGq
	nmMZUoZr1IYsryDlacDWArJnZQY1ajCPILVWRLyYuJBp5AlBDdVKAzbE521dsMuhPMmItyAjMB8CO
	r3aV3+Yfg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lR7cM-002oq7-9a; Tue, 30 Mar 2021 06:12:47 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lR7c8-002opW-NY
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 06:12:34 +0000
Received: by mail-pg1-x531.google.com with SMTP id h25so10973348pgm.3
 for <linux-nvme@lists.infradead.org>; Mon, 29 Mar 2021 23:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7dELPQZqUfFTw+6uOtsMU1/c/S3Pi38IE4jAFQvsulg=;
 b=FeJG4Q1Hj7xegpp3zWILe5YgvzQIXXSvaDI0RYLIMIlxgwKKV0+Qs6ihgV8lcAniXs
 rStzJBCjFi1Rv/+JtBegMECDv0gy3H/pSMfd6cB1Si8kA+IZIjYhpaetm4vKktTY1+Af
 dhQSGxXzbWk4Bd2R2B39QA4n59LbcPI7xfPR1usvOlS1iVDuWp0nil92LwxAM6/4hvjx
 /x3tVkLj2v6ISujedtRaFCyHhj7PjnUrjMpqWB+1s+OZ073jW5clDVdpZ8H6AcPd1t0M
 fPOt0GWlKBCf9787S20HXNIc75fFPBOLVgEKcuxJUJF86o7yaDQfeBBgY7jkwX5nRtXP
 10fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7dELPQZqUfFTw+6uOtsMU1/c/S3Pi38IE4jAFQvsulg=;
 b=skM2RTHhzfoodK1nXEeBOMqSXEIJvgpIWm2qI6/uA2oXna5OXlu+QLCjLKpL7lqNpf
 /Eep4FcKUUBXpP5PhXgRwCOLDS++c4LiHkL711+RXQYpxBpTE2pgkNtLxJbHZF7oZQWc
 nNdZROLXdTb4E0py1z9U4ysRuawvHAelRHB4F+4Dn8aaGzDAOwIqmh46delWQHkHAZR8
 2kcQSQDgqEKxcoFcsW+E1jPmF0AQOSsrcqEUG6eRF2RRX6xuMFYiGnEgkPG2mDanApnt
 IZQdoy4z48aAGasnW0gWk1CmDoiEhr00L52Da5ogHR9Veng9pJ+H/lTVWmg4UA+FZRw2
 7feg==
X-Gm-Message-State: AOAM532/DHm9e5j98bzowOB97+/RQ+TJtS7n7bb5qi9/QMzoENzm0ioA
 KcXyU7pe7bG2pa6kPvwcXeE=
X-Google-Smtp-Source: ABdhPJwuj7abj8KfjOWcC03jbBrmaxa+BOh2TVuPOzVmG3pH6BV1LnlrgiLoS+FnyQvmwXIFoDtpnA==
X-Received: by 2002:aa7:8f30:0:b029:20a:20d8:901a with SMTP id
 y16-20020aa78f300000b029020a20d8901amr27971089pfr.7.1617084751241; 
 Mon, 29 Mar 2021 23:12:31 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id f14sm20036344pfk.92.2021.03.29.23.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Mar 2021 23:12:30 -0700 (PDT)
Subject: Re: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
To: "Grupi, Elad" <Elad.Grupi@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
References: <20210326175941.22734-1-elad.grupi@dell.com>
 <20210328040427.20895-1-houpu.main@gmail.com>
 <BY5PR19MB400413D837B52BA22628A888EF7F9@BY5PR19MB4004.namprd19.prod.outlook.com>
From: Hou Pu <houpu.main@gmail.com>
Message-ID: <ef4c8620-a2aa-2fdc-3ae1-0e34e62ad78c@gmail.com>
Date: Tue, 30 Mar 2021 14:12:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BY5PR19MB400413D837B52BA22628A888EF7F9@BY5PR19MB4004.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_071232_952262_9CEBFE2D 
X-CRM114-Status: GOOD (  35.82  )
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


On 2021/3/28 1:13 PM, Grupi, Elad wrote:
> Hi Hou
>
> Even with the code below we will still queue the failed REQ for the first time.
>
> Please mind the code in nvmet_tcp_done_recv_pdu:
> 1. nvmet_req_init will call __nvmet_req_complete with an error status
> 1.1. __nvmet_req_complete will call nvmet_tcp_queue_response
> 2. nvmet_tcp_handle_req_failure will set the flag NVMET_TCP_F_INIT_FAILED
>
> In step 1.1, the failed REQ will be added to the queue anyway because the flag wasn't set yet.
>
> In the previous patch I was adding the REQ back to the queue on nvmet_tcp_fetch_cmd, so it was useful to prevent queueing the REQ over and over again.
> Now I removed that part from the patch, so it means that the REQ will be added only once.

Thanks for the detailed explanation.

I'm fine with v2 or the new version.


Thanks,

Hou

>
> Elad
>
> -----Original Message-----
> From: Hou Pu <houpu.main@gmail.com>
> Sent: Sunday, 28 March 2021 7:04
> To: Grupi, Elad
> Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me; houpu.main@gmail.com
> Subject: RE: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing error
>
>
> [EXTERNAL EMAIL]
>
> On Date: Fri, 26 Mar 2021 20:59:41 +0300, Elad Grupi wrote:
>> In case there is an io that contains inline data and it goes to
>> parsing error flow, command response will free command and iov before
>> clearing the data on the socket buffer.
>> This will delay the command response until receive flow is completed.
>>
>> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
>> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
>> ---
>>   drivers/nvme/target/tcp.c | 29 +++++++++++++++++++++++------
>>   1 file changed, 23 insertions(+), 6 deletions(-)
> Hi Elad,
> Just noticed that we still queue the failed REQ to the response queue in this version. Am I missing something?
>
> Is this still needed? (I think it is).
> @@ -526,6 +527,12 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>   		container_of(req, struct nvmet_tcp_cmd, req);
>   	struct nvmet_tcp_queue	*queue = cmd->queue;
>   
> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			nvmet_tcp_has_inline_data(cmd))) {
> +		/* fail the cmd when we finish processing the inline data */
> +		return;
> +	}
> +
>
>
> Thanks,
> Hou
>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 70cc507d1565..3bc0caa47873 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -702,6 +702,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>>   			return 0;
>>   	}
>>
>> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>> +			nvmet_tcp_has_data_in(cmd) &&
>> +			nvmet_tcp_has_inline_data(cmd))) {
>> +		/*
>> +		 * wait for inline data before processing the response
>> +		 * so the iov will not be freed
>> +		 */
>> +		queue->snd_cmd = NULL;
>> +		goto done_send;
>> +	}
>> +
>>   	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>>   		ret = nvmet_try_send_data_pdu(cmd);
>>   		if (ret <= 0)
>> @@ -1103,9 +1114,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>>   		return 0;
>>   	}
>>
>> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>> -	    cmd->rbytes_done == cmd->req.transfer_len) {
>> -		cmd->req.execute(&cmd->req);
>> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
>> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
>> +			nvmet_tcp_queue_response(&cmd->req);
>> +		else
>> +			cmd->req.execute(&cmd->req);
>>   	}
>>
>>   	nvmet_prepare_receive_pdu(queue);
>> @@ -1143,9 +1156,13 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>>   		goto out;
>>   	}
>>
>> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>> -	    cmd->rbytes_done == cmd->req.transfer_len)
>> -		cmd->req.execute(&cmd->req);
>> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
>> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
>> +			nvmet_tcp_queue_response(&cmd->req);
>> +		else
>> +			cmd->req.execute(&cmd->req);
>> +	}
>> +
>>   	ret = 0;
>>   out:
>>   	nvmet_prepare_receive_pdu(queue);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
