Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC96BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 10:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdJ9rXptHgqQbQDPvE0LNwtFejsMK5+hUEwJx9reVnw=; b=sx0q8MoWxnhK0KjeSk2nUrYdl2
	W72P/Vo4nlz+2xTmGh4MnAtlwONA55mAYuNrCeCk5QcMzriWQ1yw8EkHFaAS5q5qDkwxbO/IK0ers
	YG9KTJ6Pz4LJElUASFolau6f+KHBAfnbqNtVF5+XpQOei87AYX46Okoz70FbADS+v/sJWJrXallbd
	I7wGtRXp2rfMRz2FQ2/LxRVQSPXL98n6xe/U82qMk5+LUqIjNWazcd4KYCJXZ3BgMoH7Ev26Qeug+
	qm+woZL8IqCRPm8uMrcys3P1uzApbNcGEjsqrttR4IlVF8eDp0c1RlQHOGdN40Yu++OjB/KszAIBa
	LhfDwiFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbgck-000gMc-C2; Tue, 05 Apr 2022 10:41:22 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbgci-000gL7-3P
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 10:41:21 +0000
Received: by mail-wr1-f48.google.com with SMTP id d29so12584270wra.10
 for <linux-nvme@lists.infradead.org>; Tue, 05 Apr 2022 03:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ZdJ9rXptHgqQbQDPvE0LNwtFejsMK5+hUEwJx9reVnw=;
 b=kRyGrBPpdf6vTcynk0NLJ1bxUrJLTw4gOuZtSupWDwM1tRNh3/APoPfTLbNAz6a/+a
 VeYmXGY3sETJIu0j8ahPM8bgpgO4nyjKnPLPdu4u7xYSqQ5t/660XY2o7nb7t/+4grfB
 f4X4lgRoyVW7uhOe2bXUJ7rqVMdVxB59hbLJnYaphAilLnRXmYsufrHP2kLtKt9q9yO8
 MXsYMoUIHmmWmT4fvBzIu1R0LQ9MEQ2csuii3DwWPgBQP4yWk3dnbKnlaG7CBsapfS3b
 vToIB77paPAdCiPIY7swRg2qYiFQQrOw0tLQZKqfiNpgNAkAn/XNJiP18JK/7WN5BMvP
 z3PA==
X-Gm-Message-State: AOAM5336Qq4Hkvwnclay6XBp8DjMkVn1Rz781n6y/CATPt9toXUOmOjC
 iINGLSasTEVD7dlFPGCjicg=
X-Google-Smtp-Source: ABdhPJymUaIusqqyUiqdLsVPzGTvjDyLff/0G1mnBZ3mUcxj02YMM7xCI+h/G8THR7OZSD84aWnupQ==
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id
 u13-20020adfdd4d000000b00203f178b78bmr2161434wrm.93.1649155275636; 
 Tue, 05 Apr 2022 03:41:15 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 v18-20020adfc5d2000000b0020589b76704sm12237658wrg.70.2022.04.05.03.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Apr 2022 03:41:15 -0700 (PDT)
Message-ID: <15910553-e0a6-3513-ae43-fc1cb634b1b0@grimberg.me>
Date: Tue, 5 Apr 2022 13:41:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery log
 page for unique discover controller
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
 <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
 <20220405061941.GA24290@lst.de>
 <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <366e9acd-23c8-f8bf-2671-9187f3c0ce96@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220405_034120_186393_70FE6659 
X-CRM114-Status: GOOD (  13.98  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> To make it configurable.
>>> Unique discovery controllers show up in configfs just like any other
>>> subsystems.
>>> And with that we need to clarify the relationship between the discovery
>>> subsystem and the other subsystems, ie which subsystems should be 
>>> presented
>>> by this discovery subsystem.
>>>
>>> Linking the discovery subsystem into a given port makes it obvious that
>>> a) this port will be presenting a discovery subsystem
>>> and
>>> b) that the discovery subsystem will be presenting all subsystems
>>> configured on that port.
>>>
>>> The built-in mechanism for discovery subsystems was okay as long as the
>>> discovery subsystem was built-in, too.
>>> But with this patchset we're moving to an explicit configuration.
>>
>> Shouldn't we just require anything to be manually listed for this
>> case similar to how we configure referrals for the well known
>> discovery controller?
> 
> Which is what I've tried with this attempt.
> I did _not_ want to create a new configuration mechanism, but rather use 
> the existing ones.
> And the existing mechanism we have is linking subsystems to ports.
> 
> If we want to treat discovery subsystems differently (as you proposed) 
> we sure can have a different mechanism on how to configure it.
> But I wasn't sure if that's the direction we want to go.

What is the concern here? that it will break existing users with
introducing an additional configuration step?

