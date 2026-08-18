Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61ABCC5DF7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 15:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AsCSNGPzbndZ95SIcRx5D7YwOIyG5mzlVNBUva1QMck=; b=4ldGDeBuTJGFS2UGrSydnLbat2
	e37ji1vaFrjiYbuOfIDfBGC6spB4fmv4mgL46eNJxnFp+z9WGi3+OV3Y2d6m+nXxrMBEdifIhhuf/
	ODHbmn795YQH6IBIz5TzKVCeSzlG+3TaF/Q6GWdNeAoryv4DOVQeN0KqPQO0TpRmPcugrSAD+3tvN
	NvCK4g9RKHSSsPXfuA40oJem3KjHoShzO5FF+ASphQVOnw6Xpj+J2+GbWl1/Ll7o9ldLYkJt6ErMa
	0TZa7+AbngVHrFyf2uEEquJDnNw6UDyHWg1HGREmPe/ru3GXo8vrROryS8guVXB4AadKFfEMoC+VH
	MIaOIiWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwM1k-00000008IWe-2Qzd;
	Tue, 18 Aug 2026 15:47:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwM1h-00000008IWB-3XqZ
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 15:46:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787068016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsCSNGPzbndZ95SIcRx5D7YwOIyG5mzlVNBUva1QMck=;
	b=F2BncvUBzf4U1m+WiVtMiZZqyEoHqoaY9YXTcayISuXdm9bg6ytV+Ed6ST1oL9hOuQeIs5
	yQNuHR5z8eAZOODZxH3QRkB3gFBynOQt1hPzD1C4rL41XQHf6ZvM/dd1rbWxH4FzGPdoIy
	4WAOKcPf11WSgvIiYeK7EmuWZxQfg8M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-c6cQhTEfMjmjvHbhvIIzUQ-1; Tue, 18 Aug 2026 11:46:55 -0400
X-MC-Unique: c6cQhTEfMjmjvHbhvIIzUQ-1
X-Mimecast-MFC-AGG-ID: c6cQhTEfMjmjvHbhvIIzUQ_1787068014
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f6e658363so3033203f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2026 08:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068014; x=1787672814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AsCSNGPzbndZ95SIcRx5D7YwOIyG5mzlVNBUva1QMck=;
        b=AtxBHWl3Ot043JSE0GMRFLzws11eAVwAAR97mIIaY3mXXOk9gqbDqRefLqPD3KqZW3
         JtCb+Q0x3hw0nhKBHsGQIUxVm70x8JTslhJOHWymNkEYJOs8vKiRgYjH1D+N8xTyINQj
         yhZKeNTlZ4q6vpjG74uIrO3odSoaKPyc/MR/hqL3w3LBrcE0vEZbdtTxCQt5AwxzJoYU
         29qieAnCOVBgWlKKMI/sIWK3LL7Y5o5NGBN7CkTyoq9jK7moqMO0f0BJqrTDexxb48ax
         Z+1fUdcDx6RuQNukaN20A9r4b9UdMK4ND6z0DkGNXFv4GtfZ0s3D2H1emrNIK8hIoybN
         S2og==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Vf56/gjTEWcASwgs9japFyfVPoUkuG4XH403B/JjyZUXRGctzjZFYqMrN27iab3ht6SgOte9mEZa@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3guog6fr2Tm0LbGaiiPMVwnHhWhbfWky8l7wXmYZd4o+pLyqp
	xvW9VM0mzyj5wgWKScIHO6pMSABZeUKunlYxlvWqyAD9g/5vwdvglE/EXfdbZm2LL0tIgCaxTx+
	vx48xteuw8PjD5m4GleWRjiprvSJ4g/6H9RbkKn5gWVeGBU9VcbhnN6ZjVndxp56U0NzbTQpC9G
	T3cqaRF8bynm9q5EIQ5UEoIa0MQ2JxB/A89e6t9XNt3As=
X-Gm-Gg: AR+sD11FT8P9sSBmeaysBjjIcuiztVpNdi2/CTm/6PPKCGjuKAiOAoAdYwA/IAYNHfZ
	T1ScRwVsmF1k4p+9bJQZhJhDrhfToGLmqlMDKGZ89SIMrmkGAm7MeFtw5vPM0fpfrr3+OrCwGfd
	rXwRBbCyiFwg20Ooz98LmnacQCiz7LruC0WEv8zNFZXuOOZPfMRP8SxUx4ve1YJFITNL2FKl/v9
	W+okXSw6OQV5w9Gaw==
X-Received: by 2002:a05:6000:40c5:b0:482:aa0b:db55 with SMTP id ffacd0b85a97d-482aa0bdc7cmr15069115f8f.16.1787068013674;
        Tue, 18 Aug 2026 08:46:53 -0700 (PDT)
