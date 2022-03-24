Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18B7C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFa3UYUERa19b1nUJuFF0NzX5jcskBndMPG6dwd7bx4=; b=w4rCwMtDH6oVniv6/g8L724Dhf
	97+Mxf5ZqQaTlozpW81ZdwzM4oIkykb9Jdo66SNE7ba4eTRnEcu7xleO7K56bdRsdkOE8sXwRMY5K
	DHmgO87wExYhjAXv6GArcvo70dbYnkFs98jw8YmhCxrGFugY5OgzUhS4KUm7LBgST8wI2Ph/N9Da1
	mdLcV5A3ULCAmvG3CCTSK+Brql3NGKTLSpLKo9rzhqWOh1sxg40vSUMJjB9whS035epv7FdMU+1QP
	gT97RKMoFJTuoThpgUoREAyi210YJYtXysCT1sbUgxaZgWrIN0K1UtYW4U1jgrZ6UXDEjULZMpOqm
	f5owZKVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXPup-00H7Z5-9S; Thu, 24 Mar 2022 16:02:23 +0000
Received: from mail-bn8nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::619]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXPuk-00H7X1-Mw
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 16:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ppe16ofBUnbwh4+D8h7BiqmOpVjP60VFWFThABbMMwRzliTplI/Dw+lgTbOP8gUFi5igSac++PBYdNoUatWzyhJdKTO8kH6APtthVWjIbmfsY50mr1VWzyPpj2FFfCXpnqyeeKKojET73W0Y18pMmDXhqtJ3eIGD2Eprw1apUNPGEvb8AiFBNGFcGuuy8c2NKMek1U29KClewxL1hkX0j+iuirUhDW8y24lMu4fA1Us7VNzm1/rFfxyp6I76OL3lBbWxUHeW54J8q+zlCe2fZpqNWQdHJrBWuDqJ21K34l70zKCWgUv2pS7Gz2LzA3U+TLN5PKFwu7RJQHSpZbE2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFa3UYUERa19b1nUJuFF0NzX5jcskBndMPG6dwd7bx4=;
 b=CYMLuBq8P1fMccQdhDaish8HOX6BJ/VlYDeNl+oE52ziOLdBFE2gvlYc2o4uSMeDsaZBexLAaVEev75IZr1gweS4edlt6qUu7+yTdVfpQsrrpih3ULuM5533d2CiUrmtQXIDxaPR6lngCkfM5YXuNUt0PQz8dWQ4PHs6D2t242UvyQmCKm7akRscVx4xMnhpZihkPA8bs0ZEv0qP2dYRs6EsWFH4e31HPs5t54+IaUFJQVLb222RuNiQeKJmnV3L4uO/QG6LP7vgj5RWX0qeUtcUZbKurBWnWu+me02EfsTcaV5XMIAsPd6YUZpdGG8je/Y3P53u9Dcldtt3B+sOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFa3UYUERa19b1nUJuFF0NzX5jcskBndMPG6dwd7bx4=;
 b=EkK+TDY7UTZ3tMBTuIqWVIJblmxsxqyF79c+3PVgIZlc1hSYtSGkaly4ZNyn9UnZ/VoA+SHscvMQuPgJYJ9X3s7bi84/ZM9Mb2pGb5oGReTZQujT3N632XxJMED9QCODGvYniWYVQ9HAHDqb/oXewssyssMcmHyuKZQHXLnIkE8cynXtmDhjcIIGwRMtwdAE31hgsapgmWm+7pYOqMM/pR53kNuk2ANGQ1aelN3P8qdG2k+7klRHTMOAiLwoz7teohuYivV8Ws2S61qqWr5mN/ahxQU20OnYSwZtpK6xWEVddExzN1q5JS/XpPnLpEifIbTYRVbs/BytXqnt/Oz4CA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 24 Mar
 2022 15:46:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 15:46:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] Revert "nvme-multipath: fix hang when disk goes live over
 reconnect"
