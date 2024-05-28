Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D96C25B78
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 09:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MtA3pteLQYIW/uPbjHG6b40VYEth6jxDDC1cgAuAWFY=; b=q6fTPkRpVjOGH0j5ZlwS3JmXJq
	gb/SfHEevdIyj689BdD9jE2pU7TinYIxmHCH5NEdFkhV7GPISte9yAPWUXSoQ1Kem1d89OTBxkfK4
	P8ASIUDEZJQaRQ9Vq5trb6zeQgn0bNCq7o1463cXKWXBOPAHpzNuYXpeAQjLq1raNjqdvb8k2kYhW
	gny1cRilLz7O+dxPG3A/6/PG5sHEtDnSl681PgF9B4yAIk5TZL1eY7RwjjKveDBEK6PU7CMhqQBWI
	VezssvWSeqThh2Da8EkuvxMFf/k4kUOG/j9r6X1DZmBZrH+lkNFlFXefudH8qd0MQqIK5m+d9tSm2
	WE1+Qt3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBtOU-000000005XC-0Z3R;
	Tue, 28 May 2024 09:45:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBtOR-000000005Vx-2ql9
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 09:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716889515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtA3pteLQYIW/uPbjHG6b40VYEth6jxDDC1cgAuAWFY=;
	b=PHwQUniNchj8zCCh520InPEQ4GKVli+1fWzOx7Wtc8BhdcRb2b1NPK36rSP7evBSo+HE4C
	4ZXN3ZKRtJLK8Bln1eU/crMOK5w7LLT69dJw48r3F4cq70bWuPJfOYQjEWJWDow8GRXSbl
	y/E9Zb1HQm8YPFQUAT9Ds5OWhYmtsUI=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-3vHkv4cJMze_8HPowBZHRg-1; Tue, 28 May 2024 05:45:13 -0400
X-MC-Unique: 3vHkv4cJMze_8HPowBZHRg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-48a331bf0b8so213946137.2
        for <linux-nvme@lists.infradead.org>; Tue, 28 May 2024 02:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889513; x=1717494313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtA3pteLQYIW/uPbjHG6b40VYEth6jxDDC1cgAuAWFY=;
        b=jKOVn4gZbmCiX4S5iz6NA/O0QaKNYeSVlvpXek2qOqPAg6aIH1i6RR02Wup9W4kxhH
         5fFfTOtB83d8x21fNdxdCWbozvytiN7kTqPmAacCmTP5DytpwJiW7dXBPw2U7Qt3ljPw
         WV4SRCYT2BPALoQdG1fFOJYJtHioGjxvZsllv4aUT5kf+60NFXKW1wlhR4wjx5iamqEy
         XdsXwlliYPb6DMHwKxZobQV1/Fx5x5Z/mPeVKBF2aWaLexNxLlvk8J6i9qzwL0uETnCs
         i0fwSRX+VAtF6zpocFOlrPm+mL8Iuzeyksk7jk+b5sMaXqQ9LexvbwnkR32U1xjX4uOG
         17Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8oCv01wpPkJLraEdqHkL6nT/LRt77zHfwxmeDbQ5++NG0Xvza+/e3Tsnd9Jvaznhtjr96MMe6GIHKbMnyjpW9062RsmMuGF1u3aoUn8=
X-Gm-Message-State: AOJu0Yzzyq/GRSwlWcmV5QA2DCJsRgmjB+jzU2IAJSapWYaTn4a/bmdA
	fz6BfAaRmbzxszVY4+QrK8vPtHTGwKgRK5QpT0qJeoEiRfAIrwseQpfHi8Q5Q32/v5D4BhynF3d
	fQICiavadcSlqCeSmq5/hi9q2XvzPPC/lmUZ9GDMsW4jkoa6ZIhv380XvvPrQCkB41pX0l+u2Wt
	ZRiWLLDjWTZ+3YQ2twzBLp2TB8PCDrIpzaiYU6eEU=
X-Received: by 2002:a67:f24a:0:b0:47f:122d:4ea2 with SMTP id ada2fe7eead31-48a3865b798mr10820272137.31.1716889512496;
        Tue, 28 May 2024 02:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXbHT1DBUFt+s81DCHSO2V1YGQvjex+wT0OZcp+aYHYx9id5J+EPlIa/xCnQy/NGR2So+HrsAmbYBWCCUMHzI=
