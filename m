Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B857FA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0pUQ0umwHkTW4cidv4pNu4MpfaNyN6zsokwkYexVtuc=; b=ukzxl5YLMpR7QaESIhCOX1zYYF
	SPL2nm/5I4WjImByA69XGtkFYlKj7P9ybxsQc7FyStTPJbaCeyAkskNGGTDyZ/jTKZjudHDYPs0iD
	ldbPFJZfry86BIkk97evpECUO+odlWRBYvcgyPDbmfcNm6WbAJ3C4uCLwSyGIavdjM5dkp7DrYOXI
	wlxCOMRKASs3hjYAT/daQI22USv4K2ZKPndjB6zt0YwP3cVe0dwXzArWCajBmvhRDLtUEjUOE1Pcz
	krxyuOkAetAC7hEyw6kfMGiTZzKkRRpKOaAZ8HPaPQizOb2ItD1gdSQ7QfRT2dm8DIXOetgi29obs
	wpnky3iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5vg-00EG39-PK; Thu, 27 Oct 2022 16:40:28 +0000
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5vd-00EG2V-U2
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 16:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBev9JqgVwTG1hA35Uf1thU5ovb4CItux109rysdg3b1cqQtMx00VX4iruX7rPW7F7ufd5WyVU6GZas8AcQC/vhrKo6rpf3qsVeUdis7eKjwpurKbbNH+kueJ7hVoS0VrOn6F925LLJQvbaw5A3fT3qezVyrDK2BDD3Xxe51PPloAoy+O6/WXKnrx9hvXsz0IO5SvZY+lnScpGfQ62M8jCzLYII94eRkT72V6M0FDxt9yo6d3y89M7ldVn8FXVo/N9bEbND4TXyfvabo42EBCShcaOZ9znvSO9lpFPkqsnISlb1Tz6aIlfdP7DlW9NIjOT8LNTJTdKm7sae/uq8jdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pUQ0umwHkTW4cidv4pNu4MpfaNyN6zsokwkYexVtuc=;
 b=JuVPTI9VFQnyOwxQRECKYXROGWvlkPaOhBhdlMXm1TlQxE5ZVEX8wEvTU2NHUO2kEPYhKq7qBHg2ejKD7eCzq7XVdTC5QNs1CsanWM/z6PZU8q+0GiFe8atqwuEcbSZNgu/B5VpF7+uE1R2DktYbnp3EJ6j9wzU0bz1Vgh4QumyBlccUA0XcOL/dnQMFHgGieYlKXJoaMXdaw1p0hMWqM61TVUvvRgNV2q0f3CLU/xLpcFNXP3k+xncIOGgDvCWortdtXU0oxT6/H0jfOCRdaNNjf/CT0GljUJZRGsdL0BEXjwsWM2qjiRqstaWUc8CBrKivyIqecHLdYxdNXcUhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pUQ0umwHkTW4cidv4pNu4MpfaNyN6zsokwkYexVtuc=;
 b=BwqTDv0Crq4as/M3kTTN0GoUsGxkALcBnCg5hCjtdGCL+h//YR4juzjZB9wJxaw7UNoT/o2vpvkwB4hPwMiplvmsR765IVdaPQ9sXb2zOe/pSeNNtBaVlvpHTV/r54XCA0mc77eT+PvYW7PWFGIn5bVmon185T260tCUNoEB//lOqCXss+jBdt/xYukXpMP8RcXPXTxCDUzyGT5VUPYF4NXyFIXXb3q7iSbM6xnK3FccwGwIaUjUmLUl9HL42vAFywb+yq2h+Pfz61rpb1JcQcd14ZTJkSGNWcwUJcZgN/iwyepEZmug17UI997VRqviFqOGIJLRRgQu9wcIiUDZzg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 16:40:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 16:40:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>, Keith
 Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>, Alan
 Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH] nvme: quiet user passthrough command errors