X-Received: by 2002:a05:6000:40c5:b0:482:aa0b:db55 with SMTP id
 ffacd0b85a97d-482aa0bdc7cmr15069018f8f.16.1787068013317; Tue, 18 Aug 2026
 08:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260812174503.3705830-1-jtaubepe@redhat.com> <an75bRJc8J6NexeH@shinmob>
 <CADRr4beUeZo9ZA9TZVmWQ9Vegm2LvTXkW0wGNxYA6_7z_njMEA@mail.gmail.com>
 <aoK5sfNpxIUz7C02@shinhome> <CADRr4bfXLi_EbQzL_Z-a1VfZmr61H2pbGcLtc8A0Huigd0sOfw@mail.gmail.com>
 <aoRXbzorRVt0Ri4O@shinhome>
In-Reply-To: <aoRXbzorRVt0Ri4O@shinhome>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Tue, 18 Aug 2026 11:46:42 -0400
X-Gm-Features: AcwNN1U-b8KYhh-RUCFS1X-HcFAQYZp79oKv4tW56WCr1i3jbw1Xqz0yDpdZFx8
Message-ID: <CADRr4bcab+iaS614Z6eL0kmiJefinU0X+6TzyThGYtmLfaezAw@mail.gmail.com>
Subject: Re: [PATCH blktests 0/2] Test multipath and marginal ports
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i4d3l5d_IWo9wauwF7bNxmJ2-hTkIqJ3h84UloR6lLk_1787068014
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_084657_963488_192A7EF8 
X-CRM114-Status: GOOD (  30.80  )
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

On Tue, Aug 18, 2026 at 9:05=E2=80=AFAM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Aug 17, 2026 / 15:33, Jesse Taube wrote:
> > On Mon, Aug 17, 2026 at 3:39=E2=80=AFAM Shin'ichiro Kawasaki
> > <shinichiro.kawasaki@wdc.com> wrote:
> ...
> > > After I rebased to v7.2 kernel, it shows a bit different message:
> > >
> > > nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [faile=
d]
> > >     runtime  37.200s  ...  38.926s
> > >     --- tests/nvme/070.out      2026-08-17 11:13:53.073000000 +0900
> > >     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out=
.bad       2026-08-17 16:34:17.997000000 +0900
> > >     @@ -3,10 +3,14 @@
> > >      Testing iopolicy: numa
> > >      Changing FC links to online
> > >      Set all online: pass
> > >     -One host marginal: pass
> > >     +FC port on (/sys/class/nvme-subsystem/nvme-subsys6/nvme6) is bei=
ng used, expected no use.
> > >     +One host marginal: fail
> > >      All marginal: pass
> > >     ...
> > >     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/res=
ults/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
> > >
> > > > Maybe the links are still connecting?
> > >
> > > Should I try to add some sleeps in the test script? If so, could you =
suggest
> > > where to put the sleeps?
> >
> > maybe add a delay before the cat command in _rport_in_use it might take=
 a second
> > for the io to move paths
>
> Thanks. I tried the patch below.
>
> diff --git a/tests/nvme/070 b/tests/nvme/070
> index 0672667..085ba70 100755
> --- a/tests/nvme/070
> +++ b/tests/nvme/070
> @@ -73,10 +73,16 @@ _rport_is_marginal() {
>
>  _rport_in_use() {
>         local SUBSYS_PATH=3D$1 # /sys/devices/virtual/nvme-subsystem/nvme=
-subsys3/nvme9
> +       local ret
>
>         # there should only be one "nvme3c9n1" afaik
>         [[ "$(cat "$SUBSYS_PATH"/nvme*/stat | awk '{print $9}')" !=3D "0"=
 ]]
>         # Returns exit code 0 if in use, 1 if not in use
> +       ret=3D$?
> +
> +       sleep 3
> +
> +       return $ret
>  }
>
>
> And I got this result:
>
> nvme/070 (tr=3Dfc) (test nvme-fc marginal path handling)       [failed]
>     runtime  34.657s  ...  224.569s
>     --- tests/nvme/070.out      2026-08-18 21:38:49.298000000 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev_tr_fc/nvme/070.out.bad=
       2026-08-18 21:49:55.655000000 +0900
>     @@ -5,39 +5,66 @@
>      Set all online: pass
>      One host marginal: pass
>      All marginal: pass
>     -One remote non-optimized online: pass
>     -Two remote non-optimized online: pass
>     +FC port on (/sys/class/nvme-subsystem/nvme-subsys5/nvme7) is not bei=
ng used, expected use.
>     +One remote non-optimized online: fail
>     ...
>     (Run 'diff -u tests/nvme/070.out /home/shin/Blktests/blktests/results=
/nodev_tr_fc/nvme/070.out.bad' to see the entire diff)
>
>
> The result look a bit better (One host marginal: pass), but still I see o=
ther
> items fail.
>
> >
> > > If it helps, I will share the kernel config I use. If you want it, pl=
ease let
> > > me know.
> >
> > That would be good.
>
> Okay, please find the kernel config attached.
>
> > Im using the base centos10 config with
> > https://github.com/Mr-Bossman/linux/tree/dev/jesse/fpin_v11k
>
> Thanks, will try it out later.

No need to test i figured out the issue, it is a timeing thing. I will
send changes soon

Thanks,
Jesse Taube


