Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB6FCD98E4
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2026 03:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AwSv1YQDCP6y4NiTu0AZ9c3/eYi+OygQL41jUGGPRsU=; b=IpZ7prd14YEU//5Zk7nJJNJ9Kr
	QdFlIdsgP7MovHgdNMZhav9ZwIiiSleqwAv7BhoyaociV/8CpQbrtaCCgfBMxxM91ruftGMGIIGfO
	qqL1cbizxBf+OlC32e6Jo/cTkDT0/AboDkTwprP3ev9oaDlYGeuMWIAkGETOms4SqeCKAZeQeAfCP
	ifPS5t3+IOQxnGdMvP+PYLn2uSuwak2A8MBQUEjOlnvhSmQ5S7XL295aW/xL7M07gxFBCzgJM+G+Q
	2LzjSqt03ShUtO1f9gMWbRE1v7Q85uckUBN3Sno/hnDNzIoun17ZYPrRjh8dLcGchBEsrbCY2agN2
	ej+58xEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa3BA-00000000Y9u-2rII;
	Thu, 18 Jun 2026 03:12:32 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa3B7-00000000Y91-44yK
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jun 2026 03:12:31 +0000
X-UUID: 82a9b9626ac311f1aa26b74ffac11d73-20260618
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:620d1433-5573-4c72-a1ca-b69b26657322,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6d55710aaaa8060313bc92c833766890,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 82a9b9626ac311f1aa26b74ffac11d73-20260618
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1365626505; Thu, 18 Jun 2026 11:12:16 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, kbusch@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 0/1] nvmet: implement discovery Get Log indexing and LID 0x00
Date: Thu, 18 Jun 2026 11:03:36 +0800
Message-ID: <cover.1781751816.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvme-ecn124/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_201230_346629_765EAE2A 
X-CRM114-Status: UNSURE (   7.90  )
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

NVM Express Base Specification 2.3 defines Get Log CDW14 Offset Type (OT):
when OT is set, LPO is a structure index into the log page rather than a
byte offset.  For the Discovery log (LID 0x70), the controller advertises
Index Offset Supported (IOS) in Supported Log Pages (LID 0x00) and must
reject OT=1 when IOS is clear for the requested LID.

nvmet already handles OT=0 byte offsets on the Discovery controller
(including partial reads and zero-fill within the log page).  It does not
implement LID 0x00 there, does not set IOS for LID 0x70, and treats LPO
as bytes even when OT=1.

This patch:

- Answers Get Log LID 0x00 on the Discovery controller.
- Sets LSUPP|IOS for the Supported and Discovery log page IDs.
- Adds NVME_LIDS_IOS and NVME_LOG_CDW14_OT (bit 23, matching libnvme).
- Translates OT=1 LPO from index to byte offset (index 0 = header).
- Rejects OT=1 when IOS is not set for the requested LID.
- Guards u64 overflow when converting large indices so a wrapped offset
  cannot bypass the existing offset > alloc_len check.

OT=0 behaviour and nvme discover (libnvme default) are unchanged.

Tested on linux-next (7.1.0-rc7-next-20260611) with nvmet-tcp and
null_blk:

- nvme get-log LID 0x00 / 0x70 with OT=0 and OT=1 (index and byte paths)
- blktests nvme/003 (tcp), nvme/002/016/017/030 (loop): passed
- make -C drivers/nvme/target

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvmet: implement discovery Get Log indexing and LID 0x00

 drivers/nvme/target/discovery.c | 101 +++++++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h            | 18 +++++++-
 2 files changed, 113 insertions(+), 6 deletions(-)

-- 
2.43.0


