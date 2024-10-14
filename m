Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FC0CF259D
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 04:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9HT+ROqGa9RoXDYP3mL7svW6GdKzw+Vzrugch0IJaZQ=; b=QsI2J9y/6BGTwWeAkbNlJpf06G
	Wb6iBm3L49+upUanAnexoVMxk5aH+mM33PIV8pZTwd7JYYBAz3UhpLabovc9rqLfB+KcfqzUg0S3p
	2dm8YQS+UStt+33t/rpeb2K07O/UyDO26gfUvH9PcoZR3G4vTkLiRLogS8VTbKIkJ5aJPFFtZAO8a
	lHge30eMJfwifBvyEAyn6fUnhp6Dmr7L1H2ag7vnkJ7Kp16SaXFQSyXZb/H7KwNsRKtAwu730wKxD
	IgfJZFYAu/sxHp1cLh7skxqdsWGsXpK1Z3j7HKOr95+X8CkN/IH8tBiHpxAGKOkwaR8inTMq/7Uo0
	WaR4b8Gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0CKc-00000003gBn-3fp0;
	Mon, 14 Oct 2024 04:05:18 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0CKV-00000003gAt-3d6a
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 04:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4wOUGk5lY3RoY87VAHUPAnTrwg2tEUePLQ9xtzGnPu2At1fgP1AAJXjn5pwvh7idhDqAwxTYt37LO5yLUc/504gmXXTVZF3QpCuplm3YLqSL7fuRL+Pcqjd4HsSsbN6f9BNR5eGFHErQcqX3mtTHuyElNLAHXdoXUKukA4opnTyq4RemnJU3UIi1l0JQEL7MNPh49eRtZ2kpKY04UUWDjQhvTOr4B5aFoTYT1Q34DqJ/WvVj7jipyXlRtQOEUJA4t8Nd6G1CcUdAnUjahSDp7ZrGwQtsf7zDdqgxOtG9+ySzkbtflUiqq0SYkqrHS6Za1F64/TbzAuqEkElpTP6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HT+ROqGa9RoXDYP3mL7svW6GdKzw+Vzrugch0IJaZQ=;
 b=M8dlpXpcXOSYrgLQcIT28YEZ8J1b5vVoPmkrPWZ71OLt3nGzUjcA4820fg5TeKks88JsAXpU7COiJQOz22hw/+6Pd9kbqZnFuO89L5wM7AkjXZfiuspdREkkmMm0aF5rR0zvvIlQS+oEihcZfNYAm8Ed0j8vtmeXJa+5AJKnQ4smKSPdZa+geWm9ygNOuBkIKBpKqNFSSEANGi3nIKLozDSFxwMqtUAFzConx6iObo3q+kD7RZD1IvvjD/Cht0rmf70Ux31pG9ZBh4MX2XMuzwmuhU7QW7iaK/80GOEPs7W6PVFpXr95lYoVSJHS6PzN3TfsPAaAS64zx/jXn3deHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HT+ROqGa9RoXDYP3mL7svW6GdKzw+Vzrugch0IJaZQ=;
 b=cuua70SpLDn3nyl1uRa4A3YAG/R2O6UQzp7A3yVUTebi+MUbb9ocOfKG1bHTsXSRDHnvAOZh71ofBYCjFo9alQMrv7WAy2Jcc0sIZYEo1NpPf78FRnLj8NaSmkJc2n5HOKRmF0w67qokLtWvOiBHw3YlO3DHCvkr1C76z+yjyojy2wjFNXfwS+L1zkTvcaXDuz/X6hujU49k9Sg0yG01EpN4Qn88O3seNsj0FHMbGCb25qa1Ox3FpTze2z8KteWBKcR7L+guZjDYqA/2AdSYCG9M7+TqAUxIc1+Fj6pawEnHLvqjZY77EvRUJX5cRxaFSsnmp+LQbbCt3DbJo0iCLw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 04:05:01 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 04:04:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v14 2/2] nvmet: support reservation feature
