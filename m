Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6063AC021A4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 01:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qbJHrlRVQAyh+43S8EmVzYtWf4E9dCt/DI75YNKUnfw=; b=VBzy6SXEHJ8wXXoV4l2TW0is23
	xSDHvyJxMtXNXoPPd5mC0sM5K2fhsfU6S8qVZSev1RS9l/KqOY8+vuMjAVdNQiuhjJhzjM15KUSVS
	yOiaPbHlaTymZ4KdOTHXlRK+tGOJvkBLrLQUqY2I8zIP2IJft5HziYD5l26rqQIz3fBejZTEi24lf
	lx3rDId1nUFVxdDQ4Ftb/L0p/Xt1KVGWJbmn1M3z3ZsdOzOsD+libE7GioH+x3xzJBdL/TyBGZPen
	Juv5nLmqDnAXWc6GCGHhYIsB34Bue9rI6c+Y06tV8WsWWrXiI3LmmLyP5W2AKJPv/HAcoiw8ul6Gs
	o+VW7mww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmk7v-0000000Fk8w-2mvO;
	Tue, 25 Feb 2025 01:52:51 +0000
Received: from mail-bn7nam10on20613.outbound.protection.outlook.com ([2a01:111:f403:2009::613] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmj3d-0000000FdjL-49E2
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 00:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnm8NnD55qznLHrFi6VVKD+zee86b3fvF/ep6JP9JUkYlZqS4XdoQolsJp5ZrBbIc9FZEsEkc2NZ/2HFha+djFFCcFH5+pIxLRPOT6vl7TsW/nNLecSLDziIp07lzIJDTXxop43eAFYnbHr/BqY4r76SCaz+hfWkCFBsM7XbCQXUziZp+FiWoycXDwySiNWz+kBalzAVdx2zjK3vZNvWdnYi4QxbYfAHqsoe+a+MB2b3xZRIkveqe8CiZLmtJzzIUgdRqjl4+pZDO9YUS8GLlw4sfCIOLW9dPLnegxpokd4WGT1L99S0NR943sbfU8NbNK4t2G0NYXwHqRzFAe+QxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbJHrlRVQAyh+43S8EmVzYtWf4E9dCt/DI75YNKUnfw=;
 b=tzOU2QcAp8UdHWSEg7issx5c15FG83dBNdnE94r+T+pCwW0iphR9RRe31wHIkiyhqdD8pMkHT4wjzOJfhxzxCrpgsOi5eXkry/nU57QmVNUKFxs6Lgm/v/srFpZbrSEghIdKhTTFSGCNtLLaOmZS+gNa0l5iLevsu5Yg51zXFtgf6M4Vxh0La3a6Yv1DnobSxVxOXUFzaCYFL+AuEOOtrMM7UhFbDdlGGuDia91XLPrr9T9S0CCLzT7ebgxc583ESw6qF6RQTuoOPZijAugHZnx9lyvt1dpwn3zeBSb3KvHW1gjj7xX6P3/7P98FhWab8/WVBpRc//jTjGGcPOv6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbJHrlRVQAyh+43S8EmVzYtWf4E9dCt/DI75YNKUnfw=;
 b=dUtMj8/ZlLTIV2Frz4AzLjBCykKKLIpnzv0UkWRDshj4NJeDI7v8g9Ld3n/3Q3Y6ukdh6d0o8oZQQUz4Vv3uRWu62zN8rwVjiAPpuZ8bxWnA/MezUVYSkd97+EdZhiGRpqMsq9DVpjyxS7LrfUrAcWll7cWQ7oiQUFXfyhni3tNN3ehWp3CS/SPu4iAURvYaKo/l7uw9AO7SKCrJEejKgNU4ImvY4Uskywg4YmDMi0YHqq1OSppGUmnkUdUNG4eqPqygwLIjgZhjdksQVMaHk9hyJDwJyhqWkWc26lh6yFxbMgHGdhojA24vSp13MyNBnFpLXDg1qMa98E1iKlqzKA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 00:44:12 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 00:44:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/6] nvme ioctl cleanups