Thread-Topic: [PATCH] nvme: quiet user passthrough command errors
Thread-Index: AQHY6V2S49CphEinZkm15ANzyd7xQ64hutIAgAB/dgCAABydAIAAG/mF
Date: Thu, 27 Oct 2022 16:40:19 +0000
Message-ID: <99248CAC-D39C-4CA8-BB8D-2FF9B3E14C3C@nvidia.com>
References:  <CGME20221026171201epcas5p1f6333717c7f12b5a8fe362cf09c5447d@epcas5p1.samsung.com>
 <20221026170715.2657664-1-kbusch@meta.com> <20221027054136.GA5939@test-zns>
 <f49bd086-fe3a-670c-13ce-80f06a855166@kernel.dk>
 <Y1qc/IyQzLUxYWTC@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y1qc/IyQzLUxYWTC@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB6630:EE_
x-ms-office365-filtering-correlation-id: acfb1a80-3cf6-4ff2-1aab-08dab839ef7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  4RrT6YOdo27Jp3wYIau3SOVUrTVdTdfW9kTMXQtCzholWeXo4+iK4UoeIJYSUwyWreldVmVUuku4KOtLBklNHVWLujBEqV7M+Ll+JogEtR8IcSQIU+0XYMJMfWfxr0GKFdQw81GNyNbDz4tqTydvBQJHvIfawo5iin02iIJ7NTLYdGnneRXmk3AOOhQnnDSrhhVFNhda5bH/yxYyfS9weubz2Zh92KQbrdXiyBaqzqSHVoAXn6vF49ywNgxoJRh1XOFmfFWQ6Q9yIWjV3v3GNNwMHq28mlP6aSZAZ712TNYuZ3OidLoy8T1alUCDwNEuDJmx6Fij/lJB/n39cExxE/FlYLxxpw6SAHpjTXSaVLVjmeMjyUq7YMGxJmOetaWbtMLLAtyyMXF+RMvD1IE8L2fo0cOHcEa24I7wS/0zrnne9bS1DKlLeF1GDpfhLG8JmwMwyOw+6Pt79gQcrN3tpUTsK5XVlylM64XfZYTQdqWg2cMDhCUKJ/Nrh85+khICY0ZFuUwyVtKoI29BQXOK2PoyBdFdqOZqXWUcLWQclQ6p9LRRYZsfmql4cBmn4F5NdU7dyLfdj9kkD7wxCJOs2yRuLcnLKXiyNa7fcteiV0ZvRgpMtC2c0RJXO6ivsod3kt4TrKX0kEvME8WkPYRvxlyjJyptSifqVcGfa8vOSoF53mv0W1KF5Stxoei02hFZpAcmrfVMPcZObkARHBrUqPACEOX+meLeWQcrTVIK4POdkmRbUvEZNmgaa6+ylVUywNAg/O/+36ZI57O/58JI9OrM9MfhK2XAWyUkcsc2HDI=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(122000001)(5660300002)(8936002)(66476007)(33656002)(2906002)(64756008)(38100700002)(83380400001)(91956017)(54906003)(6916009)(53546011)(6506007)(76116006)(4326008)(66446008)(66556008)(186003)(36756003)(478600001)(66946007)(8676002)(6512007)(316002)(86362001)(6486002)(2616005)(41300700001)(71200400001)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UmpzUWdMbXNrYTdETy8zL09HUW1tUFZGZlNYUjQ4cDZhV1hTVkpNT0JDdkNk?=
 =?utf-8?B?b1RyZmMzN2orcTJvb01ZWE5aejQ4Wm1BM21vcHlwQnl0RitGMlNacUhQQU9r?=
 =?utf-8?B?MnJzbDlCUVRibUhwUHQrYzNGb2haMHZ4Yi96NHZ1N25NOC9KMkcxVVFvWHRK?=
 =?utf-8?B?Z0o2YitTd1ZzM1VCcTNBTUI2Z2RFMTBOZ01Od09qNmp3ZHlFQ2o5Q2hMUmt0?=
 =?utf-8?B?RE1xTWdPa3BTSnlVSUpic3RERkYybmx3MnpnQWNXVnRtMHJxM1VPSk1yWkR4?=
 =?utf-8?B?T2cyZTg0bkFjOVQ2UTZwVnNQcE1Ka0FRUmRlVy8wR3pEWjBwQUFyU3Bzem5K?=
 =?utf-8?B?Ylp3QkJzejlMRDZ4R3prV3RscENmOCtiRHI0YnVBMG9NUXRNSXlvbVhmc0gx?=
 =?utf-8?B?b0c5aDhpd1QrSTQwWmZFSGNZZGNlRGxUdDF5Sy9hNFpPdXpmZ2YvT1lOT1ZZ?=
 =?utf-8?B?T2RyTzBHeG5JMHYyKzZWYjkwV0s1Z1JyRXA4STdSWTZ5M1BxUk9XUUIzRnk3?=
 =?utf-8?B?cmEzd2c1TzZ5SkVwQTFIbldva0pINDg2Vzk1Mmkrcy9oajQ3elBCdkMvVmxK?=
 =?utf-8?B?YmRaNW5QQ2FYeHFkdWowR0FKUDVmc0MydFV2WGJTTnZJVS8weFZ3QXR4cHpu?=
 =?utf-8?B?Q1BqMTJ3ME14b0p5RnNnVWI1UzQxcEozdTEvYnFVaWlmMkxGeC84b1B3cG5a?=
 =?utf-8?B?cHlBVW1HS2JibEIwMWpPRVhIcTliVmsraHlMSnRSajM0UHRWSWk3KzFFcEdH?=
 =?utf-8?B?cWN2L0gxT2hjQmwyRHppWjFsWG1pcmpUZ0NIbU83NElrcUxzVlIwTzFXaVQy?=
 =?utf-8?B?d1NsemFVQzdvdXg4ZDEvRWcvVEk1MlBibkpJT3lzdmoyYmQwcDBLVHhhSXpv?=
 =?utf-8?B?Q3d3aDJUejBIRFkzNFdhS215aWdvMndXcUJYZkxEN1BBcnM0Ui9tcmNub3Bm?=
 =?utf-8?B?bk5xdlpBdE9MOUFCYTZ0b2hoREViYmVuRUdIZ1RWdW5xWklVTkNlWWorbyts?=
 =?utf-8?B?Rk5ZOUdHL2tvdUsxUFZUaVBSVEM4NjdpL1JtcGVPSWpzNHh4d2RvcDMyTERE?=
 =?utf-8?B?N0FTT3BRMmg2cWlZTE9zaE1sSFkyVER3OEVrRVJITXVwUWtPWkVvbXY2RkhM?=
 =?utf-8?B?U1FXUW44ZldkdytyV09KakNXSzg2WkVXcWE1a250d2hNR0ZzOENzYWNEdDRv?=
 =?utf-8?B?MWZNTDMyNVdTV3lWYjBDWnZYQTNqYkNERjFYZWpmOUI2Ty84aUtzSW0vazZo?=
 =?utf-8?B?d3l3Ym1QUVFTUDN0bnJTOVcrdXVtRGx1YW9xekhOUVhVL1Z6K2tKelJzZHE2?=
 =?utf-8?B?K21HQi9wb1RsckRZczZmNHZvSnJlMDI5VkJZK3JrbWJpZkFLOUdTSDg1ZWxD?=
 =?utf-8?B?SnRUSGpyVDUxUFM5TXNyR0lheldMMHByRVNibGI1R0ZoVFk1U3pkbkFJeWpZ?=
 =?utf-8?B?NEY5RjNqSEluczQxSmc3cVBCWTBtUUd2R1hxRnYxKzRNaSs0SkZmZ2ZzaHUr?=
 =?utf-8?B?Qi8yTmFpWVNlWm4rYzNZbVEra1BldVduRXV6VU1CTVA0eFdmTytNaWhzaGZN?=
 =?utf-8?B?RnRLTjYySFNGMnRQQUlrOFg1YXJ6Z2pzZzNMOFArUE9ZTStldkZTU1lLWGtR?=
 =?utf-8?B?QnBQSkJVemRVYTV5bEdBY25RVkIxQ1Z6THMwRUVSWFVFZkQvUnRoeHdqK1ht?=
 =?utf-8?B?Tk10NXJ2am50bFlkU2xiMko0bUptYVVVMFVvNjNBT2pyUDJFV3RGZ1YyeVdM?=
 =?utf-8?B?UjdEbGY4TjEzT3JFcmU3WW0zdXdPc3RSVmpvbjZBUkZVOW9OOS84YmE3Qm1I?=
 =?utf-8?B?RkJ1Q1JhUjdaZlpWT3oyL3N2VjM3d1BuelIzekxESHpkUkQrK3ArNnAyRHFt?=
 =?utf-8?B?c1JSUVhxUDRlelBNZ2lOQTMwY3p0c2gxTlFXbVluWDhPd0IvdjgrZ3lIaWJk?=
 =?utf-8?B?cGNxcUlhVW1LQUMvQzJCeVQ2bkNBZmVDSGhpQnorb1pDQjNYS0Rvdy8weXU4?=
 =?utf-8?B?T0pxSkJveU5TRk50MEIvVUJ0SzFRWW1EUXZCL0QxNXBXQ1FOKzVqVE8zYjVa?=
 =?utf-8?B?eVZjaW94R000MmpXSU9ESEFORFQwc2hyWWd1MEI3ZUxobWNoWEJqVXRpUElv?=
 =?utf-8?B?Ympad2JYeGhTVlF0NlIxL3ovNlZGN1RWYnA1RWNCdkQ2aEUveXJwNUlOcTFW?=
 =?utf-8?B?OEFQeHc1bUdLZXRKelh2VUVvWlVER1hwaFFPc2hjbXJMdFB4TTB4c21PbWMz?=
 =?utf-8?B?L1VKZnFtTk1PYXAvVm5pZzJrS0tnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfb1a80-3cf6-4ff2-1aab-08dab839ef7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 16:40:19.6543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xnuKqI02VkDs6VXyK/Mxe2wHMEyyxjBBV1esr7pNSYNeP4pGtQkO9f/x0iKHaclddEiuqKbMDeU9FhTF9awQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_094026_328958_019416C7 
