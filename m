Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7288BC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 17:07:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02EA22D6E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 17:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02EA22D6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CufESoMuSlZUZmuWRTjHblNiYxRUnDqCgBvceh8AUok=; b=M3N1O9JXqm3KFv4YXQLksntXy
	aSfyhgvAPFVXvB6OKE+KBnEy6y2nP21DuIf0SEn8H3BVPCk6Ct83ffxq7LyJsAZoBFgiXb4ic0W12
	Zz1TJtBGIa/bb5Xis1hbVIVxYN06U1Im/4z/P/ii3YLabAxL9s/1nxQ0/tnpzBMLyI/K5w60fqFrt
	Iyl5RU0oEbGM7zFs9wmK8RVQ5iUuIAmLFgW7tDY3vCDhfDf0dapJdm0VJ4k/2+/6BMrIo/6yLm+9d
	R0QEHhEsLVLXQQ+T07J20w0l2z59G7AJIdV0Cr47aF8iImEooOWNub0uS5AaR+BUQ+3bdm0g6ihwU
	WnIlWYjSg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knPP6-0005yY-RS; Thu, 10 Dec 2020 17:06:56 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knPP3-0005wO-01
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 17:06:54 +0000
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0BAH6lgS004240;
 Thu, 10 Dec 2020 09:06:48 -0800
Date: Thu, 10 Dec 2020 22:36:47 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Request timeout seen with NVMEoF TCP
Message-ID: <X9JVp9mjtC1p0iLS@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_120653_253811_0B46F17A 
X-CRM114-Status: GOOD (  16.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wednesday, December 12/09/20, 2020 at 10:02:57 -0800, Sagi Grimberg wrote:
> 
> > Hi All,
> > I am seeing the following timeouts and reconnects on NVMF TCP initiator with latest v5.10-rc5
> > kernel.
> > I see the same behavior with nvme tree too (branch:nvme-5.11)
> > I last ran this with 5.8, where it was running fine.
> > 
> > Target configuration is, 1 target with 1gb ramdisk namespace. On intiator,
> > discover, connect and run fio or Iozone. Traces are seen within couple of minutes
> > after starting the test.
> 
> Hey Potnuri,
> 
> Can you also attach the target side logs? it seems like an I/O times out
> for no apparent reason..

I see nothing much logged on target.

Target dmesg:
---
[ 8371.979029] brd: module loaded
[ 8371.983368] nvmet: adding nsid 1 to subsystem nvme-ram0
[ 8371.988189] nvmet: adding nsid 1 to subsystem nvme-ram1
[ 8371.992766] nvmet: adding nsid 1 to subsystem nvme-ram2
[ 8371.997107] nvmet: adding nsid 1 to subsystem nvme-ram3
[ 8372.001881] nvmet_tcp: enabling port 1 (10.0.3.2:4420)
[ 8407.988148] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 8417.287799] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 8417.328557] nvmet: creating controller 1 for subsystem nvme-ram0 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 8417.365155] nvmet: creating controller 2 for subsystem nvme-ram1 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 8417.402337] nvmet: creating controller 3 for subsystem nvme-ram2 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 8417.439785] nvmet: creating controller 4 for subsystem nvme-ram3 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.

[ 8511.903509] nvmet: creating controller 2 for subsystem nvme-ram1 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
[ 8552.862271] nvmet: creating controller 1 for subsystem nvme-ram0 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
^^^^^^^ Logs due to reconnect ^^^^^^^^
---

