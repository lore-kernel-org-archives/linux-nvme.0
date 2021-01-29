Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E8C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:50:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BF064E0E
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BF064E0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q0YTUUfWY8YeTlR6cjjzX2XETGcoqNgpfDOVd+d53Rk=; b=0zUUvc3w1IFiMCoKUWFJYeI9l
	6MBILXg5SudRhL7D3ze5X0YLhIK0VdmktM91/hUCt+3Ul0Lg4kqOBj8z2SA8I8vMb/0lsu60BnE2J
	SNhsd3jZ+AVr3Nio55YTsXa6Kx4j1CLL+DjUW4sWng/6UH16GlEx2IjLk9xJKT5KRdLWUH5kWAF1d
	nOSgOTK8SNi493ciYMXrLu3xOPEFnhznJeRtfxwMStJf4kf7pseDSOF6SADeD8hkCJILNEgN63PAQ
	R71LK5cPURsYJBjHCMyVG+jfT44bFAQtRgOfeGVL3ZFmB12AeS2R8+fnSirluP7564Dv1LL46kZvP
	qIKz5khzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5ZmQ-0004lW-5H; Fri, 29 Jan 2021 19:50:06 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5ZmN-0004l2-Bv
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 19:50:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611949802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoCNCOu9PD4TUfD4Hw8gN51p2Yov6YzcBCV5uN+G+x4=;
 b=nplb1NqGYBu0bZYrTkycLrwhlmBeksALNtWAMQmlT/dReZvEDoAA2bUw2dk03yPqMKEwvQ
 kcikk2SbObN01xoRW8yFZ4YMGvDhMFs3efC4y8gtv51PQfydcP78efOikY2fZ7blBFv5VX
 3VC5IegzRvG1oEM2HOtJ8LoDGkqjiws=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 11D9DACB0;
 Fri, 29 Jan 2021 19:50:02 +0000 (UTC)
Message-ID: <d699b37ac6951214aa91b28c87a51510197b3670.camel@suse.com>
Subject: Re: [PATCH 32/35] nvmf-autoconnect: add unit file for
 nvme-monitor.service
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 20:50:01 +0100
In-Reply-To: <0aaeb938-4d72-f138-6e24-0a7f95d05b39@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-33-mwilck@suse.com>
 <0aaeb938-4d72-f138-6e24-0a7f95d05b39@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_145003_597650_5097616E 
X-CRM114-Status: GOOD (  15.43  )
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

On Fri, 2021-01-29 at 11:08 -0800, Sagi Grimberg wrote:
> =

> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> > =A0 nvmf-autoconnect/systemd/nvme-monitor.service | 17
> > +++++++++++++++++
> > =A0 1 file changed, 17 insertions(+)
> > =A0 create mode 100644 nvmf-autoconnect/systemd/nvme-monitor.service
> > =

> > diff --git a/nvmf-autoconnect/systemd/nvme-monitor.service b/nvmf-
> > autoconnect/systemd/nvme-monitor.service
> > new file mode 100644
> > index 0000000..d85b133
> > --- /dev/null
> > +++ b/nvmf-autoconnect/systemd/nvme-monitor.service
> > @@ -0,0 +1,17 @@
> > +[Unit]
> > +Description=3DNVMe Event Monitor for Automatical Subsystem
> > Connection
> > +Documentation=3Dman:nvme-monitor(1)
> > +DefaultDependencies=3Dfalse
> > +Requires=3Dsystemd-udevd-kernel.socket
> > +RequiresMountsFor=3D/sys
> > +Conflicts=3Dshutdown.target
> > +After=3Dsystemd-udevd-kernel.socket
> > +Before=3Dsysinit.target systemd-udev-trigger.service nvmefc-boot-
> > connections.service
> > +
> > +[Service]
> > +Type=3Dsimple
> > +ExecStart=3D/usr/sbin/nvme monitor -A -p
> =

> I've seen issues with assuming nvme sits in /usr/sbin/

Sure, this can be fixed. More fine tuning is possible, too. I learned
meanwhile that the dependency on systemd-udevd-kernel.socket is
unnecessary.

Regards
Martin




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
