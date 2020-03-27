Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1723C43331
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 00:45:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1635206E6
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 00:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="up57kIsL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HER0HDWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1635206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZGHkJWcGCinmUj68WdqUgBfFaxsDwiZFwrKGb4TcVec=; b=up57kIsLoArm4++hU+I5cKgMP
	bMKHXVRBqjikBtjPIdEms2obdcIl5RUynvMMAH8UWKYqhAd9uu27ewB9rBnIKBdFJR0Ym4m3sRHK/
	vTkIUYa7ogYhGMPDIss61ZlBr/Q62+TD2lbghw16zEYaq6KWrw3aLRxbmEXx95J/9IxAC3QtcvxhH
	3hdRPB7WuE7KeRqTlcUqzmDWczpVP1BOyGXXsaUkiZeGx8Go5XxIrbZ7MQwG05H3fiKDUL1/u4Izk
	mGieOnu1/rQZdTqaIgk0z/hNIu6giqrWq68a1Jy/KBdzEY7Qc5zeGNBl8WXkDLPSOLxDng+GZpOq+
	NyYuwpxSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHd7J-0004WF-RY; Fri, 27 Mar 2020 00:44:57 +0000
Received: from mail-am6eur05on2057.outbound.protection.outlook.com
 ([40.107.22.57] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHd7F-0004Vn-JZ
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 00:44:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5VQtWSRQkO/vz1LqdY9+mXlQwrUySLQHVsqVxqYlZNAWsmeS0Q4lEgjrlnZe/9ZW8BSotuJtkLGEDsckeAF7pWg1HZEL3QIG9WcmGBmrqPmQt1+3cboOYeYG7rYZrpq+pIg6uXz+64Sn6cIA/CQbEPlb48Z+Wjl+gaR0c0KZrfpfxH5kLOLCqdpgZ7WzX+K8UC80/FzVnqSk2Hcw5Ul9yDzJF0HkDecccJ+WxaIYQgz3OFxLHuVv4Ztj/AaEUFQWBSQg7xREWORxWmLWtmGTPwOqUIDyqdfIhr64NdEsOeicmwxdtnpmJKLWEA3j9+pUp+5RxzxXJr1dxQpaWOY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofN7co9J9SbxCD2kZHMZKgJYqJaIi+U16b3/G9Yih/4=;
 b=SS8MiMO8mVFQBwRWzF90hMR/epIITq3tpBB0VohrSg4k5vbCVKKdJsJy3aIMxzr0tmad0t4gO70AauA/zllkc2OJjIKu/cE/NkMiciaTV8GFY1qOsL/3WFc6jY+zRqmSrCB3Pe0bwMYcValMccHNvqstCqdwuOTWLBrTwCsN+Ad4GReFU7hi+8la8z7mC3qDAgBiOCelyhb2qfjN2xgKmozYQZvwbdnH4bArLHZ1upNO2eGs7rnPWd1RMe5n/CoevNUkRDhf3XGEqjghiYApmMgpAvHpgprqPdvEdGruDk/wRJb3tvOzAXvGlOUioh0TK8VRyH3VzqkSHFYqssIpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=acm.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofN7co9J9SbxCD2kZHMZKgJYqJaIi+U16b3/G9Yih/4=;
 b=HER0HDWeyZW8TOQvJ2ZCM3jtmbqZzeZsjSZq472Vv4RGPvXgCxVAJVt6leaYySYY4e6GYaf3kszNjuKp8edzwJm5T/GSVeDe2lUBPAoc92RjeDoIPQ6IlLSEsrrACv968QV3K/pRGkg0vt7exaig5hf1Vj8oZLiHlX46iuEyk9c=
Received: from DB8P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::20)
 by AM0PR05MB5681.eurprd05.prod.outlook.com (2603:10a6:208:112::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 27 Mar
 2020 00:44:50 +0000
Received: from DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::93) by DB8P191CA0010.outlook.office365.com
 (2603:10a6:10:130::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend
 Transport; Fri, 27 Mar 2020 00:44:50 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT006.mail.protection.outlook.com (10.152.20.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2856.17 via Frontend Transport; Fri, 27 Mar 2020 00:44:50 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 27 Mar 2020 03:44:49
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 27 Mar 2020 03:44:49 +0300
Received: from [172.27.0.77] (172.27.0.77) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Fri, 27 Mar 2020 03:44:47
 +0300
Subject: Re: [PATCH v4 1/1] nvmet-rdma: use SRQ per completion vector
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <kbusch@kernel.org>, <hch@lst.de>
References: <20200326181512.58053-1-maxg@mellanox.com>
 <80ff5951-caad-1130-43d4-6239b9f6a143@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <6149129e-eacb-7b16-0540-13166dc10e8e@mellanox.com>
Date: Fri, 27 Mar 2020 03:44:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <80ff5951-caad-1130-43d4-6239b9f6a143@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.27.0.77]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; CTRY:IL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mtlcas13.mtl.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966005)(4326008)(31686004)(107886003)(16526019)(82740400003)(47076004)(186003)(2616005)(336012)(2906002)(86362001)(26005)(53546011)(316002)(356004)(478600001)(31696002)(70206006)(36756003)(8936002)(16576012)(966005)(110136005)(5660300002)(70586007)(81166006)(81156014)(8676002)(54906003)(3940600001);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97b84e79-998e-451c-1407-08d7d1e80e85
X-MS-TrafficTypeDiagnostic: AM0PR05MB5681:
X-Microsoft-Antispam-PRVS: <AM0PR05MB568139C3BD6372C555B5C8D9B6CC0@AM0PR05MB5681.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0355F3A3AE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wm/tuzK0HUp5WJwbwcACDAJT5dp679X+GcqgwEvF+QvQLoyVTARBP/pqku4ycDfmLuvAvkB7SRramCQ6RC1cASL5A374u7fVTFXE9Qp+iI3q+f6RUGtNrhtrHTLdUiVF7HpvkzfpOs63Xe5L75PfbUON9WkFi81S9FB/U1SHZZrLOa3rdjzWt+1nmcGqEGsirBPZ1fcLG1vIz75hkBQKqZhl/D5DgiP+qygw4ScK0fjXVe/bY3v6HabNd3+PJNM3fmpXH0ETChXeSbhKPwfMJe2LeCeQNjLU+1XMwuQzkrm8Zj0LxEFNFY/Vlev0hqTXw7cA4dcpE3q96u3SHPHf9J7EO7JMakIqDpDbrYorA2mXUDE2AISisvUakkfOZyu/m6T6kNz6nOFOcu0jX17T9XNz3bYom7JeHEKWKmTO1N0xsNjEPMO/eU0THqd9rtcP2f3pR5VDYO8CCqj8JvtB3S591Z1Yal3jjXXnP52vTra6Bch5ENplAVcjfVTvcV0p3TlkWpfcZ8nWryK9Puma/UqY9trRMzDpd1ObULNvpNQQIIeVcU2HS8W3qNa7SEE2XSSaJtgEHbUzNPLrIKgKdgc1AKD4mDOzbYa180NEHY4ncjty29BFLB9SJf2emOm8
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 00:44:50.0553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b84e79-998e-451c-1407-08d7d1e80e85
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5681
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_174453_647975_BD226A53 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: shlomin@mellanox.com, jgg@mellanox.com, bvanassche@acm.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDMvMjcvMjAyMCAxOjIwIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+IEBAIC05NTQs
NyArMTAzOSw3IEBAIHN0YXRpYyB2b2lkIG52bWV0X3JkbWFfZnJlZV9kZXYoc3RydWN0IGtyZWYg
KnJlZikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWVfZGV2Owo+PiDCoCDCoMKg
wqDCoMKgIGlmIChudm1ldF9yZG1hX3VzZV9zcnEpIHsKPj4gLcKgwqDCoMKgwqDCoMKgIHJldCA9
IG52bWV0X3JkbWFfaW5pdF9zcnEobmRldik7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSBudm1l
dF9yZG1hX2luaXRfc3JxcyhuZGV2KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWVfcGQ7Cj4+IMKgwqDCoMKg
wqAgfQo+Cj4gSSdtIHdhbmRlcmluZyBpZiB3ZSBzaG91bGQgZmFsbGJhY2sgdG8gbm9ybWFsIHJx
cywgcHJvYmFibHkgbm90IGEKPiBnb29kIGlkZWEuLi4KPgpZdXAsIHByb2JhYmx5IHdvbid0IGhl
bHAgc2luY2UgdGhlIHBvc3NpYmxlIGVycm9ycyBhcmUgbGFjayBvZiBtZW1vcnkgCmFuZCBtYWxm
dW5jdGlvbmluZyBkZXZpY2UuCgo+Cj4+IEBAIC0xMjM4LDYgKzEzMjYsMTAgQEAgc3RhdGljIHZv
aWQgbnZtZXRfcmRtYV9xcF9ldmVudChzdHJ1Y3QgCj4+IGliX2V2ZW50ICpldmVudCwgdm9pZCAq
cHJpdikKPj4gwqDCoMKgwqDCoCBjYXNlIElCX0VWRU5UX0NPTU1fRVNUOgo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmRtYV9ub3RpZnkocXVldWUtPmNtX2lkLCBldmVudC0+ZXZlbnQpOwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqAgY2FzZSBJQl9FVkVOVF9RUF9MQVNUX1dR
RV9SRUFDSEVEOgo+PiArwqDCoMKgwqDCoMKgwqAgcHJfZGVidWcoInJlY2VpdmVkIGxhc3QgV1FF
IHJlYWNoZWQgZXZlbnQgZm9yIHF1ZXVlPTB4JXBcbiIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcXVldWUpOwo+PiArwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4KPiBDYW4geW91IHJlbWlu
ZCBtZSB3aGVuIGRvZXMgdGhpcyBldmVudCBjb21lIHVwPyBXaHkgZG9uJ3Qgd2Ugc2VlIGl0IAo+
IHdpdGggbm9ybWFsIHF1ZXVlcz8KCk1heWJlIHRoaXMgY2FuIGhlbHA6CgpodHRwczovL3NwaW5p
Y3MubmV0L2xpc3RzL2xpbnV4LXJkbWEvbXNnNTk2MzMuaHRtbAoKCj4KPiBPdGhlciB0aGFuIHRo
YXQsIGxvb2tzIGdvb2QgTWF4LAo+Cj4gUmV2aWV3ZWQtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lA
Z3JpbWJlcmcubWU+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
