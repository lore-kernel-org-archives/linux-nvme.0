Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E12BC47425
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 11:35:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EC023BC4
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 11:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dBRJxFqG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=primelogicnl.onmicrosoft.com header.i=@primelogicnl.onmicrosoft.com header.b="gB6aJ0/9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EC023BC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XV2TR9zjsmfzmjavJkWF0PCZdjUD6R/8U5cLyZsFIsY=; b=dBR
	JxFqG3dhAu/hF0fbZR2ev33kWP5Jpubq1PYTNXSN8AeQGvxV9iTP/LQ0PQu1MKvuss7OEA+2nrjkG
	l15LdwcTbW2Ex2BN6X4xOgQfrlaBpB6ipfjYqJ3kxeMyiNU11c3EDKiReHj1waiV4EkAdcCo9g9Yp
	nDosk3eL4yYmA6GyCiVcE5cGaVp1o2szhqWsewbXtmN4BxyPHua58Fcd+EPLVPzwNXNPCx4J4z4oi
	4uFtfPBwCMKRLkLmjOhoprKSbil1QsPqnle0V6yJd9IH+CI3oOobYDlZ1Itpi0pSmLKJmy4bVY+DQ
	9vPTpsQTggrKxkcmLfhvkBi7H4Ykp9Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNDuP-0002KL-VI; Tue, 29 Sep 2020 11:35:02 +0000
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNDuL-0002J8-UV
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 11:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwPCx4ZcCaI2UL+7jyD3sy5hoI3UN2YoYpEsHtxtv103VkTayCFMr54QzC/E+725wJ7RFcmrgY5Y75ANljp7GWl/eQMkKxveXh6mUnQouf4rt8fP/Zf2ZuN6plnBCpdl4Ab4jZJm17rMlsuBucgMB8DWBMH63r6E7YH4tLzHa4uiRKKMCYMV6LKh0TagTNi8mq2VkHQaW1TwEXlQL5VwxrrAoM+v4qnA00WsXKU91On6ArWy0ehHHZTikNrB4Z/5EbPDWvtd81Lut/VKWz1C1ZGp8RBkJx8HIApjIcwKTRZuMCpCVvogdfgG5MJ9u5KY34tTX8OTwXRVfAkQyLfIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOd0hBpZxbIYR6mnsQ8sirpzNm46vZT2ruN9lIl31lk=;
 b=XfEXcc9ATW0eUvJ+ybfWM+LnNQx76pYtHUile0K8e1CM3F5VcWXAK+D1insStyriheBFzua0NcGzHCymr4DvQvpGUkV0n8bPvPGZarpDxig4/rZlzVaHcM/ckvyvxAeUDiq73ldFzIdjnK1GbEpLWopZKsCO4Ok3J7op/c9qqr70JeKRb5BuYb2RxP7hns+dIVPUMWqGEFvU1aQFIDpfjtrupmo8+01ptjvI8DDR4tnPb72/1JKflheecE6IP3IPDHGdf6gRnhPP923KdLn6CIceW0ztmIBfPLw++l81+ZxrDOluBZX1LglNE+8iYQjjahJ1uVM22NzwoJ3bBCL1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOd0hBpZxbIYR6mnsQ8sirpzNm46vZT2ruN9lIl31lk=;
 b=gB6aJ0/9P22dSjNyw4cLC71VRcj8wern9TqfnsXmw3HCPwExbsT2Ct9t765/YVbj1o8+qU+s29vuVro6LlgUpCwr61tmYYTXO4hpKvdCaZAz/b+uvENUay+wRWaWVcGb+vEamUd5txdKnWpoH8MJ1OcrCnkhgqM18fr2nU83eW4=
