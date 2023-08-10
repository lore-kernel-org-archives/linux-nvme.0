Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D4FC001DE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97EnLhuROKiA5XU6sdqPiWoCqvYENz+CWlSWUkPCvf4=; b=AgZxg38+HqEGN1rxvBSBx4+knv
	n0SvW+HHGHhDCvWMuH3dOZK5j2JGIBjQuIwaCDT6rgRFs2rQCOXqWB8tKJPCv7nsK5bka3NbuPN1Y
	uvJTjbuBis3hoRVM+rFzFcJ335Zjvd6rB4mUa8WtrxMZCZ4PwpFSnw99p8AZyB4Jl14JuUPmQ/+eg
	wuwUBFAp3pyEC+uBUq98QmU5bTDLOp1Pm0tvRi6Wbb0Ekhw+rC/lv2L66O7HyHroAcHI5SVk5PikW
	I6NHZP1Bs8GG9sXvfLsrE/2iPO8PHgOljCLdkE/jw4HRNlNs1kWxgNiJt0/XbLmcBA3+j3DVB20B6
	aAg7sqUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU2nH-00762h-1P;
	Thu, 10 Aug 2023 10:21:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU2nE-00762C-2Q
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 10:21:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691662882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97EnLhuROKiA5XU6sdqPiWoCqvYENz+CWlSWUkPCvf4=;
	b=N1bxD7AIVsinxjdqSqgj1CN9yn5hISi8uhdijasODV8STOwNFsBSzrRBqLJ/NQM62qUciH
	ovFyPOtwA5SKwuK2IjsQcBByyoVS4ubdH36EUU+EfuZCEPhqpfgoCdAMcXflWxwKc6sq4+
	NcPptz8DlKXMJW5+fGkrsyGPrFviGlc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-qSzsKp44N6iVRHXxBityyA-1; Thu, 10 Aug 2023 06:21:21 -0400
X-MC-Unique: qSzsKp44N6iVRHXxBityyA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-269421d8b22so818881a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 10 Aug 2023 03:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691662880; x=1692267680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97EnLhuROKiA5XU6sdqPiWoCqvYENz+CWlSWUkPCvf4=;
        b=bhRG18O/bJMoeG8vH6NLhwIa3SR2PqeowcSWg1uR7RQtqcIpVKR3Cp7ggZIdbYgymx
         At6BQtrIpo7/cTK9V84lEUwop6+hDMdK+KBZ9jOS4xX5RydVf3S+0nzPOV2nK+8tzJiV
         MP9Ziy6i+iXs51GcWHWLewCBBm7sqncPziCgKzoREcsFY8waJopggA/II4Fa+4jJ0w8/
         McHlF35XBt5RFUel8okVSZdyKi2oJQ+o6tJefSRUCkBhPaS8uD7EYfVm+YWhM5z0y6nR
         kM63vlGdHa6pbfiF78NZEbbWKINbNiB2pJPD6j3NPDiHFGZO/uPBN2JjtLQB700b/Tp5
         Sd/A==
X-Gm-Message-State: AOJu0Yw21PBS6YaoXpu9bB1eRAsGyqdUwpjTEuUYU1fOdHvikdQ2DW6l
	TQy53Ba/7IxnLOgoo1653JzEDLeeEH+CwNse7vW8JgzbgwKWaVEV7YdhkJJIO5pjUwg84e+pOxp
	BZXhgwPKfFBXmpgw2ZwTq9FQ5WNctV+6nW+U1xUunro43rzsaQj2/ePqe17g=
X-Received: by 2002:a17:90a:9a4:b0:263:fc45:4091 with SMTP id 33-20020a17090a09a400b00263fc454091mr1361099pjo.15.1691662880261;
        Thu, 10 Aug 2023 03:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcHNBMvFDBk7y0QhwsuUlmRcVRHLwkbRLjYKPP87oSA7v3s9ExCPraMelKe7GWxlh/LHUGAO7F9bQzhjOj7kc=
X-Received: by 2002:a17:90a:9a4:b0:263:fc45:4091 with SMTP id
 33-20020a17090a09a400b00263fc454091mr1361090pjo.15.1691662879954; Thu, 10 Aug
 2023 03:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy> <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
In-Reply-To: <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 10 Aug 2023 18:21:07 +0800
Message-ID: <CAHj4cs8TBsEct9P6iiYwsiRhgCkPbdVL0-8KkXuKZbYhVsQV0Q@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
To: Daniel Wagner <dwagner@suse.de>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_032124_865689_7F46B3B5 
X-CRM114-Status: GOOD (  17.72  )
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

Hi Daniel/Shinichiro
Thanks for looking into this issue, I checked the 047 code, and we are
missing _find_nvme_dev after the second connect, and the below change
could fix this issue now.

diff --git a/tests/nvme/047 b/tests/nvme/047
index 6a7599b..8c0a024 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -52,6 +52,8 @@ test() {
                --nr-write-queues 1 \
                --nr-poll-queues 1 || echo FAIL

+       nvmedev=3D$(_find_nvme_dev "${subsys_name}")
+
        _run_fio_rand_io --filename=3D"/dev/${nvmedev}n1" --size=3D"${rand_=
io_size}"

        _nvme_disconnect_subsys "${subsys_name}" >> "$FULL" 2>&1


On Thu, Aug 10, 2023 at 5:18=E2=80=AFPM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> On Thu, Aug 10, 2023 at 12:19:39AM +0000, Shinichiro Kawasaki wrote:
> > Yi, could you try and see if it avoids the failure?
> >
> > diff --git a/tests/nvme/rc b/tests/nvme/rc
> > index 4f3a994..005db80 100644
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -740,7 +740,7 @@ _find_nvme_dev() {
> >               if [[ "$subsysnqn" =3D=3D "$subsys" ]]; then
> >                       echo "$dev"
> >                       for ((i =3D 0; i < 10; i++)); do
> > -                             if [[ -e /sys/block/$dev/uuid &&
> > +                             if [[ -e /dev/$dev && -e /sys/block/$dev/=
uuid &&
> >                                       -e /sys/block/$dev/wwid ]]; then
> >                                       return
> >                               fi
>
> The path for uuid is not correct. It's needs to be something like
>
>         if [[ -e /dev/$dev && -e /sys/block/"${dev}n1"/uuid &&
>                 -e /sys/block/"${dev}n1"/wwid ]]; then
>                         return
>         fi
>


--=20
Best Regards,
  Yi Zhang


