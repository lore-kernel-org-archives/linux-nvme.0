Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F694C2BD05
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 10:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FqCOLLYqVoAXXLjBOqg3lgYbwI3ucof49XypDwemNZo=; b=aTjW/WNxzS0uK0KkEZcpJBKKzH
	bHN7gZyeQr27MeaoKeSY/DUU2kIAMQIVsd+lUpZXJdSs92BLjBonPq6ft6C5P6jreCRWd5fwb2VMO
	zkyl0/3uiWsgPdoyinMPyUF+tHX/EQadNSsE6I3xKPNIOoaqBN7QHaegJhUC59DjoR9zD62R/1CjK
	LI+XSSMICYYt4nphnIsfStc5yfrdkJPlqcapwNXW2N75nnUFGZVZoVq05TXATOUwwPqI6i0G3Fman
	Bms6HjL+NjPfWHSU4ikkfSaQr4A168jtjo4T2QgsqV454nciAik9Wqrsg5UGiVgy/UJEs11vJPdIP
	1xK+DTcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLgWp-0000000GLMg-1bGj;
	Mon, 24 Jun 2024 10:02:27 +0000
Received: from mail-lf1-f52.google.com ([209.85.167.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLgWm-0000000GLM5-2uXx
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 10:02:26 +0000
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cd9c890f1so251322e87.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jun 2024 03:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223343; x=1719828143;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqCOLLYqVoAXXLjBOqg3lgYbwI3ucof49XypDwemNZo=;
        b=nY98eEWqhB7DkpaYusbdd56cHeHvZNfY8GUEXmlAAz6v4lJD5OhbuHlN2BiE3GeLge
         dVRHBVBqDL5NEs+/qZlbrz95sdN2UWGkt83LLNVQr4G8KazujlsY1K0wKmqTUUonKEZ1
         AwrX4EVfcxrakisCAdGx6407wmQ+bn5ZaLLPav/yUHGq8AaDMfie5SfA92V3+RZ9cF1/
         U7J6NThGAYnyJIO95rDjEsQt12vDAW1I0id+CHvsnYd/eVJp+KtWo7tY+czlO06HmF03
         +P4Yrq2BYV2sAgRP4f7/vINEIu2HNs1qFDoPA+0mgMmw/SPj7Imsf03iiQHp3vHKELjg
         tu4w==
X-Forwarded-Encrypted: i=1; AJvYcCWhxd2qHCwnPhPIFOW/gbQO5fKCgs5in8ifkvRXtxVsB4YiGqH+rzodYSB62pwVWhqW/NF4YVZzTMVjTududBZ2Gtkn9tmf0ZYUqMBsF7w=
X-Gm-Message-State: AOJu0YyOdi7GulnriEDyJo3/ljRmglyoxsr3cs7m0uK6GpYv9sKBGZls
	i3XLvxig2rBeApT7BAQcjiIAGgFNy42MqINl/9S1IcgHTHpHFRSNnWFqYw==
X-Google-Smtp-Source: AGHT+IG72gP4WrPZc/700FYV08wPQRwhL0/lqw4zqD0hOGt86iQwG5ph5dZ2BocxMEkLWU8ckLL1WQ==
X-Received: by 2002:a05:6512:4018:b0:52c:af45:ed99 with SMTP id 2adb3069b0e04-52cdea4c7d0mr4372359e87.0.1719223342424;
        Mon, 24 Jun 2024 03:02:22 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481910d5csm133805365e9.36.2024.06.24.03.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 03:02:22 -0700 (PDT)
Message-ID: <f67d4572-f625-48eb-a8e3-3e7a5527d9c6@grimberg.me>
Date: Mon, 24 Jun 2024 13:02:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de> <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
 <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
 <eb0023bc-3a3b-4f31-955b-c6aad4cad4a3@suse.de>
 <b4dc2a6a-1663-4144-a607-edb6beef48c0@grimberg.me>
Content-Language: en-US
In-Reply-To: <b4dc2a6a-1663-4144-a607-edb6beef48c0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_030224_768789_AA3255F4 
X-CRM114-Status: GOOD (  11.86  )
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



On 19/06/2024 18:58, Sagi Grimberg wrote:
>
>
>>> I see how you address multiple controllers falling into the same 
>>> mappings case in your patch.
>>> You could have selected a different mq_map entry for each controller 
>>> (out of the entries that map to the qid).
>>>
>> Looked at it, but hadn't any idea how to figure out the load.
>> The load is actually per-cpu, but we only have per controller 
>> structures.
>> So we would need to introduce a per-cpu counter, detailing out the
>> number of queues scheduled on that CPU.
>> But that won't help with the CPU oversubscription issue; we still 
>> might have substantially higher number of overall queues than we have 
>> CPUs...
>
> I think that it would still be better than what you have right now:
>
> IIUC Right now you will have for all controllers (based on your example):
> queue 1: using cpu 6
> queue 2: using cpu 9
> queue 3: using cpu 18
>
> But selecting a different mq_map entry can give:
> ctrl1:
> queue 1: using cpu 6
> queue 2: using cpu 9
> queue 3: using cpu 18
>
> ctrl2:
> queue 1: using cpu 7
> queue 2: using cpu 10
> queue 3: using cpu 19
>
> ctrl3:
> queue 1: using cpu 8
> queue 2: using cpu 11
> queue 3: using cpu 20
>
> ctrl4:
> queue 1: using cpu 54
> queue 2: using cpu 57
> queue 3: using cpu 66
>
> and so on...

Hey Hannes,

Did you make progress with this one?

