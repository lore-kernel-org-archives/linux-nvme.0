Return-Path: <SRS0=VSZw=Y4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADE8CA9EA0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 10:19:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3A821D7F
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2019 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nP8/wR4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3A821D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hxyE8PU66RwmB1N/Rj25C7wRTumuHuoO0YENp3Rrt1I=; b=nP8/wR4OC49kWe
	Tm7MUFWTAtTPoWgvZVt0PZv4OUaC7mX1X2kS1g4NyX97zqnojkp3yEbtgp9R8sBGLNeYQh/D/fvZH
	tF/NiizwdURq20MCv+HRBoFFTXjVgqj5tKxiYLw77clcL7X96bfWJYnWcvXabFf6dnkBeF+cUNLI8
	IS9J7d2pBl7Bf5glbij0mumG9gQPfQSkg88nDR9wgtTi2atsmyhJI9De2wKxrZ3pJVLjWUjpZrXlE
	sqL60hz3bodbW16WdQ2gP2SMjjt+ViZz4Oqg218OlavPHGGmCQh9Q4z/FHwCs4D5GwGIEiQqBU3Rk
	nwL8B8woTaa2srcf/kWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iRZSX-0007Ra-8m; Mon, 04 Nov 2019 10:19:41 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iRZST-0007R4-RO
 for linux-nvme@lists.infradead.org; Mon, 04 Nov 2019 10:19:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EE47FAC3E;
 Mon,  4 Nov 2019 10:19:35 +0000 (UTC)
Date: Mon, 4 Nov 2019 11:19:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] nvmet: Always remove processed AER elements from list
Message-ID: <20191104101935.lzdhraz5wnd56g4r@beryllium.lan>
References: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
 <20191104081338.gdrk2a4mlov2io6s@beryllium.lan>
 <20191104095034.GA3193@linux-lxv2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104095034.GA3193@linux-lxv2>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191104_021938_178958_E575FFA3 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 04, 2019 at 10:50:34AM +0100, Johannes Thumshirn wrote:
> On Mon, Nov 04, 2019 at 09:13:38AM +0100, Daniel Wagner wrote:
> [...]
> > BTW, I got feedback how to produce the oops on our custerms setup:
> > 
> > Test Steps:
> > 1. Create two targets on node n1 as target side (tgt1 and tgt2)
> > 2. Run perf to write data to tgt2:
> >    sudo ./perf -q 1 -w read -o 4096 -t 60 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4421'
> > 3. Deleted tgt2 node n1 configuration during perf execution
> >    and reboot the node n1 automatically.

sudo rmdir subsystems/199212f7-33d0-46c3-b362-e47a217c2c49/namespaces/2
sudo unlink /sys/kernel/config/nvmet/ports/2/subsystems/199212f7-33d0-46c3-b362-e47a217c2c49
sudo rmdir subsystems/199212f7-33d0-46c3-b362-e47a217c2c49/
sudo rmdir ports/2/

> I assume thhis "perf" is some kind of performance test. So it should be
> possible to create a blktest recreating this issue.
> 
> I'd translate the "perf" line into something similar to 'fio -rw=read -bs 4k \
> --time_based --timeout=60 --iodepth=1' and then running on a mpathed
> nvme-loop and delete one of the controllers while the IO is running. This
> should be a fairly usual multi-path test. The only thing I can't see yet
> is, how we end up with unprocessed AENs here.

The 'perf' command seems to be able to write to a specific target. At
least I read this from from another command I see in the feedback I
got:

  Run perf to write data to tgt1 and tgt2 for a long time , command:
    sudo ./perf -q 1 -w read -o 4096 -t 600000 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4420'
    sudo ./perf -q 1 -w read -o 4096 -t 600000 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4421'


Anyway, also have a few lines from dmesg before the crash (this is
without the patch):