Thread-Topic: [PATCH v14 2/2] nvmet: support reservation feature
Thread-Index: AQHbG4T/H8s1C6KgMkaucjSB6AieILKFpW6A
Date: Mon, 14 Oct 2024 04:04:59 +0000
Message-ID: <11a10ade-fa1b-4dad-9a80-1d1681e8bd0f@nvidia.com>
References: <20241011022612.50303-1-kanie@linux.alibaba.com>
 <20241011022612.50303-3-kanie@linux.alibaba.com>
In-Reply-To: <20241011022612.50303-3-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ1PR12MB6220:EE_
x-ms-office365-filtering-correlation-id: 15a4c478-c6cd-459d-37cb-08dcec055f53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MzdxSUwzRHFvV1RCZ3ZTRWdGakFaRDRCQ0hGaWREaWNHejJHV0hHSUNBVmJ6?=
 =?utf-8?B?b3lZWmRHMlluODFNVjFiRnJZVVVrd3V0bE5tK0p3bzBmRElSNUU4VWhmTDRm?=
 =?utf-8?B?NjRBM1AvQ1lCQlFlNUoydjlPLzJPaGYvQjFRdTRISU10Qjc5T1M0dDFKeE5R?=
 =?utf-8?B?N1BxQjFFblBtbnhhUDZPMm12Vy9uN1drUkhNNTUxbG93aFpwQWhWTlJTU3Nx?=
 =?utf-8?B?ZU9UbUpHeXcwSzl0bVNRSm5UUlJlbDRSV3JzSnFmZXNwMjBxQXMyY0NsbG92?=
 =?utf-8?B?MTJqY2ZkSzNWZU5zbm9NOGJyUkgxNGUya0xSQVdDQ3hGRTJuaFRsamVCc3V6?=
 =?utf-8?B?V0dKZW5IWXFLSTF0VFo3aHIvaHdxM2ZGWmJ5REQydW5OdWtIdjZNSFpmdS9n?=
 =?utf-8?B?NjU1ams1L0FPeU10VFYyNWVQUkVQOFZoY2dZN2hSM1l2ZjJTSUxhZVZoS0Rk?=
 =?utf-8?B?MTVRbi8zTHQvU1RPWEN2MWU0OGlwaVlCc0lKZmw4cThmM3g5bERWRE9Sa3NO?=
 =?utf-8?B?WUN4UERFR2l3Z1ppMlN5eFZnS0g5eXBucGltR2o3eWtYTTJvR2NOYzN2RjY5?=
 =?utf-8?B?WC9IclhRTndsYVB1MFRvMFo5cUJaU2pCR0ZuZEhpUGR2aTVnazJWeU94a0Rm?=
 =?utf-8?B?dVFoMVFkVDBFeG5tYWJnRjF1M1pmeFUxZWU5RU9zV2pvMXZDSE5NMlJIbXlQ?=
 =?utf-8?B?Q3hYeXVuc0s0UUM0eno2NGd3U3o1WDU2b0tJeHRwTkgzRkVqZFp1Q1IwUi9z?=
 =?utf-8?B?NXZwL0l2K0p1cWNWYjBQaldXRUVDVTRTa3NzTkYzWXJIaTA0dzNDSEF4TGQw?=
 =?utf-8?B?bnpHQjZHdUlTcTQyM05aRjJSb1l4VWRmSlAyelJOS2hOQlRNVkpuejRQTnpP?=
 =?utf-8?B?QXFoRC9vM2UrdDdKSDE3TTlyd3V1MkIzRG1KYU1QMWxkM1B3eExEdzNuaFhD?=
 =?utf-8?B?UEV0aWhKL3krRE16THplRklnamd0KzJrdnpieTJTaHlxOExQZ21EdE5sMlg4?=
 =?utf-8?B?QXdoWFMzRjAwbk5vQzlsbm8ySEhDblBiNmRJK24vOVQ3bjhIcTdJUTVLYmE2?=
 =?utf-8?B?Wk11RTFrRUNYa1VPbFl5V2RyUHVCbkVabEtDWHBXOHhEN3R0R0ZlRStCdmlQ?=
 =?utf-8?B?Sjd4ajBkZlF1bXFFSGRTQXAxWSs1U1NyZEdROENhNFpxVTRhVEZMTUMzaEpN?=
 =?utf-8?B?VWZxQVBRbmZJV3Fmc3phb3hKY3psNm9SZlNDd3YyeFRaZUdCdXlkcjdIUFh5?=
 =?utf-8?B?NlpyZ1JvMEtMZndvdDUycFhpUXc1V1YvT0xjVVZlQ1dITTRaWGpiQnd5cmRF?=
 =?utf-8?B?K3RFVm5naHpYeXl6VVVBbnJNc0ltZDJiWUdLc2lESTEyYWdwTFQ1U1BkSjUw?=
 =?utf-8?B?YSsxTy9pOVQwLzVxVXpHZmxrd1J0akxxUVZZdEVSaEpyS01WVEVwRVlxQ3J2?=
 =?utf-8?B?VzBWdjM5ajZnUGkxU1o0VkZrRkF1QXo4N0tMWGI3QVQ5WkxrSFp4YkIyUnIx?=
 =?utf-8?B?YU5GMTcyTFAwM0hhczNqYllSclJITUc4cUVad3FPdU1GL1JaclcxMEQ1ZXN3?=
 =?utf-8?B?Wm0yRDVmU0FDbDd0R3owbFlvYUp2Zi9UQWhYUjJxd2pmTTh1RnF0bmZ0ZCs3?=
 =?utf-8?B?Wi8vemgyUURpTDE1bWlpMDFUcDRXWUZZb0hKd2t2K1dUUGFEM01qa0Zndm9p?=
 =?utf-8?B?dTNReUpJcFhQbzc5V1Fsc1JFYjFyUXUxbVlPUWhsTEROU1VhMHRqZUhNcTlN?=
 =?utf-8?B?YjdVdXF1aXFTZEpJcjVFMjd6ZlRMeDJwakZ3T3ZZcXE4VzAzY0lnSTdScE5W?=
 =?utf-8?B?ZFpaTVVYTm1IdE4wTndMUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0ZsaVBhdjcwTUl4RTJQdVZBVXVPL2YyVkF4SG5YUHR5WGdMQVlMdUNxbHBI?=
 =?utf-8?B?dHNFSWRPTWJrb2FpVCtNa0ttVHJMRFQ5WTdKOFNmYURGcmtNV05La0Zoajhr?=
 =?utf-8?B?VlhLSERTUkFkV3hCWkNtZk5VRFVVY0NRdG1jc2wvZVp2YllrQS9wRDQvREFZ?=
 =?utf-8?B?WHZmdEtvekdRamZXMktJeVNwa0Qzb0xnR011b0VJN0VZajdJcm9rWG9DZlRT?=
 =?utf-8?B?Ni9raW9ZZ2syZkp1R2U4ZTdiTlZQZy9yc2ZhTVdyMUtDdEl0Wlp1MnNwS2hq?=
 =?utf-8?B?N2JmeXdDYXMvR1lCVFFvaFJTNk1JM3NFcFFGZFV2L2ZRMVZMcm5WTlZ1QVox?=
 =?utf-8?B?UGwvT2hoc3kyMmgwWlRyK3BRU0d6RmpBN3htdW5nTkprbllobWIwbFJLVTZE?=
 =?utf-8?B?eTlURFVPWEVNK281ZC94aXRuV0QxYlo3NkJ1c2plcXJ1TlFwRHM0TVVyVE10?=
 =?utf-8?B?VytEU1dPcHhSSkk2R1VOWEpIQUd6MER2U1NnV216SVVVMmNXT2R4NEQrREZR?=
 =?utf-8?B?Um9oZjhvYTRPeU1zMzEvK1VlUDVUNTBzak1WMlNZL0Rxbjkrd25YZTlVelEv?=
 =?utf-8?B?V0x4Z2RQWFd6ZHNBNW5GdHZEQVVybTh1WHdlaGMwRnpTc3o5VGhTclNoOUpE?=
 =?utf-8?B?YWZLWVVFS2ZWL1BndkVOWWNwZUJqMTdna0JhTStmOUlGQU0yWU1IQ2gwL3RO?=
 =?utf-8?B?T0s2YnR2bVNJdEtROUNSU1hDYSthZ25TVkxjWURpZlBsVUsxeEl0MDdzU2ND?=
 =?utf-8?B?c1plK1ZlNTh5dGNmbFA4QnRicm1rZ0swbHg3UWdoTlB6anAzYTB3WS9rYVV6?=
 =?utf-8?B?WEEySTUxNUpRaUJVc0NlQ2ZCRHZrc2VIMFZlVGlpeUZVL0x5d3k3SEVJdXRS?=
 =?utf-8?B?YUhZVkRXa1VvR2hyTUthemFjcXBKaEZkSkk2eTVxWElqNWpVeXd2Z0ltSVFN?=
 =?utf-8?B?VDRVenBPK2lSMVFVc3FWUXBGdEFPODQ3YllMdWdHL3lHUUtEa0hFVzdZK29t?=
 =?utf-8?B?WkQvcEl5d3FFMkMvMnQvbEUrcWVnWHdSS0VqUm8wL1pzUXRHbW9RN0xNT2lY?=
 =?utf-8?B?R1ZIR1N3UjMxTEdXSFFaTGYvRlQyRVZ0SnlOYzMvcnlBYXNBNHh6TTZ3Qm5F?=
 =?utf-8?B?MFlsR0FLVjh5SlhWSGpUYnZvVWp4QlhLWEpGRDB3bkpaL3pkR1VDa3M2K2lE?=
 =?utf-8?B?VmhSRGkzV1ZFeWplUDdPNXZrN3Nhb1JacWNMRmU5ZEdmbllobG0zNWtkY0kr?=
 =?utf-8?B?d1AxOWJrNUNXVlgvQy9sbm9WT3FSTEd5ODMwRlJYVzFmUzJTVlY2ak1aRUQ5?=
 =?utf-8?B?SmNSbXJFU1lLZ2ZoTVVqWU9aZW0wbm9SUTZYdWN4M1lCL1E0ZGpTOVY0UEho?=
 =?utf-8?B?QjloMENRUVlYVjJwNGI0VmZUOWtaK2FMWnBOVnN2NkFGRzFJNmVDSUlaSGln?=
 =?utf-8?B?SUtOamMrcW5CczFJbGFtWXZ4Yjd3ekhqYTViS3BJZFVFbWYrdGdhVXBGK2Nj?=
 =?utf-8?B?eHhvdS9hTTdzNVYrV09RWU5jcUVhM3ljbkpSUmxXcGw1cVV0SityTmVHOG9n?=
 =?utf-8?B?VXFMY0M3czZWMWxNN290UVF3QXlWTnpZQ0FBVGVJNTNhUURteGZHclJRTi9D?=
 =?utf-8?B?Tkd1NENPdjBManhNY0dTTDByTGVFQ1l1aDVISFNSeG5ldTR1NkJCRFBvME5V?=
 =?utf-8?B?RUp1KzFET3pZMXNxMlM1WGhiNVNCVkJDdTd1amxtbkN1akVoVHV4SE1JL0kx?=
 =?utf-8?B?T1FwdUh2L3hYZ3lRR0RJenVLMHRHTGg0N285dG1mWUZ4STRMb2NWc3YzVzly?=
 =?utf-8?B?SHJGMVJMSmNKNGNicW1QWXBzc2JFanBkdTJCclQxL0pGNWFjK2FxVGlnS1ZU?=
 =?utf-8?B?NEwvWnExVzIzYkQ4Q2tjaW16bTh5eG5oaGZPb1R1ZVQwWlNNVjZpSS95d1NB?=
 =?utf-8?B?aHE4S1hDUHNrV2FFRXd3MUcwVElsMkpYdzJWQTVkaktnNHBlNkI3TjlVTjZT?=
 =?utf-8?B?UnJzU09lVnhDWklMMFpWWTRJcUllODI3akk5QzcrR2ZqWVVncjd0UXlkVUky?=
 =?utf-8?B?WXl2MkhCcko3SVVtUVVrRGZ0Z2pJVDFjVDlhR3BWdWVjWVcra1I5eEpIUStk?=
 =?utf-8?B?VkdUakIxWk0vSnlnZlFaKzJyeXUrOE8yZEZsRjN4SVNYNXB1UGt4SlhNdHZz?=
 =?utf-8?Q?yswexhikaz1BZSrj3mHrSWrGbnoD125tcIqiAXGcp3Fq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E34C46DCCE3ED54AB571238D41471627@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a4c478-c6cd-459d-37cb-08dcec055f53
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 04:04:59.7923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqRnav3ZMpb6z+uDwx/kYKaHNInJDSz6Cw3b/gE/IfOa2hMcD38i2rocSNaaKWOi57QRFw6AnzgDWMcv1S4J7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241013_210511_931233_860FF0E0 
X-CRM114-Status: GOOD (  14.36  )
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

