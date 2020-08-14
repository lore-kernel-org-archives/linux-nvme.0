Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB4C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:09:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D198A20708
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 07:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1CN4D42x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D198A20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5r3YrHqc1gZD6ZptCp5yPpKwhWLovpbP/DYQDsFkKYo=; b=1CN4D42x2ntSPvkfxIxRRKnBs
	kKSKawwQKqOINlUJWsCja452ZHbr6kt4SSwDndYTKe7WVTviDmf4d/FrzmvlrU0IYTAqq1gEYf/e/
	Kp5IrPSDgzbkmiPkqrpZo2TDSzLkSYGU+TmuxDa9PbtwYpmU4FB5oY8qPWrPLNkPZvv89ovsnSkYL
	th83LloQIvTo7Io0LtJMo6k2VKC39AnyQ4y/zKMAxwLHLaMgQILQMBQ7AkrmLr8jAA7gM1WhEB6we
	ovQIV+hEao4zRgVnpoxuiaBihzlS/JhcddwdwJY+Mjl+TXEtE79f+ewyejXZVkkiRl9v78A4kkC5j
	10cwHfAow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Tpn-0008FH-7E; Fri, 14 Aug 2020 07:09:03 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Tpk-0008Ei-9U
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 07:09:01 +0000
Received: by mail-wr1-f43.google.com with SMTP id c15so7392987wrs.11
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 00:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DU2tP6TQjH8NXO0G08Q4kJ6+Yx5CZ67qVQtye6UNLpg=;
 b=IljCE1MRPPLxuPynb1nrLNBetk/MENnWSNzKq7Y8rUZvKJc3SQ/lZGuBwimS7mmvAG
 gmqn4W4G4Z2hilJ3RsITVJaYBjCxKRq9nYbRspnyjberaSCyaDaw/gnbo/2mjzHnfqE8
 dk5vZ+R2S3dE9v3beI5iktgSfMvXxWNp66e7sQ+n8dL2j8HhTaXEgCvE1o+W/gbmR3J9
 aQXicEKSUdZCSw/qQzByDD/XMM1aPms/mA5M56fpSv35/qyTAjPRD2VQQHZpoRHmcjNC
 wXj9b/4U6vXgemxXj/GYOr7dEm0edcBabQUhIQDHFUtbrG7uNC1t75p2mBaNBbshGshy
 p4fg==
X-Gm-Message-State: AOAM533XVGzytSI8Kzcgp47yeoiOuVpgoKCaglGyQR4Ae54yK6PG9xO6
 1vV5HcwoWC3nbZscIbEdp98=
X-Google-Smtp-Source: ABdhPJx64sTtkcCnqd/t9zYl6gBA1Lo1oYKupVzqkcGumt6UKq46qKo8iMMK5xwxBxzQYZkqb8MJyw==
X-Received: by 2002:a5d:514c:: with SMTP id u12mr1495256wrt.90.1597388938705; 
 Fri, 14 Aug 2020 00:08:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f?
 ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id w132sm14069781wma.32.2020.08.14.00.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 00:08:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-2-sagi@grimberg.me> <20200814064414.GA1719@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <27f60468-269a-34d8-9e51-920106c3a139@grimberg.me>
Date: Fri, 14 Aug 2020 00:08:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814064414.GA1719@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_030900_385368_33F49804 
X-CRM114-Status: GOOD (  22.78  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Right now we are failing requests based on the controller
>> state (which is checked inline in nvmf_check_ready) however
>> we should definitely accept requests if the queue is live.
>>
>> When entering controller reset, we transition the controller
>> into NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for
>> non-mpath requests (have blk_noretry_request set).
>>
>> This is also the case for NVME_REQ_USER for the wrong reason.
>> There shouldn't be any reason for us to reject this I/O in a
>> controller reset. We do want to prevent passthru commands on
>> the admin queue because we need the controller to fully initialize
>> first before we let user passthru admin commands to be issued.
>>
>> In a non-mpath setup, this means that the requests will simply
>> be requeued over and over forever not allowing the q_usage_counter
>> to drop its final reference, causing controller reset to hang
>> if running concurrently with heavy I/O.
> 
> Which will still happen with the admin queue user passthrough
> commands with this patch, so I don't think it actually solves anything,
> it just reduces the exposure a bit.

The original version of the patch removed that as well, but james
indicated that it's still needed because we have no way to make sure
the admin (re)connect will be the first request when we unquiesce.

So I kept that one around and will fix it later, and yes, this
is niche corner case compared to user I/O.

>> While we are at it, remove the redundant NVME_CTRL_NEW case, which
>> should never see any I/O as it must first transition to
>> NVME_CTRL_CONNECTING.
> 
> That probablyly should be a separate patch.

OK.

>> -		if (nvme_is_fabrics(req->cmd) &&
>> +		if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
> 
> And this (make sure we don't access garbage in ->cmd for non-passthrough)
> should probably be a separate fix as well.

No, the check was in the upper condition and this reference relied on
it so if I separate this part there is no justification for the
change.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
