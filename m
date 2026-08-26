Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D0BC61DC2
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5bIYvwo5siDkIg9xFrX9qeaZqIsZePDXqcRN7YuUPPI=; b=pcV39kSERf6FqOatYqWrUALaPi
	awYtj7keLCAgYbE5Lzt/7GD4nffoyZZBlGirG+guODLYWLMVMYWu8M+HebzztpzcHS1DVnyNy4QSy
	Lrz2S7aLrN62YxBgvB6KUMX2huQVTXxvPgdQYsD+JnBCPbRXg4RJw6MnqDgGQF3XESDhn022Bnav1
	dmXHRxQHgKb3GUYuQ/5onUxG7zh65/VKdYdkXDZakBBlXF/dLhnqEC+81yI8VjX/tFpL2dW+X/z4Y
	T2oyF0HnmWNsu6D6doORI40UHVRrvvOv2xkohipN4RvuAlxIT/J7vdQ2S9G/q+/YgqYjfA/zH6964
	onBpKhVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz8UQ-000000022P3-1vX5;
	Wed, 26 Aug 2026 07:56:06 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz8UM-000000022OY-2Mfi
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 07:56:05 +0000
X-UUID: 8ec1a084a12311f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a68d62f1-261e-466f-b8cd-05506db8bef8,IP:20,
	URL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:a68d62f1-261e-466f-b8cd-05506db8bef8,IP:20,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:d0ab9b679382b80bb0c602ce5dcfffa5,BulkI
	D:2608251723390WV7H2C5,BulkQuantity:2,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8ec1a084a12311f19a56ed5b684f684d-20260826
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 523850905; Wed, 26 Aug 2026 15:55:51 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix command effects log lifetime for multipath heads
Date: Wed, 26 Aug 2026 15:55:43 +0800
Message-Id: <20260826075543.2654816-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ao3mNp35Hg_0MDlR@kbusch-mbp>
References: <ao3mNp35Hg_0MDlR@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_005603_632724_1CFABA1B 
X-CRM114-Status: UNSURE (   6.54  )
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

Hi Keith,

Thanks for the review.

Do you mean the whole IOCS entry should be shared, including CSUPP?

The Commands Supported and Effects log is controller scoped (NVMe Base
Specification 2.3, Figure 206), and CSUPP reports command support for that
controller (Figure 214). Zone Append, for example, is optional per I/O
controller (ZNS 1.4, Figure 9). That seems to allow different paths to the
same shared namespace to report different CSUPP values.

Should CSUPP remain per-controller, or do you expect the full IOCS entries,
including CSUPP, to match across paths?

Thanks,
Yao

