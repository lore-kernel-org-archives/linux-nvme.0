Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88375C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 01:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ewv9qY40mwRWH+z517DiAqPJJT29u3XlZFRHH+gaM8=; b=z49Od172s32c3o5PDZXRf1TiSA
	GNxnM/FLMjMUNaP/wMmbNft+zAewY6vnJnUByhlYSem+Ugs2O048vjyBkA165bNpPnPHri8HGHeBp
	U/vIg9/0hbScUzh+TZLFnL6tzOGA+e8t9dExEjdYfsFjNpyKe9WcIgt43t5eVigajPRV1QW91LQhB
	xSiNNB8Unm4hFKz15KvLASPY9JvVHyrmY65pVg5vIvw+91Q7sOGQSTkV+Z3rAB5VLr3UXzQMQfjsj
	Rk9v7w1NrP8FGm5JfyWqmnobHlxJvbdfij+1RPXoBkWUxXVUMJFJeYOh4lKeEJMzzCx/VKxxMihmq
	wgK3xwtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wek7i-00000000TNB-2dI0;
	Wed, 01 Jul 2026 01:52:22 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wek7e-00000000TMa-48tk
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 01:52:21 +0000
X-UUID: 776213c074ef11f1aa26b74ffac11d73-20260701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:43a14c82-540c-4858-bd1a-a553a40e96c2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f9147111aa2ade0c25ffc934bdfb6214,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15
	|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 776213c074ef11f1aa26b74ffac11d73-20260701
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 632858861; Wed, 01 Jul 2026 09:52:07 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: hare@suse.de
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org, liuxixin@kylinos.cn, sagi@grimberg.me, shinichiro.kawasaki@wdc.com
Subject: Re: blktests nvme/062 lockdep — defer TLS inline send to io_work?
Date: Wed, 1 Jul 2026 09:50:43 +0800
Message-ID: <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn>
In-Reply-To: <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn>
References: <ajtk1CaN1pBreS4O@shinmob> <cover.1782436781.git.liuxixin@kylinos.cn> <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de> <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_185219_341100_133C893B 
X-CRM114-Status: UNSURE (   7.25  )
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

Hi Hannes,

On Mon, 29 Jun 2026, Hannes Reinecke wrote:
> The most likely testcase showing regressions would be having as many
> jobs as your machine has CPUs and use qd=1.
> Just a single job will not be enough to show a noticeable difference.

I re-ran the TLS perf comparison with one job per CPU and queue depth 1
on a new test host.  Please treat the results below as the authoritative
perf data for this workload.

Test setup
----------
  aarch64 server, 128 CPUs, linux-next 7.2.0-rc1-*-perf-dirty

  Same-machine nvmet-tcp with TLS; target backing store is a 32G file on a
  local NVMe SSD.  fio runs against the connected nvme-tcp namespace.

  Compared inline send_all (baseline) vs deferring TLS inline send (io_work).
  fio randwrite 4k, direct I/O, 30s per run, 15s warmup discarded before
  each mode (10 runs total):

  - iodepth=1, numjobs=128:
      baseline 54539.4 IOPS, mean 2.34ms, p99 6.02ms
      patched  54529.0 IOPS, mean 2.34ms, p99 5.99ms

  - iodepth=128, numjobs=8:
      baseline 54632.6 IOPS, mean 18.74ms, p99 47.08ms
      patched  54633.6 IOPS, mean 18.74ms, p99 46.92ms

So on a 128-CPU box with the workload you called out, deferring TLS inline
send still looks neutral across 10 consecutive runs after warmup.

Thanks,
Xixin Liu


