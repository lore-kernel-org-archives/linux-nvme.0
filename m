Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA173C54798
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 04:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qGCWSkO+daXJw9uZlsE+vsvBpstJfL/MYHfUAsSfpD8=; b=0ch7dc7Cf5Szj11FPs7pLnjxEL
	5NF/Npzktzh+FGbFHYfB5u1SLNZ9bmgtQs/EoxsEhuCXDqjYnYAPcoEOsfn7Fo7JE3Mig23rC2l/X
	d7llcXGdK7QINPhWtwBrWPVCMl0PqbLTXtkzB3z4l0KSj+dsQWY61vMocf21rdY+RwzYOlKPXuFxH
	y8NaoWPGcal8ijMROgxaD95/Pp/gZUDi6fKxvnw9dX2DNfI7qCXSG5jA85csf2MvNqTRMEVfxO6Mj
	BeD3z8+ybcYwMCWmepxfQsLxD4VcAX4WjhaZ7wz7hUSXcqDU8yto3XcOa2CNl9jHYc0xoARL/oum7
	MpYq1Ong==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhMVj-0000000BqsA-4C4z;
	Tue, 05 Mar 2024 04:34:40 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2414::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhMVh-0000000BqqJ-1Gi9
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 04:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT5M4h85dbmX00VZP63SUDDPjf4JGXqGRJtUAIB5zQDwP0m/3KT2O7uv4dKfTR7ATSeYmCcFlUVwkD1qxmNNmNo7+5rJfE5DGghHTYCyFpzMF9tv+XCEbd5lswqmLJUKUwv+Vv5OyBaacVkEM+3llthFieD2hlgnR5gNzqTaC+/BheMHT9OQGHhF3N6ldyDOzhxVpfb1rFn7zxzIIvyzpxvGKs7vlnZjTPAnNU0zSps3mOHDsaRlEfOuGFTqVyPEyrN7KOAu5e0OZFPC8PKs910etf7ygH7eScYOu36zejbbnFNHY23LW/Tuljx0cSJmdDpVlBKPnetWTl5hZBBzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGCWSkO+daXJw9uZlsE+vsvBpstJfL/MYHfUAsSfpD8=;
 b=MF4Au6GVEpQyHlwbzDO5s+fk/K5ajZF9pavDkR01upu9hjD6qPRnr8ltApN1Ca2I8dSnsNEjVvD19KNDHv/cJz7+JORgpZG/cs7zcECIodTrrF06myOAbx1HoJurxNrlmqx2IyYAJeKAlJKND750SHn6ZglH8g8biXleT8+WI/shg06FBOeE68xxOQj78js4CibT1q+PN78+FX1FNr0kAJz7ukelKkEG8EMIS/WD/N5SVxu32dYGtw6/jJK01RvuYY6EwFKy8oMJ3IMbpbJPCzWtWdibryYwbxD05s9nFA8ofr/e/xjwXIsdBL7CC8rmQMcsWik5aQ5r80eZaDprqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qGCWSkO+daXJw9uZlsE+vsvBpstJfL/MYHfUAsSfpD8=;
 b=WW3522eWVav1o0lSHIxXxaQHiJ1ClQtP8uZBCihVmvfYm5U0TWvpOXJhFWup/s0tGmfReTBHeJPZRUNyinji1JY/yebjqlJxl5YN9KPfxkZEQt7TJl+tfFNWl6bm7I2JzefxFqXwQOJVTyfOs3qi7bGodEX06p5/SENHXc/6fgAWOIzOQE9teCN8vfoQKqoiJy0lTWpuf0zEK1l0NJjDYKfaxqpnCH1XCgUjqYjfKD0Ix1uGt8XSbFFd1ijYaqMDqTx+aTDJ8he1htg4Kp3q5AgLBQ8WfaPlfpUFWRmQnSneOB/aVaCFw4pW66Y9VV5X6ZU6ji0F/IIiJRr6kjRjhQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 04:34:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 04:34:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Thread-Topic: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Thread-Index: AQHaXWu3LWYv38OYtk+GmIdaKDPvLrEUVHEAgBRdhYA=