Initiator dmesg:
---
[  923.976468] nvme nvme0: Removing ctrl: NQN "nvme-ram0"
[  985.213878] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.0.3.2:4420
[  985.215489] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  994.513541] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.0.3.2:4420
[  994.515025] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  994.554853] nvme nvme0: creating 16 I/O queues.
[  994.559725] nvme nvme0: mapped 16/0/0 default/read/poll queues.
[  994.565373] nvme nvme0: new ctrl: NQN "nvme-ram0", addr 10.0.3.2:4420
[  994.591559] nvme nvme1: creating 16 I/O queues.
[  994.596472] nvme nvme1: mapped 16/0/0 default/read/poll queues.
[  994.602392] nvme nvme1: new ctrl: NQN "nvme-ram1", addr 10.0.3.2:4420
[  994.628442] nvme nvme2: creating 16 I/O queues.
[  994.633391] nvme nvme2: mapped 16/0/0 default/read/poll queues.
[  994.639256] nvme nvme2: new ctrl: NQN "nvme-ram2", addr 10.0.3.2:4420
[  994.665958] nvme nvme3: creating 16 I/O queues.
[  994.670913] nvme nvme3: mapped 16/0/0 default/read/poll queues.
[  994.676894] nvme nvme3: new ctrl: NQN "nvme-ram3", addr 10.0.3.2:4420
[ 1007.040464] EXT4-fs (nvme0n1): mounting ext3 file system using the ext4 subsystem
[ 1007.044448] EXT4-fs (nvme0n1): mounted filesystem with ordered data mode. Opts: (null)
[ 1007.070111] EXT4-fs (nvme1n1): mounting ext3 file system using the ext4 subsystem
[ 1007.073819] EXT4-fs (nvme1n1): mounted filesystem with ordered data mode. Opts: (null)
[ 1007.099188] EXT4-fs (nvme2n1): mounting ext3 file system using the ext4 subsystem
[ 1007.102578] EXT4-fs (nvme2n1): mounted filesystem with ordered data mode. Opts: (null)
[ 1007.126442] EXT4-fs (nvme3n1): mounting ext3 file system using the ext4 subsystem
[ 1007.130367] EXT4-fs (nvme3n1): mounted filesystem with ordered data mode. Opts: (null)
[ 1078.867439] nvme nvme1: queue 14: timeout request 0x33 type 6
[ 1078.868266] nvme nvme1: starting error recovery
[ 1078.868775] nvme nvme1: queue 14: timeout request 0x34 type 6
[ 1078.869853] nvme nvme1: queue 14: timeout request 0x35 type 6
[ 1078.869908] nvme nvme1: queue 14: timeout request 0x36 type 4
[ 1078.869958] nvme nvme1: queue 14: timeout request 0x37 type 4
[ 1078.870586] block nvme1n1: no usable path - requeuing I/O
[ 1078.870686] block nvme1n1: no usable path - requeuing I/O
[ 1078.871752] block nvme1n1: no usable path - requeuing I/O
[ 1078.872573] nvme nvme1: Reconnecting in 10 seconds...
[ 1078.872949] block nvme1n1: no usable path - requeuing I/O
[ 1078.874802] block nvme1n1: no usable path - requeuing I/O
[ 1078.875685] block nvme1n1: no usable path - requeuing I/O
[ 1078.876588] block nvme1n1: no usable path - requeuing I/O
[ 1078.877456] block nvme1n1: no usable path - requeuing I/O
[ 1078.878248] block nvme1n1: no usable path - requeuing I/O
[ 1078.879115] block nvme1n1: no usable path - requeuing I/O
[ 1089.130331] nvme_ns_head_submit_bio: 5 callbacks suppressed
[ 1089.131050] block nvme1n1: no usable path - requeuing I/O
[ 1089.131925] block nvme1n1: no usable path - requeuing I/O
[ 1089.132619] block nvme1n1: no usable path - requeuing I/O
[ 1089.133446] block nvme1n1: no usable path - requeuing I/O
[ 1089.134082] block nvme1n1: no usable path - requeuing I/O
[ 1089.134724] block nvme1n1: no usable path - requeuing I/O
[ 1089.135464] block nvme1n1: no usable path - requeuing I/O
[ 1089.136070] block nvme1n1: no usable path - requeuing I/O
[ 1089.137102] nvme nvme1: creating 16 I/O queues.
[ 1089.181184] nvme nvme1: mapped 16/0/0 default/read/poll queues.
[ 1089.196437] nvme nvme1: Successfully reconnected (1 attempt)
[ 1119.827490] nvme nvme0: queue 16: timeout request 0x1a type 6
[ 1119.828223] nvme nvme0: starting error recovery
[ 1119.828801] nvme nvme0: queue 16: timeout request 0x1b type 4
[ 1119.829456] block nvme0n1: no usable path - requeuing I/O
[ 1119.830006] block nvme0n1: no usable path - requeuing I/O
[ 1119.830337] nvme nvme0: Reconnecting in 10 seconds...
[ 1119.830664] block nvme0n1: no usable path - requeuing I/O
[ 1130.088305] block nvme0n1: no usable path - requeuing I/O
[ 1130.089473] block nvme0n1: no usable path - requeuing I/O
[ 1130.090319] nvme nvme0: creating 16 I/O queues.
[ 1130.132996] nvme nvme0: mapped 16/0/0 default/read/poll queues.
[ 1130.133572] debugfs: Directory 'hctx0' with parent '/' already present!
[ 1130.134086] debugfs: Directory 'hctx1' with parent '/' already present!
[ 1130.134669] debugfs: Directory 'hctx2' with parent '/' already present!
[ 1130.135196] debugfs: Directory 'hctx3' with parent '/' already present!
[ 1130.135766] debugfs: Directory 'hctx4' with parent '/' already present!
[ 1130.137374] debugfs: Directory 'hctx5' with parent '/' already present!
[ 1130.138070] debugfs: Directory 'hctx6' with parent '/' already present!
[ 1130.138782] debugfs: Directory 'hctx7' with parent '/' already present!
[ 1130.139553] debugfs: Directory 'hctx8' with parent '/' already present!
[ 1130.140114] debugfs: Directory 'hctx9' with parent '/' already present!
[ 1130.140728] debugfs: Directory 'hctx10' with parent '/' already present!
[ 1130.141502] debugfs: Directory 'hctx11' with parent '/' already present!
[ 1130.142111] debugfs: Directory 'hctx12' with parent '/' already present!
[ 1130.142763] debugfs: Directory 'hctx13' with parent '/' already present!
[ 1130.143535] debugfs: Directory 'hctx14' with parent '/' already present!
[ 1130.144114] debugfs: Directory 'hctx15' with parent '/' already present!
[ 1130.150104] nvme nvme0: Successfully reconnected (1 attempt)
---

I see the timeouts almost immediately after starting iozone. As expected I see 
IO blocked for a couple of seconds untill host reconnects back.

Here is my test:
-> create 4 NVMF-TCP targets with 1gb ramdisk namespace each.
-> discover and connect all targets.
-> format nvme devices as ext4, mount them. (# mkfs.ext4 -F /dev/nvme0n1)
-> run iozone over all mounted disks (# iozone -a -g 512m)

What else can I check?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
