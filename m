Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC5C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 11:18:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162DB64E37
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 11:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162DB64E37
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6jvY8OjhncA3Pjsi1Ld5F4HIY2HVQnNmDWK8+jverJA=; b=0rs2ijGDx/GfsFB1QYlStqrtJ
	cvGtJEgsySfAesRc4ELDJShoFBXoRlv8k1ayFBm170DSj+WMs6ee4ZTIFmoSW7kDxrJHuxRrV6W6P
	8jaKnbBqZHsxwBSJvPhKLKgcZsbAhqk+TR2Tf6wjzMMduFqBQiS3uuyoEkM+bfueIPIp7OzK21DH8
	1OV2q4kY3S43rKqwd0BwY9fU7zvLj4J+QIUCTFZud9d/H0Q6ChztnbLmEs5C2DvWCyukctqhhiwe1
	IMGNr9rq4O18fLZMqQpBy2eH8pjg5F7yV0sBA3RfeczK+anpAuGrFIQ+aZR4B6vKbbmM0XLAtB4LO
	QIvANDuAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Rn4-0000V1-T5; Fri, 29 Jan 2021 11:18:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Rn0-0000UJ-00
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 11:18:12 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611919086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xukrzXDMBWFFFPk/zNXPSriCEs7hZAXqMcyuPZdJKXc=;
 b=Dx6xmQokQY/QSh3zxQirm+AsczIxr6es4m+UWItl7/aaQl1Joet+Gp6y8aswbKUVwkIHkU
 32r17Kfg6SXqSAugr6jxXPuXo+0d6ksu6xmMVFS5shjfrImpC4r9BGoQZddfdhdRmS85s4
 4cFi0vxl33yu/3tS3srpJaQHUUz7H4U=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C18B5AC48;
 Fri, 29 Jan 2021 11:18:06 +0000 (UTC)
