Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8FEC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 21:49:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94DA64DD7
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 21:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94DA64DD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OtRbSpgrslfhNlEdpch2aiIfL7mptKBc00GPKB+t7I4=; b=Z5TFVB2iLZ9D3oMAsaCvqlnUW
	JyaSeFNOmFToO3kxkuZ1zArt7IXs0cb9onUt6onWyVOEs1iXPjYJutKaZLeCzkqr16Z2lji5ZeIvC
	dT1FHqukIdpLJsScAzbtElUek7f0ZDf/rSSvASjntY7zlS9XlWc+LZxTTcJPiYoTScwqIVvlvftXg
	Lu/0C5sTsQ66AQPq9ZPIOGUq/ChyOa1kKfa0MTJc2aUnFGRviM8DXhTV925c3mwoBeQhkQh07Pfr4
	yI+G1hmbtIUBO4y29KohqvYXF6WvCpKQdQuWZrwODRXTN/NFqdvqILfUIs/ybdcLMGkeutwb5iAgl
	px2/qdqvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAgJl-0006Bw-Qe; Fri, 12 Feb 2021 21:49:37 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAgJj-0006BL-Jh
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 21:49:36 +0000
Received: by mail-pj1-f54.google.com with SMTP id t2so390774pjq.2
 for <linux-nvme@lists.infradead.org>; Fri, 12 Feb 2021 13:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jdhUE6AJwckEzLe2vZNYXa3k2eiehtjxGthdtA7Iw8M=;
 b=rt751f3MbL7GlelPTpN8L0HLY8MdEK6bUF+4IfHzdsat3EdI0wVnRYxSoWSG8QZrBu
 Oe1WNv1blA+BtUMZzyF3O2XamhsVrW3HGijeysPVYBWu26DJtaWXexvjlBOHwP3AzILA
 9YScpZMVrl5yztI5AoVWJoAYA/hM/8pwIGbd6rrp2Q1gaFw/2k20bA1vbqAmhe7MN9zF
 qncSDGFTpBbb6IrJaw7fxpB/foOnjGcvM5BLA/gbc3Zgh8IUkFXYonvzwvZLGQ1QDemd
 Q5Zd5k3KEWayr5icfN8u7qWt7jpPgerYst40qShRiDay3wQ245VdD+UVy0m0T+W208+r
 Fanw==
X-Gm-Message-State: AOAM530BtYeqNt62YkqykdBrcooUbWJ6pbArAedlhWNVdnJN09Rika1L
 89lB534irU16IOlbb0mAyLWBZuUTZ1c=
X-Google-Smtp-Source: ABdhPJzfOgkCemMLAmE6h3yy00IMHAt7MkNxbH8p24zFjAg+5sJ+TeEmKeS39ij6skGH4l4XzFK9Pg==
X-Received: by 2002:a17:90a:fc4:: with SMTP id
 62mr4443004pjz.181.1613166574378; 
 Fri, 12 Feb 2021 13:49:34 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:65a3:c687:b052:ed7b?
 ([2601:647:4802:9070:65a3:c687:b052:ed7b])
 by smtp.gmail.com with ESMTPSA id h11sm6879975pjc.27.2021.02.12.13.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Feb 2021 13:49:33 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Keith Busch <kbusch@kernel.org>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
Date: Fri, 12 Feb 2021 13:49:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_164935_806235_C52E86C9 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: Daniel Wagner <dwagner@suse.de>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> blk_mq_tag_to_rq() will always return a request if the command_id is
>>> in the valid range. Check if the request has been started. If we
>>> blindly process the request we might double complete a request which
>>> can be fatal.
>>
>> How did you get to this one? did the controller send a completion for
>> a completed/bogus request?
> 
> If that is the case, then that must mean it's possible the driver could
> have started the command id just before the bogus completion check. Data
> iorruption, right?

Yes, which is why I don't think this check is very useful..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
