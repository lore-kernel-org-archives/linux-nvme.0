Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F982C2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 06:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ONL0FgIX2sUz4izMxsakEXWbAUPL/9YDsaEmV+aRNGw=; b=fVE7JT2wl3upkXmzy60NrB7QzS
	+IOpfxtEIHKBAcpx3LeXPtVnaryRXDog33L4zPpdLREpeH+3Vwmh6rUQsIgycKxWfpnxX/LubMdTL
	DYGiEqJlTPJe/jn2q24TLOVQp0HNcyEOiDbVbL2c+xdyVEreVQ1ztv2TY/8NedghfiMt8LuUQUOl8
	BS2lzLlhKopP54qwUvvhM911NTcvJ17aFJrfbFVtaBgpPKd8eYi1LDDQdi3yGLWBdi+GZH7xtWbH7
	zbUSVDIcbKsj3z8BoD3YaEia6eYiGm2/Lj0vNsw6bSop1qP/lYz8OzAs4omo1KzsOw+FBW4whFLe2
	/OpuJOeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLzzv-00000001q4l-3MyJ;
	Tue, 25 Jun 2024 06:49:47 +0000
Received: from mail-lj1-f169.google.com ([209.85.208.169])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLzzs-00000001q3c-2zgT
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 06:49:46 +0000
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec4df7077bso1951801fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jun 2024 23:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719298183; x=1719902983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONL0FgIX2sUz4izMxsakEXWbAUPL/9YDsaEmV+aRNGw=;
        b=GGI96ZWlKof0orjK+LCvAWhsjqTqW59+WeSGs0uzVsz4N+f4BaRHdY4rkDGd1ly7SD
         zQe5RuoFzwNclyigxE1iwQCtTYlDCn9jzdTKKyONxoF+F3Hx6ycHxe8zCohCoXvmExMQ
         ejBNSIwls52CwRcM5cq6cqbsghZvjl8WhK9wiZ1BJLJGII5x4ciimNRYQtQ4VxGHc/2u
         WM8UNoZgyHzU5heM9Bcdexduo+0524HVpwa72MKITcNmmirk0kx2MYN5Zi+ZZYoXEhTY
         G37h5lcf6YKSySwTE+8jO2cPIaq9Jlg5TPCl2bj7Nsa8stodlYc4UVVnNbHQKtsZzPBj
         7oAA==
X-Forwarded-Encrypted: i=1; AJvYcCXVCBfTO8DrRvapbTas5iIAArM4vx06mbLZBkmNLIz7w0wXjkKEmYFIzogV0fSJrqGIyGlS9URaU9nGNPpVJYzGGRslVZCz8h41seZ4wJo=
X-Gm-Message-State: AOJu0Yzx6NaXpmuQSK1bOOXfBkt+E0UZ0hTP7pa+FVR/rg+OHWtcXVnV
	0sy/BjyvNDuheDbd5UhTSX218tx25G9pb9kX4IPEZOmnESFbzk1H
X-Google-Smtp-Source: AGHT+IH6kbBXgi0SvFnkU1YzY4k7I3LlCL8dbNlQFwfLk38RPv9WoPN57mT/TiDxemzJllWi/mV3ow==
X-Received: by 2002:a2e:bc08:0:b0:2ec:6196:55e4 with SMTP id 38308e7fff4ca-2ec61965794mr32554831fa.2.1719298182392;
        Mon, 24 Jun 2024 23:49:42 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481910fd4sm158628985e9.30.2024.06.24.23.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 23:49:42 -0700 (PDT)
Message-ID: <e03b73ab-0856-48b6-b580-a3c7e393dead@grimberg.me>
Date: Tue, 25 Jun 2024 09:49:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Hannes Reinecke <hare@suse.de>,
 hch <hch@lst.de>, Hannes Reinecke <hare@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de> <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
 <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
 <eb0023bc-3a3b-4f31-955b-c6aad4cad4a3@suse.de>
 <b4dc2a6a-1663-4144-a607-edb6beef48c0@grimberg.me>
 <f67d4572-f625-48eb-a8e3-3e7a5527d9c6@grimberg.me>
 <BY5PR04MB6849C4BFA9AA491AA5C3BFAABCD42@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BY5PR04MB6849C4BFA9AA491AA5C3BFAABCD42@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_234944_882194_F3B823EC 
X-CRM114-Status: GOOD (  15.70  )
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



On 24/06/2024 23:01, Kamaljit Singh wrote:
> On 19/06/2024 18:58, Sagi Grimberg wrote:
>>>>> I see how you address multiple controllers falling into the same
>>>>> mappings case in your patch.
>>>>> You could have selected a different mq_map entry for each controller
>>>>> (out of the entries that map to the qid).
>>>>>
>>>> Looked at it, but hadn't any idea how to figure out the load.
>>>> The load is actually per-cpu, but we only have per controller
>>>> structures.
>>>> So we would need to introduce a per-cpu counter, detailing out the
>>>> number of queues scheduled on that CPU.
>>>> But that won't help with the CPU oversubscription issue; we still
>>>> might have substantially higher number of overall queues than we have
>>>> CPUs...
>>> I think that it would still be better than what you have right now:
>>>
>>> IIUC Right now you will have for all controllers (based on your example):
>>> queue 1: using cpu 6
>>> queue 2: using cpu 9
>>> queue 3: using cpu 18
>>>
>>> But selecting a different mq_map entry can give:
>>> ctrl1:
>>> queue 1: using cpu 6
>>> queue 2: using cpu 9
>>> queue 3: using cpu 18
>>>
>>> ctrl2:
>>> queue 1: using cpu 7
>>> queue 2: using cpu 10
>>> queue 3: using cpu 19
>>>
>>> ctrl3:
>>> queue 1: using cpu 8
>>> queue 2: using cpu 11
>>> queue 3: using cpu 20
>>>
>>> ctrl4:
>>> queue 1: using cpu 54
>>> queue 2: using cpu 57
>>> queue 3: using cpu 66
>>>
>>> and so on...
>> Hey Hannes,
>>
>> Did you make progress with this one?
> Sagi,
> Looks like this change should also address the other NVMe/TCP issue that I had
> reported for WQ_UNBOUND, agree?

Well, this reduces load from the nvme-tcp io_work, so it makes sense 
that it is shorter now.
However its not clear to me that we are not spending these 10ms in 
softirq in your test case.

Is it possible to measure it? with adding debug prints or trace events?

>   If so, would this also be merged into
> 6.8.xx branch as well?

I don't know if this will be considered as a bug fix. the complaint is 
advisory really, and does not affect
the stability of the driver afaiu.

