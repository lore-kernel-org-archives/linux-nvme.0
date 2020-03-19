Return-Path: <SRS0=OxAA=5E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03554C4332D
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 16:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55192072C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2020 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tTHAcwQZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hiCm7irL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55192072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JKCgZ/Jc7oNZBEWsdmy+7l6JbVhjxB6mV/iBNAai1tM=; b=tTHAcwQZN5TVgUZqb5w2Sy2bl
	bQjr60UmlVs79L5mqyyO/LbSBP5ecyoRHbogvD5o+n5YFNhdlU2pO57VJqtee4d6Q56N0tQ8O4hEc
	cRjELGSuCSAMrP3uk3vl+qqwgxT5qM5eC4q8IdGHYTHa7mn6/M9nx27Qt9yHeQzrbo050tyQygdAL
	7sEvbAkn67rGONR8992Fq4kKBZ/sHcQMTJ76RkDniBlc7HXhANoPyVWgNUeoFTp9xNXDLaeoPi4vI
	MI73aAeddilIC7kKJx18dT6XUS1tktBZ1KTBSb2eL6mlSBAuGp5oxnOn58Y/XUQ7xRG8RTdCwRIxm
	qkTvF9yLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEy1a-0006Nd-74; Thu, 19 Mar 2020 16:28:02 +0000
