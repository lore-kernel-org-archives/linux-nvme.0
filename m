Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D5C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 20:57:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D1D64F8C
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 20:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D1D64F8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hrf34tf0uExnmUK5M6pd1gge2IHKMZblcbUpHn91B5g=; b=DD7pjKoOzwtMgjryGyXNgopCU
	/Av0viZ3wPEhVugp95VN+JU83qw55UDkndLpJnSMC0AfjNRLYkEFXBvaZyne/EA6x39hMzU7u5Zxz
	mhy3raTSHo5bZNH1JAVi/wtdWucWR0ywlgQ/FXlQFCKaoYCuVwgntcori1R4rGhVB0xcBgdtwjyq1
	jukwuup/+tl3h8UU+eScZoPGyPysmgxG2gMFZm3ditbdUQMWblS0nxeVAzMZjIf4ZUxeY1FUS1uPj
	Rng9MU2v6nVuf7KMYyA4VpkjTr/y5rTAZyuURSztN19y8DGCZcoUA7YDQx1rciqr3BSb8fkxhD9O3
	zjPfG+A4g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMGku-001qza-2n; Tue, 16 Mar 2021 20:57:32 +0000
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMGkn-001qxs-Ci
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 20:57:27 +0000
Received: by mail-pg1-x52b.google.com with SMTP id g4so23452385pgj.0
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6ml7nGhagqBj6L8RCV9bHV+wdSY6fwo4DGB3ZmUTZHE=;
 b=vJmVv190e2zSq0tWiQHNNRkNLYU5ZAz5DwoWTRKaO2p/cjGG7rI28Szn2OoYEc/+Fg
 8K5GYZQmyAkDeiu2eHlAp74hDZN5uYlgtSCcNlSy5qtdIxjqZN6xKytVtGyzJgeLct68
 /8Iu4urXH7sRDS6YxaQbnh61NL0yXEHbenOjjfQnhFHwTjKLkOpMWn5W8c2OeBkWXhut
 +floH81P0XT0zCgn6Umj2CkKHDxTh0tLALmvIK+aG2mUMa/P09U2e7rAQ3SrjNx6PE2/
 Hz7GP4las7L69TfEzpHNL3Qkh9NPvuxYZsW/LXH8bV2xRBhqhOMeumsTKBhVTWuBqb+n
 CrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6ml7nGhagqBj6L8RCV9bHV+wdSY6fwo4DGB3ZmUTZHE=;
 b=Z00Hr7A/XXMANKn9n9GgLmeeBW9e02LOSzXE2cRv/cSN4CgAD+5+nwoet4zuLWxPMn
 sLrk9bGv+hH/Sxr/a1fOLJ/8q9FqCpqkZ4RTLWowlY3tG4pa2cHOr4ySrB/mI4fZzAgg
 s53plpcGFg19dJ0dSx86CwjtQGezT4slMJMJyDPC6pWA+y7enzp5ghDf/Jurgn5u0MnE
 YVjdwh55seGqjRO2y7allQE6yca0wgxm+58iKJMK6R+JpFssiDKJxTfiPo+1AXC8xwTo
 L9yhr/sLZXpw/nvMI+HE6c9ZW8Ps0Djm8FF7gCRocHNvYn/wIR8vf9+pB6f02uf0Y2TF
 cZkw==
X-Gm-Message-State: AOAM533kyC0wjmUBTzoB9DtPcNpbgUt7mTyYxOaLYmvKbC3C2gNW/r+i
 71voFkExR5XdU7AqnCLjLhk=
X-Google-Smtp-Source: ABdhPJwhd7mQjgFK3nDg8PMKgWuvYHrR16hupwxxVEP7V7zCdK5srtaH9GB6prxlJnx0zx5GZfEgXg==
X-Received: by 2002:a65:61a4:: with SMTP id i4mr1362602pgv.39.1615928242118;
 Tue, 16 Mar 2021 13:57:22 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id 184sm16739566pgj.93.2021.03.16.13.57.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 13:57:21 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
 <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
 <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
 <aac125ec-561a-002d-7054-782ee450067e@huawei.com>
 <20210316020229.GA35099@C02WT3WMHTD6>
 <21bc3b62-967c-6cb2-c9f3-7da479aef554@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <63ed162c-77a7-105f-5f29-47fcd32f57cd@gmail.com>
Date: Tue, 16 Mar 2021 13:57:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <21bc3b62-967c-6cb2-c9f3-7da479aef554@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_205725_776657_45A2E371 
X-CRM114-Status: GOOD (  22.83  )
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

On 3/15/2021 10:08 PM, Sagi Grimberg wrote:
> 
>>>>>>> A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in 
>>>>>>> nvme
>>>>>>> over rdma(roce) reconnection, the reason is use the queue which 
>>>>>>> is not
>>>>>>> alloced.
>>>>>>>
>>>>>>> If queue is not live, should not allow queue request.
>>>>>>
>>>>>> Can you describe exactly the scenario here? What is the state
>>>>>> here? LIVE? or DELETING?
>>>>> If seting feature(NVME_FEAT_NUM_QUEUES) failed due to time out or
>>>>> the target return 0 io queues, nvme_set_queue_count will return 0,
>>>>> and then reconnection will continue and success. The state of 
>>>>> controller
>>>>> is LIVE. The request will continue to deliver by call ->queue_rq(),
>>>>> and then crash happens.
>>>>
>>>> Thinking about this again, we should absolutely fail the reconnection
>>>> when we are unable to set any I/O queues, it is just wrong to
>>>> keep this controller alive...
>>> Keith think keeping the controller alive for diagnose is better.
>>> This is the patch which failed the connection.
>>> https://lore.kernel.org/linux-nvme/20210223072602.3196-1-lengchao@huawei.com/ 
>>>
>>>
>>> Now we have 2 choice:
>>> 1.failed the connection when unable to set any I/O queues.
>>> 2.do not allow queue request when queue is not live.
>>
>> Okay, so there are different views on how to handles this. I 
>> personally find
>> in-band administration for a misbehaving device is a good thing to 
>> have, but I
>> won't 'nak' if the consensus from the people using this is for the 
>> other way.
> 
> While I understand that this can be useful, I've seen it do more harm
> than good. It is really puzzling to people when the controller state
> reflected is live (and even optimized) and no I/O is making progress for
> unknown reason. And logs are rarely accessed in these cases.
> 
> I am also opting for failing it and rescheduling a reconnect.

Agree with Sagi. We also hit this issue a long time ago and I made the 
same change (commit 834d3710a093a) that Sagi is suggesting:  if the 
prior controller instance had io queues, but the new/reconnected 
controller fails to create io queues, then the controller create is 
failed and a reconnect is scheduled.

-- james



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
