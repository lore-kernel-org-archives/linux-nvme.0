Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90826C5DF66
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkJj2JcDlUPOQbYD6rVCALNPgZi2ktrvt0VeFhD7xJQ=; b=mxk8tdHTjBtjLvy4Qw7L+Vi79y
	ZpWPi624Zw5yNNveuKnIWoaJLYtrqqO9PVRH41fIIpGv0LQSy6Ri5g60cR9zpaOEYeUCbXs9iN8a+
	gKwaiVgXCY3NgsnrOBsWgj2Najkr66rFw0zcokpkmiY2hyY2Kl3b1Id4/+X/OaUO8EKDiWwul/OZy
	+JyEJjsoeaoFla2ThSg59LrSCFYeM4tf/fViWIz/AJrDD0Y+lv4L/9ZodseiyXaiQIVObwhh97Ln4
	RN7L42y6009xTWVPe/zu8OpB42wtIIX/UoSDmc6Pu5jd+mlzGQ8omRhVexSXv+PjUVJxIUW55YkYv
	D05AqLcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww360-00000006j6G-42V2;
	Mon, 17 Aug 2026 19:34:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ww35u-00000006j5t-2qWj
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 19:34:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786995239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkJj2JcDlUPOQbYD6rVCALNPgZi2ktrvt0VeFhD7xJQ=;
	b=eM6bo+2/oNBOe30+RSM+TGeo7hNePdqlYbpQuEMxCRDD4hOcW/d9UCCco7gekg/dJD+X/6
	8YtrVqXM2e6QWhut6KUK5/CqjMhXYhOy/Fq+pj0qsk0oceehIJi6EZ+YThFdJKtbB3H3zZ
	DpZpNB1x9kxDmlmyVjthXPMoQdwDr4c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-oX0Hm7ADPGuQSsfaZNvDrQ-1; Mon, 17 Aug 2026 15:33:57 -0400
X-MC-Unique: oX0Hm7ADPGuQSsfaZNvDrQ-1
X-Mimecast-MFC-AGG-ID: oX0Hm7ADPGuQSsfaZNvDrQ_1786995236
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4955843c6cdso35975535e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2026 12:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786995236; x=1787600036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkJj2JcDlUPOQbYD6rVCALNPgZi2ktrvt0VeFhD7xJQ=;
        b=bHAR0LNnyEom5qEpoZ7OgJsqKkotFsZqzT7JUTb7Nb59ecvW7SSBdVn/vSYmygkfyA
         dziMaUvU7ie2RJELZJ6sIJkjmi29W5Zu9Z+E7MvQYRx0hjm/V1SJZ0nkQph2ktd5zRzX
         z3jT4BKJ+h+OMdwFhFFsdVWmKsMbb2TU2XDCDCEDaAYWFqkMXpXPGbTDXeYKSYri6TP2
         BreTcNA32QcJIt/HX+LcKjIRkEGNSZK0O/MPTy6eGptptujLtSqE4IZoiDfxJnwTo9el
         f6jb4x4k7gTCUtu2yoY/6Cmwvs84FYZRg2OMrIwDTBx9fqVIAUJHL58rCJ0t1tRVmzw+
         0lhQ==
X-Forwarded-Encrypted: i=1; AHgh+RobZOVc72ODVFU2DRcv0Ef/onAhx0JLJlUJb0HyJJBXfNIrnV7f4REhNtvJ2DkvVVEI5SPMfICgigcI@lists.infradead.org
X-Gm-Message-State: AOJu0Yx77HGiswjyKhU4VMZ4qA3bLJyn9MRE+JcxBfhzHgqig5lKyTkc
	n50skMWCzj0ywSdoV1Ie565ugR68EF+GF0yXJUGilID48b9A15EH4AwFAfqxBGFIByoHUkQzhFi
	/ThSgUaE6jGmt6gMUBcILoL4ahN47LSebNDm8Fuk+ac1tA6KUuJO599j72Hal/KbRDe8vwsLHvV
	swJFP4Brs+/m1aB4MDteDI4dMCWTKZFZHDFj49Y+9WpJc=
