Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8D2CA5FC1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5jxWXMd8DplD93Thpc8/25G1u6WaT0TActwQ5PLnlh4=; b=ZEei3Zu7tBdCTl9ISDIodLEI5Q
	TchCz0JJWTdqwwzPNONS/zjOQkGIAOHLFyXOO/lNe9JHIusp+TgxvXbow+il/RtL1s6KDkUUXeV7v
	tLD1PVu3z22qd3DhjvxAG6hrTq6NtWJLImhZWkGPKnHjcEoIcSi7df1y5iWM97sjqO+b2DMOVJRVp
	x14/G79Pm/6hH7r0faBou/b06GhTEALTLerGqmBWwWNfesvPnsF/dqVa12i4b4e+0ujLcv9lT+2tY
	9b2bjPSH2uYzfgDSf7JCKMyJbhEPjhtVDwH+G8xovc4geenlsuQGOXXE2bIzgZOeHMu0NFKL01XGX
	KfIsOl8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBqkU-00000005axz-3Sjl;
	Wed, 30 Sep 2026 09:37:14 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBqkS-00000005awE-1Rjx
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 09:37:13 +0000
X-UUID: 7fc2bbe0bcb211f19a56ed5b684f684d-20260930
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_QP, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_LANG
	HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN
	HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:af5cedb7-ee9d-4a48-ba9e-668e90a1522a,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-15
X-CID-INFO: VERSION:1.3.19,REQID:af5cedb7-ee9d-4a48-ba9e-668e90a1522a,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:NOTI_GNA5D1EA,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:7db8b62,CLOUDID:01e194da639580da6cdf8f18d5fb04a2,BulkI
	D:260930154619DME7EEX6,BulkQuantity:1,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50|99,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7fc2bbe0bcb211f19a56ed5b684f684d-20260930
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1714997772; Wed, 30 Sep 2026 17:37:05 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: raghunathpalla.0209@gmail.com
Cc: axboe@kernel.dk,
	dlemoal@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	me@brighamcampbell.com,
	sagi@grimberg.me,
	sangyao@kylinos.cn,
	shuah@kernel.org,
	syzbot+2e02ccadb3c5522a5c59@syzkaller.appspotmail.com,
	syzbot+b0910be96b7c31314822@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvme-multipath: revalidate head zones after unfreezing the head queue
Date: Wed, 30 Sep 2026 17:36:23 +0800
Message-Id: <20260930093623.461383-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930062648.73871-1-raghunathpalla.0209@gmail.com>
References: <20260930062648.73871-1-raghunathpalla.0209@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_023712_679315_BA9817E6 
X-CRM114-Status: UNSURE (   3.29  )
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

Looks good to me:=0D
=0D
Reviewed-by: Yao Sang <sangyao@kylinos.cn>=0D
Tested-by: Yao Sang <sangyao@kylinos.cn>=0D

