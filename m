Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E225C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 16:12:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E376608FB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 16:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E376608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iTaY1XzScMM3wemVh2a45EOAp3qRshCPTons9dgthoA=; b=bQwprCoELjSTQTQSHC+yTtDxpo
	5Y2bnCA+Qs12QGmDhA3Hk1axRIZfE/xsMyMXimUdsFCDehiBUgAi/U0tdtARZ0XD60ln8RzByl0xO
	ffhZQx9+HGnRQArqDz+yAbf6gZmoizLQOgYjnHq+gEkjzA9hD2VA9lRJID77XQlaUZ2upq+bTvrg5
	TwiN9iba2y0PQqSgpkePhYv1GmwpR5TAn2/oTR4reByvKr4E+aPJ81XrvuqxktmoJOSO8FT8WJmQi
	kimkB9Sf0xnQwTfsO1mg4ZC5yuqeRyVTMApsPwGqbxA1D93XR0VTkSh0wNjMT2SHaLPOG9dP5NJim
	O4vviPEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnNXk-005gJy-Dl; Wed, 17 Nov 2021 16:12:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnNJs-005Zn3-OB
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 15:57:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637164675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=iTaY1XzScMM3wemVh2a45EOAp3qRshCPTons9dgthoA=;
 b=dElax1ttfSK6ICtF+MBW/3Ek2ZymiH0XdMeXZziKW0W9GUSN053+CD1+Y+BZjJJorWuEx/
 AFrGek8jitSs9/dslykL9zoLeJ6C9qYdiqtPz6fVDYrxgYx47SZQB4dyQbFbtRgH8uy/Zi
 H0GxqgviAOv26Bg/cG1upnMFLY3yXeQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-123-yFlLad93PmOBXRBHWzOn-w-1; Wed, 17 Nov 2021 10:57:53 -0500
X-MC-Unique: yFlLad93PmOBXRBHWzOn-w-1
Received: by mail-yb1-f197.google.com with SMTP id
 g25-20020a25b119000000b005c5e52a0574so4678762ybj.5
 for <linux-nvme@lists.infradead.org>; Wed, 17 Nov 2021 07:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=iTaY1XzScMM3wemVh2a45EOAp3qRshCPTons9dgthoA=;
 b=PgAirJ/9LoDOFn/mWvbIibqQkbynVR2mSzsXS6O7ixMSHDBctVmLk5bHtBfaNBlSd9
 onpl4kBrIKr8eXeX55AQem76sBz2lPET9Wp/1C3rfeo9hSUal7qndKdXaS1NUT3nxw2J
 2vnj14OP50/47tx1lV3etQx6j3S0jh2P3AQ5zp547DQADiJy2VUuzI3Vru0TraK/z73E
 p1nWOQ1e4u1I26lD/CX0io5arE7Zqu3I4N3strG3kLZvZPnZXWDB4aND7uAAFd9WtLP6
 88/8O1uCAXRqUCnygoqVVLrYSX/5repyayAbrRhvTTv/j7fTB0BvsnbeAlUyCuqKpLXB
 Hhlg==
X-Gm-Message-State: AOAM5320JZLRIqVuvurXjmCSV3HB7HtB9Y7ZSRHG3oFc1ewqPCVrqJIA
 Nlm/azgUkb2vbclWOWkG2FUoWr29DRr6cga1h0JiKmIaKv8AAEzHfS2xZH5Kk8TmcHrJYp4ByiS
 wDQ2s3D62V2i/BM5b2cpLjowHarbA5kEVlrPY64BOgx0=
X-Received: by 2002:a25:73c7:: with SMTP id
 o190mr16710945ybc.522.1637164672594; 
 Wed, 17 Nov 2021 07:57:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6OIpatvlpVxOVtahBKWfZDlCO5LJuuPugUpz4ukvSSUfCgdxmUtCd62jR6V6bQYYoaOFERHJMfOkkRvKtClQ=
X-Received: by 2002:a25:73c7:: with SMTP id
 o190mr16710905ybc.522.1637164672343; 
 Wed, 17 Nov 2021 07:57:52 -0800 (PST)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 17 Nov 2021 23:57:41 +0800
Message-ID: <CAHj4cs97spcWGFjz4JPzaRuzHnRGZkKP6HWMSPkbKLS9EmWMJA@mail.gmail.com>
Subject: [regression] nvme pci sysfs remove operation hang during fio test
 observed on 5.16.0-rc1
To: linux-block <linux-block@vger.kernel.org>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_075756_908238_6CD49E0B 
X-CRM114-Status: UNSURE (   5.80  )
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

I found this regression issue on 5.16.0-rc1, pls check it and let me
know if you need any test/debug info for it, thanks.

