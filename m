Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15092C2BB1D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 21:57:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75B120724
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 21:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZUOR6Us7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hAdL4K/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75B120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zDuaxfZLW42Og/7kbVG7tRyBK/gUDqB4p+RmPnZUcVU=; b=ZUOR6Us75VqggA4NfHV1FtPSe
	eWQw1Y5ZCF8nPBTwpg8kXfZHoJR+mNfH8qeH+8b/3jES45z0d7C1X/eMEg+FORF+2m2cU6/h6mRWe
	N5Aw5ieyqoxMON3KiSBCoh9gLM51MAQhaoVJZr177D8mm09tIG9+Bv5fVb5azxaiO7nGSuVc3Mu26
	kgedydzWuCJnRRlwfjhDzcEBxSoGH9oJXfGbwqJepPGgehZhb8QSrfeGUzBE5NCa9PIaVNX7uugKa
	sJNpFZU4UqTprnXyOG40W1U0vUzIIat+qVgY+s0Emxi+UVf0n2GlHTNUoPpHdZW1T/5vKMNmEvvT1
	qxdE09YDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEKCu-0002lv-4s; Tue, 17 Mar 2020 21:57:04 +0000
Received: from mail-eopbgr90089.outbound.protection.outlook.com ([40.107.9.89]
 helo=FRA01-MR2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEKCp-0002kv-Oc
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 21:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dO+ABR8atUPp71iBhU6SGbTK5bf7NvI9ibbFMt+U2zNeQ32pfxmzpqyks0UfkoiGKbHHsuEP/YFczPMzkn563b/luVAj/kVNh3cZwzQg+XA2FB/jyO74FxhN/CyH+2Q/eACaiGorbxAekBRapZtaAKgWBFZEGHgtFfj1VpCwp9JGa2LOIZbstaJm7ePqQ5Pxv0CwGZ0yxH4UR6cQwWkowJwxWbkxkCf3lOZ3BnF61UxJP9mpCkIP2+JlxRMMmJnDUXENuLE97Gshj4os6rtIjNyE+xzjMweeNzvOtyOIZQ2kRg1pDhcRtUq4Xlx4O+43euOAMsjCqpB0XcXNX/tQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCOV0b9sx1SlfGSKVGBSA+gLRUuwd3Z017RAawaOGSE=;
 b=Yh6QkEezrT2BKuAPrD3gH7dpzKQP73ETDUqXUjeM8DhD7mMPK17ArQqNKUzcC3Fz87ueoDIyQMV9SEgagPwSKxR0p3QdGhfg+66ldzk1fGh/XPg8BPphYqkTfW6d8825GORiFRc/DZIDuSh9Vkt7ideJnkblkLfxJHYocc64eqxstyo45T8NoME9gC7uaq+BPvO2YjaxJ2PHAR7PGMOEf9Pyw2imjaUrY2TxkqgnFyEVTm92BNTi38tMxxzCg7ZmMbgcEX/v/00okD7ydxxm1cAkgbULWX6au+9Eq6qLpxcgXzkLZjBh4qf9C7ieP30Pv0kca02+n71ffWHS2QCpZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCOV0b9sx1SlfGSKVGBSA+gLRUuwd3Z017RAawaOGSE=;
 b=hAdL4K/3o49qFaJmcEtDHVLknudBVidL5dFjaW6q7i5yoZuF8fOvTJnhcN+GfQAxNc8HW7/QmbxqvorD8FVVe7sMPCJzxjStdJcUBt9P1PJH7TBWu2WpSZTFFfevzIrxBle64Aw3y3OQ2SUdQwqwQxSAMoZvh1pUhOeK4qZydmA=
Received: from VI1PR0701CA0068.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::30) by PR1PR05MB5483.eurprd05.prod.outlook.com
 (2603:10a6:102:c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13; Tue, 17 Mar
 2020 21:56:40 +0000
Received: from VE1EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:800:5f:cafe::1b) by VI1PR0701CA0068.outlook.office365.com
 (2603:10a6:800:5f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend
 Transport; Tue, 17 Mar 2020 21:56:40 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT022.mail.protection.outlook.com (10.152.18.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 21:56:38 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 17 Mar 2020 23:56:37
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 17 Mar 2020 23:56:36 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 17 Mar 2020 23:56:17 +0200
Subject: Re: [PATCH 1/5] IB/core: add a simple SRQ set per PD
To: Jason Gunthorpe <jgg@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-2-maxg@mellanox.com> <20200317135518.GG3351@unreal>
 <46bb23ed-2941-2eaa-511a-3d0f3b09a9ed@mellanox.com>
 <20200317181036.GX13183@mellanox.com>
 <290500dc-7a89-2326-2abf-1ab9f613162e@mellanox.com>
 <20200317184338.GY13183@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <d2e06706-4671-aeab-1c7e-c5bf0f3c65a4@mellanox.com>
Date: Tue, 17 Mar 2020 23:56:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317184338.GY13183@mellanox.com>
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(396003)(346002)(199004)(46966005)(336012)(16526019)(81156014)(26005)(186003)(31696002)(8676002)(86362001)(2616005)(81166006)(107886003)(37006003)(6862004)(2906002)(6636002)(54906003)(16576012)(4326008)(70586007)(356004)(53546011)(478600001)(31686004)(8936002)(316002)(36906005)(36756003)(70206006)(47076004)(5660300002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:PR1PR05MB5483; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ef0a246-ff5d-445e-6d43-08d7cabe11dd
X-MS-TrafficTypeDiagnostic: PR1PR05MB5483:
X-Microsoft-Antispam-PRVS: <PR1PR05MB548323DD6E59370B79C54844B6F60@PR1PR05MB5483.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/7+PfaPqTV4zAGoqp22Qi0rr1SpV1JVlxRgCFml/LBC8VYPwvShtgs27NGCsms/Q0WbCOCw/lga1/mxGZz3q3hUFI2lqdGI2sOwPvDG9NeeyYAIjSkEMLK3HKsix/zFt37+kiOCGtFI9uWD5txnbZoQ1Q/+6TXFffucr/cTUTVM+Ah0OQowH4v8R7tyYwh027jiEVL+OOARJdSMaudqRt68O0d99oR/g56r/Syqi4La4JWpLij5/aiiu5VRK7KhrqPUwqGghSFqM8WF3+ui6MV8yM60ZH9Lz3rHNjynljtkJVQZtoYmi/t1ywF/NvVaz9PKJdwLiP8VFnNdEvd1G6CFnHMH4cca8+5MX+9NkbYQ9gEdaqgwglOZZylsZB6INJsmqpdNQr+magWNm7OeaJq2SXjCMsBgfQotViu5/AuSu4sp4HYYJ4gKdghrqKBNPfdP0Huo2cDHenHLOOiFPg16S41TuO3Fhm6Fp35A/+RXABL3QpvUDqfgqW8EhHtfea9962KIEs/xIf9WNuKRhnHinKTTl1cg5jdpwaWXby0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 21:56:38.6373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef0a246-ff5d-445e-6d43-08d7cabe11dd
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR05MB5483
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_145701_332988_280B6158 
X-CRM114-Status: GOOD (  16.94  )
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
Cc: loberman@redhat.com, bvanassche@acm.org, vladimirk@mellanox.com,
 idanb@mellanox.com, linux-rdma@vger.kernel.org, shlomin@mellanox.com,
 linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@mellanox.com>,
 dledford@redhat.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMTcvMjAyMCA4OjQzIFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6Cj4gT24gVHVlLCBN
YXIgMTcsIDIwMjAgYXQgMDg6MjQ6MzBQTSArMDIwMCwgTWF4IEd1cnRvdm95IHdyb3RlOgo+PiBP
biAzLzE3LzIwMjAgODoxMCBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4gT24gVHVlLCBN
YXIgMTcsIDIwMjAgYXQgMDY6Mzc6NTdQTSArMDIwMCwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Pj4K
Pj4+Pj4+ICsjaW5jbHVkZSA8cmRtYS9pYl92ZXJicy5oPgo+Pj4+Pj4gKwo+Pj4+Pj4gK3N0cnVj
dCBpYl9zcnEgKnJkbWFfc3JxX2dldChzdHJ1Y3QgaWJfcGQgKnBkKTsKPj4+Pj4+ICt2b2lkIHJk
bWFfc3JxX3B1dChzdHJ1Y3QgaWJfcGQgKnBkLCBzdHJ1Y3QgaWJfc3JxICpzcnEpOwo+Pj4+PiBB
dCB0aGUgZW5kLCBpdCBpcyBub3QgZ2V0L3B1dCBzZW1hbnRpY3MgYnV0IG1vcmUgYWRkL3JlbW92
ZS4KPj4+PiBzcnEgPSByZG1hX3NycV9hZGQgPwo+Pj4+Cj4+Pj4gcmRtYV9zcnFfcmVtb3ZlKHBk
LCBzcnEpID8KPj4+Pgo+Pj4+IERvZXNuJ3Qgc2VlbXMgcmlnaHQgdG8gbWUuCj4+Pj4KPj4+PiBM
ZXRzIG1ha2UgaXQgc2ltcGxlLiBGb3IgYXNraW5nIGEgU1JRIGZyb20gdGhlIFBEIHNldCBsZXRz
IHVzZSByZG1hX3NycV9nZXQKPj4+PiBhbmQgcmV0dXJuaW5nIHRvIHdlJ2xsIHVzZSByZG1hX3Ny
cV9wdXQuCj4+PiBJcyB0aGVyZSByZWZlcmVuY2UgY291dGluZyBoZXJlPyBnZXQvcHV0IHNob3Vs
ZCBiZSByZXN0cmljdGVkIHRvCj4+PiByZWZjb3VudGluZyBBUElzLCBJTUhPLgo+PiBJJ3ZlIGFk
ZGVkIGEgY291bnRlciAocGQtPnNycXNfdXNlZCkgdGhhdCBMZW9uIGFza2VkIHRvIHJlbW92ZSAu
Cj4+Cj4+IFRoZXJlIGlzIG5vIGNhbGwgdG8ga3JlZiBnZXQvcHV0IGhlcmUuCj4gSSBkaWRuJ3Qg
bG9vayBjbG9zZWx5LCBhbnkga2luZCBvZiByZWZjb3VudCBzY2hlbWUgaXMgcmVhc29uYWJsZSwg
YnV0Cj4gaWYgYWRkIGlzIHN1cHBvc2VkIHRvIGNyZWF0ZSBhIG5ldyBzcnEgdGhlbiB0aGF0IGlz
bid0ICdnZXQnLi4KCk5vLCB3ZSBkb24ndCBjcmVhdGUgbmV3IHNycSBkdXJpbmcgdGhlICJnZXQi
LiBXZSBjcmVhdGUgYSBzZXQgdXNpbmcgCiJyZG1hX3NycV9zZXRfaW5pdCIuCgoiZ2V0IiB3aWxs
IHNpbXBsZSBwdWxsIHNvbWUgc3JxIGZyb20gdGhlIHNldCBhbmQgInB1dCIgd2lsbCBwdXNoIGl0
IGJhY2suCgo+Cj4+IERvIHlvdSBwcmVmZXIgdGhhdCBJJ2xsIGNoYW5nZSBpdCB0byBiZSBhcnJh
eSBpbiBQRDogInN0cnVjdAo+PiBpYl9zcnHCoMKgwqDCoMKgwqDCoMKgwqDCoCAqKnNycXM7IiA/
Cj4gTm90IHBhcnRpY3VsYXJseS4uCj4KPiBJdCBhY3R1YWxseSBmZWVscyBhIGJpdCB3ZWlyZCwg
c2hvdWxkIHRoZXJlIGJlIHNvbWUgbnVtYS1uZXNzIGludm9sdmVkCj4gaGVyZSBzbyB0aGF0IHRo
ZSBTUlEgd2l0aCBtZW1vcnkgb24gdGhlIG5vZGUgdGhhdCBpcyBnb2luZyB0byBiZQo+IHBvbGxp
bmcgaXQgaXMgcmV0dXJuZWQ/CgpNYXliZSB0aGlzIHdpbGwgYmUgdGhlIG5leHQgaW1wcm92ZW1l
bnQuIEJ1dCBmb3Igbm93IHRoZSByZWNlaXZlIGJ1ZmZlcnMgCmFyZSBhbGxvY2F0ZWQgYnkgdGhl
IFVMUC4KClRoZSBpZGVhIGlzIHRvIHNwcmVhZCB0aGUgU1JRcyBhcyBtdWNoIGFzIHBvc3NpYmxl
IGFzIHdlIGRvIGZvciBRUC9DUSB0byAKcmVhY2ggYWxtb3N0IHRoZSBzYW1lIHBlcmZvcm1hbmNl
LgoKSW4gY2FzZSBvZiAxIFNSUSB3ZSBjYW4ndCByZWFjaCBnb29kIHBlcmZvcm1hbmNlIHNpbmNl
IG1hbnkgcmVzb3VyY2VzIAphbmQgY29yZXMgYXJlIHJhY2luZyBmb3IgMSByZXNvdXJjZXMuCgpJ
biBjYXNlIG9mIHJlZ3VsYXIgUlEgd2UgYWxsb2NhdGUgbWFueSBidWZmZXJzIHRoYXQgbW9zdCBv
ZiB0aGUgdGltZSBhcmUgCmlkbGUuCgpJZiB3ZSdsbCBzcHJlYWQgU1JRcyBmb3IgYWxsIGNvcmVz
L3ZlY3RvcnMgd2UgaGF2ZSB3ZSdsbCBnZXQgZ3JlYXQgcGVyZiAKd2l0aCBzYXZpbmcgcmVzb3Vy
Y2VzIHRoYXQgbWlnaHQgYmUgY3JpdGljYWwgaW4gTVEgVUxQcyBhcyBOVk1mL1NSUCAKdGFyZ2V0
cyB0aGF0IG1pZ2h0IHNlcnZlIGh1bmRyZWRzIGluaXRpYXRvcnMgd2l0aCBodW5kcmVkcyBvZiBx
dWV1ZXMgZWFjaC4KCgo+Cj4+IEFuZCB1cGRhdGUgaWJfYWxsb2NfcGQgQVBJIHRvIGdldCBwZF9h
dHRycyBhbmQgYWxsb2NhdGUgdGhlIGFycmF5IGR1cmluZyBQRAo+PiBhbGxvY2F0aW9uID8KPiBU
aGUgQVBJIGlzIGEgYml0IG1vcmUgY29tcG9zYWJsZSBpZiB0aGluZ3MgY2FuIGNhbiBiZSBkb25l
IGFzCj4gZm9sbG93aW5nIGZ1bmN0aW9uIGNhbGxzIGFyZSBkb25lIHRoYXQgd2F5Li4gSSBkb24n
dCBsaWtlIHRoZSBnaWFudAo+IG11bHRpcGxleG9yIHN0cnVjdHMgaW4gZ2VuZXJhbAo+Cj4gSmFz
b24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