Thread-Topic: [PATCH] Revert "nvme-multipath: fix hang when disk goes live
 over reconnect"
Thread-Index: AQHYPxMGovbrWCUKxkOcEQ5HOWtqQKzOWL+AgABV0QA=
Date: Thu, 24 Mar 2022 15:46:43 +0000
Message-ID: <6ad3113d-a1a8-9ee4-bb7a-9a61639fb691@nvidia.com>
References: <20220324000620.4127-1-kch@nvidia.com>
 <a51dcb74-9664-41a6-7a05-1aee2ba0572a@grimberg.me>
In-Reply-To: <a51dcb74-9664-41a6-7a05-1aee2ba0572a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6add8faf-ff2a-4cfc-d92f-08da0dad7ea7
x-ms-traffictypediagnostic: MW5PR12MB5681:EE_
x-microsoft-antispam-prvs: <MW5PR12MB5681ACCAE10B3D647A9A5EFCA3199@MW5PR12MB5681.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nrd2QpKUfK/1ENeIZLOVBhNtrkteGV+O2WfJC5fdtBMDox9CZbSwJ3US67DrFIEpZLZRjSPaAeRb9qVROeDKVdq3UN326cl+UPBmnFpkEdPxn7hNT9QXJUsAtnk00a2sc1+Ay7YDGbAjRjr4NaJlklLJfidlY1zKXkojmxHtagZvuG3ctqYg199GBCwCD0Up/pWHQ6j9DDDOooKEBtgXSM/DKoK/AMlTEewMap2VizqHmkZLxhAoRrQ5Bh0zVkTcq5kGsVEa5SaozxRQLxZfO5FMljz5lL+KLI7zcKduF+ULiMyldmZGvv34ZDkKnw4vXhqqdixMiGEzTulU4XbnEqzXzYO4GPFRxsC4cqEQY/mAgLpkww/PmgMmZoK1d/WJ+CGMcTf3t+tmleIkr7agsZ3E/DO2FkRASCk1UhqqeuVACCkSmFo5u5d2MCiQOWGZi66SSm0LDWMcKGyXRU9t9+N9w0yjbsao5MGziE/XQATRUaEqLbrwUXbxGO8C6msMtB4EgtBb8RjJrZuqOb1XFx4Ovt8cdBOwBRr0lVF2+TnzYmtuf9R3JKJuBbZqhzFJTBty/qUEHzLWvV1ABtFVIBRhY3GBECb63mdqC0cOUGW7XQbFnzf9Tfs1aYOh6VdUqy6Z7xS/Tx4wLOSu/PU3x4Iab14tomJtMgoIR3DlVrL1p8zUL7b4FWzcwgGieoFLBloRpPRRz+ScHTNqmlFYfNI8Txs3enC7iFcCJw/argkVFKSTz0wvioQrSDk+uAv2YQwbHq573ioU3m7CPV78uA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(38100700002)(38070700005)(122000001)(86362001)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(36756003)(8676002)(5660300002)(4326008)(6916009)(54906003)(31686004)(4744005)(8936002)(2906002)(316002)(53546011)(6506007)(6512007)(107886003)(186003)(2616005)(508600001)(6486002)(71200400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2x2UktnVzE2Wm11MG9FSjNSNys0TXBPZlF6QUhMcEFSaHZPWkpuS1FNUGE3?=
 =?utf-8?B?dU9QSlRCR0s3OUtrVkpxZVZPV3J3elU4dStndVJ2NWUzSDFuNTdmTTBadEhC?=
 =?utf-8?B?UXZrK3FOVVhMVit0UjVuL2Q4TzU5bmZaUDNDVm5YM1I5Nms4YnRhd0oxVi9C?=
 =?utf-8?B?aVVTblJOTlNJRzJpV1ZXa1dtbEluOVZhZ0c5N3labWNFeHpoeldxcEk3NHNN?=
 =?utf-8?B?OXp0b1hNRUpqa1p2VzAxR0szbGZrbC9YMStMUzJLaUlJMWltZjZPRm85M0I3?=
 =?utf-8?B?RUd4SXBBamdBSFhERG1hL1JmRWFGMlBwelNkWjJQZ0NLZzZSSWxRenRla29T?=
 =?utf-8?B?anl2RzdFRlEwVWFNUHBxM2xuQVZxNXM3ZWNWT2lVb1ZMTWZMK2E2MFp6N1pR?=
 =?utf-8?B?cWlBMUpTSzlERGY0TzZEOS9WUXBDOS9NWUpFTUh0SmJSN0oza1VDSVUreUl4?=
 =?utf-8?B?aW52enUxVWVXYmp6cXJNc1lZTnlvUjAvTlRpb0l6ZE9GVlBqbkNyd1VUY055?=
 =?utf-8?B?eHpoaGFhdmFGb3A4OUZ3UXQ4Rm8zUDNOZkVGOWFNSUh6WGM0VU9ya2FPZ0U3?=
 =?utf-8?B?WlMvSTM2VDVmMmx0SVMyYlJrdEVaek1iVlFEcUJUeWE1Z2JORTJNSWNudzhv?=
 =?utf-8?B?MTNVRUZ4RVloNExIcjdhNGIxd01lSU56SVphbm5qRWs5eFRqc09GWlErRjh4?=
 =?utf-8?B?QlVuNnF2aVZKMnNKRnlzaFNYVkgrL1p4a2lSUmhwS3dNdjJKM2ZmMUdXWXh4?=
 =?utf-8?B?VTVvMVVwUitseTVUM3VQWllWbllhaG54UFB4Sm9NcWZXWnZXNHRyaWtza25j?=
 =?utf-8?B?WnJZcENYVjhCR0YvVnl6bmhuMVNSMGxmNjB6TnFQNW9MR1F0MW42OXJtRjlW?=
 =?utf-8?B?MUFuQUVwcWtQTnV2Z2ZsK2FCTTlJNGhlaG0rc0lvQVo2dDNXVEJUdXNhdGIx?=
 =?utf-8?B?a05RV3AzYTVoZVdDemRaTzNieFBRWUpiNitTR3BnSHI4M0I5c0UyMzc3L0hW?=
 =?utf-8?B?K2luaWlENytzdjBzL1dwWVFPYklnSmlaMUY2OHpJNG50empldkJodmFqeEh3?=
 =?utf-8?B?QVlxODF1eTF5UVBrTFBVdXd0U2FoSWdyZ2UySjVZaldlKytUczZ5RDFlaU5B?=
 =?utf-8?B?UXJ0NERLWEZ3ekZ3MnZ0RjRKeGJXSUZZQkR0WDZQQ043NWF4K1ZLUDVieHhk?=
 =?utf-8?B?R2hKU25PWkpFOU0wUys1cUpKcmg0dUFoWXFuSE5mRVZ4Wk1Pa2xKVkxuTENi?=
 =?utf-8?B?d1ZIVFp5emFXRXhmakpRUC9ZRHVDS3NObzd1UDEzajZkQU1vYnVPUFRxbkVQ?=
 =?utf-8?B?dFkrd3JFVWFtUVQyOWN6YlBZWkt3aE9jSmhUam9FUlRBMVZ5Ynp0S2h5Q0ZY?=
 =?utf-8?B?S3lOejJCNm83TnFXVElzTnBYM1o1MVM1SVByL1E2RldZOEZHcS9lYlVsZGdt?=
 =?utf-8?B?bkxKVnJ2Q042V09pS2pmTFh5T1k4NklHaWRxYmNJdGI5c2dKVVdrczZmcWlF?=
 =?utf-8?B?R3dCdzJGZ20wODFQdXhmdW5TWCtkK1hseVF0UXhFRVVOSGR6NHBOYVhPTFZa?=
 =?utf-8?B?RzFMNFEvOFlPV3VKSkNNUW1kR21ieVVsUFluQkJ5LzdxMys2VmIvcitiZHgr?=
 =?utf-8?B?S1BZM3pTMkY0SUFkWFhpN3BlalBJVms5YWR2Q0FqZ0N5UWJFQ3dsYXdPSHFB?=
 =?utf-8?B?VS8xRDUrbXZMcVg1NXV4dWJxRmphNEdyd0ZsZDdBN2t2bVFxVHpqYzF5eU1Y?=
 =?utf-8?B?NkpCSTkvVlZOdXRlamhWWVF3MnovZ2pUNSs1dXpJQmk3MFAxZWdvRTRmdVd3?=
 =?utf-8?B?SU5GRm5zUThCWHBmRFNlc2pWSE9BdUlqV1hOTWpaSHYxY0dTM0V4OEJKTkp0?=
 =?utf-8?B?L2NEQk55R1U2bUtsRWJGWDhaekJJOUpxcFdyb3Nray9kSkR0a3VkR2x4YUsz?=
 =?utf-8?B?QWpZMm8reHNpUWVMK3BoS1VLa1dMOEcxWGRBeVBOMHBpamhmMm9sZGlZK2xz?=
 =?utf-8?B?blg3OUZYS21sVzhQUUQzV0NtOEJqU2Zzb2VTZzdGTzI3TkV3WWZzekFoSzI3?=
 =?utf-8?B?R0xvdG12ZUpkaUFlSGJzdXc4RS85cGZNK21RNUQ2WWdyNERwNjl4aUY0bGZs?=
 =?utf-8?B?VmhzNWtLalhobTVTc3FoRlVLSlJoK055TzVqUDBvenhNeTJORmhMZjZ5MEwz?=
 =?utf-8?B?QjdlTjU1L010NnBuclpGRFZvZmc0V2Zqd1NaVkJ3elI1eEtaU0Y5dTFyYk0x?=
 =?utf-8?B?WC9iams0K09DelFIS0xYU3lJQkJVY20wOEVBTVN0ZDFzSVRsRFVEVDlKTGI3?=
 =?utf-8?B?cjJEUXhGSGFwdDVTWDVaQ2dzdnFlU2Z4cjYvZDFsY2dwQU1wM3JZcTNDV2Yr?=
 =?utf-8?Q?3Q55rCbI1zcW3SAQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0D14DB08D0E2B4BBC53978392ACC3EE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6add8faf-ff2a-4cfc-d92f-08da0dad7ea7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 15:46:43.0841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yLVV6+8Gt6zyotAqRyt4b7UvKdRTf5GLwGWC9IVzYxTkUsRcn/ZmD2PlX91ejN8HlTJwQZByjN84EJ6qZhEGHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_090218_791986_2CC96A5F 
X-CRM114-Status: GOOD (  11.99  )
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

T24gMy8yNC8yMiAwMzozOSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gDQo+PiBUaGlzIHJldmVy
dHMgY29tbWl0IGQ1MGM5OTJlZGYxMGI5NWQyMDM0MDk3NDA1Yzk0ZmVjZmJlMWVmN2Ygd2hpY2gg
aXMNCj4+IGNhdXNpbmcgZm9sbG93aW5nIE9PUHM6DQo+IA0KPiBIZXkgQ2hhaXRhbnlhLCBjYW4g
eW91IHBsZWFzZSBlbGFib3JhdGUgb24gdGhlIHNjZW5hcmlvIHRoYXQgdHJpZ2dlcmVkDQo+IHRo
aXM/DQo+IA0KPiBUaGFua3MuDQo+IA0KDQpJIHB1bGxlZCB0aGUgY2hhbmdlcywgYnVpbGQgdGhl
IGtlcm5lbCBhbmQgaXQgcHJvZHVjZWQgT09Qcy4NCg0KQnkgbG9va2luZyBhdCB0aGUgZ2l0IGxv
ZyBJIHJldmVydGVkIHRoZSBjb21taXQgYW5kIEkgd2FzIGFibGUNCnRvIGJvb3QgYWdhaW4uDQoN
Ci1jaw0KDQoNCg==

