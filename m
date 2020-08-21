Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B34C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 13:03:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4DD207BB
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 13:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F40CS38I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=primelogicnl.onmicrosoft.com header.i=@primelogicnl.onmicrosoft.com header.b="PuLf6xTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4DD207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=4cUqIylpRt5TA/nAMGjKNEKZbzT9ldPogleeqbYXLV4=; b=F40
	CS38IppBIq2s6+ZdCGhC96E0C0YQZxZmX9Es2oUZg/j+5t4BQhRI14jHnyJuftrDtdUJrjpul4t8/
	1c3bx1AoUslSUQbGMz2PQ88RiQ3Su2zzzNxBh338zpbTi7WcehdjfdwJ8717LQu2ZUAsD/v9D/64h
	cIVL1CBkvX3h1sejdSVTSVCCZGEUMUtBoxeqmFFspIKxGbOkPgIjZ9r0X7gMcAQU9fldU3OJZRYW5
	qeMlVHCQ0kGpC2puIyoL8DDafbvSIP2nJsOQWr5qujPTIOX2BKP/kvWiLI1iq3k+hjSnX84gVEaoc
	bamMiKBM74ejPTjJfrX8/pk2FtOmESA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k96hs-0003M9-Dp; Fri, 21 Aug 2020 13:03:44 +0000
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k96hq-0003LS-PB
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 13:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y149d8NeW1D39vTBP4uN5Q2yQBHPn7QHaoDZLTfm6So/zug+KR/57Z2hYwvd9TNCzzexcvlnRY/+AQBxBfJauUUng60pmziZnTJsSsbC+30wp2z98g+RZl79sdYmHqFuDmjNeCb4O4ILA5MY7V1m629puX0Horo0G6Oq11wCVWhHsSjYa6CmsPrZXUMg9YLgZ6blrj7aL+4YJSEGXwUk08FjINk7oFiqxp/ymNWBXmaCJeIY2HbW+g19/52abQfquU3jTeKXAVwg/vZUw4QIdFbDm1hwZQMob0SZEEyYEyxjk78hSWsV6E2lFJH+byZp3L0sIVPBxa3h1jFOi/LEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krUOPFgxAle9bXPcpCBenlzWeH/cmf3TonWWmcl21lk=;
 b=DEEuM6lvvb79/dyP3jbAc7bT7z2ZTvvRGMfijWFSUe6jNELqA4icmkfvAq5dBcmXOt+USZM5TuAHjsk8Hs9rGZwcLfBMdF5JnrI2dqJpOKxj0mSCBULrKzS9B8LhGH/xwys5A03B5ONijz/Q06W+QzcPc6BsC0TZNFzXUoMjey3cI2W37QNLegt5zCwIjmWoQS038oXZLzspJ1ON+cCzZfHRbB9UGLhhkX91pexY5u1SvyW9NueqZ/1OflAQthCzglIeWVCiidoN6UPbYhbavtnx/7kgyI9q0p5xHfwLJK9toGOOCFFm4J8JZTaEWSorUttkyqatQAzssK4WsrgRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krUOPFgxAle9bXPcpCBenlzWeH/cmf3TonWWmcl21lk=;
 b=PuLf6xTinq450NEECuRTL6iyy5JkTaGjJeEmaYRy6fZHZpG+r4HO3/H5ZHUNGlpLgiyReosUI/HxkBA0e4iMAbp9eTAzN+Rbl3bchjmFfvmEWVMluaUSVF/WkXre0CzSKxJ0PJB3FUcRlI5Yhyl5EomFHE6f2n4h1S/TFtu6lJI=
