Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570F2C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:34:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA7764F41
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA7764F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TmVgds2jEzWocMS9XwwaHBLW8hNHWZdETqooz/hCfbQ=; b=ybLjPUAco0xwdvOBazlfKdZfC
	ULqpl3hUGkr+QjfFG/IrtvqxoLzDua7xHb7ZsuHvqcvg+gutn2HWkuVpEQTtxUWPfojEo4no+KZeK
	GAvdz+B8OxsJ8mGiHkbirOSnNLNTTUgeeCyq2hcZe+G6VJZXGFYSmQwK4vC06jlGjyg8fjzumeJO1
	BURJRegj0U1QefpD0B6mjWyvxQSxitpV9EORu4kUPMWrOnTZu42V4XWab2KsUEezeAABjz2smqKjT
	prL43SPRAwQ7aq3UU81NYuZQpCd7Ne/uR9+y/hurj7TTHJTv8p7M6JHqNuph03xmXE7gus+tFeYth
	cNfye48gQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7Z9o-0007Ft-9R; Thu, 04 Feb 2021 07:34:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Z9l-0007FX-Bh
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:34:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9E2E9AD18;
 Thu,  4 Feb 2021 07:34:23 +0000 (UTC)
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
To: Martin Wilck <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
 <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
 <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
 <b4b9a52011d17ef16cbc86d81ef3d19f7a517d93.camel@suse.com>
 <c127bde8-7cae-677c-4b8d-44cf757d05eb@grimberg.me>
 <2394e23e80f2bdcf0a95eb39e5eefcb00237d52f.camel@suse.com>
 <8cb1830e-b7f3-48ef-1190-0d917aa200bb@grimberg.me>
 <5623aeee6a57889123b8a3441ee6df7b97f76451.camel@suse.com>
 <552cb65a-8f1b-e414-4de8-f53ff469e8a1@grimberg.me>
 <c00de29ef02bf39ae231a2816f03c8e920ebdc29.camel@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <864dd77a-650f-9260-9d9d-02ab83b4a18d@suse.de>
Date: Thu, 4 Feb 2021 08:34:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <c00de29ef02bf39ae231a2816f03c8e920ebdc29.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_023425_649625_B1DF1BE7 
X-CRM114-Status: GOOD (  24.20  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/29/21 10:15 PM, Martin Wilck wrote:
> On Fri, 2021-01-29 at 13:11 -0800, Sagi Grimberg wrote:
>>
>>>>> If it does, it will recreate discovery controllers for every
>>>>> host_traddr/traddr/trsvcid tuple it finds. "--keep" semantics
>>>>> are
>>>>> only
>>>>> necessary for addresses on which no regular (non-discovery)
>>>>> connection
>>>>> exists.
>>>>
>>>> Wait, Maybe I'm missing something here, but are you saying that
>>>> for
>>>> every traddr/trsvcid it finds (both nvm and discovery) it will
>>>> attempt
>>>> to connect a discovery controller?
>>>>
>>>> If so, this is absolutely wrong.
>>>
>>> Currently, it tries to do that on startup, if (and only if) the
>>> --startup option is given. My expectation was that the connection
>>> attempts would simply fail if there was no discovery subsystem to
>>> connect to. Anyway, it's not the default behavior, and can be
>>> dropped
>>> completely if it's so bad that we shouldn't ever attempt to do it.
>>
>> IMO it needs to be dropped. I didn't understand this at first because
>> it never even occurred to me that such an assumption can be even
>> made.
>>
>>> If the service is started early on during boot, and event-based
>>> discovery works (i.e. we also have the mDNS part in place), this
>>> won't
>>> be necessary of course.
>>
>> This isn't necessary regardless. At best the discovery controller
>> endpoints should be obtained from discovery.conf or equivalent.
> =

> Understood.
> =

>> I don't even see how does this help in early boot anyways, how
>> do the existing controllers get connected?
> =

> For FC, it works today. You can start the monitor in the initrd, it
> will receive the fc_udev_device events, and autoconnect (just like
> traditional udev/systemd based discovery). For other transports, it'd
> be more work, as we'd need to do mDNS discovery from an initrd
> environment. I wouldn't say it's impossible though.
> =

mDNS isn't related to the initrd, mDNS is for discovery discovery :-)
For everything _but_ FC we have the problem that we don't know where to =

connect to for the initial discovery (ie we don't have a list of =

potential discovery controllers).
Currently we either have to specify the parameters manually, or add them =

to /etc/nvme/discovery.conf.
Which isn't _that_ dynamic.
mDNS will provide a way of promoting changes in any remote discovery =

controllers to the potential hosts, allowing the host to pick up =

information about potential discovery controllers from there.

So the monitor code would need to interact with mDNS to get the =

information, and should use that to establish discovery connections.

As this information is transient I would not tear down discovery =

controller connections on exit, but rather keep them alive.
That way a controller restart could pick up these existing connections =

and would not need to recreate them (which will be tricky as the monitor =

code doesn't have the information which connections to restart).

The alternative would be a callout to mDNS to get the current topology, =

but that doesn't exist yet.

Cheers,

Hannes
-- =

Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
HRB 36809 (AG N=FCrnberg), Gesch=E4ftsf=FChrer: Felix Imend=F6rffer

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
