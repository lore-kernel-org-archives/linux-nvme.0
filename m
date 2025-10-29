Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65234CCD1BF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 05:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=haNnS6FZA9prnK3tAhJgdBA979d3Zt4lwP+U6LZ9tII=; b=STUqpCuLzgjMyn9+BWPngqtPqy
	1zuzUGLgd9bXhq00U83LOQrJnOQSw79duN5LAfMEUD154mB8LbAK2TYZK8DNh8xaK/uCo90iDrseL
	VimzNNYy8cz63YBmDsg7OJ3D6NToAHz7hgW4pcl2ajUexzRIkiT0moplppmgJcPXYk8n7J5lffH2S
	/0R8DjcmdE9f4ki6Z+WRP05/BwpnhLOBsPh1jYS2Dvg6tUHeX/UTFIdXYK12wAxlItqm25gvW31ew
	UORlVFZrSpPuimpjI+c2/2+yR74Bve8sPDxWiYDrQB2AU8ngQDvWKbugBSPQRf6RMsb/PzvbdA/Li
	R3wQSLXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDyKz-0000000HG7m-0W8O;
	Wed, 29 Oct 2025 05:03:09 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDyKx-0000000HG6u-14F3
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 05:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udpZL3QZ1l5mGYsqpHrQEoTXe4SVh1bUzyjWkWKz04/DkD/1dFBDKE8R0uPhvaAfQ/GcB0D/8SWDTc169zc2klWFKg18hzx6u+bBD7x5txnFc8vwAOiBVfgyl81GlNlzIyLP5h1AQXgBouuZKkGTe0gvm3ZekxOZqJga8vOR9ohEa/okPN5wRVRK3eihJwDxcJ/BhCcEsJNrXpYCNBVSIFSshEezM5P11QksTrbXsYHvDLkMnm00aqGWTKMK7zi53ABGyYTCeSmDRROhiQnazKouy7RMgwOO4TxM8kegsl9IaiaLnQELLBKI+e/Tvl8p6JTtBeCOm/rGVkOa8UAX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haNnS6FZA9prnK3tAhJgdBA979d3Zt4lwP+U6LZ9tII=;
 b=nzprdNCiz5842sgom/Po6YAMXa5ysezt/yFhWKtgAGKQx19xrsFAovcii+eLYrcTU+jf3aY/Z1V55hTvPzrmCzoIMRV26LJNubOFdpJJsaWG2cMnsLKubJn2GzQ9DotPTxV7VG90+XE+abwAKoEjpxy572JNqppLnfJl9Lj6NjwqSZhAXqFH1skJGt3HYD6fPzfe2t7ngpldsWxKOnCPsNI0hPoYoK1uTXQLfxnkblE43pY/YvXlv6DUW8Gi6UjfiS8zYF0zBsHEUNQYuF7gAM9wLotXCR1uT13aXwJbG0wnA/dEplCNB63n1awamq52CewZoSPjHt5J0KWY1LqP5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haNnS6FZA9prnK3tAhJgdBA979d3Zt4lwP+U6LZ9tII=;
 b=JEdCnpdzoVpKtdQCaOPJe33pTf0OsYRBZkRKNC0PpnpKdjXr5vXOfqiLU5x0AFLT+zIEQhfrJ+xqT8FmDdzgfZ8nPthH+fu9x/P9tCVfwNV6O1SrmIE9O/kJqq4UaF8yB17LvSHcjqm0xUnO5BK9t4UD6eN9IfxIrF58tCB1ce3QA3RmTMcYm+MSNAfH4mJAMAiAlpedsj2NwZACN5W7HtCW4CliJnkvZ66a7PK+e0ZadV9X+v4kR6YkGwxrrk+PDYUePhkhtsXEeUiR5/l9d0qCCSWEfxyAL2mo4loyrPenKkGOA96wt1jC0m/Mn8IVh9t31ybVmWPfUD9+f/HZCQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 05:03:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 05:03:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens
 Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH] nvme: introduce panic_on_double_cqe param
