Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4372CDB47F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 05:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NUYPzUSf3PdQJYf/XNNIrmW9dptYXtkI8R1fqybFRLc=; b=zynZw9Am+lh/nzc7eKz5Q15XT7
	hOsqD+0MfRviu0OaDYqmdT9nrXbWWId7BpkXSJdlcuw87H9PXspQgiRxBR6LxdZ6eAONwSbm29cC3
	Lx7mbO2LoG0DEm8q8NaH5t73VLiFsq8ms8xC7J6//MSS6v1UUXBHXNybrCh10VSzpANAdoefblGEj
	M/tYzBD7nGPi7Pyxis5PPMScXkQdsLF1pL7aXI2dQQqmld70BvFntRvqVDGdCy0FaJ3VXXUzOw9iQ
	V/j3//JGS5UGymB7kF/5so9iKfhOhiH/vvY3+PGY04xTIwiNxkwutXp3y3ADbIJAWJSSIHZ7lDXxY
	Z3p45pAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcGSb-00000007Auk-0dWd;
	Wed, 24 Jun 2026 05:47:41 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcGSX-00000007Au0-0p89
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 05:47:39 +0000
X-UUID: 2b67bc906f9011f1aa26b74ffac11d73-20260624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:63ed823e-78d4-4329-9908-dac20550a3fb,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:da51d481b21873dbf0d7783d2afb6243,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2b67bc906f9011f1aa26b74ffac11d73-20260624
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1156286716; Wed, 24 Jun 2026 13:47:21 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 0/1] nvme: zns: cap zone report nr_zones by DMA buffer size
Date: Tue, 23 Jun 2026 17:35:40 +0800
Message-ID: <cover.1781842540.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvme-ecn124/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_224737_571978_F513BE4D 
X-CRM114-Status: UNSURE (   4.98  )
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

The ZNS host driver issues Zone Management Receive with Partial Report
(PR=1) fixed.  The Number of Zones (NZ) field in the report header must
reflect the zone descriptors actually transferred in the DMA buffer (ZNS
Command Set Specification Rev 1.2, section 3.4.2).

nvme_ns_report_zones() caps the parse loop by the device-reported NZ and
the caller's nr_zones limit, but not by the number of descriptors that fit
in buflen.  Cap nz with min3(device NZ, nr_zones - zone_idx, max_in_buf).

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvme: zns: cap zone report nr_zones by DMA buffer size

 drivers/nvme/host/zns.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.43.0


