Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800F5C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 07:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9dfno0EDnv7jKGr4wnkCTjOnotEiNEsT7PJLN8E3mYg=; b=jx+Nz6OrvF+Xpn5sqQPU9mQFWc
	BHizxabRzTCyRTHWxVsi+nUQoM1sV2bDhR4glZyuF2zSMVxsvS1lmiD/G0zCYlG+PJIyVFeLcUa96
	HLJd6zizuMyDZl9PglzUpUQJtGmP06dZDBioGxzmupXg+idqSoUm2zvdkgQreR5U2dODfjAqdOfnL
	FHk2shWz94LvGORAEtogUoP1Wj0ltrKsygSD7o4HpgU0TgGlL620c48Mc0KvlppbbPTSUvAKtraE0
	/mj6p0ddHQjSi+5cmftdvxZMCHiwQBasHTRbHPiGDFiTMOHuyiudpMPkAQWkgJpvS9xu1hdL3fbLG
	jKruc++A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjBXT-00000008VaU-3FRk;
	Mon, 13 Jul 2026 07:57:19 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjBXO-00000008VYx-38gS
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 07:57:18 +0000
X-UUID: 6e1839847e9011f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:87520071-a1cc-4bf9-9833-3477f95a88a7,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:fa1e937da7a321d6fbd9060e513b0d06,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6e1839847e9011f1aa26b74ffac11d73-20260713
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 27721846; Mon, 13 Jul 2026 15:57:01 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, liuxixin@kylinos.cn
Subject: [PATCH nvmet-v2 0/1] nvmet: zns: reject full zone report when buffer is too small
Date: Mon, 13 Jul 2026 18:00:00 +0800
Message-ID: <cover.nvmet-v2.1783940400.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1783579899.git.liuxixin@kylinos.cn>
References: <cover.1783579899.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_005715_101782_D18228BA 
X-CRM114-Status: UNSURE (   5.64  )
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

Hi Christoph,

Thanks for the review — folded the nested if into else if.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvmet: zns: reject full zone report when buffer is too small

 drivers/nvme/target/zns.c | 13 +++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.43.0


