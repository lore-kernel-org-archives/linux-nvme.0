Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D408BC25B75
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EdiL1W942yteIR0yCjMIK01wFzdInXozA0Mm0m+zPBk=; b=HswMum+ZVLsZxAhjUbKe4L976C
	jsPESUQom5WAINSw4CI30MYop96Eg7yw3BfLrtqoHw7/pF+iYlvYAFiUqhco/hILRfNS6/NM39v3X
	bzskFA/To7nK9A45SOfMuFR8nkU1a+Tj6a121CUOX7im3M0QiCEz3YbJdUNivi/D+GRsNypJibA0+
	oitK86JJwgcuGgyXKAoUBbX1D1Iw6WJGUQeZYl1ey0eOrhSNRGUehOLiM15B8eyclEKXvE43PnQjY
	GQFZpOFkluYLWktG/WKGqHol/qKaN/mutPG6+vqcXDK7/YsSkvnnpVZzPZKC5RopTNPQ4z9gcNexK
	ogUf+nSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBOu6-0000000DX70-1hit;
	Mon, 27 May 2024 01:11:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBOtz-0000000DX6H-2Eav
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 01:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716772308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdiL1W942yteIR0yCjMIK01wFzdInXozA0Mm0m+zPBk=;
	b=QFDEI0kq0gGvJdi9SQ4YIWqiL2mtrqSD7Bq0RjjrB1HDnmZ1k+y6Qtk97U+7iUNc058pML
	5h1EWkXJSeoebxlF4dwOgfXsEFw7XTsiMs4VbbEt0Ia2gVasKJIPSWCVxtYT+WkQg/ikQR
	5qtoWMLOz8VpxJNwcth32PD0JBWbzQY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-q11r7r4MPIOVyIlyqA3UbA-1; Sun, 26 May 2024 21:11:46 -0400
X-MC-Unique: q11r7r4MPIOVyIlyqA3UbA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2bf8a8799f1so1090922a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 May 2024 18:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716772305; x=1717377105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdiL1W942yteIR0yCjMIK01wFzdInXozA0Mm0m+zPBk=;
        b=qOWxrGrs46G0f06yAlKdpdRaVzz3EgyUq60f6wO4yg+zvLLzYMa6pWoILELmNaF9/S
         P6J+fWVNfTAJBQP7h5t5aUY1uBd65qPskQxZgaKBynqaQBWMywcXCcKdnpWh/UVozc+r
         LQEZwmxETq7SW3VImCdxF2Lpj+CgBBHr6wONL+XiyJRHtyjJk/bI9vHcGMKP6NVXT71n
         7J2n0z/4fm+IOcH/ICLLhga+2YZfy3I5ctdGt6vbX2z6+cNXqKGNcGqxtmGO8DFHGouD
         EnO+C0XDfeOz+cA+u4eNavbRmhVN7W5fDCtLNATlZfDVGhxem536WfbrZEO1jer0nHnF
         ZhRw==
X-Gm-Message-State: AOJu0YyFCsD+QJ3732VbtELlX9L4YFydEg+lNI9loFN841KHSA8wLbxR
	C2vujY5FawsdBN0+bkzsVGrSGDXQ7ETZrkH63G9uEfq5V81cQSABXXCX7xo2zANbi1hqiuPSfRr
	IG6Eq0YBXQv7Owt4um7YUsMD79kwh0ptn3adaGuTwwUgJlGm7NfQkDG+LwKFxaTM022S6SXBchL
	Ls6oLc4TRhx6ff2vcoa50LAVzMqrl+OchF8R4nQLI=
X-Received: by 2002:a17:90a:cb0e:b0:2a7:455d:82db with SMTP id 98e67ed59e1d1-2bf5f74e103mr7284270a91.36.1716772305405;
        Sun, 26 May 2024 18:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+UnQKBvgPpocAKFhel74XHC62OwAtZNQ+SVTOIz8jyWczmTY3qSyC0YE9gaMXRTIZqWMTSM86WOmedmE7swA=
X-Received: by 2002:a17:90a:cb0e:b0:2a7:455d:82db with SMTP id
 98e67ed59e1d1-2bf5f74e103mr7284257a91.36.1716772304913; Sun, 26 May 2024
 18:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
In-Reply-To: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 27 May 2024 09:11:32 +0800
Message-ID: <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_181152_309507_C19BE014 
X-CRM114-Status: GOOD (  10.47  )
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

Yeah, I also met this leak during nvme/044

https://lore.kernel.org/linux-nvme/CAHj4cs-jM_46qK2n3g9vFguq7LVBSm1h38b6Sg_=
j5veubontWw@mail.gmail.com/

On Mon, May 27, 2024 at 3:49=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
> Just noticed that these tests generate a kmemleak complaint.
>
> --
> [ 1889.516324] kmemleak: 2 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [13221.498042] loop6: detected capacity change from 0 to 8
> ^C
> root@nvme:~# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff91488fb07200 (size 256):
>    comm "nvme", pid 29344, jiffies 4295069699
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 72 b0 8f 48 91 ff ff .........r..H...
>      08 72 b0 8f 48 91 ff ff 00 d6 55 a2 ff ff ff ff .r..H.....U.....
>    backtrace (crc 36f6c278):
>      [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
>      [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
>      [<ffffffffa2562fd0>] device_add+0x510/0x8c0
>      [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
>      [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
>      [<ffffffffc13b0af6>] 0xffffffffc13b0af6
>      [<ffffffffc120e565>] 0xffffffffc120e565
>      [<ffffffffa1edeb14>] vfs_write+0x104/0x490
>      [<ffffffffa1edf263>] ksys_write+0x73/0x100
>      [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
>      [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
>      [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
>      [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff91488ed7ea00 (size 256):
>    comm "nvme", pid 37478, jiffies 4295155857
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 08 ea d7 8e 48 91 ff ff ............H...
>      08 ea d7 8e 48 91 ff ff 00 d6 55 a2 ff ff ff ff ....H.....U.....
>    backtrace (crc fc1acf5):
>      [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
>      [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
>      [<ffffffffa2562fd0>] device_add+0x510/0x8c0
>      [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
>      [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
>      [<ffffffffc13707b7>] 0xffffffffc13707b7
>      [<ffffffffc120e565>] 0xffffffffc120e565
>      [<ffffffffa1edeb14>] vfs_write+0x104/0x490
>      [<ffffffffa1edf263>] ksys_write+0x73/0x100
>      [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
>      [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
>      [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
>      [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> --
>
> The culprit is when failing after device_initialize/cdev_device_add...
> Thought I'd share it as I'm not going to address it today.
>


--=20
Best Regards,
  Yi Zhang


