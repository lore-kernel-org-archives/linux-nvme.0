Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23335C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:36:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74304218AC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vy47fIf7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74304218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eEfKffgBPRiW8PQKjWbtgUIrLaEkJR3kz3grZhpezt8=; b=vy47fIf7sdKBGMdjMFxmgqCy2
	7ukrZCPwIBCeg/XvO9Fo345B3ujCXIENHYTG0MO3lFrpng6MCUQcmmf1BgQIC3AOcCBH4/D7kAF49
	l+kjgmLa7U8y5FTqayySIHA35c450oAXyzvhxfKD5BGHiYtaVA4m8Kbg02qJQFEIdi9N3sZk86SG8
	Ni+cvOl+xror+/OWntcVOngpus8LnrUcrQe8NGD0AB5jMMQ+NTLP9zQxx5fu+odiXeEv3efi5XJCF
	RGW4bLXQBRf9iu6fLocYcFx7cso4cHJlmy/6ZA5YlkT+NIGgE+BBuLrog3xKeOL4tN/ucQXYCPpaq
	sOc0zn2vg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSSu8-0003Qi-EH; Tue, 13 Oct 2020 22:36:24 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSSu6-0003Q8-Ft
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 22:36:23 +0000
Received: by mail-pf1-f194.google.com with SMTP id j18so752366pfa.0
 for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2020 15:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=22rjIu8LeKR2tBfy7MaBP9NMMuLHR3AZBGqzLdXRcOQ=;
 b=nCjn699YyjmTN3cwq8iiSQy238CFN8ooiM48XrPinlfDDAHlxCt0W9vrp28tzfEX74
 jMLfmlDrPl+P4y6fgBz+l5QvCAUFMKickfKA+7lYQinCVk7YxWMlcXYXG2KqT3Q8EXCc
 QfwJAKR9cTJvmgGoNcbQDmF1gOJf9xn+9M+HY8k42kIOsoZPuDexozbO+nGtxNsCMoy3
 qdGDS/wmA1f6diYgZaSxnsBoe0VHg2dV+RYdvAEzA0rqVL1xh58WH7B2Nd+i2p7knckR
 DHZA84JQvRk4eGsmJpB5mmdBWYDyoonNnPmljEmUpMjhAUfpnMBOBEZ9eRJbsit+uQD4
 AxBw==
X-Gm-Message-State: AOAM531v6bS+yUC8z3/3QggaSEUi6z+U8eJdCXBbQL4i125ikiT75mg6
 JbwznWybY9RiyTi/guXPSB0=
X-Google-Smtp-Source: ABdhPJz3XhhK0F+L5hCMUdSnly23cyfDlL2WAU/D/d9FH+VGCD7dca4A3kpbIBsFJqc+x8SDjrNcUA==
X-Received: by 2002:aa7:95a6:0:b029:155:336c:3494 with SMTP id
 a6-20020aa795a60000b0290155336c3494mr1414214pfk.17.1602628581396; 
 Tue, 13 Oct 2020 15:36:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0?
 ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
 by smtp.gmail.com with ESMTPSA id 8sm747162pge.7.2020.10.13.15.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 15:36:20 -0700 (PDT)
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To: Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
Date: Tue, 13 Oct 2020 15:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_183622_574004_BCA9D04A 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> This may just reduce the probability. The concurrency of timeout and 
>>> teardown will cause the same request
>>> be treated repeatly, this is not we expected.
>>
>> That is right, not like SCSI, NVME doesn't apply atomic request 
>> completion, so
>> request may be completed/freed from both timeout & nvme_cancel_request().
>>
>> .teardown_lock still may cover the race with Sagi's patch because 
>> teardown
>> actually cancels requests in sync style.
> In extreme scenarios, the request may be already retry success(rq state 
> change to inflight).
> Timeout processing may wrongly stop the queue and abort the request.
> teardown_lock serialize the process of timeout and teardown, but do not 
> avoid the race.
> It might not be safe.

Not sure I understand the scenario you are describing.

what do you mean by "In extreme scenarios, the request may be already 
retry success(rq state change to inflight)"?

What will retry the request? only when the host will reconnect
the request will be retried.

We can call nvme_sync_queues in the last part of the teardown, but
I still don't understand the race here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
