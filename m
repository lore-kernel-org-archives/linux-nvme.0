Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B53FA373D
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 05:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ionv/LusWQA6aIuP64rNR8lB/3d6igwEjtyyi279X0M=; b=wAMeO1VsfnM3tA3ugBKFFF+Phb
	kgWI4YnI23dfC5rvrGWh4kPfCO23K2En76pTmGJe0gVCEUpB2RztUHGdy1CMmLasrc5zMRTSIRuiT
	50JFqlWIpa3ZDsu2PFPGj7AMiiDY/4XZqZzSDrf8sGJMQBgP12Mjyqb6dAmcDEnzoei8CmMAtMLov
	+TpgfFy+sw5GWtAhiQ2dGPiWRl9TtEUnYrL1s3W5iPLcU0Our08R004Q1+H+L+XxdV/1raypKHKSD
	L8ET/SVjRohecfjtT2PuH7TsyBTaqre6z/2tg53wq5wKKXaNC3OskHRQYVwx6orJn5ipJJkvTzWcp
	PVzB7arw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opjhs-001zyS-1R; Tue, 01 Nov 2022 05:21:00 +0000
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opjhp-001zxj-I0
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 05:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pm/mzdb3EtEJN4BWS/Izu2HpXHJ6H6pxryXpjkoY0Iep3JZ+r6zzSMGke3l0ZaVH63GahYEDFespAgU2uL5CNaeq2tDo2bJHSDU+oNS/DlUxDehSc4Y/UxXElKvnpJtznT03i84YjvuAkcAdQXgd5hGOBuoaScX46V8cBembOSYZd/XsSWNSCD1vKwar4+JKgt9b8bEwFb2G/2IU9dgLoURMKmVtgxKtqNwz2BSSIjbczwijsOq/eIjoxys+ETifUkAfyYo01D7j01GYXbeN44wk2Wmm5tkrWfa73o6DIf6vIff+rdUfFE097cyh6DOKAHk+NcEQniLUAv9ABM5mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ionv/LusWQA6aIuP64rNR8lB/3d6igwEjtyyi279X0M=;
 b=UnZj/rZVSt0ozTvLCRzS1qCqQHoFi1DvWXEIcC6BGkSpDEGJFEW/fmj1DK1AXWX1F3GPbgeIx3R660YHHFGL7LDfaFW/BUzRzzKV9pfkOMKpnBQvApDVgTf59FPezQ4Db/bTTMaCLPD9nOhz8+xS/8bq/iQeRkqyvoYLIblMzhTCiGy2uDN4AKvrnPyDxvDVTS8COz1Zu936Pri594F4FbX4cuRMgZPqHFyCfR9gKg10ISRtZKTQdXR9Fdc6ogg+MsmhPmyVbmlzszBePin7nxtzPrDmHSyc8R0o5mzsKuPWBO6q3U+SUVeQYNRqGZ1IP+keKxcrUmtah2+oWisO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ionv/LusWQA6aIuP64rNR8lB/3d6igwEjtyyi279X0M=;
 b=Fb+NTTUxekXtLwoPIzrwqPHwIw4hpPHh5ccGVHhLrk3UK1WdY4hdwcmeW794KKibSAHtERCOxRGxu1c7aNm7T5LJaTTWYdiampRuHFHskEpuT15IwHptaais0x50zBk4mytpsBzngWqclXlk1NKCa5s2JXxE1SGJHmVC4bHIKVkKgAGioLDGUv0j/96Tr6c3HLw03RNKdlwxWsfesp+FCT9SUouyq2l/7OkLBY/r7mulayMEPFjMjNla03cKFDcrGlnS6625jI/Y1JjJO3H9da4OCTB/sDlw/b59OLOPOJqP9gSWGLzXC2zlDPt25LX2ia4GK4oblGj0xrwCb6AaHg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 05:20:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 05:20:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH 2/2] nvme: identify-namespace without CAP_SYS_ADMIN
