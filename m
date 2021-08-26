Return-Path: <SRS0=DYpX=NR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F02C432BE
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 21:16:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B4360234
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 21:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98B4360234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=cj8Iumtzb47MNH/O62WPBe4ND6FKtFTVJC7+GH5BFyg=; b=NwIWWL24gjzsg9
	A5biFJD0XeUaJ6EdS1XgvfC2OgtpijB1hvS/sAzRKhJGdPXoNhnAqfsihLZDj2e6I/5Gi5ucg2rr+
	QtaDYL8jEmJ/znelfDP27YcEY7b9t+t+Dav86+/sAKjv8PCOFI8pmsAIXcTkyQudSb1ru6wcZaNF+
	6VP13a6U69i1osQLtFcxZmPFjhLN6vBCEi8xZrHhUj3S0hPsuhHUgGC+Ddd8MelZLNaPOuteQD2VV
	Nt7B75tbAZSTy92ycgJNRvvDvgPmvkVFZC++7Mi3X9cLmLpScZotLbmy90eVhslVNrRdkk4r/uA01
	xSw/PCBAoOSm+a3c6f7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJMje-00Augp-Tc; Thu, 26 Aug 2021 21:16:30 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJMj3-00AufM-PG
 for linux-nvme@lists.infradead.org; Thu, 26 Aug 2021 21:15:57 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20210826211546usoutp023ffc8fda93a663ea6147828ec62a845c~e98Z6zonl2040920409usoutp02R;
 Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20210826211546usoutp023ffc8fda93a663ea6147828ec62a845c~e98Z6zonl2040920409usoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1630012547;
 bh=r9IjyKb9NwYbgZQaqkfxsWQc9c2WZ3PG6KCBtXowDG8=;
 h=From:To:CC:Subject:Date:References:From;
 b=eocjVWUNELGFttxX7F6BjbuK3nbdjnkCd7hgKnL8J3ktGSuBhdd/IHzqJXzbu9F2M
 O5CMjVq1hphS6uswg9bAHYf0xdyLbTM7d9kzfg9xGdvIhA8YqHAWiSTTxP9zvc7gTp
 hfyh4VQ0iGR8oXRV2Qg00VfAjthrm0GHrx730acc=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
 [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210826211546uscas1p1efeaf1687f309a20b7c1c4a3dadf3068~e98ZvCrh42657926579uscas1p1G;
 Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
 ussmges2new.samsung.com (USCPEMTA) with SMTP id 8F.C4.03480.28408216; Thu,
 26 Aug 2021 17:15:46 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
 [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852~e98ZV3HRl0263002630uscas1p1G;
 Thu, 26 Aug 2021 21:15:46 +0000 (GMT)
X-AuditID: cbfec36f-edfff70000010d98-86-61280482aaf0
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 53.DD.47905.28408216; Thu,
 26 Aug 2021 17:15:46 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
 SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Thu, 26 Aug 2021 14:15:45 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407]) by
 SSI-EX1.ssi.samsung.com ([fe80::4df0:41c8:8343:b407%7]) with mapi id
 15.01.2242.008; Thu, 26 Aug 2021 14:15:45 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Adam
 Manzanares" <a.manzanares@samsung.com>
