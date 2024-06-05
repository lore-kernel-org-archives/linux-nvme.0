Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00C1C25B78
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 00:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UcNBZrgw/6ytP5h4XNY3ME/gkzDaQPO5kJL3DKnrCBU=; b=Cq6DrhiRuY7XSKESfrhUXiBqcV
	Faai5xV/FMGkCtaedPs/yZaldULhc3+rD1/f+T8T5K05r3T59cBsJ/eo9qsP+jubH29OpXHN3bSGQ
	rfgW3wXx7I01Nqot0qp2BLWjBPYOGS8JvaWOrZu3WaCMSViMwe/JAn8fmTsRyDDKl8ZkAiPAU/yqc
	2jIvQTg9UfShdO5nvkhT63d0uqYhaeiDkl2K3m4PH5APwTWhNrV51R5LtigZTP4Za0M5PVDQ/N+0S
	+VYNtRUmBG5WAMQ1/Y1h4oNl1r5xL7+iethU4A8Wbd0TIDd7sDq5PptuPXxrBO2VLFOq81FjLo8ig
	a/8zZC7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEeM2-00000004FiH-11V6;
	Wed, 05 Jun 2024 00:18:14 +0000
Received: from mail-bn1nam02on2062d.outbound.protection.outlook.com ([2a01:111:f403:2407::62d] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEeLy-00000004Fhn-4282
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 00:18:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqcgNBUDxb/b8+RdMWyJh87qm+Yl0gEW/I7CDTxw79frBk/dcItaoqtD7VSNGZ4O6WWDifJoVjvsk+UCRp8cdhNdKpZEyYSV4RAU+bEhp5EvvX1ndiwBRsNUtL4ASL+JVzmxqBym5ok3ZWUdcFimZ1yAADbRe0UfCefAcgiDOHFqXMRNABTt+ecJV74MMiFo4PYUhyW54EkQzxAvnfjL9P8XJxaqVXUvTsH7/cZHUip9ga7CZyANfltUyBlM3pM5+LsIvxCvLjldPSoKoVVblT1RScFMI+9jWx+l7bjFCd03pkIG9tkprIYZDD4Kh4N5xgTiUTDPcp3mrYDq7jfRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcNBZrgw/6ytP5h4XNY3ME/gkzDaQPO5kJL3DKnrCBU=;
 b=Rve9cQdpWLL6HglTEvzXBirY7cfzn0YeJVcbnfHM2mgE3AQazepoj6IEGbKv3bKh2ec8AuMK+Ru4EdA5LOtc/q+9pUdxdDA1OZnaGgnqsE65FuCnP4Qe6BJWRxHrTRcCmrZhPX8ZU+WDwrmElHgwBQkVXKZ6koCFS8rivS3WixOHmw7BAAyKF3qFMJgIstAo336EnpOOrsJh7BoKx3T5sSSdeGyUhVuK+8JqjvwlAIgCwkOTRTGnEupuU8ZgU6I3tBUEgB/mwLp0hcYZ8vdEmJsqoJP5Gku7EPlANpdpxiqqNaWl12VFWZ4xdbU7ybOAA+6aAK1s+KKsw5pZT7xVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcNBZrgw/6ytP5h4XNY3ME/gkzDaQPO5kJL3DKnrCBU=;
 b=krianGhcSz9vr0+VvxBurcPXHV1t7DK/3eUN3ldjwBlYPk2GveTYoIS18IbxK70Nzdx7u5ocoYOCIolvquGN/1hiPtgSTh4VcgDmk8LvfGeqQXX5rDROwOSILsVmcj83BiGC82j28NU3Lfs856OgnSbYKwcQj3ZQ4qhmA1Qv/AD6fwGUhVUIee9DUwBnhAHWx4EBPF30+ykLCIrorhiEdamYpdKnXZefEiNC3LsICBwbGmU/qwA6myk/ttU4HOllIJvdGjPZxxzZdZKigy6qh9vYfoaXY3gVT3HHDP3f5Oju/zNM4h8732LepxFj20P1qFtRJlYh/BX5vvMRpHsoAQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CYYPR12MB8751.namprd12.prod.outlook.com (2603:10b6:930:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 00:03:13 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 00:03:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Weiwen Hu <huweiwen@linux.alibaba.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
CC: Mike Christie <michael.christie@oracle.com>, Christoph Hellwig
	<hch@lst.de>
Subject: Re: [PATCH v2 3/4] nvme: rename CDR/MORE/DNR to NVME_STATUS_*
Thread-Topic: [PATCH v2 3/4] nvme: rename CDR/MORE/DNR to NVME_STATUS_*
Thread-Index: AQHatbWu1Cq+egVy7Uyt6v45fxXowLG4TBcA
Date: Wed, 5 Jun 2024 00:03:13 +0000
Message-ID: <1aa559cf-6c67-4b88-ac75-f8efd19af783@nvidia.com>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
 <20240603125702.97368-4-huweiwen@linux.alibaba.com>
In-Reply-To: <20240603125702.97368-4-huweiwen@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CYYPR12MB8751:EE_
x-ms-office365-filtering-correlation-id: 32300d56-2eeb-4979-f3bc-08dc84f2e490
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TmhBdy9aVDVQa2RIVG5SdGlKVFFUakIzV0lJVy95ZEhtcDVmbTcxbFRLQ0VP?=
 =?utf-8?B?Z2syS3BJbUZ3WHIrM2dSZndtZzhwN3V0cDdFWFNFREZKdEh4RFBRUjlYYnhl?=
 =?utf-8?B?QVdMK1dCTTg4NWRieCtpOXJSMFFKYXlEcDBQQnlWOFZ0RVVUcHdBTWxOcUZ0?=
 =?utf-8?B?RWRHS3N5S2xjQ3QrMFpCcDVzQkk1ZU55QzFoQUZFaitSRFUvRi9vVGN5ZFR6?=
 =?utf-8?B?N1RQblp6TUd3ZkhucEV5anBKaHhMVHFqb2NWeXJ2KzBSSDZld0NlNWJqWGNC?=
 =?utf-8?B?cy9jejMxQnJKc2xUc0RyeDU1emp4Q3NZWXkxMzl1WFBwck1OZ0d3bXU1aStE?=
 =?utf-8?B?WlBxZ1lTYXhFdnZsQkZqMnJyRU9ObWIxMEJqSnBmcHhFU21DNm9ONDFYNkRn?=
 =?utf-8?B?aXJvMmhpeHc4YzR2bWgwazNBSWYwZ0l1R2dueG1UNFBGS292Z25UdHN4bE84?=
 =?utf-8?B?dUM2UTBvMjFua1l1a0gwVXQ3eHBacVpLZGx5SGs1WEV5RjdBSkNlN3ZGUUVR?=
 =?utf-8?B?Q2hJVlJVaWxtQ1JzdHhPc25XZjNSek5SNThzR2VJc3Q3cWNFT1U4K1pyNmJH?=
 =?utf-8?B?bitCVVFHaW5SOGhsOWRlWWV2Rm92MHZNZE9pQUNVM3JpSndmcU9iSFNrVFA2?=
 =?utf-8?B?Q1RZMU9kTHZrdTZmMVFGWjczSmxSWk1TeWdNS25FMmFvL3cyRm9vcjJ2bGRa?=
 =?utf-8?B?OTVxeEszSHdmeE5KOWoxNUVDNnpiKzMwZGxtazdlYlNSOW5RWnFCRC8vVjlS?=
 =?utf-8?B?K2x1L2gwWHNUeUtuaHNvb3pET0IyeERuLzVBZmpUbXA1RUFyUUlhenludHlS?=
 =?utf-8?B?TlV1cjZ5dStWT0RhNHdKUmR1RHFoUlhZaGFDVEVQRElMOXZ1V0h4V0dxQUY2?=
 =?utf-8?B?Z2loL25URHJ6eVhESmVldk9QclRGWjFYZjNiYXQrSUtkY3RyK2o3NDU0b3lw?=
 =?utf-8?B?WTlkd3JKc2R5cWFXSkNLb20vQ2NaOVpmMW11WUxaUDl5WTNDSFpLazM5RnUy?=
 =?utf-8?B?dnJPNjdOZEZFUnZhNnhxM0U5eFlmVFNlK2NGb29wWk5tcHZEbk5ISzE0Mjl6?=
 =?utf-8?B?dTU0UUlXVmNlbDdEcHB1S2hsRXQzOUNySGlyREFxS2pIaDhVVjRuZEE2dXBB?=
 =?utf-8?B?VTdGekdwbTk2czNGaEFOVlVTMlFhd0xwVEg1eWNSeUozUittS05yQVl1QVF3?=
 =?utf-8?B?Y3VTa0t4YlRMNDNaT1pUYWFncy9haUZYUGxWbmkybytESm11UHY4a1o0VUQ5?=
 =?utf-8?B?SE9YTm93YldiWk5uNzkrdG5lWU9JWXZxTnZBYmdtTmx1dUZSVzV5b2hQeHZu?=
 =?utf-8?B?RVN3Y0hGNStyT0gxaU5pMVNSeXN0YlJNV3psUWZvcDN1dHNEb3Q2L1JuQnB5?=
 =?utf-8?B?akUwTkUzUWdBUGRvMXQ3L2drUU0yckIzR1RoMmFMMWhIK1VRajlkMURoTkg5?=
 =?utf-8?B?QWpGQXNJK3hCYmdUVE5uTERLUWZnT2RQRFpTQ0Q1b3IzRUlEQkplLy9xLzlL?=
 =?utf-8?B?Uno0Vy9aOVU1R2VLaS8zdUx1Uk84U25QN1p3VEVVRVk4aWt6R3NBcTJlbXdv?=
 =?utf-8?B?S0UvSlM4aVlwa0wrL0J2RWlwa01WOWc0UzFrOWRwaEdPeTdRKzVNdTF2RUZz?=
 =?utf-8?B?T05DNFc1Z1RBTFJyaStLbUJnaTVydU5VYlU0UXNMdDJlbCtlRTJBcDF2Uk5a?=
 =?utf-8?B?MWVTaXVkUVczMVI3NFBmNmtJM1dUSEhlazU4MUxvWWtVM0g0ODZPcFlNTmVi?=
 =?utf-8?B?OVJoUlR4TlpNOE9uSEJDcXg1a3BTVm1Rc1EweFA2MmF4ZWQ1TUZydUhiZUdr?=
 =?utf-8?B?SnJVTFVkMXFtclJBZzhPdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTdrU092WmlpMmlhcEx5S1ltSS9ualdYQ3FPNUE3RjBrV25OS0x3M255TEI0?=
 =?utf-8?B?T3E0TVNUYTRnd3VkZHc5VFMyU0o0R0lRTWRUR25ERnJ6OUVXbnFObERxdnBw?=
 =?utf-8?B?Yzk4bVQ3SGd6SDhZZHY1ZUQyOEZ4MWlQRHluZm1Wbnl2T1NSaGZwNkswMEVW?=
 =?utf-8?B?UlRSdDJNSStMSTlSbkRmSFQ1YVJ1c2lhYXpic1lzbXVURWwyeGZiS21pMHA3?=
 =?utf-8?B?a3NSNnlCZGcwUVFhQjMvVnBVNGJLRnJxenBjZjZ5NG8xeVM4Qk5lMzFUaW01?=
 =?utf-8?B?T09LVlRkb1oxVklMZ29IK01CR3lhSThVbStqSmYwZ285RERJR1VjSmRxZUdt?=
 =?utf-8?B?U1FRS2ltVXJFM1FkVk5wKy8zSlMxZFBMUW9sU2Y1N05WNVhQL1lsUTlCM2xk?=
 =?utf-8?B?NmVhU1dBTXQyaFZDeXhyZmZVaC9SdncrYm9NRFhNSkF3aHR6QkY1Yi9CSGEv?=
 =?utf-8?B?M2h0aWVCU3ZiZlBaVzdZNWZtc1ZjRjR6QUJ4ZXhoY0hiSGlkanVKdkx3YjhK?=
 =?utf-8?B?SzdxeUV2NWc2SDRySWdIRVMweE82SG9FcjFsemxPZ0FkY0ZpcWcvWCs5cFdJ?=
 =?utf-8?B?ZWtlTHA0V2NtTWpFUldwZk9ndnRSN0xaWGYrZ2M5WFB2azJDMW5kQ056QUIr?=
 =?utf-8?B?eUdjWjJyR0VCVVRQVnp6NnNWSzdaejNIWkR3M1d1Q2tNSDA3TTlsZEgybkpK?=
 =?utf-8?B?WmNmRzdQTk5odGpic09mODNSVW5hdmswUDRHbXQyeGFOd1pMRmtadTlEUzVS?=
 =?utf-8?B?N3QzMFVQeFN5c0orMEV0TE1vb1BGYjBZTm50S284NFZkelZ0NEthSndyaldp?=
 =?utf-8?B?am9ENFdKbkxIenloVXpQcXdXQmtNRlBsc0lnbE1yNmkrcnN2NWNnbUpRS0lt?=
 =?utf-8?B?RHRnNzJISnp6d0pZK1E1SytGbE92RVJsZURRUU9ZTTVValMvY1A0bUIyNVlU?=
 =?utf-8?B?RzBCbkE4MmRZVm9wcnZzYUpVTmhBd25BWitXNXlFOFBDMDVHakdRdmRIVmYr?=
 =?utf-8?B?UVU4NzdCcmwzWDZsR1ZtMVJ2QkVjSmFsWS9id1dWczk2SmRvQ3RwYkt0Zk9Y?=
 =?utf-8?B?N28xd2l0MjR5T3Rqb1hPM0hYZTVjcGlEcFBUVmF6UlZTKzJwSEdZLzlFbEJp?=
 =?utf-8?B?ZkdaWnhoWGFPazdLbitneFE2SGJYdjJBbkZ5bVVVc3R6c0dTNEVZZmJ4Qks1?=
 =?utf-8?B?SWE1ZDlSSFh0Rk80TG12THBQbS9GWDhRY2w1aWQ1K1JDaEV2ZmQ3SmdZLytt?=
 =?utf-8?B?WjZ0cHlmYmdETVBUclhMbURYOHM4NE1MWVBtUWdaakptWDBrVVduNkN6Wkl4?=
 =?utf-8?B?Q2J3U0MxY0laajRWcktUaEZmTmc4dGd0c2x4OUp6K3pXMVFibGZ6dFY2Wm53?=
 =?utf-8?B?VklpcGQwQ05jQzJpQVpucFpIemdLai8zS1dwMWNqYVo4OGV4cGRtQWtJYXR4?=
 =?utf-8?B?Vm93SUhYZVY2VldrZlRUSmRpc3F6MlAxWXdrZmd3alkvQjBFK3VoNnZZbXhu?=
 =?utf-8?B?WDFJVDVJL2Zia1N0dXhjazJ5c0lsbnR2Ri9FTDZPUWFRekttdUZvTWFGcU5n?=
 =?utf-8?B?MFdHbDhJcTljUWxXSlRST3E2OGt6K2lzVEhvZ0o5MURxd2lpU0Q5b25wcERr?=
 =?utf-8?B?WmJTdTRiVTNTU05LMkE0WlZteTFFZVFkOW9hdjk0SXM5U0hpRnZWeERRTXp2?=
 =?utf-8?B?dVpUcU9ZQURuaS81TWFvcXVyTVN6dnBnNlBpSjB1Wmtlb0QwL1JUMG84SzJy?=
 =?utf-8?B?aTZTZmdTWjNYUjliRUhtS3VyaVhMWVUvaFhTeENVN08wMDBHT05nN0YxKzdZ?=
 =?utf-8?B?OUQyUGdRWHBMZVVoMmlqOWtqcEVvNjR3TVcrWUViOFA1RS9aVmZNWDJDd2Zh?=
 =?utf-8?B?aXhHZnhFb1BUYVZnUE5YZGg4a080N3Fhc3Z1VmVMek9rZ1pMVUhmUkRCR0JO?=
 =?utf-8?B?SlczRFZWZFlaa3cxMGw3cDgxd1c2RUZ5Mk9oRUIyREJNSWFLallGUmJ0bEgv?=
 =?utf-8?B?NzJRV2NGYWJuMEVmK3BZR2E3UDk2MkhzbmVIbmR6YXpKbjFkd2phVDI3bmJk?=
 =?utf-8?B?bFdIV2dOOW5tbUc0QWEvU2JkaGoraXlPUGZzRzBQL0hNRitVd1ZxWTMyKzRw?=
 =?utf-8?B?ZnlZU3Zzc2dsVVB6amgxYmJ3aGRCai9XVmx0cUIxWlFxbWFMVDdhZE5oS3dk?=
 =?utf-8?Q?bfnTi6d7cLxTCxXFJd4+3Zleh2+sVUEO4kLR976qVI24?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16C8D35FCA5EF84692925CEDFA618EB7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32300d56-2eeb-4979-f3bc-08dc84f2e490
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 00:03:13.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQVleE+4yJ21APnuVIiV6dK2TDZPfmTMyJUdASVZ8YJHXNpANQRm2tAmKkQWbhSmxhpZGCJjsb1Q9wEPKjFlkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8751
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_171811_226531_C8FEDD48 
X-CRM114-Status: UNSURE (   7.98  )
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

T24gNi8zLzI0IDA1OjU3LCBXZWl3ZW4gSHUgd3JvdGU6DQo+IENEUi9NT1JFL0ROUiBmaWVsZHMg
YXJlIG5vdCBiZWxvbmdpbmcgdG8gU0MgaW4gdGhlIE5WTWUgc3BlYywgcmVuYW1lDQo+IHRoZW0g
dG8gTlZNRV9TVEFUVVNfKiB0byBhdm9pZCBjb25mdXNpb24uDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IFdlaXdlbiBIdTxodXdlaXdlbkBsaW51eC5hbGliYWJhLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K

