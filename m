Return-Path: <SRS0=G3e6=FS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC01EC4361B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 18:06:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F72B2246B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 18:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F72B2246B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w3BS7DxjpVF8aaxdB4pbCvk6UUCC28D1m6iyuPwOHfw=; b=qSrPQu6a/jvd3uPZjwpzvNfVp
	LJ9hPzogNU/LS1BlDlFIRMuoGnXYWBbOIqOLe4Ckk2uAqyEVYKXJDmlfyW6pFs6RNIP8ujeYmii1L
	2lWJwH2mb8he+NHu8gBIHI+O6RP1asl+jGsHdUSCTnKo6Mqdzj62VMA9HwHSb+NNdR0Zc55fZqe4v
	mgqIprnVEj/6H70LrFUvILpHqCSjtTtzmvYeIxLfqS5Nk/zaXnpJJunor6m4DnhRgwRJxVrI7D4Gt
	L5Hv9zoE2D4ra5CKySqx7Zgr3FZx+XIbJ0BjnxXj3RL+Pr+nXSnrhqHmvWmJti2PWuNy5NneYjRUW
	MFrXWAemg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kosEa-0005XI-2p; Mon, 14 Dec 2020 18:06:08 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kosEW-0005Ws-Jo
 for linux-nvme@lists.infradead.org; Mon, 14 Dec 2020 18:06:05 +0000
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0BEI5W4P028753;
 Mon, 14 Dec 2020 10:05:32 -0800
Date: Mon, 14 Dec 2020 23:35:31 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Request timeout seen with NVMEoF TCP
Message-ID: <X9epa3PPORdBKZ71@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
 <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_130604_849111_40989993 
X-CRM114-Status: GOOD (  19.78  )
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
Cc: Samuel Jones <sjones@kalrayinc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Monday, December 12/14/20, 2020 at 09:51:28 -0800, Sagi Grimberg wrote:
> 
> > Hi Sagi,
> > With above patch I still see the issue but less frequently. Without patch I was
> > able to consistently reproduce the timouts with 4 target devices. With patch I
> > see IO running fine for 4 targets. Tried the same test with 8 target devices
> > and I see the below timeout. I've observed only one instance of timeout. So,
> > I'll let it run for somemore time or rerun and update.
> 
> Hey Potnuri,
> 
> Have you observed this further?
> 
> I'd think that if the io_work reschedule itself when it races
> with the direct send path this should not happen, but we may be
> seeing a different race going on here, adding Samuel who saw
> a similar phenomenon.
> 

Yes, I have seen it further too but very intermittently. Below is the dmesg that
I saved before my test got stopped for some other reason. From the timestamps, 
timeouts were around ~20min, ~45min and ~3 hours apart.

