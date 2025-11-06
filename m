Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76223CCFA0D
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 00:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ly6z+eGpnHjORnYmWFibW2hW3O+VBGe2tjthyr7rdNw=; b=VbeHrq2OdWFPOAaeY9zooBdiBa
	Jr8HJMzTEVm5Yz7jBQb5K0l2Yu97urCU5Rlto/jejUroBBzDcZapQsP0NClp0O9r8Y2BjmNs4a1zk
	5AgxlsvMDBXU4g4lKkqfZA3eWD7MXVSUf4XglRtMyge+Dr2nlNPkjVMF1FT3bfJG9tNnZ6JUrEntP
	Puv7PhslBxMsgCT/kmS7DGmf9RJmOSJ9Z9fvplJerulaIOZ+k6Skovp2wP3BUIQ9Tik5bjP6g8cJr
	n2WhaJoWEEvyRO+o99PLg3usdlxSsvL2rpt7xpGQkMDoC7ODP3c9PkLTYQvT0dwlt0PvhA66U540l
	SJdIq1qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGnaB-0000000Edpv-25Oo;
	Thu, 06 Nov 2025 00:10:31 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGna8-0000000EdpP-2lfb
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 00:10:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nl1yK0akZ9/f/SItJEOjbo4mkFogmdY8BQWTXo41FnYDOqEM2gYUMmzfePQospkuTHu50cZsx5A+RizhM9bOHtMuSbGi5fgrJnUZVXv2+4S9pGjRcvxWwrzzaUkjO3xKJYFeWNLN4PBGoRvIUx2mWIVHE5zFxgNqW3Dufi4hkgtMAJ5HOX76rLAQoOA0e0yUQLO89HhS8o1hNtq/4ansy16CCbxO04FFf4qo1boBrQXlndB2eV7NALQzUWmnoyeiQJ3ahYzUsxxhaa9BjeWApgRuL1NtbuBq6Dq4Nakb2lO/6SFceIkeH8cnzoANK0rmPgZRpGyUz/uiIA0ZyqmqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly6z+eGpnHjORnYmWFibW2hW3O+VBGe2tjthyr7rdNw=;
 b=unamcvhHIo//33XIWgn73LYzIRFn3BhD6kDBDtQ1v5qOWE7NG9gpS5RcHr8vzyI3jBqxnfrVPXCWcEWVPlgVGHgF8vAN3v37dvQ1KfgYIfbs+uPGjnJDHZttCHCefGO2fWyKa1KV7ycJMXu1Q+jmzr/D3wRzeGmomKGDEj64ULfgOa44oOqbGGcQyNbh39xTxpuUWpJD0xGoswrahfB/jSJ5MFmgmi5rDLhfFE5ZVFAKVgTrVZPgAw9XsBHK8If62vEg1gSDaJS6slgK8zIB/T6e/dNFK4zeqiYqtSYCiBo0mVcoowi/Eu013Uv8x2J1OylNVw+U/T0yWlbglATgsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly6z+eGpnHjORnYmWFibW2hW3O+VBGe2tjthyr7rdNw=;
 b=cRfhCpoDgcFtEA8dQ69WAif1MXL49FIT+VgsDyEcRK9oZ5wqslLj7se+UkP08VfuzLR32pXbUS6bDi5CvzwCqTniajGiFCm8C9UWM3NFyoeaolHYZOFbGjEMH3hN1/gOnK69VfirSTVLnzklG2g/fInC2hacte1tB5blCMn2kfuRgtrv1AWjiqAeeeXrUZMOuuqOV5p2gD0OYXcbnUL4c5OEsmA9525juReywG3iqvmFhL98rIf3ZC1RM0S8smamj12ZSx5hZueiup4vSx+s00MnaP+xiMIFO6aazDw5JqRGDs8lLUwiJ5JdK1Rxhh976pSjgXkz+gwl4ECbd43qvg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 00:10:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 00:10:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>, Casey Chen
	<cachen@purestorage.com>
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
Thread-Topic: [PATCH] nvme: fix admin request_queue lifetime
Thread-Index: AQHcTd6+cRUvwt/Ro0Wz9pKeeHCGorTkh7kAgAACxwCAAD0+AA==
Date: Thu, 6 Nov 2025 00:10:22 +0000
Message-ID: <a67de936-70d8-4007-be0b-82a17a2025b9@nvidia.com>
References: <20251104225939.3641605-1-kbusch@meta.com>
 <CALCePG1FFQUWg2u-RhY4DQ9uVxd3uMuwSdvyU-r-ssm_dQjY=Q@mail.gmail.com>
 <aQu0Dqc6L17WplVt@kbusch-mbp>