X-CRM114-Status: GOOD (  15.89  )
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

DQoNCj4gDQo+IE9uIE9jdCAyNywgMjAyMiwgYXQgODowMiBBTSwgS2VpdGggQnVzY2ggPGtidXNj
aEBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFRodSwgT2N0IDI3LCAyMDIyIGF0IDA3
OjE3OjQ4QU0gLTA2MDAsIEplbnMgQXhib2Ugd3JvdGU6DQo+Pj4gT24gMTAvMjYvMjIgMTE6NDEg
UE0sIEthbmNoYW4gSm9zaGkgd3JvdGU6DQo+Pj4gT24gV2VkLCBPY3QgMjYsIDIwMjIgYXQgMTA6
MDc6MTVBTSAtMDcwMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+Pj4+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4+Pj4gDQo+Pj4+IFRoZSBkcml2ZXIgaXMgc3BhbW1pbmcg
dGhlIGtlcm5lbCBsb2dzIGZvciBlbnRpcmVseSBoYXJtbGVzcyBlcnJvcnMgZnJvbQ0KPj4+PiB1
c2VyIHNwYWNlIHN1Ym1pdHRpbmcgdW5zdXBwb3J0ZWQgY29tbW1hbmRzLiBKdXN0IHNpbGVuY2Ug
dGhlIGVycm9ycy4NCj4+Pj4gVGhlIGFwcGxpY2F0aW9uIGhhcyBkaXJlY3QgYWNjZXNzIHRvIGNv
bW1hbmQgc3RhdHVzLCBzbyB0aGVyZSdzIG5vIG5lZWQNCj4+Pj4gdG8gbG9nIHRoZXNlLg0KPj4+
PiANCj4+Pj4gQ2M6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4+Pj4gQ2M6IEFs
YW4gQWRhbXNvbiA8YWxhbi5hZGFtc29uQG9yYWNsZS5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+IGRyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyB8IDEgKw0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4+Pj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+Pj4gaW5kZXggNjg2YzU1Y2I1ZDFhLi5kYTg3NDE3
MmEzMWQgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4+PiAr
KysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+Pj4gQEAgLTExNTYsNiArMTE1Niw3IEBA
IGludCBudm1lX2V4ZWN1dGVfcGFzc3RocnVfcnEoc3RydWN0IHJlcXVlc3QgKnJxLCB1MzIgKmVm
ZmVjdHMpDQo+Pj4+ICAgICBzdHJ1Y3QgbnZtZV9ucyAqbnMgPSBycS0+cS0+cXVldWVkYXRhOw0K
Pj4+PiANCj4+Pj4gICAgICplZmZlY3RzID0gbnZtZV9wYXNzdGhydV9zdGFydChjdHJsLCBucywg
Y21kLT5jb21tb24ub3Bjb2RlKTsNCj4+Pj4gKyAgICBycS0+cnFfZmxhZ3MgfD0gUlFGX1FVSUVU
Ow0KPj4+PiAgICAgcmV0dXJuIG52bWVfZXhlY3V0ZV9ycShycSwgZmFsc2UpOw0KPj4+PiB9DQo+
Pj4gDQo+Pj4gQ2FuIHdlIGRvIHRoaXMgZm9yIHVyaW5nLXBhc3N0aHJvdWdoIHBhdGggdG9vPyBM
aWtlIGJlbG93IHBhdGNoIC0NCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvaW9jdGwuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2lvY3RsLmMNCj4+PiBpbmRleCA4MWY1NTUw
YjY3MGQuLmE5MWNlZmMzODUwNiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9p
b2N0bC5jDQo+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvaW9jdGwuYw0KPj4+IEBAIC01NTYs
NiArNTU2LDcgQEAgc3RhdGljIGludCBudm1lX3VyaW5nX2NtZF9pbyhzdHJ1Y3QgbnZtZV9jdHJs
ICpjdHJsLCBzdHJ1Y3QgbnZtZV9ucyAqbnMsDQo+Pj4gICAgICAgIH0gZWxzZSB7DQo+Pj4gICAg
ICAgICAgICAgICAgcmVxLT5lbmRfaW8gPSBudm1lX3VyaW5nX2NtZF9lbmRfaW87DQo+Pj4gICAg
ICAgIH0NCj4+PiArICAgICAgIHJlcS0+cnFfZmxhZ3MgfD0gUlFGX1FVSUVUOw0KPj4+ICAgICAg
ICBibGtfZXhlY3V0ZV9ycV9ub3dhaXQocmVxLCBmYWxzZSk7DQo+Pj4gICAgICAgIHJldHVybiAt
RUlPQ0JRVUVVRUQ7DQo+Pj4gfQ0KPj4+IA0KPj4+IExvb2tzIGdvb2Qgb3RoZXJ3aXNlLg0KPj4+
IFJldmlld2VkLWJ5OiBLYW5jaGFuIEpvc2hpIDxqb3NoaS5rQHNhbXN1bmcuY29tPg0KPj4gDQo+
PiBBZ3JlZSwgd2Ugc2hvdWxkIGRvIGl0IGZvciB0aGlzIHBhdGggdG9vLg0KPiANCj4gT2theSwg
dGhhdCB3b3VsZCBtYWtlIDQgcGxhY2VzIHRoZSBkcml2ZXIgaXMgc2V0dGluZyB0aGUgUVVJRVQg
ZmxhZywNCj4gd2hpY2ggaXMgYWxsIG9mIHRoZSBwYXNzdGhyb3VnaCByZXF1ZXN0cy4gSW5zdGVh
ZCBvZiBkb2luZyB0aGVtDQo+IGluZGl2aWR1YWxseSwgSSdsbCBqdXN0IG1vdmUgdGhlIHNldHRp
bmcgdG8gdGhlaXIgY29tbW9uIGhlbHBlcjoNCj4gbnZtZV9pbml0X2NvbW1hbmQoKS4NCj4gDQoN
ClllcyBwbGVhc2UuICANCg0KLWNr

