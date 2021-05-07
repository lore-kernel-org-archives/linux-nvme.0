Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA6C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 08:35:57 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE56161042
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 08:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE56161042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0GWL2T4/HaZjuEdQx8rQPUwl9DDXl/9GgemeXileHUM=; b=FdosyZ1MqZBPkurOh1qiQYX8o
	9RPQobac9q3NDqg6BUtqArGb2YcHMhNcoADqm92MqU/c+VoTzCo3uDrjfxkj8igz2SSsIqouuyVpA
	Xv/LOgPukkB9x/g2qUva5Mzb6sFxswdu1OhctAJzACXsT6697oyiLjTNAdLPm8fTSPm49qHATd1+f
	mZK+KG044CpLNo6fgyxY2gHSskh7gGAh+yvbi4SwomjlaPHFkLngPhxihFTX0h3GHjalyfB8tH5vl
	fqMgy8ebQaapTk2tosvgYegvv/z++e8TxEZR4ufLivlqg1mIcOyOogUkp2pUs6laIsHZvz/nqo6m+
	3Ove0G3hA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1levxU-006Vs0-7j; Fri, 07 May 2021 08:35:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1levxP-006Vr3-W9
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 08:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620376524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LNzlVmqhguoKtDic8Z0e/TUstJ5bt+WuV5R0ScmvEiQ=;
 b=CMZvh4fWGxh47v06baxtgnUj7PLLnwXDBtrda568OFloFJcKH7eRjnMCAydPP2ASHmP7ey
 CI2CTbi7OdmYmjJNzWeKM/p1kzizXpS2nyWmCH246ftx6pJsox+u93MFqk63AZcaHDHSII
 FABW5fbCVjtWv2di6bmVvG5jxC5ZImU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620376532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LNzlVmqhguoKtDic8Z0e/TUstJ5bt+WuV5R0ScmvEiQ=;
 b=PvKiE6Q3/RQ3CcITHqpRbMoTdQqMZw+3Twi/5aCuSFNwQhQCT4DX1PDgqyOVtXq3zlkUHb
 uEb18zNvOeinDw7NagjHoYPqOf8Ua77kzSngCqkUHfxHp/g4OTqt5c8L886pQxPJuafVid
 I8yCOYwBfCHCA+Id7K5UBbnABG+xICU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-8VPHSbn0N8yJ28vQB7t-Lw-1; Fri, 07 May 2021 04:35:20 -0400
X-MC-Unique: 8VPHSbn0N8yJ28vQB7t-Lw-1
Received: by mail-yb1-f197.google.com with SMTP id
 y5-20020a2586050000b02904ee36d3b170so9251675ybk.10
 for <linux-nvme@lists.infradead.org>; Fri, 07 May 2021 01:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LNzlVmqhguoKtDic8Z0e/TUstJ5bt+WuV5R0ScmvEiQ=;
 b=J5rCXCHfMYFYrFlDpnyvcDq2zhj/8aC8G/9EvJ1UFS3XNKs2vUPdq+oZ7zXw8pe+QX
 R7VH5xMBlXvYQ05LBJJlGVt10zUzDleu36Rq5qK9P1sLto3CNvXctaaOz23QmH6b59JM
 JjUkNlh0ywhuwq21bmR6SbWm7RZJwJIDTbdzX+83L9MTVZN0aJ7HvxZm5XmPiEbDPaHn
 zTOUKeD6h+mQS75wMWW8Hhvjzsel1SpGuNufTweFtwtW2NEs74f1+DmRX43XOpQHkqFt
 Di91XWQBm4WI+na0TD9Fvb7qj9hkxLJ9CDEiEQOYt9PLaoaC2aGkZhzzO+aZ5DO/2a/p
 FC4w==
X-Gm-Message-State: AOAM532F94CfWYB8uuNJVva4BP9+0M4Hfsy/uEpkN97xiIb7Kl3KPmbN
 6D5ychH8xv0IrZGZtYTTCJR/pRAC8N5okPD1agK66ipw7p6q6IijJk153L9uQJ4chGotHd7j9Nn
 /CV7zvakptYriVBnEnklVlplOQqHydp6thiASxqrtINY=
X-Received: by 2002:a25:4248:: with SMTP id p69mr11223638yba.205.1620376519885; 
 Fri, 07 May 2021 01:35:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/Tvw7pMaYJA6nlySJ01H4WdcAA7zpaz3sNE+eNsDddQjIIOjhlzjlPo0vHGBvOI4dlw8AkeQUj9rulW6yVnI=
X-Received: by 2002:a25:4248:: with SMTP id p69mr11223621yba.205.1620376519668; 
 Fri, 07 May 2021 01:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
 <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
In-Reply-To: <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 7 May 2021 16:35:08 +0800
Message-ID: <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, skt-results-master@redhat.com, 
 Bruno Goncalves <bgoncalv@redhat.com>, hare@suse.de
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_093536_193463_56A2FB3C 
X-CRM114-Status: GOOD (  17.53  )
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

On Sat, May 1, 2021 at 5:58 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Sat, May 1, 2021 at 8:55 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Hello
> > > Recently CKI reproduced this WARNING and NULL pointer with
> > > linux-block/for-next on aarch64, seems it's one regression, I will try
> > > if I can bisect the culprit.
> > >
> > > blktests: nvme/022 (test NVMe reset command on NVMeOF file-backed ns)
> > >
> > > [ 1879.759978] run blktests nvme/022 at 2021-04-30 12:30:36
> > > [ 1879.804283] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > > [ 1879.819087] nvmet: creating controller 1 for subsystem
> > > blktests-subsystem-1 for NQN
> > > nqn.2014-08.org.nvmexpress:uuid:0da758a0-4d84-4133-82dd-9801235b55cd.
> > > [ 1879.833081] nvmet: unhandled identify cns 6 on qid 0
> > > [ 1879.838079] nvme nvme0: creating 128 I/O queues.
> > > [ 1879.852353] nvme nvme0: new ctrl: "blktests-subsystem-1"
> > > [ 1880.879731] nvme nvme0: resetting controller
> > > [ 1889.940458] nvmet: ctrl 1 keep-alive timer (5 seconds) expired!
> > > [ 1889.946377] nvmet: ctrl 1 fatal error occurred!
> > > [ 1889.950928] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> >
> > It appears that we are somehow now expire the kato after/during a reset
> > sequence and then seem to race reset and remove...
> >
> > bisection will help definitely.
> >
> Hi Sagi
>
> Bisect shows bellow commits was the first bad commit.
>
> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (refs/bisect/bad)
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Fri Apr 16 13:46:20 2021 +0200
>
>     nvme: sanitize KATO setting
>

Hi Sagi
This issue has been consistently reproduced with blktests on recent
linux-block/for-next, do you have a chance to check it?


> Thanks
> Yi


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
