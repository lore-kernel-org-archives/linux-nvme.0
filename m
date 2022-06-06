Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35797C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V5TPK3w/MVZwPpEx/Z32A55VXeC78767BwtdwXfFS5A=; b=ntzyeV89yLz9DJ0kv6iAChgxaH
	wLKhEWz3rboM9VfLyEhOt7eSXcNS/yKiGkhAiXaY3K1gwwQE0m+hRwdgk7LFJjkJ911R6lgoAZDMt
	3a7hQ9Zxc9TBFsIeWaKIi4Hlb7gH09M61Fa7X35CxNItlDiTR77bG3MFBLytv69bSW/HR2tELqY+U
	aadH9wFjEOsnZiHIUoYTt/d5O+msSQgsDm+VFg94WqiM7Jqq0gbIeEVcOYcFyHaKySFKtAwtAEwyL
	BQA1O4jwC6Aoap3ixKIgyaejtI31a27/ijPTa6rMjUivmsP74xk9nXLSbkwQpnd220HugKmtE7HPY
	sR/VnRsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyGKO-002BIQ-Gf; Mon, 06 Jun 2022 17:15:44 +0000
Received: from mail-dm3nam02on20630.outbound.protection.outlook.com ([2a01:111:f400:7e83::630] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyGKL-002BHe-Rs
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 17:15:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrNnajLl+dVdRT0ws94tWVUBJCQyrhLhWRz+OJV3QRZJa6r1RqvUKYpPAiMr6se1D4yoNkauTxX+oIRhRXJEwemxEn7LQrsUCEqlqBrC3BuXEfYLYXyGMCm5fjFxMBpyIh5qmI2fUI6UbNAfLyqK40dPZY4b0SIUzoN3bYKO/SlRbJZqZ+T6b0BD+MS9uMEcKH1RUbcpas78S8FRmzikyvwAhxvd6b8vS+/jfx+4TVbBSKZxG5YTIKXVYHwpTmS6JhbcnSl0QJkYygbkWJedKAHNdYCzomoZtC+vOrONax8PXCCiBueHiRSFM4x4CaevGjS0GrUFoht3/iGYQ3etDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5TPK3w/MVZwPpEx/Z32A55VXeC78767BwtdwXfFS5A=;
 b=UoGbUxP6yZIa50HApXaRs0mtAue19xxRLC+BsHWNS3JNzdHD+loD0n/G4SpP1Jo3NkucYjaoi6Awh2TWaSEnw7oOelHmMvRJsfVyiESn8L0v+bGZuiMhf4h6476o3uaIXTomXBywJCyZAMpOXNw3ot6UVDEnSd10+mTYeetkR1ML5OZzkb15sXKYTQiJkfOqIoKIfYGBJwh7HucNKLLQaPec2ZjN2ZHcmtQeYNlCnHGusxTe2Xlnw4dG5lHmexltxHoXbNekl+KuYSi2R2WzfTLMDkpjuoZwnK3QQp0m6BYaDqKJgrw6x5InJ2XB8jZNe9RRUdhJTJ9IUjdlEFMfAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5TPK3w/MVZwPpEx/Z32A55VXeC78767BwtdwXfFS5A=;
 b=OMockPYQcvAGfXS2+UnZyJ8hssFhZyOjVSCq6YQE/X7E5DKmKIu0JqETkra0JnscG0PoRWBuNkmOeFQlXWUvat5TZ/sgp2oGDyeW2IcnFlQvEre33b+R2VIJKkZgLV5fd9vMDIp9ysFqdMi8NvtMnM0yu1wuZRObAerDr381fBWINTAxPJwDcA8IuYSoV2nbqDgOHsD0YdUEoX7bQ8uOIQSI7yubM4eus+m/vh2tXO9CdK8KGoUZ3JP/fHn+8OjGiawuQhVJUANFGXidT+FYWND+gW4zbGpGA8ZAdsuuSzaOjYQ9rpBJGFljy2FEf4t+XjRWA9fzXPq3xsU2dYt5Zw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Mon, 6 Jun 2022 17:15:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 17:15:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: add bug report info for global duplicate id
Thread-Topic: [PATCH] nvme: add bug report info for global duplicate id
Thread-Index: AQHYecSgvaFH4jO16UybrK5y3Ca35q1CnokA
Date: Mon, 6 Jun 2022 17:15:37 +0000
Message-ID: <2c9ad36e-aab5-526c-396d-7818838a82ed@nvidia.com>
References: <20220606164047.2549647-1-kbusch@fb.com>
In-Reply-To: <20220606164047.2549647-1-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddca9ef6-b51f-428e-ae8b-08da47e02c75
x-ms-traffictypediagnostic: DM5PR12MB1513:EE_
x-microsoft-antispam-prvs:  <DM5PR12MB151383087BE6C5C834E779BAA3A29@DM5PR12MB1513.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5dHZfgJcWoWsbrHRQ3886hYD+MAfTFRcwtkpd2xcceeGKeM8eTyR/7GuWRljgee+DuPJelWlN1Ewm1XFbOJJBTVFoo6hM6JVOGATWI+RX//qgt9nPdSGUb4SErXoc16vXO7Wu6LwW/7oVUmfQIMcJBxsr3dveGM/Lr9L1QxKotOn8sz7tskDsHqm94eBJ4N4izSybsFDOhOSxHp8MrsSbizprYWNzVds71QN6jmiF5VN6RQzKUC5aqev7REOAk9UEsG0ya2GOZuaWAwVbUg3SLe5aBXrqYP/g4rM9zhPuXw+e7dWakDfYjMv8xAs1N6X6Y8Tbc/ZByePDPgLLbPxxMasHw2AebVX2MRYi0UC/aux29S89VRFAwyegTvCo51b7vdgUDZrW7I5QS98seEF1YqXtb8aHKLxl9Xp6wkEyPRr16+U9m7nxyZDc5YZz9CzxRMAKY1Am4Oq0qT5CaHxw5oA5vu9UzGHdv04yO7i/W0wfFxmuQc0AT2ZDSH8prHTkpe/IhL9/FBvwPe+S02MB85V9IaTdeRgGiprX49MtOIfspYkXkz06V2b6EbppNQLuaP3C1/Vj9NBE1rvPvZRMG+3mu1Y2szBLwJGFqxR0gR3ghwNjoR+EfXotdT2EX2AwKLvWksjcOs9b6bX0Z4ihHJuJa0ZKVESoFjcJNYeU7KwCR31TzNbfD7OovVP0Yw7fR2cNiCDOhu2AuzQ5gf0s5UZu478HNkSDsvcyXA9hItrxsWIvaiu3c6HS+I4UfJUv8sI29EXbx+CQ0llSpdu/A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(316002)(110136005)(6506007)(186003)(71200400001)(6486002)(2906002)(508600001)(54906003)(38100700002)(38070700005)(2616005)(122000001)(66946007)(66556008)(64756008)(66476007)(66446008)(36756003)(31686004)(4326008)(8676002)(76116006)(53546011)(91956017)(5660300002)(6512007)(86362001)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bVJOMGg5VXBOZEF3UDNIaTluTWJHQ0hLVjNucmJrSzJXK0xRalFNb1ViaGx5?=
 =?utf-8?B?Z3ZkbitRQVltOE44MUFna1l2RkZoam1ONzhOLzQxSmFaVDJYRFo1eVROUFZU?=
 =?utf-8?B?NUdYL1lpTDM4V0tHc3hheDcxeVY5cXJsTVQzL0ZWN1hhMzhGUVNOVjhPcTAz?=
 =?utf-8?B?djhuQmVJK21wUTVTK1hWbTVpdkcxeXhjNkJpTTJBaW1GcXVaQU4wMFNqYThi?=
 =?utf-8?B?K3paUU9GYmpqV1BsNEVPK3VkNHY2aFJ6c2llcm5zUTkyampKTzExcjRZeDYz?=
 =?utf-8?B?UXpieW9KQlZBZnlvcnNabElUeGJUcWV3SHgvWGRFRWk2Y2R2d01lcUsrOVhC?=
 =?utf-8?B?bVQ5SFRNKzd5MFFvdlJCYVdoUGJVdkRyeHYzOVFXc3VqRGRsdUZWQWdVM3hD?=
 =?utf-8?B?SWJkSm9UN3lqcUQ4bGFGTU5UZEFaMWp1MUREZVZCNS9BVlgvUERuRjFyTWdF?=
 =?utf-8?B?SkpWcFNrbXVhRXJaUGhESFFBOXdGdk5HSVNtdXlwUE9TbHhjQnRWcCt5VC8w?=
 =?utf-8?B?ekFrckVuYWNIbU85QitYZHRqMjVGU3dsM0p4VU5EN2lPNVhiS2tla3hqMjgw?=
 =?utf-8?B?YXhQNWpkNHdJWHlXQm14bWxIYWFORG0zQ1VPSjFlK0xQdmgvcEVIQVhQdmdq?=
 =?utf-8?B?U210RSsyWERwSjMxcjFXVWd6OU81eXg4eFpucHZrcUpLZm5wQm0xVlF6RTVC?=
 =?utf-8?B?N3pBMEhkYVpkaUZUVFBEMmczVDdXTDNQK2tNUTJtOWdYWTVpR3FHVkppdlJF?=
 =?utf-8?B?eVg0SzBqOGh5TjRTZXp2Z2JNZ2Fib1FGa1JQVS81VDFtYmdWbGNoK2VmUnF4?=
 =?utf-8?B?bWRQanpTMS9NRkdZY0h4YVMyaXJ4VUV0aW1wQ2lNckJNU2dCK3pPYzVWNUtj?=
 =?utf-8?B?Qi9nUkphVFNMTzgwSDFaM2t4bnhCbEJXZHVjQXN3enYyNWFNRCtFYVdWTHpZ?=
 =?utf-8?B?M2doUTBPMElsMm5yeDRwcHcwV0lOaC9RSS92ZVQrbUVLYzZjcDlHTE1mZlVQ?=
 =?utf-8?B?OHFrdThYVzJ0akZKZFFuNEsvdnMzNWtuVVJ4QVY1WTZ6UVY0SVovZk5XbCsx?=
 =?utf-8?B?czZCTlVmYlVxZGpYc3pscTJWWjdaTEIyTzE0Z1ZNcXpHR1hzaFd5OVdyT0JU?=
 =?utf-8?B?NG9pR3AyZ05qb3laaUFKUWNMWlNYR0pmNk1ocnRQaHpYOUhiL1M0K2h2TUxs?=
 =?utf-8?B?S0g0Q2UvWDNnOCtDSUJXbEZaSUxzQ2x4aUJaaVIwTzNRZzVTLzV3M1Z6V3Z6?=
 =?utf-8?B?bXJUYlNFZHd3RDhzaTNNQW5CUG5zWkg5K3U0QVNVdXJCb3pZQzdrRjhBZ0Rh?=
 =?utf-8?B?eHg3LzA2cFo4cjlBWVJIMEtwendIM2pXOUswOGF1UmJSdEFSWVdybURHby9E?=
 =?utf-8?B?M1NVR0QyTnk1WWRJYVExOHRYSUp5WmdCYnlUTVJWZXpwQ3AwU0orMkpxbnli?=
 =?utf-8?B?MVJWUlJvNFZPc3ZqYUJCVW1UMzJhVEZTMG5tbmthSEtHRGgwNERDQUQ4VFdl?=
 =?utf-8?B?dUgxc0plYlZwaDc1WlRQejBXUjA4M3lZTDlsRzNtZFE2Q0pLWGxvWkNXUWZo?=
 =?utf-8?B?bWZ4elR0cHBpdWN6L0E4Z2JzKys5ZlpKdUxXdHg4ZVE2VDVqWjZpM1pOL2hy?=
 =?utf-8?B?a0loNnNZWWhqZ1BLVkRnZmhsK2c1VzJtN0lQL2FxYlFmWEJhZnpGNTdRNFJC?=
 =?utf-8?B?YVkvMmx5T3p2Y0o1VlhIaUU0a3dNd2wwWU95K3pCUXE3cW8xSUYydjNuSjA0?=
 =?utf-8?B?YlozMnRtN2x6Y0o4L1BFTGtFRVlNMnNQUVgveUw3TDZyU1R2VDlNUlJuMVFj?=
 =?utf-8?B?YUI5YXRic3ZSTGJ3ZjF2U01lSnFPN1pFenQvc01KMGE4U0lUOURIOWI4LzE2?=
 =?utf-8?B?U2c5M0lPS2w0MUdHdTBZa0R3WnBLWDFkWWF6c0xzdThDSVhXeC93NHNPNzRj?=
 =?utf-8?B?ZkwrMmRpbGtnR3EwQWs4S3BjcHRFOE8rTzBtZU9pU2hkWjdZU2VFdUpCdWQ0?=
 =?utf-8?B?Sk1PYUlENGlRNWt2NmtON3R1dEtndU5tSnNuMCtBRnBXVG11K3BzUHBTVkdL?=
 =?utf-8?B?MVNldXRxNmlkY2pyRlhKdWZBQTRiUDJUUCtLK0tWOGdpNE5uRk9VY1cyMFRz?=
 =?utf-8?B?V1ZNbzRTV3ZFRHM1ZTRqVTlUM2J3aWdySjdNa0JzNFFtZzNIUHZnbC9WTFpa?=
 =?utf-8?B?alZFSWJyc0FSWjcxVW5RcDA3K3ptRjZURDllTzcydXZpbkg5dmw0Z1VmQVNK?=
 =?utf-8?B?SnZldWJuMSt2bGZHRHF4Tk1hNlBzMjZMdGZpRHNaa2dOeTQ3aytZMHdaV2hv?=
 =?utf-8?B?V2pEM1RoR2tEOXJNc2VUVHJFYXBKMS9KeEYvMTVTaUZqa2RFN3U2dHVaUU11?=
 =?utf-8?Q?gn3ZoDrC1eRGLYYQHBKnctHinG2jBZC4vXg3VcIYvHUwn?=
x-ms-exchange-antispam-messagedata-1: 0wxIxAarm8reYw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <712ABE238BD01F42860E20405A4FAFB6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddca9ef6-b51f-428e-ae8b-08da47e02c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 17:15:37.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8/2r6kCw93bXEnDjB6Sg+rphlBeV5M4t9tKYr9SQaW9wo2S0NkoSiDviALgfmd3CfDpRH9ycwUNGoChZed8Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_101541_940467_AA9E46C3 
X-CRM114-Status: UNSURE (   8.78  )
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

T24gNi82LzIyIDA5OjQwLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gVGhlIHJlY2VudCBnbG9iYWwgaWQgY2hlY2sgaXMg
ZmluZGluZyBwb29ybHkgaW1wbGVtZW50ZWQgZGV2aWNlcyBpbiB0aGUNCj4gd2lsZC4gSW5jbHVk
ZSByZWxhdmFudCBkZXZpY2UgaW5mb3JtYXRpb24gaW4gdGhlIG91dHB1dCB0byBoZWxwIHF1aWNr
ZW4NCj4gYW4gYXBwcm9wcmlhdGUgcXVpcmsgcGF0Y2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBL
ZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

