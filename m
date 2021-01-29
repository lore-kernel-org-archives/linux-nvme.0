Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E15C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:14:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE2264DFB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:14:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE2264DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yr9BL3u3p5KthLbylfNfpi+j6+gNUjCcHo6pzQmSmjY=; b=eRwaTMV2JCG75gxqYyq5ekMUK
	v0t2bHyMAN2qHvubReurUpMQoh0FTDuPBj4BEjakFAF8BbnnI3BGiLQB7ZHwA7CpfZrzcqQSgkpIu
	bNtLRgFKi9mO3u2EePm7Rj1UrMzBVG6M2Bi1bp52vYGtA/6TJiAlgG/eY8MYdB5Hp+6vmroIyUa+q
	8Th/WOG6A97Uomf3pLS3yeWApMC7AU5+frUlxJbJoPVwOwW8tMxQyNYgGSiBGCt+pZUaw4nnsB1u7
	dJJUz+Qhoq5x3uClbSceB3h8xX4TQ75/iMdE4G/jXw0vpdRkNmvKRpMD8nRzQ35J3oJ16Ec6rdrS8
	dZ1C1/7mw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5IMt-0007yK-Mt; Fri, 29 Jan 2021 01:14:35 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5IMn-0007xf-AP
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:14:30 +0000
Received: by mail-wm1-f44.google.com with SMTP id e15so5959462wme.0
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 17:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dfZ8HChcs3bKhYiC9kTaiXpNGYoXxvaO00rvQ+aWaXI=;
 b=Rlhd4E+BndWZhhNT69zLvX1ebIG32skJIlhxizEihU4VjhpXgJhEkxzyMr3Gws70t2
 94+As7My4yukn7A8AEnKTP2zp4ODgwJ1CfxaBky+392V+Sq9rbpSbDUL38Wcdq2zhnj0
 m477yEh6BkYbvZpU8z9tG4hmKg3269WvpUU7ivmZ7BO6YnSsRFX57V056rPQIE8mUiWf
 sOUEC5Cf04Tya+4PPRV+F+F5quK9FJVuUpc1hCCmJCfbVs9KIUeslr9OyGyAI/akWI6i
 /jclUxKSYoYUFi3Z6rUCix+ITfTQCo090ItnxPkecMgB0EBdX6NVlfmehguRVdou58Ak
 ydyA==
X-Gm-Message-State: AOAM533Ij2U3wSgC0ECV72U3uijFE22Va2Tz+1uh+fh5mx61ulN3o9JZ
 LUAdxKXYVWrSt5OJvuast1g=
X-Google-Smtp-Source: ABdhPJwbXhCijkkZOR/igMv9ayOUcK905R2uRISbz4jwrGmUq/XO1Z5JgmcebZE2k5gyVnPWgZ5yLw==
X-Received: by 2002:a1c:9844:: with SMTP id a65mr1525907wme.113.1611882867789; 
 Thu, 28 Jan 2021 17:14:27 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id a27sm9321883wrc.94.2021.01.28.17.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 17:14:27 -0800 (PST)