In-Reply-To: <aQu0Dqc6L17WplVt@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8934:EE_
x-ms-office365-filtering-correlation-id: e8cfc509-8db1-4d69-cabd-08de1cc8e0c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NVFMc0JEdzlCTXlBbXpsUmJPTEtCenRTbVhXUHd4WHNSOEZaNkZnekE4VERO?=
 =?utf-8?B?bWZlSitDTllIVitIcjB2WHFlUHVSTnZpNFRGYXFENFgzcDhQUHJvSldraEpD?=
 =?utf-8?B?YngxOFMramFuQ0ZxRHNuMXRUbHVacTFDc3dRdE04R1VpZnpVQjZ3dFY4WThn?=
 =?utf-8?B?YmZQZ1E4bW9MUFNvZTVYTE02NFYyM2NKN2FzODBhWlZnaDBoQU5iZGx4aUtv?=
 =?utf-8?B?VWZKNGM3ZTFLNVVmcUgvSzNlMUpjR2tBaVlPczlVVU9pWVA2Qk1HWmRjdHJK?=
 =?utf-8?B?WVVPbnZzKy8ycXhhbE1pb1BWNjQyeURVUjVjVTRyQmxkVGpnOU1jd1RPVzR1?=
 =?utf-8?B?UVhQcjNUYXF2Vk5iaExYV0Jnc2hYajlDNzRBVG1iU01mSk5xSHJHTmhXRXcv?=
 =?utf-8?B?NmlEVlZLRENncmpXNWJLbGpqMlRYNXpockRva1dnL2ZWcjRmQUpLbXN2Vlli?=
 =?utf-8?B?MFY1QlNFV2JETkJzUzVBdm5Bbnl6V3JYUzNHUTdQSkUwZWJaWjdLcEhzaTBY?=
 =?utf-8?B?cXFyNFdqOWk1R3BHU0dxcDZRQUZSZlZrYjlKcGNVR2doUm03YVU2czlHd1FK?=
 =?utf-8?B?YndxZmVISWJVVkk3NDVuSXdBVDFlZEVMRk1pM0NSUXEwaXZYUUNXZGZGTklH?=
 =?utf-8?B?UXQwV1JJWWZjYy9Pcmk1eEt3K25aR2ZZUFJpRXRzMUFuVFczZTF0MHNjQXYx?=
 =?utf-8?B?bHVsemcvcXd3bW9DZ080cWtaYU9Eb1N3RTJRL21FKzcvcXMyYUlQU29ZY2Fx?=
 =?utf-8?B?Rml2WHJVNjZ4TnR3VjlxcTUyVzIwRVcrQWR3YjVWWHhFNUdaN2RXK2ZLNHJU?=
 =?utf-8?B?WEc3VW91bDN5RVpnSFdGKzNsSHhkeGNxTUgzeXRCMHFVY25TZHFnL3dXYllo?=
 =?utf-8?B?MzRySVVwZVAvcXVXTHltakw5Nkptayt0SWxZUFdCc0Z2UXJKNDdlQTBReUVX?=
 =?utf-8?B?WXNyQmFNK1JyVnJrUnNWMGdpQ1daUVROU1NvelJwM3R1THJRWlM2amNSc0g2?=
 =?utf-8?B?MmNIa2NSRlZVQ0M1Ry9ZNUI3WkxsWTV3bWpEVTV2V0hicXpRcWdTVWQwd21R?=
 =?utf-8?B?U2J4UEhPQUFNM3lvK05mcmJYTHJRMHkxeXFydXFMMjQ4RGkvZStLSVRuekc3?=
 =?utf-8?B?M05sRW44YS8xVTJGMkR0ZEI1NFM3ZUtybUNlUmloQjVleGU5bzNWWHJtUG9p?=
 =?utf-8?B?WE5HcmZIUzU5MW9LdGxMczFjSVMwbVNEdWs3T0VoUXhhUEJoam9aMjhsZ0wy?=
 =?utf-8?B?dVRlN05nN21aZXY5N3pmalNhUEtsOWova0d0c1hHaHNrQTdLL1B2OXlUWEQr?=
 =?utf-8?B?VUh0SEtPRytBdEp4Zzg1N0lYUXBiVGVkV3NQTnl5c0NsLzBnVWdITEtXT3c1?=
 =?utf-8?B?NkhZU1VYVndneTdTQVY3eW9VYytqN1VEakRmekg5Wkw4Z0M0RWh4THIvS1ll?=
 =?utf-8?B?Uy9SMFpmWE15eFhyaEl1NXJlT1IvMmg0alo4Z3FkWjZYRFE3VVpjRlZUWlNk?=
 =?utf-8?B?VXduVlNmZS9VZ3NsSXRNbWovRGtuU2x5djZGTnlQcFRLbUVWemcyc2VrTENv?=
 =?utf-8?B?RTFSYlFIMERCUk52bnErRjYxeVhmZEJJeWVMcUxseUhiNHd1K1VNSGpRbFg1?=
 =?utf-8?B?eGgzWmxJMVlYbWY2ekdhdHE0a1hQeElmTHAwSkxjTTJ2YjhrM00xVUZXengw?=
 =?utf-8?B?ZDlLNVRJTW1aN1lPZUZtdnNnUVlhd0pMZHFaZFFQZllTWTJLSTYvSDFjS3hC?=
 =?utf-8?B?bDF0cGJONFVqS0EzZzVuMS9XZDI2SjZHenNVQWppdk9iNWRKYVkreExDbllr?=
 =?utf-8?B?eTJpemUrVWRNWStpZnlHTEpRZzNDN051eGV0T21NUElZcTBkOG9VU0dTSkdJ?=
 =?utf-8?B?QlBvWSs4TE5IMUpvbzByck1mRFlMbUtEZ3lRcXNtdUJCMTAxM0pIbzl1bXBT?=
 =?utf-8?B?OGJQSnJaQUF5STZKREhuQWtuSkt4bEdXSVNQNkVTSDNWZUREM2EvaXMxajV3?=
 =?utf-8?B?VXhlbmhKNzl6UWM2SlpDUjM2dG5kQUhlbXBkM3B3Z0FHZmljOHdCb0RxNnRC?=
 =?utf-8?Q?ztml96?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlpnSkg5YUUyRzFNWUE0RU9mR0h5YjVWS0RDbmZPWmYzZVJjQkUzOC9KQkxy?=
 =?utf-8?B?cG5xYk9uOU5OclNNTmxBZ0lCZjZyalFjaGNjV1hxL2ZCRUNIZEl4K2ZNbmJn?=
 =?utf-8?B?Y25iS2dySWNiaDJHSVRWY3RFSFBsWGtFQUxwcWhMQk9yT3JKWERZbkw4b2RH?=
 =?utf-8?B?VzR4ZFFwU1YzQ25BVVNtdG5nQ2FNV005aDBoRUgvdHFXdzR0bEpiRlM1RGI3?=
 =?utf-8?B?c2dHbjNEeWdiQkt2dzNTK1ZqUXFGS3FwWUpqMTY4Q1NRNE9NalZsN2pVbzdQ?=
 =?utf-8?B?Znk4QjdENHRZL1JQNHVSMnFpb0xwbTNmUGlHWnU3MFNhQm83d2JPazhFekp2?=
 =?utf-8?B?VEEvaFA1WEZXUmpYU044SEdYNmxqZkJsTExBVTVnS3hscjN4SnlQcTNGWjB0?=
 =?utf-8?B?VHdsanFWcTRsLzdQVWRTV1ZQUHNqV3dFR3lIYXE3RFNDSGE3TCtmM0twRE04?=
 =?utf-8?B?K0RHUWlML21XeVdwWk9rMlRGOSs5ZmpBTGlRK0Z2TlgvK093UEVDSU1hS0VT?=
 =?utf-8?B?MmpJWWNqRWNBakxERFJqRzBiWkV6Z2N2ckRpaTNOWkU2cmlHNmJ5ODh6Vjha?=
 =?utf-8?B?Sk9PQVhWbGNhOEpScTZWZUQ2SmZwS3EvSVJsME0xLzZ3c2RDQ0ZFMEZhRVJ0?=
 =?utf-8?B?Qk9qYXZ4TzZiblY0THJZbjErOVh1OEVjbWR5bHo5NzgzdkRhakZkT0RHZ0Ux?=
 =?utf-8?B?M1ZJc1BGaENUY3hKcTRnOWl2VXFVTHExUWRWVWlVelJDWStMeTBiNHJ5WGM2?=
 =?utf-8?B?V096aExwc1ZCVjZkUE1ISDlmbjliTWxqR3F0NkVldVg0eGtzb1hTMTNzUHE0?=
 =?utf-8?B?VXhMOXhaRzlFaDVOUjlzbVR3am1INmNKc1JtQzF0MEtHYXM5U2ZUWWZuQ0Uz?=
 =?utf-8?B?aGV1Q25aSzJWaW1xdnhJWkgxM3RGWGJEUklvVTIvbzc3SWIrK0d5aHN6eFhQ?=
 =?utf-8?B?dm5WejkrTFlhMndOWE5NMEZveXB5VUR4V2M2b1V2ZG50cm5LZi8rczlSN1J1?=
 =?utf-8?B?Q3hlSTNyR0U0R29MWWNFeXBzRmJ6TWh1TElReDFZVUNXUXpwcDBnNnpiL0U0?=
 =?utf-8?B?NFhPd3FldnY0MkN5UmZkRFY5andaUDM1T0J1cmxPMUJ6YUt6bjhIUFZSV1JB?=
 =?utf-8?B?QmFhYlo4cjROd0p2SFJzNVZPSnVlVGJpN2VFSTVGU1R1UGVBSG5ES3RSdnls?=
 =?utf-8?B?MDVreHpZOCsydU01NXZ4RStSSzltTDdXbGZ1dmorT2x5U1pyY1JMQXh3RDJn?=
 =?utf-8?B?Qjh6QTZKeTlZQ3lCWDE3cnZKVWQ1VmZmdUM5aHRyQkd0ejlvWENoTnhZSWtr?=
 =?utf-8?B?VXJSbFAyMllMYlQwdThheHNHdFk4SFNneStsZ3VVQVJHQm9qNlc5ZjBsWU41?=
 =?utf-8?B?Z0pwa2J3RjlBR3p6ZkVKK0hxSG1TMld6NjZRSTgrZW03MlBSSmhreEZ1Zm5T?=
 =?utf-8?B?K0VlaXlobmFtK3RQQnQ5V1U3a2xrQ09vYkwwN0tuSXRiOVpXbkNJY1hRMHJN?=
 =?utf-8?B?aThTNmw1em9aSTVaamRFLzlWdHM2b0FxSkNvc3hHVGFJOU5vMWswQVIrN3lK?=
 =?utf-8?B?a0dyUnBnbzRnQksrc1B0QzFhTVdVcXFoeXJWZHFlRHFtVk5pTWwxc1V5L2M4?=
 =?utf-8?B?cHRaelFPd2lEZkxhRTBtbGVWMEVGVXZkc1NiYUI0WS9YQWVaN3lBU0NaeW1o?=
 =?utf-8?B?N2lUTmhNRGYycVVGekFFTDZONjRoMEJrek9tYmVjRkJxN1VmdzlCUlRwV2xr?=
 =?utf-8?B?Z0ZSMUJFc0o5aHp5QjVBWmhSMXB6SnIyNllpZnlVeEdBdlJTeEdSS01rdk9E?=
 =?utf-8?B?L1NUVmxGc2wrblhaNzJLV0V5QnhIYlFQczF0d05BSitpdDRrUkhVNFIyZWpN?=
 =?utf-8?B?S1FwSmJ0YzRkMjJQWEk3RTVaMU9TK2g5VnFuQzYxenc2eVNSNjJJYmRzakNy?=
 =?utf-8?B?bVh4UEQvSzZaQVBmWkpWbGlESURydGRJeldhSWt4SlEzOTFrdS93dTN2aFU0?=
 =?utf-8?B?UnkrVGRJc0s2SHpCMnkxd1ZRNmpxMzl4Q1FLVEpjdGs1Rkt0RUYvakdHVUFx?=
 =?utf-8?B?enRYQ3pESVIvQytFRDgyQVZyS2dmWlVFUFdnTEVwSTBYS1hBa2tlNlVieXVK?=
 =?utf-8?B?M2FBeUdDS2ltTjltL0N1TnVxOTVjSklDaXJqVEVKZUhuR29mS3J1bWVMTHlN?=
 =?utf-8?Q?RsrMHNKI8E8S8nAhgAYMGF/3AF8QJG5VmU262M96jQBG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <929D664E6934174CB1E6DB5AF86D7A39@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cfc509-8db1-4d69-cabd-08de1cc8e0c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 00:10:22.3093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbFvWbDdbhl0t4IVfJBuPZFROsIzzh/Tx1Ag58l1gQmS+PM+nlm1MrToaOsj7M8EC9C2NL9KIhW+6A8ut/nRMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_161028_752140_A6268EA2 
