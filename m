Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8865AC4332E
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 09:16:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA2B20724
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U3nUWAEw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="b794IKbk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA2B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l00X+mPP66qscxlCm/DqsQ6SfScOfo+WqEaCsqos9tw=; b=U3nUWAEwIZKV7S9oSWIXUsy6c
	L2MjGEtMHrx1ry/etiQrPryOcvSY+BqOmbShKQiLFLij6BhmAv2vrMPqE79y7sVb1TVWPY/ICUBRf
	TeysVErF0WSjVtjujcMqJDsjX7XRjjaYVsOc30lU+i2yFCDeSB4A+fq/KnLRkOQtn3vPX81cFIIQa
	moXqHpPEddX5SzdOkg6F94kPtNveBYBzw3nJLP4ObD4eOi/EqFS0p85tfrnvscjYTOLctQqGEJZGC
	TkDH7ENboZqjBZ+uKNlcOoRxkX4HodNVP0NbjzdVQjUddKPm3lhTuEr7GzbJXv0E2sdOD+BJO56ZE
	8+tYR5TCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jErHn-0000AW-B8; Thu, 19 Mar 2020 09:16:19 +0000
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jErHk-00009S-KH
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 09:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF6AmU1+jd1IxOa/vE7wqXJDBiLGHiuJp2s67J9im8od1nC6GDpIhQWwdXCFozjS3Xeo+SOTDHdy97ZLUKcCP1faJghwoHoCdpKqm4yDzHvmHcA1Y9M6Bp9EatFoXcz+GX5HmJoNIntTUDbXRgD4QJSdJF/Ipr3JB1R9lJYVS3LadsA9ZNh9exz7sU6urJ5tmu2iX7+s73mIMpE3Y2pTiuG/JdINk2lf/+NogHHCbUvFStS1ggL9WCp7+H2TNUIP/cHTlGCPatBj1OXosW9y9jeJ9f4XQ7k+HrDLD66KjYwbilvxgpfszOkfPUJLWGl8ejJjqW/BPt/BppJw/a8LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WFD5nF83fOUr4Mwsn6kyA0PKIVAxsLJoDIRsMSUNPM=;
 b=Oi2eMFgikrGtHMR/T0lEy1oWnTMevOI0oMQIwA90Pbdl7jdtxm95OHSnaKcNyuJdARLpNgd2vFESEHazyIhZ6VqIR+l2f7Cw1Z1Tz8+UUe4sDdtaA4c+WeBdp1SROZK1Z8NoJHSdkfHsTnT6Ein4DgzjuZVHw0v7otnU9UlOaKZqQN1KETgJXZLVShtlcSf/usFsT++VGdUK7IxBqE+LUQ1XhSFjUCCIeYoKn/yQG7lmH/cXWygiZj59InW2Wwl2UNfZ22ZN2IFV3eA/3DBdG+xbeD6uK+VcBU6J6oHMiROaLKkafInmcgp44pewHUnpkc6JPL9gRqUo/DI4N+2RgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WFD5nF83fOUr4Mwsn6kyA0PKIVAxsLJoDIRsMSUNPM=;
 b=b794IKbklMRxQSViqVYIbVTJstEBHHZkaztfUS+SosM2WuOyqSO8eLnjuKX5z2eKqCRQ2X3qey7LbT8uK6ii4EfaaKYWf7Oqib+NRmHHeNk4HoG4vZgjC+Z5DsKEiFm5PSDMdUCvmPbpYqX6qsduiG45O598eWnRaRv3GLC0u0o=
