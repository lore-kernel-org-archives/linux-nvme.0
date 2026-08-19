Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9201C5DF85
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 09:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pBEmQEYF4cErvtJNNrYgSEczgaQ9KBwOuqwwwVoE+HI=; b=TMM2bQJDa1fYSYo2DC/6hxK2e2
	Avsv4zaK1PdbVmIlRoO3ggPfOx7wahX7RBvh+YdoUKesNodsNz/Zut/3aPMzoyKMtLwkkTm3NmscT
	dYGPryU9cR2xszCVBjK87jxHAKoHn2tTi1eWEJhJ09svM3Q1o1GcZij8P+M0gprFgoV27YxpYbSvw
	/Y3YoXVS1+vMZZhef6QpurLq2JIXb5K5N0HbkXsY4cIVrBAIFqGpXCwE1QZbkaQfHVqrU+rV3QJ6B
	bI+ATHe/zTPX4eOW9ZLFK55Tv8eUIjRFnQtMoyL6UTfVg1ZyNANv/Rddr61o3cSqT1OamGMe9fr0q
	A5sQY57Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcqs-00000009RT8-0hWk;
	Wed, 19 Aug 2026 09:44:54 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcqp-00000009RRV-0vR5
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 09:44:53 +0000
X-UUID: 98fbf98a9bb211f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d8ad63da-c5f3-47f8-81b3-7109db4fdc1e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:4274b6601e69aa7beaaa05fc6ea148ea,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 98fbf98a9bb211f19a56ed5b684f684d-20260819
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1614918530; Wed, 19 Aug 2026 17:44:39 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: hare@suse.de
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org, liuxixin@kylinos.cn, sagi@grimberg.me, shinichiro.kawasaki@wdc.com, hare@kernel.org
Subject: Re: blktests nvme/062 lockdep, defer TLS inline send to io_work?
Date: Wed, 19 Aug 2026 09:05:00 +0800
Message-ID: <reply-hannes.062lockdep.formal-v1.20260819.liuxixin@kylinos.cn>
In-Reply-To: <ee0225fa-6a0b-4933-9a4d-5c77792eb94b@suse.de>
References: <ajtk1CaN1pBreS4O@shinmob> <cover.1782436781.git.liuxixin@kylinos.cn> <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de> <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn> <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn> <aoPuIUSQvZxujmv7@shinhome> <ee0225fa-6a0b-4933-9a4d-5c77792eb94b@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_024451_562931_575BA932 
X-CRM114-Status: UNSURE (   3.90  )
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

Thanks for the Reviewed-by.

I will send the TLS-only change as a formal patch on this thread:
skip the inline send for TLS queues and keep plain TCP on the
inline path.

You also suggested dropping the whole inline send condition.  I will
try that design locally and need more analysis before proposing it.
It is not part of this formal patch.

Thanks,
Xixin Liu


