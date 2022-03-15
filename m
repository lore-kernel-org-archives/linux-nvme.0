Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5831C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YrS80TM1wtKrfbtCcojFDQqGbJL4k9V5F+spAeaJ/po=; b=feWyCjdQVQAIuuuh3Xh6MZxoxe
	h9pIb/m3vkhlyAORhMj7C7fJ6QO4UaebAxjlgg2kZDWNBUDzs7J5x7V88jrZspcDQlfGLavh+6MPU
	T7J2RaZJcFnvrqmOxYvXbV0CY7BbMkvnpCmc5Ug2yp252KgzO/yrwjQwDUUevLCyKB3dzbXKDgBwY
	sYfez+LEWqhvU178fqoMsm4scSOnDSJIZ81R+BMzVDGh7fHnSpJOVsSCJNIQ4biYEFErV4Zvyq+/u
	SJuQgEA//jyAdQelbOuY8H7feWjmuqEr0c1ugJabiBvgGxvewVfVo/vPdUnj+j0EG/ezioaIvcw8C
	1pRpwMpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU4kQ-008mr0-43; Tue, 15 Mar 2022 10:49:50 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU4kM-008mof-PM
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 10:49:48 +0000
Received: by mail-wr1-f52.google.com with SMTP id r10so28327832wrp.3
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 03:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=YrS80TM1wtKrfbtCcojFDQqGbJL4k9V5F+spAeaJ/po=;
 b=ohtUh5rPwILTP++bHws/xXgKBJMBP265JXIWnOgyINzyfB4GX4NlxImeinPvFvZxxF
 jksh/U9nk4tGGQQrRzGBm4CfKNTvoZwemtYAzGpdX16F0lYOyaNpzZNd+zK1gh6JH+14
 /hB5xhQl4vAGMTnr6Dlzo5HLbKcOXQt1fDzFQWPE0p5a6n26i1LMfKDQl+xVcUFd+7pz
 xbTQQggB2kVhP4wkSoZ4mWLkIC/dlQf+hbtqb6Q6qpywmc3Vtm3oqNQetfIsAaF7C/70
 VOkbBxCOA21KF7RSveLV/GO/YOp4qmW716/k+R54hcWS9C0B1eIELJBe1h9wD8/Ldy0v
 qszA==
X-Gm-Message-State: AOAM5333ooPaRv7BG5YOYeOZg7qp5nifIyviX6bq1mgS55TbRbrag9RT
 miuyj0EufVrCdGWe5+wEDW8=
X-Google-Smtp-Source: ABdhPJzqGmRKpITUGNEhZR+2RCNST6cwQBK3WbQSynkIEBiSh7aUpLLfBlDI6epEL9BAMcsDUwT4gA==
X-Received: by 2002:adf:dcd0:0:b0:1f0:4b41:3953 with SMTP id
 x16-20020adfdcd0000000b001f04b413953mr19105288wrm.503.1647341385239; 
 Tue, 15 Mar 2022 03:49:45 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 m16-20020a05600c3b1000b00389e93b173dsm2060689wms.44.2022.03.15.03.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 03:49:44 -0700 (PDT)
Message-ID: <dae0fa76-2b78-16f9-a7fa-f28c1412c317@grimberg.me>
Date: Tue, 15 Mar 2022 12:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220314105333.56714-1-hare@suse.de>
 <20220314105333.56714-2-hare@suse.de> <20220315080602.GA3082@lst.de>
 <f2fb9eea-8c9c-cb95-5380-2a10b6ce3f46@grimberg.me>
 <ec115fe9-2b3f-8f31-d3b8-b85686c2788a@suse.de> <20220315094950.GA5322@lst.de>
 <b2942a7f-0d23-46e3-5ab1-31cad3ee8011@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b2942a7f-0d23-46e3-5ab1-31cad3ee8011@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_034946_853565_81F70792 
X-CRM114-Status: GOOD (  30.51  )
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


>>> The core question really is: do we _want_ to expose the discovery 
>>> subsystem
>>> in configfs?
>>
>> Well, if you want a freely configurable one we kinda have to, right?
>>
>>> Unfortunately, exposing the discovery subsystem and trying to 
>>> configure it
>>> with configfs does _not_ match with the way discovery is implemented 
>>> today.
>>> While we currently only have a single discovery subsystem, it will only
>>> ever return the subsystems visible from this particular port.
>>
>> Well.  The original Fabrics spec had this concept of that magic discovery
>> NQN, which implies that there is one subsystem (or many pretending to be
>> one).  And that is what the implementation followed.  The varipus 80?? 
>> TPs
>> then made a complete mess off that.
>>
>>> Hence this rather simple approach, having the 'normal' discovery 
>>> subsystem
>>> exposed, and let the admin configure it accordingly.
>>>
>>> I can look at keeping the internal implementation, and only expose 
>>> unique
>>> discovery controller (ie those with a unique subsystem NQN).
>>> That would remove the need to having the 'discovery_nqn' attribute, and
>>> address Christophs concerns.
>>
>> I suspect if we want to support all the new mess from the FMDS group
>> (and maybe we need to question the why a little more), then we should
>> so something like:
>>
>>   (1) keep the existing global NQN-based discovery as-is.
>>   (2) maybe add a per-port known to allow disabling it if people 
>> really care
>>   (3) allow creating additional discovery subsystems with non-default
>>       NQNs that do not automatically get anything added to them and will
>>       just be configured as needed through configfs
>>
> Yeah, that's the line I'm following.
> 
>> But maybe first we should take a step back and figure out what supporting
>> TPAR8013 even buys us?
> 
> Properly supporting persistent discovery controllers.
> 
> The current problem we're having (on linux) is that we cannot identify 
> discovery controllers. Each discovery controller has the same subsystem 
> NQN, and hence that's not sufficient to identify the subsystem
> Which resulted in linux to always create a new 'nvme_subsystem' instance 
> when creating a new nvme discover controller.

That is the case regardless of naming... there is no multipathing with
discovery subsystems so there will be a subsystem for every discovery
controller...

> Problem now starts when you try to use persistent discovery controllers; 
> it's quite easy to _create_ a persistent discovery controller, but less 
> easy to _use_ an existing one; how would you know which one to pick?

You are not supposed to "use" an existing one, the whole point of the
persistent discovery controllers is that you don't need to worry about
it. We already perfectly handle that with udev using the kernel of
the uevent.

> More importantly, as linux will always create a new nvme_subsystem for 
> each discovery controller you'll end up with several 'nvme_subsystem' 
> instances which in fact all refer to the very same subsystem.

OK, still don't understand why that is a problem.

> nvme-cli tries to work around that problem by requiring the user to 
> specify the device name, but that requires quite some knowledge from the 
> admin side, and making that work in a scripted fashion is a pain.

I am not aware at all on what scripting are you referring to. But udev
scripts are written already. Can you explain?

> So with TPAR8013 we now _have_ distinct discovery subsystems, can create 
> unique subsystem, won't have duplicate subsystems, and can automate 
> nvme-cli to pick the correct existing persistent discovery controller 
> even if the user does _not_ specify the device name.

And instead specify the subsysnqn? I am not aware of this reasoning you
are referring to at all, but I was probably absent from these
discussions... I thought that this TP was solely related to 8010 stuff
and also solves an issue that came up with the discovery subsystem and
the authentication TPs.

