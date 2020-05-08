Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A40BC38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 14:54:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F6B216FD
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 14:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X3R99Sj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F6B216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BMqqTaAqKB0ICD4ak/Qg4ZqkRT4YNVZb9Mf6xPrwpNw=; b=X3R99Sj+gy9KlAg1Ez7PmJIVm
	d5F3+4P7PuSmhI+oifpmIm0n4BXUOVL0WbrVDI7i2IWfFcKZ8Qn1Gzf02xjpkgVJYULAlXiNLVS0J
	Fpu1XEf4cYISjzZAGLIX6aGxvCIeDck3WDcCRKtwt1rMdxtBkOnTNTNJSK151FNJ8hsGaVRLFqLHK
	2Xsv9N1PBd6AJ3Vu/XxUvWXXbhFR7WPn7xB065SIb4aRteDAVMxSGYv6hjXalT921pKerLVg0Tzmz
	0Cj9LXU6cy1UpZ/dgTfi0YVLE02qfwvezAr0LOztMjL6H8cglll4P0b2BCkylSoQdP88vAdokMOwx
	60etIcxPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX4Oh-00083Z-QN; Fri, 08 May 2020 14:54:43 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX4Of-0007yx-72
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 14:54:42 +0000
Received: by mail-pj1-f65.google.com with SMTP id a5so4366910pjh.2
 for <linux-nvme@lists.infradead.org>; Fri, 08 May 2020 07:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uFQ0Y3FSO9+63odL1ZghbfArTQjt8zyD3Q+xcph8Ptw=;
 b=YQRxlytb87KbqIdhaOeEdz8qteFlaTBjPydLl5H2FDIePm4LajZVgjORoVaUz+V7G9
 mBnRdKFARM7qNFAQWpxWSOqX+YS+NudPE8Wf4pMvw4SW2nhWlgMxTqW8JLit9wfbB9Y/
 weHRwNoSD+8UEG1P7tQ6tzOKHb/7PotJqVk/zkAN/RznQ92pB7xTsMbkbEZjssOH8sR2
 r8GMNCP/auHIeiHWf0e2eGY5QA7AFMv3u/SqrJ65fQmZVLYp1U4HUDNIrLuZoKroGOHN
 1JCohtPaYn2+Nk3dbT+t2xTkcYBEUSMyIVvbrErWBBJfZYhdyom7jytT4s9eCVtNuA00
 /uOg==
X-Gm-Message-State: AGi0PuZarMeVQ1e5m28OMylPfxPjYtgvdIGCZcCX40PPvD52J7Go2bFO
 vXFFsbADBfe828OCwc8B9BChqBvH
X-Google-Smtp-Source: APiQypKV7l4Od7g1ShdDdhQJyts7uNohcbdlXLpwdf+BMJoueV2vJKxb4frGsZbTq/Rc/PslpIKimw==
X-Received: by 2002:a17:902:c015:: with SMTP id
 v21mr2912179plx.189.1588949676679; 
 Fri, 08 May 2020 07:54:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bc73:49fb:3114:443?
 ([2601:647:4802:9070:bc73:49fb:3114:443])
 by smtp.gmail.com with ESMTPSA id g16sm2068490pfq.203.2020.05.08.07.54.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 07:54:36 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme-fabrics: Add support for padding alignment (pda)
 option on tcp
To: Yoray Zack <yorayz@mellanox.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
 <1588860124-40089-2-git-send-email-yorayz@mellanox.com>
 <fa6f363a-17fd-b8a2-e772-da264a2b4538@grimberg.me>
 <AM0PR05MB57935C225C02987C2E1C85E8A3A20@AM0PR05MB5793.eurprd05.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <155c3cc2-9baf-48f9-05b8-62abf407a45d@grimberg.me>
Date: Fri, 8 May 2020 07:54:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB57935C225C02987C2E1C85E8A3A20@AM0PR05MB5793.eurprd05.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_075441_257372_D3295EBF 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: Boris Pismenny <borisp@mellanox.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>> index 2a6c819..4468b57 100644
>>> --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -612,6 +612,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl,
>> struct request *rq,
>>>    	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"
>> 	},
>>>    	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>>>    	{ NVMF_OPT_TOS,			"tos=%d"		},
>>> +	{ NVMF_OPT_PDA,                 "pda_size=%d"           },
>>
>> This is very specific to nvme-tcp...
>>
>> We are gradually making the fabrics arguments span transport specific stuff.
>> I'm wandering if we should have a cleaner approach to this...
> 
> Yes, this is specific to nvme-tcp
> 
>   But we added it there because there are already other parameters there that are nvme-tcp specific (such as data/header digest).

Yes, the digest pieces could at least in theory become applicable to
other transports by extension.

>   We agree that there is place for improvement, but this is a separate infrastructure work

Which should probably happen before we add user-interfacing
functionality if we need to figure it out, especially if there is no
pressing use to get this in fast.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
