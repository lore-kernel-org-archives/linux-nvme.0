Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C97DC4741F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 07:39:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A50E2076E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 07:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ykroT9T+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=primelogicnl.onmicrosoft.com header.i=@primelogicnl.onmicrosoft.com header.b="0qA/P5wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A50E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=primelogic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iVOvi7LkmsHshNTf2mJHQaqQrsQGwGYcoizGsjUk4DQ=; b=ykroT9T+5QoUF2Miwqa+llnV8
	S3lKSA8esWDDV/vZqObyQy97GagrJ4KT/BGDyg1Vb64Ize7s2AUSLQtw6frIHok94Le8nYGZfIGa2
	8KPPHbtCyG6ZLhzrTkCxNQVNtJstOfybcVr1P6CR5mvCaoVTMCuHm4Nm0WcdK3Gv6Ll/UMyTM6v1M
	fLafUGxUf/8DEbUn/l5g4qqLKD6VtrDuGNthfLXhAv5AQImFqe1Kquj6fRUnTUgVRUDjDz2faK58a
	zIYV7LfE0tz05S2pbCJcE/nOBp1gIRjAMyqKH51NsdKpwHMS9w+HIpuwczEq3FPx8mx2ju3tdp7bB
	KDMVaCNHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNWhS-0003CO-9x; Wed, 30 Sep 2020 07:38:54 +0000
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com
 ([40.107.21.134] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNWhP-0003BF-QV
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 07:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMCmmU74InvBSaa6vAVOAjqLCI2VrWKR/ePerkSinypnm4jRzgNy1Jl1KWEki0MVJV2RhIvXFlHeYaU6nwPA+kVP6+40yZU/As2bM6A5KrRaXQpBZG5HgAL5XGXOJ+Hiq2p2WResycjpT2lwhETyJ8diuRXcTY0hq66kZDxuXLlXFuXk/fAAdc9nkucB6NrxCdGBUbE/b53VUwF/I2zbStDQZ5cp2ZfpelsIYxzxmjfNVcfD3WjuNh+Vw64kA2YbxzFAcpjer5nW93AfwVzB6Wl+F2a/lPYov9DorSeypwwawuk1c/tmDWL6B+XJPCj3FONQXelGRG+CGyKK9iVQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuZG/yTOzEvLEdkZZd1+YNXLz5YAycTMb9kS6JSvne8=;
 b=LFmGJ4G0qPwgHDmkS7Vuh6Wod8BCshPciIne/WKdfu2RAg+P+JOQSjtXO4q0+L/4LCZFMmZNXnpfdxRJfYo8Bpd0vej0G+soLGoVe7hOmwUrFUqKx9JR6O9eNBDf4aGMk+dBFt5e6IB+wjvClQxuJKyFFxvz5IKz5YdcmxAGto/GJ/zk4Q1Z/S60ib5aW5tlmGzO+jT5LwWtis/Csb3vSGxNeIvllme+qvGekW3PEQkCXNbZCU0rwq55MZ8sH6HFSn6WbZVENeuzyp1lYkxPD1dEuT1DJyuI/ddtVLXq/QNVZSo9ui3jfOjMykNW2c5MQWJqt+QtYzgxljCrGBBxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=primelogic.nl; dmarc=pass action=none
 header.from=primelogic.nl; dkim=pass header.d=primelogic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=primelogicnl.onmicrosoft.com; s=selector1-primelogicnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuZG/yTOzEvLEdkZZd1+YNXLz5YAycTMb9kS6JSvne8=;
 b=0qA/P5wxJwTFGHw9p7IruNrxdeuZPOrgmXhDeESdKStmYJ3CC807jqsfpdTGGneKVWPpuw26dpmrbptPV5Hn6tGcG4ig7FMm4ngbhPaXqA1T57VcUQKAsgr0C5ix+vXZ3eEWMDCsZ6IYLQ5b3ZZx6QQYXnCC8oFM3LBIyc0V/j0=
Received: from AM0PR03MB5634.eurprd03.prod.outlook.com (2603:10a6:208:16f::27)
 by AM0PR03MB6225.eurprd03.prod.outlook.com (2603:10a6:20b:15a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Wed, 30 Sep
 2020 07:38:49 +0000
Received: from AM0PR03MB5634.eurprd03.prod.outlook.com
 ([fe80::d25:a3c8:fc68:9042]) by AM0PR03MB5634.eurprd03.prod.outlook.com
 ([fe80::d25:a3c8:fc68:9042%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 07:38:49 +0000
From: Mark Ruijter <mruijter@primelogic.nl>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
Thread-Topic: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
Thread-Index: AQHWllSMA3Lc493H20yf5BlML9rh4amA7lSA
Date: Wed, 30 Sep 2020 07:38:49 +0000
Message-ID: <04159F18-52B6-47B2-BF69-E1FD6B67E8A0@primelogic.nl>
References: <BBC87AAC-A523-41F0-8CDE-38757C407C7F@primelogic.nl>
 <BYAPR04MB4965DEBF8F5F06FC026B502786330@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965DEBF8F5F06FC026B502786330@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=primelogic.nl;
x-originating-ip: [89.220.153.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc814498-26a2-4193-4a29-08d86513df36
x-ms-traffictypediagnostic: AM0PR03MB6225:
x-microsoft-antispam-prvs: <AM0PR03MB6225024D7B7907D72B11F01DD1330@AM0PR03MB6225.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pv6khhHbkeES6+xQ1tZHBEXBqFx2/AadAYGFSIEs7vf9XxNYoxoWp0KVuzJjsbehcW62OjK8ZaKboiY/XPwtzh8yysJkn4TFf6Cvbj/YdgRqoayYPUMEIcHSA7yZkiWC4FxqvRgWPmJsWRflmxmi2ByFZl9evb5X0csJg2q30RoRbG0yKgOf8NgOkS1/Yy4FMxPRAYJw6nDzvLrpZJxQpEqLHJkPoJLfkAQIUdM9uv3VaEFvvtroRtEDehVW0tAiEK5BWsoA+ow5EnC2lYtle5Kdvtf5eSW8bgab1aVbgvD9i5GaRU5kRVTlW92PRW1kGSNMpkrXm1UY7tcki/VXJSZ1nYGcjGLEsLflurmT9H3Wn3NH6QOPgc3Sca/WGs9G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR03MB5634.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(366004)(376002)(396003)(39830400003)(36756003)(316002)(6486002)(8936002)(5660300002)(86362001)(53546011)(2906002)(71200400001)(33656002)(6506007)(186003)(478600001)(26005)(4326008)(6916009)(6512007)(76116006)(64756008)(91956017)(66446008)(66556008)(66476007)(66946007)(2616005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wKujEIdv4DnVoxVbUIevKlddnBLbK2QQrbD63IUBJfWV+rpnXP8u1yOY7FDVpxjxCRxxF1FSD6ANTNxfUCjVC/8SwuXbeW/QAPuJDbJuq9SzT4cFfYTzNPYUMsZ1jNSyxe1y/SAkl5Gu0WJzQ42pjoMyK8yVDS7bRO/P9oJTMaLV0/AWLdm2TTtOT4iK4GEX59A/c3y466DhpwmENpGrMNTsSL72Y003X755Ah0L5OLti62XP0Bb/CMT1MEgZW0v7iJil/rXNno+ffpwVzMyJGlqrlprYMzbUAxZUh/LqKxmTgqEQth1Ks/u8Wwz1S3h0gD/sS6dx9KzRVp1n07/93TrB7fmXqACOr49OaKan9iBxP46386snUYHl1AF7okiM6lfdTe8qBggU7SkQYPgQjNKTSOgfAKkSMJcOiSDDlQtlnbDF2E7iaIWBCHOoPdMmbr+/rbiCEWO8bFAa6cUMPrrUW0wB5Ad3tUH5AnRfvXWsAYWuZFT6hb8uGIDGMDowBB8ppfLdS48Xe8Ca3XPiYna3cHR849ThEex3leHwmpIJ1RLHJuupcBoOy7s7EdBu+KQVSZGNnzK7+lZeXZ95XulXZzlSp1ITnfYFOLwYtr3UIwaKU1Kt9FseS+GRgVoWLW72LVNJLMZZbmSR/YOvA==
x-ms-exchange-transport-forked: True
Content-ID: <BC815C3BFDE7274492C50F4358DB5EE1@eurprd03.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: primelogic.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB5634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc814498-26a2-4193-4a29-08d86513df36
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:38:49.4387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e6f00f2a-c615-4e27-aa0e-cb78655623c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5Dca6BlRcK3/c7bd55KvrpK7nHRbELbPUGtCyflo1CR8Rg55GviweB9VnH1D5bUgs15FtnEoC7o+M3IYx6cdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6225
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_033851_987346_E3DEC706 
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgQ2hhaXRhbnlhLA0KDQpMZXQgbWUgZXhwbGFpbiBteSB1c2UgY2FzZS4gU2luY2UgSSB0aGlu
ayB3ZSBoYXZpbmcgZGlmZmVyZW50IHRoaW5ncyBpbiBtaW5kLg0KWW91IGFyZSBzdWdnZXN0aW5n
IHRvIHVzZSBudm1lIGNsaSB0byBzZXQgYW4gbnZtZSBkcml2ZSBuYW1lc3BhY2UgdG8gcmVhZG9u
bHkgYW5kIGV4cG9ydCBpdCByZWFkb25seSB1c2luZyB0aGUgTlZNZSB0YXJnZXQgZHJpdmVyPw0K
VGhpcyB3aWxsIGNlcnRhaW5seSB3b3JrLCBJIGFncmVlLg0KDQpJbiBteSBjYXNlIGxldCdzIGFz
c3VtZSBJIGhhdmUgYSByYWlkIGRldmljZSAvZGV2L21kWCB0aGF0IEkgd2FudCB0byBleHBvcnQg
cmVhZG9ubHkgdG8gYW4gaW5pdGlhdG9yLiBJIGFtIHVuYWJsZSB0byBydW4gYW55IGNvbW1hbmQg
b24gdGhlIGluaXRpYXRvci4NClRoZSB0YXJnZXQgc2hvdWxkIGV4cG9ydCB0aGUgZGV2aWNlIGlu
IHN1Y2ggYSB3YXkgdGhhdCB0aGUgaW5pdGlhdG9yIGNhbiBuZXZlciBhY2NpZGVudGFsbHkgd3Jp
dGUgdG8gaXQuDQoNCkkgZmFpbCB0byB1bmRlcnN0YW5kIGhvdyBudm1lIGNsaSBOVk1FX05TX1dS
SVRFX1BST1RFQ1QgY2FuIGhlbHAgbWUgaW4gdGhpcyB1c2UgY2FzZT8NCg0KVGhhbmtzLA0KDQot
LU1hcmsNCg0KDQrvu79PcCAzMC0wOS0yMCAwMjoyOSBoZWVmdCBDaGFpdGFueWEgS3Vsa2Fybmkg
PENoYWl0YW55YS5LdWxrYXJuaUB3ZGMuY29tPiBnZXNjaHJldmVuOg0KDQogICAgT24gOS8yOS8y
MCAwNDozNSwgTWFyayBSdWlqdGVyIHdyb3RlOg0KICAgID4gVW5sZXNzIEkgYW0gbWlzdGFrZW4g
dGhlIE5WTWUtb0YgdGFyZ2V0IGRyaXZlciBkb2VzIGN1cnJlbnRseSBub3Qgc3VwcG9ydCB0byBl
eHBvcnQgYSBkZXZpY2UgcmVhZC1vbmx5IGZyb20gdGhlIHRhcmdldCBzeXN0ZW0uDQogICAgPiBG
b3IgZXhwb3J0aW5nIHJlYWRvbmx5IHNuYXBzaG90IGRldmljZXMgSSBhbSBjdXJyZW50bHkgdXNp
bmcgdGhlIGF0dGFjaGVkIHBhdGNoLg0KICAgIA0KICAgIEl0IGRvZXMsIGhhdmUgeW91IHRyaWVk
IHVzaW5nIG52bWUgY2xpIHdpdGggTlZNRV9OU19XUklURV9QUk9URUNUIGZlYXR1cmUgPw0KICAg
IA0KICAgIHdlIGhhdmUgYm90aCBob3N0IGFuZCBjb3JlIHBhdGNoZWQgZm9yIHJlYWQtb25seSBt
b2RlLCBpZiB5b3UgZmluZCBhbnkgYnVnDQogICAgDQogICAgcGxlYXNlIGxldCBtZSBrbm93Lg0K
ICAgIA0KICAgIA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