Received: from AM6PR03MB5640.eurprd03.prod.outlook.com (2603:10a6:20b:f7::29)
 by AM6PR03MB3560.eurprd03.prod.outlook.com (2603:10a6:209:33::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 11:34:54 +0000
Received: from AM6PR03MB5640.eurprd03.prod.outlook.com
 ([fe80::4d01:666d:ef2a:a470]) by AM6PR03MB5640.eurprd03.prod.outlook.com
 ([fe80::4d01:666d:ef2a:a470%2]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 11:34:53 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
Thread-Topic: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
Thread-Index: AQHWllSMA3Lc493H20yf5BlML9rh4Q==
Date: Tue, 29 Sep 2020 11:34:53 +0000
Message-ID: <BBC87AAC-A523-41F0-8CDE-38757C407C7F@primelogic.nl>
Accept-Language: en-US
Content-Language: nl-NL
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=primelogic.nl;
x-originating-ip: [89.220.153.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aac4c3ed-fc2b-45dd-2c3d-08d8646baf65
x-ms-traffictypediagnostic: AM6PR03MB3560:
x-microsoft-antispam-prvs: <AM6PR03MB3560AB8BC0EE23C7D0DBD0D9D1320@AM6PR03MB3560.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKq/dSZtfqqbM9MGverEtbnESQPdRSN6iWxw6gM+dRsDg0pnPcAG0VX9tsbHt6QnETH3s80/Rj8Z5Ijww4A2zTVzKcBpxOVkqWXXHvuO4ZTvVznpFe9raeINSmcQIX2WBrDU+aKoEgzx3KzbM+mkem1ZmxPZKtSSb6z8Zd4/6dAz7Lr2zQ+cmO2qAAgQb/ykQY6BTM/SQiBF9QSB4OOae2MLt0xdFFfVGJ6jv0fpuSFPTt8qCSSaEdwKvSXYTSHmCasb6y2X92vb7uY5Nvjx/4Ar/ik6JGfKyNVLjMlfoOtnI33O4hTjj8yKa/OVxoeShQR+tpCr+i+3TqsepnxOaYf19pocQaykuH3kgF6n194TA22BKys5UBZtJjfGp6E0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5640.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(366004)(39830400003)(376002)(136003)(6486002)(6506007)(478600001)(6916009)(99936003)(5660300002)(71200400001)(36756003)(4326008)(66946007)(66616009)(66476007)(66556008)(76116006)(33656002)(8936002)(66446008)(91956017)(2906002)(4744005)(86362001)(8676002)(186003)(6512007)(26005)(316002)(2616005)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: GAcz45GOk2G9xT7jtwFzoB6RcnVnxCF3Gkw2q4YkVSLuP0kGD3oYDOdxsgEF9dBm5tD7MMq9Os58ExaE6zsiZfvCgrcfObSpBx3nPo4+Z7+XQ7DXGy6o+CHoQGn7RaxWMwT+mFAVrSoeJw7GFsrtm9+DwuyDbJ2x5NW2UOn7AwmTv3KjyyocogjD/doEDHGgwK1MjqTfLTdnavJb2Ktx4DHomQmnqscbGgXDBDhV/cThN6dKTNB4w3mNBtFyRziCm7fIcpCU3QbWG8Qb59w4bPwLyEyiT1juAop4KS/ThAzCFKLkBj3O+pgA/eG/KpwPwA1zCWsWD3r5CizNnVrd42KuskN0tFewRngF97rWFjdxMgNRLbJgWAUABn2HiTyVF8NSo0hypR306i4dbB6mCC1PLEtxGFOzfeu2qN88d/0JbmRNP1LJSARBYpETQI+kmDE19HSoAlZbMxTXtHA16zvG6haLSnHVx+ChSlY5a5JFXCLL+9OTUURqL24WyzIu5v0f+f9KguoWB/26iRCAmMSsm4dMv7pmi7FGY+G9HlFXm+vu4ug8Oa2xcwU/dNy5/0/G4BuCrzGCfOZd2ozjlVrd+K9QeQZNRAWlSovgIHEM/1nrNRZENYsjWokqO8+P+kve2AaQO3QBBXMQSvZVHQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
 boundary="_002_BBC87AACA52341F08CDE38757C407C7Fprimelogicnl_"
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5640.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac4c3ed-fc2b-45dd-2c3d-08d8646baf65
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 11:34:53.7717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkTWDL6DYYDq5sDagCs87jHOyD138YbkN0reIBF/R7UBh06oe1dvsScIq+COAt5nOIk3t7Bm5kcktHhp1xVSLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3560
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_073458_038715_7C4BE336 
X-CRM114-Status: GOOD (  12.00  )
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

--_002_BBC87AACA52341F08CDE38757C407C7Fprimelogicnl_
Content-Type: text/plain; charset="utf-8"
Content-ID: <E09C0D44CC9EE44B9B8E42BA83872BBD@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

DQpIaSBhbGwsDQoNClVubGVzcyBJIGFtIG1pc3Rha2VuIHRoZSBOVk1lLW9GIHRhcmdldCBkcml2
ZXIgZG9lcyBjdXJyZW50bHkgbm90IHN1cHBvcnQgdG8gZXhwb3J0IGEgZGV2aWNlIHJlYWQtb25s
eSBmcm9tIHRoZSB0YXJnZXQgc3lzdGVtLg0KRm9yIGV4cG9ydGluZyByZWFkb25seSBzbmFwc2hv
dCBkZXZpY2VzIEkgYW0gY3VycmVudGx5IHVzaW5nIHRoZSBhdHRhY2hlZCBwYXRjaC4NCg0KRG9l
cyB0aGlzIGNoYW5nZSwgb3IgYSBzaW1pbGFyIGNoYW5nZSwgbWFrZSBzZW5zZSBmb3IgdXBzdHJl
YW0/DQoNCiAgICAtLQ0KICAgIFdpdGggdGhlIHBhdGNoIGFuZCBhZnRlciBzZXR0aW5nIHRoZSBu
YW1lc3BhY2UgdG8gcmVhZG9ubHk6DQogICAgbmFtZXNwYWNlcy8xICMgZWNobyAxID4gcmVhZG9u
bHkNCiAgICBuYW1lc3BhY2VzLzEgIyBlY2hvIDEgPiBlbmFibGUNCiAgICANCk9uIHRoZSBpbml0
aWF0b3Igc3lzdGVtIHdyaXRlcyBhcmUgbm93IG5vIGxvbmdlciBwZXJtaXR0ZWQ6DQogICAgcm9v
dEByMTFpMzp+IyBlY2hvIGhlbGxvID4vZGV2L252bWU1bjEgDQogICAgLWJhc2g6IGVjaG86IHdy
aXRlIGVycm9yOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZA0KICAgIC0tDQoNClRoYW5rcywNCg0K
TWFyayBSdWlqdGVyDQoNCg0K

--_002_BBC87AACA52341F08CDE38757C407C7Fprimelogicnl_
Content-Type: application/octet-stream; name="readonly.patch"
Content-Description: readonly.patch
Content-Disposition: attachment; filename="readonly.patch"; size=1305;
	creation-date="Tue, 29 Sep 2020 11:34:53 GMT";
	modification-date="Tue, 29 Sep 2020 11:34:53 GMT"
Content-ID: <1C3B6BC27B188946A84463BFDE6666E8@eurprd03.prod.outlook.com>
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

--_002_BBC87AACA52341F08CDE38757C407C7Fprimelogicnl_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--_002_BBC87AACA52341F08CDE38757C407C7Fprimelogicnl_--

