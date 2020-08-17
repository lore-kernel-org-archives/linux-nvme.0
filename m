Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65864C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 19:30:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3901B2065D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 19:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bLT4hIBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3901B2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/4UDnOLXLOUjjPA7+T519jPhBLdKeKzBLnCXLpsCeks=; b=bLT4hIBpHFcP7C+8MKAku+mip
	DztouDr0PhYXHV6h7orLlD5R06Oyxg753jpgghCQ5evIvqUNtcKUWYaFhs1APK/DLrWfcPQQQ5SUc
	3wDazJ3bwK1xDPIylqpKQOuolj6kSq3SSb1qEPdcaRENeI2JeI2Avv9MikzOFa+GX1hjeM0s0tS0j
	wDdmRlbfkpY5QBd7t2lGk+KO6KxjJ3ItzcAtwgNvM1dgNIaT4/BKwK/UMivgJPM56kxzBkoDtmprs
	wiYKjhoCks24rjSPaebH8Lv1coLs0owMRnQ0Cl/RjIUy1YPilrubJvCjClq7vfCOblj5Q9iSpFsX/
	AgjGijyTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7kpU-0007Q0-F0; Mon, 17 Aug 2020 19:30:00 +0000
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7kpP-0007NT-2g
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 19:29:57 +0000
Received: by mail-pl1-f170.google.com with SMTP id u10so8033502plr.7
 for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2020 12:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kGwmZoIoxhcu6Ji0shiOXdFIKt00yBKtFuMVdoKdm7E=;
 b=K9/d4q9MND8hWcSGcjFtztdWfuSl+G3456+j3qtUT8yCZTzJ2QrKDKfg7mrOsbCWsN
 MQa0gVGB1Aal5NXjx7p2hrSHG9oy96Apdz39fo66Qcx2tP+DO14flLOBPQdB2EAesluW
 qr4y0Hxvr9DcZHW+EyJ0HoPy88tliJQMvU3U6+SaxtJ4V7V4zcuYztH7dqRrogSs763s
 NHGhT+IocfDgGyqsi89ui78Alp5WsDAKYpnROF8URew9Tyk2p5mtnuxiTwPqBmHw3IC4
 sZCrqjDe1VVGy9uR/d0RE4xp2rDLZRqqJJs4ASLlzZ9JJXHcNPpjEJUbJZ2tprf+XvtV
 KFVQ==
X-Gm-Message-State: AOAM5317WDoqVD6loIv63TD/poUH6JfSWBlTyhOUdGSlnUOHakeHacyZ
 bgRNg48ZK7lsuEvRAojTHio=
X-Google-Smtp-Source: ABdhPJx28ncasQdlp83Z/F7cGEV77eLDJ7LiZe+uLLsecEQUMFGoCMyKjyyHcIQ/i9G3M9eqy9Sd1A==
X-Received: by 2002:a17:902:221:: with SMTP id
 30mr12728544plc.222.1597692593637; 
 Mon, 17 Aug 2020 12:29:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c8a:c3fd:4152:60d0?
 ([2601:647:4802:9070:c8a:c3fd:4152:60d0])
 by smtp.gmail.com with ESMTPSA id go12sm18239043pjb.2.2020.08.17.12.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 12:29:52 -0700 (PDT)
Subject: Re: nvme reservation commands during controller reset
To: Christoph Hellwig <hch@infradead.org>
References: <20200809161016.GA63121@C02WT3WMHTD6>
 <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org> <20200814100911.GA9975@infradead.org>
 <83dbae6f-01a0-a9a4-9271-de8c1cf06c66@grimberg.me>
 <20200815070134.GB20460@infradead.org>
 <e312ae98-5b40-d0ee-c13e-b65db1f3acd7@grimberg.me>
 <20200817081227.GA12680@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <29359e09-f386-8004-7369-c8fc055e2c38@grimberg.me>
Date: Mon, 17 Aug 2020 12:29:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817081227.GA12680@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_152955_571206_C2B4F866 
X-CRM114-Status: GOOD (  23.90  )
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
Cc: Keith Busch <kbusch@kernel.org>, "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@dell.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>>> Amit,
>>>>>
>>>>> can you try the branch below?  Pretty much hot off the press, but I
>>>>> think this should address your problem:
>>>>>
>>>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-pr-fix
>>>>
>>>> I like the approach, but I think we'll need a bit more path awareness
>>>> like we check for available paths if we requeue or fail..
>>>
>>> If there is no available path, nvme_find_path will fail and thus we'll
>>> error it.  This is the same mechanism as used by
>>> nvme_ns_head_submit_bio.
>>
>> nvme_find_path will return ns=NULL even if none of the paths is LIVE,
>> but we want to requeue if we have an available path (e.g. ANA state is
>> inaccessible temporarily or ctrl state is RESETTING/CONNECTING).
> 
> nvme_find_path will return a namespace if there is a namespace with
> an optimized or non-optimized state, and which does not have the
> NVME_NS_ANA_PENDING or NVME_NS_REMOVING flags set on a controller that is
> in the live or deleting states.
> 
> And that is exactly what nvme_ns_head_submit_bio relies on.

Agree.

>> Only if no path is available for request execution we are failing the
>> request.
>>
>> If we are providing multipathing for reservations, we should give
>> the same efforts as we do for normal I/O. This could mean waiting
>> for some indication on the ns path states (wait for a completion in
>> nvme_submit_sync_cmd_disk and wake it up in nvme_mpath_set_live).
> 
> The only difference in nvme_ns_head_submit_bio is that the bio is
> queued up if the controller is in a suitable state.

These are details, let's first discuss the semantics we should be
providing.

   But that isn't
> something we can implement for the passthrough path as we don't have
> an inidividual bio that we can queue up.  Note that not other retries
> are handled by the pr path either, so there is the need for some
> amount of retrying in the caller anyway.

So what is the semantics we want to provide? a best-effort one? not very
different than what we have today. We could, if we choose to, have the
pr context to wait for a path_map_changed completion and have
nvme_mpath_set_live and nvme_mpath_check_last_path do complete_all on
this completion.

But the question is what the semantics we want to provide...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
