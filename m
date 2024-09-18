Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46D7CDD543
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bzxpKNdEzL66u3mMawPHAbJ94NRKmQ8CbAuJzjAM4SM=; b=a1c3RrhOZz/jBXqZisUAb1RBf7
	Cwe9aOV7Xt33xcqgLS8sgXgfjdbeaV1UUrxXyo9nFkgXRcV+lsEvYlerAyprr4SB6d3RfgRXKkuab
	IBV60pSnGjG6dSIOYFXu5DxKNAKqh6I0Q7fVrpJkbH8nQkHUl6O4K0fBG3SMte+OliMsA5TCw+5/V
	YJOTJ0mylbd4BluDVcq9PJBg6XWG9buIA7NIC3A/tP6h2wjbjjv86oI1TK937oFgKKAF2c8D9mmJD
	I5eakAJ36KRxo1+IBpxv2pmP+YumjN4VLxWgEdKWXV1LoxjbZkDH0CLenqpKXPDQh/odFlEXdVaEQ
	ARA0g8Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqxFX-00000008b5L-43Jc;
	Wed, 18 Sep 2024 16:09:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqxFV-00000008b4q-3B3N
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 16:09:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726675787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bzxpKNdEzL66u3mMawPHAbJ94NRKmQ8CbAuJzjAM4SM=;
	b=CL/oL7lfz/r9UrpEUS7iwpDBlsaaVyTW5GD1npE/V8fHyvR6cL6ItQdCwcpWIo2KemXvQK
	rQpJMXKlN5TtUC1DLdax1cFwfECak9Ap0DOHckr6TakXghKKLqerIMXa4NzX29Otw/gIVp
	9GtRmi+5EMoMgEOvn2uhvq43+46ICQg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-SYnmjJAKPCi3n3A71IBbeA-1; Wed, 18 Sep 2024 12:09:45 -0400
X-MC-Unique: SYnmjJAKPCi3n3A71IBbeA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2dd60a85597so950581a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2024 09:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726675784; x=1727280584;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzxpKNdEzL66u3mMawPHAbJ94NRKmQ8CbAuJzjAM4SM=;
        b=YloHtbstBYyPlBhsfQgalIkrTF2s58ZhEDLPkhr71TgCV69vwEt44RoXi9SB/fdz4K
         bdsf9AVNS+uIDfX2cYf81sLpXDfBqkXdaL3JZp28xO/IGzaMHPbmRbkUlz0mXbCyFxIr
         yTK8seycn4bFWqsguisIJ48QTEDjsNJ07Kujrfp68LsMZSctiIpTP0QF9yOobDtHQSr6
         qtvcmrFZVH5jtsqJ7ErE+dTTN7dyvn1AsJuPxgNhH7I2CLulhflJuQZHF9GczPZ20qJU
         WzullFlAPvV9falH2EUIItMjaiCR7zaT5HUTI2lDsTvRh57ea0mD0/KLgQ/2sXQlf9WU
         Hplg==
X-Forwarded-Encrypted: i=1; AJvYcCWzPx7XUaJGoKaoIm4NyOzhYaVvVNzQdwopXN9Fw1FwkHmfEm2WqJMMG2Y9/8gxpgF5+PmLOSXtP0C9@lists.infradead.org
X-Gm-Message-State: AOJu0YxfPkBNTmh9tLE2So0Q/0zsn7ZhfV82LfihcF7rocik19fubHeV
	Sv/pwWcgnlzb7EyhBTkwb3YIF5TntBYMarLuPG+AtQTfk1kcoIIMx1Ua7e9obmpVDXI0ciI1hZT
	uL0KOgjfrP0dKS/dYSoE+zAYTibojUsAlZjLPqXIfOHSykdkr7kSTwNZEoaSirQ5lw3qlpxnjPe
	ZeMI5oDDQfLebLc0aOqkV/Rn/AEVQ05oamsemVtzs=
X-Received: by 2002:a17:90b:4c0c:b0:2d3:c0e5:cbac with SMTP id 98e67ed59e1d1-2db9ffa11e4mr26842424a91.7.1726675784067;
        Wed, 18 Sep 2024 09:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH58SJqTzUyrH6m4BeNeN41YNP90pfkJFT83ZTdWWVj9gyABE9wVgu37wAnXCfb9suyNHW7kUttwygG123KvHs=
