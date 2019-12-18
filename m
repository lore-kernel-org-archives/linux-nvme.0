Return-Path: <SRS0=PPGx=2I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B584C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 01:03:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A9D206D3
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2019 01:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DiGwFq1+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ws0w+1SH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ei+/sbMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A9D206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xivHZ2VGl4TOx5oz5OlGNhO/Kh2oNKA6WkEa6LMSrcc=; b=DiGwFq1+VmPSJl
	ea0fSG2YlU08ebrXYOnXPYcTvPr3+lumMcXihiQ/NnpC52E4HEeGdbIJQPa6siZR8SxR4JU9BCYmv
	S5dwc7fx7IjO9lFArc3X3DqjZwQBbbGWL6nQw5orxCaK5aG5VD10m70tWwxDa6yFr5VXxracxt77M
	wxPyqAhP9onSUDa8mvVjcgP6ibqdw5oCwIVD6HChec3BPVPFAqtvA8dA8dDYBzDU+fudY3MZ3olU0
	4CyTTXGQTNQyBAWCvwEmx2EzbBziD3/kAR0PdCOakFWgGgJfMM8Em/jubgXcr2ikLv88aC8h5ag/B
	qJQRoU4g8ocjE8VdD77Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ihNkR-00059K-RT; Wed, 18 Dec 2019 01:03:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ihNkO-00058l-OQ
 for linux-nvme@lists.infradead.org; Wed, 18 Dec 2019 01:03:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576631008; x=1608167008;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=+vpeGyQWUaPoaMDiw5eEa0RagOPFW/cTTwDuT2inJiA=;
 b=Ws0w+1SHtbcpGcYcTsuLg1B9AppaxqfAYJhlnQPyZKHfcwADabEPteI0
 sH+iCtdnNOd3IsbTuRD1nnbyXJNp0DbvBBmw3l1cevimqr4KBImwhifrO
 ZxTyo/H6Ooei0+87OCd0xXTdAVxxuhu0EuKM/FcBwLwDwC6kdV7bnxlv/
 JnZPTZouvhKXq0Nmpm2Od+ae2yKeGOKhgxo5FxDQBF6DXKEVnOAK1ZTGW
 EfXrZfxyALA3Zx0hiStvZZP8h5vtGInMJ0uyfGiVbu2Pg52SHVB3aqIWk
 NJhCYRcbykvcDbc0AG4EltkK3SH03khQ5jV6eHMQh3JhIsx6pHvqU9L0o Q==;
IronPort-SDR: 79sxCJrpOvkppt1EIYw/3n/pfcNwP0nCYwf+oQ02fzaJBhqHcJygQcus3SNealHHDpMiw/aVNz
 HxOAoK0r9AKgi/5PIQVDdN0eewtXn1vlgx16VM1KDLIwzFPDbI1mb7bWIRj4+x67uvfCH8Wuvj
 rsiYsEQ6D6qYcs7WPSHBeRwcGyA7Wcwqvma5C+05DvU1Z9qFX9S6TU7HR7GreNOshJiFrbodk/
 v8vi269CJyapwnN7soRcJjAy9BA56g/7R8yb1QQcUVWHXj10US4JiCMdZbU3BctWVVVkuVf3RF
 Ea0=
X-IronPort-AV: E=Sophos;i="5.69,327,1571673600"; d="scan'208";a="125584544"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
 by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2019 09:03:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9It5Scl4wszS0rCV6Au/Fr19JAx940jefpqkpR3qxkepk5HcD4NMZRgklCSL3LFJg94td0wgpCjIiO625J3YIyAOzKog84JpYa3owxuGEliubg5qLdzABN9oUla/pnFdkptGuuDXFXrtJC0IYoSP6S664nqtpUFz4hSUB5dsm7uj4cLIETXH/ouvMlrCY4MRqaK+Nnz8GfPISljYHhxynONHrPCuc+suszAi8K4zwqQD8J8kPWMKalbZ35T1y6S4Kj+nGZPhpq33g0dD7xvow3p/yFuyKhjFQubwKSZQAmF+tfhocLmZCET+bEqN9L8w1ylp0/b5XukYu2MenKAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vpeGyQWUaPoaMDiw5eEa0RagOPFW/cTTwDuT2inJiA=;
 b=ck6wsARSescPyuqmEWZ1JeSnUsE1UfsZseHv0oQlvzmAcBQNE7opqQYKh3s9QzT9SR2vB/w/igepyjzQ2fiF8syoW5n5PQxD/Wt8pmBXrFyY0PbqKzkzkzD2alpt8R3sU/lvmCNtUogI3lNFp4P2ShUKhTK5ZUW9kKgZhgO4LJ5fsybBrkjtMU/L22pVnOFHxg0E/KmsmSWrDW97/F1rI5wvZY8GRtkZFSwAoEBtEylSqL3wnu9FUAgXTt3bh6kcS0c7fiOODD+o9n/xQRIMWDXpVr4BcWiFIhNZyJyliRpLHxrs5Nulv2Ym3wtLXNpkPJAegK9yJAxManv7dFLqVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vpeGyQWUaPoaMDiw5eEa0RagOPFW/cTTwDuT2inJiA=;
 b=Ei+/sbMx2ean53tl2NY9zqX2CyPHEeHWkaoptWbZQCdSc+OpzLvMxsLN6sYKgcJSV0eni0Ch2H1M/htO4cwFqCYQICBPciDb3Y1rjiGO3NmTerA+1o8LezicrmHhX0W/Qu1a4U9rgwO3HWOQeV/V4n54/GgP1HHT2oABjWTBD2w=
