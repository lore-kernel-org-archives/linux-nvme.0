Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD85C43334
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 16:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6H7ZjwyzSQ8hGonkqlETZCtzSTJLBbixJg+2FnenLaU=; b=UQs4HRfqnuXJ5ox0++aDH23c1N
	MIgLFZTFSu6Z0AdB5W+T/2Gtquf4FNfqq0HxOA3Ej1VE96pqeIurtEQI2PXxQvjXX3Q5CkFJi9NjF
	TfyHunpMO6bozhrJzwCZZHPDmAuwu4t+6yas43/YGzfKWX3XEJijgE77N6FQ2GMWPSj/xtoNoeMMR
	BS8O+bLfqQfdOvJfwU8s/hJ1p24jyTEVEBGtiYzXMbEKJNjWps+kKJX9XMqX8+27e5k4A6AFwcBC3
	fxmYYeLveJuOzKjFFZrj5AI377l0LOPOQ7VkPsCFjf6pvcd7zXZWU86kW9oCAQjl2mkhOSvDarcbV
	KgdQ1teg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9qSH-004W8H-1R; Fri, 08 Jul 2022 16:03:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9qSE-004W5Q-2t
	for linux-nvme@lists.infradead.org; Fri, 08 Jul 2022 16:03:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657296217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=6H7ZjwyzSQ8hGonkqlETZCtzSTJLBbixJg+2FnenLaU=;
	b=Ntcw+DoWakh1Xdnhe8Nd6QmJ3hkZBpYnx6KQAEKy6Fg1hax3qsDS7PFAM/VSiIYhy6dqnh
	y9FYDok2KAastlbrm72d8QxUuzVJDjBpvbA6Ij6lBcMjFdsalW07+gAlTuJIBrDNxUAnhD
	jEh06AVToRBuUtWvyOrgP/5pXMmDB4A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-3n6K2MMPM6KK1xDyRholRQ-1; Fri, 08 Jul 2022 12:03:36 -0400
X-MC-Unique: 3n6K2MMPM6KK1xDyRholRQ-1
Received: by mail-pg1-f199.google.com with SMTP id a15-20020a65604f000000b00401a9baf7d5so10362144pgp.0
        for <linux-nvme@lists.infradead.org>; Fri, 08 Jul 2022 09:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6H7ZjwyzSQ8hGonkqlETZCtzSTJLBbixJg+2FnenLaU=;
        b=I0cIo+Z0QreZGotD3g0YZLzn97Fpocpr456ofMetOD9oG3eu1HAcp/PUEuGAp8D/qS
         YUxqpe1SraDOeXBMLymp4wUs/FRyY3s65fwMNLqwmJdBz1jI3qGYA6GGxTJfU333L0fH
         vSyBOhr+Bvbk7QVRXl2BK5USSLQD+h4UlHFyZ8Ed4ZMI2pbC6z7HxxKG5rMqwxzuhhJz
         S8ptPvq/NvCG/PsVbP+x0agnlcB4njC/Ck5UCOykafKmz8x9V9aj0y2jtx/ARTSmLUI1
         qQ84EBUid3J9PnXwJaKmmKAnpMXbdgMECttqzNby9MjUQaFJbyA1R0qvcC+nJEPVthJw
         o5Mw==
X-Gm-Message-State: AJIora+G7szi1QZfNAU9MJf3R6C+0r1jaCxvRPoXGeNlGc0dOPwoATfq
	5hjGYROp3NKXbcGmJQSRk8/z530xe1rwmPihKREB8rhYlYEwRfUyxf5xwaLGI+iVP5YtsmhdzPy
	m+wsgPSI8QHek5zowS4F2cuRX4nwFhd/SOaXxr9g4ybM=
X-Received: by 2002:a17:902:db10:b0:16c:1bf9:dec9 with SMTP id m16-20020a170902db1000b0016c1bf9dec9mr4342952plx.15.1657296214953;
        Fri, 08 Jul 2022 09:03:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tjc84fSv6MyYmk1LP58p8X3o2VlrxZEWMFlgP4j8lldO9e7iREe/YxP87QF9DCPSTEyfG5ni930GPdOi1CqsQ=
X-Received: by 2002:a17:902:db10:b0:16c:1bf9:dec9 with SMTP id
 m16-20020a170902db1000b0016c1bf9dec9mr4342918plx.15.1657296214491; Fri, 08
 Jul 2022 09:03:34 -0700 (PDT)
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 9 Jul 2022 00:03:23 +0800
Message-ID: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
Subject: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_090342_240516_6DABC129 
X-CRM114-Status: UNSURE (   6.16  )
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

I reproduced this issue on the linux-block/for-next, pls help check
it, feel free to let me know if you need info/test, thanks.

