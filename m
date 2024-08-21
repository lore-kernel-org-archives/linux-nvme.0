Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488FCC5321D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Aug 2024 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AnLQArsGTATyL4MdvT91fu+LNpUpQbqPFUvVbkUg8U=; b=fOkNHc5385+DsAgc/Svkur1VW0
	8gssduOamUemnmZ/bDbRoAZ4WOs1XAiRqXRNRuUiIOqbxavD1egexs4K9E3f4SdVFhAljgAzEQhwl
	P4oeTt2+vHpBPvswPjQV8BNL2amNYS0J2ZdLEvVzLMcklbWdnyajdAtKb7VeGJnoVXsDwbHAburF7
	EIpqpXLH6qYpPdC+PN9wSjdre03GHQ9XNHkYnvLNxgXxENTDB+sOTbEWIpIJYCysHL4qf5FH7ENkD
	TW64rUbsD4MI3sS1I5bltgkX7oGScHsSVnA23uBFJCB7jSVTJdglQvRm0veNY/eACxmHMv0lgI7Yg
	mxmJc9Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sglSr-000000098gc-3XYs;
	Wed, 21 Aug 2024 13:33:29 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sglRo-000000098Zh-3zP2
	for linux-nvme@lists.infradead.org;
	Wed, 21 Aug 2024 13:33:27 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-428119da952so54339895e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Aug 2024 06:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yawk.at; s=google; t=1724247143; x=1724851943; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1AnLQArsGTATyL4MdvT91fu+LNpUpQbqPFUvVbkUg8U=;
        b=NRx1J65tjzeHqOtakllYjxaj8Pv6+rG1LEjIyuHZbcjhaaes2A8VT8SgBTo7JSHlmb
         Bfowhhi9n3u82fxaIBf7qbwqA6Garjq26Ti0OgZuwtL5NhFDfm7V18D9vd1AN0o+ZKP8
         U+9tD3pz77mj+ne+WapIdf/uDw1UmuocdUqlGtVaLDsl8km6AvMnnk8SUNYuMkv0tV75
         EYntpxWVB8TjmlYiGJBlTKwXy4y3Ql75vgt6IHxAWjClqFVs/zFbSRofzy59aqC9h4yZ
         C99k9iw2gqTzH165AqhFh/Ps7MXw4MoiGYTVxNayG7uHs8qYJ/IFFSRPA5l+9JrCrvGm
         semw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724247143; x=1724851943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AnLQArsGTATyL4MdvT91fu+LNpUpQbqPFUvVbkUg8U=;
        b=cD6WywtpfqthZ+5KTs0K4UCtg68fjhHi02B491ARgrNpzpK8G5BzROAXOduGMSDDAX
         3SNzPsKTLT2BKH5WbWGVRfCnJ7HIVD6oy91xjVbiq6S4OeejuQMR55nCrrgH0n8n1J64
         rfl7+SraimzRcO9/hlkadzbCXYwC23ZgbgVHl3L9TVOXN2l6oMtvHY8ewdSYEwPJQUkg
         xa6sO7/+HdSeFh1I8En/uH9vne9hq2ptW97gMydSgrNSi+2r417SaqsN8xjxRsQR4d1M
         0Fa755V5beZ8hXUHj/owgdt7m/13DlJHECowmFHIjDSawD76gc83Qi7YxE2qTG+3aj3i
         gihg==
X-Gm-Message-State: AOJu0Yx/doTjctqyiI2ioI9ezXph5xLRnZjcZ5KfGMDEawmeL9tjC9e7
	HtJ48LtvZyXplcXWIPSAggU6yVn5ZZLSPs7PAhIZvoYxuAoOrzkzA3K1r4YhfEs=
X-Google-Smtp-Source: AGHT+IFrTTtVdQQJstuhAWTIkaPqXt38OtttzNl666uNrTaCFtTnPXjykJQp88J6zg8WGpGKujVaXg==
X-Received: by 2002:a5d:534d:0:b0:366:ee9b:847 with SMTP id ffacd0b85a97d-372fd598551mr1894021f8f.14.1724247142566;
        Wed, 21 Aug 2024 06:32:22 -0700 (PDT)
Received: from ?IPV6:2a02:8109:833c:e300:f556:5d1c:aa18:d31a? ([2a02:8109:833c:e300:f556:5d1c:aa18:d31a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe274asm8321770a12.8.2024.08.21.06.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:32:22 -0700 (PDT)
Message-ID: <ec426603-0ba8-4370-8036-7fa90e334348@yawk.at>
Date: Wed, 21 Aug 2024 15:31:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Occasional kernel error with NVMe-oF TCP target
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org
References: <364590b3-c3d1-49d6-be6f-d36c1a1412d8@yawk.at>
 <CAFL455mQ=0VoTPsTN-YZzZ9bu7gy4y2eUnEv69wACjODSQChzw@mail.gmail.com>
 <CAFL455mhJKNZqxHvTBehLxBNn75gGj9ecd3FZWe4yncSz-OZxw@mail.gmail.com>
Content-Language: en-US
From: Jonas Konrad <me@yawk.at>
In-Reply-To: <CAFL455mhJKNZqxHvTBehLxBNn75gGj9ecd3FZWe4yncSz-OZxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_063225_021371_48AD3867 
X-CRM114-Status: GOOD (  18.95  )
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

Thanks!

So from what I understand, this patch fixes the "NULL pointer 
dereference" part. However, the allocation failure and associated error 
still remains, yes? And I assume the nvme-of connection would still fail?

Is it possible that the allocation failure is caused by one of the leaks 
that have been fixed in the past year in nvme-of (I saw some in the git 
blame), and they haven't reached LTS yet? I can try getting a kdump next 
time this issue happens to see why there is an allocation failure in the 
first place.

- Jonas

On 8/21/24 2:16 PM, Maurizio Lombardi wrote:
> st 21. 8. 2024 v 12:57 odesílatel Maurizio Lombardi
> <mlombard@redhat.com> napsal:
>>
>>> Is the stack trace enough to go on? Is this already fixed in a newer
>>> kernel? Do you need me to gather more information?
>>
>> The stack trace was more than sufficient, it's still reproducible on 6.11.0-rc4
>> What happens is that the nvme-tcp failed to allocate sufficient memory
>> for the commands and the
>> queue release procedure dereferences a NULL pointer
>>
> 
> This should be sufficient to fix the crash
> 
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 5bff0d5464d1..b37506ad851f 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1534,6 +1534,7 @@ static int nvmet_tcp_alloc_cmds(struct
> nvmet_tcp_queue *queue)
>                  nvmet_tcp_free_cmd(cmds + i);
>          kfree(cmds);
>   out:
> +       queue->nr_cmds = 0;
>          return ret;
>   }
> 
> Maurizio
> 

