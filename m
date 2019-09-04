Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB97C3A5A7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 08:33:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF39020882
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 08:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oZrKoIwg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="GVSe+1Tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF39020882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U0BNiWGh2ZBYrIZHvFLdKH6vCNySoBEVI7t/Y1QbNKU=; b=oZrKoIwg4EaUGsUURUELdlHlO
	3Owz9YpmbHz4jFL7kOz5pRsDqyLb2GKA9KASuriw8Kg5XUhWX1uqFlT1oVVFjPIF2CCb1hoQrUEzV
	UrjsgCNhMcUrEIgRYd3kW1XdU2zy5eqM7IsErQyFbtaExS96n0pG44X0mDMlZBUh2TVVvALMaLCIF
	dnho6pvJ5xXEAnJmgwXPO63Wb/dKfHX9e5XSGoUle9ciVBMrC78Qp2fnpy5V5y/au0nyxx2JHzK+5
	2TXcvp7Qri+fYfbRtz+JWD4PUDsrz12BJysiuypRHD3vPS0pINp5WKt+UmE/1CyFLE+KmGbZm0UNH
	t33uSdpKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5Qis-0005zG-6e; Wed, 04 Sep 2019 08:33:02 +0000
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]
 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5Qin-0005tJ-RI
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 08:32:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l13c4By8K4kXyiDWMtcvhl6nmTBeirxzD8bW3MCPVDfWhgGtl3wGLYp2/X/FpiqLAxCbUkNkiZhwBe8oMNJdHMgL2y9A7OPPsqp6rN7SEUD/NYvZZN0WajBaCj59MMugp/6MooC6h+wCTJS9IlrHAdlk7LLgvL9EvPi5rO8yiP1MWHFN5c3tVwPvMzbXhNxiy6YYK5fZpz+vYvvCoP1blNElEo1GXdJl/i0ry+iPSgJh/zb4KdPozrsJwXQc1NSjzAyVtIKl4/e7G3GfDmOPgfj4W2OrgfKJJ8Qo2qVMuep7NmMXFRnyZrJFMMx0Pa1Rty9J6PDcgs+a7AE/e0EV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWxc9uFtqjRxJ8dfSACkllxnPOZIlUAKBGzU0q/QvhA=;
 b=UmLnNp54Rxstm6mkEGU0vYyV+0e6FObmZTi5deDwNwYdAjz+B+qhoXPcgip5Mq/nT6mOaMqbgik1KaaYxGNLjhZqjEIFsqqDE8+32IMJJ16iab6SRPD+qr8IIkHozkvRlUp0PVRyWtEatZP8fTqIL/FQWFCePGRaZB0IQoy+iGl9+RPUrNQEpx2ewE045OnTus0zywHueM63tR106N2Ift3JIIiUIL4UnvhY6MQxouULm6mIhm+VTh1l1TQ15ED8AcFC8KlNOI7vzLgkIldXsCWE0gqaDKLtjEHtvH5S5f8bFiCVd62iLGc+LtrDOAIekZXefM44AFmHXhuRriz7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=intel.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWxc9uFtqjRxJ8dfSACkllxnPOZIlUAKBGzU0q/QvhA=;
 b=GVSe+1TcvtmrNgjx/0RFyWc0vCI3V47+UK4lOYKJ4FTM7VdvOpR+WOmcpfIR1MgPWM2IBhokp209UQ4nKVYbPNHJ9rUQQT0ey8bnLvK0NMmPLA8uArmekn3smAinQVhoGDJ2moq3ZuHBbpcBjTJ6d1zLUkwc0Rg/2SKawROFClw=