Thread-Topic: [PATCH 0/6] nvme ioctl cleanups
Thread-Index: AQHbhuqH92dY8ns64U6+uRDZZpf8xrNXLvCA
Date: Tue, 25 Feb 2025 00:44:12 +0000
Message-ID: <96cec3dc-5dde-4ddf-b238-906db4b78d73@nvidia.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
In-Reply-To: <20250224182128.2042061-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7106:EE_
x-ms-office365-filtering-correlation-id: 21a69075-33dc-44c1-7c3e-08dd553585b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eTV4L1VNMW1jczdRTHJERE1KbU1zR1RvUFBKSFJYSHRVdm1qdC9VbEFLQ0xU?=
 =?utf-8?B?em1ROHJSckFWcEZ2MHZiczlFcFF2Q2VRWGw2Tm51dVhtZGdpWC9ibXNPWVZP?=
 =?utf-8?B?ZFhpMk45WHdQUmh1ZDdZSVJtUlBxcFdUMkNxMG03ZzhEeDB6UFZSRXAvcHlh?=
 =?utf-8?B?UnM4UWR0d3pNRHBNZUdnYlRFTkRIWG1VU3RYSWtJMmhxSFdkT2xCekZkNFlG?=
 =?utf-8?B?dk1PUTVsMzhTcEZweUQ3UUN2VFFIaXJGQi9JNXFTS1RKbXJMTXMrWVNlTE03?=
 =?utf-8?B?MFhoYnZZWUNGR05QMUNJdDIvTW9HODdNemJVazU2V1J5WWhmUGtLZlN2QWlX?=
 =?utf-8?B?TTVJK1ZxZUN4VHpNZVlqczJXWGR4TCsxS2FpczlHeGlZbFhiTi9sMzJBTlpo?=
 =?utf-8?B?NThuem5IcUg1dk1hRnV5QUZONVVaTk9FTU04YTRrUTJHZytmY0RGMDB1VVdL?=
 =?utf-8?B?MDRlMmUvUDJDZFBER0dReWRzWDRoNVVuZ2IwQkZHYWU5clQ3ZnQ3R2RaQ29E?=
 =?utf-8?B?VDAwSThzd1lwSmZNa2xxTVRIRzNSTXhKL0dPam5CKzN4Q0dyT01pMHY1Wi9B?=
 =?utf-8?B?dm96VmZZTGlMRXBUNVRxWTB0Ti9iem84S1NFcnlodVgydXZ4RnFPbVBZcDNT?=
 =?utf-8?B?OGtCYk1VNlNibm40elBQZU44Zk9XeVJpNVkyRjVQQTlSZlpaWHQyNUtMTkhR?=
 =?utf-8?B?WW9LNEFRdElMck5mTzhQaVlRZ2JpUWU0VUdvSlJDU0V5UjBFQWhZQkpoSnJX?=
 =?utf-8?B?ZXQ3NTZiYkhMaEhZeFVDRExoRGlBdnphMTl3eDZRQ0tHbm5Cb05hRTNvMTEw?=
 =?utf-8?B?czFwY3FzeDNlTWcwbWFLR1VDcDRCUXFKUU9Lb3NXeGxxSDJSQXI3ZjhPanYv?=
 =?utf-8?B?RklyUWVKQlRxeThYbFI2UUF1R3lsUjFQaXNyOElob01jbHJhc29RYm16ZEZh?=
 =?utf-8?B?dHowTmthTjBLQXRjQk1KbkxIdWVJTFdmUGlwcmtCbnBheVBDN3VHOTJ2WE9B?=
 =?utf-8?B?a0svZEllZWpoaFpYbFhwNW5hVVRmazZ3emZrUmUvR1pJb1cvQ1AyUUZYTlUx?=
 =?utf-8?B?cFdZTFhuMnZoRGdQQTQ0bmNraEpJMy95b1VGSlUxdzF3dW51eHZvbW9qNUJC?=
 =?utf-8?B?aE1Udmd2d093WVk2QWVreVcvTzBmTStBWGxqaE83U0VkSklPeHpHTEo0UVhl?=
 =?utf-8?B?L2NzY2dBVHFwTTNYMUdQdWtHc05FbUxESnJKRDNjcXVIaVdib2tqcEVQdGdW?=
 =?utf-8?B?YVBObTFJN2FGN0VlNTdleWR4VWo2amcxSVpBQUlIMXBaL1dFRnhMS2RFdGVq?=
 =?utf-8?B?RytRdy8yV0Z5cjFKRVlVT05Wd3VLd1lVa0Q3MDBjSjRtMkxSUWhBYTlPRmdj?=
 =?utf-8?B?Rnc2TlNNQnFYNnJFNFBZSVp2M2wrUTErNUQrTFMyYWttRmZlanh1eThLWWNN?=
 =?utf-8?B?U0hYNHc5RVV1VW5jeHhoQXI5dm9veEwvR0hjZGJ2Q0xDKzNnRFpCKytXeUlK?=
 =?utf-8?B?OGVrZExZTU5oRFUzejFCNVMxcDcxZ1NLcWZpeFJMN1dhTGNZZGxaWjFoUjYy?=
 =?utf-8?B?enQ1aUsrZFlVK1NUcExtSUNNeUtZaDZRRWNSelZiRC9ad1V4VzJHcEpaRU1R?=
 =?utf-8?B?NE9DQ0NhQ0VRSElaLzFheElaMUlML0Z6dkU0MUxzM1FGMGJkdjBpbko1LzFQ?=
 =?utf-8?B?THJXN1daRlJremFnMjdXZTg5c1pTOHpDYXd0UmZ3SHRzRzhZWUJXUi9kWTJu?=
 =?utf-8?B?ZkpnbmR5TFBad3RreFZiWld6NkNLakhDcFI4enFyblJ3WkRYSmFJVzhHUDRH?=
 =?utf-8?B?YlJUa09OOHJlSmhOaVhvT3FmbHp5VUpPUmI2VWZ2WjlOR3lTWm42WDBaMklV?=
 =?utf-8?B?RW9vN1cwNTd0WWtvM1RFKzNhK3VsWnFwaStYVmJFa0pZbUp5VEM2a3NESUFE?=
 =?utf-8?Q?rQK8AS1lErj6N381S4+2KGJZmP7Bat0B?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWlQa2x3dWErWjRPQlNZeW1MNVdDNVU4OURBMEErUnFEc2k2ZFF0aGdPSFh5?=
 =?utf-8?B?TlFaczBtVElmMWFYcWQxSlArWEgwUENIRk8zcDF3WG42YjRwdjZIb0F2Z2p2?=
 =?utf-8?B?VlhUUXc5aHV4c0NsVWs1RkpCRTk0ck16TGNlRXdFZFA3cmRvZ2VnVGxyYmZX?=
 =?utf-8?B?cFgyK2J3NmhtN2xIQStFSEJqVm1mdWpxalpXNUtBdzk4L3lVSlhZVkIvdXM2?=
 =?utf-8?B?UVJHSDZraUFnVjBYTElwVGZXaFlNSWpidXpKc1RPUlh2NlloaVVkcXlzV0Rt?=
 =?utf-8?B?YnpuRDhzTW9sRjR0REh6UG9aUEFpV0FlcEhYTlBNZXNyeFNvdGZGNnUvTC82?=
 =?utf-8?B?dGhTcnlJR21MbVZTRitkdXFiNzluV3dHSEMxME9SYWpTTWZieGh4bVBhWXFi?=
 =?utf-8?B?Y2V5NDBHajdFZi9HUTlJS1RGeWdTb04rMWgvaXYxQllxRThtSldyV2lRUVNP?=
 =?utf-8?B?UjZMR0RSQlRnc216Z1F3bXdlbEI5SnJvdExSa1BQbXF2NGdIK0tUanJBeHdK?=
 =?utf-8?B?Q0xUSzZuWG82by9vcUM5S0UyOEc2MXJQTmZBNGsxQ0FtTnZFaXFwbDlaSUhv?=
 =?utf-8?B?czRiUk41WGlJVWJQV0ViSkxtbUxZdG16N1l4VDlCdmpkdkZWaHBXL1JUbzhD?=
 =?utf-8?B?S2k1dG5NZXF1OFdvdnpGbHVDWlZUd2FqU2lRdHpZdmZQTi93SHdwMjRCQWF1?=
 =?utf-8?B?aWdpZ01tSkl3N3N4bFZrRFFPUGxLbGxxcVkwV0pyMjJwYXo1RWdYT3U0ZU5O?=
 =?utf-8?B?cUduVFpxcERCTnFoMU51MnVwWUhnWXV5eHByZFFuQU9SQkszMUJwazZ2b09o?=
 =?utf-8?B?ZXpoNXZjci83dUpyMFl2d0VsSWNlT0pseDZPRXJkcTRxQlhjUm5ueWhRcHN5?=
 =?utf-8?B?N1lrazRFT2lvbmdJd0E4aS9xMVc0aDFhT0djNWZJbWpQdmkycHBzRnhVSGV2?=
 =?utf-8?B?ZnJ6RzFraWVrQ0JxbWFhV1VRKzExN0J4aHJndXVrVUVMYXFHbUdMa00vZXZG?=
 =?utf-8?B?NWlDVjZTWS9zRkZZN2lYenRPL3VOUENlV2JzaDl4U2g4K0dDWERyMW8ybHk2?=
 =?utf-8?B?VytyOFgrMVJiVGNkb3FSdUpaK1hSc1Q0UGRiUHNqZGN5VXJRSjF6RStlYlFq?=
 =?utf-8?B?MmlXWVZJbkJNRy9PZTF2bFRuUXNYNzFYSFBFeG9Iak1SalYxZHFoTitMajRU?=
 =?utf-8?B?RWRxNVNEOENpQmxLYnpwMHFQSWZTdUQyQXA2Z0JTWVozajBWbFNpWklBYURD?=
 =?utf-8?B?TUJTMm1RalVHWFRINGFranl3UEpuMUoyTkxaWEhRK2VZL2p3bTNHUE02bVZy?=
 =?utf-8?B?Y045U1VrNjVocHNMdWNqTm11a0p1eWFBOThySVVaNmRCNnpHc0k2STVrUFEr?=
 =?utf-8?B?cXhYWFVncVdLQkk3eWo3bm5XVVFIb1kyc2E2b1RKT2M4dktmVWk3MmZBZldE?=
 =?utf-8?B?bTdMRGNRejR3dGlRYlJVWFRUdGFQa283OFVMMzVLbW1ob05zVjZ6c0ZkYWJW?=
 =?utf-8?B?bEZwR0kvTzZmVVhIcTIra3ZOamtpUzNBZFJUT1R5ODB1M2l0QnV6bTAwSS8w?=
 =?utf-8?B?ODV4S3JrY3VxS01mWjZTdE1FYk5pSFp0bmUwSkVUK2N6dXE3ZlpGdEVEdFlj?=
 =?utf-8?B?eC9PeWZMMWYzRUZPVXY2blpjdUhKWDAwTHdKc1BFMWlEOW16K0ZYK2VDdnlk?=
 =?utf-8?B?Tm5BblJpeUE0NFo5ajVxRlBSVVc3MERXdE0zbDFGZ2t2LzJNbi9WY3lRRmhL?=
 =?utf-8?B?V3dwWTNoYVhNbHNRMmJESCt1ZG1nZkp3SnFJZnFJMEF2SWVHejdJNnFjeEF6?=
 =?utf-8?B?cmxSVkxZeHpNaUx5c1lWTUU4Vll6V0dFdm1EU1kvTjF1TjF3emNPNys2Y0Vo?=
 =?utf-8?B?d01RWVpoSGd4V1Z5QzUvYVRLT3JNbWZsRUJ4RFZDYlBHY3drNVVuRVUxTXdI?=
 =?utf-8?B?ZWZxbXp0RFBkcDFYdGJEUldjS1h3UnF4YWJ0d3NBVEdHN0F4dzFnV1JoelJu?=
 =?utf-8?B?eG11MW56U2tXa1BsNHFNV05DVDBzaElnakJlZEVOSG1xOXFqSzhDclBIcXNw?=
 =?utf-8?B?UWJ4YjdCMmlRTlcyU2lhOXJQRjk2TFROTXB2VDZuZVVxcWExdW1vUUJ4dnB5?=
 =?utf-8?Q?xLzWsYUJEgqrLNmZ9cciopZNA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B80C98AD5A57C41912F524F6D07660A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a69075-33dc-44c1-7c3e-08dd553585b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 00:44:12.1170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KoyPgrXKoVpin1wd3F1760FMxNh0XJ2vb1FK5JSpYQAIwF78RXY4mwtTz2JndwXz1a3rgPglV3LfgH1T6JPflg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_164422_030704_D6BEBAF2 
