Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421F5CD6E55
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 03:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ght77JwMPxxTkARW57YoY1APDe/16ji7ZDRUHjo3/+k=; b=VtSLPXHZIDxvcSzlxVaSyCXFaU
	LXbBp50m1ZQ+u3J9KiCRhL0nZGhrRYJJD9AfAcjjHFG6Y1XAmq0wMQtNMXAsY+hrsBRr1qLKErV2r
	drAgw3i0lhu7JYVCezVK3E7byFeQtKmH/8u3KcTS/iNZULZwAr9AXg+ysCSpQ1ca2L2NFhY3wQtH2
	7zVGAPW15ZTlhzfD87+GLjf9AdXsoywzYUxDuQGk6jgJgrRwNL79HKxBDdGoUpn73DnNOtFR4DJ8A
	ByFbOdbW/ksHwOLeSsF1CKP7m0Mrg/su24S1K6CzhtaEJrQP2cZVnoSYFjvkAURwuZuz90AStd5co
	eZtHEmkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUykJ-0000000G6Ai-3iHN;
	Thu, 04 Jun 2026 03:27:51 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUykG-0000000G6AA-2tYi
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 03:27:50 +0000
X-UUID: 58b5ae265fc511f1aa26b74ffac11d73-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:028026df-7b24-42f8-9898-67cb2e239024,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:bacc47676e27c65fa7507f9b06bc5691,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 58b5ae265fc511f1aa26b74ffac11d73-20260604
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 654430822; Thu, 04 Jun 2026 11:27:42 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, liuxixin@kylinos.cn
Subject: [PATCH v1 0/1] nvmet-tcp: fix typos in tcp.c
Date: Wed, 4 Jun 2026 18:00:00 +0800
Message-ID: <cover.typo-v1.1780449274.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvmet-tcp/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_202749_065794_5BF64CC0 
X-CRM114-Status: UNSURE (   6.07  )
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

Hi,

Two cosmetic fixes in nvmet-tcp (no functional change):

- so_priority comment: "were" -> "where"; use the same block comment
  style as host/tcp.c (see f947d9e77b26 "nvme/host: fixup some typos").
- pr_err for invalid ttag: "out of bound" -> "out of bounds".

Tested: scripts/checkpatch.pl on the diff.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvmet-tcp: fix typos in tcp.c

 drivers/nvme/target/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.43.0


