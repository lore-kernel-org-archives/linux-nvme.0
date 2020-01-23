Return-Path: <SRS0=16Sh=3M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A5BC2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 10:01:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCE152253D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 10:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kEJ/InWj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="qFfmEWCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE152253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xMPl1GLD9LNKFQ82UTsH1ajWeIcMhP04tvO438dUgrM=; b=kEJ/InWjGP7JXXC5FubrBycxV
	AzU6L/j7GbHUc9pelQz5YEwmzuiupTR/AQQmDHLcq7wPgDEzJ/vQ0PuUds/xYzbwT6v7SaMIueKaN
	heiqa/ztI0EVxHdIbmSrvCAn53ibEOdwDB8Mr/trVPLpEAZ7W/9UpjK8ZY6LHqb3+KrlFtmfWVAJr
	PGnccmoyx0vCYRwuzp3JIM/JredmfdiaVPxwEG1mI2bkXEIt/tDO5/Y+0haYS7wD0Bck0YopgsC5I
	8WZ1E9NtSiLaL9/3zz/wgzmtwZIzVY3+afXhiyOYGJemE2i9aUAl8KJCw1g8lA2Um+dShoMDwViCm
	uuDVYxDFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iuZIF-0006Q4-5z; Thu, 23 Jan 2020 10:00:55 +0000
