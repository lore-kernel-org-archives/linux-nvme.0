Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C787C77B78
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 05:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CdUnU2iHABKAYTxFhZ0rG1Tv1DTnnD1Anx5uyut5m0o=; b=2qBE06gCgIM4p/MPxCJN6reZnQ
	6dzwPmuW8LCdxarB+zzpiWMby//SuSrR/M3Y+SrWD/q8Cuye0nJdQxJTBoAyiUlDHR4poV04A+3Sx
	deqKxjq9SXdXS1mwpPowG5F01WYpEEzcSUiXFoPdYT1THG8rsAAyOumYTXJGDtYeD33QUkWcMoCt6
	KVW/cgqpchUJDh+0WIgNx2LZszUPgIZ1zlH4x2Qj1ZSQ0Blcpg5kLwymt9n/h05zopMXV6xq7rfCQ
	E4XcEMnKH2DCe8ZMhs2eD6TA/QZV49RHaH2kh7UOCfGgdjMtn1mECujx9uUe7Q2XVINB2y+D87CmP
	n8mWUntw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prXXW-002ocU-25;
	Wed, 26 Apr 2023 05:18:02 +0000
Received: from mail-mw2nam10on20628.outbound.protection.outlook.com ([2a01:111:f400:7e89::628] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prXXT-002obe-0t
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 05:18:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+hrcOJSFp+UNqg9b6u3jOZWdcSLAOaHC2VEHUtN0BHAEks/WxWO2x719PthBlY15BQuYn7WQ4Nf2CEd0dpEop4YVNvr1SIGgqqH038Dnf3ueg5xd5yJfVf2KXCR4EJm0FKYxD6d9QnqUeXx3QvtQyvfFN0+H+M7zVu6fF/y81x3wiOmzn3/TVWWDC4Xh8Yxhw5Mc/vvRN1klq0uAuyE+2ofngkQW27G0iE1+nR3aBcNXXlYW7IbxNXT4Zt+bQeMamvEZo8kxkReuCEQ5agaGRa1HasILOKLfVenIApaD1ofXxgTXMPm6uDC8TUpNM9eqASJ4RPnw0eUKJdqmurmQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdUnU2iHABKAYTxFhZ0rG1Tv1DTnnD1Anx5uyut5m0o=;
 b=Odu64I1tXPG2Z05yvx18Km+utEG8s8CHOqKf20O4+SCR/ltXC5hOh9WGxVXBOjGjTN2RkcOQ62e96+FT64tixZ23AjVfMBFjwdUNEvNLD2mlxbnNp/aWA84a8v6NbrXsru6eJua0I9BbLnoqzvps9iEV42WmoE5W/u4ccr84U8zhqLQdxoCJQOXnO3bGHs3V5JuGP2IWbA0eV6EnqIFkg5yFO4oLGGQKmilVhsGq2r8ZbkDu5BvB4o+zhtETHNVMsNk1copKYVfOryk6QDWpafJ2OHpn+iacwS+7OZqPxD/KIZRsCF0loB5Q4QQUtXF6gx2JPQXwLTgS3v0LXqOg2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdUnU2iHABKAYTxFhZ0rG1Tv1DTnnD1Anx5uyut5m0o=;
 b=mWkwBn1SrIdvn6ezysCfc0biuL2432QgDonmYTHUTTg7o4kre7pPcROAt95Knx5SZkOKGpmyPWAvflM28V9Q0rXQojFMQND0gyT5iv768u8AudzKVENc3ZdynQqaM1VqYm86IUlm5mUSTMPgbs2VbDvkawbvwkmL04YCqvsN66r8WgfWLFP3hkfBuWMUgGSYi3ffTX207DedGatZ5JCW/feR4r/bq4kKKLhoL9HiLsPs5NJvfrg8PeeWVUuIgoMQU1kf1HUX0JStrBLxEKNaL2FiysV7M63BaLIqBQ9LaTle6BC+b56YqxuYgz9zEpG16hrkavzFFgcR5ipLMKUxTA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 05:17:51 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 05:17:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Wang Yicheng <wangyicheng1209@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: Seeking for help with NVMe arbitration questions
Thread-Topic: Seeking for help with NVMe arbitration questions
Thread-Index: AQHZd9X1pMP1HYrGYUSlKNn57BC1Va89DTaA
Date: Wed, 26 Apr 2023 05:17:50 +0000
Message-ID: <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com>
References:  <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
In-Reply-To:  <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB9042:EE_
x-ms-office365-filtering-correlation-id: 7b465da7-f9ec-4e83-7909-08db46159480
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ypKmQ81VJoxQr8XLE97Dczc4yHAErUYdn7WCQS++M1fJehurWFB5Lmhuy9pZBLZm+CmZOD5W7dwRvQHz29zYgxfNx91cHn9wC1ziC3YvGvv74W5FSJK34lutv8osCt2yVlgKFBy7IVNMNe/atoqTTxJt8nYdbgbD9AFfcsYgHO0p2cx9z9U8kSDgzOgGjN882LRDi6YNuYOqjXhOPlrRP6k09L1SUJs7t8CAHwtwZ7glXJZOdHbc2zE7t2gnHOhC+D8YbPpmvZsz+GQb7ngizrzH1ttdMbmoGb96xp8GZxoJpfgXmqTpZCILaCz3dVvfM7Op2q3MLLSfmpXeihGPN8gNDnr4dL8awdHsVNXmAPX5Miq/g+jeSEx1jya1LhUhmB7/BAuRE8w0iUgF4QJh9gIZ/VaHV0RK5xPArDNQbuXpFp8JdWcii5jbT/9arfOzO22pc51sNSVYv5vXuCsKJxlsiAt2JVZN97sF0hq3DfFEitQ58zCLFRa7kp8atOfmf66EdWtcB1Jt3Gch5oM8mLFWOXwxmW2X3iBVObxT6GBT1dZz55yFO6SYdZiVry6ydlwf0+p42AUgdh9ddH3NCqZedOYjPk57x4kjSrjdAuv3Ku0oAw3p6bRHLbIqEFdqG/wgGmC2Eq96NM/wF1IBERKBkGaNgX+zsApS2lzvvkRbwkojImQMqGSPDTWWD/rAJjKvvKl8kkxtvOnLun46XQ/pVn8nmEq7Vx8PslNOB3s=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(2616005)(83380400001)(478600001)(31696002)(6486002)(71200400001)(6512007)(6506007)(966005)(91956017)(64756008)(66446008)(66556008)(41300700001)(110136005)(316002)(66476007)(186003)(31686004)(76116006)(66946007)(5660300002)(8936002)(2906002)(4744005)(38070700005)(38100700002)(122000001)(86362001)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RDlUTXN6c3hTQlA1Wkt3L1ppWjRtek9VNjVFdWk5K0VjVUVreW80WHJJN1k5?=
 =?utf-8?B?YnZqRS9QQmhQZnVnRjVtWHUvcnB0ekpsbVRLdkprb1lQRnlvUUdGWEZ5UXVw?=
 =?utf-8?B?SnZzdVJPdUt2WHNSdk1JRnhkRmJkS0MvZXprNFhRR1RPNXNxYWYwelpueDNm?=
 =?utf-8?B?ZXgxTXdMZVJ2U3FmWDl5bzVTQUZWV3R0cjJMUk9HRmt0dkY3bzAzb1dxVCtW?=
 =?utf-8?B?Z3VRZWw5T1hvWk15L04xb1FxREh0L2U0SXhrbkZWclZBOWVSOXVSZ2J1NS94?=
 =?utf-8?B?TlhLdVNJcVh4VXlWMmZlU1VjR096QXJtSmNIOTRlWjlvVXBqN2hEbEpLVzZM?=
 =?utf-8?B?RXMwL3BadC92N0dwbFRJMk1KOURaN0dzTUhQY003em42VmljNUdlRlgwYU9Z?=
 =?utf-8?B?QXJrYitYOUljeS9jR3dWcUQxVUtKbUZsWGNIL1RKSUhZU1NBVzJXdnZuQ3VU?=
 =?utf-8?B?T0pKcnhGZitHV3hrWXNEUlpGWVpWTnk2a3ROUWFtMzlBOHo0bmhDcVQzdmMz?=
 =?utf-8?B?Q242N25hTlJiQnNiMVVuUWhtN0dYSHUrQW13YmtYYmFnVDVCRkhsSzltWHhi?=
 =?utf-8?B?OWtaekZMdHpCZHNhYmxubW0ycDJPZU9zbHBRTzdFUTg5NWRZWkRRYVpwOXFw?=
 =?utf-8?B?dGVPcWl3T2g4dWtPYVczamN3UHdyVjU1NlFYdEdXakdwS3dCV1JRSnZzaFo2?=
 =?utf-8?B?RTJ5QTYrUDliYXdYVjhqV1huczRQeE1lejNPZGgzRnp1SnNrd1ZxdjI3bGg4?=
 =?utf-8?B?c2hoQmZBcWJ5MmNkaVJlTUc3Z0lJZTZwMytkMXpBTkFhbUJ5WVE3UFFNUGtk?=
 =?utf-8?B?TG5rbkpFOHplRzducTJZTWN0U2wyVFpBYyt1Rm5oUGhPckdBK0g3Z2Y5ZGk5?=
 =?utf-8?B?YjNpTlgrM0tGaDROeTV6aVFPZzBNVWlxcXIrRXJjWEVxUVA3ek5MWHMyVHo1?=
 =?utf-8?B?Wnhtb2xYV2ZFNitOR1BYWWV0MGVMdDFNZ01UaXpUd3ZyYnFrM2ZtbklzL2Rl?=
 =?utf-8?B?bDd5dDA1Q2JrL1pUNlBZdHZVUjhtUGFOclJmWTVhOERwWjZUdGMrRGxVenVm?=
 =?utf-8?B?NmlBU3hVaTZic0dlY1NXK1hHK1FnQkhTTCt2U1F1RHRBcnlFWkRKY3VFdDBZ?=
 =?utf-8?B?c25qNXRvNDlnaXFNaUptUlVMSlpBOWptME9kVmhHQVBHOWx5Y3dZeGV3MnVx?=
 =?utf-8?B?REg0Y0lYWTRvd0VhaDRwWWxzblF4aXd4RytGeTVqRXZKdU5TL2h3YVJaSWo1?=
 =?utf-8?B?OWZOMHdhOWxjZkJOaFNEb3RkcGlIL1lCUDFxeEdhRFlwcTcwazJmM0FtY0U2?=
 =?utf-8?B?RDloQXRsa2pCVkV5T2ZHWXVnczd5eVgybUVDbXFBZzl3UHp3bE10YzhkbnFB?=
 =?utf-8?B?WTVBd3FiaU1NTFJuWVZXZHd5MjdLZzgwRTRZVlFvZVJnZEJQS3lxOTdYWkdv?=
 =?utf-8?B?WjlTQVAwUzE1aGx4MXhvZTN6QUNRRWE3VCs2ajMxV3hjWGhOTkF3VGw2aXVR?=
 =?utf-8?B?blE2YzRhRWZ0R1J4SExaU3JTVHJUcTR3YW83R1pycjM3cWJqc1gxc25vYUhH?=
 =?utf-8?B?MkdjTTdVZ0tIdlZTTGR6UGZhRlRsT3hPb1ROSUdTZ04wZ0c4d1FqVlBLV0J4?=
 =?utf-8?B?WjV5NmhUL3RrY0hTbHgrOWtMVzJyMUMvaGhYTVdPYjhCMzMvbVFaSXdSc2x3?=
 =?utf-8?B?RVI3RCsrcG1yODA4aTkwbEpxZjh3ZUREMjFsRnNhZFpKWEpEY0RzdTdWL0g3?=
 =?utf-8?B?a3JCb0lQMERIYXVma2grYVA2S1d2WmNXYm5KTk5YTEt2OFUra3lIOG12d3ZC?=
 =?utf-8?B?bG0zR2FNSXcvV3BmeFFEWStXTStYbUYwN2JHREF0WDd0UWRRNEhLVFBaYWwx?=
 =?utf-8?B?Nyt1S1BEbGhONkRYVm9UN3RGMVR3RDJuL3NsUlhJRCtYWnB2RTQ3Qm8vejcx?=
 =?utf-8?B?dDFxSFB5ZjdMU0Jpc0R4cWZGMzAwSDhydXh6SG9IRjg2M2lIK1ErMW5PYVhU?=
 =?utf-8?B?YzQ0NkpWaE1ZK3lXMmc0RW41d0NCQVZXTVVQUCtoN2RTa0t6Qy9hakJDS3JF?=
 =?utf-8?B?Z0d6SGtJb005VXJGc2REZjljbHJVZHpJMTQzTzFVdWFmcG9rUFRHNEV6cGxv?=
 =?utf-8?B?RGVyNDIrdm9idHc4WlcvdkdqZmk2YWpGUUZnVVF2UTVUd3pmUjBQbFNPcWZW?=
 =?utf-8?Q?j57YGDj320XMV3GbQzjwWS3/Lw5YRwymPv4qeWi4MehH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF56E1110776CF45B9F2E7DA3219EEEE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b465da7-f9ec-4e83-7909-08db46159480
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 05:17:50.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfrHJ35DSABAkbTvbXJNJ0tbsuIKMPykrLsygFPMP9sCXDgZm9AAeBq8WxPjPuUSkKX58B6QangvnKtsd2clxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_221759_387233_D643AA81 
X-CRM114-Status: GOOD (  10.25  )
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

DQo+IDMuIEkgY2FtZSBhY3Jvc3MgdGhpcyBtYWlsIHRocmVhZDogaHR0cHM6Ly9sd24ubmV0L0Fy
dGljbGVzLzgxMDcyNi8sDQo+IHdoZXJlIFdlaXBpbmcgd2FzIHRyeWluZyB0byBhZGQgV1JSIHN1
cHBvcnQgaW4gdGhlIGtlcm5lbC4gQnV0IGl0DQo+IHNlZW1zIHRoZSBwYXRjaCB3YXMgZXZlbnR1
YWxseSBkcm9wcGVkLiBEb2VzIGl0IG1lYW4gdG9kYXkgdGhlDQo+IGxpbnV4LW52bWUga2VybmVs
IGRvZXNuJ3QgaGF2ZSBXUlIgc3VwcG9ydD8NCj4NCj4NCg0Kbm8gV1JSOi0NCg0KaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtYmxvY2svbXNnNTE1NzUuaHRtbA0KDQotY2sNCg0K
DQo=

