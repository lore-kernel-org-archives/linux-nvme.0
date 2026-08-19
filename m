Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35C2C5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 06:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9djQu0T9n91GdufdgQ7vKT8VOZoi1LzDFFjF74vNil8=; b=zdiWY2Yu+yMVYTXLagWi9+MxzW
	OJueI7rFPSL3zlyREGGMtZzZQZ5U2l9ovtD2QquIhEiNV/bqFKGWNTq6DSDGOhH44/q7OH8XQwq1z
	1sDiWavE9rSURoPKLkHMVdRmMtcGTJM+zu6W5Axm3Z0ulxDfKY6PMyDDGILOqTe48R4qt/U4ge4Pk
	nhm8D6Q6BrvPgxLNI90NnF1waWFw7eDAxZTIv3r1NuiU+svLhCfuFqy5I4TIL75covEHHxNcRYZL8
	0ftMPRxmLY6CKe5xC0C4xN0UDgqr3niPZ4geWzpWs+E/Ho0cqEhkxWHo6Ed3ZkF9bIPy68LB51KkH
	XZ3N5tZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwa2o-0000000979E-1uP6;
	Wed, 19 Aug 2026 06:45:02 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwa2m-0000000978F-0vPy
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 06:45:02 +0000
X-UUID: 7a4a47449b9911f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9d47f9ec-f4eb-49b9-a9aa-63616eada200,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:8680156d63706c8edac0203147788cea,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50,EDM:-
	3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7a4a47449b9911f19a56ed5b684f684d-20260819
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 636558454; Wed, 19 Aug 2026 14:44:50 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 0/1] nvme-rdma: fix -EIO cleanup order in queue_rq
Date: Wed, 19 Aug 2026 14:30:00 +0800
Message-ID: <cover.v2.1787121041.git.liuxixin@kylinos.cn>
In-Reply-To: <nvme-rdma-queue-rq-eio-unmap.v1.git.liuxixin@kylinos.cn>
References: <nvme-rdma-queue-rq-eio-unmap.v1.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_234500_973537_AADDE24B 
X-CRM114-Status: UNSURE (   6.41  )
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

Thanks Christoph for the if/else readability suggestion on the
RESOURCE versus IOERR branch.

Changes since v1:
- use if/else for RESOURCE versus IOERR as suggested by Christoph
- initialize err to 0 for the shared unmap_qe path

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvme-rdma: fix -EIO cleanup order in queue_rq

 drivers/nvme/host/rdma.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.53.0


