Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED45C47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 06:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EXKuQGXQ0OMjfXFqb5eAIWJvjAmNGWpy7mzo+MNUjQg=; b=cXOt7e3q+qRpn5QeUw9nWXB+Do
	XsCFwWkn84NcBAWGRJqOo9S77L/LDCAo62f1xrKQwfdsTB0kaBk8jzEFIiYHLn4Vlyhx1lRKoTYQM
	rwnF1B1uRHz5R0cu2i0H4qda2Lb59MnvFj+60LJmFoskQqsaENPJVJ2E6+IWQChBfkaG63ER3D2Yd
	SSew+aThrmIoNfThe9Aj83/095F8GHOJq5UAFjo+6qRUBpdLimwYZ/pNg1VlTt97IJQQ02WDXqwlK
	I8hEsUkBMMBctm0KpJk0ouaG9S65hqrv/k42xsQmGizK26b02fAqiEoo7iviT6dNlBl+ifdIYBkca
	f97saxFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPd0e-00B78c-01;
	Tue, 16 Jan 2024 06:33:16 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPd0Y-00B782-1E
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 06:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH9VIcqYM1LfDimo6LD/5SEJMNXFdEOwBt+dZdcw7dGZpLDsOi74LMFO7EurIIVhUjm3xG+guggRG1kAJu5WYCH8JQzzt602e6smPVvQ6ACrobW0cpLdwooixkqOdT0VNO/W4nNVHNkHRsMiGt5LvasuQ5m4XglVgfBIbTTNZQ35zk5wvQ+dHu0cX6bXbAWUk/EtqpxTGTQba7LAP6Ejna3BDF0LuP0pHiSfcKMIj5NLiqdhl8+EI7MC1NjA8UeZbjchM8rWZ+jvE6ObLhLnL4i3sPvJfeqU+VWboEx7ATbC8hDAqoq5ED3XAHeZ4YTY5BmwnMkolnm8ThGAlfrQRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXKuQGXQ0OMjfXFqb5eAIWJvjAmNGWpy7mzo+MNUjQg=;
 b=oFEap1S+LCqbucQFCNh59v1+som53MCmA8Ah7SyAyBDsQjQkJEomvjCgs1BikCGyNbYptTNYUCFCc9eJ1dPE6W1t6ILuqXlRnQkkX4i/Z8GHgkNwsGyYtMV7tY1tNHJjKYyFPGPslLlAZVyEBVPxHCytyL9qb0n9elxiMa/WBfZFEvq+iPx6cOS74D2tEmontYnzjb3r/pAtQvj4QU38sRxWz8U5jkdVylXFBn74yv3+ozfpr01QGsPs8nzmuU7eAwd0SPMEISrRAh/N0w+DoMU2P4o23PdQtLAuvBgBwA0eh8G2VnBSbfZooKpFTOt7TZAfvI6INrESIigMfhBBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXKuQGXQ0OMjfXFqb5eAIWJvjAmNGWpy7mzo+MNUjQg=;
 b=Tv4kv3epNyxSrbAUeG9VD6SxDCpQxZN9TtFvoEQoav8yE9NqSJwUmRYfx3LzwUiUc1VgtRLhRMiDALTYT6++Xji3MjAqvOJcktENjowxB/XRGEUa+PuSnB5dnt7Z+qTdTHDiAX+xoosBkt+W102F3prHfZgvAq3jU0ym/LA/yx/kMvACPfkNtR0RZiKJ+DUqxi8PirGU/ZVK4bCZ5fHKEoAAyadL2qPoUUIb6E1EsCCxjEjBzt8rgavthdRyNa1A7s5NWA21jVqkWZ0PEdjTCJMuck6F4pmN72BrERWIyH1XvBDaA2UNL2lcC0H/ufuNAebqUFaAlLhbEaHyKCSLmg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 06:33:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Tue, 16 Jan 2024
 06:33:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V8 1/1] nvme: allow passthru cmd error logging