Date: Tue, 5 Mar 2024 04:34:25 +0000
Message-ID: <4195d4e8-a415-4b1a-a004-c009cca97623@nvidia.com>
References: <20240212042641.227821-1-kch@nvidia.com>
 <17c9eef3-38b3-4134-96d5-32501266915d@nvidia.com>
In-Reply-To: <17c9eef3-38b3-4134-96d5-32501266915d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4054:EE_
x-ms-office365-filtering-correlation-id: 5907fc75-3dc2-46aa-190c-08dc3ccd89c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ywou0KdbTQUOTPVbe4E2ZIUIwBn23pHISJLYVjUYf2TQ6baDtIdCT1tzdm89dC0B9b1zWBuSL3bqHw9PiDlrCon3F+9a0NTifASAkJMLHHs0wuMj+DesDKvRFulBGGZUTyu8iQIHm5pfnXu4ex27aUxNeTIuVOsmjdnSurlT0qxZqv8Xcz0gdgUG9alEoWeKQaBnQIfzJNdSmms+mDL+My6SMHMbWajl604gLJ4TSFPsBx40aZe6hOvRKPe5NgtG/9Ot3hH+4+lLFRHlNyk9USTfGcA91URawcBi7ZPQEJOpilS/xcwZgLaj7rQdobyt1zjj1wAGOz15mTMR9ELH5waB08iZ7BQYiiAfuA+Oyc+JZyhrOh7G2Jn6gOTEi+IIp7cjlZgc9+GP4G7nkjhkWXgBdcGTA8W5cvk57O2XJvPLejEB6iWbjgnjVg3LqeQStZZNrUQyKji/MjrK4h7EzrWHTHE8kMn1twqwwaqvbFFCjV3O8ktd6aQy8tjQXqt12qDp58Pm51TE++Cr0b+eZtPXCm/dQ+U25jtVhE2FxP6WyLGh7SpgDMXe24XKcerbBCMv3doIlXlXhpGDLif+6x8kgtBZHSFIimuQpE2d652UCIYNjm6F+n46bKJMgIKh7I8VJDGJiIry02z0PHbv3LPbR6y8503Uvtovv97/lexC6wPHkMTUmUP3SHejGWPWSkC2ZXbOgpUyuw5gsu+RrR0AP6gUZF9UvhIGgfLZqZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlZQSXJybHJzV256eGVvUTdSeEcvcG52SHNEUFRvb1UzZ1hQYmJZMFNMTGhS?=
 =?utf-8?B?R095ZzdkZXZibllOVkNzeW5uaTRLNjhaL0ZzVWc1dXVxc2ZjVjl3RDRKSjJz?=
 =?utf-8?B?b3VnL3RiaHlycDNVU2h0eDRHZU5NSVZhWWJIL3pzM3padnlsMWdFaHZ2Q0NX?=
 =?utf-8?B?bWlicXNkM0NxN1lwRThZbFMwQVdEb2txQ09Mb0ZFRlBNaWNqRXlXWkVyZERh?=
 =?utf-8?B?UVZUV0RHVUlrOXZGVi9JcFE0L2ZsNjhobysyVUQxR2gvR2k2TXRBMHIyVXJu?=
 =?utf-8?B?RTlYOTRDTlVYYktjNXpacHI2RnNlSGN0SnFKSTdZN3QzdzNhSmNrbTNvQ2lE?=
 =?utf-8?B?ZmErSGNucWtXZkVrL0pzeFhpeS9DSHEvcHdNbk1LdlVPd2JtMlNtRDdhNk1R?=
 =?utf-8?B?cVJjKzV0SkFyaEdJZFBTK2FZb1l1Yk9wbm56SkE5b3ljS3BadGQzR0FzM0dC?=
 =?utf-8?B?SVNWS0dURVhTV3h2eXZEVE5IbGRsOFJGVmhpamxmckpkMTRVVTlYZFE4aEtx?=
 =?utf-8?B?K0lnQXV0OTJsd1BoZ2xveGxQSHdhSi8zM0Y4bUdxbFE4clFobUVnOE1EZ0Jv?=
 =?utf-8?B?Q0RyOUxSZFRPZTZhMWcraGFWVncwMWpDdjUzb2hFUTFyOCttWVBSV1NESy9B?=
 =?utf-8?B?YStsV2VpKzE1SC80OUp2UkpOdjBzOVhrWE5FMThtdkVoNkRDVmZLS3NaMmFJ?=
 =?utf-8?B?ZFIzR3hXb2RpaXN2cWk1bXNLUDBNTG42S2RDeFNxbnJNZ0ZycHZaREZJdGd3?=
 =?utf-8?B?VHV3K3g1QklmbFhCZnJkeUV6cUJycmVJeTB1Vm9zMmo5Q1cydStHbkpneWhZ?=
 =?utf-8?B?LzVLUHFsdXhWdGVmQUZuYlh2Z3RCVmJKeUVRVGhZV1p0VFQ4MUcwNkV2TkFw?=
 =?utf-8?B?aTN2c1dDckp0QnZCNVVMSjdHbzFKQmtvdmt3aEEyQVZ1KzZTVEE0cTNwY0Iw?=
 =?utf-8?B?RVdKNmdFTnhtcTFzaS8vUis3clo5L3IxdG53S2pYVm5ETlFmWFF5UFNtdytE?=
 =?utf-8?B?Z2tDM24yUmJnbm16YXA5VVhUUWV3eFBSK3hFamxPemNERVIrc1YvL29sczhR?=
 =?utf-8?B?cW96TUpkUDNTUUJoRk5RdE1CRU5HTHhYV0E1dHhyRVg1aUkxdmpEM0drYmt2?=
 =?utf-8?B?VExtSFFTYjdRMnIrc2RvT3dZK092NTZFMUVTeXU1Yi9RcTJYQWczSEJ6bTdX?=
 =?utf-8?B?amhOOVRoenZ4RnYvM3dZV0pldFZRRFVUcVJzZzc1V0lTZjlyM3hkSkJzczJJ?=
 =?utf-8?B?ak9nWEdHbHJVcVFhTERoR3VrV2RSY1FDY1loYS9oNzMyb2ZKVEtxMnBwaFNJ?=
 =?utf-8?B?RVhLYU0zbHlKMGpVRGNIelNGQnY0Nmo2cmUzeXVlM0lSSjV5YzUrdXd1a2VQ?=
 =?utf-8?B?NHBtS2t4UHJvUXVlY011QjZwWmxETFphSzVvNytBR1FIRFpCMURXZXJBaFRj?=
 =?utf-8?B?akxaSFc0NlMrWlNvVTRkMnd3ZGpQSzBzc2FvcmNpSm8zZkpSeHFTQ2VOOUVJ?=
 =?utf-8?B?Sm9mZnNFMHNneEp0S2crSTBNRnZBNklId3dobXo2WWFCejlHczVkWGphb05P?=
 =?utf-8?B?WGJKY2ZmMjlnODZ2cVVsZmg0MGZXU3FFREtwNWx3azJVcTl4c1F1UWFsVkpi?=
 =?utf-8?B?SGU3S3VvNjFpL1dZSjJHeWs2UjN3dUFZbUFtUUJ3WW8yZDFQRDMyTWJpRGUw?=
 =?utf-8?B?Q3NEMTk0L2IwMlJvdlhKa05zZGtKaFBsVStpYVI5bisrQU9Oa3pSdnNSWlBx?=
 =?utf-8?B?YXVDLzl5dG43NTdzdFJ1dlIzT3pML3RZRFVpSGxBZ1hKTDNyNUdjODhWd1pp?=
 =?utf-8?B?Q2NtMi9kK3AzeUVvbldocDNtQ2g3VVVDYi9DMUdRKzQwclAxSi84THZXUUQ1?=
 =?utf-8?B?U1c0MjdJcENmaTlVZzArQXJzeGJMY0Z1bEZyWHQrV2tTTFRyZmFaUk9VaTdX?=
 =?utf-8?B?SHloY0FuazBuZkdjMHNDRXhrazA5Qzk2eEFiNkg2RGNYK01oQTBvY2RVNE8x?=
 =?utf-8?B?dlFaTzBoQVdqa2U3YTN0elhKR1dobjJabnVHSWdJb1BpVWhBcDZRcXQ0em5Y?=
 =?utf-8?B?QmY5WXZoVEFUcUJkckwxZkRYZTJMSXRLSHlkRXdNTGRmS2dMMHNHdGlQc3d3?=
 =?utf-8?B?MGVnZGxaTnNHZUcrOHRaRGNtLzl6SUU3d2UzeVJZNzRzaXVOOWFDZ1NxdTB2?=
 =?utf-8?Q?kvBFe9cV/lC48/hMifE7cMRIDsYRoHU7TLBcArtu6jG3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94EC3F2F456F034D874CF0976DDB11AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5907fc75-3dc2-46aa-190c-08dc3ccd89c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 04:34:25.6383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vf5CuFlOM+NqjgU0RXoQYoVtyZ4AfszTljxMFQoPL1jMyEwDQtI0Ib9ZgIUXpnxnktd2hZJLuLdQxUXUxVCatA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_203437_457367_2C83664A 
