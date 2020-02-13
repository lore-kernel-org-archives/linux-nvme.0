Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA90AC2BA83
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 07:19:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CFB2173E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 07:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QYgbscu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CFB2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QlnZHeYTIp99YFlcr1HFlXwxXbRNb3sEd3swj0r8XDY=; b=QYgbscu+N2++SMY4IDoCfWzqN
	UN1F3SbEApNCqYyCqJP4jC/BhuOuztVmt9VQ83sFRCJ9sMK0VNDWUoEmLHFnmj3pOCQgF6wCwYQm5
	xmLlS8Qxr+Dt5FraKhCeXU3y8q3dNj3yblCGLDLz6U0b/Gm//LOYxAh/yi2RCvGtxdA9/eEO672Eo
	m+FR/WeFrB1Rh7eB12VrfUY7UrEPYvOw5OVwNqT7W3e7IiQbSREVgMR0ycpbWigIKCp3qSoLtzpWn
	51KgI3InEodjglSIe9fHAKd+qdd/aAlumUyRaXz6zpQNGB5B3uQt9/bKObnvyXy8uJ/AxcDFdRAg9
	eCT3aY/nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j28mu-00042J-PW; Thu, 13 Feb 2020 07:19:52 +0000
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j28mp-00041c-6Q
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 07:19:51 +0000
Received: by mail-pg1-f194.google.com with SMTP id z7so2596886pgk.7
 for <linux-nvme@lists.infradead.org>; Wed, 12 Feb 2020 23:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ja6gf9MEaqrvOgwUuoyyxMjAaR/r4VgMZk91XtYd5zQ=;
 b=JusVIiwbSUbxDXHty2H+3kl+hRKTM+OyzK7J1NDxsFmi4LEbMWEdWkVwmE+R6LGmmu
 xXIqepXTD4kfLda9hVUtLKWuwRK3ND3RJpaxDD0h8N6xTKZDVTw/j+lbXMQ9YQFbbmeL
 JsQd8m3rqPsFbbHtdXrkYoZx/tS04HScyW2sPYTyA/5NL7wOpcYdz9sbzg7u85ocRvYP
 HRKaKylhJmRf9rA1j+BT7lKWpSIKE4DDzxj1e7yU2F6TXyMpmXORrIAvwIeeDnI8ewiS
 +y8tnMdoEvp+2Ly3a32a7ERTCBAuZ9fxeDw79zBCucZjWctrJach3HMx7Ej03cIE8va1
 W4Ww==
X-Gm-Message-State: APjAAAVn8Tt3BTRqj4ouAvDDjpZ/zOC7JAco8e/2jG4MkP+Ch0qTZV8G
 cHv0KraR7a2bV0GQ20dl0LU=
X-Google-Smtp-Source: APXvYqyVNNoRvxNzeNBTSOzSBwww4czI1uC5Q48rUUsuSsN/u2kADaJcxqyi0JTreBjolnxD66+fbA==
X-Received: by 2002:a63:1b1d:: with SMTP id b29mr16638328pgb.111.1581578382450; 
 Wed, 12 Feb 2020 23:19:42 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:c458:cda5:e3f1:f123?
 ([2601:647:4802:9070:c458:cda5:e3f1:f123])
 by smtp.gmail.com with ESMTPSA id v5sm1494867pgc.11.2020.02.12.23.19.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Feb 2020 23:19:41 -0800 (PST)
Subject: Re: [PATCH] nvme-multipath: do not reset controller on unknown status
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200212134140.105817-1-hare@suse.de>
 <20200212175317.GA5813@lst.de>
 <6d4d18e3-c3a1-7d93-5abf-1ae46e18ca8c@grimberg.me>
 <3345c55f-3a42-315b-1d62-20f9aaab296e@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9e1ff8a9-8151-678e-3634-ae7272ddcd00@grimberg.me>
Date: Wed, 12 Feb 2020 23:19:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3345c55f-3a42-315b-1d62-20f9aaab296e@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_231947_234210_D53545BF 
X-CRM114-Status: GOOD (  19.26  )
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
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 John Managhini <john.meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> What will happen in the common case? right now it will just retry
>> it on the same path, is that the desired behavior?
>>
>> I guess we need to understand the phenomenon better.
>>
>> Right now the code says, we don't know what went wrong here, so we
>> are going to reset the controller because it acts weird, which can
>> make some sense, given that the host doesn't understand what is going
>> on...
>>
> But this is precisely the case I'm arguing against here.
> One of the lessons learned from SCSI is that reset only makes sense if
> the system misbehaves and resetting it would make this error go away.
> 
> Receiving a status code which we don't know about does _not_ fall into
> this category; the very fact that we have a status code proves that the
> system does _not_ misbehave.

Fair enough...

> So what exactly will be resolved by resetting?
> There actually is a fair chance that we'll be getting the very same
> error again...

Or not, we don't know.. That is exactly the point.. But I agree with
you that resetting the controller may not the best action to take here.

But, you didn't answer my question, what is the expected behavior here?
right now with your patch is to blindly retry on the same path, is that
desired? is that always desired? Please share more details on the issue.

> Consequently I think that resetting the system here is wrong, and we
> should just handle it as a normal but unknown error.

What is this unknown error? Was it what John complained about a few
months back that the array returned a status code that translated
to BLK_STS_IOERR which is considered a path error and the host reset
the controller?

I think I'm starting to remember that this sort of approach was
suggested... I forget the details though...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
