Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFDAC282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 22:06:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F169D206DB
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 22:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dFSL381L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="oNl+EDHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F169D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jac987xsoGeCgn208DldMHMt91DsGALF6EE5lExC8ys=; b=dFSL381LQ3i7+DnxK6QMzDmSy
	wRbVD90A4WShycTyYsozhcQO1FboZ4sBFaGNGTDB4zt8i9LyyjIw0scDL53dKSFzcNjqH4PmFeH/H
	GsDRcEX0euwi41m1DWvwSGCC3g+ijQIC//x71vTrQMykC1zjrVmLTFn9S136e9Cd4FTD2Ai0G2Z90
	J0IL5GFL3U1KeEnQOS5V07pX/o3l3txN1vaysMPponfxtmrpwAXj97c9M62S8MnQIISURpvBqbEDv
	8v/o5Wv25Zcc/S0yCuBKSCGMBHo0NIsw+mQufX+l8josDDIUOBWeUI+oSpIHPshSJlV8hVTnXb0MZ
	oqksYJIhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipJT7-0006B2-Fi; Wed, 08 Jan 2020 22:06:25 +0000
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipJT4-0006AC-70
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 22:06:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1dFQRgk9eItNdTdk9jxcG2RskVr5RBV+EQNuPyZzgti5g1DKy9JzvY6nKr3DOYJXGLWeMEB49OLK35f4SEC39u0EEo5jCVbq6MHOFikMc8IQ8XHd9QxDWzwvueAspNX8K7t8lKjohuK7rTCaMFEeF9fi7T8i42jzapflKyVxfjYm7V0ZHPO5QEl7IuYNszb3qcBvsEqJY96fkYt0TNRg8bDCXzMOwE2Hnxrk6MTW8eT2wXHNdjoVBJu39PQOsEhI8QpMMg4HIQlP5oNSHpAYJz9LMJpSAB/oRJ0Aj5Zmru3OmoIHlTLnuiejIoNv4Ya/ZYE/9eP4UkgrkkWMrPY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is435NasdJMaUfP0yEiQkUVd1ShjOnNBE79DIDLbpeQ=;
 b=YdygwUa92Ml95ButM3f9ud7GFvY/5QYBoxwh4bmvm3MXTiRaxX2/FvO0yycj8FLj98Sj25DdSYjmyZTG5VlAc8cOjPxNpxdoWoL30HJ/lXXhOGdzC8wAYZqj71CUCMDrI0B8Op1hn+fjA0P++eWJLTsxWWJFS9snv+b1GH23ikoxClmr/mjPehw8VQM2Cp5YbZcwyeUjpQbvway0iyHUt+w9S0Vxy53B9InSf9YaCtyWwEE7mMW1qwYinI/7rbgNpa/9EQUGssi6zS/nxjhKVQJrzHnQy9ICTG1yT1pdejMwWYX2TaEMMpZrff/oX8QGHPmRAC9kT65KYBljXHL+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is435NasdJMaUfP0yEiQkUVd1ShjOnNBE79DIDLbpeQ=;
 b=oNl+EDHOs2/KKAmsD733HCHw99RaKtCj/RrGqUvt4fXzeN5pCXJ2iAD34L2d9C/JO8DgrOyYaE3JD5hwYUROcgeBfwT8xKWoly+2iBmBf7BVuqfN0ptvsrY2sviOEV+AvoilfS4rcXUcFbaQ5s1Nce0Um69QoI4dzw78iix/T9M=
