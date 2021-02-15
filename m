Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED64C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:24:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54F6564DF0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 21:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54F6564DF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JbtZXyAaYXBXd0Rk2sDS2dClihu8g0oBDxmntoAQ+Ig=; b=s64LvOWIluVW2Ht7EpJakFs7q
	4xmWuYpnaERBkvbaWzfAZbNYvfHxyC1psKQA96lp1I95gKUTVmdfUnBwo+oAa2U7AmIpKbapOnBns
	z2SUJ+NRGI/8YGGUTNUqE6+xQJH5PKovdK9kZLIrHm5gItQqvX+ZV3TQC51KVNKphJ2nhy80Em2hP
	hnAb4wenlUVbLfdPvtFkgT+a0Wlg9zv6WvLaYQfbrez+rgM7ldz2H71dNFcLUNHJRZDvgHcid5C+r
	Fww6Wgo96CDg63MqWwDc9lo7ctk8Zx2uF4FEh/zDzi+rMfcQ5YEgWhD+iTkS/xzs9Yq4vJWtrsKBR
	0bonnRSnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBlLh-0002Rt-Jq; Mon, 15 Feb 2021 21:24:05 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBlLe-0002RG-WE
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 21:24:04 +0000
Received: by mail-wr1-f50.google.com with SMTP id t15so10660021wrx.13
 for <linux-nvme@lists.infradead.org>; Mon, 15 Feb 2021 13:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9WE7sfWuADZEgBkO6VBLoyU3Kt+14QI5HCaf9dRKQr0=;
 b=sdElxloTlJ87D0cUPR9pfqYZnxSS099tWEubbwYq/dFLh4hVfN/6/Z1jowbZh5bj4c
 ZG4uylUVgR+Hee+hddt5V3BaRAy8yfkCI7LQpdQhKgoC/VCxct0KBhzPMlUBYNb0sQyX
 VM1avan+z3whFCa5g3JZLZtrMsugSgGCDf6YL7uLvefJk2MQ72FL2JpgTtSKCtJyQv+k
 /86h3hkFm0jZpch1njELnuiioR4oNam6aKvTw9pFIZQ5TXifU8rBcXGb4tRcZDELTuRk
 pcBFa9b6YEejJGdoGSeoVE8rQ94uc9ZJCpVjSST6Cs2S6NeQT6eXFljHz/D9593WF9gV
 9YHQ==
X-Gm-Message-State: AOAM531Zh6K+sO/6uQ1qoSle/LNbtkq6Fg+AQqnShNpsczf0mbdz2EEp
 M4K3WKOUKajg+u+3G9fO4Yo=
X-Google-Smtp-Source: ABdhPJyOdMuEiNm8u20zTsF8TOp7tAyT4IUWQCToD1uMnEiSwNxtuc3/Htz4clHlcbiBTWYOQf6beA==
X-Received: by 2002:a05:6000:242:: with SMTP id
 m2mr20027397wrz.422.1613424240136; 
 Mon, 15 Feb 2021 13:24:00 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e348:9c6c:4cb7:8321?
 ([2601:647:4802:9070:e348:9c6c:4cb7:8321])
 by smtp.gmail.com with ESMTPSA id t6sm16067655wrn.96.2021.02.15.13.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 13:23:59 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5b45835b-eb81-29e8-e319-a8509474e27f@grimberg.me>
Date: Mon, 15 Feb 2021 13:23:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_162403_097300_52EE4B08 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: Jens Axboe <axboe@fb.com>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>> blk_mq_tag_to_rq() will always return a request if the command_id is
>>>>> in the valid range. Check if the request has been started. If we
>>>>> blindly process the request we might double complete a request which
>>>>> can be fatal.
>>>>
>>>> How did you get to this one? did the controller send a completion for
>>>> a completed/bogus request?
>>>
>>> If that is the case, then that must mean it's possible the driver could
>>> have started the command id just before the bogus completion check. Data
>>> iorruption, right?
>>
>> Yes, which is why I don't think this check is very useful..
> 
> I actually view that as a valid protection against spoofed frames.
> Without it it's easy to crash the machine by injecting fake completions 
> with random command ids.

And this doesn't help because the command can have been easily reused
and started... What is this protecting against? Note that none of the
other transports checks that, why should tcp?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