Received: from HE1PR05CA0214.eurprd05.prod.outlook.com (2603:10a6:3:fa::14) by
 AM6PR05MB5379.eurprd05.prod.outlook.com (2603:10a6:20b:57::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 4 Sep 2019 08:32:53 +0000
Received: from DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by HE1PR05CA0214.outlook.office365.com
 (2603:10a6:3:fa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.13 via Frontend
 Transport; Wed, 4 Sep 2019 08:32:53 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT005.mail.protection.outlook.com (10.152.20.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Wed, 4 Sep 2019 08:32:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 4 Sep 2019 11:32:50
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 4 Sep 2019 11:32:50 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Sep 2019 11:32:04
 +0300
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
 <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
 <20190904054956.GA10553@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <fd70d115-bb29-a8a7-83ae-7e3dcaa1dc1c@mellanox.com>
Date: Wed, 4 Sep 2019 11:32:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904054956.GA10553@lst.de>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(199004)(189003)(26005)(2486003)(23676004)(76176011)(336012)(53546011)(2870700001)(107886003)(31686004)(36756003)(31696002)(5660300002)(7736002)(16526019)(478600001)(54906003)(70586007)(486006)(70206006)(476003)(106002)(126002)(50466002)(81166006)(81156014)(186003)(6246003)(316002)(2906002)(86362001)(16576012)(8676002)(14444005)(110136005)(2616005)(58126008)(4326008)(65806001)(65956001)(8936002)(47776003)(356004)(6116002)(305945005)(229853002)(53936002)(3846002)(11346002)(446003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB5379; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9045fd05-c460-4558-8326-08d731127a86
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:AM6PR05MB5379; 
X-MS-TrafficTypeDiagnostic: AM6PR05MB5379:
X-Microsoft-Antispam-PRVS: <AM6PR05MB5379498047C0781FB4482078B6B80@AM6PR05MB5379.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0150F3F97D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XI6BN/GFCXntrsot5CTElFJxPeRpVxAEcstP5Q6c8NCLKwugvHJB8vAqgAQIwuizmlnN6e7G8iFyLg6+nxQIrQMH2UWeVqhbZFzDqfHd1cvMitmJ3qo9tS+LqeqI5Eh5rUf90svFZIAxRFACI1fZH/PD9bcgwKW93Tuz8CZsLaAjQAxCIQ368bSret8ro2ijGRULQq+TSg2iKLScmwXaKyD0JHoctLR3gtzXnIlQo+zNah8+Jdh2pQl48zI1Ibrw4ydxxHRv9pk85z33mbwEcjtb129qvt7qZaibAxW0ocv7lhOZSidDD+Av0vzhvlTUzBWjr0orPSPwG1I4jOTsWhrmz5GYTBzbTuhnP+Ar27Jo8OlIax9JfxyJhQnOY438+dQkMi6jKDUVGJtrIvctBWtQDgoGcYUsUZlDc7BWikc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2019 08:32:52.8950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9045fd05-c460-4558-8326-08d731127a86
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5379
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_013258_374625_AB54D16E 
X-CRM114-Status: GOOD (  14.53  )
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
Cc: keith.busch@intel.com, Sagi Grimberg <sagi@grimberg.me>,
 martin.petersen@oracle.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 shlomin@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDkvNC8yMDE5IDg6NDkgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFR1ZSwg
U2VwIDAzLCAyMDE5IGF0IDAxOjIxOjU5UE0gLTA2MDAsIEplbnMgQXhib2Ugd3JvdGU6Cj4+IE9u
IDkvMy8xOSAxOjExIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4+ICsJaWYgKGJsa19pbnRl
Z3JpdHlfcnEocmVxKSAmJiByZXFfb3AocmVxKSA9PSBSRVFfT1BfUkVBRCAmJgo+Pj4+ICsJICAg
IGVycm9yID09IEJMS19TVFNfT0spCj4+Pj4gKwkJdDEwX3BpX2NvbXBsZXRlKHJlcSwKPj4+PiAr
CQkJCW5yX2J5dGVzIC8gcXVldWVfbG9naWNhbF9ibG9ja19zaXplKHJlcS0+cSkpOwo+Pj4+ICsK
Pj4+IGRpdiBpbiB0aGlzIHBhdGg/IGJldHRlciB0byB1c2UgID4+IGlsb2cyKGJsb2NrX3NpemUp
Lgo+Pj4KPj4+IEFsc28sIHdvdWxkIGJlIGJldHRlciB0byBoYXZlIGEgd3JhcHBlciBpbiBwbGFj
ZSBsaWtlOgo+Pj4KPj4+IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgc2hvcnQgYmxrX2ludGVncml0
eV9pbnRlcnZhbChzdHJ1Y3QgcmVxdWVzdCAqcnEpCj4+PiB7Cj4+PiAJcmV0dXJuIHF1ZXVlX2xv
Z2ljYWxfYmxvY2tfc2l6ZShycS0+cSk7Cj4+PiB9Cj4+IElmIGl0J3MgYSBob3QgcGF0aCB0aGlu
ZyB0aGF0IG1hdHRlcnMsIEknZCBzdHJvbmdseSBzdWdnZXN0IHRvIGFkZAo+PiBhIHF1ZXVlIGJs
b2NrIHNpemUgc2hpZnQgaW5zdGVhZC4KPiBNYWtlIHRoYXQgYSBwcm90ZWN0aW9uX2ludGVydmFs
X3NoaWZ0LCBwbGVhc2UuICBXaGlsZSB0aGF0IGN1cnJlbnRseQo+IGlzIHRoZSBzYW1lIGFzIHRo
ZSBsb2dpY2FsIGJsb2NrIHNpemUgdGhlIGNvbmNlcHRzIGFyZSBhIGxpdHRsZQo+IGRpZmZlcmVu
dCwgYW5kIHRoYXQgbWFrZXMgaXQgY2xlYXIuICBFeGNlcHQgZm9yIHRoYXQgdGhpcyBwYXRjaCBs
b29rcwo+IHZlcnkgbmljZSB0byBtZSwgaXQgaXMgZ3JlYXQgdG8gYXZvaWQgaGF2aW5nIGRyaXZl
cnMgdG8gZGVhbCB3aXRoIHRoZQo+IFBJIHJlbWFwcGluZy4KCkNocmlzdG9waCwKCkkgd2FzIHRo
aW5raW5nIGFib3V0IHRoZSBmb2xsb3dpbmcgYWRkaXRpb24gdG8gdGhlIGNvZGUgKGNvbWJpbmF0
aW9uIG9mIAphbGwgdGhlIHN1Z2dlc3Rpb25zKToKCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLWNv
cmUuYyBiL2Jsb2NrL2Jsay1jb3JlLmMKaW5kZXggNThlY2ZkMy4uY2VmNjA0YyAxMDA2NDQKLS0t
IGEvYmxvY2svYmxrLWNvcmUuYworKysgYi9ibG9jay9ibGstY29yZS5jCkBAIC0xNDA5LDcgKzE0
MDksNyBAQCBib29sIGJsa191cGRhdGVfcmVxdWVzdChzdHJ1Y3QgcmVxdWVzdCAqcmVxLCAKYmxr
X3N0YXR1c190IGVycm9yLAogwqDCoMKgwqDCoMKgwqAgaWYgKGJsa19pbnRlZ3JpdHlfcnEocmVx
KSAmJiByZXFfb3AocmVxKSA9PSBSRVFfT1BfUkVBRCAmJgogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlcnJvciA9PSBCTEtfU1RTX09LKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHQx
MF9waV9jb21wbGV0ZShyZXEsCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnJfYnl0ZXMgLyAKcXVldWVfbG9naWNhbF9ibG9ja19z
aXplKHJlcS0+cSkpOworwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG5yX2J5dGVzID4+IApxdWV1ZV9sb2dpY2FsX2Jsb2NrX3NoaWZ0
KHJlcS0+cSkpOwoKIMKgwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShlcnJvciAmJiAhYmxrX3Jx
X2lzX3Bhc3N0aHJvdWdoKHJlcSkgJiYKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIShyZXEtPnJxX2ZsYWdzICYgUlFGX1FVSUVUKSkpCmRpZmYgLS1naXQgYS9ibG9j
ay9ibGstc2V0dGluZ3MuYyBiL2Jsb2NrL2Jsay1zZXR0aW5ncy5jCmluZGV4IDJjMTgzMTIuLjgx
ODNmZmMgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay1zZXR0aW5ncy5jCisrKyBiL2Jsb2NrL2Jsay1z
ZXR0aW5ncy5jCkBAIC0zMzAsNiArMzMwLDcgQEAgdm9pZCBibGtfcXVldWVfbWF4X3NlZ21lbnRf
c2l6ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAKKnEsIHVuc2lnbmVkIGludCBtYXhfc2l6ZSkKIMKg
dm9pZCBibGtfcXVldWVfbG9naWNhbF9ibG9ja19zaXplKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpx
LCB1bnNpZ25lZCAKc2hvcnQgc2l6ZSkKIMKgewogwqDCoMKgwqDCoMKgwqAgcS0+bGltaXRzLmxv
Z2ljYWxfYmxvY2tfc2l6ZSA9IHNpemU7CivCoMKgwqDCoMKgwqAgcS0+bGltaXRzLmxvZ2ljYWxf
YmxvY2tfc2hpZnQgPSBpbG9nMihzaXplKTsKCiDCoMKgwqDCoMKgwqDCoCBpZiAocS0+bGltaXRz
LnBoeXNpY2FsX2Jsb2NrX3NpemUgPCBzaXplKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHEtPmxpbWl0cy5waHlzaWNhbF9ibG9ja19zaXplID0gc2l6ZTsKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvYmxrZGV2LmggYi9pbmNsdWRlL2xpbnV4L2Jsa2Rldi5oCmluZGV4IDFlZjM3
NWQuLjRhMDExNWUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvYmxrZGV2LmgKKysrIGIvaW5j
bHVkZS9saW51eC9ibGtkZXYuaApAQCAtMzMyLDYgKzMzMiw3IEBAIHN0cnVjdCBxdWV1ZV9saW1p
dHMgewogwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
aXNjYXJkX2FsaWdubWVudDsKCiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBzaG9ydMKgwqDCoMKg
wqDCoMKgwqDCoCBsb2dpY2FsX2Jsb2NrX3NpemU7CivCoMKgwqDCoMKgwqAgdW5zaWduZWQgc2hv
cnTCoMKgwqDCoMKgwqDCoMKgwqAgbG9naWNhbF9ibG9ja19zaGlmdDsKIMKgwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIHNob3J0wqDCoMKgwqDCoMKgwqDCoMKgIG1heF9zZWdtZW50czsKIMKgwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIHNob3J0wqDCoMKgwqDCoMKgwqDCoMKgIG1heF9pbnRlZ3JpdHlfc2Vn
bWVudHM7CiDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBzaG9ydMKgwqDCoMKgwqDCoMKgwqDCoCBt
YXhfZGlzY2FyZF9zZWdtZW50czsKQEAgLTEyNjcsNiArMTI2OCwxNiBAQCBzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGludCAKcXVldWVfbWF4X3NlZ21lbnRfc2l6ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1
ZSAqcSkKIMKgwqDCoMKgwqDCoMKgIHJldHVybiBxLT5saW1pdHMubWF4X3NlZ21lbnRfc2l6ZTsK
IMKgfQoKK3N0YXRpYyBpbmxpbmUgdW5zaWduZWQgc2hvcnQgcXVldWVfbG9naWNhbF9ibG9ja19z
aGlmdChzdHJ1Y3QgCnJlcXVlc3RfcXVldWUgKnEpCit7CivCoMKgwqDCoMKgwqAgdW5zaWduZWQg
c2hvcnQgcmV0dmFsID0gOTsKKworwqDCoMKgwqDCoMKgIGlmIChxICYmIHEtPmxpbWl0cy5sb2dp
Y2FsX2Jsb2NrX3NoaWZ0KQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR2YWwgPSBx
LT5saW1pdHMubG9naWNhbF9ibG9ja19zaGlmdDsKKworwqDCoMKgwqDCoMKgIHJldHVybiByZXR2
YWw7Cit9CisKIMKgc3RhdGljIGlubGluZSB1bnNpZ25lZCBzaG9ydCBxdWV1ZV9sb2dpY2FsX2Js
b2NrX3NpemUoc3RydWN0IApyZXF1ZXN0X3F1ZXVlICpxKQoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