Thread-Topic: [PATCH 2/2] nvme: identify-namespace without CAP_SYS_ADMIN
Thread-Index: AQHY5FPEjF7f8Ycm4kOhtN5yj61s2K4oIvwAgABzIoCAAQSlAA==
Date: Tue, 1 Nov 2022 05:20:52 +0000
Message-ID: <7231d3c5-d185-c096-d29c-27d892dd4a95@nvidia.com>
References: <20221020070205.57366-1-joshi.k@samsung.com>
 <CGME20221020071346epcas5p4c3b8da5e60f94947ad570cbd151eb38d@epcas5p4.samsung.com>
 <20221020070205.57366-3-joshi.k@samsung.com>
 <737c7d72-ff5e-1f0e-304c-24bbb23f30a1@nvidia.com>
 <20221031134759.GA20135@test-zns>
In-Reply-To: <20221031134759.GA20135@test-zns>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BY5PR12MB4322:EE_
x-ms-office365-filtering-correlation-id: 8ff60649-a182-4a52-850f-08dabbc8d885
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  enx+zTaWcOf/jq5cE/qmV2Ylpk/cq70JLVTUtBx16cQCk7PXDfocyRZ0CZucY0UzWuRJsDUwTb5Jtghey3E+egF0koP656528FahAyrArP/hMA4CTdo4fZX2HYl9ZMewjQE4CHiAXxeWsLzsRNI8WfqBKfFOovOqkOnLqHdo7OgimuKOm0f6fjRbp92S6yfJlmal4LWlKXcWlvK62harA34pHGsoh6UsSFpcnNG+761d3HuGzWss6RwLcz88aLEbB6WmZqOmlPgWnmMylhYHMiH0/IQvwn5NBCHHWJhWM6sQJQo9gf8V+EUK7huUYnQVvF8MXEhsQK2a1zl347WN2WfHzFEmo/JXcCkyn5A1xvBTIRSk/aiucSPixJn67hlOHCSFaaqZaJWJKDdnYIKFzB1RLf1yA1uKLbvXe2M/N9gP3Eth5HMN9GTLCK4BkgFMseA0r3fI2b6ibqQI0PARxvgOwKkc5sXbtU3QY+KfmT4kB8vx7hbGoLPaGlo21/BtsuEoBG5pJwGDHBF8omVv3P+9vmNnpwZvOVVefeta1IbfjQuBcj95b0fKwH976NltZqBtKhiZlD4LFJJpF8A7x1ozB1A9duaOR0ShdcSlLitYbuAOxdAGYmn89Qnunk2PXTaLqeIa9GSGKgmUHu8Ss9TYCaqpPkTAQH/6MqdfEEnlSwp/zSWWhXxPEwfhc2wnq7TVIF+QZYSu5dRoVMvYgKShlA2LMsy8cGlL6eWfclMibtVLjGsNuHH5zr0vuKZKtr8qDUG37Ae1PaniMXQyidr2D7H8hTSh9KjylwCuTsaa9kt5k3dsrUGL8Htiuwlj+3WWi+4zzxf1GfTcwn9V9w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(66946007)(8936002)(4326008)(83380400001)(5660300002)(4744005)(36756003)(54906003)(478600001)(316002)(2906002)(91956017)(2616005)(76116006)(6916009)(38070700005)(41300700001)(71200400001)(6486002)(186003)(6506007)(6512007)(66556008)(31686004)(8676002)(66476007)(64756008)(38100700002)(31696002)(122000001)(66446008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?U2pZQWUwQ0RDb2U2VlI0V1JUeEFIMmhLdnJIRTY0TThZa2tlRDZiREJ1bnVS?=
 =?utf-8?B?WlpQcSt2OWNQajFIMi9KR2llUHVxdFVSNm8zWk0xTnB4akllOE9wdTVxd1dT?=
 =?utf-8?B?TXZ0cVZ1Z05yRzVYZ1djMUp0M3VSY0ZEQ25ZTjlnemdSS0YwVXl2T1pYQzJR?=
 =?utf-8?B?M1RUaVpBdklFZC9BUXRQSTl0OHlDSVcxcTRlbnNiWU1kM1A0MFE3bHZUbG5r?=
 =?utf-8?B?aWVZc3V3czM1alE1ankzMHZTZkxFTFhJNmhnODBtU0tRclFsS0M4cHZnNTZm?=
 =?utf-8?B?TVBldGcwbGJ4THBqYWtISHhia0VDOHdoNjNSOHRHdHRmWHNrak5ZckZ4L0lP?=
 =?utf-8?B?UkJJYnhSWW1iaDhzWGVJZStSVmVMMDdtZGh0SUJ3ZlQxODJLbTlJNmo5V1RI?=
 =?utf-8?B?TXNXTWZ0NUpDbkJsSVMrNEFoSDc3RmRrNW1GVCtDcDVLOTArYitQRStuRFk2?=
 =?utf-8?B?bGtIaFo1blcyTWNKYzFuZTFlSkRWRnlUSGs0T1JsdnF0VXpHQzkyKzdzc2o0?=
 =?utf-8?B?YUVpam9vS2c2M2ZoWXRqNTZGRWlobGJjc2FxbUtzekdnS2RZYWVmWEZNTzFL?=
 =?utf-8?B?eUVmdno1MWNsS2p4dmVUeHdLalpHUjEwV2hybGdnYUlHVzVYemwxUStsUGF5?=
 =?utf-8?B?d29SYi92YWs4Z21ONHIyM01OOGRXQmZ3UHdLeGszaTdWZ00yOTdWMkI3cGpZ?=
 =?utf-8?B?MTdWd3A0bTVua2RHakxPV0ZScUJ3WDVBUDdac0sveWJWRkZzdTA3ZTVwcmZk?=
 =?utf-8?B?WkdBSnNXZXkycDlRV2lIVVlzbXk5YmZwWVNqanNRUDA4SXc3Q2lzejB6ejEw?=
 =?utf-8?B?RjFXeHZsUmllSFBxcVBreUtvWGJ6ZnZZNFFsRHBCU1hXd0hiWWNDV05aYXdv?=
 =?utf-8?B?WFNNTDlveFVFaUpSSjhPem9mWW1RQmVZclA4OWFhb3BzYlo2V1kvS2NkUEE2?=
 =?utf-8?B?RWY5WnBhbjc1d3BXR1ZXdGhYUWFBUW1OVnhtcG5VOE01V1F3VUZiQ3R5bmJE?=
 =?utf-8?B?QkZHQ0d3NThhVlhNZG1DWDZsN0hrbktwY0pqSHFpb29lWldmVzJ0a0xiUUxB?=
 =?utf-8?B?M3FON0pnTU9BYkgyLy9VWXJ4cTRITHQ5OE45VmpxY0wrYUFuWERxZVUrNzNF?=
 =?utf-8?B?dFhwZzZWSEk5WmdnM0F3Tit4d3ZNNjZEUzBGWW9vVkRSZmp4WmpWUDlObGJT?=
 =?utf-8?B?UVVJc0VaU1Y4bjBVWmtsSnN2UnZHZWVhNVlmbStGYVVzWnVPZFVlZ25QNEpu?=
 =?utf-8?B?dGd4clp2RGhJSUFFay94WFdKOVR6QWJSYkMwUDlnSTg2MHMyb0c5dGNHSnZ3?=
 =?utf-8?B?UWp6R1lZcVp4eTdGSFExYzVjb3ZuRElWQktHTTNlOWxxQTZFVjVZejZvWndE?=
 =?utf-8?B?cHNlNlhXRGFXanVyc1pKcWZDYjBIWkVzbGJxc3ZiNW85MndmTTd3aTB2OEh3?=
 =?utf-8?B?eWJ3dWNLeEhJaFNmNlgzZjk5dkpOWnpJTE1TZUt0ZXdaK1h0M1o1Y2NobXFw?=
 =?utf-8?B?UlpCd2xTMXI2aHZlOUQ2dW4zNmRIMjlTdmxWdlNXUjJrOTBNdk16TldjNENr?=
 =?utf-8?B?MmUwUXdCL2pIN0JHMDFQalZRQ2lnbDJNcGoxOCtrdVhmQ1BtRXp2SEpHenRh?=
 =?utf-8?B?TG9QODRaNlJBRGlrbFl0aXR6bEF2bjdBSmtESHQzaUYrRmhMUTNleG1mVlNQ?=
 =?utf-8?B?VUs5OFFqUEJzU3lRaThKSmoybkIwTEJVOTBXT2l2YW9tVlgwYWw0LzZhNzFt?=
 =?utf-8?B?QUU0dTM4c1p0WEN2SEFSVUxBb08vaWU3SFU0TytXNUVjL002REJHYjNqQk1N?=
 =?utf-8?B?YWRiTThQTk5jR002b0k3M3RBRlZTZGp3NW82MStoeUFsaHZIM0c4VURFVDhz?=
 =?utf-8?B?U0lNNUFyNC8xOWtXTGVZemsxRHNVRGoxNlY1SVRNT3NJUHBvaUpjY1JieDZR?=
 =?utf-8?B?VGVSNEVSdUtNc2dTeE8zcFd3dThheFNGampzMjh1ckxvT1Nnd0VjYU5PT05X?=
 =?utf-8?B?LzRqUlVqeDhLNlVMaUs1SW1WSXlhMTBQcGpabDBnd1ZFYVZzTzRUTVNXbU8r?=
 =?utf-8?B?dUZTSW8xMk4xK1FES1pNbjBWOHRselVHQ0dMMU5PZndnN0s1cEVPY0VSQjNm?=
 =?utf-8?B?b2lyeitsOUg3dGJsQ3FHM085WDVqcDZ4clpZNnEyUURaUEJVZm9UbGF5R0dL?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97F2A01FCFD28E4BAA3732584B18B5DB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff60649-a182-4a52-850f-08dabbc8d885
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 05:20:52.6360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxGy/0gs5vAS6TbZEx2MWwfeELe8fAyjSmcEla7vKICiViL7H+1SzHnbjNNsGtmWsP94Ec6UzJxFdWvlhoKHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4322
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_222057_620872_B550C7D0 
X-CRM114-Status: GOOD (  14.05  )
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

DQo+IERvIHlvdSB0aGluayB0aGF0J2xsIGdpdmUgYmV0dGVyIGxvb2tpbmcgY29kZT8NCj4gSSBk
aWQgbm90IHdyaXRlIHRoYXQgYmVjYXVzZSBpdCBkaWQgbm90IHNlZW0gZ29vZCBmaXQgZm9yIHRo
ZQ0KPiBzaXR1dGF0aW9uLiBJdCBpbnZvbHZlZCBhbGlnbmluZyBtb3JlIGN1cmx5IGJyYWNlczoN
Cj4gLcKgwqDCoMKgwqDCoCAvKiBhZG1pbiBjb21tYW5kcyBhcmUgbm90IGFsbG93ZWQgKi8NCj4g
LcKgwqDCoMKgwqDCoCBpZiAoIW5zKQ0KPiArwqDCoMKgwqDCoMKgIGlmICghbnMpIHsNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3dpdGNoIChvcGNvZGUpIHsNCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBudm1lX2FkbWluX2lkZW50aWZ5OiB7DQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKGMtPmlkZW50
aWZ5LmNucykgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY2FzZSBOVk1FX0lEX0NOU19OUzoNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNhc2UgTlZNRV9JRF9DTlNfQ1NfTlM6DQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIE5WTUVfSURfQ05TX05TX0NTX0lO
REVQOg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0KPiArwqDCoMKgwqDCoMKgIH0NCj4gDQoNCnRoaXMgaXMg
ZXhhY3QgcGF0dGVybiB3ZSBoYXZlIHVzZWQgaW4gdGhlIHRhcmdldCB3aGVuIGl0IGNvbWVzIHRv
DQpudm1lX2FkbWluX2lkZW50aWZ5IGhhbmRsaW5nLCBzbyBpdCBtYWtlcyBzZW5zZSB0byBrZWVw
IHRoZSBzYW1lLA0KdW5sZXNzIHRoZXJlIGlzIGFueSBzdHJvbmcgb2JqZWN0aW9uLi4NCg0KPiBB
Ym92ZSBpcyB3aXRob3V0IGRlZmF1bHQuIEFuZCB3aXRoIHR3byBkZWZhdWx0cywgaXQganVzdCBn
ZXRzIG1vcmUNCj4gd29yZHkuDQo+IEFuZCBmdXR1cmUgZ3Jvd3RoIGluIGFib3ZlIGFkbWluIG9w
Y29kZXMgaXMgbm90IGV4cGVjdGVkIHRvby4NCj4gDQoNCi1jaw0KDQo=