Message-ID: <d8956cf973867ad7cc6c4d968682ec3db3054aa3.camel@suse.com>
Subject: Re: [PATCH 00/35] RFC: add "nvme monitor" subcommand
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 12:18:05 +0100
In-Reply-To: <60846bb5-c0df-ac23-260b-b53afd48f661@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <60846bb5-c0df-ac23-260b-b53afd48f661@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_061811_036600_632416CB 
X-CRM114-Status: GOOD (  49.16  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2021-01-28 at 17:14 -0800, Sagi Grimberg wrote:
> =

> > From: Martin Wilck <mwilck@suse.com>
> > =

> > (Cover letter copied from =

> > https://github.com/linux-nvme/nvme-cli/pull/877)
> > =

> > This patch set adds a new subcommand **nvme monitor**. In this
> > mode,
> > **nvme-cli** runs continuously, monitors events (currently,
> > uevents) relevant
> > for discovery, and optionally autoconnects to newly discovered
> > subsystems.
> > =

> > The monitor mode is suitable to be run in a systemd service. An
> > appropriate
> > unit file is provided. As such, **nvme monitor** can be used as an
> > alternative
> > to the current auto-connection mechanism based on udev rules and
> > systemd
> > template units. If `--autoconnect` is active, **nvme monitor**
> > masks the
> > respective udev rules in order to prevent simultaneous connection
> > attempts
> > from udev and itself.
> =

> I think that a monitor daemon is a good path forward.
> =

> > =

> > This method for discovery and autodetection has some advantages
> > over the
> > current udev-rule based approach:
> > =

> > =A0 * By using the `--persistent` option, users can easily control
> > whether
> > =A0=A0=A0 persistent discovery controllers for discovered transport
> > addresses should
> > =A0=A0=A0 be created and monitored for AEN events. **nvme monitor**
> > watches known
> > =A0=A0=A0 transport addresses, creates discovery controllers as require=
d,
> > and re-uses
> > =A0=A0=A0 existing ones if possible.
> =

> What does that mean?

In general, if the monitor detects a new host_traddr/traddr/trsvcid
tuple, it runs a discovery on it, and keeps the discovery controller
open if=A0--persistent was given. On startup, it scans existing
controllers, and if it finds already existing discovery controllers,
re-uses them. These will not be shut down when the monitor exits.

This allows users fine-grained control about what discovery controllers
to operate persistently. Users who want all discovery controllers to be
persistent just use --persistent. Others can set up those that they
want to have (manually or with a script), and not use --persistent.

The background is that hosts may not need every detected discovery
controller to be persistent. In multipath scenarios, you may see more
discovery subsystems than anything else, and not everyone likes that.
That's a generic issue and unrelated to the monitor, but running the
monitor with --persistent creates discovery controllers that would
otherwise not be visible.

Hope this clarifies it.

> > =A0 * In certain situations, the systemd-based approach may miss
> > events due to
> > =A0=A0=A0 race conditions. This can happen e.g. if an FC remote port is
> > detected, but
> > =A0=A0=A0 shortly after it's detection an FC relogin procedure is
> > necessary e.g. due to
> > =A0=A0=A0 an RSCN. In this case, an `fc_udev_device` uevent will be
> > received on the
> > =A0=A0=A0 first detection and handled by an `nvme connect-all` command
> > run from
> > =A0=A0=A0 `nvmf-connect@.service`. The connection attempt to the rport =
in
> > question will
> > =A0=A0=A0 fail with "no such device" because of the simultaneous FC
> > =A0=A0=A0 relogin. `nvmf-connect@.service` may not terminate immediatel=
y,
> > because it
> > =A0=A0=A0 attempts to establish other connections listed in the Discove=
ry
> > Log page it
> > =A0=A0=A0 retrieved. When the FC relogin eventually finishes, a new
> > uevent will be
> > =A0=A0=A0 received, and `nvmf-connect@` will be started again, but *this
> > has no effect*
> > =A0=A0=A0 if the previous `nvmf-connect@` service hasn't finished yet.
> > This is the
> > =A0=A0=A0 general semantics of systemd services, no easy workaround
> > exists.=A0 **nvme
> > =A0=A0=A0 monitor** doesn't suffer from this problem. If it sees an
> > uevent for a
> > =A0=A0=A0 transport address for which a discovery is already running, it
> > will queue the
> > =A0=A0=A0 handling of this event up and restart the discovery after it's
> > finished.
> =

> While I understand the issue, this reason alone is an overkill for
> doing =

> this.

I agree. But it's not easy to fix the issue otherwise. In the customer
problem where we observed it, I worked around it by adding the udev
seqnum to the "instance name" of the systemd service, thus allowing
several "nvme connect-all" processes to run for the same transport
address simultaneously. But I don't think that would scale well;
the monitor can handle it more cleanly.

> > =A0 * Resource consumption for handling uevents is lower. Instead of
> > running an
> > =A0=A0=A0 udev worker, executing the rules, executing `systemctl start`
> > from the
> > =A0=A0=A0 worker, starting a systemd service, and starting a separate
> > **nvme-cli**
> > =A0=A0=A0 instance, only a single `fork()` operation is necessary. Of
> > course, on the
> > =A0=A0=A0 back side, the monitor itself consumes resources while it's
> > running and
> > =A0=A0=A0 waiting for events. On my system with 8 persistent discovery
> > controllers,
> > =A0=A0=A0 its RSS is ~3MB. CPU consumption is zero as long as no events
> > occur.
> =

> What is the baseline with what we have today?

A meaningful comparsion is difficult and should be done when the
monitor functionality is finalized. I made this statement only to
provide a rough idea of the resource usage, not more.

> > =A0 * **nvme monitor** could be easily extended to handle events for
> > non-FC
> > =A0=A0=A0 transports.
> =

> Which events?

Network discovery, mDNS or the like. I haven't digged into the details
yet.

> > I've tested `fc_udev_device` handling for NVMeoFC with an Ontap
> > target, and
> > AEN handling for RDMA using a Linux **nvmet** target.
> > =

> > ### Implementation notes
> > =

> > I've tried to change the exisiting **nvme-cli** code as little as
> > possible
> > while reusing the code from `fabrics.c`. The majority of changes in
> > the
> > existing code exports formerly static functions and variables, so
> > that they
> > are usable from the monitor code.
> =

> General comment, can you please separate out fixes/cleanups that are
> not
> related to the goal of this patchset?

Which ones are you referring to? 09 and 19? While these are minor
improvements to the existing code, I wouldn't say they qualify as fixes
or cleanups. They aren't necessary without adding the monitor code.

But yes, I can post all changes to existing code separately.

> > =A0 *=A0 When "add" uevents for nvme controller devices are received,
> > the
> > =A0=A0=A0=A0 controller is consistently not in `live` state yet, and
> > attempting to read
> > =A0=A0=A0=A0 the `subsysnqn` sysfs attribute returns `(efault)`. While =
this
> > should
> > =A0=A0=A0=A0 arguably be fixed in the kernel, it could be worked around=
 in
> > user space
> > =A0=A0=A0=A0 by using timers or polling the `state` sysfs attribute for
> > changes.
> =

> This is a bug, what in the code causes this? nothing in controller
> state
> should prevent from this sysfs read from executing correctly...

I think it can be fixed by making nvme_sysfs_show_subsysnqn() fall back
to ctrl->opts->subsysnqn if ctrl->subsys is NULL.

I'll send a patch. Anyway, it'll take time until this is fixed
everywhere.

> =

> > =A0 * Parse and handle `discovery.conf` on startup.
> =

> This is a must I think, where do you get the known transport
> addresses
> on startup today?

There's a systemd service that runs "nvme connect-all" once during
boot. That exists today. I'm not sure if it should be integrated in the
monitor, perhaps it's good to keep these separate. People who don't
need the monitor can still run the existing service only, whereas for
others, the two would play together just fine.

> =

> > =A0 * Implement support for RDMA and TCP protocols.
> =

> What is needed for supporting them? Not sure I follow (I thought
> you mentioned that you tested against linux nvmet-rdma?)
> =


AENs over existing discovery controllers are supported for all
transports. But there's no support for discovery of new transports
except for NVMeoFC's "fc_udev_device" mechanism.

Regards
Martin





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