Thread-Topic: [PATCH] nvme: introduce panic_on_double_cqe param
Thread-Index: AQHcQ1uPZ/XVoVOMEkSObv1C0WAkpbTPMQwAgAkyuYCAACthAIAADLqA
Date: Wed, 29 Oct 2025 05:03:00 +0000
Message-ID: <2ed05044-7d62-4426-b4bf-05869c02bef5@nvidia.com>
References: <20251022135454.75767-1-kanie@linux.alibaba.com>
 <6dc4c33e-8183-481c-a101-8a2b6596d2b1@nvidia.com>
 <36c2cec2-7d0b-4ee6-a79f-d5e318a8fee0@linux.alibaba.com>
 <3d8c3319-9f46-48fc-aaef-181322329c88@nvidia.com>
In-Reply-To: <3d8c3319-9f46-48fc-aaef-181322329c88@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7030:EE_
x-ms-office365-filtering-correlation-id: 0cfd01a3-ebad-48c8-b77f-08de16a86eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RzExQTNEU2grT2JYemlrb0VsbVRZYUZyRFhZQ0M2OEp5bWRIRmNFYXNyRGNU?=
 =?utf-8?B?bTYvYld3Um5ZZmVyb2Y1eVU3YUFINFcvc2wvWWV6cHRWcEZORnBzUmZsdkxV?=
 =?utf-8?B?QnJ0T0dwSEZoMHFaU0lQOHZsS0NtNUlKdXNyUmFiL05sRXFWTnlkR0dkTUZP?=
 =?utf-8?B?d3kyN05hSUZaVm00TS9XTVgvVUpSUmxwWWw2LytId2tibXQ1VU9IQW1UNG9l?=
 =?utf-8?B?RWdvL0NPcWQ5cWh0UkhQRTVvRDBQZ0xESXZpajlSZGRCSUdVbnlMdkIxcmpP?=
 =?utf-8?B?RmsvK2x4WGt2TTFUK1ZJQnc2L0dlRnZxdmZNVEpiODB1S1kzMThDemZ2MlN3?=
 =?utf-8?B?MDRYYUN4Zm4rMTJ4eEx4QldyQjZIMHhIL1kvOTlLS2RTK0NZRE43U2ZLNVdo?=
 =?utf-8?B?SnpmM1dlaFJnS0RzTE05OTEySWVvbGsvbDhSTWpGSHVkNWZUanZKYW5icUVs?=
 =?utf-8?B?UGdPSHliUjRmUGppbVRaNUVmeTAwZ1h6VmpuUDNjVnlSMHdqVEIyM3RQUEhD?=
 =?utf-8?B?N0JHU3YrK0w2dXF0ZnphV0NzOGNWQm8yUGVZSGoyd3NBNlZVTmNxK29wMWc2?=
 =?utf-8?B?b2toaCtyOWJmeXE2TFVlOXBVQnR6UU9RaG5XWis0SmZJZzFlSmEra1JFNk0v?=
 =?utf-8?B?WmluNGQ5aVl0L1g0aDk0N0dzcmg1anllZnQ5V0MvclJORkV1ZEdvaFJabE1N?=
 =?utf-8?B?ZWNSQ2dyVXlLZ1BBT0JoUTc1b29NOXRzZTFQOUFaSkdwUTI2U1dLalpwbHJI?=
 =?utf-8?B?STUvTTRCVWFJZFU0TXlYaklRV1J3dnhTRkMrT3ZDZmVQeDliaEhNMXFhODN0?=
 =?utf-8?B?RWc0Y1ZBbjU4VSsvRlhFZWUwSnhzSzF5UjRMK21KdDY2RmVRSzZ3dHpvQjhD?=
 =?utf-8?B?TDJWalV1bWxLbzVZRkJGWTIvbDRUVWt6MWFuR0FIKzBSWlpzN2lKR0xBdXps?=
 =?utf-8?B?NlduUnlBM282OERieS9HazBWZFQ2ZWl4ZVA4Q1UvbEY1UmVJNlhDRnJGamhV?=
 =?utf-8?B?Z1RKa2dwemxZclpUYWw1LzJ0QW9JelNpYThxMjd3cnNnaWNKTG5zWU1ocHVW?=
 =?utf-8?B?Q0JJZCsxZ21nZnNOUUhVcHRnWlp2VDArcld1UWdpN1ExWUtQSEdwS21ldjlh?=
 =?utf-8?B?a21ZT3VOK294bXA1RmlVdk1aRnVadTlaMXBXRE54MVVzc0MxclVpWWQvSzgx?=
 =?utf-8?B?c3dyUjR2UFlPTXVYdUlUYXM0Rmg4d1RJMm0zaW0xNkp4bDZRMExqYTU2UmdT?=
 =?utf-8?B?OExmZFROSlpFcE56eXNTWDZoUHBaaHF2WUFXaTZzKzJ6UVJnb21YY1UwclQ4?=
 =?utf-8?B?M0gxWXNjWjZJdk9wM3p6MklNbW1BQWwvVFlscFh6ZGU2ZXZwWWhLdXZxaWpN?=
 =?utf-8?B?WHViaG51SXNabFUyRTEyc3krYzhidG9TZjVtZVh4SW9LaEJIYXF4Tmg2UUpN?=
 =?utf-8?B?OHZFNjg5bkZXV01tK3VCNWwyVzdnT3lObmp1Z01lRjJkbnJ6ajJUZmU3U2tQ?=
 =?utf-8?B?czR5VGk4bUxaVUNrMnlPV21CcU40Vmp5NThXVzcwRTVhemdPTEEzMDJ4cnNi?=
 =?utf-8?B?Vy9pYkEvbjlEVVk0NXFjU2dJVWlGQ00vc3EzODM3R0VhdlJ2Z1BidnhTLytP?=
 =?utf-8?B?Q2tLRkNsMm83a1VFOWJ2NWM3VlJBQ3NoRjIrYmhwN0pWMVRaUGYzZXhZWWRI?=
 =?utf-8?B?VHZ6eTY4U1JzRkVjVWhjQW41MTJhU21pbzM4RkU1ZFUxeVV5V3lobUIrSy9Y?=
 =?utf-8?B?dUpBbXFBbHQ5YUQyMjVSSkRuZnNTVmNwY0M5Ukw4OHdpMlBRL2UrVmR2M3VW?=
 =?utf-8?B?MmlkSUNRWThMditqYU9jRzJYaE9RbDZtQkVaWXl5Yy9qeHpGRy9lQTNwa0F4?=
 =?utf-8?B?Wit1RnFZQytqdGZUazFzMTkwd0FHUGFvOGlJdGxKZDJWUXo4SkdqRVJBNUd2?=
 =?utf-8?B?VFdiMjcrajFEang5YWl4R1RPZVFEWWxwOVZQbS9VVEdWVDJnSDAwby9SZVhJ?=
 =?utf-8?B?cmFsTFNnM1FLY1VLcFZ6cDNwL0c4VFdhRTEzOW9XbE9sYmpzSjZNNnBrajE0?=
 =?utf-8?Q?oUqEhB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXJPcGlDR3BaUC9UeHVrTzJTclloOC8zN3dvWFR4KzVOd284eGNFM1A5SXV4?=
 =?utf-8?B?aFUrdXlqK3BRamRQQktZTWsyRHV6ckhPTnNIUElUbVJuRWpVcjRFT25iaXJt?=
 =?utf-8?B?c0ZZM3F0SVBQNHZqRUl6NElJMTFSVkpPSjJSc2xCbkpzVnpSRUE3V3g2ajk2?=
 =?utf-8?B?ZFJ3TW8rOEUybHczcU1lRC9sMmQzb28wSm52eHg5Qzh2bHlBSXRNMHdyc3FE?=
 =?utf-8?B?c1NIaDBTZy9kcC9rblhsNzVJcGV2ZExNS2ZGOXhWa215WTNiaVpNK093OVIx?=
 =?utf-8?B?THZVQWRYb0FjdkpiMkhneHo5cFA5amxTc284TGZqeW5nMmZCUm5tQjBOUWVj?=
 =?utf-8?B?aFl2bEFNR0xQL1Qwa2pVV05GS25MMjZsdHlBaktVV0tCMC81M2t2MGRIb0xi?=
 =?utf-8?B?Z1Z4ZU5vMHhzRXlUeG1GQ2dIb21NT0wyK0ljZmNVclg3Mm91SnBKS3licGY4?=
 =?utf-8?B?cnhtNUhZTWhaT1E3Q3pRTDMzcDhzKzBSMy9WTThKb2xIL2xMSTRlV2UxZXZx?=
 =?utf-8?B?S3RrdkM0OFpnbE1jV2tLdzZBdmhsaVdYVGZyWEpHcHRrREVtWHczcndYbDgv?=
 =?utf-8?B?dFhWQVYzckgzakhrN1NhcDBBUjV5bHNhYmVwREZyamt3U0FWNFd6RTMwdGFU?=
 =?utf-8?B?cnlPN1dRcnJJQTc4Vmt2VkhHdGdoVFNXRzlaamxUbmd3WTd4WUhveGVPVFQ4?=
 =?utf-8?B?b3NsSTBKdVU3YkljWW1vbGFXWGZsaWNiUmVIUE9VMjgzK1UwYVAxYW01RVpS?=
 =?utf-8?B?dXlBR085Q0pYRVA2U1ZnYUdaM2pDYmZEQVlGWERSVGRBaGR5MCs0emRxK3E4?=
 =?utf-8?B?bjkvQjY2N3BuYUsrNm55MVFxQXJLRWtyVVpiZ1NJTGdiOGVnT01wVkhKZnNz?=
 =?utf-8?B?YjFPbTF3SHZ4Ym1QMXh6dzZKTDh3b2VaWmZicy8wbFVxY0dRNEJsWHIwVnZr?=
 =?utf-8?B?WjFnczBWWVNRZnVMQi9aNDFiQjhKOGd3VmYxRENSVVJtNThJOHlsbkJGYnVB?=
 =?utf-8?B?S3B2NVNCRXUvUGlHR0xneWl2RFdtQjNrcEYvMExwdUNwR3RBYzg1bkJuNXpo?=
 =?utf-8?B?NmYvMHRMbjBzTC9nVTZ2MDZnS0NOT3duS1BmUDN2YWtHNEt5djcwU0lKZ2VO?=
 =?utf-8?B?OHUvYldjQnduZ2xJZG5RUXgzMmZWUnlKYkJhRDJ3U041em1peFpRWVFkYzJ1?=
 =?utf-8?B?UGZxK1FKa3ZYWFpwUU1aWGRPREVDN3lYM0ZWeStjamVQZGlxMGRZZWNsUEhR?=
 =?utf-8?B?WmRIUVlIWXkvR0x0STdJN240V0FJNS9rK3dMWmY5anRLb2NmekdOWlRtdElO?=
 =?utf-8?B?MGNrWmhzR3hLem9MbHhZT1V5WDdHb2xWMlI5VC9aV3FYZjZRV3Q0b3RlWG9x?=
 =?utf-8?B?aVpnY1RLWkNESThIcUhYUlhJRnFRVWk2K29hN0VOeCtFZXZKaDRCVFJTa0tH?=
 =?utf-8?B?YUZlN0RpK3N6ajlpREhQT3RuUWM4RDA0eXdiZTdPWjROWDlVbFluaU1DMXFL?=
 =?utf-8?B?VTVVc1BCbExVakl6ZXZibXdNY3ZhVlRvZ1UxMC9PbnRVdW5WSTgrK2ZwYmlU?=
 =?utf-8?B?V3ZDdFNOeXhCbEsrTXI5V1RHa05NVWYzYklKNUdZLytsUW9CSjRJakI1NURo?=
 =?utf-8?B?Ty9FM05hM3RyQ0E5S1dRcGpVUC9tQ1IxZXovbmRkc3dXR2tOUmkxUEg1Qnps?=
 =?utf-8?B?VWxraDMyMk5Fd3JnWTBxREZqVnBueHVJQUVOVHBiUkxsQ2RzaW4xMFRDeTht?=
 =?utf-8?B?eFRFUkdKeUFrQ0gwOGlldktkd1NybWlNelhndDRBVE5jdG9KWVJ4UkhKWUUw?=
 =?utf-8?B?czVxZ3JSNTVyNFdaZUE4ckFKYUMwVTJJYVlKYWFSUTZCK3Q2eWNicjJyYVIr?=
 =?utf-8?B?WjVtNDAxZzEwUC9uM0dJUGVjR0R0Q1c1Mlo4VUlteG5RVVY4bThGR3U5M2pF?=
 =?utf-8?B?VnFFVXF0VWh0SGREKzU3THB5UDdhRUVCRmhKcnhPVzhEa2xiU0wrNFhwVFht?=
 =?utf-8?B?Q0Q0cWtWS0lrR0drUkYrWUtUcnZZcUtzdkh3SHRneDRja09tWjEzZ1c3WlE1?=
 =?utf-8?B?QzAzMkI2NStMTW9RMTZST3RCOTJKSitTTFJRbkh0R1lOY0JEbUhVYm00THMz?=
 =?utf-8?B?Sy9HZWhIOExlQVBHS0RhYnpwWTlEYStiZXpWbC9UWXNKdlQ3cWVyM1VpR1NO?=
 =?utf-8?Q?BNh1BN2hAHTPIfJxZJN06xRrIfNlhOQVQnseiAgHkZ9q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09007DB41E08DA4984060838F1DB8A79@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfd01a3-ebad-48c8-b77f-08de16a86eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 05:03:00.0480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtHSi5i7XWoFTzqju+hS7ESjjl+0VzPsUkKvs8QiSDkR1p13NglhwxFT+nWW4anJWULvkmPKAZr5OzJkrRrgfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251028_220307_343210_B5534E36 
