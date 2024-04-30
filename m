Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4AEC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 03:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlgKF/QoIdCyCRbAu84T8bIz4O3199vNSNN1VTh5Hx4=; b=niUiuKDGRLHCK9D4q3W3sqwOKY
	2sDITnDHXGBJS1f3pjqPP/fCVsq4urZCiP/EXykMJpFE6RBqup7VbJf2IlKJ+aGTqCqSeyp+G1yY1
	EO9tmROcL8pP81iD3zEEtggGGfL4A6tmzHHuZfSfGTjKI2Y0BC2W7pY0o1ncsvt8WrG6hz2wz1POr
	wSCnjRVLvQ3rSkqJYDsw74TVTa/FG/6VdtcDD3ABNKVokDGF4SlaCfKrID1YJuPOa8PUtd9h3j+tc
	WVFUo7xxihlSSt8+JI5ZjVU87Z7bUZhkS0ZHLO12qN7TgRyrMweB4NRvu3aQACtB4hiNmRFRqR8CB
	0HhlJ4kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1eKV-00000004wrN-1BZc;
	Tue, 30 Apr 2024 03:38:55 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1eKS-00000004woh-0HMY
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 03:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvMzXusN+vGc3Xvks/WRnzGx10D3DMIvfTc3PG1eSYaDgFEVzl+pCrYnastRMBwT3frvYBSFZFX5jSyjb69WtOTlRBwieaeqjPzyfizZjpeGS3AkA7ilx5gsPzMdYtDQKU54lQPH9hSRpOC+3T7MojwZXHG2Hq3EM0b6OP7FJEOA0DusMO8TDTSrUJ+btAGs2smfh0OV5+7wO4qzS1kezVIq58Wc4vElLjocNBVZTNLayf9cqhikGLNkaFXo85mMQcbAQn4oDXEYeHIGRehZV8SU5Gug1mtMQ76RfssBlT09Q0Buh68VqY/60LQbkZg7BvDi+wNzLt4OhYhx4vbThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlgKF/QoIdCyCRbAu84T8bIz4O3199vNSNN1VTh5Hx4=;
 b=WO2uqyLcKCnDoyyyHv9s9hGasittWum/OfWIRCfz5/JOC5QIwgbLFBWJYfoGy0ZYY/0obG+6YLwdTb/Q0fqLF8DUlmkOhTbhB2D+sFsXt4v/Lih3DuDUlH/69aqtdR0uAAyCjezZZlckLrkjoVD+NK0arj637Pd5TSwtG801oBEojJjdYKeyRftCAE+/SAI9TdiRr0wqrbucztlowhRPABA7F7S8BsFHzeYc1/PeB1oF+peM4sNEtrqjq+pU4DP3Ure15l1wREOium3R8NX7f6V/otbrYC0tyJJLHrjeSM6AqXpJ4wrLy6MyVA2XPuOSNWldYX8T7M/dzcRsSqXXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlgKF/QoIdCyCRbAu84T8bIz4O3199vNSNN1VTh5Hx4=;
 b=t+D9PMkh6FPRYwV3N2jF98p5u6KBH6TngdJFua/f2vxzmKhSBuqhTLwxUHFl86nn0lyeXk4O7FfPVBSMdAzZtZ3gBfLq/v63FoDVji/9s1//yoEYYgcK+qczNHkDipPwXjJegelbKtPAVIYslrgeb3AsYgEr+YRBdh6l2CCZDlEtpfJ59CHFOKLFRf9GNz1ta1gXrRKUUcPIogX5OkypiVHVnQ5X3753VF+3JcU2PnkoPSe3sgKChXNCagsM5OUwYVTn+K3utUTgnFsf5q+TpMa4MuaI6dZ9eWxeOZM3wO3DUV/Az/LklC1o/pjwLjjGQ36twJdJfkueWLVsuyChjw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 03:38:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 03:38:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, "jirong.feng@easystack.cn"
	<jirong.feng@easystack.cn>
