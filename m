Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078E5C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 07:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SY1fJAl5qprIF7myjXkJbWCE4tmLz1w5j+Vf1UY9FVw=; b=4iq66QvnCZ/bShMDFc8Ir8gbQi
	2EeYGLc4YH8Xt/9obOhE12+haWVTOzO66Vr6kbddlbcYuHoweaM3ywGy37q++fOlQ7MX8GnynuV3h
	xma2NmnKNqSK/Y0s/yFcZxymz464UVlq08EDZT3CzeItDilvW9Z80NTKGu95fvH1SRBPvD8DfZ8hS
	mC1j/dNwdaXdsST92RMjIsIrAiQt4rR+jd/KTk4GU+KUvShCYPZ94UGSnyBtY85E1i2la3soqHp9k
	86MmmxGhNj46CPtAIKxMUyXDjLXPMluELhjjFf+yREQ4gveJ97MFuxr1gxES8u8IQHf1pi4fs/NB1
	tYH7O7mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prwEP-005hgH-0s;
	Thu, 27 Apr 2023 07:39:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prwEL-005hfV-39
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 07:39:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1682581192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SY1fJAl5qprIF7myjXkJbWCE4tmLz1w5j+Vf1UY9FVw=;
	b=GCLQFrwYppyrhIKD0hRcCqj0+UI+1R/kIMuUPTxeHxM1sd7kb+X31Hjf8g/+I9yMXqZ8xm
	VPdtMdGSjSqtVCfdYBzB3ixVHR4mc4PkqGNTFxvdfwuGvLHp53jCKcJB9lpfvjG2R98n//
	IwkgOpHL+QO1KsH98Nj+DP/j6W8khbM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-7t1bz-N-NX6FQHnLiTu9dQ-1; Thu, 27 Apr 2023 03:39:51 -0400
X-MC-Unique: 7t1bz-N-NX6FQHnLiTu9dQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-63b66a3275eso5521791b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 00:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682581189; x=1685173189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SY1fJAl5qprIF7myjXkJbWCE4tmLz1w5j+Vf1UY9FVw=;
        b=GPFmkAO093uKhwX4akZoyq4BhOkX5HxduZTiADlsGr++kpkLlpRLESJ4ZNCDGfQErh
         LFFIy+6OnvgIZE9XExorMKmwZaCfJlL63w2Z4i43ViV+MikfKias1Xy5HaoimWc1eq6N
         atzfz7t3V/+6XpJoSo2ORMyoqPml/rzKz88yhecZ89o/M3t4NBRpqzTA2P1DU9ekFO+V
         gSwyIbSNxdJZEoDVrasBnq+HznnkybjxkFpC5aNWzNwEIAUkEOOp3h91mI+TVhtdK7TV
         6yKKmwAj3ok6Tema/29YvPpOEbxOhFOBDpQUf7pfCMoHLXkluNt5NulSZbm14ieD4QRM
         rLIw==
X-Gm-Message-State: AC+VfDyadRLt7ZDr6rbiNLMtHOUfh8THFblhClCGwBo/Tox5xr7MH5HC
	AVnz9PXfNI5PRxPjCsPzf9dyEBblWHfq1KlDCQbGQhXVDCxnkQ+dM51+gHpWy/glEOPxYBy82Pu
	EzXC0swInSyJt9RTVM4uRA+128sH/dXaX+ygeOn8qI3Y=
X-Received: by 2002:a05:6a20:2d14:b0:f5:e533:4dbf with SMTP id g20-20020a056a202d1400b000f5e5334dbfmr697813pzl.55.1682581189598;
        Thu, 27 Apr 2023 00:39:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZaXGHHWS9lCK+rm9XvG+9eFrC4Py3cWvLgoIoqmUtS11he6Qa7XWpmucUcChQLQuo0ZU3aPTWHkshr3ImWHI=
X-Received: by 2002:a05:6a20:2d14:b0:f5:e533:4dbf with SMTP id
 g20-20020a056a202d1400b000f5e5334dbfmr697786pzl.55.1682581189229; Thu, 27 Apr
 2023 00:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-nDaKzMx2txO4dbE+Mz9ePwLtU0e3egz+StmzOUgWUrA@mail.gmail.com>
 <6e06dffd-e9a1-da5a-023f-ac68a556692f@grimberg.me> <CAHj4cs99us_r4Ebth5oAJMqHHA9aXZCpq0A3uu1BEdNw2GeRww@mail.gmail.com>
 <f74df8a4-03c6-6687-7ada-35aa268f44b9@nvidia.com> <763959d1-8876-31f0-25ee-57ddb2049c75@nvidia.com>
 <CAHj4cs_urWYi_yPQ-FoFo2kV4h1gz-mwxfRiOTj7co3=bUnO5w@mail.gmail.com>
