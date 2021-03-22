Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82399C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 04:07:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A7E61967
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 04:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A7E61967
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5KugKdKsnHT1vCfHzbf3T2zDDxGjp3DuR19xdIXx8Rc=; b=SS8CQBTqv4lpMbHEW71RuHlN2
	XwCuZfEwjtcdxyxFx6RixbDHSPNESgYELQK2IuRF/NuKzZjXR2m4HnBcA9iVU91854IJwaCXOP2GX
	qees3MY2OtG+coYmXUM/m9OGlvR3SiHiUEtX7i5FpeT3FCCUlVKKqREjXk/mdj2twfyBhX23mmRhV
	HfzRpX1NEA3gQPlxVSg66owr0LT3U1yb/OVCbSc8FHlKW2QeEJvGbhSItlXDyt+CpkpMDWPCZggjo
	2zLq+/cXZ89ibxegEE7yEZA56F+qqtG91PlkL6f4bYInrdSjAMd6MxpsEmlXwqoCsBCuXwEpmwKn6
	maFPbQWbQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOBqD-00AqCu-Hu; Mon, 22 Mar 2021 04:06:57 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOBps-00AqCO-Q9
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 04:06:39 +0000
Received: by mail-pf1-x42e.google.com with SMTP id x26so10055133pfn.0
 for <linux-nvme@lists.infradead.org>; Sun, 21 Mar 2021 21:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=/KDln5nCx45EZhxjkBuevwUjo/3k5OL1V00//1PfGsI=;
 b=PvczID2CYVhzuiPRFGd3Rb5BHSu2dmHQz6bu4NfKFUnB3jeM7Yo13Rok080+ezLOGB
 NhD4sRy+VplctWgyENncU8HfF8+x3osGkTJ66r0q3UDsoBMD4jgBT2FqcBeL37LDCKVy
 iwq+h2UrYUNT1mD0OZ4lsuwVRAh4WTkKfkwRXK7OSjxBah+Gr+tOQ7RuQCwm5mmJQq3w
 zy050enBj8CmHrvTh33+yaPpzFrtj3a+W5GABSFMFtMC8+troXCfYkyUIiiMNG8rbNli
 7kx4epHvNxijRO3VOllSzIJ46dSRyDBO8tiPpr3lS1nJLYsgaBIpkgQ7B7rDb8Qf8DlO
 NdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/KDln5nCx45EZhxjkBuevwUjo/3k5OL1V00//1PfGsI=;
 b=suxfBfRZ158HXEcA005+JYAXzVWuDBu8RArJO3/ilMxHjAjZuGlTOq8zw2evETXGUO
 CRbH1d3K3xOSYLUaYMN2H7PAVaPseA2itnPj4Jx36+k/NHwUKIpiRmLe1Huj8ewZwblM
 9ct3+EPrZ3IB3y0LTRCWTyU5ovLOadmFZRtp6hYIj8uMYVnkEo4HIEsoYMTcJywIfY6m
 a1a11qj4Yq3NdcwN+7mw8mg0t5RGxA/pVtrJ1XS94kk0DBl9D3TdHkrVCXkPz2ScUKSS
 c5S+A+NKuIQp0Do3QPL1QDMzI4AH/vQxggnPHyHjPb04oe6g+EAoPVdkNPm/Dvym1zRL
 ncYw==
X-Gm-Message-State: AOAM533IoswYjjXRYcXR6V23ZYHXezUtlfDLP3SJ6QtvbualxXIFAKJ8
 gYUOrGbPa7f1bKPf+89WGs8smuMCGVcNbA==
X-Google-Smtp-Source: ABdhPJxr5eLF2XgTOTC4bUTt7iOEtJEhwNXd/4WCT+9GImQfVhrjlsxz3Gmq1POgIdD4DMCHO0PcXQ==
X-Received: by 2002:a63:e1b:: with SMTP id d27mr21059219pgl.135.1616385993998; 
 Sun, 21 Mar 2021 21:06:33 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id l190sm11925761pfl.73.2021.03.21.21.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Mar 2021 21:06:33 -0700 (PDT)
Subject: Re: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing
 error
To: "Grupi, Elad" <Elad.Grupi@dell.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210318125518.27121-1-elad.grupi@dell.com>
 <20210319035257.96267-1-houpu.main@gmail.com>
 <DM6PR19MB4011CB40F6635EEC2AEF86EFEF689@DM6PR19MB4011.namprd19.prod.outlook.com>
From: Hou Pu <houpu.main@gmail.com>
Message-ID: <c7801b53-70e5-6687-a077-01a5dcf97bf6@gmail.com>
Date: Mon, 22 Mar 2021 12:06:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB4011CB40F6635EEC2AEF86EFEF689@DM6PR19MB4011.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_040637_221682_784BD007 
X-CRM114-Status: GOOD (  25.52  )
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


On 2021/3/20 1:26 AM, Grupi, Elad wrote:
> Right, I see.
>
> But when calling nvmet_tcp_queue_response, the flag for NVMET_TCP_F_INIT_FAILED is not yet set.
> The flag is being set only after nvmet_req_init returns in nvmet_tcp_handle_req_failure.
Hmm, that's true.
> It is possible to block in nvmet_tcp_queue_response any command that has unattended inline data, will that work for you?

It's OK with me.


Thnaks,

Hou


>
> Thanks,
> Elad
>
> -----Original Message-----
> From: Hou Pu <houpu.main@gmail.com>
> Sent: Friday, 19 March 2021 5:53
> To: Grupi, Elad
> Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me; houpu.main@gmail.com
> Subject: RE: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing error
>
>
> [EXTERNAL EMAIL]
>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 70cc507d1565..5650293acaec 100644
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
> Hi Elad,
> Although this works, I think Sagi would prefer not adding this to the response queue in nvmet_tcp_queue_response().
>
>
>>   	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>>   		ret = nvmet_try_send_data_pdu(cmd);
>>   		if (ret <= 0)
>> @@ -1106,7 +1117,9 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>>   	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>>   	    cmd->rbytes_done == cmd->req.transfer_len) {
>>   		cmd->req.execute(&cmd->req);
>> -	}
>> +	} else if ((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>> +			cmd->rbytes_done == cmd->req.transfer_len)
>> +		nvmet_tcp_queue_response(&cmd->req);
>>   
>>   	nvmet_prepare_receive_pdu(queue);
>>   	return 0;
>> @@ -1146,6 +1159,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>>   	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>>   	    cmd->rbytes_done == cmd->req.transfer_len)
>>   		cmd->req.execute(&cmd->req);
>> +	else if ((cmd->flags & NVMET_TCP_F_INIT_FAILED))
>> +		nvmet_tcp_queue_response(&cmd->req);
>   
> Here we also need to check cmd->rbytes_done == cmd->req.transfer_len as we could get multiple data pdu.
>
> (BTW, did you forget to add [PATCH v2] to the subject line?)
>
> Thanks,
> Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
