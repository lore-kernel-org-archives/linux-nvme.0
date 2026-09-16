Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30205C88E75
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 01:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dapO0baKQ7A5fSYLm2jaHeMRSFuP5ubkiQSWlwV9M4M=; b=UUBGz129PQeCxaGap2JzwyIuO7
	pNsNF6rJvpvgmOvwuxukODsfVlLrsNFsK0cCSDJ80t3olYERqW/s9ZqsVpi/O5fxnLkobHcIl+m+K
	kapBy09WFjHz4CA5oshC7WNS/YN0PMq5haWiNiuO/X7ELkPJKpBD9rdZf7zEwqq5Q52ANgXIsJItW
	PF9/wnERsAkiOg26uY3tl89e936KPyRBsrMBwfa3x9diLLMo6cIkOSUF7wgyKx8BfoILrnPyPtqDw
	aXLoqKlQKIvXkfZejME/ICEjR8wrAOveHXHmCyn1S8Pmzjb3F0LFmviPfdpDIkPXYf8ZeOtHSMTeA
	xwVvEv6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6e7Q-000000088x4-3D5L;
	Wed, 16 Sep 2026 01:07:24 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6e7O-000000088wY-0mIM
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 01:07:23 +0000
X-UUID: f07e488eb16a11f19a56ed5b684f684d-20260916
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d24ea6b0-6fb1-46a1-86d1-957573a9d07e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:34f08496e484b9c3311aaf7a7a37961a,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50|99,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f07e488eb16a11f19a56ed5b684f684d-20260916
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 890354739; Wed, 16 Sep 2026 09:07:08 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: kbusch@kernel.org
Cc: hare@suse.de, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v1 0/1] nvme-auth: constant-time DH-HMAC-CHAP response comparison
Date: Wed, 16 Sep 2026 08:50:00 +0800
Message-ID: <reply-nvme-auth-memneq-thanks.20260916.liuxixin@kylinos.cn>
In-Reply-To: <aqmY5qqjghx4DFNM@kbusch-mbp>
References: <cover.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn> <reply-nvme-auth-memneq-ping.20260915.liuxixin@kylinos.cn> <aqmY5qqjghx4DFNM@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_180722_527120_9E39D4F5 
X-CRM114-Status: UNSURE (   3.06  )
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

No worries at all, and thanks for applying.

Thanks,
Xixin Liu