X-CRM114-Status: GOOD (  11.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yMC8yNCAyMTozNCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBPbiAyLzExLzI0
IDIwOjI2LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBOVk1lIGNvbnRyb2xsZXIgc3Rh
dGUgbWFjaGluZSBoYXMgdG90YWwgNyBzdGF0ZXMgYW5kIDEzIHN0YXRlIHRyYW5zaXRpb24NCj4+
IGFyY3MuIERlYnVnZ2luZyBOVk1lT0YgcHJvYmxlbXMgaW4gdGhlIGZpZWxkIGlzIG5vdCBzdHJh
aWdodC1mcm93YXJkLA0KPj4gc2luY2UgaXQgaW52b2x2ZXMgY29tcGxleCBjb21iaW5hdGlvbiBv
ZiBjb25uZWN0L3JlY29ubmVjdC9rYXRvL3RpbWVvdXQNCj4+IGhhbmRsZXJzIGV0YyBzY2VuYXJp
b3MuDQo+PiBXZSBhbHJlYWR5IGhhdmUgYSBoZWxwZXIgaW4gc3lzZnMuYyB0aGF0IHJlYWRzIHRo
ZSBjb250cm9sbGVyIHN0YXRlLCBidXQNCj4+IG9uZSBoYXMgdG8gY29uc3RhbnRseSByZWFkIHRo
ZSBzdGF0ZSBpbiBvcmRlciB1bmRlcnN0YW5kIHRoZSBjb21wbGV0ZQ0KPj4gc3RhdGUgdHJhbnNp
dGlvbiB3aGljaCBpcyB2ZXJ5IGluY29udmVuaWVudC4NCj4+DQo+PiBJdCBpcyBvZnRlbiBoZWxw
ZnVsIHRvIGtub3cgZnVsbCBzdGF0ZSB0cmFuc2l0aW9uIG9mIGNvbnRyb2xsZXIgd2hlbg0KPj4g
ZGVhbGluZyB3aXRoIE5WTWVPRiBpc3N1ZXMgYXQgdGhlIHRpbWUgb2YgYW5hbHl6aW5nIHRoZSB0
cmFjZS4NCj4+DQo+PiBBZGQgYSBoZWxwZXIgdGhhdCBhbGxvd3MgdXMgdG8gZGVjb2RlIGFuZCBw
cmludCBlYWNoIGNvbnRyb2xsZXIgc3RhdGUNCj4+IHRyYW5zaXRpb24gOi0NCj4+DQo+PiBibGt0
ZXN0cyAobWFzdGVyKSAjIGRtZXNnIC1jIHwgZ3JlcCBudm1lX2NoYW5nZV9jdHJsX3N0YXRlDQo+
PiBibGt0ZXN0cyAobWFzdGVyKSAjIG52bWVfdHJ0eXBlPXRjcCAuL2NoZWNrIG52bWUvMDQ4DQo+
PiBudm1lLzA0OCAoVGVzdCBxdWV1ZSBjb3VudCBjaGFuZ2VzIG9uIHJlY29ubmVjdCkgICAgICAg
ICAgICAgW3Bhc3NlZF0NCj4+ICAgICAgIHJ1bnRpbWUgIDYuMjY0cyAgLi4uICA1LjI0MHMNCj4+
IGJsa3Rlc3RzIChtYXN0ZXIpICMgZG1lc2cgLWMgfCBncmVwIG52bWVfY2hhbmdlX2N0cmxfc3Rh
dGUNCj4+IFsxNzA4MC45ODg2ODldIG52bWUgbnZtZTA6IG52bWVfY2hhbmdlX2N0cmxfc3RhdGUg
bmV3IC0+IGNvbm5lY3RpbmcNCj4+IFsxNzA4MS4wMDY2MjNdIG52bWUgbnZtZTA6IG52bWVfY2hh
bmdlX2N0cmxfc3RhdGUgY29ubmVjdGluZyAtPiBsaXZlDQo+PiBbMTcwODEuMDM4MzEzXSBudm1l
IG52bWUwOiBudm1lX2NoYW5nZV9jdHJsX3N0YXRlIGxpdmUgLT4gcmVzZXR0aW5nDQo+PiBbMTcw
ODEuMDQwNzMwXSBudm1lIG52bWUwOiBudm1lX2NoYW5nZV9jdHJsX3N0YXRlIHJlc2V0dGluZyAt
PiBjb25uZWN0aW5nDQo+PiBbMTcwODMuMDU2NzUwXSBudm1lIG52bWUwOiBudm1lX2NoYW5nZV9j
dHJsX3N0YXRlIGNvbm5lY3RpbmcgLT4gbGl2ZQ0KPj4gWzE3MDgzLjA3NTkwNl0gbnZtZSBudm1l
MDogbnZtZV9jaGFuZ2VfY3RybF9zdGF0ZSBsaXZlIC0+IHJlc2V0dGluZw0KPj4gWzE3MDgzLjA3
NjExMl0gbnZtZSBudm1lMDogbnZtZV9jaGFuZ2VfY3RybF9zdGF0ZSByZXNldHRpbmcgLT4gY29u
bmVjdGluZw0KPj4gWzE3MDg1LjEwNTI3MF0gbnZtZSBudm1lMDogbnZtZV9jaGFuZ2VfY3RybF9z
dGF0ZSBjb25uZWN0aW5nIC0+IGxpdmUNCj4+IFsxNzA4Ni4xMjY0ODRdIG52bWUgbnZtZTA6IG52
bWVfY2hhbmdlX2N0cmxfc3RhdGUgbGl2ZSAtPiBkZWxldGluZw0KPj4gWzE3MDg2LjEyNjUwNl0g
bnZtZSBudm1lMDogbnZtZV9jaGFuZ2VfY3RybF9zdGF0ZSBkZWxldGluZyAtPiBkZWxldGluZyAo
bm8gSU8pDQo+PiBibGt0ZXN0cyAobWFzdGVyKSAjDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4NCj4gZ2VudGxlIHBp
bmcgLi4uDQo+DQo+IC1jaw0KDQpnZW50bGUgcGluZyAuLi4NCg0KLWNrDQoNCg0KPg0KPg0KDQo=

