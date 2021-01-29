Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB580C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:28:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713AB64DDE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 20:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713AB64DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lfiys3GeN2jM2yG1DgxL/r4xOCTTTN8oXPa3wtrBde0=; b=wbc5gf6uH8Ftdtnhz+w6dXbMs
	VG/Vx90FjU3Z4dZDqN1E0JYT6qRo/EQwf+T3a8VmeEOSnnQUV5W1rtxNm32FcmWcFgm6XcQJC88st
	77r1dKknwcXjBfuSZdAhRu9h7Rw3WVxLhBP8rrFgrsUitvWST5mR2Cyn9gN/0UvfWnPc1z7/HbS+Z
	FQHsFLOnfMWBx6BkI877njPoHMnPH4uk9CE3iNQbmHM/N2Najp9O8LpxvU4WPv/kHflhpyfapqob7
	PJqrhoBRGyv6Wc99olyBNipbJuyiz7xzY1iUq+Wxdsc6ETtHQG/IARfvQO+UUC7bxTU5F5NTSm3r6
	FNJnNOI8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5aN0-0001Yi-Oq; Fri, 29 Jan 2021 20:27:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5aMu-0001Xm-1K
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 20:27:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611952064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zs46aW2vPkqkQ2J7X+4pRqOZsxo77SLVouGMfXyLQ3U=;
 b=KV40lvrwDKkbvgytUJkNGGunfMokB+fUNBzXjsu9KX4tL/tAkeDJq3ojHVH89ZPiltFpEJ
 sX2zJiDIkQnPBSo5NfXYPpmq/oz+jiHqLxrH3BfsKFhaG8KL3u8sRnzLXtf69zrZe0uzg3
 oFXDUDRXnGXA3MvhJY/Zi8wkKQmDMLg=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3E866AC45;
 Fri, 29 Jan 2021 20:27:44 +0000 (UTC)
Message-ID: <26138a83eee9362b1769940f6da86387716ab2d8.camel@suse.com>
Subject: Re: [PATCH 00/35] RFC: add "nvme monitor" subcommand
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 21:27:43 +0100
In-Reply-To: <d8e35845-31d3-a46d-b464-728d751d0b33@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <60846bb5-c0df-ac23-260b-b53afd48f661@grimberg.me>
 <d8956cf973867ad7cc6c4d968682ec3db3054aa3.camel@suse.com>
 <d8e35845-31d3-a46d-b464-728d751d0b33@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_152748_326776_06B8652B 
X-CRM114-Status: GOOD (  46.84  )
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

On Fri, 2021-01-29 at 12:08 -0800, Sagi Grimberg wrote:
> =

> > > > =

> > > > This method for discovery and autodetection has some advantages
> > > > over the
> > > > current udev-rule based approach:
> > > > =

> > > > =A0=A0 * By using the `--persistent` option, users can easily
> > > > control
> > > > whether
> > > > =A0=A0=A0=A0 persistent discovery controllers for discovered transp=
ort
> > > > addresses should
> > > > =A0=A0=A0=A0 be created and monitored for AEN events. **nvme monito=
r**
> > > > watches known
> > > > =A0=A0=A0=A0 transport addresses, creates discovery controllers as
> > > > required,
> > > > and re-uses
> > > > =A0=A0=A0=A0 existing ones if possible.
> > > =

> > > What does that mean?
> > =

> > In general, if the monitor detects a new host_traddr/traddr/trsvcid
> > tuple, it runs a discovery on it, and keeps the discovery
> > controller
> > open if=A0--persistent was given. On startup, it scans existing
> > controllers, and if it finds already existing discovery
> > controllers,
> > re-uses them. These will not be shut down when the monitor exits.
> =

> And if it doesn't run with --persistent it deletes them? even if
> these
> weren't created by it?

No, not those. That's what I wanted to express with "These will not be
shut down when the monitor exits."

It's not trivial to determine reliably which controller the monitor
created and which it didn't. The current code assumes that all
discovery controllers that didn't exist at startup were created by the
monitor. We can improve the intelligence of the tool in that area, of
course. Currently it makes this dumb assumption.

> =

> And, if none exist where does it get new discovery controller
> details?
> Today we use discovery.conf for that.

