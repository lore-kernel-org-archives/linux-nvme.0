Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3527CA5FC1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 09:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBMnDFeTFjA6o5lir8aYg7Q1nxgXxskFh7ltUG1eKa0=; b=reyYw1mVKyh+WznIfDTS5GGO50
	zGJnrkXq0j0IGQd3WEsbYCqNFuuHxqwQmWk1xC9YdKibQXq1Dq6BVoy8t6fqomckkZIvYuTuOJZNN
	CpFPVx7akES5+wQUxFj1YyPu8dnd7F49yM5UzR8OIWt9I0afzp8eKhCiSC4WixB4IcgZOF/rSNBs4
	Zw6iLMRVsEQwpZB9fAIA0kwh50rSV5wLw4JSYOKT8UxDbFyl17cWqWA8ot9a4/G0G8tlcgpk7PbMK
	lwnUB94mpRMTTB/yNS4uGE9eB/C0OkhK9Z/6pdRFWPYJnBxXQgNQYaUGQKirGZc1wzNLVlvheVnzu
	MF1CVzHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBqM2-00000005X02-3ED8;
	Wed, 30 Sep 2026 09:11:58 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBqLv-00000005Wya-1oRR
	for linux-nvme@lists.infradead.org;
	Wed, 30 Sep 2026 09:11:53 +0000
X-UUID: f1135ababcae11f19a56ed5b684f684d-20260930
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_QP, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:be1cafa9-a4e9-4612-99d5-2219269dcb61,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:be1cafa9-a4e9-4612-99d5-2219269dcb61,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:b402e681f5a3a7591de3410ba00273b8,BulkI
	D:260929044255IT3ZBZHL,BulkQuantity:1,SF:10|66|78|81|82|83|102|127|850|865
	|898,TC:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:4
	0,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1135ababcae11f19a56ed5b684f684d-20260930
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 686644997; Wed, 30 Sep 2026 17:11:38 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	dlemoal@kernel.org,
	hch@lst.de,
	kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sangyao@kylinos.cn
Subject: Re: [PATCH v2] nvme-multipath: revalidate zones for namespace heads
Date: Wed, 30 Sep 2026 17:11:12 +0800
Message-Id: <20260930091112.454399-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2bfc96f2-7d0d-47e0-936e-8810abb31a9f@acm.org>
References: <2bfc96f2-7d0d-47e0-936e-8810abb31a9f@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260930_021151_779760_328C1008 
X-CRM114-Status: UNSURE (   4.37  )
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

Hi Bart,=0D
=0D
Thanks for pointing this out, and sorry for the regression.=0D
=0D
I reproduced the lockdep warning and confirmed that Palla's fix=0D
resolves it in my tests:=0D
=0D
https://lore.kernel.org/all/20260930062648.73871-1-raghunathpalla.0209@gmai=
l.com/=0D
=0D
Thanks,=0D
Yao=0D

