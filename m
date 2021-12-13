Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718A2C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 07:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3MLenRjuqFGfye5AAgNFO/7WhwHdyP9fiiX5CdvR4Sk=; b=YF7i7zosKwGU4Mjw3cfRpInYQE
	/Rzk0Ic8w/zh0cpdrbKO3dOx2NzHMRylE33rOVOlgBScj4B6G0EXpMgrUMQMBx5j6+kDgA0SnVr7o
	NWav4sy7mAYemEGbmubQF890HuP/EqsnHUEnwp+vaHxgcYOOvBaiY6pS0f+YwRyPRcAgUbO0JakNk
	uRChHfZxKKWnQlsnwz1KMmrR5tXxc88tfztVR/x76OeaE/pXpNy3KpSt65z8iVtR+GVttt6fW4U+Y
	hr753BLAk4S/jhJ3Is9zrZd5/tUTscfy4lGSUeTOs5gXo37HQQGviyaDjMxhlLvwvJLgtuxnSzCJk
	D6oqhM7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwfQh-0081L5-3Y; Mon, 13 Dec 2021 07:07:23 +0000
Received: from mail-sn1anam02on2043.outbound.protection.outlook.com
 ([40.107.96.43] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwfQe-0081KG-7Y
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 07:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVlwAMfozstQQ1iuBvnWCp81thaECfkVuJgB9G6+MW2ssoNiGQdoroDWG2KOaLoMcMvlBBq6T/A1JStZfxM4PquxkqKDnkzIPSo+7V/m5FFLdfqJ8ZfAhzUDa8y2HBrL19uZ5Pm8S4+twYQA+ftbhKh0QzRzjUdCmGO9/kIZbTfrj3o/Oaq8d1XsdjcNdCwSyih8rd8kpt+4TZjsmKpj5j72kijJFYCBZ2/Ch2GjDq2teCq/d9UmzyJCkTEIgWyu/qwXEpt002wwXAjkM+quPqvLhAeHCAfAhhaYdrdTDv19XdTyq9tNjVGgINXgAcx5m6yaypllFHN+Bu3LvZpcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MLenRjuqFGfye5AAgNFO/7WhwHdyP9fiiX5CdvR4Sk=;
 b=ImkEbbnwxW1dkI4U0UvNuKSlzquUKkbzcCbR3Kv3ka7jymsV1xtg61hooiQ3d7I0Syl5kyU1nIdlpTT7uVjd/OCz8WYoWTjyWJXGz803ghH2fY0eru6TpjaY92lpx9vdk83j4mbQeW7C5uggojJc4XxB6cRIxRJavmkE2FNkewFN7lLogU7Df7S3rhASg0HVINpRi6tLaG9xfxHr7HDdqFkVEr0tXvStqYLVAxaL59RyFkYv3PICdekQ52wcg/3IEaDW2RokTuKbPn+oi/Kfj0wn3WcTxrUG4fhd84ezrRGRi5ty+Pijp4fZWvpD5iEe8N4i2bljG9KMPiIIsnnnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MLenRjuqFGfye5AAgNFO/7WhwHdyP9fiiX5CdvR4Sk=;
 b=U2DRf5H5Dofc8vUjPWsIXniFdLnvcgqjEMGvz8sf5z2zQfNLr5n/XlMduGbPrSC1mRpLKb5ZaSkZaC1DlAwGEdf+fQygPMIqlzA5eFOA/W42cUf2BvMA+vQ81cOp3mGT1o5CZaXop8B6OC621UnUFjJaW4pJzC0p/wY5B6tsTRzWwsri+L7cFbj2AmiTWc/UFDgzxF+Lr0gvQLN621hyBZgAGybLzSyFO59+ax0dpEg53LyBH8No/BU3sLj5Q2lenrZi3doxrcnNdJ/k4YO6z1C2iIjvsRSRXNpxsAnN94KkET/COygRNXAPIyRxi2rRrr6V38adJ8+jGX7yquphsQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2508.namprd12.prod.outlook.com (2603:10b6:907:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Mon, 13 Dec
 2021 07:07:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 07:07:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme-core: move gencounter check into nvme_cid()
Thread-Topic: [PATCH 2/3] nvme-core: move gencounter check into nvme_cid()
Thread-Index: AQHX7bgvtLb6GLoTo0CdCskgu+VpBawr3eQAgAAihgCAApbrAIABbVcA
Date: Mon, 13 Dec 2021 07:07:14 +0000
Message-ID: <a53c4433-1ccd-b634-29e5-d6a240505c5f@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-3-chaitanyak@nvidia.com>
 <20211210154324.GA3856533@dhcp-10-100-145-180.wdc.com>
 <d0ce0b57-211a-5e04-9528-a99a83f22600@nvidia.com>
 <879b8c22-878d-3bb5-413f-559df240935b@grimberg.me>
In-Reply-To: <879b8c22-878d-3bb5-413f-559df240935b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91488a3d-80dc-4f4d-f7b4-08d9be0730f3
x-ms-traffictypediagnostic: MW2PR12MB2508:EE_
x-microsoft-antispam-prvs: <MW2PR12MB250887E66EEC8F2C226AE185A3749@MW2PR12MB2508.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hiUQAkNZyevbV38GyudzCZX3TlBNpvax+CigbOTam9rQaEKEiuPn/6Fw60PyL+GmjcGE/WfqaBWw3M0M8PUHD3f7lyqONogBnrFwaaOSR/d24Wf+J3kxo/9U2iMD09oTYEahydRlrC2OKoe0s43N45piO5Svg4wb0kXqjXhBv+cTkrzrozAGAjHJ0ZIxTiMbcKOvbLBghAVt+aFiATcPunVWekE1q8ZQo/8FjQV68EssjRBMtSdcNsEl/lE/hdBeZSoKUwv1eNf8+ZVYMx6LBv6SRKrFaMZY/TMcn+fA/2seTVGtashd26PjClMo+OXwE4SmXH91n+K3a5NxocESXi1ZcOxFy/rAJBQgj96CajOfKQfN+p9fZt6KkHF9Ha3upIJkvFAeqDUd457BUAV9/du8obH2rrn4UrXhIi19NQ2svtWARcY/Kd/ncw4WOvGLEsacvXZh00zvW91DNJ5mRd0d3Pfyv+0vsaU+aHxCZZua/XAtkDzKjSGgY/gqtXngxxml8T/XBFJm472kSEkXMcBOQ4fiJZZsSJHwHzFKL22eFqucWgt2V0Mg9vYyjShkCGVhnY5/F0o7ZIqdV281DoidYtKEXthOdGWZoDNtJoH2G0rUg3CdM1Yj+/gji0ZfAQ5SYDNGeGpTlnYO8N26eDN/nzVrxa99rBVDG1xWvhJJCFbRr9cWGaj7a4no8XC5GdHGJPW24y3b2wjhmGOzB5OIssHT8G31pmcHf8BD4Zh6lLAk1z/mv654CBmXI6BhMAdDiB9wwOziRt/Vz9gfCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(6512007)(2906002)(31696002)(2616005)(53546011)(4326008)(66476007)(38100700002)(66446008)(6486002)(64756008)(66946007)(6506007)(71200400001)(508600001)(66556008)(5660300002)(86362001)(8936002)(186003)(91956017)(76116006)(83380400001)(54906003)(316002)(31686004)(8676002)(38070700005)(6916009)(122000001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW5GSU04bnhxZGNEdVZmWVhWOFNrdi9UVnJmTDJiZFN1V3FpUmxjbGpEMEh2?=
 =?utf-8?B?UnNmaFdiaENXbzAyR1Jxd3JxcGMyMVhJd0xZRnF6WEY5cnBzV0xPakNCM2dq?=
 =?utf-8?B?aWdjV21XQlVNVU5Cb3FPbkxuZVRLR1U0NnFCRDk0RUxXVlJ0QU9Nd2NISGxX?=
 =?utf-8?B?TTE1VUNydUhWemJhMVdTeFVFZHZOWUZoMzFVaGRPNFJYc0ZLUXdmanRNS0x3?=
 =?utf-8?B?alhQbmpVbG1Tam5OekVXeVlPd1FhdFd6Y0ltajJRS2hIamZoMTNmb0w2MUsy?=
 =?utf-8?B?SFU5dmRZaExRTnhORi9pYzBCbHkyNC9XRDJJdDh4OWtFaHBoeHBJQjBUU1hu?=
 =?utf-8?B?SGptdGM5dE1CVDAwRGpGWnlPSHJ2a2FiVnd2TVdDYTlsbGJyS1cvNWtiUllX?=
 =?utf-8?B?VmlSMi9RTUlpRDRhN0ZRMHR2VjNaa0JiNmlyVERTVDBOV0FMRG11MmQvU2lk?=
 =?utf-8?B?WFIxUGVsQ1A2dW0xV3NtaXpIdFNaTTkvUTRlVEVsemk2bVRUT3QvejdxaW02?=
 =?utf-8?B?SnJac1VrM3VIbE5aWStMa1VRZWRWV2lRWUF4YWJyWENmVllkNzExbGJMUkU4?=
 =?utf-8?B?ZFV6ZWpWS1NHZmI4dDN6bDhuMGk3UWNQVXVlamxFTGVtUHFxdEZ2MjA0dG00?=
 =?utf-8?B?ZTNLejhGd21XdHhtS0FxeVBQcHhoYkw2Rjl1RUg0eEVuODVDNG9qbmJoTWw1?=
 =?utf-8?B?RVVFeG9aV3o5ZTJIRmEzTTlWVzJBVWV0M1VBTHo0VkFtaTRGcEpheDBzUGZC?=
 =?utf-8?B?bTM0dXcxUERmVmQ2MVdYVHZDNTNITGsraXFPUS9WNXNWL1ZWallZcm5lK2w4?=
 =?utf-8?B?cHVNbWgxQU50VHNNTnNINmx0Q0xNM1RFZlV4ZEd6ZkpFV1JNZ3F5c2h1VDRv?=
 =?utf-8?B?bXptRW95UXQ3WEpMajNsYTdTL1FLQUxJTnlTOXR1UEt6RHFuTWlSNVhkOFl6?=
 =?utf-8?B?RndRMGllRlY1dkZ1bFlqMTJ1OFNhM2xnMm9sUzc3NjJBRTdCWnlMSVhadVpO?=
 =?utf-8?B?Z1dsdU5xbFJUR0w0MVgrOXllWmdSKzJ4aU1RdVBqS2VXNk5OL3VucW1IMm9T?=
 =?utf-8?B?bzRhQ3F0TnNXZmE3KzVvTDBoMmN3bnNqNldRSisrcTlwRXQxbkx5M05kc2pT?=
 =?utf-8?B?NUZBRVpiTkd4L3A3cnpmRWQ5Q2JRRWl2U3FRcy8rVkxvSzB4U3BkWFl6WGc3?=
 =?utf-8?B?c3BTODhSVVM5L2RpYi8vYlpUendqVlplK0Y1Mk94MXl5bnRMWHNYLzRMWjlp?=
 =?utf-8?B?TldvREJ4T25nTkdVV2VLMENXNzBKT1JTbUcxbldUdFUxdzlBVGZSb0xSaHll?=
 =?utf-8?B?dUlWMTBoeDNncG1TNEx3WWxvOVYwaU1pNEd2YndYZjNRYWxtanFxamRSVUdp?=
 =?utf-8?B?bU0rdjlDZVRBb1NrbkZ4ek1vbXFkbzU2NWdsOU1KWWx5SjJSS1UwTWFwOTFR?=
 =?utf-8?B?YTMrZmR5ZUJqQ1ZrVWtIUTRmU21HdXBSU0d1cE5Yd1JuNWk4L3YxTDdCVysy?=
 =?utf-8?B?S3FmMzl2S2lzYVNsQzhja2Z4Tm5NUHdlWnBlYzRRM2lvZnRqU2tpTnk1S3lX?=
 =?utf-8?B?dDlvNS9nRXlYcFM3a0R5TEg4VDdNaGowYXBpYU1DR2c4NjhRWTRYUmxCUldv?=
 =?utf-8?B?WmpreW1ldEc4cGI1WXp1eXp6NUZLdXlIY0t0VGRPK2JxUGlpMTdYNlY3ZTQ0?=
 =?utf-8?B?V0ZiQ1BQMjVxTWkvWGZwdG50bnZKSUxUd2o1NUN0NFVEY3dpSGdPcWRvOG5N?=
 =?utf-8?B?dkJZZ0sxUGZ6eXR5dnhNOHNzUDBhSy9FdHVUdTh3YTIvclljSXc2OEpqMmhJ?=
 =?utf-8?B?bG91WVJGdzFnQTBqek5NSjVEVjYrVnpPbVR1ZjRJUko3SUNLVncwU29GK01S?=
 =?utf-8?B?VnBhWUd3Wm9uZHpxWWh6QmhWZnd6bHlQZktqVTRoajQ2TkI5clhBUW9GWG9L?=
 =?utf-8?B?bnBOT2RJK09ycXZoaXR6blJLNXYyTzlZcjFsMGhvZ2NkMTBMUjFVMGUzcWNq?=
 =?utf-8?B?MGZvR1lNd0Vzc2dIT0hYMXFMY2pDNzNzQS8zL2FJMUVnOXNlWGFVRERROHBF?=
 =?utf-8?B?UDhLNG1za1hLYTNTSEtjblBEOEJYcHBlTjFDZTV6Q3dtaEN0azR0WVFOUWVL?=
 =?utf-8?B?NEdHWVg3MDhqdzlDa0Evc3J1YVY1dTNNUGkzaEFZcC9TbmE1b2ZyLzh6eHpQ?=
 =?utf-8?Q?E7TQJ0NfUxz7lNYXz8VlN0dF4Ft1n6pJcf4badguzUHQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9E3566CEA2B38448D85474176677F11@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91488a3d-80dc-4f4d-f7b4-08d9be0730f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:07:14.4129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYq+HXTW1uXSeFNMvGmxQTgkHSOFKk/mDbORTgWGoMLDoh/nxf2y7hZ8LCdyKa9qX8V3p+tsPFhrTV7Dk+0U7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2508
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_230720_469063_B02E3ED4 
X-CRM114-Status: GOOD (  17.49  )
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

U2FnaSwNCg0KT24gMTIvMTIvMjEgMToxOSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPj4+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0
dGFjaG1lbnRzDQo+Pj4NCj4+Pg0KPj4+IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDAzOjIxOjE1
QU0gLTA4MDAsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+Pj4gLcKgwqDCoMKgIGlmICgh
KGN0cmwtPnF1aXJrcyAmIE5WTUVfUVVJUktfU0tJUF9DSURfR0VOKSkNCj4+Pj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBudm1lX3JlcShyZXEpLT5nZW5jdHIrKzsNCj4+Pj4gwqDCoMKgwqDC
oMKgwqAgY21kLT5jb21tb24uY29tbWFuZF9pZCA9IG52bWVfY2lkKHJlcSk7DQo+Pj4+IMKgwqDC
oMKgwqDCoMKgIHRyYWNlX252bWVfc2V0dXBfY21kKHJlcSwgY21kKTsNCj4+Pj4gwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHJldDsNCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252
bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPj4+PiBpbmRleCA5OGQ3NjI3Y2ZkY2Uu
LjJiZTAxOTFlMWExZiAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5o
DQo+Pj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPj4+PiBAQCAtNTExLDYgKzUx
MSw4IEBAIHN0cnVjdCBudm1lX2N0cmxfb3BzIHsNCj4+Pj4NCj4+Pj4gwqDCoCBzdGF0aWMgaW5s
aW5lIHUxNiBudm1lX2NpZChzdHJ1Y3QgcmVxdWVzdCAqcnEpDQo+Pj4+IMKgwqAgew0KPj4+PiAr
wqDCoMKgwqAgaWYgKCEobnZtZV9yZXEocnEpLT5jdHJsLT5xdWlya3MgJiBOVk1FX1FVSVJLX1NL
SVBfQ0lEX0dFTikpDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9yZXEocnEp
LT5nZW5jdHIrKzsNCj4+Pj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG52bWVfY2lkX2luc3RhbGxf
Z2VuY3RyKG52bWVfcmVxKHJxKS0+Z2VuY3RyKSB8IHJxLT50YWc7DQo+Pj4+IMKgwqAgfQ0KPj4+
DQo+Pj4gTm8sIHRoaXMgd2lsbCBpbmNyZW1lbW50IHRoZSBjb3VudGVyIGV2ZXJ5IHRpbWUgc29t
ZW9uZSBxdWVyaWVzIHRoZQ0KPj4+IGNvbW1hbmQgaWQgZm9yIHRoaXMgcmVxdWVzdCwgd2hpY2gg
aGFwcGVucyBpbiBtdWx0aXBsZSBwbGFjZXMuIFRoZQ0KPj4+IGNvdW50ZXIgY2FuJ3QgYmUgbW9k
aWZpZWQgZm9yIHRoZSBsaWZldGltZSBvZiB0aGUgcmVxdWVzdC4NCj4+Pg0KPj4NCj4+IFllcywg
dGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGhlcmUgaXMgdG8gY3JlYXRlIGEgbmV3IHN0dWIgZm9yDQo+
PiBDT05GSUdfTlZNRV9ERUJVR19VU0VfR0VOQ1RSIGFuZCAhQ09ORklHX05WTUVfREVCVUdfVVNF
X0dFTkNUUg0KPj4gY2FzZSBhbmQgbW92ZSB0aGUgcXVpY2sgY2hlY2sgaW4gdGhlcmUsIHdpbGwg
c2VuZCBvdXQgVjIuDQo+IA0KPiBEb24ndCB1bmRlcnN0YW5kIHRoZSBnbG9iYWwgY29uZmlnIG9w
dGlvbiBhdCBhbGwsIGRpc3RyaWJ1dGlvbnMNCj4gd2lsbCBwcm9iYWJseSBlbmFibGUgaXQgYW55
d2F5cyAoYXMgdGhlIGRlZmF1bHQgbmVlZHMgdG8gYmUgc2V0DQo+IHRvIFkgYW55d2F5cykuIEhv
d2V2ZXIsIHRoaXMgc2V0IHdhcyBvYnZpb3VzbHkgbm90IHRlc3RlZCB3aXRoIG52bWUtdGNwDQo+
IGJlY2F1c2UgaXQgYnJlYWtzIGl0IGNvbXBsZXRlbHkuIEFuZCBpdCBpcyBhbHNvIGluIGdlbmVy
YWwgYSBiYWQNCj4gcHJhY3RpY2UgSU1PIHRvIGluY3JlbWVudCB0aGUgZ2VuY3RyIG9uIGV2ZXJ5
IGluc3RhbGwuIEl0IG5lZWRzIHRvDQo+IGJlIGluIGEgZGlmZmVyZW50IGhlbHBlci4NCj4gDQo+
IFBsZWFzZSBtYWtlIHN1cmUgdG8gdGVzdCBudm1lLXRjcCBvbiB5b3VyIHYyLg0KDQpZZXMgdGhl
IG52bWVfY2lkKCkgY2hhbmVnZSBpcyB3cm9uZywgbGV0IG1lIHNlbmQgYSBWMiB0ZXN0ZWQgb24g
dGhlDQp0Y3AgYW5kIGNvcnJlY3QgbWVudGlvbmVkIGhlbHBlci4NCg0KLWNrDQoNCg==