Subject: [PATCH 0/2] Make nvmet_init_cap dependent on passthru controller
Thread-Topic: [PATCH 0/2] Make nvmet_init_cap dependent on passthru controller
Thread-Index: AQHXmr+Icw4LjsGPkE629HHiiLhFoQ==
Date: Thu, 26 Aug 2021 21:15:45 +0000
Message-ID: <20210826211522.308649-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRiH+845nh2Hq+MSfZvSZaGU1bxQNCikKGIFpUFBraCOdVDLOduy
 0oqki2lXKzWbonZbbk1L05JlmDYta2ZZbtNilmlkkrIsZqWZ21ngf8/7/X7fy/PBR+FCvZeI
 Skjay6qSmEQxySfuN/18ueAoMYcJNxeFSMdqm0ip5l0/IdXdbsSkFxssSPrGWEhKi7W9PGl5
 /yCxjCe7cGyAJ2u1VxCySn0WKbt344jsYUc6KRuqnC47+fg0FsOT85fuZBMT9rGqsKjt/Pjy
 M8NE8g3ywMXGGiwdZXudQt4U0AthqNs8znxKSOsQmEzXSG44gcH7T3bsfyvfMYZxQRkC/fcs
 ghscCDo6TDxueIygovyB+wpJh8OfpxW4K/CjszF4VWUiXQFO74FHZUOEi6fSq+F4Y7ub/egY
 MLeYxk2ocZbAaKf7mKCD4WuFE3exgI6Cs+k6NyPaH5zPDRi3MgA6e4o9qr5wraAW59gf/ho/
 khzPgi5nH4/rS8CWm+PRmQfaq/2e/b7QfKWH4PrToL7U5n4l0LUU1GUYkcsN6JVQeM+X6wRC
 uzUX5zoWBLe6C724oQvBiTOjiGstgasjdzymk2H0d7dnkQAyM4TZSKyZ8AbNBD/NBD/NBL8S
 ROhRQIparYhj1ZFJ7H6JmlGoU5LiJDuUiko0/p1e/H2irEHWToekAWEUakBA4WI/QYkzhBEK
 djKpaaxKuU2VksiqG1AgRYgDBNimC9uEdByzl93Nssms6n+KUd6idGzNbh/DfvNMXnVru7/P
 wKRqZ8+WPkvk3SbFcp+fvgp750Jb4EwqdP2r86W7jmus8SJj12WRcfHBAmnQ2+s3D+ItwbFZ
 JfH2vMHr8ne/knXr2uqHXhriHrWJDGvacteHfIuo1xxLfR30warP2fSjrM7QDFstWJ3805dF
 X5xFor5QrW1+qXY7O7z53Crlg+C1OxLmbswzjx1iLkkSfj9L69twS3RnoKkgIv/zd5WjalrG
 kg5l9hZ7sVbOVwTM/eCITp0RG11zMy0oMlM3aFkxaaTXYYsZDpsS2LvscFC+fBY9ktla1UzO
 /iqeLDfcbbce0b2d0qxARcIo4+bDAlqOzh4QE+p4JiIUV6mZf8zW1Iq9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWS2cA0SbeJRSPRoHE9n8X/PcfYLGbdfs1i
 sXL1USaLSYeuMVpc3jWHzWL+sqfsFutev2dxYPeY2PyO3eP8vY0sHptWdbJ5bF5S77H7ZgOb
 x+dNch7tB7qZAtijuGxSUnMyy1KL9O0SuDLW9fxgKVjCVjHp6A6mBsYJrF2MnBwSAiYSMz7+
 Z+pi5OIQEljNKLH8wBI2COcjo8SUNYeZIZwDjBK3728Ba2ETMJD4fXwjWEJEYAKTxIUtR9hA
 EswChRJ7135mAbGFBTwlWo5eBbNFBPwkdv85AmRzANl6En9vgYVZBFQlXm38zgxi8wrYSfQ2
 rASzGQXEJL6fWsMEMVJc4taT+UwQpwpILNlznhnCFpV4+fgf1AuKEve/v2SHqNeTuDF1CtQ5
 2hLLFr6Gmi8ocXLmExaIekmJgytusExgFJ2FZMUsJO2zkLTPQtK+gJFlFaN4aXFxbnpFsWFe
 arlecWJucWleul5yfu4mRmA8nv53OHIH49FbH/UOMTJxMB5ilOBgVhLhXfBdLVGINyWxsiq1
 KD++qDQntfgQozQHi5I4r5DrxHghgfTEktTs1NSC1CKYLBMHp1QDU5wzR3Dp50V/1v5IXr1k
 x8TP2XFXTO7qC5gfEU+6uJ19+6zgW0lHElsT9K1vFwgvebRNzv/B4eMd9eKb8hY51Kr+OeFR
 ob0uL7N44esdPb+ZEuIuNGf4V+/42ZPTf2115Qyb+gjzG7/cF6x7a50Vm+BocMP10GO/iZ/D
 jmZdYdqb/mLKvj+cU1qZf1zSCmDfML3ux/9J/KckO81XrvPZYT3B//89dlb+2e3rSuYkxqWU
 5565F+dSMm+zTXWDnVupwINwje7JZ7MjRL//ZVi6ynQB691Zse8/cEhz14cdna6309nOXeO7
 2YM9d+fevbZNxp67ecrtKWGZy+4v/RjhpP0jedMJg0j1qXxR+5ZL7VdiKc5INNRiLipOBACY
 fpQONgMAAA==
X-CMS-MailID: 20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852
CMS-TYPE: 301P
X-CMS-RootMailID: 20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852
References: <CGME20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852@uscas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210826_141554_053926_3B8C44E4 
X-CRM114-Status: GOOD (  12.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_init_cap unconditionally sets support for one or more command sets. When
using a passthru controller this may cause a conventional namespace to be
ignored when checking the namespace identification descriptors which must
include the command set identifier when the cap is set to support one or more
command sets. Since the namespace identification descriptors come from the
passthru controller they may not include the command set identifier causing the
namespace to be ignored.

Adam Manzanares (2):
  nvme: move nvme_multi_css into nvme.h
  nvmet: use passthru cntrl in nvmet_init_cap

 drivers/nvme/host/core.c   | 5 -----
 drivers/nvme/host/nvme.h   | 5 +++++
 drivers/nvme/target/core.c | 9 ++++++---
 3 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.25.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
