Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C491AC369D3
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Apr 2025 10:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ljk43xtIhuZJm+NVg03EJzyD0vryP3mX6f5pOhBhi5M=; b=vsyCuv8SMlXXDBthhQphxGpHPg
	KDefut8wymQ6ylrhOA3e6IOkhJDfyuXZdLlZKbMfJCKUc2xfXWxnC6L4UQbOqYjru9XlswBVm43Lj
	gxAHr8IHuq9zDXaL8QlEeU27jCJhBCpbrQeXH3AVdk8bB0Lo1F/aC3XEhBLlKqOzPo56QH65eSFMd
	/V0r0VpwBP4swd1uC0Tv31+lkcOhhPBm0suDYNDFo7j6CxEN7ThX2e+2ahu8BN7fr00ifatunYpNb
	Dygc67x7AfteS0FWylaBxnLVzWa5D08Dky4nOf/iO6myZUeBtA98qTp/VDvS3DpQ6waGJsiLcIwUp
	1l9cIh9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8zMn-00000003MZZ-2rw4;
	Sun, 27 Apr 2025 10:36:09 +0000
Received: from mail-ua1-f51.google.com ([209.85.222.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8zMj-00000003MZ6-2bus
	for linux-nvme@lists.infradead.org;
	Sun, 27 Apr 2025 10:36:08 +0000
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86b9b1def28so3747171241.3
        for <linux-nvme@lists.infradead.org>; Sun, 27 Apr 2025 03:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745750164; x=1746354964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljk43xtIhuZJm+NVg03EJzyD0vryP3mX6f5pOhBhi5M=;
        b=RAuiexxJar/w6HN7KSrG+/DxYBSKKZXVZVtAqLnVQhZthd+gXXtzzyVNbQB+A2bzmz
         ciHWDKffWUq2xm/iHorl7fJvPQGOt8Ckpfjt5V3KxgAyrDxjSwzTYpv8C+4Rnq8fdGDC
         7BD2lZ90sy7/pHQQptg80YXtWCcjr4lPBicgHDOrF8RW2gYP2zvPuKWFBrMbKCZhZP6U
         ekvPfjvHwgof5PSuMMFDzHc2oOyyWu9JHM91UhfTHY0zHY3RXND1E7+WWoWCcSFoBfQj
         os+m8Mf5fZy5I93SroQaICl9U8j4COgSUheQBWcOrP2QjBPEF5+DeBRMJpbk/EBTbd31
         wtUA==
X-Forwarded-Encrypted: i=1; AJvYcCXmMKTiDMyavg34oEt9YvVWCdS1Ye3CJ6aMEvIfhBOjhs7lJ4Vegf0d6EReIqeEgloF597EUGUulmMl@lists.infradead.org
X-Gm-Message-State: AOJu0YypZMOn1aowNWxV4m1kYm2H8Xyy244DZdcfFDeHPweYvSxy7NKb
	2dqDDOpYhuZe86Rxp5Qo/LVyaqhWIYMa7BPBwU0/5VximeEYtx35
X-Gm-Gg: ASbGncvstQsZwtFyrdDeXNcgmhzRqtUnlfG89t3pFg8RV6hbrG1AV2W4liZ51KPXftS
	yuLPK9JDYpV+bBNgj4tYH3q5d3Jm6b91QKcCWh2gYXhP4qA/bv7OVN4WodPwOwjN1eI+FkpRxFu
	Mn/Fx4+/nJWu0cGDkw/XAaj5rSzamxd+ZxDpr6xyX2t5VglKiqOJ5aoM3fe66AH1qvKwBE8IFJx
	UZ0AjaEzmzbg7XnZ8TOdXN1eC/YNFZHvmoghDc5eupqImsmRoMzxqLtPnmjgD/7LyrhGwsbpMdW
	UHtPH81l2uhy3te/dK/zfzLU7xuvET8QlcGhv2vojHFbzIeGVQmzl9b3EiCgRuT6Z4MXGvICCQ/
	xn2V2UQ==
X-Google-Smtp-Source: AGHT+IEWN/Z+lcHCHdSSurBYIwDx1JiFa+lFycfW37ELCCHQvRjgcZvceu15Ch5wfcslFG+AGnsmnw==
X-Received: by 2002:a05:6102:15aa:b0:4bb:9b46:3f6f with SMTP id ada2fe7eead31-4d5432e770amr5426524137.1.1745750163672;
        Sun, 27 Apr 2025 03:36:03 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4d3d75bcca3sm1489618137.25.2025.04.27.03.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 03:36:02 -0700 (PDT)
Message-ID: <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
Date: Sun, 27 Apr 2025 13:35:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Hannes Reinecke <hare@kernel.org>, hch <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chris Leech <cleech@redhat.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_033605_663924_E6862993 
X-CRM114-Status: GOOD (  17.29  )
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



On 26/04/2025 2:47, Kamaljit Singh wrote:
> Sagi,
>
>>> Right after the check sk_stream_is_writeable(), there could have new
>>> room in the socket
>>> send buffer, state_change() fired, and queued io_work, before we get
>>> to the pending
>>> check. This is the "lost event" problem.
>> Actually, this is incorrect. write_space() -> queue_work(io_work) will
>> be re-queued if io_work
>> is currently running. Hence I'm not sure that this flag is needed.
>>
>> Kamaljit, can you run with the below and report if it fixes your problem?
> With the last set of fixes that included list_del_init() you suggested, all
> tests have been stable. I'm not seeing any more issues. Are you asking to
> test this patch regardless? If so, does this need to be in addition to
> previous patches?

Instead of my patch that introduces WAKE_SENDER - apply just the change 
below
that looks at sk_stream_is_writeable() only. I no longer think that the 
other changes in that patch solve anything.
>
>
>> --
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 4d20fcc0a230..835e29014841 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -1390,6 +1390,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>                   else if (unlikely(result < 0))
>>                           return;
>>
>> +               /* did we get some space after spending time in recv? */
>> +               if (nvme_tcp_queue_has_pending(queue) &&
>> +                   sk_stream_is_writeable(queue->sock->sk))
>> +                       pending = true;
>> +
>>                   if (!pending || !queue->rd_enabled)
>>                           return;
>> --
> Thanks,
> Kamaljit


