Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDC7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WLKPZy+Jlr1Xx2q0yXtMCZwDP9Et38naaSp35UhAMTY=; b=Ap0+qrAvjeljtxrZgrGiauLpDa
	YwPQAoDBwfe4uqnDRbltsnIFjB3GtYPuQW3Ed0vcgYdtSkNGmEDTKBABsck+JzrMHUDtOdLY/Z9vr
	tp8+/9930Iy/BIrlgbxTq8+og1ZpQ4O0x+B/kkmPNOJJ9GS/Z7sqzP/xQ33PcqKdLY3CveQxSKOBk
	r+itA2pzoRN7X4tIPQdRlODIf4bwF0yuyvaZCd8SpPYrJHrRXyZZquQ5N51xGJF5U//LqAlgFLxeU
	aFeiU7FqZLfDn5Yx+R0QHq75FplkARFyN34wTo/VxF/U1TRWW+4yrfnjhreTlfx1H4JR9qPAhFLAB
	EmBw/77A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHaML-00Fpfc-9E; Tue, 08 Feb 2022 23:57:21 +0000
Received: from mail-bn1nam07on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7eb2::608]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHaMI-00Fpf3-ET
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 23:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+mdOxM/HhuYdwMpxNqwkLb/JG+14CBdkXvIMA7ssRdrJwMC3+kYDQxyRQW6Zc5vZNKolYanphZZym1ze8pEppxXrs7oaInF9Paajb4D5GbAhPb7LE8Lb3OV990HgL09dAIpjrtutWbrHWzfQ6GtyCqub1xXJzFvNZ+uHk/AobqgtaPSxaXJEfpTr8yDtgF1OmDCVTm5vjASBNLZB0MhMVBSgGoSOnQvsWdPBnPYW/ihBWFkq1kvMJ7tzsQ+W+H6D+cpCDd784hHQyU2cKVq7VESxslDeQssLG9qStjAI9hsBw3XCEOheFU0RFe+4NwWZYiX8Plq2PklIGMcb48WcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLKPZy+Jlr1Xx2q0yXtMCZwDP9Et38naaSp35UhAMTY=;
 b=Jyeg7XsOEBAaDc5so9OVuIHhEz/pPZwpmbD8PH1raAMEqlEJ//s0lqxluy/rMzq9t8cgy8BGlDcNs8n9vloZUHzD2W8OLceMf4EBYPWdOFjv7Ai49in5qf/Fsdr1I+17LT41PsEr1TOmFiIR7G109vWbYRk2SqNZxzBFBBxH2KvWioWfiTXjp+DdO7Rdtou734THWrORE5pHKY7YEepMzulmUcn7bQqA07Z7EtJIqSQS9fy6fg7VOkiLH4HnNTAs7YCT/Umgv+mO5IXNhKHc/E1ihwyXZ4S2p6nnOhMtXONzM26zLR97hw17iDSOE1eUnXiJICdcrlv9Sjh/Pcnx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLKPZy+Jlr1Xx2q0yXtMCZwDP9Et38naaSp35UhAMTY=;
 b=foecWBWA1utgUIJa/uoWH9tMFuHGCfXqKbaD81TTDIxEf/WLl4ErHIx0RZeN2KbRh4nPLe1o1hgDBjpENgSo+L7RY1CUfV8ge1qEr0giRpDZCI39Eb6xrJhs9GxEyOtvrRhfq2LbQni9FobcGYf5+zhXubdSJv77qKWAgco2wSFHS6/qeJNfXf3eB7iOvR9eIS+6PYB9wORI+Gc/OPNBrBTmLJeeiXMLfw3HC1KHUIEtGCN2Nk+F/J/JF4L+bXukM04mUq7cD3N/0MIpopbMbN9IgxmRm9WLjWTV2e8QKR33gZ9Wk2QooeRkXZk//t+Gh6iJYTfTP0uy3FVOgmfotw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1685.namprd12.prod.outlook.com (2603:10b6:910:11::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 23:57:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 23:57:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