X-Received: by 2002:a67:f24a:0:b0:47f:122d:4ea2 with SMTP id
 ada2fe7eead31-48a3865b798mr10820242137.31.1716889511371; Tue, 28 May 2024
 02:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me> <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
In-Reply-To: <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 28 May 2024 11:44:59 +0200
Message-ID: <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_024519_816246_E41F9ABB 
X-CRM114-Status: GOOD (  15.56  )
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

This happens because if the nvme_init_ctrl() function fails, the
callers assume that put_device() isn't necessary
and just execute kfree() against the ctrl structure.

This patch fixes the problem for TCP, it should also work for loop but
I've not tested it.

http://bsdbackstore.eu/misc/0001-nvme-fix-memory-leak-when-nvme_init_ctrl-f=
ails.patch

--=20
2.43.0

po 27. 5. 2024 v 3:12 odes=C3=ADlatel Yi Zhang <yi.zhang@redhat.com> napsal=
:
>
> Yeah, I also met this leak during nvme/044
>
> https://lore.kernel.org/linux-nvme/CAHj4cs-jM_46qK2n3g9vFguq7LVBSm1h38b6S=
g_j5veubontWw@mail.gmail.com/
>
> On Mon, May 27, 2024 at 3:49=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> =
wrote:
> >
> > Just noticed that these tests generate a kmemleak complaint.
> >
> > --
> > [ 1889.516324] kmemleak: 2 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [13221.498042] loop6: detected capacity change from 0 to 8
> > ^C
> > root@nvme:~# cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffff91488fb07200 (size 256):
> >    comm "nvme", pid 29344, jiffies 4295069699
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 08 72 b0 8f 48 91 ff ff .........r..H...
> >      08 72 b0 8f 48 91 ff ff 00 d6 55 a2 ff ff ff ff .r..H.....U.....
> >    backtrace (crc 36f6c278):
> >      [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
> >      [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
> >      [<ffffffffa2562fd0>] device_add+0x510/0x8c0
> >      [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
> >      [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
> >      [<ffffffffc13b0af6>] 0xffffffffc13b0af6
> >      [<ffffffffc120e565>] 0xffffffffc120e565
> >      [<ffffffffa1edeb14>] vfs_write+0x104/0x490
> >      [<ffffffffa1edf263>] ksys_write+0x73/0x100
> >      [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
> >      [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
> >      [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
> >      [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > unreferenced object 0xffff91488ed7ea00 (size 256):
> >    comm "nvme", pid 37478, jiffies 4295155857
> >    hex dump (first 32 bytes):
> >      00 00 00 00 00 00 00 00 08 ea d7 8e 48 91 ff ff ............H...
> >      08 ea d7 8e 48 91 ff ff 00 d6 55 a2 ff ff ff ff ....H.....U.....
> >    backtrace (crc fc1acf5):
> >      [<ffffffffa2b8b46a>] kmemleak_alloc+0x4a/0x90
> >      [<ffffffffa1e57897>] kmalloc_trace+0x2f7/0x3a0
> >      [<ffffffffa2562fd0>] device_add+0x510/0x8c0
> >      [<ffffffffa1ee5b9e>] cdev_device_add+0x4e/0xc0
> >      [<ffffffffc133b7a0>] nvme_init_ctrl+0x360/0x460 [nvme_core]
> >      [<ffffffffc13707b7>] 0xffffffffc13707b7
> >      [<ffffffffc120e565>] 0xffffffffc120e565
> >      [<ffffffffa1edeb14>] vfs_write+0x104/0x490
> >      [<ffffffffa1edf263>] ksys_write+0x73/0x100
> >      [<ffffffffa1edf319>] __x64_sys_write+0x19/0x30
> >      [<ffffffffa1a0553e>] x64_sys_call+0x7e/0x25c0
> >      [<ffffffffa2b7be01>] do_syscall_64+0x71/0x130
> >      [<ffffffffa2c0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > --
> >
> > The culprit is when failing after device_initialize/cdev_device_add...
> > Thought I'd share it as I'm not going to address it today.
> >
>
>
> --
> Best Regards,
>   Yi Zhang
>
>


