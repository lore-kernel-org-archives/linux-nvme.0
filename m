Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BB5C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 19:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Jv4OCmj9ZOFOZwKdsGbByycSgZr948YUTIzjqKDeOI=; b=w5GQf/fiqfr7WWoX5dqQjVPvkP
	exgU0lmTtUL1C+bOe3WWlxF/lZKDXtUzoGv4BBfULwgixtrd4jwClTKBP1k5VSPCp8BtZW3lqSEI2
	k0il7yXqB3yccVO7EcU3lL2JGyq2U7M6oXrrGtEEZAl0DkhBNP4B58zX7K/8vhG9ZVLsLu2o7sBuv
	sXGjucySUdPuwlGOCuxFBDG5U+A68sba5/T2UCOxDgtMk0j+rINa0TrV03o4tjRHosgtpDv3wPs/v
	jK6j56ZKD+C3hsy1HkYjgfVao8pnN12dc4f+xgRb5eFfqyIYFrwULpq/BsBeSPENMRd2wJr2avYbw
	HttCAOBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osqKU-00GQmv-FT; Wed, 09 Nov 2022 19:01:42 +0000
Received: from mail-ot1-f43.google.com ([209.85.210.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osqKS-00GQlf-2B
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 19:01:41 +0000
Received: by mail-ot1-f43.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso10623812otf.13
        for <linux-nvme@lists.infradead.org>; Wed, 09 Nov 2022 11:01:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Jv4OCmj9ZOFOZwKdsGbByycSgZr948YUTIzjqKDeOI=;
        b=D04nBvbmYL+bXulan/ZgZH6FF/ZfaqK0w+wtL6uIB35eW3MRGUL0e4JpkbYHo/Lk1t
         9u3Ey+5kiPWEGzqvwW36majFsbqBzUhS+5m8JEkpw7HQ9x9G1bBYi5BWk85KMiGjp6nU
         naWyAfd+W2nEbX6S6KRpMZQvJSiF8JCI3PP+DRLK0XrMlwzmcSX6Ri29V6DJIlYmtpI2
         ppHeO6C+9VSVqQUjlS/NAwJlO7shzYozL3tz/SmYd+JgCQfwdD24zWEqKEIMmPSHWA84
         B5PKkdQS67dcIkdkWkg35G+BUPPviKPtE6kv/Xo8TVupkdO+lPHZI1FtRT9Rw6fBybnc
         e1aQ==
X-Gm-Message-State: ACrzQf3TNwZR9W/i+SsDEyAx+EqzDEmTntcnaCkVw5BB6KTGYcpS3o3w
	+KTlv81tjf16EuK++SEjArM=
X-Google-Smtp-Source: AMsMyM4JVLyvfseDPm+cCz3ws24DKD4BhVRgpqu1BEoushlfDf89fxJ+euXEtnlFvaMgBILE/DVDnw==
X-Received: by 2002:a9d:198c:0:b0:661:aa2e:1aa0 with SMTP id k12-20020a9d198c000000b00661aa2e1aa0mr30024987otk.154.1668020498878;
        Wed, 09 Nov 2022 11:01:38 -0800 (PST)
Received: from [192.168.82.40] ([108.95.161.27])
        by smtp.gmail.com with ESMTPSA id b5-20020a9d4785000000b00666fdab9da7sm5527918otf.78.2022.11.09.11.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 11:01:38 -0800 (PST)
Message-ID: <b7199f1d-75b8-4121-8af6-3bec252baaed@grimberg.me>
Date: Wed, 9 Nov 2022 21:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 14/16] nvme-auth: have dhchap_auth_work wait for queues
 auth to complete
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-15-sagi@grimberg.me>
 <098502b9-0021-1d17-7fe0-aef101bbb745@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <098502b9-0021-1d17-7fe0-aef101bbb745@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_110140_123366_ACE9947A 
X-CRM114-Status: GOOD (  16.82  )
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



On 11/9/22 09:44, Hannes Reinecke wrote:
> On 11/9/22 04:44, Sagi Grimberg wrote:
>> It triggered the queue authentication work elements in parallel, but
>> the ctrl authentication work itself completes when all of them
>> completes. Hence wait for queues auth completions.
>>
>> This also makes nvme_auth_stop simply a sync cancel of ctrl
>> dhchap_auth_work.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/auth.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
>> index 0159179c2455..e88d6254f2f5 100644
>> --- a/drivers/nvme/host/auth.c
>> +++ b/drivers/nvme/host/auth.c
>> @@ -924,6 +924,12 @@ static void nvme_dhchap_auth_work(struct 
>> work_struct *work)
>>        * Failure is a soft-state; credentials remain valid until
>>        * the controller terminates the connection.
>>        */
>> +    for (q = 1; q < ctrl->queue_count; q++) {
>> +        ret = nvme_auth_wait(ctrl, q);
>> +        if (ret)
>> +            dev_warn(ctrl->device,
>> +                 "qid %d: authentication failed\n", q);
>> +    }
>>   }
> Don't we need to clear the dhchap context here?

nvme_auth_wait clears it.

> 
>>   int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>> @@ -974,12 +980,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
>>   void nvme_auth_stop(struct nvme_ctrl *ctrl)
>>   {
>> -    struct nvme_dhchap_queue_context *chap;
>> -    int i;
>> -
>>       cancel_work_sync(&ctrl->dhchap_auth_work);
>> -    nvme_foreach_dhchap(i, chap, ctrl)
>> -        cancel_work_sync(&chap->auth_work);
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_auth_stop);
> Cheers,
> 
> Hannes

