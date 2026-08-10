Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE34C5AD4E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 08:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zz/YDBfBE60MeZURe4eH+xwS1quBTlzpy3Mkms+m2Q=; b=FmXbAPEk+YSC9hYqX/qyUoidlR
	Bk2bR4QzygYVIkSFUf3LvlADJ6ift2xnkkhrBW6PbQvFAZWdvo2moVQ+RxfGnuBsl+1J1gDtL2y4v
	e3GCwrnGyFrkYZu8OsyA2mhdHGMTWTOsRA88cFeZvVQ7dQ/fIlDdFbYWYWWY9wQ2eDtLum8Gw1Y6d
	zdNAQwxMNY1z2E+AoOz29HF3orUFkuNIsjs9s9DlTjqx3HzmIeQTVOC9sNk27i5GPBkb1K4qOC3cp
	0eh93ou2Zgpm7F1CbQl18FZOSZ3FnWNIUWTOidDku5QuhiF1LpCVp3lOBM1li67nPxP+AP4o2pdIS
	yJyqSoeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtLik-0000000BL6t-3khM;
	Mon, 10 Aug 2026 08:50:58 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtLif-0000000BL5O-2ZAj
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 08:50:56 +0000
X-UUID: 90983856949811f1aa26b74ffac11d73-20260810
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_QP, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_AS_FROM, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0cec714a-a86c-4433-b80e-104d1a6400b3,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:0cec714a-a86c-4433-b80e-104d1a6400b3,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:47048db6355b9a3cdbee5087e94c61eb,BulkI
	D:260810164140PAAK7HM7,BulkQuantity:1,Recheck:0,SF:10|66|78|81|82|83|101|1
	02|127|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 90983856949811f1aa26b74ffac11d73-20260810
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 34844069; Mon, 10 Aug 2026 16:50:40 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: sangyao@kylinos.cn
Cc: axboe@kernel.dk,
	hch@lst.de,
	kbusch@kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH v2 0/4] block/nvme: split path limits for namespace heads
Date: Mon, 10 Aug 2026 16:50:05 +0800
Message-Id: <20260810085005.2275640-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806024658.4193386-1-sangyao@kylinos.cn>
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_015054_492398_15E3E96F 
X-CRM114-Status: UNSURE (   4.99  )
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

Just to clarify the base for this series: it is based on the public=0D
nvme/nvme-7.3 branch at bf881dd20062 ("nvmet: reject out-of-range mdts=0D
values in configfs store").=0D
=0D
It depends on 224041412693 ("nvme-multipath: revalidate zones for=0D
namespace heads"). Sashiko appears to have failed to fetch nvme/HEAD and=0D
then tried axboe/HEAD, which does not contain that dependency, so the=0D
reported apply failure looks like a baseline selection issue rather than a=
=0D
conflict on the intended nvme tree.=0D
=0D
Thanks,=0D
Yao=0D

