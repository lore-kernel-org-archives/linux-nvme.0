Return-Path: <SRS0=oU3s=W4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A57CC3A5A4
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 08:20:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BDC2190F
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 08:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gG3c3arA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="M4W5qW5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BDC2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d2Kb67GaxIIC14gFo4s1t4VkO3fGs1wmhmYMR78h2MM=; b=gG3c3arAtq17f8dRtef9LKU7x
	r07Yo3oMln1C5POLJoJAaXpqzOE88DUyLxua4sM3GZeJlJ8kiAQuxlrWcjd8nu14cV+e4gWsTJOTu
	+417VxJzkOeKKFEyRDZ4x80wvHhN6uhY4c+gGlRTJL7NDRx6TD/jIKRZMGxCyUuQ7O4m834VDFzVT
	IEb12/tMHwyJTo9G9ks3DVu19UX/5A8aqkSfQI8ptH234ckLIkVYzPHO0gt4hkujCV7NidYtYBKfL
	32hY/DIxUm78sCJK/dSwcTvGQMgCpO681Xub0iXvtYB2Ya5NCk22vAY/RTlBLE8UnfA81GD66RPOs
	par7WRPrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4L60-00032g-0r; Sun, 01 Sep 2019 08:20:24 +0000
Received: from mail-eopbgr150057.outbound.protection.outlook.com
 ([40.107.15.57] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4L5w-00032L-JE
 for linux-nvme@lists.infradead.org; Sun, 01 Sep 2019 08:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/7MTozcBwFKvKvV6mAMOsPfsn/nfYcsTLOBMYxUQgM5wjjdMW568vDl8Qjq+zYszEIEoF04C/gPyx9ATyqCV37zK6RdqeaGESgndlb1zWlJ2Kl3Y5AWkvtjeraLG8aumwm3YvzQUqf03fo142NRqXMx57p3CY27tCqyFDvfqrDJHS9R15M5pe36ZnES2leGVK6/g0QHGVu0sg2U0hs+tfk/nJ/MwCWmxDoxewiUZreGik2inGPIVxYsf7jHwwrruRdIzjFhj6r6udBxtFiajhwzl/6arot1WRChr0z/lz0TthUaF1Jb5nW0VyGrqt/dcSSTBm/AqsqccYAyMRNmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiJ/Sm6e5aX/a/3Z7BqRxGJMw3w6YBoahP92z/kW40w=;
 b=n5YlOkLXnzwUlAzg+cgN//AGShSaS9i5ltl/edJEybQwqxTfwgu9B97zS/D05Ui7WDi19fFHwIjvxr3KQZV0CTqxQIeWEKWNVogpFoOBmQewTSxFrTEC2qBR7qXqUF/k4vdBDOUF2RvLQPFlfIv5KxKm5coFb7ihjBHmnOKudGvytGiMmNcNHHrxkC9OHkfc6AXWuwuDMtbt6azBy+bNPHh2DoF0gONeqARbQcH3t1+7OC0gUmS518idULscctWqbwVdWunk+3kE0ONeS9g+8qSbB9vhlPYzdARahkja/Y5d0qBlMBIfNpW55VjyXGSo7CbKaPMxkt2fJu07Sa5IQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiJ/Sm6e5aX/a/3Z7BqRxGJMw3w6YBoahP92z/kW40w=;
 b=M4W5qW5mplTNC4LDQei85YnFuQ8tmloW5fCOvoNvZB/JifwV4j6TKhunX9bMQRaHcRlW0ctVO55zRPxoASlD0bFWVmAesSqhZYp5DB0UikdC0VVsVcUTb9DH4KV6eELP3LidsSuItVOJh1F1om0BPO3fSXSi8LSRLQm1X+RJku0=
Received: from VI1PR0501CA0047.eurprd05.prod.outlook.com
 (2603:10a6:800:60::33) by VI1PR0502MB2925.eurprd05.prod.outlook.com
 (2603:10a6:800:b8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19; Sun, 1 Sep
 2019 08:20:14 +0000
Received: from AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by VI1PR0501CA0047.outlook.office365.com
 (2603:10a6:800:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Sun, 1 Sep 2019 08:20:13 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT044.mail.protection.outlook.com (10.152.17.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 08:20:13 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 1 Sep 2019 11:20:12
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 1 Sep 2019 11:20:12 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 1 Sep 2019 11:20:09
 +0300
Subject: Re: [PATCH] nvme-core: get rid of the unused variable
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 <linux-nvme@lists.infradead.org>
References: <20190831001013.8581-1-chaitanya.kulkarni@wdc.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <55e83bf3-572b-63b1-427b-65b7a521e2f5@mellanox.com>
Date: Sun, 1 Sep 2019 11:20:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190831001013.8581-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39850400004)(396003)(346002)(376002)(2980300002)(199004)(189003)(476003)(229853002)(6246003)(53546011)(106002)(16526019)(2486003)(23676004)(186003)(446003)(110136005)(76176011)(86362001)(53936002)(2616005)(16576012)(2906002)(316002)(3846002)(6116002)(126002)(36906005)(486006)(47776003)(81166006)(65806001)(70206006)(8676002)(70586007)(4744005)(36756003)(50466002)(58126008)(11346002)(31696002)(26005)(336012)(14444005)(5660300002)(478600001)(65956001)(2870700001)(7736002)(81156014)(8936002)(31686004)(305945005)(356004)(26583001)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0502MB2925; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b4a979f-6604-4a6c-f3f0-08d72eb536a2
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR0502MB2925; 
X-MS-TrafficTypeDiagnostic: VI1PR0502MB2925:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB29259726D9D9438F26951141B6BF0@VI1PR0502MB2925.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-Forefront-PRVS: 0147E151B5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yd1PWFj5BvrEI2aASeTJ3zwmj8RuZyn7dZdyIoaT8Z/ks2jcj4TDNKlosuL4wdfxk0yBFch8oZ2pSt/oJQRBmgGQwjyy/yKeSAp1/WhtTLJtM+mkTJ/ZIUTZex2Iy1UIbWvu+Rf1sSTXYc47vQ5SHgVR/y4bXxqjrlROzav4pj3com3YQdDk+zM//RrgyN7CVXP+08ymLxbxNRwI+BdCOV6YKaE9RverpKTUo9uoj8OtpXSHUaAKDEqbEPps7rzxB9WtJKj+M6uWUcZZuO+VOgmCh1Z0SO6ptsvim/pwubXZud/GDnHvi+Y/DyEPyPURPULvprIeTkaIGf4pyDCor21QizZD3Q2dQ9NVlofypw1U+7/6VOs/QerBH3F6EGjlox89GyaCKH5zY8XczvQQoa7x0Q/GN4qPomjFhNC3Txw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2019 08:20:13.5030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4a979f-6604-4a6c-f3f0-08d72eb536a2
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2925
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190901_012020_714767_196FEF9C 
X-CRM114-Status: GOOD (  12.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDgvMzEvMjAxOSAzOjEwIEFNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6Cj4gVGhpcyBw
YXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIGNvbXBpbGF0aW9uIHdhcm5pbmc6LQo+Cj4gZHJpdmVy
cy9udm1lLy9ob3N0L2NvcmUuYzogSW4gZnVuY3Rpb24g4oCYbnZtZV9jb21wbGV0ZV9yceKAmToK
PiBkcml2ZXJzL252bWUvL2hvc3QvY29yZS5jOjI2NDoxODogd2FybmluZzogdW51c2VkIHZhcmlh
YmxlIOKAmG5z4oCZCj4gWy1XdW51c2VkLXZhcmlhYmxlXQo+ICAgIHN0cnVjdCBudm1lX25zICpu
cyA9IHJlcS0+cS0+cXVldWVkYXRhOwo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYyB8IDEgLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMKPiBpbmRleCAwYjFmZjhkNTRlNDguLmRkZjk5MzQ1ZTNkOCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
PiBAQCAtMjYxLDcgKzI2MSw2IEBAIHN0YXRpYyB2b2lkIG52bWVfcmV0cnlfcmVxKHN0cnVjdCBy
ZXF1ZXN0ICpyZXEpCj4gICB2b2lkIG52bWVfY29tcGxldGVfcnEoc3RydWN0IHJlcXVlc3QgKnJl
cSkKPiAgIHsKPiAgIAlibGtfc3RhdHVzX3Qgc3RhdHVzID0gbnZtZV9lcnJvcl9zdGF0dXMocmVx
KTsKPiAtCXN0cnVjdCBudm1lX25zICpucyA9IHJlcS0+cS0+cXVldWVkYXRhOwoKCkkgY2FuJ3Qg
ZmluZCB0aGlzIGNvZGUgYW55d2hlcmUsIGJ1dCBhbnl3YXkgdGhpcyBtdXN0IGdvIG91dC4KClJl
dmlld2VkLWJ5OiBNYXggR3VydG92b3kgPG1heGdAbWVsbGFub3guY29tPgoKCj4gICAKPiAgIAl0
cmFjZV9udm1lX2NvbXBsZXRlX3JxKHJlcSk7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
