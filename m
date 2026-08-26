Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459ECC61DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 00:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4SEoTJB+4ttKK4dOWvXeDh8E5LQD7YrsSdgnAQ50kC0=; b=A0FMDuQwa1uqYy3K7Lf0cSFEgt
	r74Rov4WSE07R0GiUoEjlJRyu/Evu+tvYexqMGZ/zH7/nZ25GY693kkuQHVcl8H7QbL2qbDbxFv08
	oxvVSXabYWYtqv5rdvNyBsrKbzfr/P6hPmDB2TQcI6YVBTAkqyhuybIK9iIYtdYEcYDqmU2riGKsi
	LkBraH2D2eQeNsEBUzpbHX/Y75Hms+/Uae7Tsu+jhv0+WiSlCL9e2DhlVBGih3c9Oh76S/ep5Qq2f
	Lpo16KHX+GMGNWga6wsPbPKkRTu83bdUPWh/ujFum6/u6tQDkAcfSSClnO5SeXrqg/Mx66ERmnxMq
	wj211iLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz1no-00000001jQM-1BLw;
	Wed, 26 Aug 2026 00:47:40 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wz1nk-00000001jQ1-1WSo
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 00:47:38 +0000
X-UUID: b417f3d8a0e711f19a56ed5b684f684d-20260826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:68209700-d274-4f8c-a419-b5b5f5aed446,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:5340f1cb8357bc15272fbcfa7cf66164,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b417f3d8a0e711f19a56ed5b684f684d-20260826
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1414228066; Wed, 26 Aug 2026 08:47:24 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, hare@kernel.org, linux-nvme@lists.infradead.org, liuxixin@kylinos.cn, sagi@grimberg.me, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH] nvme-tcp: defer TLS inline send to io_work
Date: Wed, 26 Aug 2026 08:45:00 +0800
Message-ID: <reply-keith.062lockdep.applied.20260826.liuxixin@kylinos.cn>
In-Reply-To: <ao0ErlDKMbvwAoGx@kbusch-mbp>
References: <ajtk1CaN1pBreS4O@shinmob> <cover.1782436781.git.liuxixin@kylinos.cn> <8803a2bf-3f8e-4ee9-b6d7-5467bfc1b1ce@suse.de> <reply-hannes.062lockdep.20260629.liuxixin@kylinos.cn> <reply-hannes.062lockdep.20260701.liuxixin@kylinos.cn> <aoPuIUSQvZxujmv7@shinhome> <ee0225fa-6a0b-4933-9a4d-5c77792eb94b@suse.de> <c6e2a91f0b62.1787100300.git.liuxixin@kylinos.cn> <ao0ErlDKMbvwAoGx@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_174736_723276_8EC6A6C1 
X-CRM114-Status: UNSURE (   2.95  )
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

Thanks for applying.

I will use new threads and Link tags next time.

Thanks,
Xixin Liu


