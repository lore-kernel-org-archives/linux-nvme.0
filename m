Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C3C3F2CE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:49:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA65422B48
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 16:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EkuXAJ23";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="k+KuMJFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA65422B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1/S0/d1r+x9KT0U4Xe/WlHyT1M41CI+LXYGCVOym0nY=; b=EkuXAJ23OQLYRIePqtLhgXwKu
	/JH8lQLHE/gX42T5k9OgFDtRAJQuSJ/GAkZ0Ib+msFaK4/H4USYfygRv6QIFYheWgTwJulu9fJN2m
	HxfgO+ZN9SSYusoiMiCxbKPQHxsh3WT1HhM5K6ghLsbLioZojba/cWuQ+d9aaTHNM3L5Yi+5H2Jv7
	rJ+bY9vN+uDhgrUPRjI6j1CqGPypBT4i7W+gMzsO9Kz9FLrn3yalFp31QM+G1kKtnn6X2mI4b3YLt
	nz8tEUsN0e3NXh2l+SEazB4qBTBmDZJ6d4mPzjX/Gs9en63z1q75RTB0ZWsa9uqD9rdTTArV8yJuC
	mv44sqzrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9XCd-0007ST-9f; Wed, 04 Mar 2020 16:48:59 +0000
Received: from mail-ve1eur01on061c.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::61c]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9XCa-0007RI-IF
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 16:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdDy6OY1PpVPsUnficsg1zZeFP4yqJr1lXlVBY/V8CdKE/aLILVjGX31K6pSsS8F/4PnOJJu39V4HI8y+gvmeZAtpt7vaeifKsMTscTPEfZHYFjzXaupyyLGy68AgiHtrl4Dw+OkZmTaF/VXwh8ZR1qRrVRTne+Ua3TuWLnsSEeCNiDfGG1yXnQ6CaUjx4V/flNZIsTxHcq4L4wLjr1Wz6pnVP7eM3677MY39NvTfNrJS9qDe/DnfczjG8npFdkms1atluVtlOCcm98ZgphjUwfes1elBPsHaczk+Ckfu7QnkN6Va84ofnn7tKKsjkG5NGzC3x6qx4RJPEOyIHLjQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWL2CxRyQ5GSAnHXPfirSQvws9b413tugZDsEjJO/14=;
 b=g2dcHS1BVVIq1EPuaHFFuEvvhKf8O4lKtD5JqX4+Q25LtfIDeoDNPFr0gp59GUfXypFWBAMf2Mo7N9woG51tB752xSOjEI6oppF3+PDeEIjW/c1x7gHZSbaYcMSm6d2R4AiuxCFp3Af4gos9kEi2NPZzwqFcjjq+J6s0fHsSCeGK75NBwN2WVGOQABfE9a1kkhlr1kfRqjgPZZ1U4oAUbsUimCcyJ1XntDXUOKF+dI5jIryUMJRYI8+GxHzUgzH5TIvKs/j0Z4f6l5TU12C13B2JCeW8w7/yKBxSB0cSHZnlo994hrSAHRXSZ60nXBmtd+Uzi6ct8LAw2TCzeiEX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=chelsio.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWL2CxRyQ5GSAnHXPfirSQvws9b413tugZDsEjJO/14=;
 b=k+KuMJFY8lth/lQe5x/KnLypQhPEOF7SUAJyepBBkN4TO8IT62bvtBDSSDc/uKFI22LSDGkHlVtJvKiLgGXYsSPD+ZF93Qtk2PcgRBA4RIkJZTVcOF1YgdMtyBjvp1BWml3r2WQmqEiFORRnNQdWuxkgyyB5gktt/V6mn05mQbE=