[ 1507.453659] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0052-3910-8036-c7c04f315332.
[ 1507.453794] nvme nvme12: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.219.4:4421
[ 1507.453925] nvme nvme12: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1926.227086] nvmet: creating controller 1 for subsystem 416d7463-d3c2-41e4-b2f5-76df2ed3db26 for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0052-4210-8033-c7c04f315332.
[ 1927.992304] nvmet: creating controller 2 for subsystem 199212f7-33d0-46c3-b362-e47a217c2c49 for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0052-4210-8033-c7c04f315332.
[ 2135.800592] nvmet: adding nsid 2 to subsystem 199212f7-33d0-46c3-b362-e47a217c2c49
[ 2137.174479] nvmet_rdma: enabling port 2 (192.168.219.4:4421)
[ 2138.597566] nvmet: creating controller 2 for subsystem 199212f7-33d0-46c3-b362-e47a217c2c49 for NQN nqn.2014-08.org.nvmexpress:uuid:4c4c4544-0052-4210-8033-c7c04f315332.
[ 2912.103808] nvmet: ctrl 2 keep-alive timer (15 seconds) expired!
[ 2912.103812] nvmet: ctrl 2 fatal error occurred!
[ 4005.326810] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN 2014-08.org.nvmexpress:uuid:a9ebf41b-201c-42e1-9b09-4dd7fb70e2c5.
[ 4005.329045] nvmet: creating controller 2 for subsystem 416d7463-d3c2-41e4-b2f5-76df2ed3db26 for NQN 2014-08.org.nvmexpress:uuid:a9ebf41b-201c-42e1-9b09-4dd7fb70e2c5.
[ 4068.052392] nvmet: adding nsid 2 to subsystem 199212f7-33d0-46c3-b362-e47a217c2c49
[ 4068.106984] nvmet_rdma: enabling port 2 (192.168.219.4:4421)
[ 4078.581846] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN 2014-08.org.nvmexpress:uuid:742c21ef-fcee-4b64-aec1-6063ae5710e4.
[ 4078.583849] nvmet: creating controller 2 for subsystem 199212f7-33d0-46c3-b362-e47a217c2c49 for NQN 2014-08.org.nvmexpress:uuid:742c21ef-fcee-4b64-aec1-6063ae5710e4.
[ 5076.654122] nvmet: adding nsid 1 to subsystem 416d7463-d3c2-41e4-b2f5-76df2ed3db26
[ 5076.720100] nvmet_rdma: enabling port 1 (192.168.219.4:4420)
[ 5076.744432] nvmet: adding nsid 2 to subsystem 199212f7-33d0-46c3-b362-e47a217c2c49
[ 5076.804401] nvmet_rdma: enabling port 2 (192.168.219.4:4421)
[ 5115.805550] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN 2014-08.org.nvmexpress:uuid:988626aa-4466-44dc-8142-6bfc382192e3.
[ 5115.807714] nvmet: creating controller 2 for subsystem 199212f7-33d0-46c3-b362-e47a217c2c49 for NQN 2014-08.org.nvmexpress:uuid:988626aa-4466-44dc-8142-6bfc382192e3.
[ 5136.186393] general protection fault: 0000 [#1] SMP PTI
[ 5136.191643] CPU: 14 PID: 54995 Comm: kworker/14:1 Tainted: G           OE      4.12.14-95.19.1.17807.0.PTF.1134097-default #1 SLE12-SP4
[ 5136.203873] Hardware name: Dell Inc. PowerEdge R740xd/01KPX8, BIOS 1.5.4 07/30/2018
[ 5136.211554] Workqueue: events nvmet_async_event_work [nvmet]
[ 5136.217230] task: ffff983bdb11d0c0 task.stack: ffffafc449b58000
[ 5136.223169] RIP: 0010:nvmet_async_event_work+0x5e/0xb0 [nvmet]
[ 5136.229017] RSP: 0018:ffffafc449b5be58 EFLAGS: 00010202
[ 5136.234258] RAX: dead000000000100 RBX: ffff983b99b830b0 RCX: 0000000000000002
[ 5136.241404] RDX: 0000000000040002 RSI: 38ffff983bdb3c05 RDI: ffff983bdb9412c0
[ 5136.248552] RBP: ffff983b99b83018 R08: 00000000fffffff0 R09: 0000000000000000
[ 5136.255709] R10: fffffffffffffff4 R11: ffffffffffffff83 R12: ffff983b99b830a0
[ 5136.262887] R13: ffff983bcaa55f29 R14: 0000000000000000 R15: 0ffff983c501e860
[ 5136.270045] FS:  0000000000000000(0000) GS:ffff983c501c0000(0000) knlGS:0000000000000000
[ 5136.278160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5136.283925] CR2: 00007f06d9f246e0 CR3: 00000032ed00a001 CR4: 00000000007606e0
[ 5136.291073] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5136.298236] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5136.305398] PKRU: 55555554
[ 5136.308121] Call Trace:
[ 5136.310587]  process_one_work+0x14c/0x390
[ 5136.314619]  worker_thread+0x47/0x3e0
[ 5136.318294]  kthread+0xff/0x140
[ 5136.321462]  ? max_active_store+0x60/0x60
[ 5136.325503]  ? __kthread_parkme+0x70/0x70
[ 5136.329526]  ret_from_fork+0x35/0x40
[ 5136.333131] Code: b8 00 01 00 00 00 00 ad de 89 53 e8 4c 8b 6c d3 c8 0f b6 4f 12 0f b6 57 11 49 8b 75 08 c1 e1 10 c1 e2 08 09 ca 0f b6 4f 10 09 ca <89> 16 48 8b 0f 48 8b 57 08 48 89 51 08 48 89 0a 48 89 07 66 b8


At 2912 tgt2 is propably deleted. I wonder why there are two "enabling
port 2" after it.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