X-Gm-Gg: AR+sD134PZNZF+Bm1V2UoMPN7KGVWmEXeZTFFkWkQZ5jupMeVTST6hQoqCNuy4iGJYy
	Mt3b0n6z/UaNYT3r6o8/HD41zEXlnDaMFcPdqYVKqru/r4X3fomzyGVnL23dtWsLRvXjLP7aGU4
	4c5eVHLPGtcJCXAEohaeHhVHOK9/uPbE8VOH3j5FipAVa6ts1NW8DE799ufZi+5+HhQ1eAA4R2t
	R7QmTwv52OVjdpnfA==
X-Received: by 2002:a05:600c:3b8e:b0:499:a0f3:9d5c with SMTP id 5b1f17b1804b1-499a0f3a47bmr12732685e9.3.1786995236054;
        Mon, 17 Aug 2026 12:33:56 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8e:b0:499:a0f3:9d5c with SMTP id
 5b1f17b1804b1-499a0f3a47bmr12732225e9.3.1786995235695; Mon, 17 Aug 2026
 12:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260812174503.3705830-1-jtaubepe@redhat.com> <an75bRJc8J6NexeH@shinmob>
 <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com> <aoK5sfNpxIUz7C02@shinhome>
In-Reply-To: <aoK5sfNpxIUz7C02@shinhome>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 17 Aug 2026 15:33:44 -0400
X-Gm-Features: AcwNN1U_VZTy9a8fJk48fdV_hK07jAcQCVb6Zq1f-ghl9ACCE-z76QTZw-W5I1o
Message-ID: <CADRr4bfXLi_EbQzL_Z-a1VfZmr61H2pbGcLtc8A0Huigd0sOfw@mail.gmail.com>
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OOiVjRHvIXBz1FC6AIhL9BWQgHy5iLHyBnUl9V8wG50_1786995236
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_123402_798371_A9A39048 
X-CRM114-Status: GOOD (  21.57  )
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

On Mon, Aug 17, 2026 at 3:39=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 14, 2026 / 10:18, Jesse Taube wrote:
> ...
> > > I applied the series on top of v7.2-rc7 kernel. Then I ran the test c=
ase added
> > > by this blktests series and observed the failurea below:
> > >
> > > nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [faile=
d]
> > >     runtime  33.581s  ...  33.028s
> > >     --- tests/nvme/070.out      2026-08-14 12:03:21.338000000 +0900
> > >     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out=
.bad       2026-08-14 20:17:04.731000000 +0900
> > >     @@ -2,7 +2,8 @@
> > >      Starting background I/O
> > >      Testing iopolicy: numa
> > >      Changing FC links to online
> > >     -Set all online: pass
> > >     +No FC ports are being used, expected atleast one in use when all=
 are online in numa mode.

This is should pass even without my patches. I had this happen once
when a link got stuck in connecting.
it could be solved by adding a longer delat after _run_fio_verify_io
as it sometimes takes a bit to connect

> > >     +Set all online: fail
> > >      One host marginal: pass
> > >     ...
> > >     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/res=
ults/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
> > >
> > > Is this failure expected?
> >
> > No. I can't reproduce the issue either.
> > Does this happen consistently?
>
> Yes, it happnes always I run the test case.
> After I rebased to v7.2 kernel, it shows a bit different message:
>
> nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [failed]
>     runtime  37.200s  ...  38.926s
>     --- tests/nvme/070.out      2026-08-17 11:13:53.073000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad=
       2026-08-17 16:34:17.997000000 +0900
>     @@ -3,10 +3,14 @@
>      Testing iopolicy: numa
>      Changing FC links to online
>      Set all online: pass
>     -One host marginal: pass
>     +FC port on (/sys/class/nvme-subsystem/nvme-subsys6/nvme6) is being u=
sed, expected no use.
>     +One host marginal: fail
>      All marginal: pass
>     ...
>     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results=
/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
>
> > Maybe the links are still connecting?
>
> Should I try to add some sleeps in the test script? If so, could you sugg=
est
> where to put the sleeps?

maybe add a delay before the cat command in _rport_in_use it might take a s=
econd
for the io to move paths

> If it helps, I will share the kernel config I use. If you want it, please=
 let
> me know.

That would be good. Im using the base centos10 config with
https://github.com/Mr-Bossman/linux/tree/dev/jesse/fpin_v11k

Thanks,
Jesse Taube


