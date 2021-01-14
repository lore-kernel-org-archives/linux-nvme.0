Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94E5C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:09:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F353F236F9
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 03:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F353F236F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A91+C/5HKhL7wais45lJefRRwgAGIoAMn3hyDH7qyNQ=; b=i5ZUEkdcEOOxIvaDVD/4RvupM
	nMpqM2afqYa5sE7SXd8QC5tnKVCQUZOOV0KxzqSmQ3ub6iKnEnsmdjP9ZWXDNdehz/kdmtbveh3FU
	s1ZNquY8tTW8n4eAzWb5ip5Xjl8ZvgfuHsOxc2/17ewJbzAegeiSyyZQ9hpoYNdn7aF4tnob75dvo
	YZrQJFfujeT6V9shESHlCTW2EEz0UQtJ40NPoDB6qIdFqW9eRDNJscUlaFnHa0Q+lpHrl/R/3tDam
	RmnxUPVc0uv2RFt1qCZZhw7nf1e8uhRMVCjAAX3gyN0VJ9tuvqtueASPJnYq8mXQHtzsroUv+99+N
	7JuwiLyfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzt0r-00028a-Da; Thu, 14 Jan 2021 03:09:29 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzt0o-00027f-2A
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 03:09:27 +0000
Received: by mail-wm1-f46.google.com with SMTP id r4so3394033wmh.5
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 19:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p2mEDzkeBHsduE+U5v9zxdrCO0/7j9A6S9AKCIuS1ZI=;
 b=dSEBSeO5winR5y5H8x3j5DoXP056lTRTdNSswEsOd09TUvRPrV+u6m/HKib3kesKRD
 8FL9FX2fCgGwI/yPv3shnWW/1lkpNYmGMgg4tMC/uQ7YZ+NNLh16V+ZRThpw0FkCfe9w
 dqs/PDRDxdFGiE1XK3s6HII2g9j8oau3naIfpMxcTyhrR0XExeSptDQxkas0JOrGymc9
 96urFKVjd0GqnhGn3B0b+M+PPFew7Gmn7UfxckKuCoNE1HtaJVkS7D4pY0aO75SPGDC0
 Xx4DihGCUJ/VTPKf6l/BqQX6aSk3BQ2dO5pfROmNWLtQe7Lc4dNkina0gCXgKdimWB8/
 2aLg==
X-Gm-Message-State: AOAM532dNUVhy1ISjt+pnZUZgS/aYRKcKkhO7E9aLiFrrd0hwQL9b1o0
 Z63mkbgYhpCBPX1BC4Adu8s=
X-Google-Smtp-Source: ABdhPJyLHULMfFtqgKJf0UUjRbOWkp3vUAhax4JhL0YWdX8hhOyRmr3tSpPLCeE3oDY8oiQ98/OAxw==
X-Received: by 2002:a1c:5406:: with SMTP id i6mr1753223wmb.137.1610593762479; 
 Wed, 13 Jan 2021 19:09:22 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id b7sm6528183wrv.47.2021.01.13.19.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 19:09:22 -0800 (PST)
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20201209155321.GA31729@redsun51.ssa.fujisawa.hgst.com>
 <b9c9e5f9-a447-2a2e-b687-304dd8f3d2b2@suse.de>
 <20201209161911.GA31836@redsun51.ssa.fujisawa.hgst.com>
 <66bad47c-0cd3-8461-3629-146778f15059@suse.de>
 <20201209173936.GA31971@redsun51.ssa.fujisawa.hgst.com>
 <20201209174718.GA19512@lst.de>
 <DM5PR0601MB3624722C4C00B5A7EDB7E6A0F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201209213437.GA3682670@dhcp-10-100-145-180.wdc.com>
 <20201210085111.GA15999@lst.de>
 <baa8c2e6-1376-1cad-4c84-1129bd80d4ca@suse.de>
 <20201210133418.GA3645@redsun51.ssa.fujisawa.hgst.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eb84db43-5e63-19b4-cdb9-53f52d1c45e8@grimberg.me>
Date: Wed, 13 Jan 2021 19:09:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210133418.GA3645@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_220926_170786_EFF32C73 
X-CRM114-Status: GOOD (  28.17  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Knight, Frederick" <Frederick.Knight@netapp.com>,
 "Meneghini, John" <John.Meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey all,

Joining late to the discussion, ramping up on an old old backlog...

>>> On Wed, Dec 09, 2020 at 01:34:37PM -0800, Keith Busch wrote:
>>>> Linux hosts currently want an ANA AEN anytime the host needs to refresh
>>>> the ANA log. That includes any condition that adds groups that didn't
>>>> exist from the host's previous reading.
>>>>
>>>> If the Namespace Attach occurs to an ANA group the host already knows
>>>> about, then you don't need to send an ANA AEN because there's nothing
>>>> new in the log that the host requires. You just need to send the NS
>>>> Notify AEN.
>>>>
>>>> But if a side effect of attaching a namespace results in a new ANA group
>>>> becoming visible to the host, then that group creation is considered a
>>>> separate event, so the host wants both AENs. I believe this is where
>>>> Christoph is trying to steer the interpretation and the text.
>>>
>>> Exactly.  Although as Hannes pointed out, this language:
>>>
>>>     If, for an ANA Group, there are no namespaces attached to the
>>>     controller processing the command, then no ANA Group Descriptor is
>>>     returned for that ANA Group (i.e., an ANA Group Descriptor is returned
>>>     only if that ANA Group contains namespaces that are attached to the
>>>     controller processing the command.
>>>
>>> creates a bit of a chicken an egg problem in that case of a newly
>>> attached namespace that is the first one referencing an ANA group.

FWIW, the subsystems I'm familiar with are sending both events in this
case and the interpretation of this paragraph was that although the ANA
group existed since day-0, the host was never informed about it, so
just like lots of other internal resources, it doesn't exist from an
interface perspective.

The alternative would have been to tell the host about every ANA group
that the subsystem is managing, which could be a very large number and
just creates a churn of completely useless huge log pages.

>> Yes, this was what I tried to outline.
>>
>> Personally I don't mind whether the controller is required to send an ANA
>> change AEN together with the NS change AEN.
>> Requiring both will pose an ordering issue (as on fabrics we can't control
>> the completion ordering), so effectively we'll have to implement handling
>> for AENs arriving in any order.
> 
> I was thinking more about this, and it's actually not a problem based on
> how the controller is allowed to send AEN completions:
> 
>    When the controller posts a completion queue entry for an outstanding
>    Asynchronous Event Request command and thus reports an asynchronous
>    event, subsequent events of that event type are automatically masked by
>    the controller until the host clears that event.
> 
> These are both "Notice" event types, so the controller is not allowed to
> send both at the same time. The host must acknowledge the first before
> the second can be seen, so we can enforce a deterministic sequence.

Well that is easy today because there is only one aen at a time...

> And while it may make sense if the first event seen is the ANA one
> before the NS, it doesn't look like Linux cares if we observe them the
> other way around. The only thing the driver needs to do is synchronize
> the work queues for each event.

Yes, the order doesn't matter and we should keep it that way...

>> But I'm also fine with just getting one AEN; the patch will solve that
>> situation just fine.
> 
> I'm also okay with that patch, too.

I would actually be in favor of this patch, would be nice to skip
sending duplicate events for this.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