[ 6026.144114] run blktests nvme/012 at 2022-07-08 08:15:09
[ 6026.271866] loop0: detected capacity change from 0 to 2097152
[ 6026.294403] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 6026.322827] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 6026.347984] nvmet: creating nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:90390a00-4597-11e9-b935-3c18a0043981.
[ 6026.364007] nvme nvme0: creating 32 I/O queues.
[ 6026.380279] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[ 6026.398481] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
127.0.0.1:4420
[ 6027.653759] XFS (nvme0n1): Mounting V5 Filesystem
[ 6027.677423] XFS (nvme0n1): Ending clean mount
[ 6173.064201] XFS (nvme0n1): Unmounting Filesystem
[ 6173.656286] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
[ 6174.005589] ------------[ cut here ]------------
[ 6174.010200] workqueue: WQ_MEM_RECLAIM
nvmet-wq:nvmet_tcp_release_queue_work [nvmet_tcp] is flushing
!WQ_MEM_RECLAIM nvmet_tcp_wq:nvmet_tcp_io_work [nvmet_tcp]
[ 6174.010216] WARNING: CPU: 20 PID: 14456 at kernel/workqueue.c:2628
check_flush_dependency+0x110/0x14c
[ 6174.033579] Modules linked in: nvme_tcp nvme_fabrics nvmet_tcp
nvmet nvme nvme_core loop tls mlx4_ib ib_uverbs ib_core mlx4_en rfkill
sunrpc vfat fat joydev acpi_ipmi mlx4_core igb ipmi_ssif cppc_cpufreq
fuse zram xfs uas usb_storage dwc3 ulpi udc_core ast crct10dif_ce
drm_vram_helper ghash_ce drm_ttm_helper sbsa_gwdt ttm
i2c_xgene_slimpro ahci_platform gpio_dwapb xgene_hwmon xhci_plat_hcd
ipmi_devintf ipmi_msghandler [last unloaded: nvmet]
[ 6174.072622] CPU: 20 PID: 14456 Comm: kworker/20:8 Not tainted 5.19.0-rc5+ #1
[ 6174.079660] Hardware name: Lenovo HR350A            7X35CTO1WW
/FALCON     , BIOS hve104q-1.14 06/25/2020
[ 6174.089474] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[ 6174.096168] pstate: 004000c5 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 6174.103117] pc : check_flush_dependency+0x110/0x14c
[ 6174.107985] lr : check_flush_dependency+0x110/0x14c
[ 6174.112851] sp : ffff800026b2bb10
[ 6174.116153] x29: ffff800026b2bb10 x28: 0000000000000000 x27: ffff80000a94f240
[ 6174.123279] x26: ffff800009304a90 x25: 0000000000000001 x24: ffff80000a570448
[ 6174.130405] x23: ffff009f6c6d82a8 x22: fffffbffee9cea00 x21: ffff800001395430
[ 6174.137532] x20: ffff0008c0fb3000 x19: ffff00087b7dda00 x18: ffffffffffffffff
[ 6174.144657] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000006
[ 6174.151783] x14: 0000000000000001 x13: 204d49414c434552 x12: 5f4d454d5f515721
[ 6174.158909] x11: 00000000ffffdfff x10: ffff80000a53eb70 x9 : ffff80000824f754
[ 6174.166034] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 : 00000000000affa8
[ 6174.173160] x5 : 0000000000001fff x4 : 0000000000000000 x3 : 0000000000000027
[ 6174.180286] x2 : 0000000000000002 x1 : ffff0008c6080000 x0 : 0000000000000092
[ 6174.187412] Call trace:
[ 6174.189847]  check_flush_dependency+0x110/0x14c
[ 6174.194367]  start_flush_work+0xd8/0x410
[ 6174.198278]  __flush_work+0x88/0xe0
[ 6174.201755]  __cancel_work_timer+0x118/0x194
[ 6174.206014]  cancel_work_sync+0x20/0x2c
[ 6174.209837]  nvmet_tcp_release_queue_work+0xcc/0x300 [nvmet_tcp]
[ 6174.215834]  process_one_work+0x2b8/0x704
[ 6174.219832]  worker_thread+0x80/0x42c
[ 6174.223483]  kthread+0xfc/0x110
[ 6174.226613]  ret_from_fork+0x10/0x20
[ 6174.230179] irq event stamp: 0
[ 6174.233221] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 6174.239478] hardirqs last disabled at (0): [<ffff800008198c44>]
copy_process+0x674/0x14a0
[ 6174.247644] softirqs last  enabled at (0): [<ffff800008198c44>]
copy_process+0x674/0x14a0
[ 6174.255809] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 6174.262063] ---[ end trace 0000000000000000 ]-----

Best Regards,
  Yi Zhang


