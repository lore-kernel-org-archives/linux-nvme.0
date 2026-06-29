Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0B1C43327
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kJAs2qPW70jiaqHLx6WE/vxBbcx6SffFDxzVV1eEjLs=; b=mB0aj3KcFaVjbz1ClXhyqPQ0VV
	Pj43F5J4PYE24Mjvx6diwZCiaSreSbIapXuiTZlLQjr5IRWfMKwsXTIaWSbKw9I/cZiJyxUwUA/f9
	cNgMaYhLxAdK0gRQk42RRmn5LXbCA4GG8bVdHozJ11f4e6HCtFRaWWQ7yMKNIbQSrSnjkzVbn030b
	1oHDu6f97i+8rwNvVI1408JfjwLRA7Hystktg2fha3o19neKN3CbP1Y+XUOWegfsOFc8tDW23myvu
	MwruF0sifRRh+PivriAdkQszSfaj7RVwQE8g03oXH1TS0ykARyJCZ+UH7O1CKLMv+b6AwCtkVJM/U
	WJa6II4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we6WI-0000000DuxB-1OG9;
	Mon, 29 Jun 2026 07:35:06 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we6WF-0000000Duu2-1Hxm
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 07:35:05 +0000
X-UUID: 02fd57be738d11f1aa26b74ffac11d73-20260629
X-CID-CACHE: Type:Local,Time:202606291531+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3dcdc528-64ee-4586-bada-307b5f916fde,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:8a9baedd4c1fb40683bf8dc74bdf8d44,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15
	|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 02fd57be738d11f1aa26b74ffac11d73-20260629
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1337076712; Mon, 29 Jun 2026 15:34:50 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Subject: Re: blktests nvme/062 lockdep — defer TLS inline send to io_work?
Date: Sun, 29 Jun 2026 15:00:00 +0800
Message-ID: <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn>
In-Reply-To: <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de>
References: <ajtk1CaN1pBreS4O@shinmob>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_003503_670250_D3DEE4FC 
X-CRM114-Status: UNSURE (   6.10  )
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

Thanks for the feedback — I ran the lockdep and perf checks you suggested.

try_send vs send_all (lockdep)
------------------------------
With PROVE_LOCKING=y, blktests nvme/062:

  Inline nvme_tcp_try_send() instead of send_all() does *not* fix the
  lockdep splat: TLS would still call tls_sw_sendmsg() from queue_rq
  under blk_mq srcu — same as you suspected.

Performance / latency (skip TLS inline send)
----------------------------------------------
Same-machine nvmet-tcp with TLS (lockdep disabled for timing).  Compared
inline send_all (baseline) vs skipping inline send for TLS (io_work).
fio randwrite 4k, direct I/O:

  - iodepth=128, 8 jobs, 30s: ~90k IOPS baseline vs deferred after
    baseline warmup; no regression.

  - iodepth=1, 1 job, 30s (3 runs, warmup discarded): mean ~786us
    vs ~764us, p99 ~1.39ms on both sides.

  - 20x (connect --tls, one 4k write, disconnect): ~917ms vs ~897ms
    mean; dominated by TLS handshake, no measurable difference.

If the above is not enough on the latency side, I would be happy to
run other workloads you suggest.

Thanks,
Xixin Liu