Subject: Re: [PATCH] nvmet: fix nvme status code when namespace is disabled
Thread-Topic: [PATCH] nvmet: fix nvme status code when namespace is disabled
Thread-Index: AQHamU4lZMiORzbRPkm5I3fyA7L5eLGALSOA
Date: Tue, 30 Apr 2024 03:38:33 +0000
Message-ID: <9a0f45b0-42f1-43dd-af0c-183de824a967@nvidia.com>
References: <20240428092540.77366-1-sagi@grimberg.me>
In-Reply-To: <20240428092540.77366-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL1PR12MB5852:EE_
x-ms-office365-filtering-correlation-id: c5fd18b1-bc46-4c28-02f3-08dc68c7029e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eWFnem13MDZLd1J5QUFDdTB3aDIzemFEZ1ZrNXptcnRMM2tNbmxYeCsrS2NG?=
 =?utf-8?B?TFl2NUF2VEV1OWQ0WjZjOTdnSTZoZW0zOEt3U3I3RGk1eUk4MTViRFVjSy9h?=
 =?utf-8?B?cUpTSVk1NExQQjgvM0dCN0g2aWJiOTdlRlpBODVvNFpGYVh0QldlcjA0YTJv?=
 =?utf-8?B?OUU5UE8rcjd0UGVBZXpWTlRtb0NaR3ZCNlBPSG5tUlVrMFZ2ZTJMcTAySjg1?=
 =?utf-8?B?MnczSEhOK2Nrc0F2ekgxaDVrSkh4ZCtqdkJUd0RPQVFqSDdiQXVldVFJNFVI?=
 =?utf-8?B?MS9BME05cHZIVlowVUlkMnIwN2lZbGRvcU95SGt6bHgxeVJSRlpiL0RpNDhC?=
 =?utf-8?B?Q0FpWVg3Qm15UG14ZHFLYWRrMDROMThrQXhtaVpZR1p6ZkZoSFp2eWQ2OTFG?=
 =?utf-8?B?bnNhU1BHVUZyWDhkSWRzTjBGY1lyWUl6Qm84QUZaMDF2eFhsaDVvUUZCbndv?=
 =?utf-8?B?eXMwcTlVVzNTQWlNSGJZQnVsMENjbDdtZjZHWW1qSkowZnRCWFhDL0xaa2cw?=
 =?utf-8?B?a0wxejdPbzlzOWE4a0EwTk1yOENsOS90aVE5OW1TdGJXTU43M2toQS80RC9M?=
 =?utf-8?B?UVl1ak9rNE1oZWg2Rk1PeWhScnBEK0ppOGowanFPeVlkdjE0dFZJdGhEOFJk?=
 =?utf-8?B?Sk9IUFVldjN2Qk8xWTBqOVNlNEo0azUyUGFSdkhicmJKVGpKRWxkMnlQSEdo?=
 =?utf-8?B?U0tPTDAwT0Y4bnoya2VuTklqVloyMlo2WURQeUJJdWMwdGhIczFUT3kvTmNz?=
 =?utf-8?B?Yk5ER0laNS9YVFlJY1NISTFwbTV4VldGT0xCVnU5U21OU2R3bmYzUjlCampy?=
 =?utf-8?B?a1lvS1M4UGNPMVpZaDZrbHlDUDNOTjVTZjBTNlc1eDNGR3RqZzVQeG1rUm9X?=
 =?utf-8?B?R2hCaFJ2VHR3UnErMHFPY2NGYnZvTHVoRWtsamZET0IwSmhvSGh5RzVQWklR?=
 =?utf-8?B?dHI3OHBKcEFDa1dXTUlkYUp1SExXYjQ3S05IZGV1NDBZNzh0OEg2TFdTL1dN?=
 =?utf-8?B?elgySzg0VmpnUC9vWUVwNmE4QmNLaitpVmFsUmJnd0JIKzNDTUFSODl6KzN2?=
 =?utf-8?B?aXVBUXEzZ1Avd2E3WEpLTE1CQWRDbUxhUEZ1SWtkK0NEUnd5WktCSkpvSCtW?=
 =?utf-8?B?elkrYy9GdkM5YlhQNlhnei9UdG9JY0tPTHgxOEpEekhXYjcyc2ZoRFhRQ3Uz?=
 =?utf-8?B?a0lIcWRyemhCRzcraVh1dmJ4MjJRQWFuVWg2SStZcWU3eEIwL1JNRVlQdkk3?=
 =?utf-8?B?SnJ2RW1vVVluVG9kM0tmRUx0MXMvQzZEYjVOcUs4UER6V1NlUTBqNG5MMW9p?=
 =?utf-8?B?MkRiVnVuOC9ON1RPV0lxeERxaW1iZDNnUEU1dEVFUzA4VFpaa1hZZDh0RVhl?=
 =?utf-8?B?RU0ycHUzN3ZET2ZYL0VsS1FnU0RyV0FtYkllTnE1c1JxbFpteXNvTjBPbDZE?=
 =?utf-8?B?RGpJYk9laitJS3hESlFleXNkNGY5aHRwYi9oWTdjYm1EZmhBajBZT0NLM0Nq?=
 =?utf-8?B?TStDNThSMjkyczZoLytvOWF1QVVYcFd5NWZmb3ZWOG5weWtYbzVTdy9NL2Yx?=
 =?utf-8?B?emovSGhqeUg0UlNqQ3Z1bXhsV3BaZUdYQzFFMVMxaktIcWFxelRPcWt5cjFU?=
 =?utf-8?B?dVBsYmxhTWxlL3Z0WjVNQUVnaldHRVJ4OUlWZ2lNeFFhTG9NbExKbnkvT2pT?=
 =?utf-8?B?blVvb2w5K2lvKzFHdTRZWE9TaTczdkF0aVRvSjZmRlRmWkxJYkxUMUxLV1gw?=
 =?utf-8?B?ckE4TXpMdE51WXhuRGRMS0VVcU1lM2IwbElYa01RekJ0THd0aU9YL0xUUno3?=
 =?utf-8?B?MC9WM05yUUtQeDIrZkFkZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dy9JZXp4cmVLTW1qb3hIV0pkVFBYUGxCRjBMaHBHQzJUb0VSQnc2cG80UXJB?=
 =?utf-8?B?d0VibHp0MFNZNVc5Y0tCejhLdnh5M2F5cWVweTFiajlzMlBRalN0Z2hObmVm?=
 =?utf-8?B?amQ5b2g2ekNnM2RmWmVuMi9ESVA2ME54Rzd6Wm5WMlVPeWdCYlQrbDdzQXJP?=
 =?utf-8?B?SWhyTUFHbEJ3bk04UFNSYllBdXFLUW5Gc0crQWJxbnBYQnU3RHgwRXVxREg2?=
 =?utf-8?B?MDdublNZVmtMaFUwbUs2NHE2bkRVWmliUFZRR0xBMkl5S2R6a1FWcnc5M0Vp?=
 =?utf-8?B?eGhoSnJBV1kyU01lREUvZmlYeUo3dGZ6NzFmb0FQQTdPQldzVm9hTERoVUkw?=
 =?utf-8?B?d0R6SEVzaHBPYUhERVYyOCtUU1lvNmlkWm1JempxQm81L2kyN2lBSkNBVmRN?=
 =?utf-8?B?YXJ2aVJ6aUhjMFdoL1g0cDZvWmZGM3ZXeC9CZDNCM2JGL2I2OVVkTFhHRUFl?=
 =?utf-8?B?aUU5MWZPT05CSWl6WnhubTN5REszRUF4OFVJM0RGWFQrRzJRa2dRYThvNjdN?=
 =?utf-8?B?a21uVGRnUnZUekQydjlwcUhtVG9HZkVoQm1JSCtaeUdXcko3MGlIdzhabENz?=
 =?utf-8?B?UnRRLzZ1YU1OUmFLY0NVcGRDUzNiUnhabnJnOTI1aE1kSlZ6cW80NHN2RVBo?=
 =?utf-8?B?MzlJMks4TzB3cENGRmszcktXc2lpMlhPMzY0NThxdUJrbTRMMm5heW8yZ2Zj?=
 =?utf-8?B?WVRNSTVNb2dJVUdwUGxtdDhGKzRaOXhjWWJ0UFB4Uk1zYVJtcTZqUjE1UGpW?=
 =?utf-8?B?UXJzY05EWWlFVnVlbVk5SlREVGxBV254NC9sV3dTdDJ0QmtNWDlqM1IwODRR?=
 =?utf-8?B?S0FhSEUxVU1MTWw1ZVB5aUU0NlhxQXZQQUNWL3V4NFpBV1JBOXpQSEtENEJq?=
 =?utf-8?B?Ynkyb3BKdlVuZUtiMmx0Q3c3TXBac0pGcEVEdDlMOFZMejkvS2dTeFFKRGlI?=
 =?utf-8?B?UEgwVitQMm1YYXZPcnNBeGNrK1lxUFVMZkNGY3hCUmIxUVU4bkN5MWdVZ0Jz?=
 =?utf-8?B?QS9YWm1VQVdhSmJtSno4UGxnWWxIV2hzTWgreXdYWVhBUVRiTXIrd2Iyekgw?=
 =?utf-8?B?bnNNTkFnZFZrUmNSQnRyeWtpYk9sQ2xhNm9HcktYR05qL00vLytwbFlyYlVC?=
 =?utf-8?B?Ym9LK3dkbHNaOUhwRHVnNjNpY0FFOXZpSTVXOWlLTGVuV20vcGpYWlJITHFD?=
 =?utf-8?B?WW85OHZkSUtBZEQ5a0o3TUxBNzJxaWhnQmZWbW5HaHpjalB2T3cweWhtUnJS?=
 =?utf-8?B?ckNTZXRTU0tMWW1KemJyWW16NS9FOXlsczBvNDV6Nk5UWWkxbHNBN0E4WU9n?=
 =?utf-8?B?ZkN6UEhFNzdaVVFXSk9zL2REa04yUE0xbnUvbDdGVlJYYjNuYTkwaGc0RGxo?=
 =?utf-8?B?K1lOZ3pXTjJzQzI4RFdMY2RhWThVSFRaL1FqaXRHZ3B4MmRaUlZIcjZ4eUlC?=
 =?utf-8?B?ZmtyaWNKYlpoTHBmMUVVblp6TlIvMDBpR1pGSFdScXpXR1lkYVczeSttRTFz?=
 =?utf-8?B?RkdmcCtlWGFuV2svSUdidVFWQ2VyOE5qL2VXUFQ3ZWI4VlI3M25qdkFXdkNS?=
 =?utf-8?B?NStzMkR1WVVnZFgwQTRhQjh0ak42dGVEQ0tUOVg1WlpXWUFOV3V2NWNBdVpM?=
 =?utf-8?B?MkV1U0tHdHhNVGRpdUlKUmovTWNLUWxraGlmOXR1TnFUOVNub1FZaW5QTk5V?=
 =?utf-8?B?NXRHQ3dsUVBxblY3MzRBa2xGSzRTV0hMUThucGM0THB2T05McU53aG9rYnlB?=
 =?utf-8?B?TGtUYnZ6a1RaN1lod3NIUktvNTQ0NC96ZEp1NG15dVpYYU0wTFgyYkFURnIw?=
 =?utf-8?B?dWFpbGZMZkhzbjM1dUZ0YjI2L1U2dlBFT3NqdCtHKzUxYXVLeWNOcWdHZzdC?=
 =?utf-8?B?eU82YisweGp0NXVxWHhRMFg2OHhKRTQyR01KM0pVbTArVWp1YzZ1UFJLL2Mv?=
 =?utf-8?B?STBIaHA2RHRJTld6RlB3MFpZQ2gxdGxsdkNmMUNoVmphOXhUVkM4T1h0ZTMx?=
 =?utf-8?B?SlYwSmhLZ3FJb0s1eXIxcUg4bXVMak9tbVlxZUt2Y1ArRUNxTEJmY2xYQkdP?=
 =?utf-8?B?MElFOHZpYnV0M2t6cTJScEFhTDF0V1NYcjRHWWN0Snh3NkFZTFBBVitlN0dz?=
 =?utf-8?B?eXdlZ0VTSFZoWU9lekZWRXhVSU1peXp6eXUyaTdRdDNtWDhqUEdhcERESU9Y?=
 =?utf-8?Q?WF7u8GJsbuV8xhWN90ezn9tdLWgPoPAB9qvhX9T5eoP4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B8AA9185081B742A4CD75ED0365B1DC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fd18b1-bc46-4c28-02f3-08dc68c7029e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 03:38:33.0961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Gh3xSXWBDy1u+NPIsOeNE75VXJmAxFFBob300ZAskSOzkyeFwAs7x6+0HaKVfQ1+d3K4y9/zRh/Ao40R1M5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_203852_161874_07AB4173 
