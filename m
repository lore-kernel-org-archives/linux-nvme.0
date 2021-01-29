Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F776C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:08:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAFF264E04
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAFF264E04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yZ3wwQMM/+xqfdhga798we5H7D8dBwN3so0vwvOCgrA=; b=sUNSYNUShLoMCD7RV01hsZx73
	jMrk9Z4JC+UA3GafogWv9bBUOTvzly/NuuVq/YETIAiPGtOlNFqlFI7PXYqdi1KakTMXHo280EcoD
	GylCnIGkxjNu2Sv3gQANxVeGpD1ssX4MKKGSNkxFDter9X/3IobYMGs4zlA9Oj/dPgAAK329tqxTP
	t5FFwgsKdxZIIDZ8DtsedmZLPLkusDYm17BzTsmJD+W1HsdGIS5squE9gTkZJVcyjycm9clzrGkgn
	QtGO2N2EWUrAEP4yJ0oHIKIgr4mGfeWJ0eDXYCWxOROelB3ixdYnxW9Wk/ESYKxbTjRDOZIgtamK+
	r2MzXvLig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5a3y-00074P-Ib; Fri, 29 Jan 2021 20:08:14 +0000
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5a3v-000742-VD
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 20:08:12 +0000
Received: by mail-pf1-f174.google.com with SMTP id m6so6921912pfk.1
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 12:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6NMabYib4iWnCph0KB5MlXVyYMqHdtFKzmhhwfniiyw=;
 b=EsNDHBGeKSOdwf21Quw+4XKbyGk2UV14NuoDfjCzWpdaieOSe36/hetAQLLXAYIS5E
 UZOnE9tyWhVs6ihaz7YHJ+qyYidsiKcVDFS1fFFHUx0fQYZZGNRomN9yi7V2bxloX+LU
 RGBI/JfIwve3kHAqh3rlKCjWzedrvcyJKh14FfVYNCoa9SdwC3CMJk62A4C6SQ+t8QJA
 N2LHuOgLlIC3Lwk8tpKHlVOSvlXIRcbahJ0Fm2w5gi4JkpnRHUU8B9kHBYHlRnZKqFKB
 Q3v8Lef6Pa6YOLX8lT/RABrxEcnuUErp/qfRxjVDwEb6HessuHDIUvniVnodfcMmbiAM
 SJjA==
X-Gm-Message-State: AOAM533nPnMxXdPPaSkHpEit6Jk/1OgiBld5/FHF0uyWULeRFFVu8+2H
 8qZ8oVgKDY1FdBoGtbRhiYo=
X-Google-Smtp-Source: ABdhPJzc6BVjQ3rSdHf64zr71vvwzze7r5KOmuKXC2wqBi9jzat4nI++rHYPJCqMFpy+GwKMpaNybQ==
X-Received: by 2002:a63:d42:: with SMTP id 2mr6651231pgn.236.1611950890528;
 Fri, 29 Jan 2021 12:08:10 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id h23sm9815190pgh.64.2021.01.29.12.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 12:08:09 -0800 (PST)
Subject: Re: [PATCH 00/35] RFC: add "nvme monitor" subcommand
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <60846bb5-c0df-ac23-260b-b53afd48f661@grimberg.me>
 <d8956cf973867ad7cc6c4d968682ec3db3054aa3.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d8e35845-31d3-a46d-b464-728d751d0b33@grimberg.me>
