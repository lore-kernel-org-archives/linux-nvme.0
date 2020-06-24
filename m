Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A08AC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 20:07:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA1212081A
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 20:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gpQm4AiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1212081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aCT94FKFhIaLpbe6+ndnWcaX2ffITbJTOjD8wPHR5SI=; b=gpQm4AiHLMFytGcv4hMy45VcB
	YrlzCTVyBsXjXx0YEulrhkmVYB6Q/GvJrK+PzV3AoswGnwTFqIFzc9wi0adTVJbqLMGDg2dvV2T0Z
	sQ7pRUPL2UWxNH9NmesWLkWHQ0x4hJmiYsp9TJaP6z3D7lFqzqbGOwDghdtmE37SsrfWOQeaeC3j4
	N3GHo6YHuOX4AkAZPg8FuB7loL0/RYmVnFnKgHeuGRC7nMeA00MjArQUgzZ5lqUKTSVd9+Ry1wkdW
	jnRyfhehXFBEhoEmKmtYi2nUFQORJJJ8Mx9KzJL6p0abE1VE1WJNCmHyvFHuXi3Uvziv/0y7QOWns
	tXoMEnFcw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joBfk-0007qn-8z; Wed, 24 Jun 2020 20:07:04 +0000
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joBfe-0007nV-Fh
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 20:06:59 +0000
Received: by mail-pg1-f170.google.com with SMTP id f3so1967365pgr.2
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 13:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QBrh2Y8qB2rjjdDv5606BgnucmDDyh6bme2qSdCdVJU=;
 b=HMiOPlwWlcVbsSbKQyGvum2FHA1pVORcWHzNCjHM+qx34iwcFtakBajUjV68SmxkGg
 L7EKpKYucTsnkTGGG1G0fEr1PU3IZ9jI8DxAF0kxg4QBBfkS5+THfyFoKCtmDZTQzwo/
 gtsS/DV6bQyA63BbYukDdcBgOk7pffeXEMIZePz5gd0VNJtrB3/r5vPRjMGZPuisF7N4
 64zj57v3GbYZDyIfulMFL35Bb4r3kpbuBlr3jgW6hCkvJO2u+jCg4dT3L1mTv5dpEWN/
 dI48xUL6VrqUTteat7LDdvSzArPD9kukXENnqa35pChxVyKMpAiNlEifRnlecsL+6e3O
 2GnA==
X-Gm-Message-State: AOAM5316CANPpQs3lDioXAhkQZ6+SGGQIed9vo9GHHEYLF0wLRWscaGO
 rSgHvUfhODoG8/Xy7puCoJE=
X-Google-Smtp-Source: ABdhPJziirVLKj9FvoGZYg6xd2stZq1cwNpDOc3uYyvxv3xfGD3xWGydSXo5ywsxF4SPD48CvqkssQ==
X-Received: by 2002:a63:1444:: with SMTP id 4mr22194583pgu.388.1593029216700; 
 Wed, 24 Jun 2020 13:06:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id y7sm6399979pjm.54.2020.06.24.13.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 13:06:55 -0700 (PDT)
Subject: Re: NVMe over Fabrics transport requirements support
To: Boris Pismenny <borisp@mellanox.com>, Alex Talker <alextalker@yandex.ru>, 
 linux-nvme@lists.infradead.org
References: <eaceb06a-79d3-2b97-c975-6f2f641e90c7@yandex.ru>
 <71232e85-054b-638a-c168-4829e97f917f@grimberg.me>
 <39e303bc-7d99-5202-dcb7-4d2f487760bc@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <75010fdd-36dd-2ac0-a658-4fc7070744f1@grimberg.me>
Date: Wed, 24 Jun 2020 13:06:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <39e303bc-7d99-5202-dcb7-4d2f487760bc@mellanox.com>
Content-Language: en-US
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
Cc: Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hey Alex,
>>
>>> Is it true that setting any value in addr_treq attribute of port in via
>>> configfs
>>>
>>> only affects displaying TREQ on discovery page and doesn't anyhow inflicts
>>>
>>> "whether connections shall be made over a fabric secure channel"?
>>>
>>>
>>> I can't find much about whether RDMA(RoCE in particular) is secure
>>>
>>> but for TCP TLS is must-do these days I think.
>>>
>>>
>>> Is this functionality planned to be implemented in near future?
>> There were some discussions around adding this. Currently there is
>> some infrastructure work that we need to do first to have a kernel
>> consumer utilize ktls (mostly revolves around the fact that both
>> ktls and nvme-tcp are socket consumers and implement sk upcalls).
>>
>> I'm CC'ing Boris and Or who were very much involved with the
>> ktls implementation in Linux, they can maybe provide some more
>> input.
> 
> I have some early-stage patches the enable NVMe-TLS on the host's
> receive side and on the target's transmit side. It requires
> some TLS infra work, but the real problem is the userspaece side,
> as the TLS handshake cannot be in the kernel. Consequently,
> nvme-tcp must be modified to use sockets provided by userspace,
> and I suspect that this may be controversial.

Yes... That part is going to be annoying as hell. It's unnatural
no matter how we tackle it...

Please do note that there is ongoing update technical proposal on the
NVMe TWG to update the spec to match TLS v1.3 (not sure if you are a
member or not).

> At the moment,
> I'm busy with other things, but I expect to post an RFC after
> I finish with my current project.

Great! Looking forward to seeing some patches for it!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