As I said, this can be done with a separate "nvme connect-all" call,
which could be run from an ExecStartPre or from a separate service.
Or we can integrate the functionality in the monitor. I don't have a
strong opinion either way. I can adapt to what you guys prefer.

> =

> > This allows users fine-grained control about what discovery
> > controllers
> > to operate persistently. Users who want all discovery controllers
> > to be
> > persistent just use --persistent. Others can set up those that they
> > want to have (manually or with a script), and not use --persistent.
> > =

> > The background is that hosts may not need every detected discovery
> > controller to be persistent. In multipath scenarios, you may see
> > more
> > discovery subsystems than anything else, and not everyone likes
> > that.
> > That's a generic issue and unrelated to the monitor, but running
> > the
> > monitor with --persistent creates discovery controllers that would
> > otherwise not be visible.
> > =

> > Hope this clarifies it.
> =

> Well, How do people expect to know if stuff change without a
> persistent
> discovery controller? Not sure if people may see more discovery
> controllers this is a real issue given what they are getting from it.

You're right. At this very early stage, I wanted to give users the
freedom of choice, and not force dozens of discovery controller
connections upon everyone. If there's consensus that the discovery
connections should always be created, fine with me. =



> > I agree. But it's not easy to fix the issue otherwise. In the
> > customer
> > problem where we observed it, I worked around it by adding the udev
> > seqnum to the "instance name" of the systemd service, thus allowing
> > several "nvme connect-all" processes to run for the same transport
> > address simultaneously. But I don't think that would scale well;
> > the monitor can handle it more cleanly.
> =

> Still changing the entire thing for a corner case...

It's just one puzzle piece.

> > > > =A0=A0 * Resource consumption for handling uevents is lower.
> > > > Instead of
> > > > running an
> > > > =A0=A0=A0=A0 udev worker, executing the rules, executing `systemctl
> > > > start`
> > > > from the
> > > > =A0=A0=A0=A0 worker, starting a systemd service, and starting a
> > > > separate
> > > > **nvme-cli**
> > > > =A0=A0=A0=A0 instance, only a single `fork()` operation is necessar=
y.
> > > > Of
> > > > course, on the
> > > > =A0=A0=A0=A0 back side, the monitor itself consumes resources while
> > > > it's
> > > > running and
> > > > =A0=A0=A0=A0 waiting for events. On my system with 8 persistent
> > > > discovery
> > > > controllers,
> > > > =A0=A0=A0=A0 its RSS is ~3MB. CPU consumption is zero as long as no
> > > > events
> > > > occur.
> > > =

> > > What is the baseline with what we have today?
> > =

> > A meaningful comparsion is difficult and should be done when the
> > monitor functionality is finalized. I made this statement only to
> > provide a rough idea of the resource usage, not more.
> =

> You mention that the utilization is lower than what we do today,
> hence
> my question is by how much?

I'll try to figure it out and come up with something. Sorry for the
hand-waving assertion. I admint It was speculative for the most part.

> > > > =A0=A0 * **nvme monitor** could be easily extended to handle events
> > > > for
> > > > non-FC
> > > > =A0=A0=A0=A0 transports.
> > > =

> > > Which events?
> > =

> > Network discovery, mDNS or the like. I haven't digged into the
> > details
> > yet.
> =

> Yes, that is possible, would probably be easier to do this in a
> higher
> level language but libavahi can also do this...

Enzo Matsumiya has been working on it, and we've been discussing how to
integrate his functionality into the monitor.

> > > =

> > > > =A0=A0 * Parse and handle `discovery.conf` on startup.
> > > =

> > > This is a must I think, where do you get the known transport
> > > addresses
> > > on startup today?
> > =

> > There's a systemd service that runs "nvme connect-all" once during
> > boot. That exists today. I'm not sure if it should be integrated in
> > the
> > monitor, perhaps it's good to keep these separate. People who don't
> > need the monitor can still run the existing service only, whereas
> > for
> > others, the two would play together just fine.
> =

> Then doesn't this service need to run after it?

Not necessarily. It can handle controllers that are created by other
processes while it's running.

Thanks for your comments,
Martin




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