Date: Fri, 29 Jan 2021 12:08:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8956cf973867ad7cc6c4d968682ec3db3054aa3.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_150812_102753_DEE01089 
X-CRM114-Status: GOOD (  42.59  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>
>>> This method for discovery and autodetection has some advantages
>>> over the
>>> current udev-rule based approach:
>>>
>>>  =A0 * By using the `--persistent` option, users can easily control
>>> whether
>>>  =A0=A0=A0 persistent discovery controllers for discovered transport
>>> addresses should
>>>  =A0=A0=A0 be created and monitored for AEN events. **nvme monitor**
>>> watches known
>>>  =A0=A0=A0 transport addresses, creates discovery controllers as requir=
ed,
>>> and re-uses
>>>  =A0=A0=A0 existing ones if possible.
>>
>> What does that mean?
> =

> In general, if the monitor detects a new host_traddr/traddr/trsvcid
> tuple, it runs a discovery on it, and keeps the discovery controller
> open if=A0--persistent was given. On startup, it scans existing
> controllers, and if it finds already existing discovery controllers,
> re-uses them. These will not be shut down when the monitor exits.

And if it doesn't run with --persistent it deletes them? even if these
weren't created by it?

And, if none exist where does it get new discovery controller details?
Today we use discovery.conf for that.

> This allows users fine-grained control about what discovery controllers
> to operate persistently. Users who want all discovery controllers to be
> persistent just use --persistent. Others can set up those that they
> want to have (manually or with a script), and not use --persistent.
> =

> The background is that hosts may not need every detected discovery
> controller to be persistent. In multipath scenarios, you may see more
> discovery subsystems than anything else, and not everyone likes that.
> That's a generic issue and unrelated to the monitor, but running the
> monitor with --persistent creates discovery controllers that would
> otherwise not be visible.
> =

> Hope this clarifies it.

Well, How do people expect to know if stuff change without a persistent
discovery controller? Not sure if people may see more discovery
controllers this is a real issue given what they are getting from it.

But OK.

>>>  =A0 * In certain situations, the systemd-based approach may miss
>>> events due to
>>>  =A0=A0=A0 race conditions. This can happen e.g. if an FC remote port is
>>> detected, but
>>>  =A0=A0=A0 shortly after it's detection an FC relogin procedure is
>>> necessary e.g. due to
>>>  =A0=A0=A0 an RSCN. In this case, an `fc_udev_device` uevent will be
>>> received on the
>>>  =A0=A0=A0 first detection and handled by an `nvme connect-all` command
>>> run from
>>>  =A0=A0=A0 `nvmf-connect@.service`. The connection attempt to the rport=
 in
>>> question will
>>>  =A0=A0=A0 fail with "no such device" because of the simultaneous FC
>>>  =A0=A0=A0 relogin. `nvmf-connect@.service` may not terminate immediate=
ly,
>>> because it
>>>  =A0=A0=A0 attempts to establish other connections listed in the Discov=
ery
>>> Log page it
>>>  =A0=A0=A0 retrieved. When the FC relogin eventually finishes, a new
>>> uevent will be
>>>  =A0=A0=A0 received, and `nvmf-connect@` will be started again, but *th=
is
>>> has no effect*
>>>  =A0=A0=A0 if the previous `nvmf-connect@` service hasn't finished yet.
>>> This is the
>>>  =A0=A0=A0 general semantics of systemd services, no easy workaround
>>> exists.=A0 **nvme
>>>  =A0=A0=A0 monitor** doesn't suffer from this problem. If it sees an
>>> uevent for a
>>>  =A0=A0=A0 transport address for which a discovery is already running, =
it
>>> will queue the
>>>  =A0=A0=A0 handling of this event up and restart the discovery after it=
's
>>> finished.
>>
>> While I understand the issue, this reason alone is an overkill for
>> doing
>> this.
> =

> I agree. But it's not easy to fix the issue otherwise. In the customer
> problem where we observed it, I worked around it by adding the udev
> seqnum to the "instance name" of the systemd service, thus allowing
> several "nvme connect-all" processes to run for the same transport
> address simultaneously. But I don't think that would scale well;
> the monitor can handle it more cleanly.

Still changing the entire thing for a corner case...

> =

>>>  =A0 * Resource consumption for handling uevents is lower. Instead of
>>> running an
>>>  =A0=A0=A0 udev worker, executing the rules, executing `systemctl start`
>>> from the
>>>  =A0=A0=A0 worker, starting a systemd service, and starting a separate
>>> **nvme-cli**
>>>  =A0=A0=A0 instance, only a single `fork()` operation is necessary. Of
>>> course, on the
>>>  =A0=A0=A0 back side, the monitor itself consumes resources while it's
>>> running and
>>>  =A0=A0=A0 waiting for events. On my system with 8 persistent discovery
>>> controllers,
>>>  =A0=A0=A0 its RSS is ~3MB. CPU consumption is zero as long as no events
>>> occur.
>>
>> What is the baseline with what we have today?
> =

> A meaningful comparsion is difficult and should be done when the
> monitor functionality is finalized. I made this statement only to
> provide a rough idea of the resource usage, not more.

You mention that the utilization is lower than what we do today, hence
my question is by how much?

>>>  =A0 * **nvme monitor** could be easily extended to handle events for
>>> non-FC
>>>  =A0=A0=A0 transports.
>>
>> Which events?
> =

> Network discovery, mDNS or the like. I haven't digged into the details
> yet.

Yes, that is possible, would probably be easier to do this in a higher
level language but libavahi can also do this...

>>> I've tested `fc_udev_device` handling for NVMeoFC with an Ontap
>>> target, and
>>> AEN handling for RDMA using a Linux **nvmet** target.
>>>
>>> ### Implementation notes
>>>
>>> I've tried to change the exisiting **nvme-cli** code as little as
>>> possible
>>> while reusing the code from `fabrics.c`. The majority of changes in
>>> the
>>> existing code exports formerly static functions and variables, so
>>> that they
>>> are usable from the monitor code.
>>
>> General comment, can you please separate out fixes/cleanups that are
>> not
>> related to the goal of this patchset?
> =

> Which ones are you referring to? 09 and 19? While these are minor
> improvements to the existing code, I wouldn't say they qualify as fixes
> or cleanups. They aren't necessary without adding the monitor code.

Patches that are not directly related to the goal of this should
be splitted out to ease the review.

> But yes, I can post all changes to existing code separately.
> =

>>>  =A0 *=A0 When "add" uevents for nvme controller devices are received,
>>> the
>>>  =A0=A0=A0=A0 controller is consistently not in `live` state yet, and
>>> attempting to read
>>>  =A0=A0=A0=A0 the `subsysnqn` sysfs attribute returns `(efault)`. While=
 this
>>> should
>>>  =A0=A0=A0=A0 arguably be fixed in the kernel, it could be worked aroun=
d in
>>> user space
>>>  =A0=A0=A0=A0 by using timers or polling the `state` sysfs attribute for
>>> changes.
>>
>> This is a bug, what in the code causes this? nothing in controller
>> state
>> should prevent from this sysfs read from executing correctly...
> =

> I think it can be fixed by making nvme_sysfs_show_subsysnqn() fall back
> to ctrl->opts->subsysnqn if ctrl->subsys is NULL.
> =

> I'll send a patch. Anyway, it'll take time until this is fixed
> everywhere.

Thanks.

> =

>>
>>>  =A0 * Parse and handle `discovery.conf` on startup.
>>
>> This is a must I think, where do you get the known transport
>> addresses
>> on startup today?
> =

> There's a systemd service that runs "nvme connect-all" once during
> boot. That exists today. I'm not sure if it should be integrated in the
> monitor, perhaps it's good to keep these separate. People who don't
> need the monitor can still run the existing service only, whereas for
> others, the two would play together just fine.

Then doesn't this service need to run after it?

>>>  =A0 * Implement support for RDMA and TCP protocols.
>>
>> What is needed for supporting them? Not sure I follow (I thought
>> you mentioned that you tested against linux nvmet-rdma?)
>>
> =

> AENs over existing discovery controllers are supported for all
> transports. But there's no support for discovery of new transports
> except for NVMeoFC's "fc_udev_device" mechanism.

I see. thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
