Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE734C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Apr 2024 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w6B5y/ek09wlIFz5bPmy427wDB5IaFQtue2osoBEKqs=; b=s3bWeeAQzYvgjSpnNBDfIuqZi2
	hYUHYowwhrnhUfMsuDDtX2nEXLx1B9Ww76szd/84zfbB5o+sK6kHmFji2sTDF4ek87oE2oRzRc+5j
	rU1iY4YUNO6Zit0T5ml53VPKIm7FitV5g0/66hLi0jK1jgCkUOPyGUX2pb81DRzvLtSUlj0RikvGt
	R9yWDDmpGT/B3dqs8yfG10YcmtGDRM3W/ap4b4uGXBXXO9WpBf/5NSU6YNNzSTH6+dCDy+vWGl5Rw
	aZNFzS3pSRlSCzQWPKc2dEYU/cqNcY42VMRBo7lb5/ZqMWw7WjsiesGhYVXGtfUSz/SmcAegHQOap
	kPQMPmMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzMH3-00000001Lp9-3FR0;
	Tue, 23 Apr 2024 19:57:53 +0000
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2407::600] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzMGx-00000001Li9-2obY
	for linux-nvme@lists.infradead.org;
	Tue, 23 Apr 2024 19:57:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjGiz6rUhJ+qjilbmX5fEBZ+13iT7+q+EajacddYfHMX/NoWTlcHeGoyJvIM2RMi2rhqEE2pSK42syJsxDESRnewaMU0/dnbP1fMEoJiuhRJTnjl1y3up6k6oXbNdLnRZ0vLhs7mvrwxZRxXRtpynbc9NWWiPzxUll1qjTrx3NZ7+3ua+N+GHjW3RaGFD6b8gKesc0we6w1FBG7OnmV4s2qTmwsl97EHxc2iuVDMr4tAuJxMtLNWnJdyl/xko+0UCp6oykX78xeAPwxJfSYQNQ/q7Y6LkvtxE9ZUoh2UXYikLJDYgiRny73LhAVd5eZM+OMuD3hWUCIHioWNKZ//LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6B5y/ek09wlIFz5bPmy427wDB5IaFQtue2osoBEKqs=;
 b=hbg5BzeJ6pe+7Pvxf6nEeiy2R84iuQyQdH46DE4/llBFWu67b6jCnLks3g/FCIWCsUva91x22jiXANIsr2t0gb9Tn18/53eW3gi5EQnxwTXjoYnwdJ0t44VF5guavfEI8ZiZ9TpOB3xT/seOfG11TvoTXdQTYZzCFF/1wPJILD2MkLqW8u0EsxYx/t8JTc1YYKajfH4q4VC3T8eQgeQR4gCWajTECXhKjX2cEgXIkdKWSWiZkPKYQWEJ+UXcdrPZEG7op/9jSRUCsZiQnloxrOe4H3YBDS758Jtkgs9FyBudOh0RzgJNqrbzbIxiZw13aSzSEt5GpeDLNnp/xUdAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6B5y/ek09wlIFz5bPmy427wDB5IaFQtue2osoBEKqs=;
 b=C935A9gK416IDavweiZXhj6mi2K4tXvzJb+yIjAxAy6iUVuj5sytYxuhi+5uQYj8XJl7anu8yQmp6GX+BtzBrZLPQRLy1+IHcAiC3G6y1H5Mb4Tcps/b2Ipk4L8bLLKCrNmtRqEqkYoyTevpqGwdCU5P305B6N9d8d9SCJ2CGDd96L6Teavwbmpptax2PgAKtldnl94aXSNbXf4WasAcf1+P4fhWc6rZ3/re6Q6HxjTQEdh00HNCQh4wabGu+BgVvI7r4QMw4xM2l8fiyoMQYEXv4PihMmhWTTXMlstZSg7Z60ZMDHqt3tA89uLxifTa4jqJzhnsVx6OLKdpyga5Cg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 19:57:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 19:57:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "hare@suse.de" <hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme-fabrics: factor out auth code into helper