X-CRM114-Status: GOOD (  14.42  )
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

T24gMTEvNS8yNSAxMjozMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFdlZCwgTm92IDA1LCAy
MDI1IGF0IDEyOjIxOjE0UE0gLTA4MDAsIENhc2V5IENoZW4gd3JvdGU6DQo+PiBPbiBUdWUsIE5v
diA0LCAyMDI1IGF0IDM6MDDigK9QTSBLZWl0aCBCdXNjaCA8a2J1c2NoQG1ldGEuY29tPiB3cm90
ZToNCj4+PiBAQCAtNTA0NSw2ICs1MDQ0LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9mcmVlX2N0cmwo
c3RydWN0IGRldmljZSAqZGV2KQ0KPj4+ICAgICAgICAgICAgICAgICAgY29udGFpbmVyX29mKGRl
diwgc3RydWN0IG52bWVfY3RybCwgY3RybF9kZXZpY2UpOw0KPj4+ICAgICAgICAgIHN0cnVjdCBu
dm1lX3N1YnN5c3RlbSAqc3Vic3lzID0gY3RybC0+c3Vic3lzOw0KPj4+DQo+Pj4gKyAgICAgICBi
bGtfcHV0X3F1ZXVlKGN0cmwtPmFkbWluX3EpOw0KPj4gV2FpdC4gRG8gd2UgbmVlZCB0byBjaGVj
ayBjdHJsLT5hZG1pbl9xIG5vbi1OVUxMIGJlZm9yZSBwdXR0aW5nIGl0ID8NCj4+IElmIG52bWVf
YWxsb2NfYWRtaW5fdGFnX3NldCgpIGZhaWxzLCBibGtfcHV0X3F1ZXVlKCkgd291bGQgcHV0IE5V
TEwNCj4+IGFuZCBwYW5pYyBrZXJuZWwuDQo+IE9oLCBsaWtlIGlmIHdlIGNhbGwgbnZtZV91bmlu
aXRfY3RybCgpIHByaW9yIHRvIGFsbG9jYXRpbmcgdGhlIHRhZ3NldD8NCj4gWWVzLCBJIHRoaW5r
IHlvdSdyZSByaWdodCwgdW5saWtlbHkgYXMgdGhhdCBpcyB0byBvY2N1ci4gVGhhbmtzLCBJJ2xs
DQo+IGZvbGQgaW4geW91ciBzdWdnZXN0aW9uLg0KDQpJIGhhZCB0aGF0IGNoZWNrIGluIHRoZSBw
YXRjaCBJIHBvc3RlZCBlYXJsaWVyIDopDQoNCiIiIiIiIiINCg0KKyAgICAvKioNCisgICAgICog
UmVsZWFzZSBhZG1pbl9xJ3MgZmluYWwgcmVmZXJlbmNlLiBBbGwgbmFtZXNwYWNlIHJlZmVyZW5j
ZXMgaGF2ZQ0KKyAgICAgKiBiZWVuIHJlbGVhc2VkIGF0IHRoaXMgcG9pbnQuIE5VTEwgY2hlY2sg
aXMgbmVlZGVkIGZvciB0byBoYW5kbGUNCisgICAgICogYWxsb2NhdGlvbiBmYWlsdXJlIGluIG52
bWVfYWxsb2NfYWRtaW5fdGFnX3NldCgpLg0KKyAgICAgKi8NCisgICAgaWYgKGN0cmwtPmFkbWlu
X3EpDQorICAgICAgICBibGtfcHV0X3F1ZXVlKGN0cmwtPmFkbWluX3EpOw0KKw0KICAgICAgICBp
ZiAoIXN1YnN5cyB8fCBjdHJsLT5pbnN0YW5jZSAhPSBzdWJzeXMtPmluc3RhbmNlKQ0KICAgICAg
ICAgICAgaWRhX2ZyZWUoJm52bWVfaW5zdGFuY2VfaWRhLCBjdHJsLT5pbnN0YW5jZSk7DQogICAg
ICAgIG52bWVfZnJlZV9jZWxzKGN0cmwpOw0KDQotY2sNCg0KIiIiIiIiDQoNCi1jaw0KDQoNCg==

