Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288B5C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 15:22:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CAB20820
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 15:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pGcARY2b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="F6hdhnBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CAB20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0QHo92FwcvAj1/WoU4xpNN7xB+aW2wdzuzVMog+M2UI=; b=pGcARY2bGdZgdxlUYJv0pN4It
	ZYIqhibj12H1x6TJu5rUaVdX9dCRQsSyxViOj89LHYU4bhDLhDhwNOmSDc6Uvw4gCUFyOMqM6vsBO
	skRTeBmSvbGzGw6OewGfGNRQWyNqr4GoFXbS9Y/w1pnPcyokBMuymBObZtMx0NRNJpN+nc1RknQ/v
	8tS4LtWgemf+aD5LuYTI3x7v+uYZFTNaYxK9RqvvdYitpBbfRLhXXC0jh/l0KyTT1yk6EoeXhXPvk
	KZ8UoieVembLF6gW5pN2U1KeHqCZiC2a8EV4pM74Zuy5VSIL0g8DyQfNkgk74EgC5u5pLF6UVhWAe
	ryqoYN+mA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5tag-0004Nm-F2; Thu, 05 Sep 2019 15:22:30 +0000
Received: from mail-eopbgr150058.outbound.protection.outlook.com
 ([40.107.15.58] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5tad-0004Mz-JY
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 15:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR9GHvjrAk9V9fFQESd+nDWBt5whXOJBT9TglxVcBeCdEHs+OzlwYwLmGu2YwyKtz9RhTCnbW+C+7ULhLjEdDT+9GZE1Eb9mZsvAQjmpUz13hQtgyLDAsYiFC5MFxwh4VdUcgTI417UsWU3UapJwn37aANkRw8oOs/lzL3XCaqjeFyH4q3O2Ewifu8jVQDy9bBkX3beS1Zmzi4y11065OIZQuya2lDXuUSlBJjfQbHsMyC9B6K73nAJFf+aeyr+LYWSr43wxCZ+SstWPIIaWhonNmhbDSdEvXo6cavCIpvi46M7pwiy1wvstP/15JoMVJ3Q7uINj+0eX+b9ZPM1SFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmkETVxNWDDWox+zWg2hh1yzNqYgBXjqfI2AgAN3CPs=;
 b=nlLGSLrBtDlaH/5WPioThLCZF4QMCnooCeCSFhv2rter5q1+4Yr+KhlszCDPyZCgWKF8eWtZ1wV59fh8mTPCWKcTNyww3q2qGC7iAkCgb1irV6xK11wBZbi7QEXPMFA+G6l0YdHMLm/2on5Zzgm9+tffg5e9d4s47rnaVwfjUPS4gD1UnbT5lSXghADH5aqPozQ2/aMMCHmgglpMAahJSD5Ycy+UlNDEZ7QAySRpp/zpghdiA87IOBWLtAdqkzh2xGtBYHaL31QR57s0cQKR0ZHtnEWeDaqWkYC9GzqeREh4fzuU/otuoxiznkB20oKGN2XogTxN3dOgWG+EfWOZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=grimberg.me smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmkETVxNWDDWox+zWg2hh1yzNqYgBXjqfI2AgAN3CPs=;
 b=F6hdhnBVZLZEQApuHOc9/pcKLzsVz8uMSH70+WCJt80GONdG7Y0oKfcumzD28ONJLLsCoe126/i/5WubV269Kai2ZaH0MzOlNqMsvHGALY+9WFGL4dc8lPRPR4gPq9RA30U1bqS6Di4k75mdxXssOjGwGe1pKTA61nqFNMroZKE=
Received: from HE1PR05CA0177.eurprd05.prod.outlook.com (2603:10a6:3:f8::25) by
 AM6PR05MB5287.eurprd05.prod.outlook.com (2603:10a6:20b:3e::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Thu, 5 Sep 2019 15:22:22 +0000
Received: from DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by HE1PR05CA0177.outlook.office365.com
 (2603:10a6:3:f8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.14 via Frontend
 Transport; Thu, 5 Sep 2019 15:22:21 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT041.mail.protection.outlook.com (10.152.21.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Thu, 5 Sep 2019 15:22:21 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 5 Sep 2019 18:22:20
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 5 Sep 2019 18:22:20 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 5 Sep 2019 18:22:19
 +0300
Subject: Re: [PATCH] nvme: Remove double assignment of cq vector
To: Israel Rukshin <israelr@mellanox.com>, Keith Busch <kbusch@kernel.org>
References: <1567695048-5234-1-git-send-email-israelr@mellanox.com>
 <20190905145937.GB24939@localhost.localdomain>
 <4de909ca-b4f6-a842-5d3f-a738b5a01a1f@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <83809c5a-ca68-a11b-f606-6748c862f8ff@mellanox.com>
Date: Thu, 5 Sep 2019 18:22:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4de909ca-b4f6-a842-5d3f-a738b5a01a1f@mellanox.com>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(189003)(199004)(50466002)(36756003)(2906002)(4744005)(65956001)(65806001)(47776003)(356004)(5660300002)(70206006)(70586007)(31686004)(26005)(186003)(76176011)(16526019)(336012)(11346002)(446003)(8676002)(81156014)(81166006)(8936002)(305945005)(2486003)(6246003)(53546011)(23676004)(4326008)(7736002)(478600001)(14444005)(31696002)(126002)(476003)(2616005)(486006)(229853002)(316002)(106002)(58126008)(16576012)(86362001)(110136005)(54906003)(53936002)(2870700001)(3846002)(6116002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5287; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbc765e6-ee10-495d-fa6b-08d73214d8e5
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:AM6PR05MB5287; 
X-MS-TrafficTypeDiagnostic: AM6PR05MB5287:
X-Microsoft-Antispam-PRVS: <AM6PR05MB52870E4BD0423DD32AB9DC99B6BB0@AM6PR05MB5287.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wc94b0cFJ+U/cZXyFZmwwb5Vx0sAKSS2VXK5LpGrwd+zzoimAuKzNubqMdC98fKeB/IlVy/+MNEv7bUGS8hRZjHg/tav3Eg7fep9fPQ9eMws5Vp5oj1dx3RyiwFRITv8RwtH5VvaQBb7wz7+bBCMapu1edO4nrdJ4U9iIYX0RmW/JeILijbNkhF3j83x3DQhLZGLKIhasKTy1vzwkj43mALgAnkNA3jtxwWpQQ61s/wRjoEc+DJa9KllK0ltDPlU2oi+XYFID0oZCxe6zBdBbXkeoSTCogITWnQg4BtQcwNDH51Xjpe1TXk5ynSfpJipsmj1+dbZ7GAbwBmIjDKXof4lwaw5uyYbP5+klsycw+JDSmDnFAS1GqZTOBcJBU/nJE32svFCOPprROTrRt/Nmkyv57x/LRcKRrqwa4wwiXg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 15:22:21.3147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc765e6-ee10-495d-fa6b-08d73214d8e5
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5287
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_082227_649212_3C945FDB 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Cc: Christoph Hellwig <hch@lst.de>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDkvNS8yMDE5IDY6MTAgUE0sIElzcmFlbCBSdWtzaGluIHdyb3RlOgo+IE9uIDkvNS8yMDE5
IDU6NTkgUE0sIEtlaXRoIEJ1c2NoIHdyb3RlOgo+PiBJdCdzIG5vdCByZWFsbHkgYSBkb3VibGUg
YXNzaWdubWVudC4gQW4gaW50ZXJydXB0IGRyaXZlbiBxdWV1ZSBtYXkgYmVjb21lCj4+IGEgcG9s
bGVkIHF1ZXVlIGFmdGVyIGEgcmVzZXQsIGluIHdoaWNoIGNhc2UgdGhpcyBhc3NpZ25tZW50IHNl
cnZlcyB0bwo+PiBjbGVhciBpdCdzIHByZXZpb3VzbHkgYXNzaWduZWQgdmVjdG9yLiBJdCBkb2Vz
bid0IGFjdHVhbGx5IGFwcGVhciB0bwo+PiBtYXR0ZXIgaWYgd2UndmUgY2xlYXJlZCBpdCBvciBu
b3Qgd2hlbiB0aGUgTlZNRVFfUE9MTEVEIGZsYWcgaXMgc2V0LAo+PiB0aG91Z2guCj4gU28gd2hh
dCBhYm91dCB0aGUgc2Vjb25kIGFzc2lnbm1lbnQgd2hlbiBwb2xsZWQgaXMgZmFsc2U/Cj4KPiAg
IMKgwqDCoMKgwqDCoMKgIG52bWVxLT5jcV92ZWN0b3IgPSB2ZWN0b3I7Cj4gICDCoMKgwqDCoMKg
wqDCoCBudm1lX2luaXRfcXVldWUobnZtZXEsIHFpZCk7Cj4KPiAgIMKgwqDCoMKgwqDCoMKgIGlm
ICghcG9sbGVkKSB7Cj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXEtPmNx
X3ZlY3RvciA9IHZlY3RvcjsgPDw8PDwKCmxldCdzIHJlbW92ZSB0aGUgc2Vjb25kIGFzc2lnbm1l
bnQuIFRoZSBmaXJzdCBvbmUgaXMgZ29vZCBlbm91Z2ggZm9yIApib3RoIElNTy4KCgo+ICAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlc3VsdCA9IHF1ZXVlX3JlcXVlc3RfaXJxKG52
bWVxKTsKPgo+Cj4gUmVnYXJkcywKPgo+IElzcmFlbAo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