dmesg on intiator:
---
[ 1735.038634] EXT4-fs (nvme7n1): mounted filesystem with ordered data mod                                                                                e. Opts: (null)
[ 2111.990419] nvme nvme5: queue 7: timeout request 0x57 type 4
[ 2111.991835] nvme nvme5: starting error recovery
[ 2111.998796] block nvme5n1: no usable path - requeuing I/O
[ 2111.998816] nvme nvme5: Reconnecting in 10 seconds...
[ 2122.253431] block nvme5n1: no usable path - requeuing I/O
[ 2122.254732] nvme nvme5: creating 16 I/O queues.
[ 2122.301169] nvme nvme5: mapped 16/0/0 default/read/poll queues.
[ 2122.314229] nvme nvme5: Successfully reconnected (1 attempt)
[ 2522.795467] perf: interrupt took too long (2503 > 2500), lowering kerne                                                                                l.perf_event_max_sample_rate to 79000
[ 3043.544758] perf: interrupt took too long (3135 > 3128), lowering kerne                                                                                l.perf_event_max_sample_rate to 63000
[ 4197.260041] perf: interrupt took too long (3922 > 3918), lowering kerne                                                                                l.perf_event_max_sample_rate to 50000
[ 4848.175367] nvme nvme1: queue 6: timeout request 0x42 type 4
[ 4848.176086] nvme nvme1: starting error recovery
[ 4848.176864] nvme nvme1: queue 6: timeout request 0x43 type 4
[ 4848.178194] nvme nvme1: queue 6: timeout request 0x44 type 4
[ 4848.179873] block nvme1n1: no usable path - requeuing I/O
[ 4848.180665] block nvme1n1: no usable path - requeuing I/O
[ 4848.180775] nvme nvme1: Reconnecting in 10 seconds...
[ 4848.181372] block nvme1n1: no usable path - requeuing I/O
[ 4848.183022] block nvme1n1: no usable path - requeuing I/O
[ 4848.183782] block nvme1n1: no usable path - requeuing I/O
[ 4858.436889] block nvme1n1: no usable path - requeuing I/O
[ 4858.437558] block nvme1n1: no usable path - requeuing I/O
[ 4858.438168] block nvme1n1: no usable path - requeuing I/O
[ 4858.439547] nvme nvme1: creating 16 I/O queues.
[ 4858.489650] nvme nvme1: mapped 16/0/0 default/read/poll queues.
[ 4858.490357] debugfs: Directory 'hctx0' with parent '/' already present!
[ 4858.491256] debugfs: Directory 'hctx1' with parent '/' already present!
[ 4858.492790] debugfs: Directory 'hctx2' with parent '/' already present!
[ 4858.493601] debugfs: Directory 'hctx3' with parent '/' already present!
[ 4858.494362] debugfs: Directory 'hctx4' with parent '/' already present!
[ 4858.495310] debugfs: Directory 'hctx5' with parent '/' already present!
[ 4858.496261] debugfs: Directory 'hctx6' with parent '/' already present!
[ 4858.497098] debugfs: Directory 'hctx7' with parent '/' already present!
[ 4858.497972] debugfs: Directory 'hctx8' with parent '/' already present!
[ 4858.498806] debugfs: Directory 'hctx9' with parent '/' already present!
[ 4858.499574] debugfs: Directory 'hctx10' with parent '/' already present                                                                                !
[ 4858.500268] debugfs: Directory 'hctx11' with parent '/' already present                                                                                !
[ 4858.501030] debugfs: Directory 'hctx12' with parent '/' already present                                                                                !
[ 4858.501807] debugfs: Directory 'hctx13' with parent '/' already present                                                                                !
[ 4858.502459] debugfs: Directory 'hctx14' with parent '/' already present                                                                                !
[ 4858.503196] debugfs: Directory 'hctx15' with parent '/' already present                                                                                !
[ 4858.510075] nvme nvme1: Successfully reconnected (1 attempt)
[12905.117166] perf: interrupt took too long (4944 > 4902), lowering kernel.perf_event_max_sample_rate to 40000
[15436.031342] nvme nvme0: queue 16: timeout request 0x22 type 4
[15436.031920] nvme nvme0: starting error recovery
[15436.033746] block nvme0n1: no usable path - requeuing I/O
[15436.035221] nvme nvme0: Reconnecting in 10 seconds...
[15446.292544] block nvme0n1: no usable path - requeuing I/O
[15446.293541] nvme nvme0: creating 16 I/O queues.
[15446.339595] nvme nvme0: mapped 16/0/0 default/read/poll queues.
[15446.340846] debugfs: Directory 'hctx0' with parent '/' already present!
[15446.342664] debugfs: Directory 'hctx1' with parent '/' already present!
[15446.343413] debugfs: Directory 'hctx2' with parent '/' already present!
[15446.344228] debugfs: Directory 'hctx3' with parent '/' already present!
[15446.345155] debugfs: Directory 'hctx4' with parent '/' already present!
[15446.345948] debugfs: Directory 'hctx5' with parent '/' already present!
[15446.346767] debugfs: Directory 'hctx6' with parent '/' already present!
[15446.347368] debugfs: Directory 'hctx7' with parent '/' already present!
[15446.348129] debugfs: Directory 'hctx8' with parent '/' already present!
[15446.348948] debugfs: Directory 'hctx9' with parent '/' already present!
[15446.349538] debugfs: Directory 'hctx10' with parent '/' already present!
[15446.350185] debugfs: Directory 'hctx11' with parent '/' already present!
[15446.350757] debugfs: Directory 'hctx12' with parent '/' already present!
[15446.351539] debugfs: Directory 'hctx13' with parent '/' already present!
[15446.352200] debugfs: Directory 'hctx14' with parent '/' already present!
[15446.352722] debugfs: Directory 'hctx15' with parent '/' already present!
[15446.358750] nvme nvme0: Successfully reconnected (1 attempt)

---


> > 
> > Target dmesg:
> > ---
> > [ 1704.132366] nvmet: creating controller 1 for subsystem nvme-ram0 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > [ 1704.185987] nvmet: creating controller 2 for subsystem nvme-ram1 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > [ 1704.230065] nvmet: creating controller 3 for subsystem nvme-ram2 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > [ 1704.277712] nvmet: creating controller 4 for subsystem nvme-ram3 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > [ 1704.314457] nvmet: creating controller 5 for subsystem nvme-ram4 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > [ 1704.370124] nvmet: creating controller 6 for subsystem nvme-ram5 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > [ 1704.435581] nvmet: creating controller 7 for subsystem nvme-ram6 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > [ 1704.501813] nvmet: creating controller 8 for subsystem nvme-ram7 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > [ 2103.965017] nvmet: creating controller 6 for subsystem nvme-ram5 for NQN nqn.2014-08.org.nvmexpress:uuid:77f6ffad-1c4a-4c0e-9f11-23cd4daf0216.
> > ^^^^^^^^^^^^^^^
> > ---
> > 
> > Initiator dmesg:
> > ---
> > [ 1735.038634] EXT4-fs (nvme7n1): mounted filesystem with ordered data mode. Opts: (null)
> > [ 2111.990419] nvme nvme5: queue 7: timeout request 0x57 type 4
> > [ 2111.991835] nvme nvme5: starting error recovery
> > [ 2111.998796] block nvme5n1: no usable path - requeuing I/O
> > [ 2111.998816] nvme nvme5: Reconnecting in 10 seconds...
> > [ 2122.253431] block nvme5n1: no usable path - requeuing I/O
> > [ 2122.254732] nvme nvme5: creating 16 I/O queues.
> > [ 2122.301169] nvme nvme5: mapped 16/0/0 default/read/poll queues.
> > [ 2122.314229] nvme nvme5: Successfully reconnected (1 attempt)
> > ---
> > 
> > 
> > Thanks.
> > 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
