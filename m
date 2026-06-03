Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84176CD6E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 03:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7ux9AKpVskEWjJWxvOMPzjM8QPzn/gPGdCk3Y4wr9x4=; b=0MYdK/DIRzKWSU4/HyCykzQ78E
	xHGV3dWm8mmKeRCE/PbFF8k37CoSMaxxkP+JLyeJkUpzecMaWRkHYFERksepKXE1giBibytSqfVYZ
	vD35aGqgh316B8yxQuJrz46Qd0yHo28CMk0wtIqfMc8cU0nVwxPLA5I67Rygt8HHQDNhmOGx3rLEn
	lpFQrTp82cE+7Fxq1Rq5n2FF4pLolWToQD33zApzYt/7t/p9nXYfvPrlKMoiSJsBNYjg0wkfZZM3m
	xO/U0CfRHCRUsZXUqjY2wfZlX7sH3e5BJApNQUdWR98kTVqYF22wKM2e/XhQolYDLCvBcdcBTmdnc
	cgc8kTnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUyKW-0000000G4uo-0Die;
	Thu, 04 Jun 2026 03:01:12 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUyKS-0000000G4sZ-0kDz
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 03:01:10 +0000
X-UUID: 980d40f65fc111f1aa26b74ffac11d73-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8e8b6ed4-8448-42f6-9eba-f7b39c0178f1,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:28a6badb55f55c07da44bfc1c29ce9af,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 980d40f65fc111f1aa26b74ffac11d73-20260604
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 703255889; Thu, 04 Jun 2026 11:00:50 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, liuxixin@kylinos.cn
Subject: [PATCH v1 0/1] nvmet-tcp: complete command on H2C protocol errors
Date: Wed, 3 Jun 2026 09:14:17 +0800
Message-ID: <cover.1780449274.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvmet-tcp/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_200108_531510_53B37B61 
X-CRM114-Status: UNSURE (   6.34  )
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

This series fixes the H2C Data PDU error path in nvmet-tcp.

When nvmet_tcp_handle_h2c_data_pdu() hits err_proto it used to return
-EPROTO without completing the associated command (there is even a
FIXME in that path).  The host often only sees the connection drop.
Complete commands that already have a valid transfer tag with
nvmet_req_complete() before returning -EPROTO.  Skip completion when
req->sq is unset (pre-connect placeholder).

Tested: make M=drivers/nvme/target on linux-next; nvmet TCP target
with null-blk backend; nvme connect -t tcp loopback read smoke test;
malformed H2C Data PDU before Fabrics Connect and on an active Write
without kernel oops.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvmet-tcp: complete command on H2C protocol errors

 drivers/nvme/target/tcp.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

-- 
2.43.0


