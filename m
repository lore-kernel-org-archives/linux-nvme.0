Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 10:41:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565BF619E2
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 10:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 565BF619E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sSkVJmFTZsZCj+l5QYD1zkXiNNMJwPfM0ehxbZZuKgo=; b=2ELITR+rud4Mn6
	rf1QU6cZSCQZLcBdjj5bBqgI1OwXPUYx78aTUq95d8QsqgzPyQ7WrmZD1BT4qpft2nCCXXYNo4quy
	EmynZZ83jM0ZLW7Fr1atzlq31iTBIXhc70T2S1zhMb+uOhaGLHu0pVw5gu4BCnRYgh8vn05RuTdSh
	kbek1F15nSfyMrLD6t1+3M1xwrSL5jz2fnpyXFYjvPnX0SybNto/S8BySy4Uiy3qC0YwPYTgrASCj
	w6MQBYhQxFq1nyGOaL3qyG0pAHW3QWNjnnV2jf24Rqw/GZdT5CZw4LL71Qu/gIUsNDmN3kT0gijUC
	JMMp4qKMmZzMAYMjGO/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVtUc-00DsBz-OO; Thu, 30 Sep 2021 10:40:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVtRA-00DqST-2j
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 10:37:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632998230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIynjB3KQIRLo+CuNY6gdWmeevq5ziubtl0qp57nI4c=;
 b=Gaap/2vVuob1aQ4rR7XkcnyA84nVzT/QZ2xWGbUZT9ZF/nYLZeHi/Fmro2jQ2korN+qy0a
 vPoqh065fH0br+nl1S+OWXOy4us3K6KnW3S3UYL+LdloebyAFE6c2BiEhLU/8wo8J34L0P
 an8cVzVB8pXinfBQxmazbSekclKXnMc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-avOrOKDxPm2Ks5rzwuc7Aw-1; Thu, 30 Sep 2021 06:37:09 -0400
X-MC-Unique: avOrOKDxPm2Ks5rzwuc7Aw-1
Received: by mail-yb1-f198.google.com with SMTP id
 x16-20020a25b910000000b005b6b7f2f91cso7874338ybj.1
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 03:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fIynjB3KQIRLo+CuNY6gdWmeevq5ziubtl0qp57nI4c=;
 b=zX7txnxoW9EK48M6ua7nHDkhtzauu/RQYr3c2m7KBk5rWjXU+6QQMpcnpZa19oef1W
 kCssNI8wdQyArQP5VfIhw5woq0FEd17zKHpxSXW0D72/YzBbNF39OexwcXgaDFe58MWv
 Vfr3z9kGIrqFN9eJ7269gPkcp2JLTf0igEBuXVfJ7wG+ESGcNS4IcjtHzOiCc7xPmK9L
 WmJU1zpDlimgaWfkX3HBerAzC9HOI1h1xmNkgu5JYdQUYKA07xBEPQFv3s2F03B+AgIy
 q2/Gr7wVnWKBfvHB7KwglXlNHiAA3XseWExymYrYBiqTtrTZQmJJiT2uc9Ofe/FnJcAf
 Fx7Q==
X-Gm-Message-State: AOAM533cDy151qljI5YK/sDtJLotR4+5LPM8hwGQZyq9/2CnfL+A3XHw
 tRLTYaygVHUz8RMuEJiUbzrA7QNUc3pXIblPGUTsTqoDiZafSDXPjJwr901Kxc2szysTnt5Oe+D
 kXKgnoSTUiRc9+eo9PAh26z1nYXLB/qFxf771fhlOOSQ=
X-Received: by 2002:a25:496:: with SMTP id 144mr5400291ybe.522.1632998228899; 
 Thu, 30 Sep 2021 03:37:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRx8JSORgzzKA6phKCXl7L3yWUWVcipNXdnrnt+jh425/ohL1/LoVj6mCfb1W064CH+/66Y6gsQ01RMajG4yQ=
X-Received: by 2002:a25:496:: with SMTP id 144mr5400245ybe.522.1632998228326; 
 Thu, 30 Sep 2021 03:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
 <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
In-Reply-To: <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 30 Sep 2021 18:36:56 +0800
Message-ID: <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_033712_241201_4740FF88 
X-CRM114-Status: GOOD (  14.30  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 30, 2021 at 3:55 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >>> Hello
> >>>
> >>> Below kmemleak was triggered with blktests nvme-tcp on latest
> >>> 5.15.0-rc3, pls check it.
> >>>
> >>
> >> Please share the test number and the frequency to reproduce this...
> >>
> >
> > Hi
> > I'm running the full blktests nvme-tcp[1] and it's 100% reproduced.
> >
> > [1]
> > # nvme_trtype=tcp ./check nvme/
>
> Yi, this does not happen with nvme_trtype=rdma? It looks like

nvme_trtype=rdma use_siw=1 also can reproduce it.

> we don't get to call cdev_device_del and del_gendisk, which means
> we may have a referencing problem...
>
> I'm wandering if this is a regression we can bisect to?

So just run[1] with nvme_core: multipath=Y will trigger it.
[1]
nvme_trtype=tcp ./check nvme/004

Will try bisect it.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