Thread-Topic: [PATCH 1/3] nvme-fabrics: factor out auth code into helper
Thread-Index: AQHaWleNVmMt0ea0tkaXq3zmvd8OnLFuMWoAgAiK2IA=
Date: Tue, 23 Apr 2024 19:57:30 +0000
Message-ID: <f9a83465-35eb-47d3-b279-826308132ff7@nvidia.com>
References: <20240208062427.31255-1-kch@nvidia.com>
 <20240208062427.31255-2-kch@nvidia.com>
 <aa43242d-a460-4fc2-9802-bc68f050dd01@grimberg.me>
In-Reply-To: <aa43242d-a460-4fc2-9802-bc68f050dd01@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7873:EE_
x-ms-office365-filtering-correlation-id: c3efabd1-11a1-4f18-972a-08dc63cf9bc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?bE5pTFZ1WDZNRUxkbUV2NVFtVXhxS0xLK2ZEdmxxL2RPZjIzR1dFU0lPeG90?=
 =?utf-8?B?UE5JNDZuT2RvclpXK05kNnZxZEZuQnR0T1hRT3luV1ppWSt6dFNsMzR6SHRr?=
 =?utf-8?B?T2ZLYjZIMGd3QUVYcTc4U1p1S2FxNGJ2TUdkdDVRSXN1ZHlBeDRvcmMvVXpW?=
 =?utf-8?B?Q1p6M29ya3l1dXJyVWF0ZFQzSzJjMDBHMGpvVzRjNWhLbWdabXBldkEyN3NK?=
 =?utf-8?B?Nmp6ZXJIMEcwSElqaUpsS2x0TnVVR1Qwc0hTZ2pmdXhpWEhpa1FVVWtqZGsx?=
 =?utf-8?B?M3F2Sm5OV3RsMkh0Mk5vcDA4SzVWejg3VDdSVHBrYVNqV0VuM1d5ZVZlZGpq?=
 =?utf-8?B?dkhaVURSTnJFcUVxVHkrUDJqZVZqNGtobzdibGtSRUQwTWlTYmhWSUlMM0tG?=
 =?utf-8?B?Ylk2UUVMUjg0Um5jcWo2eHgxVG5XSklnTmU3VDJqS3hlSER3cFR2a3VRNzJC?=
 =?utf-8?B?TEh2L1dRbnVHc3F6aUh2T1V3SUh6eThlZ0dpREEzRlhOK0dTU1ZjbnZaUktZ?=
 =?utf-8?B?MlV6MjdiNk5ROTI5RzFzZGptQWN6d3VPZmNXUzZwNk1QM3RLc0M0MXRuakxE?=
 =?utf-8?B?SEd4dkVDUHpkRU5RVWEveG5zMnoyRnYza1hTdFdzdDIxanpyZzA4aTlzQzJ6?=
 =?utf-8?B?WUlGT0NwbHJYNzlNc05WREhkb3N0WEFlaTNkeGU4RWhYQkdxeThBZW96VTBs?=
 =?utf-8?B?TkNJRk4zQUthbU9FMEUrdjNUeFJRdW5jOXE0UFpKN0MwNHFiMlpGZUJYRitU?=
 =?utf-8?B?ZEN6OVc0czVzRTAyNXBPMGVPK2tnbG1hZGtlSXpteU5SWVZ3aElrNlBvdFFu?=
 =?utf-8?B?eGlzVXRGb2NENWZ5SkkzbUNBdmdWcEVBOE1YWFpISHlhOVJnYlF6NTdRUVRy?=
 =?utf-8?B?Qk1GZFZCditlbWx6R0M2Zm93VlRIQlllN0ZhZTd5WDJNRktuakhNbUVJejJJ?=
 =?utf-8?B?ekhacUR1Qzg5Z0ZVRGNna3ViRzVSMUpDY3JOZitaYmlVa1RXWFpIVGJ6Sk9r?=
 =?utf-8?B?MkZzT3Zqd0NZSHh1K2lWV3pXQXBLV25vMGE5YUtYcTVtWWRHWEVnTlhnOFJP?=
 =?utf-8?B?a0VRbGNSeGpPZDczTFpjNHV1Z1BZcXJBdjJXOTRCdEJ3akQ0UldsaWptdzBw?=
 =?utf-8?B?YTUzOFdUR0IzbGUybnV2V2NJS3Q0bDF4Vm5HN25PRnFmektrdmFZRG01ZXl6?=
 =?utf-8?B?aUdYMitlbExGOWZRK01CWGNlYldhZ3ZMU21yaUlMVlhhWFhucE1ZR0J2OXlU?=
 =?utf-8?B?Zmk4OEEzZklDOVphREVDMWZZMU0rWEpLSm5XbmJtNjhqS3RwcVFrU1JFekdk?=
 =?utf-8?B?dm8wMVBlWjI0MlRvUGM3ZjdDR1dDNzFzVzh5djJpanpKbGxnT3RFcmw4OU1y?=
 =?utf-8?B?K3RsN1JzanJXOHppUkx4SlJnQ3FXeXYxc25UL01JMC9EZ2lWcWdheXYzZjVz?=
 =?utf-8?B?U0NicEZGVUhwd0g2cVVsWTU3SVhLblJnK0tYL0N5ZkYzUXNrZ0lDbUl4YTlo?=
 =?utf-8?B?djE0aG8zUGlLMDY2a3lRWCt3UVFSV3JGT3kzQ25NWjFkczBldWJYUUpySERH?=
 =?utf-8?B?QVdieXhnemVuNGdVSUdURXhERTNVQmNCK0ZGenFic3lJSlNkd3M0N0JwSGgx?=
 =?utf-8?B?WW9jWTZNY05hZ0ZhUjR0Rk81VkNscFZPRWRwUm5NMitFK1dtV0ovOStKNGpr?=
 =?utf-8?B?Tk1mK05oN3JaWnAvaVVYV0ZxaTVZbm5IeHdVTTI5d1R6RnoxRlBnSjd1TVpr?=
 =?utf-8?B?enhuNVpRVENRZHNkaWMvT0J2RFB6ZGJuQzJBVUFiVWdWOXRtNmpjaFpxY01m?=
 =?utf-8?B?SmVUZkdldnNNR05DUWVCZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXdyZUpKZXh4WGFBZG1oZ1d3aFZzalZiRlkvM3AyMGdZVm1BT1FGVTN0dThj?=
 =?utf-8?B?b1VSSEd4dTBadVVCM2wzcVg1QkJpaTIvUUN1bXdXKzE4TlFNTU55amh5WnZG?=
 =?utf-8?B?d0VPZ3NWUU4zZVoraEJVWCtid1J5WWRvTmR1b2VLVzBDNkc4WXU3QkxBdnZx?=
 =?utf-8?B?R3gvQWQ3dXRhWjJ4VTBWY09RQ0VpL0I4YUR3NC9mM2xQNHV0dVdZMmF0Y0w0?=
 =?utf-8?B?N1JGeXZKY3BvaGNEZGZVZlFiV1FQOXZkRUNHdzVHRVVVVE0zckl6SzIxNlZx?=
 =?utf-8?B?alU4cWlwRmJvcmZ3amo1TWlGUk9VSktmdFpBaFd3S1BYS1EreTZ1dFc1eWNQ?=
 =?utf-8?B?TS9QWStpUlZBdGlIeHJXUWlMZnFnRTBMYnlVNWplTGpvRUduaE5OdXRTMUtC?=
 =?utf-8?B?R0U5L0lwcDgrNUZZWnVGZEtlL3J3eFgwSmF5R0JUd0RucEtFczRGU2VsSHJr?=
 =?utf-8?B?NjRCQW56a25WMFN3RWJZRHhtL002TlNjUTZTdlFSbVlVeSt6NzNHckdHd1Vs?=
 =?utf-8?B?ZVhBS0srMlI0SjV1cytnRDByL2VVb1ZjMEVJK2EvNU1Kdno5MlhaMW5WYVhw?=
 =?utf-8?B?VGdFbVpEdisvYjVDbjViaGVLYlIycWZjT0ZkSTUxb29EckRLVnEwRjZaSHpL?=
 =?utf-8?B?MHRBbmNkRVVMR3JzM1p5bnM0K2l1bmIvRzF3c3F6bkpNRzAxenZmM1hLSU4z?=
 =?utf-8?B?Y3d6cGhqM1VBam1hWXVkcGpTdHkvZll3WGJPa2pyMjJGZ3dYTGhrQnUrZ0dI?=
 =?utf-8?B?N2sxWFlvMGlzVjV4L2RXOE1GeDAwZDVFVWd0dUdVTGNGendxZ3ZmT1ZTbTVs?=
 =?utf-8?B?K2ZoMng0MENUSi9KWXQvRU5nZjFiZFNNZ2UrRkRvZGpYVlpVV1VJWEU4WkdV?=
 =?utf-8?B?OFh0RGhEelNQN05PTTd1SzZJc01zdFJYR2o4eVBWd0IweWJRVHNQdWVvWUhw?=
 =?utf-8?B?WXI0UmI0UENEN2IyUHRNZElDMUE4aHdyQ05VUVhVazhGZW00bitNNDNtL1pS?=
 =?utf-8?B?THFPZ1NTeUpWUlpoS0tGNlpHWnBqVDBvVC9SdFg4bWlMYlhYZFdxRU95dWZn?=
 =?utf-8?B?TXJaK21zRVkxSEkxcjNGSkVheG9iUDFrQmJZbGcyTzgrT3kxV1lFTzhYbzQz?=
 =?utf-8?B?ekJKM2d2U2ppZXk4NzNabmtSN3lYWGxxaXlQcVJHOER6MThYaktSOEpsZVov?=
 =?utf-8?B?M0hra013TU56T1RYZGZSNkxyZnF5NXJUK3JiVWZ4Vnp6dXBJK3BpYzlkSTJi?=
 =?utf-8?B?Und5S3JOVk9ob3R1STBGbWtQV21SWDdOYnkwS25oczl3aENRWC9XS2I2YXFq?=
 =?utf-8?B?Y2FxTnhmd0R2MjRhZU9LRG1iRUNCRzRpUUFqZ1J5ZmNOTzRoRXc0ZERNZHMx?=
 =?utf-8?B?MDhsTWxkMnVKQjNJcXdkdmw4N0hXd1V2VjhncHB2TkpmQ0hFaHZpeE0yS1ZR?=
 =?utf-8?B?Nmt0YTNCVlZFMHYvQkJtNGMwcnpIYTBIWlE0a2FxcmQzQ3orYjAydGRsV3p1?=
 =?utf-8?B?Z2lNNlpMbks1SWZnMWk5UG04U2FDUmNFL2pjdW1BRjV5NGcrOUYxa1NvRmlR?=
 =?utf-8?B?UnRxL250SkJCcjE1allFWVBSbjBXaHEzQitISE14aFdtZUlTUXM2ZFZzWHlh?=
 =?utf-8?B?alIyek96YnVmUVFFUjQ4SVJkVDZUMENzWnNnR29qVi9vdloxL0M3QU1SeUdl?=
 =?utf-8?B?MDJSQ1Nlc2U1M3hQdyt5L1NhVWowSzY5em1aTXI3MDg4TVRZdXRyRFFwM1ls?=
 =?utf-8?B?YytuelNmdEwyQ1pHdlg2cWFQbVcyWmQwUUV2VGg1WWVXUmN6RTdGL2Y3Ryt1?=
 =?utf-8?B?UkRROTBxVFVtd2ZTdzhncGJvaW9rT3NTQ0xZK0dUWW1ONWJuSzRMUjJiR3l0?=
 =?utf-8?B?VGRPd2hiMXZlKzJ6RVgzc2NNRkk2bTRFTXV2c1J3UjhJaDMrM1c5ME82UTFP?=
 =?utf-8?B?YXIzMTQrWGRDNVRDVDQ1N1R3UHlIYTBVOERzSHNDYi9DdDBsd1NCaWx5bjla?=
 =?utf-8?B?Wm03WlpHTTNqVGZjQ0Z6UHZDcHZqaWNxaFJtNlNKZGlzTlp0aGFmQ204QUkv?=
 =?utf-8?B?RCs2YVhGN01OZVU3dDM1SzB6cXJqSnZDQkRyK0hkWVI1c1FHTnl4MnYzOFVU?=
 =?utf-8?B?a1NlUFArYy81UUZKVjE1Zk4vOUdTVXo3Zm9xVWwyajFuR2toUXI2QXIrVFBI?=
 =?utf-8?Q?EXPxNQxW2zBzz1qopCx+/3TUJI9rgIaGU25hVJEvH+T7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1890B48FAE61874E9F738306ED74C32B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3efabd1-11a1-4f18-972a-08dc63cf9bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 19:57:30.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ExXrUu21n76r85v83PudsmuG59H5X6JxTtXhKwC5jBoY5qCIR9I787yPDmpJAp0wfs9MLyaArB8gOztndPBD1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_125747_814906_DACFC2BF 
