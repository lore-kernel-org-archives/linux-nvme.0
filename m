Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A13CC43334
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Jul 2022 01:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LnmwoE1ESaUSXake5lmFYTPM0/kp0klpWUDGs+CL1aM=; b=BN77YyV3C/n1U5PosYBDVMTNSA
	oaDn/NMYG2xwrFH8SiAGPbev8PRT1fasGyHongGKnvC9FClJRmBCEU61WtuP6V06dkAxCAg5rsVNI
	g+bJ8QlmZ4YezuArftGw1AfSn0ddsSW1lG4IRDl6IX1iODzfN5WKXH1x1jbpvRVhW08OQcwApSD6N
	rCSy0Gk6hQGv4UqH+9x4y8u5QQPVMZa0yp7pWUwgTiMg2DHulwkv9A9QWf7soRwfxf7btgWlUSTKn
	PaMpF+ADw4IgFT2dTDZxvK6KCtooFAleZXLhtTVN3B9a449ieT2NSA/gVq8+bQbUdBLyMHGNrF7pk
	F2GWxirQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oALXa-00A5B9-H9; Sun, 10 Jul 2022 01:15:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oALXT-00A58F-HV
	for linux-nvme@lists.infradead.org; Sun, 10 Jul 2022 01:15:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657415707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LnmwoE1ESaUSXake5lmFYTPM0/kp0klpWUDGs+CL1aM=;
	b=iexgIstEzH0mvfOwUWvrOuMXkDkio3ncneZJZNjxfPwNkqK1i13UtIx0cvxDXNdbKn+xLv
	nLS5qMxaWCVFLLuEKZltvcdSozxnypwoWMBTacORxV9VE9imEvJ5NvpiFsi+uL90vs7xAu
	v/dKEQSQgNgIixv0iKLPAkMmlaK2UZM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-y4nNUvM_O9CQ0HM0wS58Wg-1; Sat, 09 Jul 2022 21:15:06 -0400
X-MC-Unique: y4nNUvM_O9CQ0HM0wS58Wg-1
Received: by mail-pj1-f72.google.com with SMTP id mh7-20020a17090b4ac700b001ef88609386so3549395pjb.9
        for <linux-nvme@lists.infradead.org>; Sat, 09 Jul 2022 18:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnmwoE1ESaUSXake5lmFYTPM0/kp0klpWUDGs+CL1aM=;
        b=N+Juc8zIu10WA2KAl55n2UJNXnsbRAAPlo1vzbttkd2oS6Nyew6Ie4jk6k4Afnqbt2
         PXkpTFQuyqTuET6OcUh6STkfTVzNi9Q2F35/LqwMIuVL85oRqGizEC15tKhpxgAmomqF
         P4dddVxwE4hpzTptk356cxq3U+RozknaGdM2arPsKuD7jfjqpN1dAssb5FKwvclOD4Wm
         r6BRaS6j+TGbEj/0BAJYYl01RXqKsmE8GTbulTj4FFGapnqsQpe6Ygf8t33+dkDExga7
         5tlDOrU6LXCqW8lIEdvX7Wbvw1vlsRDA7y/ZX0zYtUAT/GSFw7gI0bRLKpOAfkLzqL7E
         FfSA==
X-Gm-Message-State: AJIora9YhujJ141yIK6prh0ObYfITV4VFobl2QktfFxC++5sUPKI8W7D
	OHcIcL6jaAN/9XSyWNUc9F9qUgYO1Iqrb1fHhHTHOHMhv+n7cwcos3GK6KbhYH2nR92rHw3bdkU
	4RJlk4cm4G/dUt7L0SBOVk2Txbge/xsKdFWY3ufJH7Gc=
X-Received: by 2002:a05:6a00:793:b0:52a:b261:f8e7 with SMTP id g19-20020a056a00079300b0052ab261f8e7mr10004220pfu.20.1657415705340;
        Sat, 09 Jul 2022 18:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tqJATeVZl4K9fNLEfFlRcSBawUoqH1LFdOK/P3Q+zc5HAvKZdmY9aMRgLd4rtICcDO1JtOVkruH4QCr3aZBZs=
X-Received: by 2002:a05:6a00:793:b0:52a:b261:f8e7 with SMTP id
 g19-20020a056a00079300b0052ab261f8e7mr10004202pfu.20.1657415705013; Sat, 09
 Jul 2022 18:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
 <def01493-bd2d-bed4-ab1a-9b4304687692@acm.org> <CAHj4cs-xUroRHbvY4kBPCBFgch7d24yXDFLo4P_ym8KEkHCvug@mail.gmail.com>
In-Reply-To: <CAHj4cs-xUroRHbvY4kBPCBFgch7d24yXDFLo4P_ym8KEkHCvug@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sun, 10 Jul 2022 09:14:53 +0800
Message-ID: <CAHj4cs960iq+KfSaCWCtm=xB3bNYNVkewLmZPpuaO66ZZ9nwXQ@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/005 trigered debugfs: Directory
 'hctx0' with parent '/' already present!
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Ming Lei <ming.lei@redhat.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220709_181511_819451_CA479610 
X-CRM114-Status: GOOD (  18.07  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Jul 9, 2022 at 11:19 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>
> On Sat, Jul 9, 2022 at 2:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 7/8/22 09:32, Yi Zhang wrote:
> > > I found below error log when I ran blktests nvme/ tests on aarch64
> > > with the latest linux-block/for-next,
> > > Please help check it, and feel free to let me know if you need any
> > > info/test for it, thanks.
> >
> > Is this 100% reproducible? I tried to reproduce this yesterday but
> > without success. See also
> Yes, it always can be reproduced at the second run of "nvme_trtype=tcp
> ./check nvme/005"
> I reproduced it on aarch64, not sure if it's arch related.

Just reproduced it on x86_64, so pls try to run two times for the test.


>
> > https://bugzilla.kernel.org/show_bug.cgi?id=216191.
> I tried block/001, and cannot reproduce it.
>
> >
> > Thanks,
> >
> > Bart.
>
> >
>
>
> --
> Best Regards,
>   Yi Zhang



-- 
Best Regards,
  Yi Zhang


