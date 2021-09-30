Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30137C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 13:02:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2DA76124B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 13:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E2DA76124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OHXs3T8RFpfH/jLrh+4DZhQFRNUBQhwVKs/r6hpEoRg=; b=NxF2fJdfz7Ycs2
	ViD9hejcADE7Co1PX8IsLNQlu01Iq+YHkOSo/qY5tagv+H4UGXs09D+om4QGnLTbvkg2vCMMopEzs
	87DqMslZUy02P7yTIzG1DGY5i0uspSyAjnC7zqi0ms1IdKHBX2Ak96c63L5btAtE1yGdkAKpEek+R
	REz0H1Z6N6GP+UXsMyLJSYHgppZFZqYcQkF6CvH2bogWoY2pS1bMlTBSpMfMY5L4q0ttlMR0aprGB
	f54UVZ1cfT3w6N3Tz8nyDCtmom6Xo0TW3tuwWoGZkgn4OCTNptFXwJhcx7rmyypz7qNvQF1vKoKyc
	/ynypV5pRVzL+SsnqLWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVvgz-00EL1P-AL; Thu, 30 Sep 2021 13:01:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVvgw-00EL0f-Oz
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 13:01:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633006897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1NWAxPtJGZgh0LgxeixEIBJmRp1/t4taogZ21etg+nI=;
 b=aXDP2j1gULgHbC/hHQdy1kabDt72iPyG7EWXHchmk/bkUVQBKpB3tjI/GCIQzZ+icLfk9G
 Bj2hV1Zs1tvqGLfcXjPCY4/zcEyBVAwAJXu9+DlMAX/2z6xL2AOztjwijmVpnGZz8pEJMg
 80MCYgaEjTFcsXzU8rM6GbXivgOwmRE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-MjNWcYy1PIWBaDe6QIPfRg-1; Thu, 30 Sep 2021 09:01:35 -0400
X-MC-Unique: MjNWcYy1PIWBaDe6QIPfRg-1
Received: by mail-yb1-f197.google.com with SMTP id
 z130-20020a256588000000b005b6b4594129so8215101ybb.15
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 06:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1NWAxPtJGZgh0LgxeixEIBJmRp1/t4taogZ21etg+nI=;
 b=ilmmY/WxDreuTWmXOsI+gL2VvQkSIscjz0xEdTKMHrwnnETT37Jfk2yLD2hQALX3ks
 RR5sTIOpHx0+EOw5en7/ebLRTh0diM+/hmDDBDNGFGPtM9UhIa/p7l8fmUtmQEnTavua
 n8LNk/EnFa7m5vnmT0onNjE6n+S3h7tUvcqYQmMkEfRKck+GRQMOBAQ1C4gIGyV8f2ct
 t7yRYPdboPWhIZQFX7XTaBtsOqystPRRTE1PvRnFv4tbCTTpWQRDZhBmIP1ykqDgTZLQ
 KzyrSfqRmvhdxkhLPMytEOBfYhBMSBU6LbZNgIrL803ln3CotWWmS+Q8PErpoVqIUUXD
 lFrA==
X-Gm-Message-State: AOAM531Q83bKNrocws9B5aBCuH+ajm8AHxoM+tvhNXwt82RJGqNRfmgf
 Mc4SyKDzJuWReg9ek3ZsTD547G4SEUUFPDvINf/NZZrtb7zlNdefv8Nsh0wwzY2MZMAiQbd0iCD
 HDiA8ZR17VnfOzRouWiLL+daTBPi0L53sFFrfyhW1iBs=
X-Received: by 2002:a25:b94a:: with SMTP id s10mr6467205ybm.153.1633006894738; 
 Thu, 30 Sep 2021 06:01:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHR/hJqDv/ltpQUhiohV3HRGxluUrMPW+fMuJC7V15DXufuIaJBxIvf9QM7ktrMiR2jt7+SK7p4+k6aY8W/70=
X-Received: by 2002:a25:b94a:: with SMTP id s10mr6467161ybm.153.1633006894381; 
 Thu, 30 Sep 2021 06:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8pcLTjHMhh_0vebWUgwTY+UtYoKAhQntCsFvKM4zcKfA@mail.gmail.com>
 <caa2467e-9763-b9dd-db91-4cb7020bab47@nvidia.com>
 <CAHj4cs_NqB6WYQQOpqjoOFvTbbN_VydJkn1VquzTkyGpFqMM2Q@mail.gmail.com>
 <0a8810e0-4c42-4275-acd6-475fd42485fe@grimberg.me>
 <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
In-Reply-To: <CAHj4cs_icpHAf7wN3LFt7avcPcrhjOYiSnU8SnCLQN1ObkRV1Q@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 30 Sep 2021 21:01:23 +0800
Message-ID: <CAHj4cs9QBFXca-rnP05ZmWBKDJv4aviiDQ=q2_JihMQuESE7OA@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed with blktests nvme-tcp tests
To: Sagi Grimberg <sagi@grimberg.me>, minwoo.im.dev@gmail.com
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_060138_907634_7AA57E3C 
X-CRM114-Status: GOOD (  17.80  )
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

Bisect shows it was introduced from the below commit:

commit 2637baed78010eeaae274feb5b99ce90933fadfb
Author: Minwoo Im <minwoo.im.dev@gmail.com>
Date:   Wed Apr 21 16:45:04 2021 +0900

    nvme: introduce generic per-namespace chardev


On Thu, Sep 30, 2021 at 6:36 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Thu, Sep 30, 2021 at 3:55 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > >>> Hello
> > >>>
> > >>> Below kmemleak was triggered with blktests nvme-tcp on latest
> > >>> 5.15.0-rc3, pls check it.
> > >>>
> > >>
> > >> Please share the test number and the frequency to reproduce this...
> > >>
> > >
> > > Hi
> > > I'm running the full blktests nvme-tcp[1] and it's 100% reproduced.
> > >
> > > [1]
> > > # nvme_trtype=tcp ./check nvme/
> >
> > Yi, this does not happen with nvme_trtype=rdma? It looks like
>
> nvme_trtype=rdma use_siw=1 also can reproduce it.
>
> > we don't get to call cdev_device_del and del_gendisk, which means
> > we may have a referencing problem...
> >
> > I'm wandering if this is a regression we can bisect to?
>
> So just run[1] with nvme_core: multipath=Y will trigger it.
> [1]
> nvme_trtype=tcp ./check nvme/004
>
> Will try bisect it.



-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
