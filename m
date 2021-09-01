Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6C9C4320A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:49:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7180360E98
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7180360E98
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MRIqKQa7Whv0GDoEp/P4D+jBZuP7+3YH5/XuiOQFo9w=; b=O+lsxqIE6odwCBnFBXF1KeKIU5
	RWRVQSnsaGdyNpwWMfJ65Fm3KRiOeXZC2++erUGgbcwgI9FqELqVOJo0ioIFVjdsd41eI4BhLn+av
	CDOuR3+/QuQT8j7UYygkqw9OeFrQgja84L00nZi77i2gCB2MtMk3cAgxM1Ch6i5W3Yb7ev5SxXNbI
	JfPk5/q3T6QKkj2SoCywJBIlpRxeHvbaaSIQK6SGlG9yCTRq8ussFSl1BeygYwmd1qzhnvc/pPjiz
	ZJ8fK7QsXg+LZUgERS5GCfu2jW+aQXyCOE3m09xJAA5d6HOBlH06r8jvYT9Pl2nAPOTT08tca2wG8
	L3gfRqZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLPgN-0064eO-KW; Wed, 01 Sep 2021 12:49:35 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLPgF-0064dd-L4
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 12:49:29 +0000
Received: by mail-wr1-f50.google.com with SMTP id b6so4296739wrh.10
 for <linux-nvme@lists.infradead.org>; Wed, 01 Sep 2021 05:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1WckK7fEaSWpG8duascHkujn2Vx8Zlck6TFr81ItVU0=;
 b=c0BKb0zWtj7TRZM08pJt/n536rU3pkBrQd00mUm1/O704wXJJVOa/cB/Y3FS4pCarD
 cpGB1PP1ewe8EgUoBg1bJH/ZW09z/yasvSjXv4PpoZCbTfIS7qNWJIYnQUDwvLBFPkjx
 Drjr01BlbZmN+ThJV4XXTp1G+ET5zMYIlI4h4CNKsosMuPHlvm5tc2d0jZe16m0oAQAu
 1yXJsVvm8inZqsMy21maACZh1d94pjmVn82GV+T6PY5/PtjbBOwsjDNXU94yKrfXl2ia
 cM6XSzQZ1miKwEVFYoicW2PS6+PTm2u8O7BJHu+iecmMPqKTmPqVbUcgR7ABp9PDt+MA
 HxHQ==
X-Gm-Message-State: AOAM532P4rJZxDDaikP/BIONKQjLyVzjrPAoIfqbH+7WhzRa9+iQGL40
 d72ydEtAUGzJOdf4gpnKdI5qy6jN1oA=
X-Google-Smtp-Source: ABdhPJyUF/Wc1qFfVk0FA+XcK+t+W0klQtlHBzp1v3DkIq7F1znL2YCdnisblRJCd55Yqi7wSah2jg==
X-Received: by 2002:adf:82aa:: with SMTP id 39mr37797333wrc.9.1630500564713;
 Wed, 01 Sep 2021 05:49:24 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id q13sm21159235wrv.79.2021.09.01.05.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 05:49:24 -0700 (PDT)
Subject: Re: nvme-tcp crashes the system when overloading the backend device.
To: Mark Ruijter <mruijter@primelogic.nl>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1A17C9D4-327C-45D6-B7BB-D69AEB169BBD@primelogic.nl>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <11cd3514-570a-8bf1-55f7-cda6cacc7124@grimberg.me>
Date: Wed, 1 Sep 2021 15:49:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1A17C9D4-327C-45D6-B7BB-D69AEB169BBD@primelogic.nl>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_054927_767430_FADE000B 
X-CRM114-Status: GOOD (  22.92  )
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


> Hi all,
> 
> I can consistently crash a system when I sufficiently overload the nvme-tcp target.
> The easiest way to reproduce the problem is by creating a raid5.
> 
> While this R5 is resyncing export it with the nvmet-tcp target driver and start a high queue-depth 4K random fio workload from the initiator.
> At some point the target system will start logging these messages:
> [ 2865.725069] nvmet: ctrl 238 keep-alive timer (15 seconds) expired!
> [ 2865.725072] nvmet: ctrl 236 keep-alive timer (15 seconds) expired!
> [ 2865.725075] nvmet: ctrl 238 fatal error occurred!
> [ 2865.725076] nvmet: ctrl 236 fatal error occurred!
> [ 2865.725080] nvmet: ctrl 237 keep-alive timer (15 seconds) expired!
> [ 2865.725083] nvmet: ctrl 237 fatal error occurred!
> [ 2865.725087] nvmet: ctrl 235 keep-alive timer (15 seconds) expired!
> [ 2865.725094] nvmet: ctrl 235 fatal error occurred!

This is the target not getting a keep-alive commands from the initiator, 
hence it triggers a controller removal. btw what kernel version is this?

While the target is tearing down the controller queues, and waits for
all the inflight commands to complete and drop the final reference on
the queue. I'm wandering if something is preventing these inflight
commands from getting completed by the backend R5 device.

> 
> Even when you stop all IO from the initiator some of the nvmet_tcp_wq workers will keep running forever.

That is because the target is waiting for the commands to complete, but 
they don't.

> Eventually the system runs out of resources.
> At some point the system will reach a workload of 2000+ and crash.
> 
> So far, I have been unable to determine why the number of nvmet_tcp_wq keeps increasing.
> It must be because the current failed worker gets replaced by a new worker without the old being terminated.

Is it possible to check if the R5 device has inflight commands? if not 
there is some race condition or misaccounting that prevents an orderly 
shutdown of the queues.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