T24gMTAvMTAvMjQgMTk6MjYsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL252bWUvdGFyZ2V0L3ByLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi41ZjNiOTg2MTUzM2UNCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCj4gQEAgLTAsMCAr
MSwxMTYyIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyoN
Cj4gKyAqIE5WTWUgb3ZlciBGYWJyaWNzIFBlcnNpc3QgUmVzZXJ2YXRpb24uDQo+ICsgKiBDb3B5
cmlnaHQgKGMpIDIwMjQgR3VpeGluIExpdSwgQWxpYmFiYSBHcm91cC4NCj4gKyAqIEFsbCByaWdo
dHMgcmVzZXJ2ZWQuDQo+ICsgKi8NCj4gKyNkZWZpbmUgcHJfZm10KGZtdCkgS0JVSUxEX01PRE5B
TUUgIjogIiBmbXQNCj4gKyNpbmNsdWRlIDxsaW51eC91bmFsaWduZWQuaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9sb2NrZGVwLmg+DQo+ICsjaW5jbHVkZSAibnZtZXQuaCINCg0KSSdtIHJ1bm5pbmcg
aW50byBlcnJvciB3aGVuIHRyeWluZyB0byB0ZXN0IHRoaXMgY29kZSBbMV0sDQp3aXRoIGZvbGxv
d2luZyBzZWVtcyB0byBmaXggaXQgb24gbXkgcGxhdGZvcm1jYW4geW91DQpjaGVjayA/Oi0NCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcHIuYyBiL2RyaXZlcnMvbnZtZS90YXJn
ZXQvcHIuYw0KaW5kZXggNWYzYjk4NjE1MzNlLi4wMDBjODNmYmRhNTIgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcHIuYw0K
QEAgLTUsNyArNSw3IEBADQogwqAgKiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KIMKgICovDQogwqAj
ZGVmaW5lIHByX2ZtdChmbXQpIEtCVUlMRF9NT0ROQU1FICI6ICIgZm10DQotI2luY2x1ZGUgPGxp
bnV4L3VuYWxpZ25lZC5oPg0KKyNpbmNsdWRlIDxhc20tZ2VuZXJpYy91bmFsaWduZWQuaD4NCiDC
oCNpbmNsdWRlIDxsaW51eC9sb2NrZGVwLmg+DQogwqAjaW5jbHVkZSAibnZtZXQuaCINCg0KLWNr
DQoNCg0KWzFdDQoNCm52bWUgKG52bWUtNi4xMikgIyBtYWtlIE09ZHJpdmVycy9udm1lL3Rhcmdl
dC8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL252bWUvdGFyZ2V0L3ByLm8NCmRyaXZlcnMvbnZtZS90
YXJnZXQvcHIuYzo4OjEwOiBmYXRhbCBlcnJvcjogbGludXgvdW5hbGlnbmVkLmg6IE5vIHN1Y2gg
DQpmaWxlIG9yIGRpcmVjdG9yeQ0KIMKgwqDCoCA4IHwgI2luY2x1ZGUgPGxpbnV4L3VuYWxpZ25l
ZC5oPg0KIMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoCBefn5+fn5+fn5+fn5+fn5+fn5+
DQpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLg0KbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxl
LmJ1aWxkOjIyOTogZHJpdmVycy9udm1lL3RhcmdldC9wci5vXSBFcnJvciAxDQptYWtlWzFdOiAq
KiogWy9tbnQvZGF0YS9udm1lL01ha2VmaWxlOjE5MzY6IGRyaXZlcnMvbnZtZS90YXJnZXRdIEVy
cm9yIDINCm1ha2U6ICoqKiBbTWFrZWZpbGU6MjI0OiBfX3N1Yi1tYWtlXSBFcnJvciAyDQoNCm52
bWUgKG52bWUtNi4xMikgIyBnaXQgZGlmZg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJn
ZXQvcHIuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcHIuYw0KaW5kZXggNWYzYjk4NjE1MzNlLi4w
MDBjODNmYmRhNTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3ByLmMNCisrKyBi
L2RyaXZlcnMvbnZtZS90YXJnZXQvcHIuYw0KQEAgLTUsNyArNSw3IEBADQogwqAgKiBBbGwgcmln
aHRzIHJlc2VydmVkLg0KIMKgICovDQogwqAjZGVmaW5lIHByX2ZtdChmbXQpIEtCVUlMRF9NT0RO
QU1FICI6ICIgZm10DQotI2luY2x1ZGUgPGxpbnV4L3VuYWxpZ25lZC5oPg0KKyNpbmNsdWRlIDxh
c20tZ2VuZXJpYy91bmFsaWduZWQuaD4NCiDCoCNpbmNsdWRlIDxsaW51eC9sb2NrZGVwLmg+DQog
wqAjaW5jbHVkZSAibnZtZXQuaCINCg0KbnZtZSAobnZtZS02LjEyKSAjIGdpdCBhcHBseSBwci1m
aXguZGlmZg0KDQpudm1lIChudm1lLTYuMTIpICMgbWFrZSBNPWRyaXZlcnMvbnZtZS90YXJnZXQv
DQogwqAgQ0MgW01dwqAgZHJpdmVycy9udm1lL3RhcmdldC9wci5vDQogwqAgTEQgW01dwqAgZHJp
dmVycy9udm1lL3RhcmdldC9udm1ldC5vDQogwqAgTU9EUE9TVCBkcml2ZXJzL252bWUvdGFyZ2V0
L01vZHVsZS5zeW12ZXJzDQogwqAgQ0MgW01dwqAgZHJpdmVycy9udm1lL3RhcmdldC8ubW9kdWxl
LWNvbW1vbi5vDQogwqAgTEQgW01dwqAgZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5rbw0KIMKg
IExEIFtNXcKgIGRyaXZlcnMvbnZtZS90YXJnZXQvbnZtZS1sb29wLmtvDQogwqAgTEQgW01dwqAg
ZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC1yZG1hLmtvDQogwqAgTEQgW01dwqAgZHJpdmVycy9u
dm1lL3RhcmdldC9udm1ldC1mYy5rbw0KIMKgIExEIFtNXcKgIGRyaXZlcnMvbnZtZS90YXJnZXQv
bnZtZS1mY2xvb3Aua28NCiDCoCBMRCBbTV3CoCBkcml2ZXJzL252bWUvdGFyZ2V0L252bWV0LXRj
cC5rbw0KbnZtZSAobnZtZS02LjEyKSAjDQoNCg0K