X-CRM114-Status: GOOD (  16.42  )
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

T24gNC8yOC8yMDI0IDI6MjUgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IElmIHRoZSB1c2Vy
IGRpc2FibGVkIGEgbnZtZXQgbmFtZXNhcGNlLCBpdCBpcyByZW1vdmVkIGZyb20NCj4gdGhlIHN1
YnN5c3RlbSBuYW1lc3BhY2VzIGxpc3QuIFdoZW4gbnZtZXQgcHJvY2Vzc2VzIGEgY29tbWFuZA0K
PiBkaXJlY3RlZCB0byBhbiBuc2lkIHRoYXQgd2FzIGRpc2FibGVkLCBpdCBjYW5ub3QgZGlmZmVy
ZW50aWF0ZQ0KPiBiZXR3ZWVuIGEgbnNpZCB0aGF0IGlzIGRpc2FibGVkIHZzLiBhIG5vbi1leGlz
dGVudCBuYW1lc3BhY2UsDQo+IGFuZCByZXNvcnRzIHRvIHJldHVybiBOVk1FX1NDX0lOVkFMSURf
TlMgd2l0aCB0aGUgZG5yIGJpdCBzZXQuDQo+IA0KPiBUaGlzIHRyYW5zbGF0ZXMgdG8gYSBub24t
cmV0cnlhYmxlIHN0YXR1cyBmb3IgdGhlIGhvc3QsIHdoaWNoDQo+IHRyYW5zbGF0ZXMgdG8gYSB1
c2VyIGVycm9yLiBXZSBzaG91bGQgZXhwZWN0IGRpc2FibGVkIG5hbWVzcGFjZXMNCj4gdG8gbm90
IGNhdXNlIGFuIEkvTyBlcnJvciBpbiBhIG11bHRpcGF0aCBlbnZpcm9ubWVudC4NCj4gDQo+IEFk
ZHJlc3MgdGhpcyBieSBzZWFyY2hpbmcgYSBjb25maWdmcyBpdGVtIGZvciB0aGUgbmFtZXNwYWNl
IG52bWV0DQo+IGZhaWxlZCB0byBmaW5kLCBhbmQgaWYgd2UgZm91bmQgb25lLCBjb25jbHVkZSB0
aGF0IHRoZSBuYW1lc3BhY2UNCj4gaXMgZGlzYWJsZWQgKHBlcmhhcHMgdGVtcG9yYXJpbHkpLiBS
ZXR1cm4gTlZNRV9TQ19JTlRFUk5BTF9QQVRIX0VSUk9SDQo+IGluIHRoaXMgY2FzZSBhbmQga2Vl
cCBETlIgYml0IGNsZWFyZWQuDQo+IA0KPiBSZXBvcnRlZC1ieTogSmlyb25nIEZlbmcgPGppcm9u
Zy5mZW5nQGVhc3lzdGFjay5jbj4NCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2Fn
aUBncmltYmVyZy5tZT4NCj4gLS0tDQo+IEppcm9uZyBGZW5nLCBjYW4geW91IHBsZWFzZSByZS1y
dW4gdGhlIHRlc3QgYXMgcmVxdWVzdGVkIGFuZCB2ZXJpZnkNCj4gdGhhdCB0aGUgSS9PIGVycm9y
IGdvZXMgYXdheS4gSWYgc28sIHBsZWFzZSByZXBseSB3aXRoIHlvdXIgIlRlc3RlZC1ieSINCj4g
dGFnLg0KPiANCg0KRldJVywNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