In-Reply-To: <CAHj4cs_urWYi_yPQ-FoFo2kV4h1gz-mwxfRiOTj7co3=bUnO5w@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 27 Apr 2023 15:39:37 +0800
Message-ID: <CAHj4cs-MtUM=7w=YG2ohATeA1HSZp_5CT1Y9DATDEqPPMZ8MMw@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed during blktests nvme-tcp
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_003954_166585_ECCE4705 
X-CRM114-Status: GOOD (  16.83  )
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

oops, the kmemleak still exists:

# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8882a4cc6000 (size 4096):
  comm "kworker/u32:6", pid 116, jiffies 4294699939 (age 1614.355s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 03 10 03 1f 00 00 00  ................
  backtrace:
    [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
    [<ffffffffc08cc68e>] nvme_identify_ns+0xae/0x230 [nvme_core]
    [<ffffffffc08cc8b9>] nvme_ns_info_from_identify+0x99/0x4a0 [nvme_core]
    [<ffffffffc08e0696>] nvme_scan_ns+0x1b6/0x460 [nvme_core]
    [<ffffffffc08e0ae2>] nvme_scan_ns_list+0x192/0x4f0 [nvme_core]
    [<ffffffffc08e1271>] nvme_scan_work+0x2f1/0xa30 [nvme_core]
    [<ffffffff85e98629>] process_one_work+0x8b9/0x1550
    [<ffffffff85e9987c>] worker_thread+0x5ac/0xed0
    [<ffffffff85eb2902>] kthread+0x2a2/0x340
    [<ffffffff85c062cc>] ret_from_fork+0x2c/0x50
unreferenced object 0xffff88829782bc00 (size 512):
  comm "nvme", pid 1539, jiffies 4294914967 (age 1399.449s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff a0 73 bf 8d ff ff ff ff  .........s......
  backtrace:
    [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
    [<ffffffff873658c5>] device_add+0x645/0x12f0
    [<ffffffff867c38e3>] cdev_device_add+0xf3/0x230
    [<ffffffffc08c77c6>] nvme_init_ctrl+0xbe6/0x1140 [nvme_core]
    [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
    [<ffffffffc0d38177>] 0xffffffffc0d38177
    [<ffffffffc0d38613>] 0xffffffffc0d38613
    [<ffffffff867b5056>] vfs_write+0x216/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff88824216a880 (size 96):
  comm "nvme", pid 1539, jiffies 4294914968 (age 1399.448s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
    [<ffffffff87395fa0>] dev_pm_qos_update_user_latency_tolerance+0xe0/0x20=
0
    [<ffffffffc08c783c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
    [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
    [<ffffffffc0d38177>] 0xffffffffc0d38177
    [<ffffffffc0d38613>] 0xffffffffc0d38613
    [<ffffffff867b5056>] vfs_write+0x216/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8881b00f4900 (size 64):
  comm "check", pid 1587, jiffies 4294922730 (age 1391.686s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 79 68 33 70 6f 45  DHHC-1:00:yh3poE
    61 47 37 31 68 45 69 2f 33 42 41 75 54 2f 61 6c  aG71hEi/3BAuT/al
  backtrace:
    [<ffffffff86564d3b>] __kmalloc+0x4b/0x190
    [<ffffffffc08d5841>] nvme_ctrl_dhchap_secret_store+0x111/0x360 [nvme_co=
re]
    [<ffffffff869ce038>] kernfs_fop_write_iter+0x358/0x530
    [<ffffffff867b5642>] vfs_write+0x802/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8882b4567700 (size 64):
  comm "check", pid 1587, jiffies 4294922738 (age 1391.678s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 79 68 33 70 6f 45  DHHC-1:00:yh3poE
    61 47 37 31 68 45 69 2f 33 42 41 75 54 2f 61 6c  aG71hEi/3BAuT/al
  backtrace:
    [<ffffffff86564d3b>] __kmalloc+0x4b/0x190
    [<ffffffffc08d5841>] nvme_ctrl_dhchap_secret_store+0x111/0x360 [nvme_co=
re]
    [<ffffffff869ce038>] kernfs_fop_write_iter+0x358/0x530
    [<ffffffff867b5642>] vfs_write+0x802/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff8882b6fbe000 (size 512):
  comm "nvme", pid 1934, jiffies 4294932235 (age 1382.239s)
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff a0 73 bf 8d ff ff ff ff  .........s......
  backtrace:
    [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
    [<ffffffff873658c5>] device_add+0x645/0x12f0
    [<ffffffff867c38e3>] cdev_device_add+0xf3/0x230
    [<ffffffffc08c77c6>] nvme_init_ctrl+0xbe6/0x1140 [nvme_core]
    [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
    [<ffffffffc0d38177>] 0xffffffffc0d38177
    [<ffffffffc0d38613>] 0xffffffffc0d38613
    [<ffffffff867b5056>] vfs_write+0x216/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff888288a53b80 (size 96):
  comm "nvme", pid 1934, jiffies 4294932237 (age 1382.237s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
    [<ffffffff87395fa0>] dev_pm_qos_update_user_latency_tolerance+0xe0/0x20=
0
    [<ffffffffc08c783c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
    [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
    [<ffffffffc0d38177>] 0xffffffffc0d38177
    [<ffffffffc0d38613>] 0xffffffffc0d38613
    [<ffffffff867b5056>] vfs_write+0x216/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff88829e6a3b80 (size 64):
  comm "check", pid 1981, jiffies 4294936167 (age 1378.307s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 61 56 6f 56 44 4f  DHHC-1:00:aVoVDO
    79 69 31 6c 59 33 74 79 77 47 33 6a 4f 6e 37 33  yi1lY3tywG3jOn73
  backtrace:
    [<ffffffff86564d3b>] __kmalloc+0x4b/0x190
    [<ffffffffc08d5841>] nvme_ctrl_dhchap_secret_store+0x111/0x360 [nvme_co=
re]
    [<ffffffff869ce038>] kernfs_fop_write_iter+0x358/0x530
    [<ffffffff867b5642>] vfs_write+0x802/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
unreferenced object 0xffff88829e6a3a80 (size 64):
  comm "check", pid 1981, jiffies 4294936885 (age 1377.589s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 61 56 6f 56 44 4f  DHHC-1:00:aVoVDO
    79 69 31 6c 59 33 74 79 77 47 33 6a 4f 6e 37 33  yi1lY3tywG3jOn73
  backtrace:
    [<ffffffff86564d3b>] __kmalloc+0x4b/0x190
    [<ffffffffc08d5841>] nvme_ctrl_dhchap_secret_store+0x111/0x360 [nvme_co=
re]
    [<ffffffff869ce038>] kernfs_fop_write_iter+0x358/0x530
    [<ffffffff867b5642>] vfs_write+0x802/0xc60
    [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
    [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
    [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc


On Thu, Apr 27, 2023 at 3:24=E2=80=AFPM Yi Zhang <yi.zhang@redhat.com> wrot=
e:
>
> Hi Chaitanya
>
> The kmemleak in [1] is fixed by your patch, but there still has
> one[2], would you mind checking it, thanks.
>
> [1]
> nvme_ctrl_dhchap_secret_store
> cdev_device_add
>
> [2]
> unreferenced object 0xffff888288a53b80 (size 96):
>   comm "nvme", pid 1934, jiffies 4294932237 (age 237.359s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff86564437>] kmalloc_trace+0x27/0xe0
>     [<ffffffff87395fa0>] dev_pm_qos_update_user_latency_tolerance+0xe0/0x=
200
>     [<ffffffffc08c783c>] nvme_init_ctrl+0xc5c/0x1140 [nvme_core]
>     [<ffffffffc1ab0e0c>] 0xffffffffc1ab0e0c
>     [<ffffffffc0d38177>] 0xffffffffc0d38177
>     [<ffffffffc0d38613>] 0xffffffffc0d38613
>     [<ffffffff867b5056>] vfs_write+0x216/0xc60
>     [<ffffffff867b62e9>] ksys_write+0xf9/0x1d0
>     [<ffffffff881adc4c>] do_syscall_64+0x5c/0x90
>     [<ffffffff882000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> On Wed, Apr 26, 2023 at 4:34=E2=80=AFPM Chaitanya Kulkarni
> <chaitanyak@nvidia.com> wrote:
> >
> > On 4/26/23 01:23, Chaitanya Kulkarni wrote:
> > >
> > >>>> [<ffffffff86f646ab>] __kmalloc+0x4b/0x190
> > >>>>       [<ffffffffc09fb710>]
> > >>>> nvme_ctrl_dhchap_secret_store+0x110/0x350 [nvme_core]
> > >>>>       [<ffffffff873cc848>] kernfs_fop_write_iter+0x358/0x530
> > >>>>       [<ffffffff871b47d2>] vfs_write+0x802/0xc60
> > >>>>       [<ffffffff871b5479>] ksys_write+0xf9/0x1d0
> > >>>>       [<ffffffff88ba8f9c>] do_syscall_64+0x5c/0x90
> > >>>>       [<ffffffff88c000aa>] entry_SYSCALL_64_after_hwframe+0x72/0xd=
c
> > >
> > > can you check if following fixes your problem for dhchap ?
> > >
> > >
> > > linux-block (for-next) # git diff
> > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > index 1bfd52eae2ee..0e22d048de3c 100644
> > > --- a/drivers/nvme/host/core.c
> > > +++ b/drivers/nvme/host/core.c
> > > @@ -3825,8 +3825,10 @@ static ssize_t
> > > nvme_ctrl_dhchap_secret_store(struct device *dev,
> > >                 int ret;
> > >
> > >                 ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> > > -               if (ret)
> > > +               if (ret) {
> > > +                       kfree(dhchap_secret);
> > >                         return ret;
> > > +               }
> > >                 kfree(opts->dhchap_secret);
> > >                 opts->dhchap_secret =3D dhchap_secret;
> > >                 host_key =3D ctrl->host_key;
> > > @@ -3879,8 +3881,10 @@ static ssize_t
> > > nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
> > >                 int ret;
> > >
> > >                 ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> > > -               if (ret)
> > > +               if (ret) {
> > > +                       kfree(dhchap_secret);
> > >                         return ret;
> > > +               }
> > >                 kfree(opts->dhchap_ctrl_secret);
> > >                 opts->dhchap_ctrl_secret =3D dhchap_secret;
> > >                 ctrl_key =3D ctrl->ctrl_key;
> > >
> > > -ck
> > >
> > >
> >
> > sorry my forget to add ida changes, plz ignore earlier and try this :-
> >
> > linux-block (for-next) # git diff
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 1bfd52eae2ee..bb376cc6a5a3 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3825,8 +3825,10 @@ static ssize_t
> > nvme_ctrl_dhchap_secret_store(struct device *dev,
> >                  int ret;
> >
> >                  ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> > -               if (ret)
> > +               if (ret) {
> > +                       kfree(dhchap_secret);
> >                          return ret;
> > +               }
> >                  kfree(opts->dhchap_secret);
> >                  opts->dhchap_secret =3D dhchap_secret;
> >                  host_key =3D ctrl->host_key;
> > @@ -3879,8 +3881,10 @@ static ssize_t
> > nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
> >                  int ret;
> >
> >                  ret =3D nvme_auth_generate_key(dhchap_secret, &key);
> > -               if (ret)
> > +               if (ret) {
> > +                       kfree(dhchap_secret);
> >                          return ret;
> > +               }
> >                  kfree(opts->dhchap_ctrl_secret);
> >                  opts->dhchap_ctrl_secret =3D dhchap_secret;
> >                  ctrl_key =3D ctrl->ctrl_key;
> > @@ -4042,8 +4046,10 @@ int nvme_cdev_add(struct cdev *cdev, struct
> > device *cdev_device,
> >          cdev_init(cdev, fops);
> >          cdev->owner =3D owner;
> >          ret =3D cdev_device_add(cdev, cdev_device);
> > -       if (ret)
> > +       if (ret) {
> >                  put_device(cdev_device);
> > +               ida_free(&nvme_ns_chr_minor_ida, MINOR(cdev_device->dev=
t));
> > +       }
> >
> >          return ret;
> >   }
> >
> >
> > with above patch I was able to get this :-
> >
> > blktests (master) # ./check nvme/044
> > nvme/044 (Test bi-directional authentication) [passed]
> >      runtime  1.729s  ...  1.892s
> > blktests (master) # ./check nvme/045
> > nvme/045 (Test re-authentication) [passed]
> >      runtime  4.798s  ...  6.303s
> >
> > -ck
> >
> >
>
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