Received: from BYAPR04MB5656.namprd04.prod.outlook.com (20.179.58.95) by
 BYAPR04MB6199.namprd04.prod.outlook.com (20.178.235.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Wed, 18 Dec 2019 01:03:19 +0000
Received: from BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e9c7:7465:ee42:c2ae]) by BYAPR04MB5656.namprd04.prod.outlook.com
 ([fe80::e9c7:7465:ee42:c2ae%7]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 01:03:19 +0000
From: Jeffrey Lien <Jeff.Lien@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: NVMe CLI Doc Regen
Thread-Topic: NVMe CLI Doc Regen
Thread-Index: AdW1Pu77WhASuiIvSieALdRluH8oFA==
Date: Wed, 18 Dec 2019 01:03:19 +0000
Message-ID: <BYAPR04MB5656D3C483431C89188A3C22EA530@BYAPR04MB5656.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Lien@wdc.com; 
x-originating-ip: [199.255.45.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b59dffea-fe57-4313-6e01-08d783561289
x-ms-traffictypediagnostic: BYAPR04MB6199:
x-microsoft-antispam-prvs: <BYAPR04MB6199197D4993F3C5DB4FED3BEA530@BYAPR04MB6199.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0255DF69B9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(199004)(189003)(8936002)(81156014)(478600001)(26005)(316002)(8676002)(4326008)(33656002)(76116006)(4744005)(6506007)(71200400001)(52536014)(7696005)(3480700005)(186003)(9686003)(6916009)(66556008)(2906002)(66476007)(66946007)(64756008)(66446008)(86362001)(5660300002)(55016002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6199;
 H:BYAPR04MB5656.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8/d6iDeccN76YkAfGYUTShkDb0K4O7+0nCzZAobXBrLfd6AZcwgVJgCasLfBLVPXv1Y7+CWpW0VhhIuyJZhMgZFfnGDPq5/ZsfVPhIuNaCgUpV5BN4X2wT/Wg3GrE3zvSpiCxlzxPQGX4syfMjEATUexPLnlvtlDxCf20qtykZkiX6eithRJ6SnX4+BnzKiAuW1n3acOhmKtisrSrhyq492CVJpwZSq0DNefZ0ns1Ljhpq9pwABSRchMMqWNs/jtA378BaITL5tDnIY2x59r4ruPENjPK1yMidI45B2+Za2XYsy7CMdzeA0SK3DE3UJlDl/ars2dlXDNpKDkmKW+4BAOHa57DoAIqdT8I8DM5NOHwT89x/ZvKvIyTT0uMCd0xuP+8zmrJLhID3sgDUN+qbLhh8uqJwH+P20QLAvJoZw+yxMLJonG+qKLbCfb3BGI
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59dffea-fe57-4313-6e01-08d783561289
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2019 01:03:19.6417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5h+o0+sJmQeONjWA994g9aFrgvKIOJiKhBSqXeYpBW60PlZxmBJjQJ84ruf7r3L2BB38U6xRZwh7QJZzwk+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6199
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191217_170328_859433_2D88E381 
X-CRM114-Status: UNSURE (   6.66  )
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
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


Keith,
I added a new wdc plugin command (vs-telemetry-controller-option) in the la=
st pull request and need the new doc files generated.=A0 Could you do a reg=
en of the Documentation files?=A0 =

If you want me to build and include them in the pull request next time, jus=
t let me know.=A0=A0 =A0

Thanks

Jeff Lien
Linux Device Driver Development
Device Host Apps and Drivers
jeff.lien@wdc.com
o: 507-322-2416 (ext. 23-2416)
m: 507-273-9124







_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