X-CRM114-Status: UNSURE (   9.77  )
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

T24gMi8yNC8yNSAxMDoyMSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gVmFyaW91cyBub24tZnVuY3Rpb25hbCBjaGFuZ2Vz
IGluIHRoZSBudm1lIGlvY3RsIGNvZGUgb3JnYW5haXphdGlvbi4NCj4NCj4gS2VpdGggQnVzY2gg
KDYpOg0KPiAgICBudm1lLWlvY3RsOiBmb2xkIG9wZW5fZm9yX3dyaXRlIGludG8gZmxhZ3MNCj4g
ICAgbnZtZS1pb2N0bDogdXNlIGNvbW1vbiB0eXBlIGZvciB1c2VyIGRhdGEgYWRkcmVzc2VzDQo+
ICAgIG52bWUtaW9jdGw6IGZvbGQgJ3ZlYycgaW50byBmbGFncw0KPiAgICBudm1lLWlvY3RsOiBj
b21tb24gdXNlciB0aW1lb3V0IHNldHRpbmcNCj4gICAgbnZtZS1pb2N0bDogY29tYmluZSBhbGxv
YyBhbmQgbWFwDQo+ICAgIG52bWUtaW9jdGw6IHNpbXBsaWZ5IHBhcmFtZXRlcnMNCj4NCj4gICBk
cml2ZXJzL252bWUvaG9zdC9pb2N0bC5jIHwgMjQzICsrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyOSBpbnNlcnRpb25zKCspLCAxMTQg
ZGVsZXRpb25zKC0pDQo+DQoNCkZvciB0aGUgd2hvbGUgc2VyaWVzIGxvb2tzIGdvb2QgOi0NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQpUZXN0ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNClRlc3QgcmVzdWx0IGlz
IGJlbG93Lg0KDQotY2sNCg0KDQo=