Thread-Index: AQHaRCI5o/0gWRRNpE6eYNPv+sWFV7DcA24A
Date: Tue, 16 Jan 2024 06:33:00 +0000
Message-ID: <67007392-75a2-4a66-8a80-010fd7fe377f@nvidia.com>
References: <20240111000855.1800481-1-alan.adamson@oracle.com>
 <20240111000855.1800481-2-alan.adamson@oracle.com>
In-Reply-To: <20240111000855.1800481-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6323:EE_
x-ms-office365-filtering-correlation-id: 0863dc55-20b1-48cc-3733-08dc165cfc66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FsSKutJMDCJuJsnf48eTxwD6/1MU0718Ijlw0d/zInW4pLsOw/PD5UyA+hGUN7oxRDuj5yrnkJ7dN3/6jz1DJNh01k9tDXClOUCh+HZyesMxZf4io711lTQ51QCNZFiOIZA2gE6Uy7MurIOHL+8kxhYPODRr+XSBJfn8iNwtVtUfBVdaaE8hcjyVJIsEPYkWj6n4cXVyMb3VmBEPOO743v9Dyex+jHeWI43TvYbsl1ed90h5CfxNaFPD2X7vKlrBMgGsKJXK7pLOXXMu1i/k5EpvG/khG32oNbnWI1Nx3lIYZfM4okoqNV6poZtO22nAeqxL1cG/2OYC7Q+WC8sckQ25s1XIfAUazIW7ZRjZlY7dX2P7Y7Nsp/H1mBaH9k9EJWL5LUs/iPmJFJVpwumN6OWF8Y/BYDLD9B0Md2ogreqK0YU0jbBUyYCDrPpQI90TyY/DWKeZNkqRtG/zKL9LB8gIRoxGJFadKTfp+YetGtLCabcESc21QogLu70y+CWndnQJ6iSccvp/KJvV4wACsNDgYyLedSq2UzkouIsRyPCm6XrJmXX68TGqBEyf6F+2uzWt7iCcmiZ43ShptdSjzPTk8PVh79szCjljaj1rHUOoN1WB/5rTYDrNr+hubBTNYxP5boligTVsItUGizdCSMZ+alEmEH0N9sEBeMf3+cZzWdG4yM3bsy1Jpas7PHu27dqU0XhOEcqJXAxc1pJUyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(122000001)(38100700002)(36756003)(38070700009)(31686004)(54906003)(478600001)(6486002)(66946007)(316002)(91956017)(76116006)(6916009)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(5660300002)(4326008)(26005)(6506007)(2616005)(4744005)(6512007)(2906002)(71200400001)(86362001)(31696002)(41300700001)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE1wVVJ1YXB2djZneUJESFdVR0ZiSE1GS2NhaURVMitBdStUV21lVlB1M1Z5?=
 =?utf-8?B?Z1c5NkZCREM2N0prK0VJcDBRVUpMR3lOdGxpWkN1L3A0TmE1RTdhdGlZNXBa?=
 =?utf-8?B?Z1RDcHNwUG01QmlMVm5yeDdOYVMvVVZpYVFBTWd4SUR1T0ZKb0VuUnovQzRr?=
 =?utf-8?B?RDFrWmc4aXYvWlVWNEIyUHdhRGxhZzRnUVB0YzQvTkY5V0VWSE44c2k2bGJT?=
 =?utf-8?B?UUlteVd1Tkt0U0xlb09leGtRanExeXBkOXVZZ0F3Z1ZRUm1zd2ZmaG5xZWdL?=
 =?utf-8?B?eFR3ZitPbGE0U2VweGtGbFBQQXQ1L1l4Qlk3MWtPb2MzQnd5a3B1Wi9YdWZ1?=
 =?utf-8?B?M2ZUVFVzY2p0bXNZbXFwZlR1VytEZ3dUdjNHRzYxUmVac2phVC9PUVNPNFFs?=
 =?utf-8?B?R0NibnZqOVZ6TytZNkcyQzJtTXk5ekdjM2pEZ0VoVHhka1draHB2NzdaQ3I4?=
 =?utf-8?B?a0REN0JzM1NLUEo4Z0UvUnZISjk1b3hRbVlmVHhFZmhmeWkwQkRVSDFqTkx3?=
 =?utf-8?B?NTZ5aVpuNlBaNGZZWWpXd3pkWGVmSnE1V0JrTHQzY2xUZjlBdmlFVTdxcjNH?=
 =?utf-8?B?TENTbzZiUng4KzBPeDNUL2FXcTEwOS90cmdjMk00ci9zL2xlZ1VHNjVIWkhK?=
 =?utf-8?B?WTlibmV1dUlZUzNDU0I1YjZrK2Zldm1HNG45R2ZXQ0RPNTU0dEpCQWFEZVNq?=
 =?utf-8?B?VnNPYUJBdTl6ZTJIQnA5azlMOUdEdHhGMGRtSithSVR4MkpORnVHYXhLbkt4?=
 =?utf-8?B?Qnd2L0Y2TStyRGFGdTh5VmZnR1BwQTdnaDBWL1ViV3k5NkNNRUxNQURCaUZn?=
 =?utf-8?B?Tis0YkRFQkVHc3RQTHdpanZjbHM1T2Z0c2N3c1p0cEtxTEM3V2ZYYnF4Nm1s?=
 =?utf-8?B?a3ovbFhNN1pyM3hkaFJkSjZwc1NEdUVsTEtkY1c4WjA2ZUhDL2dSMURXUDVu?=
 =?utf-8?B?RTdGNU9uN2NRbVo0S3JwaGhDbTJOOEJINDJIR0diR1hLS3RtWk1oSElCcHhR?=
 =?utf-8?B?S0pET3luSDB2ZDI5bEVaZ3ptVk9sM0VnbjNrU3RvZDBvZHh5bHQ0N3dYNzdp?=
 =?utf-8?B?amxlU1hpTGZyVEhVZHdvaWF4ME1DSExJT0xaUDdvQ1kwVFZycjA0VlFMK1JV?=
 =?utf-8?B?a2k2bEhqaEdjOTZoZmpkYkZ1ZHhQVkZtZGt2NElJWitab29rNkRUT0hocE9n?=
 =?utf-8?B?STF2c1BLbVZZVkY3Q2hnVytKT2tjbURaZGxxc0hOVkxqK3htYXk4Y0FidWhS?=
 =?utf-8?B?dVJyR2NCUk80cVVBOWhVbTJyWFhpL3Y3VWYyU20yQVNManN1dnhxQXJQWHFJ?=
 =?utf-8?B?YUF1T3FpWGNvZjNRREhtTlNDY1RzY2xjQUR5bTBJWWFKNXBBQUpTdFRjWTcx?=
 =?utf-8?B?RFlvREw0R0RVcEUxNXJVMVIrQ0FXQnBFOEdKczFmN1c3SUtyc2hCb1FkZHBG?=
 =?utf-8?B?NmxwdjYwN0VlZ1NoQUJsWEhWQXZXcVdhUFV5ZGdnaUQ1c3BvU1lPaUw2WEJC?=
 =?utf-8?B?THJGcWF0bTdvMjlHUzFYZjM3Y3VRZmtxd1BKM29oZmtJSktCUkNpa1hHNjM4?=
 =?utf-8?B?clNZVXZPL05pNGNUTVJtZEsrMXlyM09SOGFvT0JCbkd5OUp1V0djWGJpcWRu?=
 =?utf-8?B?aGZXRWU1cldiU1h4RXJpMUF3NFo3ekZkUkEveW9XWkpFMEkvZUIxVEo0S2Q0?=
 =?utf-8?B?OTFrWlJEUGU1TVV4Sk1BbGIzc3hNdmwxR3BxTGJkVjgrYW40VTdBL05pdEwz?=
 =?utf-8?B?Ync5YU5GTEVHUEtjWlBEazlkRTkveVNtKytEVDVPSmRDY051Y2RmVndPbHc2?=
 =?utf-8?B?eGFHMXF6cHczZzI4YlN5RE5DY1FnTm1lZHlyMnpkeFNKRlNTY0gwME9Fc3ZB?=
 =?utf-8?B?YjJuY2hPeXJQYngycGhFY3c2dmhSVXNkdzl3SW4yMlBib0gvYU8rQTJxaXpr?=
 =?utf-8?B?a2xLbDdWZWpjalBwR1diclRYclMybUdQUVNrdnNLWDgwUUJHdG9EcGJ5RHUy?=
 =?utf-8?B?WkVTdnd0cVBBS0N1RUc1WUZpR0hIMGRjejUxOFEyZ2tKaWUxTlFnRDhxYmxR?=
 =?utf-8?B?RWJPdTNJNGhOeWJzTWpNc080dFNmek9oSkJXN3Nxa2tKVnovUDhUUnFQNnI3?=
 =?utf-8?Q?OqL+LRH//jo6F6qghUeqeqlPQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CF93E44578E3D43AB0D7D3533B1F7BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0863dc55-20b1-48cc-3733-08dc165cfc66
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 06:33:00.6838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiVgEsWVwksasi9WyywwwkdjpZt1WecCaW5tStq6qALmP1Ok9/hxILXdMHvZ3+xWnZB3FviKZHFX5+bSFDubDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_223310_460607_6522CB56 
X-CRM114-Status: UNSURE (   9.79  )
X-CRM114-Notice: Please train this message.
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