Received: from AM0PR03MB5634.eurprd03.prod.outlook.com (2603:10a6:208:16f::27)
 by AM0PR03MB5634.eurprd03.prod.outlook.com (2603:10a6:208:16f::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 13:03:40 +0000
Received: from AM0PR03MB5634.eurprd03.prod.outlook.com
 ([fe80::fd3b:eb05:4ba7:e6af]) by AM0PR03MB5634.eurprd03.prod.outlook.com
 ([fe80::fd3b:eb05:4ba7:e6af%4]) with mapi id 15.20.3305.026; Fri, 21 Aug 2020
 13:03:40 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: A new feature requests with patches that implement the features.
Thread-Topic: A new feature requests with patches that implement the features.
Thread-Index: AQHWd7t921KOUq57MkW4kMk91lMgjQ==
Date: Fri, 21 Aug 2020 13:03:40 +0000
Message-ID: <179E62B7-E056-43D7-8222-E3D7CDFBBCBF@contoso.com>
Accept-Language: en-US
Content-Language: nl-NL
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=primelogic.nl;
x-originating-ip: [89.220.153.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ff6131f-4611-4e25-b091-08d845d2a02e
x-ms-traffictypediagnostic: AM0PR03MB5634:
x-microsoft-antispam-prvs: <AM0PR03MB5634F6A2CEB69B1E191E6DBBD15B0@AM0PR03MB5634.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yyMYWa1qsYQRRyv4FwjIPWF0cNHuuwZiQOmbgSfaSpt16dpSA1KJ9kqgM5ecAixGwm9pAHuQ7ehb1PIPNoUpExkfZiI2gmNnS7uWiRxctMI+vCScgWy+GJYtRWdHgWh0b/3T5PX491fuQSnxqPFVUSLS/VsvfBE+5YqmadCObgOQXNi/hyTXzadow0BcghWtkxKE9Cvols3ajQmIC1lJZR2SnpG5tyFUw/yeYJz5VcbSi663Jy5KrkkKqD25RqUrFdMTH4ZKU/El7BXvrgOhNIWUKLAUBzc6/8kdDaWkV/8vNN84BHYKEWB2DoT/sSfjmBvlkGPjw/6k/EEhgFkCRA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB5634.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39830400003)(396003)(366004)(376002)(346002)(83380400001)(66576008)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(91956017)(6486002)(8676002)(26005)(36756003)(71200400001)(6506007)(2906002)(33656002)(99936003)(186003)(316002)(6916009)(8936002)(4326008)(5660300002)(6512007)(9686003)(478600001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: iUzCWtFTCHkRRYYhG373Eu23BINdRXI//NVtVfOBALRef09REUY7mOyO9YQmYIbK993N/G//uwsL9ddF8MxFSuArsK/aJiU+O0K3s4Mxfk2n2T2reMcuw2y9aAHLA4n6iZtYANGz10HdWj6ouABk8hmcZ59qz4ywVtCo9DCQdZlsWfL/10qNPD8+22zvoE7OsFS8C+5nHQYzSfFnsvZ17HTSOD8H4mCSqruZ4HUVS3CjXfxgthMKrPdb8k9jaVA0igfMBOWAH2XtAIWK5MJ7OWsKHfa+RnmTb8860ABgGTYC/+BFfEYNSxs8Q+qoanFQu3uBOMmnrYXdlHwNXzn7GZQ7gGzYOIZCmVDbYtGzXROCXwJSMKtzFK+9qIenMaQIe+f1s/9uVR++38zP1KckukjWzbMm92jVKZ1h3Kv/wmQyVLi9go3YMbTpie5u3MeeMvr7AsEsAZkDJ5aubOacRPleutyRHhT7jnOmSe6Db0KUZhML994HYbYOeQP9amP/lSSP3ZPg0erU0YEkeDiiYJY026UWYR0yLjE6kUhpOdM8XtXTVIKRcCF4lx0kLW1fLjiLRdc0Jp5NUjHoExCvKreyLuugnaalb+Vq+639g+J1HlPfv1DK7S2OEEG3EKvKzkZMfa3WWB6pjAfG18t/pQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
 boundary="_003_179E62B7E05643D78222E3D7CDFBBCBFcontosocom_"
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB5634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff6131f-4611-4e25-b091-08d845d2a02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 13:03:40.4758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVb4sIAbRUzynepasVa3d6kyge3bmQkCPURcOeGH3XxkfhAFh30IG0Lpvdc3c0hJ/fsQnKSrjVX/O51suw+PXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5634
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_090342_863346_3CFF821D 
X-CRM114-Status: GOOD (  19.88  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--_003_179E62B7E05643D78222E3D7CDFBBCBFcontosocom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <313B4896E90EA940B52274124C9FB509@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

SGkgQ2hhaXRhbnlhLA0KDQpXZSB3b3JrZWQgYSB3aGlsZSBhZ28gb24gdGhlIE5WTWUgdGFyZ2V0
IG1vZGVsIGF0dHJpYnV0ZSBhbmQgdGhlIGNvbnRyb2xsZXIgaWQgY29uZmlndXJhdGlvbiBjaGFu
Z2VzIHdoaWNoIGFyZSBub3cgYWxsIHVwc3RyZWFtLiBTbyBJIGhvcGUgeW91IGRvbuKAmXQgbWlu
ZCB0aGF0IEkgdXNlIHlvdSBhcyBhIGZpcnN0IGNvbnRhY3QgZm9yIHRoZSBmZWF0dXJlIHJlcXVl
c3RzIEkgYW0gYWJvdXQgdG8gcHJvcG9zZS4NCg0KMS4gVGhlIE5WTWUgdGFyZ2V0IHN1YnN5c3Rl
bSBhbGxvd3MgdG8gY2hhbmdlIGEgZGV2aWNlIGZyb20gcmVhZHdyaXRlIHRvIHJlYWRvbmx5LiBI
b3dldmVyIGN1cnJlbnRseSwgYXNzdW1pbmcgdGhhdCBJIHVuZGVyc3RhbmQgdGhpbmdzIHJpZ2h0
LCB0aGlzIG5lZWRzIHRvIGJlIGRvbmUgb24gdGhlIGluaXRpYXRvci4gU28gZm9yIHRoZSBpbml0
aWF0b3IgdGhpcyB3b3JrcyBpZGVudGljYWwgdG8gYSBQQ0llIGNvbm5lY3RlZCBOVk1lIGRyaXZl
LiBIb3dldmVyIGZvciBhIE5WTWUtb0YgdGFyZ2V0IHN5c3RlbSBpdCBtYWtlcyBzZW5zZSB0byBi
ZSBhYmxlIHRvIHNldCB2b2x1bWVzIG9uIGV4cG9ydCB0byByZWFkb25seS4gQSBnb29kIGV4YW1w
bGUgaXMgZXhwb3J0aW5nIHNuYXBzaG90cywgd2hpY2ggYXJlIGZyZXF1ZW50bHkgZXhwb3J0ZWQg
cmVhZG9ubHkuIEhvd2V2ZXIgdGhlIHVzZSBjYXNlIGlzIG5vdCBsaW1pdGVkIHRvIHNuYXBzaG90
cyBvbmx5LiBNb3N0IG9mIHRoZSBjb2RlIHRvIG1ha2UgdGhpcyB3b3JrIGlzIGFscmVhZHkgcHJl
c2VudCBpbiB0aGUgTnZtZXQgY29kZS4gU28gdGhlIG9ubHkgY2hhbmdlIHRoYXQgSSB3b3VsZCBs
aWtlIHRvIHByb3Bvc2UgaXMgdG8gYWRkIOKAnHJlYWRvbmx54oCdIGFzIGEgY29uZmlnZnMgYXR0
cmlidXRlLiBUaGUgZXhhbXBsZSBwYXRjaCB0aGF0IG1ha2VzIHRoaXMgd29yayBpcyByZWFkb25s
eS5wYXRoLg0KDQotLQ0KV2l0aCB0aGUgcGF0Y2ggYW5kIGFmdGVyIHNldHRpbmcgdGhlIG5hbWVz
cGFjZSB0byByZWFkb25seToNCm5hbWVzcGFjZXMvMSAjIGVjaG8gMSA+IHJlYWRvbmx5DQpuYW1l
c3BhY2VzLzEgIyBlY2hvIDEgPiBlbmFibGUNCg0Kcm9vdEByMTFpMzp+IyBlY2hvIGhlbGxvID4v
ZGV2L252bWU1bjEgDQotYmFzaDogZWNobzogd3JpdGUgZXJyb3I6IE9wZXJhdGlvbiBub3QgcGVy
bWl0dGVkDQotLQ0KDQoyLiBDdXJyZW50bHkgd2hlbiBhbiBpbml0aWF0b3IgZGlzY292ZXJzIGEg
dGFyZ2V0IHBvcnRhbCB0aGUga2VybmVsIHdpbGwgbG9nIGEgbGluZSBsaWtlIHRoaXM6DQprZXJu
ZWw6IFs2OTk3My42NzMxOThdIG52bWV0OiBjcmVhdGluZyBjb250cm9sbGVyIDQgZm9yIHN1YnN5
c3RlbSBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkgZm9yIE5RTiBucW4uMjAx
NC0wOC5vcmcubnZtZXhwcmVzczp1dWlkOjMzYWExNmMwLTBkNTYtNDU4Ny1iMWMyLTAwMDAwMDAw
MDAwMy4NClRoZSBwYXRjaCAiZmFicmljcy1jbWRfbG9nLnBhdGgiIHdpbGwgY2hhbmdlIHRoZSBs
aW5lIHRvIGxvb2sgbGlrZSB0aGlzOg0Ka2VybmVsOiBbODE5NzEuNDM0NTU5XSBudm1ldDogY3Jl
YXRpbmcgY29udHJvbGxlciAxIGZvciBzdWJzeXN0ZW0gbnFuLjIwMTQtMDgub3JnLm52bWV4cHJl
c3MuZGlzY292ZXJ5IGZvciBOUU4gbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVpZDozM2Fh
MTZjMC0wZDU2LTQ1ODctYjFjMi0wMDAwMDAwMDAwMDMgb24gcG9ydCAzMTIyIDogMTkyLjE2OC45
LjEwIC0gNDQyMA0KDQpUaGUgaW1wb3J0YW50IHBhcnQgb2YgdGhlIGNoYW5nZSBpcyBhZGRpbmcg
dGhlIHBvcnQgbnVtYmVyLiBXaHkgaXMgdGhpcyBpbXBvcnRhbnQ/IFRoaXMgaW5mb3JtYXRpb24g
Y2FuIG5vdyBiZSB1c2VkIHRvIG5vdCBvbmx5IGF1dG9tYXRpY2FsbHkgZGV0ZWN0IGluaXRpYXRv
cnMsIGJ1dCBhbHNvIGRldGVjdCB3aGljaCBwb3J0IGFuZCBwcm90b2NvbCBpcyB1c2VkLiBBZGRp
bmcgdGhlIElQIGFuZCBwb3J0IGluZm9ybWF0aW9uIGlzIGNvbnZlbmllbnQgb25seS4gSG93ZXZl
ciBsb2dnaW5nIHRoZSB0YXJnZXQgcG9ydCBpcyB2ZXJ5IHVzZWZ1bCB3aGVuIGEgdGFyZ2V0IHN5
c3RlbSBoYXMgbXVsdGlwbGUgcGh5c2ljYWwgcG9ydHMgYW5kIHN1cHBvcnRzIG11bHRpcGxlIHBy
b3RvY29scyBsaWtlIHRjcCBhbmQgcmRtYS4NCg0KSG9wZWZ1bGx5IHRoZSBwcm9wb3NlZCBjaGFu
Z2VzIG1ha2Ugc2Vuc2UuDQoNCi0tTWFyayANCg0K

--_003_179E62B7E05643D78222E3D7CDFBBCBFcontosocom_
Content-Type: application/octet-stream; name="fabrics-cmd_log.patch"
Content-Description: fabrics-cmd_log.patch
Content-Disposition: attachment; filename="fabrics-cmd_log.patch"; size=633;
	creation-date="Fri, 21 Aug 2020 13:03:40 GMT";
	modification-date="Fri, 21 Aug 2020 13:03:40 GMT"
Content-ID: <1A45CE5BDC0FF34D8A364AB0BAD2C7B5@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvbnZtZS90YXJnZXQvZmFicmljcy1jbWQuYy1vcmlnCTIwMjAtMDgtMjAgMDk6
MzQ6MDIuMDkyMjgyMjA3IC0wNjAwCisrKyBkcml2ZXJzL252bWUvdGFyZ2V0L2ZhYnJpY3MtY21k
LmMJMjAyMC0wOC0yMSAwMzozODoyNy4wMzczMzQ1MzAgLTA2MDAKQEAgLTIwNSw4ICsyMDUsMTAg
QEAKIAkJZ290byBvdXQ7CiAJfQogCi0JcHJfaW5mbygiY3JlYXRpbmcgY29udHJvbGxlciAlZCBm
b3Igc3Vic3lzdGVtICVzIGZvciBOUU4gJXMuXG4iLAotCQljdHJsLT5jbnRsaWQsIGN0cmwtPnN1
YnN5cy0+c3Vic3lzbnFuLCBjdHJsLT5ob3N0bnFuKTsKKwlwcl9pbmZvKCJjcmVhdGluZyBjb250
cm9sbGVyICVkIGZvciBzdWJzeXN0ZW0gJXMgZm9yIE5RTiAlcyBvbiBwb3J0ICVpIDogJXMgLSAl
c1xuIiwKKwkJY3RybC0+Y250bGlkLCBjdHJsLT5zdWJzeXMtPnN1YnN5c25xbiwgY3RybC0+aG9z
dG5xbiwKKwkJbGUxNl90b19jcHUoY3RybC0+cG9ydC0+ZGlzY19hZGRyLnBvcnRpZCksCisJCWN0
cmwtPnBvcnQtPmRpc2NfYWRkci50cmFkZHIsIGN0cmwtPnBvcnQtPmRpc2NfYWRkci50cnN2Y2lk
KTsKIAlyZXEtPmNxZS0+cmVzdWx0LnUxNiA9IGNwdV90b19sZTE2KGN0cmwtPmNudGxpZCk7CiAK
IG91dDoK

--_003_179E62B7E05643D78222E3D7CDFBBCBFcontosocom_
Content-Type: application/octet-stream; name="readonly.patch"
Content-Description: readonly.patch
Content-Disposition: attachment; filename="readonly.patch"; size=1305;
	creation-date="Fri, 21 Aug 2020 13:03:40 GMT";
	modification-date="Fri, 21 Aug 2020 13:03:40 GMT"
Content-ID: <0BCD85AA5E434C45A00F0D2909596CA1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvbnZtZS90YXJnZXQvY29uZmlnZnMuYy1vcmlnCTIwMjAtMDgtMjEgMDU6NTA6
MTQuMzY5NDYyNDE5IC0wNjAwCisrKyBkcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMJMjAy
MC0wOC0yMSAwNTozNzoxMy44MTc0NDk3OTUgLTA2MDAKQEAgLTU0Myw2ICs1NDMsMzQgQEAKIAog
Q09ORklHRlNfQVRUUihudm1ldF9uc18sIGJ1ZmZlcmVkX2lvKTsKIAorc3RhdGljIHNzaXplX3Qg
bnZtZXRfbnNfcmVhZG9ubHlfc2hvdyhzdHJ1Y3QgY29uZmlnX2l0ZW0gKml0ZW0sIGNoYXIgKnBh
Z2UpCit7CisgICAgICAgIHJldHVybiBzcHJpbnRmKHBhZ2UsICIlZFxuIiwgdG9fbnZtZXRfbnMo
aXRlbSktPnJlYWRvbmx5KTsKK30KKworc3RhdGljIHNzaXplX3QgbnZtZXRfbnNfcmVhZG9ubHlf
c3RvcmUoc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLAorICAgICAgICAgICAgICAgIGNvbnN0IGNo
YXIgKnBhZ2UsIHNpemVfdCBjb3VudCkKK3sKKyAgICAgICAgc3RydWN0IG52bWV0X25zICpucyA9
IHRvX252bWV0X25zKGl0ZW0pOworICAgICAgICBib29sIHZhbDsKKworICAgICAgICBpZiAoc3Ry
dG9ib29sKHBhZ2UsICZ2YWwpKQorICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOworCisg
ICAgICAgIG11dGV4X2xvY2soJm5zLT5zdWJzeXMtPmxvY2spOworICAgICAgICBpZiAobnMtPmVu
YWJsZWQpIHsKKyAgICAgICAgICAgICAgICBwcl9lcnIoImRpc2FibGUgbnMgYmVmb3JlIHNldHRp
bmcgcmVhZG9ubHkgdmFsdWUuXG4iKTsKKyAgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJm5z
LT5zdWJzeXMtPmxvY2spOworICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOworICAgICAg
ICB9CisKKyAgICAgICAgbnMtPnJlYWRvbmx5ID0gdmFsOworICAgICAgICBtdXRleF91bmxvY2so
Jm5zLT5zdWJzeXMtPmxvY2spOworICAgICAgICByZXR1cm4gY291bnQ7Cit9CisKK0NPTkZJR0ZT
X0FUVFIobnZtZXRfbnNfLCByZWFkb25seSk7CisKIHN0YXRpYyBzdHJ1Y3QgY29uZmlnZnNfYXR0
cmlidXRlICpudm1ldF9uc19hdHRyc1tdID0gewogCSZudm1ldF9uc19hdHRyX2RldmljZV9wYXRo
LAogCSZudm1ldF9uc19hdHRyX2RldmljZV9uZ3VpZCwKQEAgLTU1MCw2ICs1NzgsNyBAQAogCSZu
dm1ldF9uc19hdHRyX2FuYV9ncnBpZCwKIAkmbnZtZXRfbnNfYXR0cl9lbmFibGUsCiAJJm52bWV0
X25zX2F0dHJfYnVmZmVyZWRfaW8sCisJJm52bWV0X25zX2F0dHJfcmVhZG9ubHksCiAjaWZkZWYg
Q09ORklHX1BDSV9QMlBETUEKIAkmbnZtZXRfbnNfYXR0cl9wMnBtZW0sCiAjZW5kaWYK

--_003_179E62B7E05643D78222E3D7CDFBBCBFcontosocom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--_003_179E62B7E05643D78222E3D7CDFBBCBFcontosocom_--

