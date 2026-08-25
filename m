Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BF7C5DF94
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 09:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+BQ9rAhfAwkPyifUEOqLSE4MTafWiKio4psavq9rOUQ=; b=iwOBFAbaEmB59F5tY7264jMXEu
	TNXB27z11jqYj/RigoT9DX8/ta5Y9cXk2p2DpikU4FW3jkc7coz2Dx1qTAFbVKouu7ITduiMVzihN
	Pp8Ev0tdalRoEhBU93RobHg37Ex5J3c4qW0MKjCWbd4IkNAcLdbQrp268D7m3diEFSbbFnnAsi79b
	52tvwx0V9cwurYXAvhKK3w19cL3+ZhJeJPGyCjnI6SLBfJgK6NUyUnb4MdQYJBayE1nwQU8wn/SLC
	h/gtMEwjJvsVPZKCC2OkryDdv+QFNBwdhosC2BkyjuSRvwuja6aaTTC5WB5Ck0JYSZemU+hDF2IwS
	zWOdJxAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wynNo-00000000U65-19bc;
	Tue, 25 Aug 2026 09:23:52 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wynNl-00000000U5a-22pg
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 09:23:51 +0000
X-UUID: a57ea406a06611f19a56ed5b684f684d-20260825
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a2538096-0b7b-458d-89d4-606c15051055,IP:10,
	URL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-20
X-CID-INFO: VERSION:1.3.19,REQID:a2538096-0b7b-458d-89d4-606c15051055,IP:10,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,ACT
	ION:release,TS:-20
X-CID-META: VersionHash:7db8b62,CLOUDID:cddbac3030593b5d1d8b48696add7ade,BulkI
	D:2608251723390WV7H2C5,BulkQuantity:0,SF:10|66|78|81|82|83|101|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:2,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:
	nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,B
	RE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a57ea406a06611f19a56ed5b684f684d-20260825
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2009507602; Tue, 25 Aug 2026 17:23:34 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: sangyao@kylinos.cn
Cc: axboe@kernel.dk,
	dwagner@suse.de,
	hare@suse.de,
	hch@lst.de,
	javier.gonz@samsung.com,
	johannes.thumshirn@wdc.com,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme: fix command effects log lifetime for multipath heads
Date: Tue, 25 Aug 2026 17:23:22 +0800
Message-Id: <20260825092322.1991601-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260814070651.3973067-1-sangyao@kylinos.cn>
References: <20260814070651.3973067-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260825_022349_827249_05A92B87 
X-CRM114-Status: UNSURE (   5.36  )
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

Hi all,

A gentle ping on this patch. It fixes a KASAN-reported use-after-free
in the multipath namespace head ioctl path by keeping the command
effects log pointer with each controller path.

A blktests regression test was also posted as nvme/070:
https://lore.kernel.org/r/20260814070019.3860097-1-sangyao@kylinos.cn

Any comments would be appreciated.

Thanks,
Yao

