Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5A6C78850
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2024 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fCalEBABFVFsMMhs8TPEqo8Ap8uiBjRPjKqEGdMLqnE=; b=o7I5aWvdCbSWn9cCtffLPvOF+B
	cMqiWN6tSCYJtcu80OsbwgFfg2G4rvexQHugE0GId7K8cMa4P1PCPwZ4lhHV0hu+SrOknhHDzKvaq
	gZCSny/l7ivVt0SGPCqtRowB3VV5eFdAtNQ7iTfoSHQ6n32tpG8capiQ1SttzKGfSfcwmHxVXRfyF
	t5iiLNriJdR77FoRg6EffuczwTB4n3hZic4dExARtcGRe22im2UGolwgCjq1utk63k2RzrZfYBcde
	WctGQBTzD8Si5KGIkQu9rbP/8qtLRq+Jl8Q80xlifXfg3C95voZBI1REZo641+ata7OD4YTzS5yx6
	5nU6hfqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sreVm-0000000CNB9-1MxZ;
	Fri, 20 Sep 2024 14:21:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sreUn-0000000CMnl-1L2s
	for linux-nvme@lists.infradead.org;
	Fri, 20 Sep 2024 14:20:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726842026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCalEBABFVFsMMhs8TPEqo8Ap8uiBjRPjKqEGdMLqnE=;
	b=B6uR9wTQ8yhaFQSIopuQEGyA9pMbe+Vr/xJ2LG3m9mseWz8p/lxgAlHhO3b4gomDiwwIQv
	+65T8cob8ZJlNOXiDAn/2g6zdz+piYVKFG7LsaSTpzO5SK9pMwrpTEp9S5FellnsxBtr5g
	tJFpwp65YK6Te0ZR9s7caVbgPVYjFgs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-ZkOmyWvENoOg2lAd_invew-1; Fri, 20 Sep 2024 10:20:25 -0400
X-MC-Unique: ZkOmyWvENoOg2lAd_invew-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8b3af9e61so2245978a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2024 07:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842024; x=1727446824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCalEBABFVFsMMhs8TPEqo8Ap8uiBjRPjKqEGdMLqnE=;
        b=wBgjRZSEeqc358P9tCZP50rbXTLmcp4Vv16f7dGpIpMX3UIj7nlpOOSaO+a8xp14/y
         7UXxGVB2Mj8tujTDp03N6yMnoFuyvejOZw/LQE+bDWy6xHqAw1W2ThdLSOrcEPLD1jx7
         d72OGv39k+y10fUr8kyUIHLgidrDuQnA+6c0KEb2d3obQcs413UUlXRBPuoHlf7GOquk
         weOa1MdC1xHX9AT4ke2yIMSbAQL4Q/P1ltbEbY53Oy+ni3R6Y/MDoPBcmv/qHLiiHHcS
         558TM9JR3aonQwCsBnHjhLAXcWd1nSfRV+jdluFuV+KoBNmfQQcU8sc5frkaTmqZZh2+
         qe2A==
X-Forwarded-Encrypted: i=1; AJvYcCW3BBkklF+2OnuBbqtpKsA/xbzzpoLTQKi8TXoK29Ws1KYR+RObm/WaOmnoTt3LMnODF8+3KLa0i+1m@lists.infradead.org
X-Gm-Message-State: AOJu0YwyN2YObb+P5KQjofx/gvyE1wrimEYeLQ8FxV1G0ofzzLQthiPm
	SxmGgi6U+8m+UF4ZwuRwEK1tFI8Mpztl5Y4ihzfPTz067xwd/O2R3rDjOHx3QvAd+T3WyERsXCe
	9IpFzM6G4xpg7ml5Y8ysNjxqPesoT/7s7YuR04JCyAlKxqsoK7+zs3GStzfoFzzC6cR+TTf7UpF
	QKBitEmiclgnCnsWuiuUPVHEQOM0Y3SS30KFfMPK8=
X-Received: by 2002:a17:90a:62c7:b0:2da:9490:900c with SMTP id 98e67ed59e1d1-2dd80c7ecbcmr3202656a91.21.1726842024032;
        Fri, 20 Sep 2024 07:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyCh2QJpZ4RfCR4/0c8rkzSouxSf5uv4vyNtzdlJMeQxeDouDT2kEKJZpDylsJEwPmGG+nC5N7oytgOPvdg2Q=
X-Received: by 2002:a17:90a:62c7:b0:2da:9490:900c with SMTP id
 98e67ed59e1d1-2dd80c7ecbcmr3202632a91.21.1726842023707; Fri, 20 Sep 2024
 07:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
