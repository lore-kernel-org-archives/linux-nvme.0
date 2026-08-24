Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB1DC5DF8C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uQYM/Xa1lh6tbMdzvCYe7MJgnLM/gr85swWhTZREnxc=; b=gmeuasfEMT3yFu5WMtKXVAGtvY
	MNvyq1SCOqyyYgLd/FRWZBYbD7cVqBDTesf0FNTrfe1ajM5IOkidzbWvHlZwNyCL46alG+hED6SzS
	3wiqxvfOV+slX+R0ozebc5IlEbFu+LDPw+yx6s9mwyGy0ZZrbnSpof1qJfHeDJvuq1mTda2qazvq+
	OzxAP2apvPWN2Ew8SFfSSig9p3Goj9QWe9+kD+uJgBrxPjBXChMqBHhdvkR040UrA8mWggqT7ZCeK
	IqhnY6Ltz+UYoBtqNLbaJFWLq3LXu5Z5y9smmofGXAGHocuqLh9V1otJOd0aiiIOy/k5lAWSgE5He
	tgqW1Dcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyNnn-0000000FxPq-1fFu;
	Mon, 24 Aug 2026 06:04:59 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyNnj-0000000FxPE-30mG
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 06:04:57 +0000
X-UUID: b3d943e89f8111f19a56ed5b684f684d-20260824
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:f76345bb-68a7-4973-b4fd-bb13850b7ec7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:858a5a996be75465cf7d98c8bd10b2bd,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b3d943e89f8111f19a56ed5b684f684d-20260824
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 510788427; Mon, 24 Aug 2026 14:04:44 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: sagi@grimberg.me
Cc: hare@suse.de, hare@kernel.org, axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org, liuxixin@kylinos.cn, shinichiro.kawasaki@wdc.com
Subject: Re: blktests nvme/062 lockdep, defer TLS inline send to io_work?
Date: Mon, 24 Aug 2026 14:00:00 +0800
Message-ID: <reply-sagi.062lockdep.formal-already.20260824.liuxixin@kylinos.cn>
In-Reply-To: <cb6890a5-81d3-49a1-9179-08a453f5bd4d@grimberg.me>
References: <ajtk1CaN1pBreS4O@shinmob> <cover.1782436781.git.liuxixin@kylinos.cn> <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de> <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn> <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn> <aoPuIUSQvZxujmv7@shinhome> <ee0225fa-6a0b-4933-9a4d-5c77792eb94b@suse.de> <reply-hannes.062lockdep.formal-v1.20260819.liuxixin@kylinos.cn> <c6e2a91f0b62.1787100300.git.liuxixin@kylinos.cn> <cb6890a5-81d3-49a1-9179-08a453f5bd4d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_230456_063728_B64D9A3B 
X-CRM114-Status: UNSURE (   3.33  )
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

Hi Sagi,

Thanks for the Reviewed-by.

The formal patch is already on the list as of 2026-08-19:

  [PATCH] nvme-tcp: defer TLS inline send to io_work
  <c6e2a91f0b62.1787100300.git.liuxixin@kylinos.cn>

Thanks,
Xixin Liu


