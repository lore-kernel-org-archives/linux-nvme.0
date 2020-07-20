Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0574EC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 23:15:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D1A2065D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 23:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1dUY9pVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D1A2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uHqI2KI2OEBNft5cqrkYNil1Wn2jH0rHVNwSeS0jRfQ=; b=1dUY9pVkd/bJiJhf5b7+Y/0RJ
	EnMY77yokIqZeImUywvY6HV+RbNWXgFVh3nR5XLpsgfHPOB6mni4q+jurOb5vz9FkJv0FfkCMc8eq
	HpLOodC/XpPtYZthkR4a865/LGeVa9g+U9YM2p4klz0phUJRyP9oU5wMa+ARXxacPPkUSxYEmhe4H
	Hw+RrtXJXOyxTE2opBkh5mM+MS7Js/ttfYuJdV2FH/uFmbiDien6xBgBwOLZf2/fgyZ2fUZScloQl
	8G3SMY1GYdPrDqmm/wM/wvlG5TV/r2gHavcNIz1bkzadV6C3GM9WQv+0L8/LxVfhBQH34lz3ZILlS
	r3kMbafxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxf0T-0000Pk-PP; Mon, 20 Jul 2020 23:15:37 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxf0Q-0000PL-Uc
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 23:15:36 +0000
Received: by mail-pl1-f193.google.com with SMTP id x9so9410812plr.2
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 16:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8MdlYlmqeapz+lWES5DzlofRg8ebONQpfWbq8TC/AcE=;
 b=DLHKe7ESeQaQNIgnCRGiHsy/f33XXRO8OnpUGnriSssyvW049wwlqA2f0WWE2bkZg3
 zlbQ7MoDUnewUmfM4cj5apor+Pqt0nB2w53F0mQjdb/bZx3iNPLWIcqnbqDpHqbeKcJF
 zTHq/sHpsueiX6DC/ix3cAXr6Y+bAnaTbkh52ZZb4CGef+b/acOQBqd5eb4AaO/PY8Fu
 f3H7PGGdcO5PAmHuwDmbk50l+8s+MgpBvNSwwWAWcb4uypV1T/L9B+YLxsbA5XD5sjGX
 S81S+jxSRfpAU2XhwWmHyQzJ+ZhI5Xc2Cim9BqCpwCn9sXACgCD+G7wRDG6IVQTwm/ka
 XTdw==
X-Gm-Message-State: AOAM5330iCpN2AXy6PZ5wCreYzfxJSAFhe1s+nMMTXAuX2NRxcjpLblb
 WJGqoWKbwpmX4YYEwBeiLFE=
X-Google-Smtp-Source: ABdhPJwbJoyhAgLqcBDDHOBujk/HlsFuCFkXaqar88knZbTDRJMGZtq/wh80vgsj1WSZEMX0aeVy0g==
X-Received: by 2002:a17:90a:bf02:: with SMTP id
 c2mr1625764pjs.114.1595286933772; 
 Mon, 20 Jul 2020 16:15:33 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id y27sm16821780pgc.56.2020.07.20.16.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 16:15:32 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b395c041-9ecf-4239-2cc2-4ecbfe2a550d@grimberg.me>
Date: Mon, 20 Jul 2020 16:15:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_191535_177165_8272E4E2 
X-CRM114-Status: GOOD (  18.47  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Thanks for the review Christoph. I think I should be able to make all
>>> the requested changes in the next week or two.
>>>
>>> On 2020-07-20 1:35 p.m., Sagi Grimberg wrote:
>>>>
>>>>> I'm still not so happy about having to look up the namespace and still
>>>>> wonder if we should generalize the connect_q to a passthrough_q.  But
>>>>> I guess we can do that later and then reduce some of the exports here..
>>>>
>>>> That is a neat idea! should be easy to do (and we can then lose the host
>>>> xarray stuff). I don't mind having it on a later patch, but it should be
>>>> easy enough to do even before...
>>>>
>>>
>>> I sort of follow this. I can try to work something up but it will
>>> probably take me a few iterations to get it to where you want it. So,
>>> roughly, we'd create a passthrough_q in core with the controller's IO
>>> tagset and then cleanup the fabrics hosts to use that instead of each
>>> independently creating their connect_q?
>>>
>>> Though, I don't understand how this relates to the host xarray stuff
>>> that Sagi mentioned...
>>
>> passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
>> means that the driver shouldn't need the ns at all. So if you have a
>> dedicated request queue (mapped to the I/O tagset), you don't need the
>> ns->queue and we can lose the ns lookup altogether.
> 
> Thanks, that helps clarify things a bit, but which xarray were you
> talking about?

The patch from Chaitanya

See "[PATCH V4 2/2] nvme-core: use xarray for ctrl ns tracking"

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