Received: from DB7PR05CA0025.eurprd05.prod.outlook.com (2603:10a6:10:36::38)
 by DB6PR0501MB2310.eurprd05.prod.outlook.com (2603:10a6:4:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 8 Jan
 2020 22:06:18 +0000
Received: from VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by DB7PR05CA0025.outlook.office365.com
 (2603:10a6:10:36::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Wed, 8 Jan 2020 22:06:18 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT057.mail.protection.outlook.com (10.152.19.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 8 Jan 2020 22:06:17 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 9 Jan 2020 00:06:19
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 9 Jan 2020 00:06:19 +0200
Received: from [172.16.0.23] (172.16.0.23) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 9 Jan 2020 00:06:14
 +0200
Subject: Re: [PATCH v10 6/9] nvme: Export existing nvme core functions
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
References: <20200108174030.3430-1-logang@deltatee.com>
 <20200108174030.3430-7-logang@deltatee.com>
 <707b39a3-b58a-44b7-7ffa-0c2bd3f28e21@mellanox.com>
 <2d8a1cc2-be58-176e-b12b-8dbc5dab8739@deltatee.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f8a934d6-dc09-7211-650e-7cf45e24f9f2@mellanox.com>
Date: Thu, 9 Jan 2020 00:06:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <2d8a1cc2-be58-176e-b12b-8dbc5dab8739@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.16.0.23]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(186003)(54906003)(2616005)(36756003)(110136005)(16576012)(5660300002)(478600001)(336012)(53546011)(16526019)(26005)(966005)(356004)(81156014)(86362001)(31696002)(4326008)(8676002)(70206006)(36906005)(316002)(70586007)(31686004)(8936002)(81166006)(2906002)(3940600001)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0501MB2310; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27c0b797-e24e-458a-af3a-08d79486fc72
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2310:
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2310333FC653F6B2A03ED816B63E0@DB6PR0501MB2310.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQQihdgPXVxhybdP7JimlHyNybbi7YZMj5Q9UuQ4zBE97ilrEj4L4Xcphpz0VY67dX5uUi7eQL+XxRB2MIut3C5nTQE3QBJDNAgPxIW+u378lQPod+YdOzuoOzOY299PXCUcs5ApyzR/gQ9BX9uS1ojMOUySFRfisKlUEW+7MS408kGAnzzagAhtmGunRRwrD8TAQKU3tzNiRdF2QYp2xtkFclhyArhbnV5dM0FsNpRLs+2EfROmD7Su0tPDY+SidmLqLe/V5XHuu9K+73gDgzlemDxI3CmT4lVQVL5kCHyUNimyRE8jkHimR2bk1KfuqITueKkiJ4ku6tYLLGdAgdRz/SxPjayWvLn8gJBLmy2ZgKlJp0I6JIhNgoJ8mMSb0M/2f6IOL1j5GC8N6NsBl2zwhZzryfrQtoKALlfXKq3fZdqcK/lbmjlCsGFLkuC5zsqsC9nNf+OW26yQ6FnUkqBky8Yvm8hvj2lV5vTIDQaCfcj/1Mz3MF/FvhC4LuiwQ1kKMSHFk77PIrpUQRmmvxPh3ZcaKOmeLpE4inXc68VF8vf3YeDqZ/wVW+h56TMW4EzN4Dsg3PgizCVoRyMVOg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 22:06:17.6185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c0b797-e24e-458a-af3a-08d79486fc72
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2310
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_140622_261548_140BBC3C 
X-CRM114-Status: GOOD (  13.38  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDEvOC8yMDIwIDExOjUwIFBNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4KPiBPbiAyMDIw
LTAxLTA4IDI6NDggcC5tLiwgTWF4IEd1cnRvdm95IHdyb3RlOgo+PiBPbiAxLzgvMjAyMCA3OjQw
IFBNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6Cj4+PiBFeHBvcnQgbnZtZV9wdXRfbnMoKSwgbnZt
ZV9jb21tYW5kX2VmZmVjdHMoKSwgbnZtZV9leGVjdXRlX3Bhc3N0aHJ1X3JxKCkKPj4+IGFuZCBu
dm1lX2ZpbmRfZ2V0X25zKCkgZm9yIHVzZSBpbiB0aGUgbnZtZXQgcGFzc3RocnUgY29kZS4KPj4+
Cj4+PiBUaGUgZXhwb3J0cyBhcmUgY29uZGl0aW9uYWwgb24gQ09ORklHX05WTUVfVEFSR0VUX1BB
U1NUSFJVLgo+Pj4KPj4+IEJhc2VkLW9uLWEtcGF0Y2gtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50
aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+Cj4+PiAtLS0KPj4+ICDCoCBkcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMgfCAxNCArKysrKysrKystLS0tLQo+Pj4gIMKgIGRyaXZlcnMvbnZtZS9ob3N0
L252bWUuaCB8wqAgNSArKysrKwo+Pj4gIMKgIDIgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+PiBpbmRleCBkNzkxMmU3YTk5
MTEuLjAzNzQxNTg4MmQ0NiAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Ywo+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+PiBAQCAtNDYzLDcgKzQ2Myw3
IEBAIHN0YXRpYyB2b2lkIG52bWVfZnJlZV9ucyhzdHJ1Y3Qga3JlZiAqa3JlZikKPj4+ICDCoMKg
wqDCoMKgIGtmcmVlKG5zKTsKPj4+ICDCoCB9Cj4+PiAgwqAgLXN0YXRpYyB2b2lkIG52bWVfcHV0
X25zKHN0cnVjdCBudm1lX25zICpucykKPj4+ICt2b2lkIG52bWVfcHV0X25zKHN0cnVjdCBudm1l
X25zICpucykKPj4+ICDCoCB7Cj4+PiAgwqDCoMKgwqDCoCBrcmVmX3B1dCgmbnMtPmtyZWYsIG52
bWVfZnJlZV9ucyk7Cj4+PiAgwqAgfQo+Pj4gQEAgLTg5Niw4ICs4OTYsOCBAQCBzdGF0aWMgdm9p
ZCAqbnZtZV9hZGRfdXNlcl9tZXRhZGF0YShzdHJ1Y3QgYmlvCj4+PiAqYmlvLCB2b2lkIF9fdXNl
ciAqdWJ1ZiwKPj4+ICDCoMKgwqDCoMKgIHJldHVybiBFUlJfUFRSKHJldCk7Cj4+PiAgwqAgfQo+
Pj4gIMKgIC1zdGF0aWMgdTMyIG52bWVfY29tbWFuZF9lZmZlY3RzKHN0cnVjdCBudm1lX2N0cmwg
KmN0cmwsIHN0cnVjdAo+Pj4gbnZtZV9ucyAqbnMsCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHU4IG9wY29kZSkKPj4+ICt1MzIgbnZtZV9jb21tYW5kX2VmZmVjdHMoc3RydWN0
IG52bWVfY3RybCAqY3RybCwgc3RydWN0IG52bWVfbnMgKm5zLAo+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB1OCBvcGNvZGUpCj4+PiAgwqAgewo+Pj4gIMKgwqDCoMKgwqAgdTMyIGVmZmVj
dHMgPSAwOwo+Pj4gIMKgIEBAIC05ODIsNyArOTgyLDcgQEAgc3RhdGljIHZvaWQgbnZtZV9wYXNz
dGhydV9lbmQoc3RydWN0IG52bWVfY3RybAo+Pj4gKmN0cmwsIHUzMiBlZmZlY3RzKQo+Pj4gIMKg
wqDCoMKgwqDCoMKgwqDCoCBudm1lX3F1ZXVlX3NjYW4oY3RybCk7Cj4+PiAgwqAgfQo+Pj4gIMKg
IC1zdGF0aWMgdm9pZCBudm1lX2V4ZWN1dGVfcGFzc3RocnVfcnEoc3RydWN0IHJlcXVlc3QgKnJx
KQo+Pj4gK3ZvaWQgbnZtZV9leGVjdXRlX3Bhc3N0aHJ1X3JxKHN0cnVjdCByZXF1ZXN0ICpycSkK
Pj4+ICDCoCB7Cj4+PiAgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQgPSBudm1l
X3JlcShycSktPmNtZDsKPj4+ICDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2N0cmwgKmN0cmwgPSBu
dm1lX3JlcShycSktPmN0cmw7Cj4+PiBAQCAtMzQ0MSw3ICszNDQxLDcgQEAgc3RhdGljIGludCBu
c19jbXAodm9pZCAqcHJpdiwgc3RydWN0IGxpc3RfaGVhZAo+Pj4gKmEsIHN0cnVjdCBsaXN0X2hl
YWQgKmIpCj4+PiAgwqDCoMKgwqDCoCByZXR1cm4gbnNhLT5oZWFkLT5uc19pZCAtIG5zYi0+aGVh
ZC0+bnNfaWQ7Cj4+PiAgwqAgfQo+Pj4gIMKgIC1zdGF0aWMgc3RydWN0IG52bWVfbnMgKm52bWVf
ZmluZF9nZXRfbnMoc3RydWN0IG52bWVfY3RybCAqY3RybCwKPj4+IHVuc2lnbmVkIG5zaWQpCj4+
PiArc3RydWN0IG52bWVfbnMgKm52bWVfZmluZF9nZXRfbnMoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCwgdW5zaWduZWQgbnNpZCkKPj4+ICDCoCB7Cj4+PiAgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9u
cyAqbnMsICpyZXQgPSBOVUxMOwo+Pj4gIMKgIEBAIC00MjI1LDYgKzQyMjUsMTAgQEAgRVhQT1JU
X1NZTUJPTF9HUEwobnZtZV9zeW5jX3F1ZXVlcyk7Cj4+PiAgwqDCoCAqIHVzZSBieSB0aGUgbnZt
ZXQtcGFzc3RocnUgYW5kIHNob3VsZCBub3QgYmUgdXNlZCBmb3IKPj4+ICDCoMKgICogb3RoZXIg
dGhpbmdzLgo+Pj4gIMKgwqAgKi8KPj4+ICtFWFBPUlRfU1lNQk9MX0dQTChudm1lX3B1dF9ucyk7
Cj4+PiArRVhQT1JUX1NZTUJPTF9HUEwobnZtZV9jb21tYW5kX2VmZmVjdHMpOwo+Pj4gK0VYUE9S
VF9TWU1CT0xfR1BMKG52bWVfZXhlY3V0ZV9wYXNzdGhydV9ycSk7Cj4+PiArRVhQT1JUX1NZTUJP
TF9HUEwobnZtZV9maW5kX2dldF9ucyk7Cj4+IFNpbmNlIHRoaXMgaXMgdGhlIGNvbnZlbnRpb24g
aW4gdGhlIGRyaXZlciwgY2FuIHlvdSBleHBvcnQgdGhlIHN5bWJvbHMKPj4gYXQgdGhlIGVuZCBv
ZiBlYWNoIGZ1bmN0aW9uID8KPiBDaHJpc3RvcGggc3BlY2lmaWNhbGx5IGFza2VkIGZvciB0aGVz
ZSB0byBiZSBleHBvcnRlZCBhdCB0aGUgZW5kIG9mIHRoZQo+IGZpbGUgd2l0aGluIGFuICNpZmRl
ZiBDT05GSUdfTlZNRV9UQVJHRVRfUEFTU1RIUlUuCgpJIHNlZS4KCkFyZSB3ZSBnb29kIHdpdGgg
dGhlIGZhY3QgdGhhdCB0aGUgZnVuY3Rpb25zIGFyZSBub3Qgc3RhdGljIHdoZW4gCkNPTkZJR19O
Vk1FX1RBUkdFVF9QQVNTVEhSVSBpcyBub3QgZGVmaW5lZCA/Cgo+IExvZ2FuCj4KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGxpbnV4LW52bWUgbWFp
bGluZyBsaXN0Cj4gbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlz
dApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
