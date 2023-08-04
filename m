Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E91C04A94
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Aug 2023 10:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYiqSi4DodEOlaOomALCTsLyCZXw6UfvQ3KXAk6gbxE=; b=lKLQo5bQbrqEOevhn/Mi5/DvVw
	f8TSVT8kjC3EVgcO2DyDCAGA8zROtkdmzuSv9ZUAhIYhuwIRke4g1dCAMCWfZHOsmW/wsFvr0dBxU
	WCwfuppkBxa9zYlLBXkM3Cx4JftwuC6oDw/NEXZPYoMzmYaOmJaPYa3QaGhPg4d3sglDEb2xTD3ei
	GXNr9jwLP2zXOuaO6nw7YvNesMsfBh4RryIclvlWKeGPftG3/tM8yA+swaClusyyciVYozRgqGJ3W
	8GVzHIf9AJVVfIiI01Zs6/lO4SC6OJjRFBCzgsnNxOtwCQyY4xObtiG0DkifuXDy/eUB5Y0bBpnd3
	D8MSUJkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRs7d-00C8rN-2U;
	Fri, 04 Aug 2023 10:33:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRs7Y-00C8ou-15
	for linux-nvme@lists.infradead.org;
	Fri, 04 Aug 2023 10:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691145199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYiqSi4DodEOlaOomALCTsLyCZXw6UfvQ3KXAk6gbxE=;
	b=d13I2i1VkRXUCslG8rnxPlpNlyOF/v9IhXRTJ/bIMbEjHFhw8igAnu3D/vAP0zrL63wVyR
	gDwV7fl0XJUpdGQn4UguAXbyCl+iPH1uhF/t0USnPx1dgMr4e2xPSB7wffxT6T/tnEUUzb
	Var+mCWK3G7Ul0/4aLob4SdvQchTesA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-aQy-vCvfNoqhyrNYFJ04_Q-1; Fri, 04 Aug 2023 06:33:18 -0400
X-MC-Unique: aQy-vCvfNoqhyrNYFJ04_Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-268441d0e64so1598461a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 04 Aug 2023 03:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691145197; x=1691749997;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYiqSi4DodEOlaOomALCTsLyCZXw6UfvQ3KXAk6gbxE=;
        b=JP7cQRSQlY6nyD1Gl3h/ya/LLjDm2kEaH3GBTJZISHWUommMJNGVqCNxo9c4uEC5Nw
         ShJ+eTwzKVDHb/FCH/fABplzbO2n0rzApYypMFnRJuI0vmXU5N2yhlHmaZadzaGtRYg0
         dgRXVffSnGEbCorCOBYEFpyJrCkUZa0TuPKc/R2QXI+RNXA8v9SBv9GoEfL0nw0RV2WV
         U18buFzExii3706c7foUEo7C9BWxFHb4pizoklQcPJx/oQEfvo8NgsAJFj1vA1EKVP5b
         VFL39wU/ayrAw559Ip/anbjRXB57lp6tEHw871AxeFBX3NID8JlPAtcnebXurxmOeSxT
         GMbg==
X-Gm-Message-State: AOJu0YzmFKF2c2zc5tlMry5tQpGa43tAELOCmmlAcOnjw36fkwfPYZ9l
	TusV5ShMnYIbcEvDVc9R/L9Hh/QPVOMC0AE6EQ2mUx6zp5lPoU5zNYDyQF1WHefs0BI+l0m42X8
	Z3D0ucFmR/6HMAvNT1HYfCjmFmnL62gm+1HQ+hpMXz4w=
X-Received: by 2002:a17:90b:3b4f:b0:262:f06d:c0fc with SMTP id ot15-20020a17090b3b4f00b00262f06dc0fcmr1384840pjb.7.1691145197683;
        Fri, 04 Aug 2023 03:33:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF81eckYJqc1+gwa1EwjNj3rqlJJA6x/ZAxR713Dj1IuEDl9lZjyBwP8DHBTAaI45pg010f6iMGvfVyFgK4T4o=
X-Received: by 2002:a17:90b:3b4f:b0:262:f06d:c0fc with SMTP id
 ot15-20020a17090b3b4f00b00262f06dc0fcmr1384831pjb.7.1691145197391; Fri, 04
 Aug 2023 03:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
In-Reply-To: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 4 Aug 2023 18:33:04 +0800
Message-ID: <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230804_033324_467528_CCD1128C 
X-CRM114-Status: GOOD (  15.24  )
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

On Tue, Aug 1, 2023 at 7:28=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrote=
:
>
> Hello
>
> I found random nvme/047 failure on linux-block/for-next when I do
> stress blktests nvme/tcp nvme/047 test:

I tried to add one "sleep 0.05" after connecting that can workaround this i=
ssue.

>
> Kernel config: https://pastebin.com/6i3sZWAx
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D0
> nvme/047 (test different queue types for fabric transports)  [failed]
>     runtime  71.129s  ...  7.096s
>     --- tests/nvme/047.out 2023-07-16 23:04:30.052101710 -0400
>     +++ /root/blktests/results/nodev/nvme/047.out.bad 2023-07-19
> 09:17:35.949908134 -0400
>     @@ -1,2 +1,198 @@
>      Running nvme/047
>     +fio: looks like your file system does not support direct=3D1/buffere=
d=3D0
>     +fio: looks like your file system does not support direct=3D1/buffere=
d=3D0
>     +fio: looks like your file system does not support direct=3D1/buffere=
d=3D0
>     +fio: looks like your file system does not support direct=3D1/buffere=
d=3D0
>     +fio: destination does not support O_DIRECT
>     +fio: destination does not support O_DIRECT
>     ...
>     (Run 'diff -u tests/nvme/047.out
> /root/blktests/results/nodev/nvme/047.out.bad' to see the entire diff)
>
> After some investigating, I found it was due to the /dev/nvme0n1 node
> couldn't be created in time which lead to the following fio failing.
> + nvme connect -t tcp -a 127.0.0.1 -s 4420 -n blktests-subsystem-1
> --hostnqn=3Dnqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60=
b8de349
> --hostid=3D0f01fb42-9f7f-4856-b0b3-51e60b8de349 --nr-write-queues=3D1
> + ls -l /dev/nvme0 /dev/nvme-fabrics
> crw-------. 1 root root 234,   0 Aug  1 05:50 /dev/nvme0
> crw-------. 1 root root  10, 122 Aug  1 05:50 /dev/nvme-fabrics
> + '[' '!' -b /dev/nvme0n1 ']'
> + echo '/dev/nvme0n1 node still not created'
> dmesg:
> [ 1840.413396] loop0: detected capacity change from 0 to 10485760
> [ 1840.934379] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 1841.018766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 1846.782615] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> [ 1846.808392] nvme nvme0: creating 33 I/O queues.
> [ 1846.874298] nvme nvme0: mapped 1/32/0 default/read/poll queues.
> [ 1846.945334] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420
>
> BTW, I also found after disabling nvme_core.multipath, seems this
> issue cannot be reproduced.
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


