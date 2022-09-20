Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71555ECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zsoYNuKP3QpmgzC9FFiiHSP/WEa5pMQzXimPu0ydcOE=; b=vFb7VpFeEZ8dKn2sm2fLA1jNrR
	0cf2TP9n7KqhdhVDz9eANYS9IZJphibisJAiSmqW5g+eTbrYpWTlK0QSGCURHJKwx6Si50quVhtkW
	ECoatIMLKvm50zltl9kWfbxbB/UPhdxnrhIetgvWT3dyYpWsbDVf68v8nRCNLr30DLXxWPEQKifCM
	j7xJQdPY8oF3021oyNrlKEcFN4dQLINPv5BDGJqgAyvxNynJJPZ6Pz/JMoNDWH0RFnFpJS6y7vsb5
	N013Bq+MvdX1eHnmn1U14PbYB7npLMIXdP7DaLwEM12VaLGYYKAkC9Ceq1/gLII4VcQbw3hqYjeze
	9m8JGI3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oafYv-0050HW-BK; Tue, 20 Sep 2022 15:53:29 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oafYp-0050FQ-8i
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 15:53:24 +0000
Received: by mail-qt1-x836.google.com with SMTP id c11so1993367qtw.8
        for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zsoYNuKP3QpmgzC9FFiiHSP/WEa5pMQzXimPu0ydcOE=;
        b=kjU6l6JfRRZbDTNquAyOaWSz6dvfZpAU9BZRsbZZbdj6f7hkJruG66++Cwe2SZIcmn
         0diHioaUv1FZpwAiHGr90/kmJNOSHaJ7P7zhMdeHIzzCjALNeoUWcchLaEBV+PZLA7qk
         skiGzHyA6shPXwtI92TjtmQFY1WnLN+gBbjdAI3xsERpiKi1YRy2nRPCL9eNJaZdLeNy
         HjagSkL/gjaegg4KAkYBCRTSCsi1wHVGGQyoDdjzH4Uvsvflqh1+H9EgMNXRAuJHmdiq
         u9mLqI7E2jkWCd52Mb+pYZDeSOIAy3Wam+8DpxGyRz92cztPBzgU5hxtPqCxxYIQxvF3
         N0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zsoYNuKP3QpmgzC9FFiiHSP/WEa5pMQzXimPu0ydcOE=;
        b=ixbffStEgYEQLaLCQhNHSg0W9Lx3hp2tpV+Uh7nX8W8hE6joYr956HXNBCcuDJNHzl
         ghrlYzsZH2gMy/w5b7Y2/AIvGYXUgkVNr7MpKTD7JHACGSgbRmFgCGeSQovsTbmFF70q
         xBD2pC3r+L6tdVXimTYVaG/J0oA5B594xSzW143wILB80b8LPgu4V1G8MTUhcN5nrJ8B
         cE67YPkpQucU8fWgYgGN2yL/MCEshqMHzRkIIb/74dTpfWT6FMJFQDNq+c51en0GEVzU
         uqCHhNfxc/JVV3Aq+TmmpO4RDZP80U0roEwv+T53tb5of80+hMgs12ZYPlYwFf2+HcPq
         EcZg==
X-Gm-Message-State: ACrzQf0+2otUBt504cxvNQuMPhmf5Xj3RISdnpkNXSt+8UIVGW0guO8V
	zuShywBoHv6F3VfipGg8mDo=
X-Google-Smtp-Source: AMsMyM4N5qbEKcE+I8eLN1XXrW1dRC1SgDn4ovgCmx8sOLWYsMQbAWkCJB7DW1C8KN1M2tdbBQmZsw==
X-Received: by 2002:ac8:4e46:0:b0:35c:f374:d686 with SMTP id e6-20020ac84e46000000b0035cf374d686mr6043551qtw.188.1663689200066;
        Tue, 20 Sep 2022 08:53:20 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id f6-20020a05620a20c600b006b949afa980sm75626qka.56.2022.09.20.08.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:53:19 -0700 (PDT)
Message-ID: <43dd5538-1d5e-73bf-c78a-48e1beaabe9b@gmail.com>
Date: Tue, 20 Sep 2022 08:53:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmet-fc: Fix potential Use-after-free bug in
 nvmet_fc_delete_target_queue()
Content-Language: en-US
To: Liang He <windhl@126.com>
Cc: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20220916082953.4095940-1-windhl@126.com>
 <5c965e81.13d6.183536d5bba.Coremail.windhl@126.com>
 <35339637-846a-2c7d-d414-fa05527a8cf6@gmail.com>
 <71e21f4.78db.1835af68bbc.Coremail.windhl@126.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <71e21f4.78db.1835af68bbc.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_085323_543177_781DF4FE 
X-CRM114-Status: GOOD (  15.58  )
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

On 9/20/2022 5:54 AM, Liang He wrote:
> 
> At 2022-09-20 01:57:05, "James Smart" <jsmart2021@gmail.com> wrote:
>> On 9/18/2022 6:46 PM, Liang He wrote:
>>>>
>>>> 		kfree(deferfcp);
>>>>
>>>> -		spin_lock_irqsave(&queue->qlock, flags);
>>>> +		spin_lock_irqsave(q_lock, flags);
>>>> 	}
>>>> 	spin_unlock_irqrestore(&queue->qlock, flags);
>>>>
>>>> -- 
>>>> 2.25.1
>>>
>>> Sorry, my patch is totally wrong as the 'qlock' is embeded into queue.
>>> So if queue is freed, the 'qlock' will also be freed.
>>>
>>> Now, we can only hope the 'nvmet_fc_tgt_q_put' in lin 941 will never really free the 'queue'.
>>
>> Did you actually see that occur (line 941 freed the queue) ?
>>
>> -- james
> 
> Hi, James,
> 
> I actually have not seen this as I use static method to detect it.
> 
> While there will be no UAF in current version, I think we should not use the
> reference after we put it, right?
> 
> Liang

there are multiple gets thus puts for it. All depends on the heirarchy 
of what's happening. Have to track that through. Expectation, based on 
the implementation, is that wouldn't be the last reference so it 
wouldn't free it. now need to prove the truth of that.

-- james