X-CRM114-Status: GOOD (  17.13  )
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

T24gNC8xOC8yNCAwMjozMCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4NCj4gT24gMDgvMDIv
MjAyNCA4OjI0LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBQb3N0IGNvbm5lY3QgY29t
bWFuZCBhdXRoZW50aWNhdGlvbiBoYW5kbGluZyBjb2RlIGlzIHJlcGVhdGVkIGludG8gaW4NCj4+
IG52bWZfY29ubmVjdF9hZG1pbl9xdWV1ZSgpIGFuZCBudm1mX2Nvbm5lY3RfaW9fcXVldWUoKS4N
Cj4+DQo+PiBBZGQgYSBoZWxwZXIgdG8gaGFuZGxlIHBvc3QgY29ubmVjdCBjb21tYW5kIGF1dGhl
bnRpY2F0aW9uIGhlbHBlci4gVXNlDQo+PiB0aGUgc2FtZSBoZWxwZXIgaW4gbnZtZl9jb25uZWN0
X2FkbWluX3F1ZXVlKCkuIFRoaXMgYWxzbyByZW1vdmVzDQo+PiBhdXRoZW50aWNhdGlvbiBzcGVj
aWZpYyBjb2RlIGZyb20gYSBidWlsZCB3aGVyZSBhdXRoZW50aWNhdGlvbiBmZWF0dXJlDQo+PiBp
cyBub3QgY29uZmlndXJlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9hdXRo
LmPCoMKgwqAgfCAzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gwqAgZHJp
dmVycy9udm1lL2hvc3QvZmFicmljcy5jIHwgMjUgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4gwqAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5owqDCoMKgIHzCoCA4ICsrKysrKysrDQo+PiDC
oCAzIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9hdXRoLmMNCj4+IGluZGV4IDNkY2U0ODBkOTMyZS4uMTU5MDcxNDYyNzM4IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvYXV0aC5jDQo+PiArKysgYi9kcml2ZXJzL252bWUv
aG9zdC9hdXRoLmMNCj4+IEBAIC05ODgsNiArOTg4LDM4IEBAIHZvaWQgbnZtZV9hdXRoX3N0b3Ao
c3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4+IMKgIH0NCj4+IMKgIEVYUE9SVF9TWU1CT0xfR1BM
KG52bWVfYXV0aF9zdG9wKTsNCj4+IMKgICt1MTYgbnZtZV9hdXRoX3Bvc3RfY29ubmVjdChzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsLCB1MTYgcWlkLCB1MzIgDQo+PiByZXN1bHQpDQo+PiArew0KPj4g
K8KgwqDCoCBpbnQgcmV0Ow0KPj4gKw0KPj4gK8KgwqDCoCBpZiAoIShyZXN1bHQgJiAoTlZNRV9D
T05ORUNUX0FVVEhSRVFfQVRSIHwgDQo+PiBOVk1FX0NPTk5FQ1RfQVVUSFJFUV9BU0NSKSkpDQo+
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5WTUVfU0NfU1VDQ0VTUzsNCj4NCj4gSSByZWFsbHkg
ZGlzbGlrZSBmdW5jdGlvbnMgdGhhdCBtYXkgb3IgbWF5IG5vdCBkbyBhbnl0aGluZy4gSSB2b3Rl
IA0KPiB0aGF0IHdlIGF2b2lkDQo+IGFzIG11Y2ggYXMgcG9zc2libGUuDQo+DQo+IEhvdyBhYm91
dCBjYWxsaW5nIHRoZSBmdW5jdGlvbiBudm1lX2F1dGhlbnRpY2F0ZV9xdWV1ZSgpIGFuZCBtb3Jl
IHRoZSANCj4gYWJvdmUNCj4gY29uZGl0aW9uIHRvIHRoZSBjYWxsLXNpdGU/IA0KDQoNCnNvdW5k
cyBnb29kLCB3aWxsIHNlbmQgdjIsIHRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0KDQotY2sNCg0K
DQo=

