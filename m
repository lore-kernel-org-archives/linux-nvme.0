Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38350C79FB9
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FDh0DW4FreAXgSlDFmbyju9lTtz4hVwzfOzm+e6qy+M=; b=f/54QljuYT3mTC3WU+hrrLxtR6
	YOS/6EkX8pySfac/Ciz/pV2N5eZ4Pn2BByrgFt3K+50XtQ5kmZf9rFyFZ8kzOdWV5HVuozxnm/3jJ
	GGnMESuMx+ZusHnJVrfhUQ0MFmfIm5/1ER3dtbMn8LySCQ3l9ImfV5EjgNOL45crIxH2+7VhuOC7o
	JewmdROpW2ve6yYji/yLP/wFyuObjbb3+7+eIAEktdXKW8J9stI31+QsX42PBY0TonnsOB6lcc/zC
	G3yn0t0wjtNIR/V1l1/unwe6DsRlehGHmGbDevPXqRNNL3klvQdQabfmcgvwioZd8Rx6noyoh2VRN
	STGrdD7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4bil-0000000E0LV-2BAg;
	Thu, 10 Sep 2026 10:09:31 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4big-0000000E0KV-0SB8
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 10:09:30 +0000
X-UUID: aafcedfcacff11f19a56ed5b684f684d-20260910
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a6cd0f10-e723-4c87-8165-18430586c298,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.3.19,REQID:a6cd0f10-e723-4c87-8165-18430586c298,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:7db8b62,CLOUDID:6a195ccaa05e1996a283e674f5ff424d,BulkI
	D:26083116041099FKK443,BulkQuantity:2,SF:10|66|78|81|82|83|102|127|136|850
	|865|898,TC:nil,Content:0|15|50|99,EDM:5|-100,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aafcedfcacff11f19a56ed5b684f684d-20260910
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1445208291; Thu, 10 Sep 2026 18:09:11 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: john.g.garry@oracle.com
Cc: axboe@kernel.dk,
	hch@lst.de,
	john.garry@linux.dev,
	kbusch@kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	sangyao@kylinos.cn
Subject: Re: [PATCH v3 0/5] block, nvme: support same-LBA multipath limit stacking
Date: Thu, 10 Sep 2026 18:08:48 +0800
Message-Id: <20260910100848.1248846-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b6372900-7be4-4e6e-94ae-f816341e4c07@oracle.com>
References: <b6372900-7be4-4e6e-94ae-f816341e4c07@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_030926_449768_0E4DB506 
X-CRM114-Status: UNSURE (   5.61  )
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

Hi John,

Sorry for the late reply, and thanks for the review.

Initializing the head limits only once needs some care, as we still
need to refresh them after Format NVM and namespace changes.
I'm working on this and will send v4 once it's ready.

Thanks,
Yao