Received: from HE1PR05CA0327.eurprd05.prod.outlook.com (2603:10a6:7:92::22) by
 AM0PR05MB4836.eurprd05.prod.outlook.com (2603:10a6:208:cb::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Wed, 4 Mar 2020 16:48:53 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::203) by HE1PR05CA0327.outlook.office365.com
 (2603:10a6:7:92::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 16:48:52 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:48:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 4 Mar 2020 18:48:51
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 4 Mar 2020 18:48:51 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Mar 2020 18:48:11
 +0200
Subject: Re: [PATCH 1/3] nvmet: Add mdts setting op for controllers
To: Bart Van Assche <bvanassche@acm.org>, <jgg@mellanox.com>,
 <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <kbusch@kernel.org>, <Chaitanya.Kulkarni@wdc.com>
References: <20200304153935.101063-1-maxg@mellanox.com>
 <2063651c-47d7-6b79-215f-7367e27202bf@acm.org>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3a06e413-097b-28d4-6a76-a7e048d07922@mellanox.com>
Date: Wed, 4 Mar 2020 18:48:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2063651c-47d7-6b79-215f-7367e27202bf@acm.org>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(26005)(16526019)(86362001)(356004)(70586007)(70206006)(53546011)(2616005)(186003)(336012)(36756003)(36906005)(5660300002)(316002)(16576012)(81156014)(54906003)(31696002)(2906002)(4326008)(8936002)(110136005)(8676002)(31686004)(478600001)(81166006)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB4836; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 665faa77-deff-4d8a-2afd-08d7c05bebcf
X-MS-TrafficTypeDiagnostic: AM0PR05MB4836:
X-Microsoft-Antispam-PRVS: <AM0PR05MB4836FE03641FCB012AD897C6B6E50@AM0PR05MB4836.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3POnw/YKn7kLLc0RWTytR6diqvSNwOP0WzvKwGizW8jEDMcYZ/FjZ49U4kVV/dF8r57VFHa6UphKfdUfpVixpyBXEQUBT4vrgAyLRgpSmhhSrs79k1I+IyXLxHzdkiY1WVf8ZWxRgZ7VCqEyKUYilR+f0yyw30wUgvlrSmOB0xcbDrJ+Er2wfJFIzvrxaS/wvo/YGIWuAVbTYPP0xaMBp251lRmOoU6g634J+K31lTRRhJzN0d67L2g/n80WYawQCspLmxAl9hsOPMjswFMncmKm8sDt794z10ILIl5X7pBHvBuDekS5clUq9cExgqIfgbQI/ZJToJZsxT+vg4SDFT+Gwhi5n9KCZzGvuS37PK11pNUiAN31qFxKL3Wfpe2jiL26kWZ8gHpLz3O7zw78YtOftyi6nqW9qGoo6RzYtnzg3tujVhK3zg5+Ir1SGUO2GqyPhQCW7sZu1giuM5tcoQZbzbecQ9Hpe/nW1K/MD8ahEj5+Lslor2/0399r27m
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:48:52.5378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665faa77-deff-4d8a-2afd-08d7c05bebcf
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4836
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_084856_609049_138E161A 
X-CRM114-Status: GOOD (  17.19  )
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
Cc: krishna2@chelsio.com, bharat@chelsio.com, nirranjan@chelsio.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvNC8yMDIwIDY6MzYgUE0sIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToKPiBPbiAzLzQvMjAg
NzozOSBBTSwgTWF4IEd1cnRvdm95IHdyb3RlOgo+PiBTb21lIHRyYW5zcG9ydHMsIHN1Y2ggYXMg
UkRNQSwgd291bGQgbGlrZSB0byBzZXQgdGhlIE1heGltdW0gRGF0YQo+PiBUcmFuc2ZlciBTaXpl
IChNRFRTKSBhY2NvcmRpbmcgdG8gZGV2aWNlL3BvcnQvY3RybCBjaGFyYWN0ZXJpc3RpY3MuCj4+
IFRoaXMgd2lsbCBlbmFibGUgdGhlIHRyYW5zcG9ydCB0byBzZXQgdGhlIG9wdGltYWwgTURUUyBh
Y2NvcmRpbmcgdG8KPj4gY29udHJvbGxlciBuZWVkcyBhbmQgZGV2aWNlIGNhcGFiaWxpdGllcy4g
QWRkIGEgbmV3IG52bWV0IHRyYW5zcG9ydAo+PiBvcCB0aGF0IGlzIGNhbGxlZCBkdXJpbmcgY3Ry
bCBpZGVudGlmaWNhdGlvbi4gVGhpcyB3aWxsIG5vdCBlZmZlY3QKPj4gdHJhbnNwb3J0cyB0aGF0
IGRvbid0IHNldCB0aGlzIG9wdGlvbi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95
IDxtYXhnQG1lbGxhbm94LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogSXNyYWVsIFJ1a3NoaW4gPGlz
cmFlbHJAbWVsbGFub3guY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1lL3RhcmdldC9hZG1p
bi1jbWQuYyB8IDggKysrKysrLS0KPj4gwqAgZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5owqDC
oMKgwqAgfCAxICsKPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNt
ZC5jIAo+PiBiL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMKPj4gaW5kZXggYzBhYTlj
My4uYmJiYjUwMiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQu
Ywo+PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jCj4+IEBAIC0zNjksOCAr
MzY5LDEyIEBAIHN0YXRpYyB2b2lkIG52bWV0X2V4ZWN1dGVfaWRlbnRpZnlfY3RybChzdHJ1Y3Qg
Cj4+IG52bWV0X3JlcSAqcmVxKQo+PiDCoMKgwqDCoMKgIC8qIHdlIHN1cHBvcnQgbXVsdGlwbGUg
cG9ydHMsIG11bHRpcGxlcyBob3N0cyBhbmQgQU5BOiAqLwo+PiDCoMKgwqDCoMKgIGlkLT5jbWlj
ID0gKDEgPDwgMCkgfCAoMSA8PCAxKSB8ICgxIDw8IDMpOwo+PiDCoCAtwqDCoMKgIC8qIG5vIGxp
bWl0IG9uIGRhdGEgdHJhbnNmZXIgc2l6ZXMgZm9yIG5vdyAqLwo+PiAtwqDCoMKgIGlkLT5tZHRz
ID0gMDsKPj4gK8KgwqDCoCAvKiBMaW1pdCBNRFRTIGFjY29yZGluZyB0byB0cmFuc3BvcnQgY2Fw
YWJpbGl0eSAqLwo+PiArwqDCoMKgIGlmIChjdHJsLT5vcHMtPnNldF9tZHRzKQo+PiArwqDCoMKg
wqDCoMKgwqAgaWQtPm1kdHMgPSBjdHJsLT5vcHMtPnNldF9tZHRzKGN0cmwpOwo+PiArwqDCoMKg
IGVsc2UKPj4gK8KgwqDCoMKgwqDCoMKgIGlkLT5tZHRzID0gMDsKPj4gKwo+PiDCoMKgwqDCoMKg
IGlkLT5jbnRsaWQgPSBjcHVfdG9fbGUxNihjdHJsLT5jbnRsaWQpOwo+PiDCoMKgwqDCoMKgIGlk
LT52ZXIgPSBjcHVfdG9fbGUzMihjdHJsLT5zdWJzeXMtPnZlcik7Cj4+IMKgIGRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LmggYi9kcml2ZXJzL252bWUvdGFyZ2V0L252bWV0
LmgKPj4gaW5kZXggNDJiYTJkZC4uMWFlNDFmZCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1l
L3RhcmdldC9udm1ldC5oCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaAo+PiBA
QCAtMjg5LDYgKzI4OSw3IEBAIHN0cnVjdCBudm1ldF9mYWJyaWNzX29wcyB7Cj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1ldF9wb3J0ICpwb3J0LCBjaGFyICp0cmFkZHIp
Owo+PiDCoMKgwqDCoMKgIHUxNiAoKmluc3RhbGxfcXVldWUpKHN0cnVjdCBudm1ldF9zcSAqbnZt
ZV9zcSk7Cj4+IMKgwqDCoMKgwqAgdm9pZCAoKmRpc2NvdmVyeV9jaGcpKHN0cnVjdCBudm1ldF9w
b3J0ICpwb3J0KTsKPj4gK8KgwqDCoCB1OCAoKnNldF9tZHRzKShzdHJ1Y3QgbnZtZXRfY3RybCAq
Y3RybCk7Cj4+IMKgIH07Cj4+IMKgIMKgICNkZWZpbmUgTlZNRVRfTUFYX0lOTElORV9CSU9WRUPC
oMKgwqAgOAo+Cj4gUGxlYXNlIGRvY3VtZW50IHRoZSBzZW1hbnRpY3Mgb2Ygc2V0X21kdHMuIElz
IGl0IGFzc3VtZWQgdG8gcmV0dXJuIGFuIAo+IE1EVFMgdmFsdWUgb3IgaXMgaXQgYXNzdW1lZCB0
byBtb2RpZnkgYW4gYXR0cmlidXRlIG9mICdjdHJsJz8gSW4gdGhlIAo+IGZvcm1lciBjYXNlLCBo
b3cgYWJvdXQgcmVuYW1pbmcgJ3NldF9tZHRzJyBpbnRvICdnZXRfbWR0cycgYW5kIAo+IGRlY2xh
cmluZyB0aGUgJ2N0cmwnIHBvaW50ZXIgY29uc3Q/IEhvdyBhYm91dCBkb2N1bWVudGluZyB0aGUg
bWVhbmluZyAKPiBvZiB0aGUgcmV0dXJuIHZhbHVlPwoKCmdldF9tZHRzIHNvdW5kcyBnb29kIHRv
IG1lLgoKSSdsbCBzZW5kIFYyIHRvbW9ycm93LgoKSG9wZWZ1bGx5IEtyaXNobmFtcmFqdSB3aWxs
IGNvbmZpcm0gdGhhdCB0aGlzIHNlcmllcyBmaXggaGlzIGlzc3VlLgoKCj4KPiBUaGFua3MsCj4K
PiBCYXJ0Lgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