X-Received: by 2002:a17:90b:4c0c:b0:2d3:c0e5:cbac with SMTP id
 98e67ed59e1d1-2db9ffa11e4mr26842390a91.7.1726675783642; Wed, 18 Sep 2024
 09:09:43 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 19 Sep 2024 00:09:31 +0800
Message-ID: <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
Subject: [bug report][regession] most of blktests nvme/tcp failed with the
 last linux code
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_090949_895852_0A656C0D 
X-CRM114-Status: UNSURE (   8.08  )
X-CRM114-Notice: Please train this message.
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

Hello

CKI reported most of the blktests nvme/tcp tests failed on the linux
tree[1], here is the reproducer and dmesg log, the issue cannot be
reproduced with 6.11.0, seems
it was introduced with the latest block code merge, please help check
it and let me know if you need any info/testing about it, thanks.


[1]
https://datawarehouse.cki-project.org/kcidb/tests/14394423

[2]
# nvme_trtype=tcp ./check nvme/003
nvme/003 (tr=tcp) (test if we're sending keep-alives to a discovery
controller) [failed]
    runtime  11.280s  ...  11.188s
    --- tests/nvme/003.out 2024-09-18 11:30:11.243366401 -0400
    +++ /root/blktests/results/nodev_tr_tcp/nvme/003.out.bad
2024-09-18 11:52:32.977112834 -0400
    @@ -1,3 +1,3 @@
     Running nvme/003
    -disconnected 1 controller(s)
    +disconnected 0 controller(s)
     Test complete
# dmesg
[  447.213539] run blktests nvme/003 at 2024-09-18 11:52:21
[  447.229285] loop0: detected capacity change from 0 to 2097152
[  447.233104] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  447.242398] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  447.251089] sysfs: cannot create duplicate filename
'/devices/virtual/nvme-fabrics/ctl/nvme0/reset_controller'
[  447.251810] CPU: 2 UID: 0 PID: 5241 Comm: nvme Kdump: loaded Not
tainted 6.12.0-0.rc0.adfc3ded5c33.2.test.el10.aarch64 #1
[  447.252540] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  447.253006] Call trace:
[  447.253171]  dump_backtrace+0xd8/0x130
[  447.253432]  show_stack+0x20/0x38
[  447.253657]  dump_stack_lvl+0x80/0xa8
[  447.253925]  dump_stack+0x18/0x30
[  447.254152]  sysfs_warn_dup+0x6c/0x90
[  447.254406]  sysfs_add_file_mode_ns+0x12c/0x138
[  447.254713]  create_files+0xa8/0x1f8
[  447.254973]  internal_create_group+0x18c/0x358
[  447.255274]  internal_create_groups+0x58/0xe0
[  447.255558]  sysfs_create_groups+0x20/0x40
[  447.255826]  device_add_attrs+0x19c/0x218
[  447.256093]  device_add+0x310/0x6d0
[  447.256327]  cdev_device_add+0x58/0xc0
[  447.256579]  nvme_add_ctrl+0x78/0xd0 [nvme_core]
[  447.256895]  nvme_tcp_create_ctrl+0x3c/0x178 [nvme_tcp]
[  447.257248]  nvmf_create_ctrl+0x150/0x288 [nvme_fabrics]
[  447.257614]  nvmf_dev_write+0x98/0xf8 [nvme_fabrics]
[  447.257948]  vfs_write+0xdc/0x380
[  447.258174]  ksys_write+0x7c/0x120
[  447.258408]  __arm64_sys_write+0x24/0x40
[  447.258673]  invoke_syscall.constprop.0+0x74/0xd0
[  447.258994]  do_el0_svc+0xb0/0xe8
[  447.259225]  el0_svc+0x44/0x1a0
[  447.259449]  el0t_64_sync_handler+0x120/0x130
[  447.259745]  el0t_64_sync+0x1a4/0x1a8

-- 
Best Regards,
  Yi Zhang