[  369.657564] INFO: task main.sh:1695 blocked for more than 122 seconds.
[  369.664871]       Tainted: G S                5.16.0-rc1 #1
[  369.671106] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  369.679854] task:main.sh         state:D stack:    0 pid: 1695
ppid:  1692 flags:0x00004004
[  369.679863] Call Trace:
[  369.679866]  <TASK>
[  369.679872]  __schedule+0x3e3/0x9a0
[  369.679887]  ? _raw_spin_lock_irqsave+0x17/0x40
[  369.679893]  schedule+0x44/0xc0
[  369.679899]  blk_mq_freeze_queue_wait+0x62/0x90
[  369.679908]  ? finish_wait+0x80/0x80
[  369.679920]  del_gendisk+0x18d/0x210
[  369.679931]  nvme_ns_remove+0xc7/0x1d0 [nvme_core]
[  369.679954]  nvme_remove_namespaces+0xac/0xf0 [nvme_core]
[  369.679974]  nvme_remove+0x60/0x140 [nvme]
[  369.679984]  pci_device_remove+0x36/0xb0
[  369.679994]  device_release_driver_internal+0xf7/0x1e0
[  369.680005]  pci_stop_bus_device+0x69/0x90
[  369.680012]  pci_stop_and_remove_bus_device_locked+0x16/0x30
[  369.680018]  remove_store+0x75/0x90
[  369.680025]  kernfs_fop_write_iter+0x130/0x1c0
[  369.680035]  new_sync_write+0x122/0x1b0
[  369.680045]  vfs_write+0x1ba/0x2a0
[  369.680053]  ksys_write+0x59/0xd0
[  369.680058]  do_syscall_64+0x3a/0x80
[  369.680067]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  369.680073] RIP: 0033:0x7f99b1159648
[  369.680078] RSP: 002b:00007ffec2a09748 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  369.680083] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f99b1159648
[  369.680086] RDX: 0000000000000002 RSI: 0000564e26ba1b20 RDI: 0000000000000001
[  369.680089] RBP: 0000564e26ba1b20 R08: 000000000000000a R09: 00007f99b11ec620
[  369.680091] R10: 000000000000000a R11: 0000000000000246 R12: 00007f99b142c6e0
[  369.680094] R13: 0000000000000002 R14: 00007f99b1427880 R15: 0000000000000002
[  369.680099]  </TASK>
[  492.536344] INFO: task main.sh:1695 blocked for more than 245 seconds.
[  492.543638]       Tainted: G S                5.16.0-rc1 #1
[  492.549870] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  492.558617] task:main.sh         state:D stack:    0 pid: 1695
ppid:  1692 flags:0x00004004
[  492.558625] Call Trace:
[  492.558627]  <TASK>
[  492.558631]  __schedule+0x3e3/0x9a0
[  492.558639]  ? _raw_spin_lock_irqsave+0x17/0x40
[  492.558644]  schedule+0x44/0xc0
[  492.558650]  blk_mq_freeze_queue_wait+0x62/0x90
[  492.558655]  ? finish_wait+0x80/0x80
[  492.558663]  del_gendisk+0x18d/0x210
[  492.558671]  nvme_ns_remove+0xc7/0x1d0 [nvme_core]
[  492.558692]  nvme_remove_namespaces+0xac/0xf0 [nvme_core]
[  492.558710]  nvme_remove+0x60/0x140 [nvme]
[  492.558718]  pci_device_remove+0x36/0xb0
[  492.558724]  device_release_driver_internal+0xf7/0x1e0
[  492.558732]  pci_stop_bus_device+0x69/0x90
[  492.558737]  pci_stop_and_remove_bus_device_locked+0x16/0x30
[  492.558742]  remove_store+0x75/0x90
[  492.558748]  kernfs_fop_write_iter+0x130/0x1c0
[  492.558756]  new_sync_write+0x122/0x1b0
[  492.558763]  vfs_write+0x1ba/0x2a0
[  492.558769]  ksys_write+0x59/0xd0
[  492.558775]  do_syscall_64+0x3a/0x80
[  492.558780]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  492.558785] RIP: 0033:0x7f99b1159648
[  492.558789] RSP: 002b:00007ffec2a09748 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  492.558794] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f99b1159648
[  492.558797] RDX: 0000000000000002 RSI: 0000564e26ba1b20 RDI: 0000000000000001
[  492.558800] RBP: 0000564e26ba1b20 R08: 000000000000000a R09: 00007f99b11ec620
[  492.558803] R10: 000000000000000a R11: 0000000000000246 R12: 00007f99b142c6e0
[  492.558805] R13: 0000000000000002 R14: 00007f99b1427880 R15: 0000000000000002
[  492.558811]  </TASK>

-- 
Best Regards,
  Yi Zhang


