Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA5BC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:05:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6A364E09
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6A364E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jE+oZpZuBoVQMCnA7n0vV6TJDDUPG9AYEh1FGlEt1rk=; b=rbmkA9KTxXxwn2B1GDyTqGj1B
	v0gJW7+V9ZyOJN5KU5ZUPwvhtj4GKYu+Wmm1DM7jUPFJxkDdHioazlspcHcy68CK5+lRy3fkymRm1
	f7RB8U0j1uZGjmyAO9BVdSX6VhQLfbfZVAnMBvU6D4FMiQZPmUJ92UCdZmGku8SY6wTevBgvn5HIf
	O4QVHCP0Bi1x16YFfe8YW72S91rdayNvqJB9jX28uYw4xHY7rA/EtdX3wXSqPFJdsWRbQfmnyBqfF
	RHxh8cFyb7qyfNunCOebdHgHSrZHmZHUorXJ3INdz4fU0TwHZJcmGTzMf8kDVPXRuwk7OLQM5Sugv
	W4yNJHsxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5axP-0004yh-Dk; Fri, 29 Jan 2021 21:05:31 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5axM-0004yM-Ve
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 21:05:30 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611954327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FH/NhG+OG5BJ7xXic7bGHmMrg49vO0hE0ykRBYa9Zm0=;
 b=k6hbVGw37TzZwLM2uWqaTmPtgJnkfdzLaiSUKVW08zFvNzsUaWv1tKo+3Tlj7Jer+geEZl
 PpcDvoPLzvOuBlZneJEg/aNU+8DS81ajOg6A7f2wvasaN1yE02RrXQCfPpN8/gd9CoRQ0v
 K4QNVS9SQWvVsbR9r4rc4s0aVnV8H50=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7D54BACB0;
 Fri, 29 Jan 2021 21:05:27 +0000 (UTC)
Message-ID: <5623aeee6a57889123b8a3441ee6df7b97f76451.camel@suse.com>
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 22:05:26 +0100
In-Reply-To: <8cb1830e-b7f3-48ef-1190-0d917aa200bb@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
 <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
 <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
 <b4b9a52011d17ef16cbc86d81ef3d19f7a517d93.camel@suse.com>
 <c127bde8-7cae-677c-4b8d-44cf757d05eb@grimberg.me>
 <2394e23e80f2bdcf0a95eb39e5eefcb00237d52f.camel@suse.com>
 <8cb1830e-b7f3-48ef-1190-0d917aa200bb@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_160529_356024_BD624F71 
X-CRM114-Status: GOOD (  20.67  )
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

On Fri, 2021-01-29 at 12:57 -0800, Sagi Grimberg wrote:
> =

> > > > But I'm not quite following you here, because this option is
> > > > about
> > > > keeping controllers up after the monitor exits. Given that the
> > > > monitor
> > > > would be the instance that receives the AENs and acts upon
> > > > them,
> > > > what's
> > > > the point of keeping them alive after it has terminated?
> > > =

> > > It may run again at some point.
> > > =

> > =

> > If it does, it will recreate discovery controllers for every
> > host_traddr/traddr/trsvcid tuple it finds. "--keep" semantics are
> > only
> > necessary for addresses on which no regular (non-discovery)
> > connection
> > exists.
> =

> Wait, Maybe I'm missing something here, but are you saying that for
> every traddr/trsvcid it finds (both nvm and discovery) it will
> attempt
> to connect a discovery controller?
> =

> If so, this is absolutely wrong.

Currently, it tries to do that on startup, if (and only if) the=A0
--startup option is given. My expectation was that the connection
attempts would simply fail if there was no discovery subsystem to
connect to. Anyway, it's not the default behavior, and can be dropped
completely if it's so bad that we shouldn't ever attempt to do it.

If the service is started early on during boot, and event-based
discovery works (i.e. we also have the mDNS part in place), this won't
be necessary of course.

Regards
Martin






_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