In-Reply-To: <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 20 Sep 2024 22:20:11 +0800
Message-ID: <CAHj4cs8YGgmemMZDXmt7yHa+Xq3EiEvRWOJGEQTDjqGB2rAogw@mail.gmail.com>
Subject: Re: [bug report][regression][bisected] most of blktests nvme/tcp
 failed with the last linux code
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240920_072029_460170_8556564E 
X-CRM114-Status: GOOD (  13.86  )
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

+ Hannes
I did bisect and it seems was introduced with the below commit:

commit 1e48b34c9bc79aa36700fccbfdf87e61e4431d2b
Author: Hannes Reinecke <hare@suse.de>
Date:   Mon Jul 22 14:02:22 2024 +0200

    nvme: split off TLS sysfs attributes into a separate group


On Thu, Sep 19, 2024 at 12:09=E2=80=AFAM Yi Zhang <yi.zhang@redhat.com> wro=
te:
>
> Hello
>
> CKI reported most of the blktests nvme/tcp tests failed on the linux
> tree[1], here is the reproducer and dmesg log, the issue cannot be
> reproduced with 6.11.0, seems
> it was introduced with the latest block code merge, please help check
> it and let me know if you need any info/testing about it, thanks.
>
>
> [1]
> https://datawarehouse.cki-project.org/kcidb/tests/14394423
>
> [2]
> # nvme_trtype=3Dtcp ./check nvme/003
> nvme/003 (tr=3Dtcp) (test if we're sending keep-alives to a discovery
> controller) [failed]
>     runtime  11.280s  ...  11.188s
>     --- tests/nvme/003.out 2024-09-18 11:30:11.243366401 -0400
>     +++ /root/blktests/results/nodev_tr_tcp/nvme/003.out.bad
> 2024-09-18 11:52:32.977112834 -0400
>     @@ -1,3 +1,3 @@
>      Running nvme/003
>     -disconnected 1 controller(s)
>     +disconnected 0 controller(s)
>      Test complete
> # dmesg
> [  447.213539] run blktests nvme/003 at 2024-09-18 11:52:21
> [  447.229285] loop0: detected capacity change from 0 to 2097152
> [  447.233104] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  447.242398] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  447.251089] sysfs: cannot create duplicate filename
> '/devices/virtual/nvme-fabrics/ctl/nvme0/reset_controller'
> [  447.251810] CPU: 2 UID: 0 PID: 5241 Comm: nvme Kdump: loaded Not
> tainted 6.12.0-0.rc0.adfc3ded5c33.2.test.el10.aarch64 #1
> [  447.252540] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/=
2015
> [  447.253006] Call trace:
> [  447.253171]  dump_backtrace+0xd8/0x130
> [  447.253432]  show_stack+0x20/0x38
> [  447.253657]  dump_stack_lvl+0x80/0xa8
> [  447.253925]  dump_stack+0x18/0x30
> [  447.254152]  sysfs_warn_dup+0x6c/0x90
> [  447.254406]  sysfs_add_file_mode_ns+0x12c/0x138
> [  447.254713]  create_files+0xa8/0x1f8
> [  447.254973]  internal_create_group+0x18c/0x358
> [  447.255274]  internal_create_groups+0x58/0xe0
> [  447.255558]  sysfs_create_groups+0x20/0x40
> [  447.255826]  device_add_attrs+0x19c/0x218
> [  447.256093]  device_add+0x310/0x6d0
> [  447.256327]  cdev_device_add+0x58/0xc0
> [  447.256579]  nvme_add_ctrl+0x78/0xd0 [nvme_core]
> [  447.256895]  nvme_tcp_create_ctrl+0x3c/0x178 [nvme_tcp]
> [  447.257248]  nvmf_create_ctrl+0x150/0x288 [nvme_fabrics]
> [  447.257614]  nvmf_dev_write+0x98/0xf8 [nvme_fabrics]
> [  447.257948]  vfs_write+0xdc/0x380
> [  447.258174]  ksys_write+0x7c/0x120
> [  447.258408]  __arm64_sys_write+0x24/0x40
> [  447.258673]  invoke_syscall.constprop.0+0x74/0xd0
> [  447.258994]  do_el0_svc+0xb0/0xe8
> [  447.259225]  el0_svc+0x44/0x1a0
> [  447.259449]  el0t_64_sync_handler+0x120/0x130
> [  447.259745]  el0t_64_sync+0x1a4/0x1a8
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang


