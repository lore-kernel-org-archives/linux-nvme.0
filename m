Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1CEC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:15:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27B764E04
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27B764E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rRi3n6w5QpH4tnzr44D/7oQtPrBKNqrpDxx12l82v98=; b=RplROSUjAK+oYq/2WGrOqkcwt
	dmZJnKxTBNEU90qyzEyXDdRFGha+uNKcd+pxoZOAlARJgJPu0rv60TMNpREw/PwuUTa9e+BPt5fi5
	pWAIK6acqILfYLbiVP8UH4zSLfYF0fFFqlLw2lVBiuXxtYrFvMqP/WoKOBLcn279zA8z+FeaxVVRT
	vhfwxY6WC1cIi5IDRMlbUNaPPZMGY14ILXcZ3o8MnOeLzbS4aplhOJvUlm26cHhQB5X3EGo44U1HS
	YXaAj+fk5l8sj27S9eLmm1FaaVPyaISmzUprrxKrxi0hDHiqwlREfoqvAhDyPgfAOo2gDPVAWFbos
	o/7utiZ8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5b7K-0005z3-A0; Fri, 29 Jan 2021 21:15:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5b7H-0005xf-Qg
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 21:15:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611954942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tj9gy0YJ53K+VDc1R24TRR0qgnkggLvO/H3W6g68n1w=;
 b=f8XnF3N65Ttof7WxTZ8/ick01V006IIGSYQ6KeREXbFC7DkUXsbREuW2rQ1dqZA7dNG4/h
 PJgsGK8jATdT6GyuQThODHHQsvqqosxn7twlc2/lQvZYqAUcx/6xXxJQiFwxdK/+8gje/5
 Bw7leT+YfPmY2NKvErkCQ760oaJkjks=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AB9BAAE74;
 Fri, 29 Jan 2021 21:15:42 +0000 (UTC)
Message-ID: <c00de29ef02bf39ae231a2816f03c8e920ebdc29.camel@suse.com>
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 22:15:42 +0100
In-Reply-To: <552cb65a-8f1b-e414-4de8-f53ff469e8a1@grimberg.me>
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
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_161544_009024_8CCF1D67 
X-CRM114-Status: GOOD (  22.47  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2021-01-29 at 13:11 -0800, Sagi Grimberg wrote:
> 
> > > > If it does, it will recreate discovery controllers for every
> > > > host_traddr/traddr/trsvcid tuple it finds. "--keep" semantics
> > > > are
> > > > only
> > > > necessary for addresses on which no regular (non-discovery)
> > > > connection
> > > > exists.
> > > 
> > > Wait, Maybe I'm missing something here, but are you saying that
> > > for
> > > every traddr/trsvcid it finds (both nvm and discovery) it will
> > > attempt
> > > to connect a discovery controller?
> > > 
> > > If so, this is absolutely wrong.
> > 
> > Currently, it tries to do that on startup, if (and only if) the
> > --startup option is given. My expectation was that the connection
> > attempts would simply fail if there was no discovery subsystem to
> > connect to. Anyway, it's not the default behavior, and can be
> > dropped
> > completely if it's so bad that we shouldn't ever attempt to do it.
> 
> IMO it needs to be dropped. I didn't understand this at first because
> it never even occurred to me that such an assumption can be even
> made.
> 
> > If the service is started early on during boot, and event-based
> > discovery works (i.e. we also have the mDNS part in place), this
> > won't
> > be necessary of course.
> 
> This isn't necessary regardless. At best the discovery controller
> endpoints should be obtained from discovery.conf or equivalent.

Understood.

> I don't even see how does this help in early boot anyways, how
> do the existing controllers get connected?

For FC, it works today. You can start the monitor in the initrd, it
will receive the fc_udev_device events, and autoconnect (just like
traditional udev/systemd based discovery). For other transports, it'd
be more work, as we'd need to do mDNS discovery from an initrd
environment. I wouldn't say it's impossible though.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
