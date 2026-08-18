Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A230C5DF7E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ACYXKU/Nic1yc8Z4UR9F6KI9s2qOj/VTudiQ5yqRyF0=; b=eB+zL+kq47EYNpyWrq6BAcD80v
	RqI6GkUUeQiEYQ0ienyqtso41UIA6hqI0qcLirAQjWUImTS0LfGfO+GximgiGpIEj1CkSFL284jKE
	bgNKXa9M8ZtBaB3KJobIXaJeuKQOUh84BJVwEoZ0D10NmEQ+JTrHY8tVSBMwQI/+fmQRAbA0wLYv1
	A6RRqY20NuQN275Zs6W4NYuP9xDlpluMKl4IeX9oJufvY9kfDkhOH/DXi2XWDGoN6QrwsAmuR7h8n
	bG2M9wRL2xcp84TSND2KXNr/34pVTPQbv91zPBbuQ8NfdV9McFWHsBIOFvYM89adQTnOD1eXccRUP
	N8W86q6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJZ8-000000080hc-3Asn;
	Tue, 18 Aug 2026 13:09:18 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJZ5-000000080gc-2zix
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 13:09:17 +0000
X-UUID: fb5d59be9b0511f19a56ed5b684f684d-20260818
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d7d061bb-4bb4-447d-8c4f-30e6de1b515a,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:d7d061bb-4bb4-447d-8c4f-30e6de1b515a,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:de5d071f5d1758ad4f4bce3cb37d6f49,BulkI
	D:260817160545Z40WACRV,BulkQuantity:2,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fb5d59be9b0511f19a56ed5b684f684d-20260818
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 851412601; Tue, 18 Aug 2026 21:09:01 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/4] block: factor block size and alignment handling out of blk_stack_limits
Date: Tue, 18 Aug 2026 21:08:48 +0800
Message-Id: <20260818130848.2408718-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <58358ff3-2c59-4ebb-bfa7-3ef22a7fb1a3@oracle.com>
References: <58358ff3-2c59-4ebb-bfa7-3ef22a7fb1a3@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_060916_066842_E98F8632 
X-CRM114-Status: UNSURE (   5.86  )
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

Thanks for the review.

The intended boundary is the mapped-range geometry: block sizes and
alignment for a top-device range starting at @start on the bottom device.
The max sector limits stay with it because they must be rounded after the
resulting logical block size is known. I'll clarify this in v3.

Thanks,
Yao