X-CRM114-Status: GOOD (  21.64  )
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

T24gMTAvMjgvMjUgMjE6MTcsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gT24gMTAvMjgv
MjUgMTg6NDIsIEd1aXhpbiBMaXUgd3JvdGU6DQo+Pg0KPj4NCj4+IOWcqCAyMDI1LzEwLzIzIDEz
OjE0LCBDaGFpdGFueWEgS3Vsa2Fybmkg5YaZ6YGTOg0KPj4+IE9uIDEwLzIyLzI1IDY6NTQgQU0s
IEd1aXhpbiBMaXUgd3JvdGU6DQo+Pj4+IEFkZCBhIG5ldyBkZWJ1ZyBzd2l0Y2ggdG8gY29udHJv
bCB3aGV0aGVyIHRvIHRyaWdnZXIgYSBrZXJuZWwgY3Jhc2gNCj4+Pj4gd2hlbiBkdXBsaWNhdGUg
Q1FFcyBhcmUgZGV0ZWN0ZWQsIGluIG9yZGVyIHRvIHByZXNlcnZlIHRoZSBrZXJuZWwNCj4+Pj4g
Y29udGV4dCwgc3VjaCBhcyBzcSwgY3EsIGFuZCBzbyBvbiwgZm9yIHN1YnNlcXVlbnQgZGVidWdn
aW5nIGFuZA0KPj4+PiBhbmFseXNpcy4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogR3VpeGlu
IExpdSA8a2FuaWVAbGludXguYWxpYmFiYS5jb20+DQo+Pj4+IC0tLQ0KPj4+PiDCoMKgIGRyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYyB8IDUgKysrKysNCj4+Pj4gwqDCoCBkcml2ZXJzL252bWUvaG9z
dC9udm1lLmggfCAzICsrKw0KPj4+PiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+Pj4gaW5kZXggZmE0MTgxZDdkZTczLi43YTNmOTEy
OWEzOWMgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPj4+PiAr
KysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+Pj4gQEAgLTk1LDYgKzk1LDExIEBAIG1v
ZHVsZV9wYXJhbShhcHN0X3NlY29uZGFyeV9sYXRlbmN5X3RvbF91cywgDQo+Pj4+IHVsb25nLCAw
NjQ0KTsNCj4+Pj4gwqDCoCBNT0RVTEVfUEFSTV9ERVNDKGFwc3Rfc2Vjb25kYXJ5X2xhdGVuY3lf
dG9sX3VzLA0KPj4+PiDCoMKgwqDCoMKgwqAgInNlY29uZGFyeSBBUFNUIGxhdGVuY3kgdG9sZXJh
bmNlIGluIHVzIik7DQo+Pj4+IMKgwqAgK2Jvb2wgcGFuaWNfb25fZG91YmxlX2NxZTsNCj4+Pj4g
K0VYUE9SVF9TWU1CT0xfR1BMKHBhbmljX29uX2RvdWJsZV9jcWUpOw0KPj4+PiArbW9kdWxlX3Bh
cmFtKHBhbmljX29uX2RvdWJsZV9jcWUsIGJvb2wsIDA2NDQpOw0KPj4+PiArTU9EVUxFX1BBUk1f
REVTQyhwYW5pY19vbl9kb3VibGVfY3FlLCAiY3Jhc2ggdGhlIGtlcm5lbCB0byBzYXZlIA0KPj4+
PiB0aGUgc2NlbmUiKTsNCj4+Pj4gKw0KPj4+PiDCoMKgIC8qDQo+Pj4+IMKgwqDCoCAqIE9sZGVy
IGtlcm5lbHMgZGlkbid0IGVuYWJsZSBwcm90ZWN0aW9uIGluZm9ybWF0aW9uIGlmIGl0IHdhcyAN
Cj4+Pj4gYXQgYW4gb2Zmc2V0Lg0KPj4+PiDCoMKgwqAgKiBOZXdlciBrZXJuZWxzIGRvLCBzbyBp
dCBicmVha3MgcmVhZHMgb24gdGhlIHVwZ3JhZGUgaWYgc3VjaCANCj4+Pj4gZm9ybWF0cyB3ZXJl
DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252
bWUvaG9zdC9udm1lLmgNCj4+Pj4gaW5kZXggMTAyZmFlNmEyMzFjLi4yNDAxMGQ1ZDE1Y2UgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPj4+PiArKysgYi9kcml2
ZXJzL252bWUvaG9zdC9udm1lLmgNCj4+Pj4gQEAgLTU5NSw2ICs1OTUsOCBAQCBzdGF0aWMgaW5s
aW5lIHUxNiBudm1lX2NpZChzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+Pj4+IMKgwqDCoMKgwqDCoCBy
ZXR1cm4gbnZtZV9jaWRfaW5zdGFsbF9nZW5jdHIobnZtZV9yZXEocnEpLT5nZW5jdHIpIHwgcnEt
PnRhZzsNCj4+Pj4gwqDCoCB9DQo+Pj4+IMKgwqAgK2V4dGVybiBib29sIHBhbmljX29uX2RvdWJs
ZV9jcWU7DQo+Pj4+ICsNCj4+Pj4gwqDCoCBzdGF0aWMgaW5saW5lIHN0cnVjdCByZXF1ZXN0ICpu
dm1lX2ZpbmRfcnEoc3RydWN0IGJsa19tcV90YWdzIA0KPj4+PiAqdGFncywNCj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdTE2IGNvbW1hbmRfaWQpDQo+Pj4+IMKgwqAgew0KPj4+PiBAQCAtNjEy
LDYgKzYxNCw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHJlcXVlc3QgDQo+Pj4+ICpudm1lX2Zp
bmRfcnEoc3RydWN0IGJsa19tcV90YWdzICp0YWdzLA0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkZXZfZXJyKG52bWVfcmVxKHJxKS0+Y3RybC0+ZGV2aWNlLA0KPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJyZXF1ZXN0ICUjeCBnZW5jdHIgbWlzbWF0Y2ggKGdvdCAlI3ggZXhw
ZWN0ZWQgJSN4KVxuIiwNCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YWcsIGdl
bmN0ciwgbnZtZV9nZW5jdHJfbWFzayhudm1lX3JlcShycSktPmdlbmN0cikpOw0KPj4+PiArwqDC
oMKgwqDCoMKgwqAgQlVHX09OKHBhbmljX29uX2RvdWJsZV9jcWUpOw0KPj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gTlVMTDsNCj4+Pj4gwqDCoMKgwqDCoMKgIH0NCj4+Pj4gwqDCoMKg
wqDCoMKgIHJldHVybiBycTsNCj4+Pg0KPj4+IEknbSByZWFsbHkgbm90IHN1cmUgdGhpcyBpcyBh
IGdvb2QgaWRlYSwgSSdsbCBsZWF2ZSB0byBvdGhlcnMuDQo+Pj4NCj4+Pg0KPj4+IC1jaw0KPj4g
WWVhaCwgSSB0aGluayBzbyB0b28sIGFuZCBJJ2QgYWxzbyBsaWtlIHRvIGZpbmQgYSBtb3JlIGVs
ZWdhbnQgc29sdXRpb24uDQo+Pg0KPj4gQmVzdCBSZWdhcmRzLA0KPj4gR3VpeGluIExpdQ0KPj4N
Cj4NCj4gV2hhdCBhYm91dCBsb2dnaW5nIHRoZSBuZWNlc3NhcnkgaW5mb3JtYXRpb24gYW5kIHN0
aWxsIGNvbnRpbnVpbmcgdGhlIA0KPiBzZXR1cCA/DQo+IFdoZW4geW91IGFyZSBkZWJ1Z2dpbmcg
eW91IGNhbiBhbHdheXMgc2V0dXAgYSBicmVha3BvaW50IHRoZXJlIGFuZCBnZXQgDQo+IHRoZSBz
eXN0ZW0gc3RhdGUgaW4gdGhlIGJyZWFrcG9pbnQsIHNvbWV0aGluZyBsaWtlIGZvbGxvd2luZyB0
b3RhbGx5IA0KPiB1bnRlc3RlZCA6LQ0KPg0KPiBVc2FnZToNCj4gIyBFbmFibGUgYXQgcnVudGlt
ZQ0KPiBlY2hvICdtb2R1bGUgbnZtZSArcCcgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9keW5hbWljX2Rl
YnVnL2NvbnRyb2wNCj4NCj4gIyBPciBhdCBtb2R1bGUgbG9hZA0KPiBtb2Rwcm9iZSBudm1lIGR5
bmRiZz0nK3AnDQo+DQoNCnNvbWV0aGluZyBpcyB3cm9uZyB3aXRoIG15IG1haWwgdHJ5aW5nIGl0
IGFnYWluIDotDQoNCiDCoGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgNDggKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCiDCoDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KaW5kZXggYzkxNjE3NmJkOWYwLi5h
OWY5YzYxZDNmYzkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KKysrIGIv
ZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCkBAIC0xMjk0LDYgKzEyOTQsNTAgQEAgc3RhdGljIGlu
bGluZSBzdHJ1Y3QgYmxrX21xX3RhZ3MgDQoqbnZtZV9xdWV1ZV90YWdzZXQoc3RydWN0IG52bWVf
cXVldWUgKm52bWVxKQ0KIMKgIMKgIMKgcmV0dXJuIG52bWVxLT5kZXYtPnRhZ3NldC50YWdzW252
bWVxLT5xaWQgLSAxXTsNCiDCoH0NCg0KKy8qKg0KKyAqIG52bWVfaGFuZGxlX2R1cGxpY2F0ZV9j
cWUgLSBIYW5kbGUgZHVwbGljYXRlIENRRSBkZXRlY3Rpb24NCisgKiBAbnZtZXE6IFRoZSBxdWV1
ZSB3aGVyZSBkdXBsaWNhdGUgd2FzIGRldGVjdGVkDQorICogQGNxZTogVGhlIGNvbXBsZXRpb24g
cXVldWUgZW50cnkNCisgKiBAY29tbWFuZF9pZDogVGhlIGNvbW1hbmQgSUQgZnJvbSB0aGUgQ1FF
DQorICoNCisgKiBMb2dzIGRldGFpbGVkIGluZm9ybWF0aW9uIGFib3V0IHRoZSBkdXBsaWNhdGUg
Q1FFIGluY2x1ZGluZyBDUUUgZGV0YWlscw0KKyAqIGFuZCBmdWxsIHF1ZXVlIHN0YXRlIHRvIGFp
ZCBpbiBkZWJ1Z2dpbmcgaGFyZHdhcmUgb3IgZmlybXdhcmUgaXNzdWVzLg0KKyAqLw0KK3N0YXRp
YyB2b2lkIG52bWVfaGFuZGxlX2R1cGxpY2F0ZV9jcWUoc3RydWN0IG52bWVfcXVldWUgKm52bWVx
LA0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBudm1lX2NvbXBsZXRp
b24gKmNxZSwNCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1MTYgY29tbWFuZF9p
ZCkNCit7DQorwqAgwqAgc3RydWN0IG52bWVfZGV2ICpkZXYgPSBudm1lcS0+ZGV2Ow0KKw0KK8Kg
IMKgIGRldl9kYmcoZGV2LT5jdHJsLmRldmljZSwNCivCoCDCoCDCoCDCoCAiRHVwbGljYXRlL0lu
dmFsaWQgQ1FFIGRldGVjdGVkOlxuIg0KK8KgIMKgIMKgIMKgICLCoCBRdWV1ZTogJWQgKFNRIElE
OiAldSlcbiINCivCoCDCoCDCoCDCoCAiwqAgQ29tbWFuZCBJRDogJXVcbiINCivCoCDCoCDCoCDC
oCAiwqAgU3RhdHVzOiAlI3hcbiINCivCoCDCoCDCoCDCoCAiwqAgUmVzdWx0OiAlI2xseFxuIg0K
K8KgIMKgIMKgIMKgICJRdWV1ZSBzdGF0ZTpcbiINCivCoCDCoCDCoCDCoCAiwqAgUXVldWUgZGVw
dGg6ICV1XG4iDQorwqAgwqAgwqAgwqAgIsKgIFNRIHRhaWw6ICV1LCBsYXN0X3NxX3RhaWw6ICV1
XG4iDQorwqAgwqAgwqAgwqAgIsKgIENRIGhlYWQ6ICV1LCBwaGFzZTogJXVcbiINCivCoCDCoCDC
oCDCoCAiwqAgQ1EgdmVjdG9yOiAldVxuIg0KK8KgIMKgIMKgIMKgICLCoCBTUSBETUEgYWRkcjog
JXBhZFxuIg0KK8KgIMKgIMKgIMKgICLCoCBDUSBETUEgYWRkcjogJXBhZFxuIg0KK8KgIMKgIMKg
IMKgICLCoCBGbGFnczogJSNseCAoZW5hYmxlZD0lZCwgc3FfY21iPSVkLCBwb2xsZWQ9JWQpXG4i
LA0KK8KgIMKgIMKgIMKgIG52bWVxLT5xaWQsIGxlMTZfdG9fY3B1KGNxZS0+c3FfaWQpLA0KK8Kg
IMKgIMKgIMKgIGNvbW1hbmRfaWQsIGxlMTZfdG9fY3B1KGNxZS0+c3RhdHVzKSwNCivCoCDCoCDC
oCDCoCBsZTY0X3RvX2NwdShjcWUtPnJlc3VsdC51NjQpLA0KK8KgIMKgIMKgIMKgIG52bWVxLT5x
X2RlcHRoLA0KK8KgIMKgIMKgIMKgIG52bWVxLT5zcV90YWlsLCBudm1lcS0+bGFzdF9zcV90YWls
LA0KK8KgIMKgIMKgIMKgIG52bWVxLT5jcV9oZWFkLCBudm1lcS0+Y3FfcGhhc2UsDQorwqAgwqAg
wqAgwqAgbnZtZXEtPmNxX3ZlY3RvciwNCivCoCDCoCDCoCDCoCAmbnZtZXEtPnNxX2RtYV9hZGRy
LA0KK8KgIMKgIMKgIMKgICZudm1lcS0+Y3FfZG1hX2FkZHIsDQorwqAgwqAgwqAgwqAgbnZtZXEt
PmZsYWdzLA0KK8KgIMKgIMKgIMKgIHRlc3RfYml0KE5WTUVRX0VOQUJMRUQsICZudm1lcS0+Zmxh
Z3MpLA0KK8KgIMKgIMKgIMKgIHRlc3RfYml0KE5WTUVRX1NRX0NNQiwgJm52bWVxLT5mbGFncyks
DQorwqAgwqAgwqAgwqAgdGVzdF9iaXQoTlZNRVFfUE9MTEVELCAmbnZtZXEtPmZsYWdzKSk7DQor
fQ0KKw0KIMKgc3RhdGljIGlubGluZSB2b2lkIG52bWVfaGFuZGxlX2NxZShzdHJ1Y3QgbnZtZV9x
dWV1ZSAqbnZtZXEsDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IGlvX2Nv
bXBfYmF0Y2ggKmlvYiwgdTE2IGlkeCkNCiDCoHsNCkBAIC0xMzE1LDkgKzEzNTksNyBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgbnZtZV9oYW5kbGVfY3FlKHN0cnVjdCANCm52bWVfcXVldWUgKm52bWVx
LA0KDQogwqAgwqAgwqByZXEgPSBudm1lX2ZpbmRfcnEobnZtZV9xdWV1ZV90YWdzZXQobnZtZXEp
LCBjb21tYW5kX2lkKTsNCiDCoCDCoCDCoGlmICh1bmxpa2VseSghcmVxKSkgew0KLcKgIMKgIMKg
IMKgIGRldl93YXJuKG52bWVxLT5kZXYtPmN0cmwuZGV2aWNlLA0KLcKgIMKgIMKgIMKgIMKgIMKg
ICJpbnZhbGlkIGlkICVkIGNvbXBsZXRlZCBvbiBxdWV1ZSAlZFxuIiwNCi3CoCDCoCDCoCDCoCDC
oCDCoCBjb21tYW5kX2lkLCBsZTE2X3RvX2NwdShjcWUtPnNxX2lkKSk7DQorwqAgwqAgwqAgwqAg
bnZtZV9oYW5kbGVfZHVwbGljYXRlX2NxZShudm1lcSwgY3FlLCBjb21tYW5kX2lkKTsNCiDCoCDC
oCDCoCDCoCDCoHJldHVybjsNCiDCoCDCoCDCoH0NCg0KLWNrDQoNCg==

