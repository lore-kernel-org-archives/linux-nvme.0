Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C64C61DE2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 02:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVY0T3JwyXT/6dVyL7LmwAP/+4eMrFjE9+JxXuFzXSU=; b=lr9k3+eAYC4geF38bZV8wJG44g
	VH5lGTx0COP5/L+jAaINKWQ8JPy7Y9w+NBmR/nRCczUHLkwezqmERdNcqO0XTb5HkGLdQ4jxekFWY
	nRPinxlVPBe9PyydE6pevGgByrzlvq3txbFSO1OOOMZOrVFL5CAoJfx6Vrr3rbNDnk79wL99U0luP
	VduY+2ZEm3gclyYFLcHeN6lLsQ2o7AzJvP5m7h+9R8JU5VpxB8XtZAvIokNoJ0++g7xp7WZRz+0Pl
	mnOvUrnUWkfJ7+TmA1G1oMI5yhQTAm1d8b8s3+r4Wabj8NOdwNtCiD00f+8AcZVmwuOerpRaw0yTH
	X5K5/KZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0rJj-00000008Kkq-2sOF;
	Mon, 31 Aug 2026 02:00:11 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0rJg-00000008Kiw-32WS
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 02:00:10 +0000
X-UUID: ab4075aea4df11f19a56ed5b684f684d-20260831
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3e89e118-3949-48f1-b183-cb3f0859ae69,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:4c411dc073f26930cd612200696fd570,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab4075aea4df11f19a56ed5b684f684d-20260831
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 769739705; Mon, 31 Aug 2026 09:59:58 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: sagi@grimberg.me
Cc: axboe@kernel.dk, dwagner@suse.de, hare@suse.de, hch@lst.de, kbusch@kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v2 1/1] nvme-tcp: fix wrong status on deferred digest error
Date: Mon, 31 Aug 2026 10:15:00 +0800
Message-ID: <reply-sagi.nvme-tcp-req-status.v3.20260831.liuxixin@kylinos.cn>
In-Reply-To: <9ded840a-d7c0-408d-a3a4-2729e26e15e9@grimberg.me>
References: <cover.nvme-tcp-req-status.v2.git.liuxixin@kylinos.cn> <1.nvme-tcp-req-status.v2.git.liuxixin@kylinos.cn> <9ded840a-d7c0-408d-a3a4-2729e26e15e9@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_190009_054323_C2667C97 
X-CRM114-Status: UNSURE (   3.88  )
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

Thanks for the review. v3 follows your suggestion: host status on the rsp
path, complete through nvme_tcp_end_request with cqe->result. I will send
v3 shortly.

Thanks,
Xixin Liu


