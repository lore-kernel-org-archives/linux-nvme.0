Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC9C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 15:10:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D242070C
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 15:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nlCB1TDr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DUXTxI98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D242070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LbrAYJ+gG03YcecN4GwXqWxYDDg/Hz/9C6E4WsqU4xE=; b=nlCB1TDrglqaMz
	jVG+uSYNSOBIBDo2KLNRMjGOvQMjFnMjWtA/FpCkQJgf0eov6CNXdZgcpHHw/3zyky/KQFZZNeoJe
	CIrYeskrHuBm3aigT+9fmLY7j+i+evwtrZVJI/h8gknF4vaU4cxumohkncHd5yGwqOqRLl3/pOiTU
	ogo7V1KjuK3C7M8hmce9DTUN6tjcdth01pMOKV0Almv0ENk6+2uxQOqyCTRvjH6p1lyBXTLKX1s5i
	CtdnVefYW2oR8pV1TMgW8GRmrUUiJ3eU1/pDVkr3GwO6C6UxkJnomMYtfG675Va2PZbWNBRe7JCyk
	AfNaBz8ASFEM2T3lYY8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5tPG-0000z1-Uj; Thu, 05 Sep 2019 15:10:42 +0000
Received: from mail-eopbgr150080.outbound.protection.outlook.com
 ([40.107.15.80] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5tPD-0000yc-Bo
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 15:10:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alPnTMT3DoaI/zjVMlH3ElSzcz/CDyfne3IZ0FVa55CiuvPL7pBzCO1KwR3BzpZcf4uJJj9r/q1nfm2J64ODX+h8E2TW8MNGrMCmDTXIDxkM2XmoCiP0Duo4fhQH+OvIQkyqj6EHYctISJO5GPa4QPP4MjRPgfCbJQPsIKAH6oeBEvKxbxzvPNqlylG3XxYLHPQGU0gKFNXZlgcTeFUII28i5W7USAnpCkwj12ZFPr+14r14UfE00PESYux5VWPW3SEW5ztFIAe0Zw/tqBpYkEIXW6Rdi1UH9GRd2VZXQkkcnGgybKmSxX2T74DCDT6ispeAyuSDFGly+Zvmdu/WeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs0fgRIx86VxBJWa4AQzf9JLZ8tgCSIecCkLhciuGco=;
 b=dqHJtQAcwoBjQ77GkQu6YeomFxKN69aAD9T2lUFEOMRz5XilezScXP7EkeFdKQ5m5WMgENMx1/KKGJM1T50HrLa2PkFX7OPbBT/Vcj8/OPCo5ICrGUTnb0qYiAZNQJzg1dIOXM4U6e/Fr/7MZrZQUufyN5yD5bSbCeHSS51gyPFQXTZ5ZUpid5itGJVg3wPscUZHItEgG96fGIPAeMrz8/48Vuj4QK0doHzFa2mkM5TBiKkg8MplvbOD3rWknQCWc1KWCpiJ9GOmWeZ+hZIwmq3whAFJ4OwXkg1b5XXWPMFGWB3qUt3JemirupqfLt4WNCz1KCW3a0+noOoZDbINWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fs0fgRIx86VxBJWa4AQzf9JLZ8tgCSIecCkLhciuGco=;
 b=DUXTxI98t8HUCefgfGVCagEK3Yj0lV8sA9iVtdx4jDrhlMWLlHuHsnuguqYimagDPWlhMDVwapSfy0BMHXjr8FPChvUQx+0tcGZBeOFFiRnEplx1Dq/b32weFJru3hbv7e9AGANFuhVvlAFsy32W20pXjLBS96Dqiy6AHGH767s=
Received: from AM6PR0502MB4070.eurprd05.prod.outlook.com (52.133.28.22) by
 AM6PR0502MB3799.eurprd05.prod.outlook.com (52.133.18.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Thu, 5 Sep 2019 15:10:36 +0000
Received: from AM6PR0502MB4070.eurprd05.prod.outlook.com
 ([fe80::adb0:f6d:2124:55a8]) by AM6PR0502MB4070.eurprd05.prod.outlook.com
 ([fe80::adb0:f6d:2124:55a8%7]) with mapi id 15.20.2241.014; Thu, 5 Sep 2019
 15:10:35 +0000
From: Israel Rukshin <israelr@mellanox.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Remove double assignment of cq vector
Thread-Topic: [PATCH] nvme: Remove double assignment of cq vector
Thread-Index: AQHVY/kVVLzcdF6q3UKYStqU0WCTUacdLSEAgAADCwA=
Date: Thu, 5 Sep 2019 15:10:35 +0000
Message-ID: <4de909ca-b4f6-a842-5d3f-a738b5a01a1f@mellanox.com>
References: <1567695048-5234-1-git-send-email-israelr@mellanox.com>
 <20190905145937.GB24939@localhost.localdomain>
In-Reply-To: <20190905145937.GB24939@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0079.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::19) To AM6PR0502MB4070.eurprd05.prod.outlook.com
 (2603:10a6:209:18::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=israelr@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51d1e624-cd4f-478d-dc0c-08d7321333fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:AM6PR0502MB3799; 
x-ms-traffictypediagnostic: AM6PR0502MB3799:|AM6PR0502MB3799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0502MB379908CC014C90B4DCB86D2ED7BB0@AM6PR0502MB3799.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 015114592F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(199004)(189003)(316002)(76176011)(52116002)(54906003)(6512007)(478600001)(2906002)(6436002)(6116002)(229853002)(6916009)(26005)(81166006)(81156014)(66946007)(6506007)(3846002)(31686004)(53546011)(66066001)(386003)(53936002)(6246003)(186003)(102836004)(8936002)(6486002)(36756003)(4326008)(99286004)(2616005)(25786009)(446003)(305945005)(11346002)(256004)(4744005)(14444005)(66476007)(66556008)(64756008)(66446008)(71190400001)(71200400001)(31696002)(476003)(486006)(5660300002)(86362001)(7736002)(8676002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0502MB3799;
 H:AM6PR0502MB4070.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YRsYvohJ8cnX8V5CE0wkCiU195/ZkA5cqRcgSzK/q4mg46qqNQmRnJB6TxzqtcyMyEVbGJ/bw8C+u7zXo8enO51RNsMiBdOtlXiem/Th/aXA2KdFJd0GRqEz7jwMd9YjvvNN9BXNbaQw8xgsaMgNcFs6qf45Tl2KfP2NLQ72HNffRl/betHY9xz7ZqHnrRNvGZcYcq4sCJkiHmcTwdgbm2WvgIDhWajSQUeccD++ccPdQfowNms9/6/SDcKFth+vZDsRXessfXKgvGL224DhR3vaOUifOjmr0gBcknNpjZ0E4PfuyXVALPhxSIlkhRMEOil+2dGVEobt6+DMZt3KJYWJ4AdqIVWXWIDZln9phcP9yG4FbBk5whLuKqGqr+U6zdIRmS/hW788LKsQpEPQVJIeFUBXUGKsdhZGqqHpTBY=
Content-ID: <ECFFD948EECD0140A3EA593123D987B5@eurprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d1e624-cd4f-478d-dc0c-08d7321333fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2019 15:10:35.7790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxvBUtfvp9iaM1O5yizO6jmJn+Eeq7dzSSTF54UDSkEHEOC5BZH5J55ZtOefLHEIVcocNk5mnUCxrjzT9AmULQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0502MB3799
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_081039_407496_70CB4FA8 
X-CRM114-Status: UNSURE (   8.70  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS81LzIwMTkgNTo1OSBQTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEl0J3Mgbm90IHJlYWxs
eSBhIGRvdWJsZSBhc3NpZ25tZW50LiBBbiBpbnRlcnJ1cHQgZHJpdmVuIHF1ZXVlIG1heSBiZWNv
bWUNCj4gYSBwb2xsZWQgcXVldWUgYWZ0ZXIgYSByZXNldCwgaW4gd2hpY2ggY2FzZSB0aGlzIGFz
c2lnbm1lbnQgc2VydmVzIHRvDQo+IGNsZWFyIGl0J3MgcHJldmlvdXNseSBhc3NpZ25lZCB2ZWN0
b3IuIEl0IGRvZXNuJ3QgYWN0dWFsbHkgYXBwZWFyIHRvDQo+IG1hdHRlciBpZiB3ZSd2ZSBjbGVh
cmVkIGl0IG9yIG5vdCB3aGVuIHRoZSBOVk1FUV9QT0xMRUQgZmxhZyBpcyBzZXQsDQo+IHRob3Vn
aC4NCg0KU28gd2hhdCBhYm91dCB0aGUgc2Vjb25kIGFzc2lnbm1lbnQgd2hlbiBwb2xsZWQgaXMg
ZmFsc2U/DQoNCiDCoMKgwqDCoMKgwqDCoCBudm1lcS0+Y3FfdmVjdG9yID0gdmVjdG9yOw0KIMKg
wqDCoMKgwqDCoMKgIG52bWVfaW5pdF9xdWV1ZShudm1lcSwgcWlkKTsNCg0KIMKgwqDCoMKgwqDC
oMKgIGlmICghcG9sbGVkKSB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVx
LT5jcV92ZWN0b3IgPSB2ZWN0b3I7IDw8PDw8DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJlc3VsdCA9IHF1ZXVlX3JlcXVlc3RfaXJxKG52bWVxKTsNCg0KDQpSZWdhcmRzLA0KDQpJ
c3JhZWwNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
