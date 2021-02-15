Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D81EC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:30:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912BD64DEB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912BD64DEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MxT4WToQPjjsib+CIeDrcNJmhYBwCdL+PqGEPy50eaY=; b=vHu3H18hmjc2d36COTWDzfpPM
	E4v0hIzegIx/afFiYC+n7R3NoOdUJe+ARVaGIQ6+OqvzpdLNDRybOEHXALvnmbVyUd+ZHb2i0+EK0
	6jz5tjSWQWAaMeVH1a+KOmFXpUk9jntD/2E4MzbIcDOV7u33vQP9ofWJf9sX1MbNN5VHk/fGztEMf
	RtNc8ZBF0798dhu+09omuK7jZTR+7gcnGuqtHmlHzQSv1ayf5YSIvPe+swy1YxvwF9V35g6ZyVnDj
	Pvpy15Rq6A41bbZo66nKWGvxJSL6canSQhri2o30xGtq28jbmth0+PVZgaTQaKx/qXmfQRlCqv5g/
	D5cGrDI6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBlRK-0002xE-2H; Mon, 15 Feb 2021 21:29:54 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBlRG-0002wb-T8
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 21:29:51 +0000
Received: by mail-wr1-f50.google.com with SMTP id v15so10746326wrx.4
 for <linux-nvme@lists.infradead.org>; Mon, 15 Feb 2021 13:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s+MKjbp2tjims7Jwguvyk6qEwa7KWs9qt/eX8yJuFUE=;
 b=Qaubwwjr1kAGCjjxcKcwhvuUlrACgXninhFUPDjw+v9DWu6OzIxSZUCnxR8ti2+bXl
 YOiUX1IsurNSWLfj5D2dKn35uQ1L+b89zlPj0yj8zhkgt7irPuUA7PBdEh7tf7n8794l
 0L/KZQbDGcRB3slEA7I9Oxu9StzwsVBXajHerrQEo1WwC4YzmZg5DfQX98wlobhNEqnJ
 yNlAwNq2/H2InMBHct1bDn5zB7PhopEFcaBS19WLNYTWvF82fwQUEJjORSX2PYTR5dwF
 Mmg8S6mcdza5bR/wfN+zXFVXTk8tcxeharMNU5Qs4mnPhJwwyd7Cd9Xu5AfCcBY05Iit
 49Lw==
X-Gm-Message-State: AOAM530Zp2zMHiQICE/CBbmhkxfapgqzltcvBiHasdZDQZKP+Z5Ueh9X
 CCHRjt9S59C/1bWIYVyEFOUzm2Eanh0=
X-Google-Smtp-Source: ABdhPJw81FppzKL8jTGA+041elKQYqU7nKWWWBkvJlCJ0s088DeXwoU+R0hK9cwl1gnpxfN6zAbrRQ==
X-Received: by 2002:a5d:4e41:: with SMTP id r1mr16045804wrt.6.1613424589846;
 Mon, 15 Feb 2021 13:29:49 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e348:9c6c:4cb7:8321?
 ([2601:647:4802:9070:e348:9c6c:4cb7:8321])
 by smtp.gmail.com with ESMTPSA id j71sm615134wmj.31.2021.02.15.13.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 13:29:49 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
Date: Mon, 15 Feb 2021 13:29:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_162950_989023_1D02F100 
X-CRM114-Status: GOOD (  18.77  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>>> blk_mq_tag_to_rq() will always return a request if the command_id is
>>>>>> in the valid range. Check if the request has been started. If we
>>>>>> blindly process the request we might double complete a request which
>>>>>> can be fatal.
>>>>>
>>>>> How did you get to this one? did the controller send a completion for
>>>>> a completed/bogus request?
>>>>
>>>> If that is the case, then that must mean it's possible the driver could
>>>> have started the command id just before the bogus completion check. Data
>>>> iorruption, right?
> 
> 'during TCP LIF toggles and aggr relocates' testing the host
> crashes. TBH, I do not really know what is happening or what the test
> does. Still trying to figure out what's going on.

Well, I think we should probably figure out why that is happening first.

> I was just very
> surprised how much the code trusts the other side to behave correctly./

What does pci/rdma/fc does differently? What does scsi do here?

>>> Yes, which is why I don't think this check is very useful..
>>
>> I actually view that as a valid protection against spoofed frames.
>> Without it it's easy to crash the machine by injecting fake completions with
>> random command ids.
> 
> In this test scenario it's not even a spoofed frame; maybe just a
> confused controller.

Maybe... I am still not sure how this patch helps here though...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
