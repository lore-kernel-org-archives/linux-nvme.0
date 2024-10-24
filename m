Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88ABD0E3E3
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+Fv5L3zQQtAwhfv0kkG7Ms3lME8IZGdIgiKu4T/JGs=; b=lczqAcHidJOYEtVAiR8auFiAN0
	NYWYCGE7k9HhPQGRjuqJQlKf7RVZ7kMoaW0sVJBsmZxjUM2JuZxWMp81nfCy6hJYDjZyAgLWBpnRo
	776FKGU9dsYC46NOA4n9qSqG7MiRtkugp+I0Od1e7kukEqRXvMrkzpAJ7DvOAV600fQzIgA6fKFUz
	w/3hF/VLePXOyKbH5ABeU3ZlyZpBNDcezLBR0twoheoOzNT4bqftL4lYG/jGu9Bn/lLFulI/MveM+
	DacSQjFVJR5sOEvX/zO1beHDSdxmy5oD50b/DdyP70hRgFHKvE6cSV7K1VC2mxzr6yMKYHgG+kX0Q
	82uoxCBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t43JZ-00000001Z51-0KuP;
	Thu, 24 Oct 2024 19:16:09 +0000
Received: from mail-bn8nam12on20612.outbound.protection.outlook.com ([2a01:111:f403:2418::612] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t42J2-00000001QTS-0GcG
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 18:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H70jiIzpH/bLVlAKtjtLORiaoG4J2wvmoW3fmX7Z5+LOu0iaVPFGzRIBx65M3tcYth05HUpFU5gG9wBeskWDz6tSDbVgpRtiDI5Pa1Hkj9myinO1dbKr9khCknbdjZCsDFiv0vaX6fdRMLzLzhvBMmgjbrHTpzSLw8hbxN0399B9+BIg1VLLGWej+svi3JA58PlSwnLlN9IfN63wzEF91RO4oq4K7Da76Z77RWaiJXTHtNrK2V8EwFwfGWOyOy87H9YyJyG3IWyXOYmTG9atuB86NL8E4ZyRjGiP8u8twRxulGqmo5NP7KNCUeOSe9h+Dsl636Qiu/wThHrvT/1aDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+Fv5L3zQQtAwhfv0kkG7Ms3lME8IZGdIgiKu4T/JGs=;
 b=j0lXNwvB24EvjheiEZDZ/BZae1hltJjEzc5mtCUIHAjWPbds+FuHQAltAJhDcn4AAsAZPrTHB3cPaSNePWKsSUrKECX3zHKtWV6Ty5Gi93vtbnmMxflzv809NUzcMkAiW4QthjtJLMB9dbqaE92VWlJ0wGc+xbORAovPyFwaiAe96UWwqBL+4y3pIHvi2C2f0lxcP1whMiNr5oMZDdtHiiQI2yp9ZV1gvf1borwd2OkkDFATFvehoyopJ8ntHn/dmPepu4PfWGfEchfbSNv6mlQP6qhbeYHzhlgGhMg8HBb8eacnilEAHaaSrzuz7X7M8LOcuf//0ZFo/JOFRxt1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+Fv5L3zQQtAwhfv0kkG7Ms3lME8IZGdIgiKu4T/JGs=;
 b=dl1A5OWUy6EvVh5EuHgXsdOKAcwUqzWikFP3/HtjI1ZTmo4sHTLbqy5G/SQCl3goDcoRZgIrr9i4PQuwLSM7dT4AxkULxf8WN6swQj/Tf6jrzQvO7MSNpVzanhhnuQo9kssBx/URsf7Bi0GV1ihAZ0WO6+DuY6id5N177hKHKhu4AoxFZGsZEdZv8rcSIhLxKh36wyVNoRR0DX1KWTVWlElPRlHsfw832Zjm+E2P/s5z+VojNkCKy2qefj7g6M2yeoO367thfOYimGABfb+92n+UHfSlbNyzi75gdBAXagUC1d0e9PZd34ppE8Ctqwg3WNWEkihDO5eyOnIICiKEJA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB6975.namprd12.prod.outlook.com (2603:10b6:303:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 18:11:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 18:11:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "joshi.k@samsung.com" <joshi.k@samsung.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCHv3] nvme: module parameter to disable pi with offsets
Thread-Topic: [PATCHv3] nvme: module parameter to disable pi with offsets
Thread-Index: AQHbJi1RAuH0IwcKfkWwX1c9fm2EibKWG70AgAAYLQA=
Date: Thu, 24 Oct 2024 18:11:24 +0000
Message-ID: <0e001c6b-7e20-4a47-a99b-1c4f6673c7b3@nvidia.com>
References: <20241024154923.3156803-1-kbusch@meta.com>
 <Zxp5hNBP-dAaCrBn@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Zxp5hNBP-dAaCrBn@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB6975:EE_
x-ms-office365-filtering-correlation-id: bd64799b-a7d6-4d4e-0074-08dcf4574570
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3k2djY4MG1BRm1qZFhrSEk1VGI0Tnd2cStQb0Zoam5lTVdsWlBPSHlEelp2?=
 =?utf-8?B?Z0pZWExnVmdJcWxqOVZKSGhNQXhOZ1pGbTg2Z1JFdlgwMVhxMzZTMENLWlJy?=
 =?utf-8?B?ZWVJSjZsQmM3RUFoeVhiU1dTZkFJMEtNd0UyK2ViZ0RLenl5elErVy9Fd0Rw?=
 =?utf-8?B?UENNVktVVm5jS3dlc1NGZWJNUnVHNFNwSk5WUkZVSVBXNkNMamYwV0w5Rkg3?=
 =?utf-8?B?NnBOWXJKcms0Mzg2ZkVmVXFycTIyODBjcGtzK2dLWDZTbG41a0pKemJuVUhX?=
 =?utf-8?B?WWViRmQ3VXI1ajl6eGtQdUM5NkZaQTMvZytEVE5yaFlnVXpiTmk3WmtSLzdy?=
 =?utf-8?B?SG83VkJIOXJCKzJtSHFxNEgycXRQSWNoY2ZsdVk2SHNDM09PWDFTYlR0bURD?=
 =?utf-8?B?S215OENKSldmeDNhRUdGSWJzTjF1MkR2bFNuTkx5MkpnTXk0dWRjM3NmUW1O?=
 =?utf-8?B?WFFxQ2xsV3hSTm1KbzBzRmlENTU4QzNOYU1wcVFxYk5RVG1WalRYL3g5WlRu?=
 =?utf-8?B?OXFoK29WTVUydXAvM1o5eXhEMnZ5L2JGN1dhNS9RSTU2cTl2czA2akFJYnFa?=
 =?utf-8?B?cmphdFN5cElhRks4ZzhBMWFjTGZxTW50dCtob0pMcG55ZHNSRkxsbTZkSkUr?=
 =?utf-8?B?NWE4d1NkQlQrcVhXcktpbit2SXpoU2g3cS9CaElwaENWWVRjNDh3YlNHWHdR?=
 =?utf-8?B?UjAxOERucW8yRVgrWG9vUkhRNkxWYXUyeDVZTDN1L2JVcFNXYzlwZlJrUHU2?=
 =?utf-8?B?M2VDNE5SWVVvcklETENaY21XZkEwbmRMYllycU5BVlhwZDJwT3Rsb2JDbFdP?=
 =?utf-8?B?bXRCbUtJeFB3cEVOS3d6bWVBempicDg5N0JiOXhTemZ4L1N0WjJSTWY5S2ZJ?=
 =?utf-8?B?MkM3Wi9SaWxlazRuQTFwSTVuTUJjcXN2ZkJkZW9WMlcraWdoeHJDbXFQdUI0?=
 =?utf-8?B?RjZjQmt4cGRrQlRnTWVrQ0ZKaTFkSlR6S21QYjUrMnE4djJSamNXK0pkckRU?=
 =?utf-8?B?WHNYVThESmhPVjRzS3BueWh0cG42ZytrMjhhdEhzbWJRbVdldFdWbmFPYkhI?=
 =?utf-8?B?aUtxdEt1ZXhUZlczU25PQndQY1hyYzd2MTM2L0FyQ2ZVTDN6bzFKdVBnSFQ2?=
 =?utf-8?B?ajhJMWRWekcwQlNoTU5rZmNjTVByRTdrMkpRazlYUTZVY1N1b0Z2TlJWNUtU?=
 =?utf-8?B?NEIwNEtJNW9SWlJzWE85VFoxUmtlbEdUU2QyWTh6Q3dVVGZEaUlOVFJ4YnUr?=
 =?utf-8?B?aVZlZVh1NDJTVGR4REpxNXVtOXBNR216dnhTdExhL0syUG5tT3NDL2VjRDBu?=
 =?utf-8?B?ZWpISnd6UDhuR1lteDJrQ3lKdG1Mb3k3b0dDREliMkNKZUNUWXhJS0FJWVFt?=
 =?utf-8?B?ZG44UG8vWWc1aCtHNjB5U2hyTFlaWHVVeWtlR2ZSSk9ONGQ3cmJ2TWVETTMx?=
 =?utf-8?B?RTNMZVRmSkc2Zkx4ZSt0MnRkWlFCUFM0V1FtVEgzNGJ4ZkdXcEJEK2pyNDhQ?=
 =?utf-8?B?TVNPN0toZHM5bzA1a1FycDNCZG80OUtnOCtsWDAzZnRKSEhpb1IyV2Jybmgr?=
 =?utf-8?B?akRDTFEvNnhHVlNTQTk5N3BZdmpwbjdRdkxzWVRyWTR5M1pnaTNtQk5HMnhM?=
 =?utf-8?B?NmZJc0loM0hhdHNHR3p2RlJ3NjBySXE0UFRXNG1aeGczYTVaVmNLeUFUbWd0?=
 =?utf-8?B?WDI2N0NRQ0IzV3hvbEtRTHpxT0dQN1AyaEVPUmNvV1l3OU9PRHlzZy8zZjUz?=
 =?utf-8?B?NWdFWDZXMDVxdGNiQ1p4T0J3RnJkZGQzaUk0N2c0WGdYNVcxalFaTTdzMEVv?=
 =?utf-8?Q?WYYQP+rBTqlEc+m+7HbFlpABpuHSvSGnCE+t0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkZVSlR3US9mdFMvTE1SckNkekkxczRrYmtmdHJFaGZBNXAyR09leng4SlF5?=
 =?utf-8?B?QmxacHJUbXhKSjd4QllyYVVUa3BtUkxqYTIzTmFMMUtJL1FXUFkwR29UenNk?=
 =?utf-8?B?VkExcFI1NVdTcVNPVlFpRU5OUVpTRVRXc0h1MEVOV2l5TXpOTGx4bFhNY1dT?=
 =?utf-8?B?eU5JTUVFcWFObmJsY2FBNXpBeDdQcWJrQzFsVUFoZW1oTzMxaXVIRml3VXdV?=
 =?utf-8?B?NGxCT2VqOGs3elE4akxKR25RcmNmMlBUSzlYUGl1ZEtjRnFYb1Z1aHpKYXU1?=
 =?utf-8?B?QkVpU1ZQTWZMOUJEQVZsdmthZ001bnBYZFVQd0E2UytEbnMzdFhRN0NkNHZt?=
 =?utf-8?B?enBpQVcvalE3cldyekxPT1M3dFZXZnl4cVBiVFJxOWIrOXZxZkt5ampEQk1Q?=
 =?utf-8?B?eGlkTFJjQ01vc0dpWVF0U0JUdWVVSDNtdWNSSVZ6bnhpMUpKV3AreDdEeGZE?=
 =?utf-8?B?S2pVK0YwWVV5b0lUcTlTc2NxOWxxZGwvTi96b0t1WlgvQXBEbFpnSU1hNGRY?=
 =?utf-8?B?c3ZxOC9IakwxWXpGODBKVFZ1QURwWG5MK2poWEpjMFhKdWNZVlJETGRjUmVD?=
 =?utf-8?B?R1NtdUtrQlZyZnNwM3JEZy9GSU1wTnRlRUxLZmIzdW9xZ1BwVkRmK2ZtRGZa?=
 =?utf-8?B?eE5vT3ZraWpscXgwdks4S0grTkxTNjNWTmU4SWJBVk5JV1M2bnprZE1vbGpQ?=
 =?utf-8?B?T3FyMElxc2h1MHN5Ums3TkJvQkUyREVoYllndVRsYVJuSHlXN0JGaFdIeHlX?=
 =?utf-8?B?am96SzRZb2JzUkU0aHlnZFUzRzhISUh5WW14L0FwdTFkL1Bibzl4cWRyb2FD?=
 =?utf-8?B?cEo1dXZDVkZORitzVUs4NllSNi9RK0dJT0NiYldOYkxyMVF0eXRQcHBTTk1s?=
 =?utf-8?B?TDdYUWxReDRXK2F2UWZYRFpaT0dScFZYbTNOdWxMVXdVZU9aSmhYUlVSdmFi?=
 =?utf-8?B?ejRHVFBXcXlZK2RNRHVNV08rRWhPRWFqdjdjVC9kdjRoeWtPeFRENklRdXFx?=
 =?utf-8?B?ak5Zd2VaQVd2L2o3bmpWT2tjODgyZVVIdEVCc0JXUmZUdldZcWQ1c3RDdVBx?=
 =?utf-8?B?Q1pQVENqaXBBMk1kaWNCTXJNRXJKeUw1aVJtUzZUdTNKdkp3Smx4N0k3cFh0?=
 =?utf-8?B?N3N4cmRCdUFRYjZmeVNvYk82WGxmYkNjSGtGK1BDZG8yVElobncyUzFnMEdF?=
 =?utf-8?B?WFc2QVB1YmtrUEJrRzF6bndIMHNwZENJNjh0RGhvWU1kanA5azdURzQ0TmhW?=
 =?utf-8?B?aXNxYnNNa1VEWXBDTXZrNTlab25IajlsajBTNmMzTkNscGx6UVdDblE1czE3?=
 =?utf-8?B?bGdoMnZOUm15Uk8ycXJ1MmZBeUpDdnB6MDRyMHR6ZG5FRHlHZGRrdGIzczYz?=
 =?utf-8?B?YUxDM05meVdid1dZSm9BQzIvNHNoK1BUWnB1TExxeGcrNmt1ZUlSaW1QYVcr?=
 =?utf-8?B?TXpLbCszMkZQb0tOSnpwa2RuU1RMVGhKYVk5aEx5d2t1ZU1CSXF6RG9FUXBy?=
 =?utf-8?B?eXg1Nlhkek1QL09nenUxTDlmVzlZWnV2bHVOQ3kwZ2hpakg2dnJ1M3FHS0tO?=
 =?utf-8?B?anRnakFmM3JIWXpSaG8wQnNROW45UkRnTVVLVUk2YjVkRTQvL0swV3pSSkVP?=
 =?utf-8?B?WjgwYlhidjVDU3p1a1Z4bGg5SzIxNzU4S2pkWkcrRDUwanZ0aEVKNVI1OUJK?=
 =?utf-8?B?cjNCQmM3cVZFYS9YbWV5QUFIRmVlcW9mSWJyQWpFQUhuQzlwNXh2YXZPZ0tG?=
 =?utf-8?B?amZLZ21TOFdzVjZvMjhaenltWlVBOGxad0piZ09vWFVkV08xM3lROHRzZ2ZC?=
 =?utf-8?B?UmdRb3Q2YVVlQlRPZ1hQSVZlS3dnNzAzN3lMYUt4a1BmUXNlcm1UaXhOMTBu?=
 =?utf-8?B?M05mVE9jZGx4aDk1RmMwYngwcThDTUx2YWxaZEEwdXN5dTI1YmpuL2FKbzBI?=
 =?utf-8?B?eWVaQ2VHdjdHckRsNmRzeTFySlpHKzNnQWFxOWQrdG9aTzNMejQzejAwVjl2?=
 =?utf-8?B?Q2VoQkEwOG5wRU9wVkZoelRQNUpFRk9rYkhDUDZtZTdmTHBBditiOXdCbm50?=
 =?utf-8?B?WXAwV1o2a3NzU3RXMEtDaWo5Q3hiRkhRSlFrR2FMUXlXWURkNE42YUIweVB4?=
 =?utf-8?B?SlQrMU9TWGdzRDUvNG9kTjFLb3BlZjRPV1BSVndLajhucXBNcC9WN3gxR25z?=
 =?utf-8?Q?B3DmyYT/AJFycLHrdwMLREjqyLL+/udPqQ+pTj9mchTd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <196C4839DD2E4F40A8F09B3430EFB860@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd64799b-a7d6-4d4e-0074-08dcf4574570
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 18:11:24.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLYY2OytY4RKM3hK8riqM74ru1eyVc75px1KfQRWKSEpk5UmmUEM+5vdAMDbvgJtOALnFmUMpw5JbguyFJ2Hpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6975
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_111132_129385_893B08E0 
X-CRM114-Status: UNSURE (   8.14  )
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

T24gMTAvMjQvMjQgMDk6NDQsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBUaHUsIE9jdCAyNCwg
MjAyNCBhdCAwODo0OToyM0FNIC0wNzAwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4+ICsJaWYgKGlu
Zm8tPnBpX29mZnNldCAmJiBkaXNhYmxlX3BpKQ0KPj4gKwkJaGVhZC0+cGlfdHlwZSA9IDA7DQo+
IEFkZGVkIHRvIG52bWUtNi4xMiwgd2l0aCB0aGUgdHlwbyBmaXg6IHNob3VsZCBiZSAiZGlzYWJs
ZV9waV9vZmZzZXRzIg0KDQpJbmRlZWQuDQoNCg0KTG9va3MgZ29vZC4gUGxlYXNlIGFkZCBteSB0
YWcgOi0NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==

