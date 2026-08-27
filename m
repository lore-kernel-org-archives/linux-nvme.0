Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3FFC61DBD
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 02:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5K19eAvDk8BKqdS1o6IpkMAlP+xwSRe850LjA5FEUWM=; b=TJZDlyfLdaauq7PuiTaqcH54bz
	vtaK0ppV8okRH01FRecnHrW2gzE9PqJzaq1fel7poA4/Po/nWpuYVM3dDwrdieoqy7Jk5mhavCMJQ
	dYdWgvJDeWnbmreagj6Ue21lLyUTq6MvfHmTa4uhJ2GVeCT2dOweks+r/YHpV5//5AQbarySNjcAB
	Zyqt2wvVX7LUp+jYa+3DyumBjyR4xOVVlDLhmHJg8+Km4v7CHJYK6GNW44kA84WBbLy7tvxXqY3VO
	BM8TovXJO7eQ99gGNBNXwjoktipBG+WW5EDqTeydEWrnOp/VTMSjI5GMzjlJBz8Jv60lRmz9tAA9F
	zGSiv8NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzQ7I-00000003Jsi-3DLe;
	Thu, 27 Aug 2026 02:45:24 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzQ79-00000003Jru-3ozy
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 02:45:18 +0000
X-UUID: 4cc37600a1c111f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:49a27659-8d11-4c5f-aa7d-3d332443ad4c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:9447a778819b87a361c0153b70017719,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4cc37600a1c111f19a56ed5b684f684d-20260827
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 104589409; Thu, 27 Aug 2026 10:45:01 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: hare@suse.de
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, dwagner@suse.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v1 0/1] nvme-tcp: fix wrong status on deferred digest error
Date: Thu, 27 Aug 2026 10:40:00 +0800
Message-ID: <reply-hannes.nvme-tcp-req-status.v2.20260827.liuxixin@kylinos.cn>
In-Reply-To: <22ddb116-840d-4d6b-ae2a-5bdb755273df@suse.de>
References: <cover.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn> <22ddb116-840d-4d6b-ae2a-5bdb755273df@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_194516_245559_A7E8F8E7 
X-CRM114-Status: UNSURE (   5.38  )
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

Thanks for the review. This is not a wire to host conversion. req->status
already mixes wire and host values. Digest error stores a host SC. u16
makes the host SC explicit. __le16 is endian packaging for wire layout.
The SUCCESS rsp branch overwrites with cqe->status, which is wire. A host
SC must be shifted left before nvme_try_complete_req.

Without DATA_SUCCESS, digest error is deferred to the rsp path:

	req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);   /* host SC */

	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
		req->status = cqe->status;   /* wire */
	if (!nvme_try_complete_req(rq, req->status, cqe->result))

Both branches pass req->status into nvme_try_complete_req, which expects
wire:

	nvme_req(req)->status = le16_to_cpu(status) >> 1;

SUCCESS is fine. Non-SUCCESS still holds host SC 04h Data Transfer Error,
so 0x4 becomes INVALID_FIELD, 0x2.

v1 changed req->status to u16. v2 keeps __le16 as you suggested. Please
take a look at both and say which you prefer for merge. I will send v2
shortly.

Thanks,
Xixin Liu