Received: from mail-db8eur05on2086.outbound.protection.outlook.com
 ([40.107.20.86] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iuZI8-0006Gi-U2
 for linux-nvme@lists.infradead.org; Thu, 23 Jan 2020 10:00:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBhel8IN7sS/f27UXxcsPDhnz68T7p4k2acwjLT0+hNbHCmNOhGS3GGNA5WJXpJ7D+Xki62rZwaReW1dhlDZ8ONr7T8BGCdEMmi2B9kL6MvkppYMRfU7F9LIKxGUuUxDQUe8jETszTNwM3qh3/QGmMuEyzxLp4HybDs4jzbY4PNskB9pnW6G7Ik9X2jrshsRsQY8zrOrmTirSGk4G8SWlZ8UyhNtt73Vgv8/Mgzz7IfUucY1VHoCP6TCAj1KHDriE398gCKRI7qAwKMqj6ksmj63CiLymie9NulJ4CLqZbE4Rxg/ntXW9bGjGjoHK8vpxm9b2QGHFzO9K5aDrXIeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaKlF7XEiEseRuzcVzXT5MvoGUgrhNnQm/quvONIFEI=;
 b=CyQq24BVUwpLH4WhTjgWcIqB24raulAHUh4AhK++iZC9x9M6bERFStF/pF9AA87xY5IW1z+JclwBZxp+01mc97oPitdQdtvkPvu73ObA1DpcVRxBcZ88ZrcKnwvXQ7GyPKNCu54clSNPzrw7d1Bd3PDgO4AIcTLNwlnEpfFQvg9FbtKtG31EZCBs3JCMaxS23169/ihaIUOAzz7Wqo2y8FzN3pu/GoUf7D4dixBUVz5ZSB412KYcUMPmyI+cNPmAo8iTSFBGxldQL9xCeB/+5qDlDh4ptlrG/HGx+qEeMI/7lE47wqy6u5fq8WK9w9X+Dy+at389Zm/LpkX//1qnFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=kernel.dk smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaKlF7XEiEseRuzcVzXT5MvoGUgrhNnQm/quvONIFEI=;
 b=qFfmEWCs2QmWml/ZZx2s6AiVgMKDRnG6fzU9oov/ly8WqTRI6tKkwdMtgW7B3Vvg3A+26zzX4otZBroNRdyToCqHKsW1z5UmJIwl4MpxHPAeNLQCI+hLnilt24T17TfOHMDHkUW7bLsuTdKLRiCagTun+8q7X1PSVM6K6yPCSq0=
Received: from DB7PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:10:36::14)
 by AM6PR05MB6358.eurprd05.prod.outlook.com (2603:10a6:20b:bd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Thu, 23 Jan
 2020 10:00:40 +0000
Received: from DB5EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by DB7PR05CA0001.outlook.office365.com
 (2603:10a6:10:36::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend
 Transport; Thu, 23 Jan 2020 10:00:39 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT039.mail.protection.outlook.com (10.152.21.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2665.18 via Frontend Transport; Thu, 23 Jan 2020 10:00:39 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 23 Jan 2020 12:00:34
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 23 Jan 2020 12:00:34 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 23 Jan 2020 11:59:37
 +0200
Subject: Re: [PATCH 07/16] nvme-rdma: Add metadata/T10-PI support
To: James Smart <james.smart@broadcom.com>, <linux-nvme@lists.infradead.org>, 
 <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
 <martin.petersen@oracle.com>
References: <20191202144812.147686-1-maxg@mellanox.com>
 <20191202144812.147686-9-maxg@mellanox.com>
 <522e0efe-5907-b28d-ef90-4ceca0fb3103@broadcom.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <07d7772c-7ec5-d29f-ae84-c177321145ae@mellanox.com>
Date: Thu, 23 Jan 2020 11:59:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <522e0efe-5907-b28d-ef90-4ceca0fb3103@broadcom.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(199004)(189003)(336012)(86362001)(31696002)(107886003)(8676002)(356004)(6666004)(5660300002)(81156014)(53546011)(8936002)(478600001)(81166006)(2616005)(110136005)(54906003)(2906002)(36756003)(26005)(4326008)(31686004)(70586007)(70206006)(316002)(16526019)(16576012)(186003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB6358; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 103a8992-d552-492a-f391-08d79feb1a05
X-MS-TrafficTypeDiagnostic: AM6PR05MB6358:
X-Microsoft-Antispam-PRVS: <AM6PR05MB635803C69FC666C49434F15EB60F0@AM6PR05MB6358.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 029174C036
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dccd5PWk3F7uMQ7jjpSReBrFDopq1zvfEkEhjx7dPdc9+HKycKYRrjUzJB0pjKSMsToCRiAjVOD1juikK6s9prtnlksvxe0mcRxcBvylbx2q8udbeyK/wyA1ukZM+n7/oC6tVCT0GUlaDWgavQiQE35lzKrGy6jA+SjlfWytIn7PQ2q4VDzwK0+O+YHyvMmLat3qZtdyRE00ZTdfuZZdI7vlHmmD53hI2RqcTQo73iyuXXsoDca+eT6CKVjZhBEniA+3N4ZVbvh84fw0QJfNV9yuKyrveOIHPyGw+7VWgXTEuVsFnR7tr9kOJ0VeUgTOkkbmUgHcWpiB03a03n4MuUDb5i0BB+BY5pOcRPI6n5JG52An9mrrkeGcEHOb6koiVobJqbM/qIqXpb4J+ANsgGHgP7e0l3+d0Tzwusq8drfkA/nP95T0X1YC6AgpQrULKeBMBRSBeBmIPBFcVHOI8rS9CSDkFHDkYZdO+LPrkUTazocHebw3JWZ17PPs/kV1
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2020 10:00:39.5290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 103a8992-d552-492a-f391-08d79feb1a05
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6358
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200123_020049_115483_F8C31DF6 
X-CRM114-Status: GOOD (  18.79  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, shlomin@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDEvMjIvMjAyMCAxMTo1NyBQTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4KPgo+IE9uIDEyLzIv
MjAxOSA2OjQ4IEFNLCBNYXggR3VydG92b3kgd3JvdGU6Cj4+IEBAIC0xMjE1LDM0ICsxMjgzLDEx
NSBAQCBzdGF0aWMgaW50IG52bWVfcmRtYV9tYXBfc2dfc2luZ2xlKHN0cnVjdCAKPj4gbnZtZV9y
ZG1hX3F1ZXVlICpxdWV1ZSwKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PiDCoCAt
c3RhdGljIGludCBudm1lX3JkbWFfbWFwX3NnX2ZyKHN0cnVjdCBudm1lX3JkbWFfcXVldWUgKnF1
ZXVlLAo+PiAtwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfcmRtYV9yZXF1ZXN0ICpyZXEsIHN0
cnVjdCBudm1lX2NvbW1hbmQgKmMsCj4+IC3CoMKgwqDCoMKgwqDCoCBpbnQgY291bnQpCj4+ICsj
aWZkZWYgQ09ORklHX0JMS19ERVZfSU5URUdSSVRZCj4+ICtzdGF0aWMgdm9pZCBudm1lX3JkbWFf
c2V0X2RpZmZfZG9tYWluKHN0cnVjdCBudm1lX2NvbW1hbmQgKmNtZCwgCj4+IHN0cnVjdCBiaW8g
KmJpbywKPj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBpYl9zaWdfZG9tYWluICpkb21haW4sIHN0
cnVjdCByZXF1ZXN0ICpycSkKPj4gwqAgewo+PiAtwqDCoMKgIHN0cnVjdCBudm1lX2tleWVkX3Nn
bF9kZXNjICpzZyA9ICZjLT5jb21tb24uZHB0ci5rc2dsOwo+PiAtwqDCoMKgIGludCBucjsKPj4g
K8KgwqDCoCBzdHJ1Y3QgYmxrX2ludGVncml0eSAqYmkgPSBibGtfZ2V0X2ludGVncml0eShiaW8t
PmJpX2Rpc2spOwo+PiArwqDCoMKgIHN0cnVjdCBudm1lX25zICpucyA9IHJxLT5ycV9kaXNrLT5w
cml2YXRlX2RhdGE7Cj4+ICsKPj4gK8KgwqDCoCBXQVJOX09OKGJpID09IE5VTEwpOwo+PiDCoCAt
wqDCoMKgIHJlcS0+bXIgPSBpYl9tcl9wb29sX2dldChxdWV1ZS0+cXAsICZxdWV1ZS0+cXAtPnJk
bWFfbXJzKTsKPj4gLcKgwqDCoCBpZiAoV0FSTl9PTl9PTkNFKCFyZXEtPm1yKSkKPj4gLcKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRUFHQUlOOwo+PiArwqDCoMKgIGRvbWFpbi0+c2lnX3R5cGUgPSBJ
Ql9TSUdfVFlQRV9UMTBfRElGOwo+PiArwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5iZ190eXBlID0g
SUJfVDEwRElGX0NSQzsKPj4gK8KgwqDCoCBkb21haW4tPnNpZy5kaWYucGlfaW50ZXJ2YWwgPSAx
IDw8IGJpLT5pbnRlcnZhbF9leHA7Cj4+ICvCoMKgwqAgZG9tYWluLT5zaWcuZGlmLnJlZl90YWcg
PSBsZTMyX3RvX2NwdShjbWQtPnJ3LnJlZnRhZyk7Cj4+IMKgIMKgwqDCoMKgwqAgLyoKPj4gLcKg
wqDCoMKgICogQWxpZ24gdGhlIE1SIHRvIGEgNEsgcGFnZSBzaXplIHRvIG1hdGNoIHRoZSBjdHJs
IHBhZ2Ugc2l6ZSBhbmQKPj4gLcKgwqDCoMKgICogdGhlIGJsb2NrIHZpcnR1YWwgYm91bmRhcnku
Cj4+ICvCoMKgwqDCoCAqIEF0IHRoZSBtb21lbnQgd2UgaGFyZCBjb2RlIHRob3NlLCBidXQgaW4g
dGhlIGZ1dHVyZQo+PiArwqDCoMKgwqAgKiB3ZSB3aWxsIHRha2UgdGhlbSBmcm9tIGNtZC4KPj4g
wqDCoMKgwqDCoMKgICovCj4+IC3CoMKgwqAgbnIgPSBpYl9tYXBfbXJfc2cocmVxLT5tciwgcmVx
LT5kYXRhX3NnbC5zZ190YWJsZS5zZ2wsIGNvdW50LCBOVUxMLAo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgU1pfNEspOwo+PiAtwqDCoMKgIGlmICh1bmxpa2VseShuciA8IGNvdW50KSkg
ewo+PiAtwqDCoMKgwqDCoMKgwqAgaWJfbXJfcG9vbF9wdXQocXVldWUtPnFwLCAmcXVldWUtPnFw
LT5yZG1hX21ycywgcmVxLT5tcik7Cj4+IC3CoMKgwqDCoMKgwqDCoCByZXEtPm1yID0gTlVMTDsK
Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChuciA8IDApCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBucjsKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+PiArwqDCoMKg
IGRvbWFpbi0+c2lnLmRpZi5hcHB0YWdfY2hlY2tfbWFzayA9IDB4ZmZmZjsKPj4gK8KgwqDCoCBk
b21haW4tPnNpZy5kaWYuYXBwX2VzY2FwZSA9IHRydWU7Cj4+ICvCoMKgwqAgZG9tYWluLT5zaWcu
ZGlmLnJlZl9lc2NhcGUgPSB0cnVlOwo+PiArwqDCoMKgIGlmIChucy0+cGlfdHlwZSAhPSBOVk1F
X05TX0RQU19QSV9UWVBFMykKPj4gK8KgwqDCoMKgwqDCoMKgIGRvbWFpbi0+c2lnLmRpZi5yZWZf
cmVtYXAgPSB0cnVlOwo+PiArfQo+PiArCj4+Cj4KPiBPbiBhIHBlci1pbyBiYXNpcywgdGhlcmUg
bmVlZHMgdG8gYmUgc3BlY2lmaWMgZGVzY3JpcHRpb25zIG9mIHRoZSBESUYgCj4gaW5mb3JtYXRp
b24gdG8gcHJvZ3JhbSB0aGUgcG9ydCBoYXJkd2FyZS7CoCBUaGluZ3Mgc3VjaCBhcyBibG9jayBz
aXplLCAKPiB0eXBlLCBhbmQgc28uIEkgc2VlIHRoaXMgcm91dGluZSB1c2luZyBhIG1peCBvZiB0
aGUgYmlvIHRoYXQgaXMgCj4gYXNzb2NpYXRlZCB3aXRoIHRoZSBvcmlnaW5hbCByZXF1ZXN0IGFz
IHdlbGwgYXMgdGhlIG5hbWVzcGFjZSBwb2ludGVyIAo+IHRvIGdldCB0aGlzIGluZm8uIMKgwqAg
VG8gbWUgdGhlIHJlYWNoaW5nIGludG8gdGhlIGJpbywgYXMgd2VsbCBhcyB0aGUgCj4gbG9jYXRp
bmcgb2YgdGhlIG5zIHN0cnVjdHVyZXMgYXJlIHJlYWNoaW5nIGludG8gdGhlIG90aGVyIGxheWVy
cyB0b28gCj4gbXVjaC4KPgo+IFdvdWxkbid0IHdlIGJlIGJldHRlciBvZmYgd2l0aCB3aXRoIHRo
ZSBjb3JlIGxheWVyIGRvaW5nIGFsbCB0aGUgCj4gcmVhY2hpbmcgYW5kIHNldHRpbmcgdXAgYSBw
aSBzdHJ1Y3R1cmUgaW4gdGhlIG52bWVfcmVxdWVzdCB3aXRoIHRoaXMgCj4gaW5mb3JtYXRpb24g
P8KgwqAgcmVwbGFjZSBoYXNfcGkgd2l0aCB0aGlzIHBpIHN0cnVjdCBhbmQgCj4gIm52bWVfcmVx
KHJxKS0+cGkucGlfdHlwZSA9PSAwIiBpcyBlcXVpdmFsZW50IHRvIGhhc19waSA/wqDCoCBJZiB3
ZSAKPiBkaWRuJ3Qgd2FudCB0byByZXBsaWNhdGUgdGhlIFBJIGluZm8sIHRoZW4gbnZtZV9yZXF1
ZXN0IGNhbiBzaW1wbHkgYWRkIAo+IGEgcG9pbnRlciB0byB0aGUgbnMsIGFuZCB0aGUgbnMgY2Fu
IGJlIGxvb2tlZCBhdCBleHBsaWNpdGx5IHRvIGdhdGhlciAKPiB0aGUgYXR0cmlidXRlcy4KPgo+
IFRob3VnaHRzID8KPgpOVk1lIG5hbWVzcGFjZSBpcyB1c2VkIGJ5IFJETUEvVENQL0ZDIHRyYW5z
cG9ydCBkcml2ZXJzIGluIGVhY2ggcXVldWVfcnEgCmltcGxlbWVudGF0aW9uLiBXZSBjYW4gcGFz
cyBpdCBpbnN0ZWFkIG9mIHJlYWNoaW5nIGl0IGZyb20gdGhlIHJxLCBpZiAKdGhpcyBsb29rcyBi
ZXR0ZXIuCgpOVk1lIFBJIGF0dHJpYnV0ZXMgKGUuZ8KgIHJlZnRhZy9jaGVja19mbGFncy9hY3Rp
b25fZmxhZ3MpIGFyZSBhbGwgc2V0IGluIAp0aGUgY29yZSBsYXllci4KClBJIGF0dHJpYnV0ZXMg
Zm9yIGNvbmZpZ3VyaW5nIHRoZSBIVyBvZiBlYWNoIHRyYW5zcG9ydCBzaG91bGQgYmUgZG9uZSBp
biAKdGhlIHRyYW5zcG9ydCBkcml2ZXIuCgoKPiAtLSBqYW1lcwo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdAps
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
