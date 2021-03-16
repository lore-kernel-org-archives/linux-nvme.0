Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB30C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:14:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A66A64FD6
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A66A64FD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ja6i7VnKg8SH49F8UhQHAC2Cy+pA/Rv9RrYY80LFz6I=; b=mdmp37DA1rkTV+K88xmFy7SRs
	k9g/j4OgEvrk6fBssTZ3vSDWnR8MOQzeNBd5PtrZkqWzzuas96yQT0EJefqDEcdGu+SqPZWWfoPr0
	lEDcN69bsMsF5DO/HUZOHo3u1vWL67Lq0WaEK32d+Asi57OVXttyLeDMKOZbiQEF0oJGD9/M5il41
	taQZnOD0EXWmh63PTU6+pmFRyckrKS9leenMWNBIQ1IVZ5RlE4NOIO4LfLFLVlD4ZYnxTv+1WvV08
	vyAQl2COZ9xDNiqTHto+/NIZs3U9TMjQVB+70E+/eN9bRq+XA7KQ/Yp32Cl5mrTdNbBp5DqtSibj3
	3JAN99nZw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM4qZ-0007Qo-WF; Tue, 16 Mar 2021 08:14:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM4qW-0007QK-Gr
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 08:14:34 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1615882471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5x3rE5uyC/9WTM2yn402Hx/+AOwgC6Sq31gudADKWE=;
 b=fT3MAuV7EGJPunx/vDoTBSgLB33BrqOaJwZQBaGpyx4ocCGSeJTPnQmicH4VdbW4CUlsOr
 hv0FsycLL1qfU4MF4rLlpgRP1f5Iv3JjWjssbHKX2fB0K19wgiap40uXoyHLSUr/LG8b+3
 CFje04KspQ7aHXXnOq9oArD0Paq9IUk=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B2FC4AC1F;
 Tue, 16 Mar 2021 08:14:31 +0000 (UTC)
Message-ID: <52d6b3eccf1debcf42fe50845bcd8504e7b8d7b5.camel@suse.com>
Subject: Re: [PATCH 06/10] nvme-cli: add generic logging functionality
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Keith
 Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
Date: Tue, 16 Mar 2021 09:14:30 +0100
In-Reply-To: <28137147-9fce-1581-e55d-b190f7666cfa@grimberg.me>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-7-mwilck@suse.com>
 <28137147-9fce-1581-e55d-b190f7666cfa@grimberg.me>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_081432_860918_F4E6897E 
X-CRM114-Status: GOOD (  17.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2021-03-15 at 10:45 -0700, Sagi Grimberg wrote:
> =

> > From: Martin Wilck <mwilck@suse.com>
> > =

> > Add a msg() macro that allows more flexible customization of
> > logging
> > both at build time and at run time. Allow several log levels, using
> > the well-known standard sylog levels. Also optionally allow
> > printing
> > of log timestamps.
> > =

> > Put '#define LOG_FUNCNAME' before '#include "util/log.h"' to enable
> > printing
> > the name of the calling function before the log message.
> > =

> > Use this functionality in the fabrics code for now, wherever
> > fprintf(stderr, ...)
> > had been used.
> > =

> > No functional change except changing the output channel of 554db7d
> > ("print
> > device name when creating a persistent device") from stdout to
> > stderr.
> > =

> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> > =A0 Makefile=A0=A0 |=A0 2 +-
> > =A0 fabrics.c=A0 | 85 ++++++++++++++++++++++++++++---------------------
> > --
> > =A0 util/log.c | 90
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > =A0 util/log.h | 34 +++++++++++++++++++++
> =

> I think it makes sense to do a wider sweep also for nvme.c and
> friends
> no?

Yes, but could we do that wider sweep separately, or do you consider it
a requirement?

Regards,
Martin







_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