CC: Martin Belanger <nitram_67@hotmail.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>, "axboe@fb.com"
 <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "Hayes, Stuart" <Stuart.Hayes@dell.com>, "Rose, Charles"
 <Charles.Rose@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Thread-Topic: [PATCHv3 2/2] nvme: Expose cntrltype and dctype through sysfs
Thread-Index: AQHYHSM49++cF75LEUW3CdjmyS9B4ayKSuQAgAAJFwCAAADtvQ==
Date: Tue, 8 Feb 2022 23:57:12 +0000
Message-ID: <638EEF43-BB5D-4186-B8E0-F7F939D54EF3@nvidia.com>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
 <BL0PR13MB4291B3A6C98BA5EB5ACD8A129C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <890f6817-7880-79cd-3651-2f91e4454e28@nvidia.com>
 <SJ0PR19MB4544A98CC3684F2421BC7220F22D9@SJ0PR19MB4544.namprd19.prod.outlook.com>
In-Reply-To: <SJ0PR19MB4544A98CC3684F2421BC7220F22D9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18330218-49e5-49aa-65c4-08d9eb5eb9fa
x-ms-traffictypediagnostic: CY4PR12MB1685:EE_
x-microsoft-antispam-prvs: <CY4PR12MB168531BDFFAD79EAA8B77C84A32D9@CY4PR12MB1685.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNHf1i0YVXb3A1tvVLvPnGbChYcS3n8whZ+hxmS3iq/U6LLZo5wF9PjRPMFDOpCV4tEwqqSaItqWrDC+CE70kFfdbGcee72aXjNY7qmG8fkHK3qKZ9DgqOyvYa3G3yDZyuVSkj1Cn/RdGSuYtzH4oLAmC7MXh0p1ySISm9g1xtOOG3h+LWYBdDZ5nuF88qY94PkCDUurxHvwQKtmVmG+fC2hresEDQfpV/Lpb/bMY0/1Vsh6gzykI0Svzw7lk1VVnwwa8X9z35lSZEVv3K6zLLabGqO+Flq1lOliXNdJGHMMv8toEjDVdybasPCiWYGqCVJdB+3B3wi6+yCVx0IEmbT3u4sZlC7yyQELORhLr7UM80tw2edDyqPSjWs+L4y2Ep/5Bv+iFmmAc9yB7HFOEQtcH3Cf0oX/yqdqC2fCJ2kwAmu4zWX1M2eTX5lqJYMfCvp+A4pGOmNtl6ulSq2Flf6IeYgxGgCfFwbVYoZS6nqnJzU4wqeAhnl4VDTkgRcKQUMg2pcIjuz5AMU2dr4zLEFvke0MRPUbKkYYsgNH9m1C5qPDdN1bkuhZ8vYgW90SaPqM1flLgS14ZGe6445k33iV4b9H0Pb08bmoruy2wksMcLWdQhId4zbLWMC5uS966JBxRr5SuPdUCBTtB6dtS0HvW7UHHjgAz3pOUv1RkX8gpyRvjgxMs1gHN7YL17iBnPnPFJeglp6qdQKmLZ9r0cKHebg2GO/hHNsk5jEcmwY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(33656002)(4326008)(8676002)(66446008)(66476007)(66556008)(8936002)(71200400001)(66946007)(6916009)(64756008)(54906003)(36756003)(2616005)(316002)(186003)(76116006)(91956017)(38070700005)(4744005)(6512007)(53546011)(86362001)(6506007)(7416002)(5660300002)(38100700002)(508600001)(2906002)(122000001)(6486002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDJNOFJKRWxId01vc1dNZk1sM3pOQitQeHV6YTJkaTVSRU8yY2g2UEdHbnVJ?=
 =?utf-8?B?alBBdHlPZm1aalluWXREWkgyQjJRSTlsdmhBQlgrOFl4R0IreWtWUm83YThn?=
 =?utf-8?B?QlBqZlF6TEhjVXBVWDBUNkh5a3A1L1E5TTByc3NSdFpjam9aU2lHTlkyVW84?=
 =?utf-8?B?ZUNaWlh2dmU5WHYzakxlZjEydFc5RVYyeHo4bmttZGlWMWs4QUR3aU1lblQv?=
 =?utf-8?B?VTU5OWRUWkF2TTZhVzNyNFU3ZUlmYnpPV29SbzBCdzhocE10S3pMdkFYKytZ?=
 =?utf-8?B?b0F6UUR1bGNGK3VhNkMyNVhBS3cwQ3RkbmZrckNJWmxNSkJXRnRYWlRSZTVP?=
 =?utf-8?B?a3dJOEtjUE84VWs5akpWOEFzd3oyZ21lR25Vd2gwT3dnWWNkOWFuYTdVTkZH?=
 =?utf-8?B?dm9UbkFPY0NIVDRoa1pHUmZSY0g2TW9lWjNuYjZKdFNtMjNRMFM3NG81eTB6?=
 =?utf-8?B?ZjdYTjR4UWFwNTJhZ0NleFg1dUFYN2d2SS9KdDdWRVp3bHZiOVdkV0M4UEo5?=
 =?utf-8?B?K2NrV2ZwWFhicWRmVVNiS2dYL1JJYnVIUlQ0SVh0dXYyVW5MVkZzZmxLQWhv?=
 =?utf-8?B?YlpSemlLZ2tMcWdXalVLZnJscG5VeVdRb1hpejRiL2MxZGdZUVVTenFJOEF4?=
 =?utf-8?B?WWQ5ZzhrT3MzR1ZnZmV1cVBKbXVHcGFKamVVbHV3NUNiVEFOOVhRRXQyMnRN?=
 =?utf-8?B?eUFyTkZZWHdhZ2g2MWY0K3dGOVNzMW1XenQ4ZGt4bG85Nk52b2xadWJlVm9u?=
 =?utf-8?B?dE41WGtvaGlNMm9hd3dwbTBsUDh5dUtZY2YxOVdZaWh4ZG5MZDBGR3NPaU05?=
 =?utf-8?B?TVR0ZGNkOG9BWU9sRldDZzc2SmlLNDFjUHgyNmx6d1Brcmk2UVRLMTEra1py?=
 =?utf-8?B?SzZlVy9lai9EOHVHdDRWR2hpcG9HcDVvdmJ6UHB1NXZhZGVFNGprQVIyaU93?=
 =?utf-8?B?ZFl4RmRXbFIzRStRZnhEaFRzaE1wcTBHNEF6YzhDS2dUQ3EzOGdGaUpMZ2Rl?=
 =?utf-8?B?OTcraWNlYU9ibFU1c1hjblB1SXo0NXRVNnRDakY4MjY0WC9DMFdCaHhLRXN4?=
 =?utf-8?B?VFN6aFlNQzlRT2lydXlXTmRaUlVBcUJ4Z1g2YitQTHdCU3NmcVh3T2orenph?=
 =?utf-8?B?NDlqUlJIQW5ZRk44TTF4TTRVaVhhUWMrenQzak9PSzVGYVVnSDZORm15dC83?=
 =?utf-8?B?UVhIZE91TWROQUpRVGtCNEZyWUNZM0pNcEZmbjV2S1pMejk3NFNNbm9VSVF3?=
 =?utf-8?B?SEtDV1dJY2RHcmxCK3NVR0VYTCtCcjRucWp1Lzl3S214RmUrejBtQ2ZDTjFB?=
 =?utf-8?B?Z1ZIdnBwMHBVWjY5d1VLc3Zpa1BRNTJ2ZE9FVHRrRzB0S29FVEw2dlZJMVV6?=
 =?utf-8?B?SldKYmowUnZmalQ2S2RzN1A3VGlZUXlHbVdOK0FqbnNjQk5jQW5ZUENydlFp?=
 =?utf-8?B?YUNYcnplV2tuUEFMajlMLy90WGFrazlrUFl4MjU5TUhjSnJvRUx0eXFYNHBQ?=
 =?utf-8?B?LzhkRHNkT0VDMmlXUkp6WWNLY2d3dHdKanBzMFVva3VUSnl0YUpvSmpWZHpI?=
 =?utf-8?B?dWNtZEpObklJOEVuRUNEUFJzWnVwQlRaK3JoODBBRVhWZi9Cc3I4R0ZwdTlG?=
 =?utf-8?B?NitHekVPZzc3SERieGVRRnFNUXVvVVNJWkVrOFFxR3JGL1ZlNGUyaFBYekpp?=
 =?utf-8?B?blBzMHJUMzZrTWJhOEVwYWpoVkNHdUEvQXF4ZHVPY0lVVElla0ZsUGtQSnkz?=
 =?utf-8?B?STNvb1VHeE91N09zQjk0dVA0WGxOZkN2bVJ6QmFkQkFpUFZzeTljdHdEU2FF?=
 =?utf-8?B?ZmFEY0Q4WUtsSy9qNnc1YTk0UW9BdU52aGl4cWRFK2d4M2NJalhmQlRuRHc2?=
 =?utf-8?B?OFBqdzVXOVVOYzkxclZ2c3RVOVMxT2VhczhORU9Kc3orZGE0MHY5VjBoZU5k?=
 =?utf-8?B?aEdlaEhCQXBSemp1anpiSHhkWEhxRXZBdzMydlFFb2ZyaGlSK0FORDl4UmFN?=
 =?utf-8?B?RmlNOXM5U3NVaTRXc1FxRWJ3QnpIMkpUQzczLzBRZ3JFSFZIdnMwcmxvNkpK?=
 =?utf-8?B?T2FhZUIxZEdaZ1dsakFZMWx3ZWNRRnkrbkFTemRTbUd0S0lhL0Y5RnVBY3Nw?=
 =?utf-8?B?bVJHNFphMXFxRDdIY05oM3hPWitVTUJaRjRTSlZwWGZSYmlkVmNFMUxDYjZz?=
 =?utf-8?B?NGdCS0FCMlYxYTVpb1dlRGxhZlpRbE5TVk9rNUlsUGhoNDd1dG9OeXpvZEZE?=
 =?utf-8?Q?oRvDiLcVXbZDC5KUl8LqbfdEYePb5sper/d3Dxt3zs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18330218-49e5-49aa-65c4-08d9eb5eb9fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 23:57:12.8034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mluhlWSPz4uLc2pL+dfab12fwZMkX1A1Raap3nINZFvSM8MKGnki0mZj6xz8CMEZ182pVLbgBvBQcUvX71iOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1685
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220208_155718_565899_56CA6BA5 
X-CRM114-Status: UNSURE (   8.28  )
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

DQo+IE9uIEZlYiA4LCAyMDIyLCBhdCAzOjU0IFBNLCBCZWxhbmdlciwgTWFydGluIDxNYXJ0aW4u
QmVsYW5nZXJAZGVsbC5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+PiANCj4+PiArc3RhdGljIHNz
aXplX3QgY250cmx0eXBlX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPj4+ICsgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKSB7DQo+Pj4g
KyAgICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHR5cGVbXSA9IHsNCj4+IA0KPj4gbml0Oi0g
c3RhdGljIGNvc3QgY2hhciAqY29uc3QgdHlwZVtdIC4uLg0KPiANCj4gSGkgQ2hhaXRhbnlhLiBJ
J20gYWZyYWlkIEkgZG9u4oCZdCBrbm93IHdoYXQgeW91IG1lYW4gYnkgIm5pdCIuIA0KPiBUaGUg
c3ludGF4ICJzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IHR5cGVbXSA9IiB3YXMgc3VnZ2VzdGVk
IA0KPiBieSB0aGUgY2hlY2twYXRjaC5wbCBzY3JpcHQuDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJ0
aW4NCg0KSW4gdGhhdCBjYXNlIGlnbm9yZSBteSBjb21tZW50LiANCg0KDQo=