Received: from mail-eopbgr150083.outbound.protection.outlook.com
 ([40.107.15.83] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEy1X-0006Mk-L8
 for linux-nvme@lists.infradead.org; Thu, 19 Mar 2020 16:28:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMwNMlXDwTNYzbzcd6cHx6hDHCQhgunOHbSbBp35GUm0mnTf+eLm5ye5TrWbOHQI414BvaKiXijjDY+23ZWa9V86H1mOSxlyOVdpzaVl9EW9QZ+GO/tqx1dLmQZGOlRCfx9oYYjKmWvhkAhQYXbnKcLXggCsBGq7bWHyoDw4j/1AEGvjN1g5jAv/X4oHaq5BfGfr8NedHPU0EBmxjn3J/n/j0xaTPJ9vNBdepai+JvvpZjCXoqov94HLFNFC5QuZftXcElZuGnhfuApIsKHGOhsmnKFmZcnLu+mSXwzvyUsktVp0jvvfEl9Y7uGwviZ37hajHeYJnVktAyumbqRMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWY8XHWlBfImIxF2am7pmFR9Boi8r2+XIHndw+cCaGs=;
 b=XyWBIJWRzMBKzWmh3AslgSpTeHKuIQmAgJmq5J1R3okvCI8KBCutPSz3qqnSmKba6IaRm+hB2XezVGWFTSENcF8fxEvyRPXRD9Lmw5kuXQIEP8Kf7/0MzlZIvzJz4K525EXhOkfwNiEUr+HP5caRsRNe6xtDegBSjKNqNXdzpvLAzlqF1J+NNoV0hbnUlSFEjS49T/lyF6TC5g1u1vyESxnwZIhNzEkOk8fYJhWPdVyL6TbAg/zD3X3n4NYBYzlfW0SfzjUO0RZjnd0Fq5cpS5fakUNQ6xSsV/5qnJ+mqibxkdoy5umJ3gUOwFgOZogm4IP1BylQeY2v3UdbF+IBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWY8XHWlBfImIxF2am7pmFR9Boi8r2+XIHndw+cCaGs=;
 b=hiCm7irLFYxnfDvwWg1je1T5Qq2eysfeB8BLk9MpEc6L1GHCGHTCmgvbiYgfGS4oimx/IirWfQLg90Vz8S+1Sb/ycjMO4KaVvcoz4XVF5gSxx3DA6YJ6zXfhtUj74NPqli6OQSA7vfN2EMIoUJGZ7UOPlyj+Y0CiqXt2FZ9C+Jo=
Received: from AM6P191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::24)
 by DB7PR05MB5657.eurprd05.prod.outlook.com (2603:10a6:10:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Thu, 19 Mar
 2020 16:27:55 +0000
Received: from VE1EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::fa) by AM6P191CA0047.outlook.office365.com
 (2603:10a6:209:7f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend
 Transport; Thu, 19 Mar 2020 16:27:55 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT064.mail.protection.outlook.com (10.152.19.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Thu, 19 Mar 2020 16:27:54 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 19 Mar 2020 18:32:04
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 19 Mar 2020 18:32:04 +0200
Received: from [172.27.15.129] (172.27.15.129) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Thu, 19 Mar 2020 18:27:39 +0200
Subject: Re: [PATCH v2 3/5] nvmet-rdma: use SRQ per completion vector
From: Max Gurtovoy <maxg@mellanox.com>
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@mellanox.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-4-maxg@mellanox.com>
 <d72e0312-1dfd-460e-bc83-49699d86dd64@acm.org>
 <5623419a-39e6-6090-4ae2-d4725a8b9740@mellanox.com>
 <20200319115654.GV13183@mellanox.com>
 <0b11c26f-d3de-faf5-5609-c290ea46ed9c@mellanox.com>
 <20200319135356.GZ13183@mellanox.com>
 <6dcf300c-d010-829b-b996-285ad16786d5@acm.org>
 <50dd8f5d-d092-54bc-236d-1e702fb95240@mellanox.com>
 <6e3cc1c4-b24e-f607-42b3-5b83dd8c312c@mellanox.com>
Message-ID: <d5afe0a5-5fab-203e-a3fc-bba9db86ff05@mellanox.com>
Date: Thu, 19 Mar 2020 18:27:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6e3cc1c4-b24e-f607-42b3-5b83dd8c312c@mellanox.com>
Content-Language: en-US
X-Originating-IP: [172.27.15.129]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(199004)(46966005)(316002)(54906003)(31696002)(16576012)(53546011)(6636002)(47076004)(36906005)(86362001)(110136005)(31686004)(36756003)(8936002)(81166006)(81156014)(8676002)(2906002)(5660300002)(478600001)(70206006)(70586007)(4326008)(186003)(356004)(2616005)(26005)(16526019)(336012)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR05MB5657; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0624cb03-0768-4e21-93e1-08d7cc227a3f
X-MS-TrafficTypeDiagnostic: DB7PR05MB5657:
X-Microsoft-Antispam-PRVS: <DB7PR05MB56577807643CE0E2E0BFE352B6F40@DB7PR05MB5657.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0347410860
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sg5w7yxpHJjh1Z6R3L9sV4RavtMBRsZhHpUkchSEOCC01ZLYhxVXeeqoooIcZi7Sc9Pyzxfw2HYTm1eIntF6AdwfOyIs5SUn/KMFk56dvGkt2X26BFNxYgvJOPKkpNM7mnwu50YrcQ+wbVNziF7WGCTUqSqP2XICBdzGsNm06Zs/fO5uuhAEeIltHQv9Fy+Cxs4wdCIZmIhGxRD/iVKPv8u33J9mr4NT0K8q+k/r51E976olHO/XM0sXhCfV51jvfIH1d7huVmdyXOTt1OfcGgCliHAiV/uQitwoFBc0euZzUJCjr+j3Z9KuqbNVxmNyguGAVmwSMbzlAIQ2Lk98O+w3j6PoP/Zh0ZsjVyjitJaOLLcu3ZJcXKNc4w6EcHrhwUpM79MnL6WFzbqao3ReU/mPyGNxXdCUb9qommdWD6GQ7E8OmYvynTF88qpBiFmD4UTwY7EINd3rf7Jwt8ayQmtjinNGjvYubVY5je83+alW9MpeEyPnbtedXK4u+Yzut+wp6O3LQW73bIDcXJth08qtOObPC8CGM+D3zGW7P4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 16:27:54.6204 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0624cb03-0768-4e21-93e1-08d7cc227a3f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5657
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200319_092759_717096_565B80ED 
X-CRM114-Status: GOOD (  14.52  )
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
Cc: loberman@redhat.com, sagi@grimberg.me, vladimirk@mellanox.com,
 idanb@mellanox.com, linux-rdma@vger.kernel.org, shlomin@mellanox.com,
 linux-nvme@lists.infradead.org, leonro@mellanox.com, dledford@redhat.com,
 oren@mellanox.com, kbusch@kernel.org, rgirase@redhat.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

YW5kIGFnYWluIC0gaG9wZWZ1bGx5IGxhc3QgdGltZSBJJ20gYmxvY2tlZC4uLgoKT24gMy8xOS8y
MDIwIDU6NDQgUE0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPgo+IHNlbmRpbmcgYWdhaW4gLSBJIHRo
aW5rIHRoZSBwcmV2aW91cyBtYWlsIHdhcyBibG9ja2VkLgo+Cj4gT24gMy8xOS8yMDIwIDU6MTAg
UE0sIE1heCBHdXJ0b3ZveSB3cm90ZToKPj4KPj4KPj4gT24gMy8xOS8yMDIwIDQ6NDkgUE0sIEJh
cnQgVmFuIEFzc2NoZSB3cm90ZToKPj4+IE9uIDMvMTkvMjAgNjo1MyBBTSwgSmFzb24gR3VudGhv
cnBlIHdyb3RlOgo+Pj4+IE9uIFRodSwgTWFyIDE5LCAyMDIwIGF0IDAyOjQ4OjIwUE0gKzAyMDAs
IE1heCBHdXJ0b3ZveSB3cm90ZToKPj4+Pgo+Pj4+PiBOZXZlcnRoZWxlc3MsIHRoaXMgc2l0dWF0
aW9uIGlzIGJldHRlciBmcm9tIHRoZSBjdXJyZW50IFNSUSBwZXIgSENBCj4+Pj4+IGltcGxlbWVu
dGF0aW9uLgo+Pj4+Cj4+Pj4gbnZtZS9zcnAvZXRjIGFscmVhZHkgdXNlIHNycT8gSSBzZWUgaXQg
aW4gdGhlIHRhcmdldCBidXQgbm90IAo+Pj4+IGluaXRpYXRvcj8KPj4+Pgo+Pj4+IEp1c3Qgd29y
cmllZCBhYm91dCBicmVha2luZyBzb21lIHdlaXJkIHRhcmdldCBzb21ld2hlcmUKPj4KPj4gSmFz
b24sCj4+Cj4+IFRoZSBmZWF0dXJlIGlzIG9ubHkgZm9yIHRhcmdldCBzaWRlIGFuZCBoYXMgbm8g
aW5mbHVlbmNlIG9uIGluaXRpYXRvciAKPj4gYW4gdGhlIFVMUCBsZXZlbC4KPj4KPj4gVGhlIG9u
bHkgdGhpbmcgdGhhdCBJIGRpZCBpcyBmaXhlZCB0aGUgU1JRIGltcGxlbWVudGF0aW9uIGZvciAK
Pj4gbnZtZS9yZG1hIGFuZCBzcnB0IHRoYXQgYWxsb2NhdGUgMSBTUlEgcGVyIGRldmljZS4KPj4K
Pj4gTm93IHRoZXJlIGFyZSBOIFNSUXMgcGVyIGRldmljZSB0aGF0IHRyeSB0byBhY3QgYXMgcHVy
ZSBNUSAKPj4gaW1wbGVtZW50YXRpb24gKHdpdGhvdXQgU1JRKS4KPj4KPj4+Cj4+PiBGcm9tIHRo
ZSB1cHN0cmVhbSBTUlAgdGFyZ2V0IGRyaXZlcjoKPj4+Cj4+PiBzdGF0aWMgdm9pZCBzcnB0X2dl
dF9pb2Moc3RydWN0IHNycHRfcG9ydCAqc3BvcnQsIHUzMiBzbG90LAo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBpYl9kbV9tYWQgKm1hZCkKPj4+IHsKPj4+IMKgwqDCoMKgWyAu
Li4gXQo+Pj4gwqDCoMKgwqBpZiAoc2Rldi0+dXNlX3NycSkKPj4+IMKgwqDCoMKgwqDCoMKgIHNl
bmRfcXVldWVfZGVwdGggPSBzZGV2LT5zcnFfc2l6ZTsKPj4+IMKgwqDCoMKgZWxzZQo+Pj4gwqDC
oMKgwqDCoMKgwqAgc2VuZF9xdWV1ZV9kZXB0aCA9IG1pbihNQVhfU1JQVF9SUV9TSVpFLAo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2Rldi0+ZGV2aWNl
LT5hdHRycy5tYXhfcXBfd3IpOwo+Pj4gwqDCoMKgwqBbIC4uLiBdCj4+PiDCoMKgwqDCoGlvY3At
PnNlbmRfcXVldWVfZGVwdGggPSBjcHVfdG9fYmUxNihzZW5kX3F1ZXVlX2RlcHRoKTsKPj4+IMKg
wqDCoMKgWyAuLi4gXQo+Pj4gfQo+Pj4KPj4+IEknbSBub3Qgc3VyZSB0aGUgU1JQIGluaXRpYXRv
ciB1c2VzIHRoYXQgZGF0YSBmcm9tIHRoZSBkZXZpY2UgCj4+PiBtYW5hZ2VtZW50Cj4+PiBJL08g
Y29udHJvbGxlciBwcm9maWxlLgo+Pj4KPj4+IEFueXdheSwgd2l0aCBvbmUgU1JRIHBlciBpbml0
aWF0b3IgaXQgaXMgcG9zc2libGUgZm9yIHRoZSBpbml0aWF0b3IgdG8KPj4+IHByZXZlbnQgU1JR
IG92ZXJmbG93cy4gSSBkb24ndCB0aGluayB0aGF0IGl0IGlzIHBvc3NpYmxlIGZvciBhbiAKPj4+
IGluaXRpYXRvcgo+Pj4gdG8gcHJldmVudCB0YXJnZXQgc2lkZSBTUlEgb3ZlcmZsb3dzIGlmIHNo
YXJlZCByZWNlaXZlIHF1ZXVlcyBhcmUgCj4+PiBzaGFyZWQKPj4+IGFjcm9zcyBtdWx0aXBsZSBp
bml0aWF0b3JzLgo+Pgo+PiBJIGRvbid0IHRvIGNoYW5nZSBpbml0aWF0b3IgY29kZSBhbmQgcHJl
dmVudCBvdmVyZmxvdy4KPj4KPj4gQXMgSSBleHBsYWluZWQgZWFybGllciwgdGhlIFNSUXMgaW4g
dGhlIHRhcmdldCBzaWRlIHdpbGwgYmUgYXNzaWduZWQgCj4+IGZvciBhbGwgY29udHJvbGxlcnMg
Zm9yIHNwZWNpZmljIGRldmljZSAoaW5zdGVhZCBvZiBnbG9iYWwgMSBwZXIgCj4+IGRldmljZSkg
YW5kIHNoYXJlIHRoZSByZWNlaXZlIGJ1ZmZlcnMuCj4+Cj4+IE5vdCBwZXIgaW5pdGlhdG9yLiBU
aGlzIHdpbGwgY2F1c2UgbG9jayBjb250ZW50aW9uLgo+Pgo+PiBJbiBjYXNlIHRoZSB0YXJnZXQg
U1JRIGhhcyBubyByZXNvdXJjZXMgaW4gdGhlIHNwZWNpZmljIHRpbWUsIHRoZSBsb3cgCj4+IGxl
dmVsIChSQyBxcCkgaXMgcmVzcG9uc2libGUgdG8gc2VuZCBybnIgdG8gdGhlIGluaXRpYXRvciBh
bmQgdGhlIAo+PiBpbml0aWF0b3IgKFJDIHFwKSB3aWxsIHJldHJ5IGluIHRoZSB0cmFuc3BvcnQg
bGF5ZXIgYW5kIG5vdCBpbiB0aGUgVUxQLgo+Pgo+PiBUaGlzIGlzIHNldCBieSBtaW5fcm5yX3Rp
bWVyIHZhbHVlIHRoYXQgYnkgZGVmYXVsdCBzZXQgdG8gMCAobWF4IAo+PiB2YWx1ZSkuRm9yIFNS
USBjYXNlIGluIGdlbmVyYWwsIElNTyBiZXR0ZXIgdG8gc2V0IGl0IHRvIDEgKG1pbmltYWwgCj4+
IHZhbHVlKSB0byBhdm9pZCBsb25nZXIgbGF0ZW5jeSBzaW5jZSB0aGVyZSBpcyBhIGNoYW5jZSB0
aGF0IFNSUSBpcyBmdWxsLgo+Pgo+PiBJbiBteSB0ZXN0aW5nIEkgZGlkbid0IHNlZSBhIHJlYWwg
bmVlZCB0byBzZXQgdGhlIG1pbl9ybnJfdGltZXIgYnV0IEkgCj4+IGhhdmUgcGF0Y2hlcyBmb3Ig
dGhhdCBpbiBjYXNlIEphc29uIHRoaW5rcyB0aGF0IHRoaXMgc2hvdWxkIGJlIHBhcnQgCj4+IG9m
IHRoaXMgc2VyaWVzIHRoYXQgaXMgbm90IHNvIHNtYWxsIHdpdGhvdXQgaXQuCj4+Cj4+Cj4+Pgo+
Pj4gVGhhbmtzLAo+Pj4KPj4+IEJhcnQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