Received: from AM5PR0602CA0017.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::27) by DB6PR0501MB2615.eurprd05.prod.outlook.com
 (2603:10a6:4:8d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Thu, 19 Mar
 2020 09:16:12 +0000
Received: from AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:a3:cafe::4d) by AM5PR0602CA0017.outlook.office365.com
 (2603:10a6:203:a3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend
 Transport; Thu, 19 Mar 2020 09:16:12 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT035.mail.protection.outlook.com (10.152.16.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Thu, 19 Mar 2020 09:16:12 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 19 Mar 2020 11:16:02
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 19 Mar 2020 11:16:02 +0200
Received: from [172.27.15.129] (172.27.15.129) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Thu, 19 Mar 2020 11:15:51 +0200
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
To: Bart Van Assche <bvanassche@acm.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>, <hch@lst.de>, <loberman@redhat.com>,
 <linux-rdma@vger.kernel.org>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
Date: Thu, 19 Mar 2020 11:15:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
Content-Language: en-US
X-Originating-IP: [172.27.15.129]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(199004)(46966005)(36756003)(336012)(26005)(2616005)(47076004)(2906002)(4744005)(478600001)(5660300002)(186003)(16526019)(356004)(4326008)(53546011)(31686004)(316002)(70206006)(31696002)(8676002)(110136005)(70586007)(54906003)(81166006)(8936002)(86362001)(36906005)(16576012)(81156014)(3940600001)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0501MB2615; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 864026af-6d81-43ef-5b2d-08d7cbe62b22
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2615:
X-Microsoft-Antispam-PRVS: <DB6PR0501MB261561E290B404FCFDD36237B6F40@DB6PR0501MB2615.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0347410860
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vE4er8Wy7PtS+1CR6fFFQE3XpCUdkTobC2/d3CidxWHh2fRJdLCFLaAI4OqrKhu6qj6SS7UJI+75Ecprgeb2JzCrMK/RAzGiE/zTbmYGAAmncwvGka498x+cGP722sfy9czw/MjYyNXC71vD4JjGWcBdi3SViR/MCUcXcQw9gaz14C6IPg+BH8Cnt0mUmy7sjT3BqdhSfrC5dNW7uun5dde9daaiRd3jYkQtm8aQfoKee6SQDApGdIcKTmfV+FnOGDQ6FQiMWEFxKsoxw0LCLWqiOpaCYWQYmkS1KarycHM40W7zghOaEPmuOnuu7uwk/HrJqVH1eKrvB8e7vi7n/EhPyQ6Tt4kWLynTEOpH2Wue84ukIGmVZHkOvkJa4UwEQRZTq87BLMqIYki53L0sQYmr4Ez6ddDix5/vlcnsHg7LRqZ1VWBFG73tL361ggVolSZGexsVOD5y7ruaQUt34gbACtoY3BIZWmBxr1B7EnmShbyzaq7Xb7TD+7zVu1PZvJKEAQEDRjwJ7h/f0BWR+cED3hANiIRqVXAYvY4FhIgN/9KCd1bzVjxXBZ9wsZ+Q
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 09:16:12.0311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 864026af-6d81-43ef-5b2d-08d7cbe62b22
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2615
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200319_021616_669086_CECCE298 
X-CRM114-Status: GOOD (  10.30  )
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
Cc: rgirase@redhat.com, vladimirk@mellanox.com, shlomin@mellanox.com,
 leonro@mellanox.com, dledford@redhat.com, jgg@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, idanb@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMTkvMjAyMCA2OjA5IEFNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6Cj4gT24gMjAyMC0w
My0xOCAwODowMiwgTWF4IEd1cnRvdm95IHdyb3RlOgo+PiBJbiBvcmRlciB0byBzYXZlIHJlc291
cmNlIGFsbG9jYXRpb24gYW5kIHV0aWxpemUgdGhlIGNvbXBsZXRpb24KPiAgICAgICAgICAgICAg
ICAgICAgIF5eXl5eXl5eXl5eXl5eXl5eXl4KPiAgICAgICAgICAgICAgICAgICAgIHJlc291cmNl
cz8KCnRoYW5rcy4KCgo+Cj4+ICtzdGF0aWMgaW50IG52bWV0X3JkbWFfc3JxX3NpemUgPSAxMDI0
Owo+PiArbW9kdWxlX3BhcmFtX2NiKHNycV9zaXplLCAmc3JxX3NpemVfb3BzLCAmbnZtZXRfcmRt
YV9zcnFfc2l6ZSwgMDY0NCk7Cj4+ICtNT0RVTEVfUEFSTV9ERVNDKHNycV9zaXplLCAic2V0IFNo
YXJlZCBSZWNlaXZlIFF1ZXVlIChTUlEpIHNpemUsIHNob3VsZCA+PSAyNTYgKGRlZmF1bHQ6IDEw
MjQpIik7Cj4gSXMgYW4gU1JRIG92ZXJmbG93IGZhdGFsPyBJc24ndCB0aGUgU1JRIHNpemUgc29t
ZXRoaW5nIHRoYXQgc2hvdWxkIGJlCj4gY29tcHV0ZWQgYnkgdGhlIG52bWV0X3JkbWEgZHJpdmVy
IHN1Y2ggdGhhdCBTUlEgb3ZlcmZsb3dzIGRvIG5vdCBoYXBwZW4/CgpJJ3ZlIGFkZGVkIHRoZSBm
b2xsb3dpbmcgY29kZSB0byBtYWtlIHN1cmUgdGhhdCB0aGUgc2l6ZSBpcyBub3QgZ3JlYXRlciAK
dGhhbiBkZXZpY2UgY2FwYWJpbGl0eToKCituZGV2LT5zcnFfc2l6ZSA9IG1pbihuZGV2LT5kZXZp
Y2UtPmF0dHJzLm1heF9zcnFfd3IsCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXRfcmRtYV9zcnFfc2l6ZSk7CgpJbiBjYXNlIHRoZSBT
UlEgZG9lc24ndCBoYXZlIGVub3VnaCBjcmVkaXRzIGl0IHdpbGwgc2VuZCBybnIgdG8gdGhlIApp
bml0aWF0b3IgYW5kIHRoZSBpbml0aWF0b3Igd2lsbCByZXRyeSBsYXRlciBvbi4KCldlIG1pZ2h0
IG5lZWQgdG8gY2hhbmdlIHRoZSBtaW5fcm5yX3RpbWVyIGR1cmluZyB0aGUgY29ubmVjdGlvbiAK
ZXN0YWJsaXNobWVudCwgYnV0IHN0aWxsIGRpZG4ndCBzZWUgdGhlIG5lZWQgZm9yIGl0LgoKLU1h
eAoKPgo+IFRoYW5rcywKPgo+IEJhcnQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