Subject: Re: [PATCH 00/35] RFC: add "nvme monitor" subcommand
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <60846bb5-c0df-ac23-260b-b53afd48f661@grimberg.me>
Date: Thu, 28 Jan 2021 17:14:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_201429_428452_176B84BD 
X-CRM114-Status: GOOD (  37.61  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> From: Martin Wilck <mwilck@suse.com>
> 
> (Cover letter copied from https://github.com/linux-nvme/nvme-cli/pull/877)
> 
> This patch set adds a new subcommand **nvme monitor**. In this mode,
> **nvme-cli** runs continuously, monitors events (currently, uevents) relevant
> for discovery, and optionally autoconnects to newly discovered subsystems.
> 
> The monitor mode is suitable to be run in a systemd service. An appropriate
> unit file is provided. As such, **nvme monitor** can be used as an alternative
> to the current auto-connection mechanism based on udev rules and systemd
> template units. If `--autoconnect` is active, **nvme monitor** masks the
> respective udev rules in order to prevent simultaneous connection attempts
> from udev and itself.

I think that a monitor daemon is a good path forward.

> 
> This method for discovery and autodetection has some advantages over the
> current udev-rule based approach:
> 
>   * By using the `--persistent` option, users can easily control whether
>     persistent discovery controllers for discovered transport addresses should
>     be created and monitored for AEN events. **nvme monitor** watches known
>     transport addresses, creates discovery controllers as required, and re-uses
>     existing ones if possible.

What does that mean?

  It keeps track of persistent discovery
>     controllers it created, and tears them down on exit. When run in
>     `--persistent --autoconnect` mode *in the initial ramfs*, it will keep
>     discovery controllers alive, so that a new instance started after switching
>     root can simply re-use them.

Nice.

>   * In certain situations, the systemd-based approach may miss events due to
>     race conditions. This can happen e.g. if an FC remote port is detected, but
>     shortly after it's detection an FC relogin procedure is necessary e.g. due to
>     an RSCN. In this case, an `fc_udev_device` uevent will be received on the
>     first detection and handled by an `nvme connect-all` command run from
>     `nvmf-connect@.service`. The connection attempt to the rport in question will
>     fail with "no such device" because of the simultaneous FC
>     relogin. `nvmf-connect@.service` may not terminate immediately, because it
>     attempts to establish other connections listed in the Discovery Log page it
>     retrieved. When the FC relogin eventually finishes, a new uevent will be
>     received, and `nvmf-connect@` will be started again, but *this has no effect*
>     if the previous `nvmf-connect@` service hasn't finished yet. This is the
>     general semantics of systemd services, no easy workaround exists.  **nvme
>     monitor** doesn't suffer from this problem. If it sees an uevent for a
>     transport address for which a discovery is already running, it will queue the
>     handling of this event up and restart the discovery after it's finished.

While I understand the issue, this reason alone is an overkill for doing 
this.

>   * Resource consumption for handling uevents is lower. Instead of running an
>     udev worker, executing the rules, executing `systemctl start` from the
>     worker, starting a systemd service, and starting a separate **nvme-cli**
>     instance, only a single `fork()` operation is necessary. Of course, on the
>     back side, the monitor itself consumes resources while it's running and
>     waiting for events. On my system with 8 persistent discovery controllers,
>     its RSS is ~3MB. CPU consumption is zero as long as no events occur.

What is the baseline with what we have today?

>   * **nvme monitor** could be easily extended to handle events for non-FC
>     transports.

Which events?

> 
> I've tested `fc_udev_device` handling for NVMeoFC with an Ontap target, and
> AEN handling for RDMA using a Linux **nvmet** target.
> 
> ### Implementation notes
> 
> I've tried to change the exisiting **nvme-cli** code as little as possible
> while reusing the code from `fabrics.c`. The majority of changes in the
> existing code exports formerly static functions and variables, so that they
> are usable from the monitor code.

General comment, can you please separate out fixes/cleanups that are not
related to the goal of this patchset?

> 
> The main process just waits for events using `epoll()`. When an event is
> received that necessitates a new discovery, a child is forked. This makes it
> possible to fill in the configuration parameters for `do_discover()` without
> interfering with the main process or other discovery tasks running in
> parallel. The program tracks *transport addresses* (called "connections" in
> the code) rather than NVMe controllers. In `--persistent` mode, it tries to
> maintain exactly one persistent discovery connection per transport address.
> 
> Using `epoll()` may look over-engineered at this stage. I hope the better
> flexibility over `poll()` (in particular, the ability to add new event sources
> while waiting) will simplify future extensions and improvements.
> 
> ### Todo
> 
>   * Referrals are not handled perfectly yet. They will be handled by
>     `do_discover()` just as it would when called from **nvme connect-all**, but
>     it would be better to pass referrals back to the main process to make it
>     aware of the additional discovery controller rather than using
>     recursion. The main process would e.g. know if a discovery is already
>     running for the transport address in the referrral.

Agree, this way you can also keep new referrals persistently, which I
don't know if we do today.

>   *  When "add" uevents for nvme controller devices are received, the
>      controller is consistently not in `live` state yet, and attempting to read
>      the `subsysnqn` sysfs attribute returns `(efault)`. While this should
>      arguably be fixed in the kernel, it could be worked around in user space
>      by using timers or polling the `state` sysfs attribute for changes.

This is a bug, what in the code causes this? nothing in controller state
should prevent from this sysfs read from executing correctly...

>   * Parse and handle `discovery.conf` on startup.

This is a must I think, where do you get the known transport addresses
on startup today?

>   * Implement support for RDMA and TCP protocols.

What is needed for supporting them? Not sure I follow (I thought
you mentioned that you tested against linux nvmet-rdma?)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