PiAgIA0KPiArc3RhdGljIHNzaXplX3QgbnZtZV9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWRfc2hv
dyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICsJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LCBjaGFyICpidWYpDQo+ICt7DQo+ICsJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCBkZXYtPmxvZ2dp
bmdfZW5hYmxlZCA/ICJvbiIgOiAib2ZmIik7DQo+ICt9DQo+ICsNCg0KQ2FuIHdlIHVzZSBmb2xs
b3dpbmcgb24gdGhlIHRvcCBvZiB0aGlzIGFzIG1vc3Qgb2YgdGhlIFhYWF9zaG93KCkNCmZ1bmN0
aW9ucyBpbiB0aGUgaG9zdC9zeXNmcy5jIGFyZSB1c2luZyAiXG4iID8NCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L3N5c2ZzLmMgYi9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jDQpp
bmRleCA4MjE1YWJhYTY4ZTUuLmNlMDIxZjQ5OTVlYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3N5c2ZzLmMNCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3N5c2ZzLmMNCkBAIC0zOCw3
ICszOCw3IEBAIHN0YXRpYyBERVZJQ0VfQVRUUihyZXNjYW5fY29udHJvbGxlciwgU19JV1VTUiwg
TlVMTCwgDQpudm1lX3N5c2ZzX3Jlc2Nhbik7DQogwqBzdGF0aWMgc3NpemVfdCBudm1lX3Bhc3N0
aHJ1X2Vycl9sb2dfZW5hYmxlZF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIg
KmJ1ZikNCiDCoHsNCi3CoMKgwqDCoMKgwqAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCBkZXYtPmxv
Z2dpbmdfZW5hYmxlZCA/ICJvbiIgOiAib2ZmIik7DQorwqDCoMKgwqDCoMKgIHJldHVybiBzeXNm
c19lbWl0KGJ1ZiwgZGV2LT5sb2dnaW5nX2VuYWJsZWQgPyAib25cbiIgOiAib2ZmXG4iKTsNCiDC
oH0NCg0KIMKgc3RhdGljIHNzaXplX3QgbnZtZV9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWRfc3Rv
cmUoc3RydWN0IGRldmljZSAqZGV2LA0KDQotY2sNCg0KDQo=

