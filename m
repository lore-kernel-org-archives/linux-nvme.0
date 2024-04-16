Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F1BC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 02:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IwpAKxusFRIEHestBJ8FxmRVDQP8CVZuiif87vAjZmY=; b=t9I4rZvtBn1lcJZBj4uFqS4UPZ
	uahsSmY7HuUxHa1jzU1hB4o/dBorYEqH/uLxTutGhQHUgoIb0+enNWBJ/4YOLwx0a7ZFl2jCfckEg
	e9ZFfWkjkdYixSXUdDpm5FcGv/o+0A4xYgO5waICv4U6iGM6yHJuD3hez+W6XpSb9FW5fhklPHsmf
	Sl3YBMRaY8gn9T+Eo8LekLRPPXYX03DOeSsy0GPHUNqO13geGLSemWZhdYNuQpRFQFabRuxa64lcy
	P28xmc/xHU8/pGd7KZkVYtJqnQOlM2qT1tL53iXT7IZJs1G6qZsFdwUw5oexF7YOcRN4/e3YvNZrn
	WvVk0CZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYgV-0000000AYdY-44Xe;
	Tue, 16 Apr 2024 02:36:36 +0000
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2009::600] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYgT-0000000AYcj-09F0
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 02:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUokC6G6QykxT/RKCanHDekmBmXcyB3oa4bKFLGuahEGgDl9bGESK4Zk9dD4aTj14VTOaePchLFgvAYT3gx5PeENXYgECb9BQcn1hayV6uUJDbHVFBjFfiqwVED1U4iVtlA7c3zxIjcQ5TiZ0Dy3CCB2Ox0oMEDMTZxoj1RefsALF+oWasFs1351Y1KqwcvfCKUplZPvqrP0u9FD0V2jHHoRdSKasfObBA56THSlofNcb2q+Ar3oEc3vEq7g18nRI7ReUgI7xXKkQAmi2S4CUpldfcSFwI7fod+E3iRWv/J8pBJXHQ7LsqCcQl39J2oR3p2C31JKqqIyaY2RiTu3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwpAKxusFRIEHestBJ8FxmRVDQP8CVZuiif87vAjZmY=;
 b=RkoXWihJOGwKSp30+bGHNHteIDGNpDGy4q4fPS28YXG+YzLj3UMJiFiVuCOYiYTAT6hvHaTjG1xUUTSocCZ647Ru7hsogd+8Z0+Yo4UL1yFrSVJtncsS8BTZGbBVShwecurWbSZpPsXQx1d924Knst13dUoaxoHvPdcWZGBFSCDTj4oc/z5Euc3GEvqew6XZx0FLST9qIOySgN4eNLnpwn9cl6P5cfejPg8JYoLGUQE2t7onsVQAQMlkLpV5xEDnm8+xtSpT/s715zuag3gCWb2xzAE+IHxVahUn6G8+e6Onegqf1V6drUURt1uAUEaL/HBiU2iyID7IbV+spV2S6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwpAKxusFRIEHestBJ8FxmRVDQP8CVZuiif87vAjZmY=;
 b=sAHoFTLjMDIlM+4G4N/qa1NXqQnoYgBWz6m/KLXp8FeSURq8I7iXNYr+oqiZz1h9DbAEK5xJUeJ+cGuJa7fPefDm54UIpnuJzYIhykMNsHO8gkd8tJoOA6GNf7SVPZGeOtUJciA84nUfmvUPOK1bcmePQC8/hIBQOmxzR+xBhoIQBo3XUOy9pJl29LHRwX64vSzDXXg+P07NRM8rywOrzoE757lQ9SxARSqFVouHsFb6al3Glth30rvk1mo9oIr028+bVcFClUCYrjHAsYRDcBu9FIbqPS1SAJelWue+v9CMFdkrKIiq74PUCCyho+Tny+Qdfyj31lFFl8NBMwIbYA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:36:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:36:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH v2] nvme: find numa distance only if controller has valid
 numa id
Thread-Topic: [PATCH v2] nvme: find numa distance only if controller has valid
 numa id
Thread-Index: AQHaj0DL5uOxMb7+oE2Z3Jlm6ub9+bFqLzYA
Date: Tue, 16 Apr 2024 02:36:18 +0000
Message-ID: <a31a6787-16cb-4dfb-afa4-f24d66faab3f@nvidia.com>
References: <20240415142408.889236-1-nilay@linux.ibm.com>
In-Reply-To: <20240415142408.889236-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9119:EE_
x-ms-office365-filtering-correlation-id: 448fdf71-378d-432c-26b8-08dc5dbdfeef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsGkfPSJHmN9bObJZkqZIgv55UTKae+ogE7kdpTZyE0FKgC07PAYMyt6+WpwActxUwPwuG2bnbH9aZC8nUA6nfQL3w2W1k1RLt7QUePSRQSRtZjyLUqyTRTO4h+Fc5uxZyzanZ+T85UQQOMeOoa80v09aJrmcCDYdNVHtuCB8B4vjvLmL79st0h1hYFnUc1Ymr0ut4azDk/9N5Fo1ICZmcbkZoQPkz606GYaZoMOdkcli3KJ0i9Ym69V2aOUS25uv5oG+/7aYcNCLnkIs1HTGt4N4wEsky1/YHRZjrlPtRS17qakPmZGcO47UfkrU2bWTIamEtkfXAQKYXnyvArDLQBDw7UlJiqlfjPIFckdX4vwpr4nHeMhPJ2d+d5rm5tkHXVvdjFb30NlYHS9kgen58EomAVqNsldAh1dbkiOM/q1F1J+rA5l/hEf00j3k0CS+J/b0NqqN1yUCq/4YJ8XrQnTz8r2ppP5fJ8SAvLIw3tSLXaA98O7BFvlWpdiqFs5hERhEDggXttIUO24hdDeloxHddNRzJEPGchz5jpkWsF72PJor7zYTyWmGCm4qAhef2SPe3BQQaT/ClItBoOu0unfTmiLQUPQbgQ5spg2APXR6xLyoRhiS8vwSpiorJSg3J5e5QIORe9di2J8UKFfkC7GUCOkixlhhYwcHFdm6P0pJfLk6F8cHDnq62s6bCPM2JJWC1E8n2CZj2CKrqsgWCwZNv5slB4UCPgBokuBHiI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzJiVFJ3ZzZkU244cklaZ1RrVGQraGdPMUg1NnFsUGdMNU9DeVlnWG00L2hM?=
 =?utf-8?B?bThxOFZWTUxFeCtIV2ZhV0p2bllNQzFyaGNsQzEra0tOSWtxdlRYQ1hFWm1x?=
 =?utf-8?B?aHVRQWRaMVVxUkMwZlp5dzF5MktZVWVOZ0VxUnFjUk1GSHpUbncweWRaNlkx?=
 =?utf-8?B?THNxcHhTcTZZd2RpcGtldmZSbG5MZno2UUdMT3d4SEt0cnUrOVlUL0VqRGtw?=
 =?utf-8?B?RE12akJpYVVjVVJQdnJ1bXRaRFRJcFN0bnc0U3NObm5XVWkxQmVSZlFvWS9H?=
 =?utf-8?B?SFJSNy9yU2JwcW5BSVhlUllrV3hvb0dZSTJjKzJkUmN2ZHVYcWZsd2ZGVFB4?=
 =?utf-8?B?Z1RxSjNWRlhNL0JpY0xkaEE1bG1LWkVYTjVkTHVKNGlTQzdXbExGaW1zNHpK?=
 =?utf-8?B?bUsvNm5LRnNRc052MGQ5bGtmdkxxaHZVTjZKcnd3QlBCMi9PK2FtS0xlY0hG?=
 =?utf-8?B?cWhxZnNhSVM4QThnSXRFZXlJWms3MVlmRFJsTEZHNVhZVm1NNnZodXl2M2N0?=
 =?utf-8?B?a0lDRjJXZ0RuTGVNVFhtaFdSZ2hCMkl1WlBDR0FVQlc1Mi9SUUpYS2FlRDQw?=
 =?utf-8?B?SlJmSi9CUDBxdmtnV2pHQmI1Yi9aZjU1TmNBajJ5a0Z3RWdnemNWSGI1cHRp?=
 =?utf-8?B?SkVoeEpNYnFNZzF4cVZieGJpMTlXcDlZZEJEdG9aT01FOGRKeWY0dUxZZ0Vh?=
 =?utf-8?B?RjRkM3VpSWFZV2lpYkl2aERWZ3U3TGs0SXRud29EYmFERmNQMjZNNHUvZ3Fo?=
 =?utf-8?B?L1c1cTc2cHVpSlZ5TktRbDQrZ3NHUzRPMUNUMHFsTEV5QnhkeHNITExMbzV1?=
 =?utf-8?B?V3RTb2x5QnhpeXhmVVpBQWFtT3AxaVZ6SjE0dllFd1JwTHIydmNVeFZodDZO?=
 =?utf-8?B?NXBTTk1vMVBDYlBTTDNnNFZ1M2NGenFER2svaFdjcU5iUUhPZ3B0Q1NCVmJk?=
 =?utf-8?B?UGsxRXlSWXkrOTMrdTRYSDZhODBQYW54SE1zM3h3a3ZyKzFGb2V5VlVhT0Ex?=
 =?utf-8?B?d0wxSHRZMDl3b2R6MFVLNEQwV2FYOEJxYTRoMmVPY1pZV3ZocE9xdDFMc3A4?=
 =?utf-8?B?amFnQ3lPdWVCblpPektCcSt4b2p1Yisxb0tjOC9UaFdReWYzeFFRbXhhWjNE?=
 =?utf-8?B?ZG0yYmtYTzFJM0g3dUlMNzhUTHluaDdhSE9oekFDRVVwOWZkSk9jRUlYa0dx?=
 =?utf-8?B?N3k5anVUbmVWcXo2VmQ4ZVZKK3ZkcnMydnVHUXA3bEk2a3pPZzhRSkxYWUZE?=
 =?utf-8?B?TE1XK3lWeS9pRGpEMU1RelUwdkZrbzhRUXlWbU5jUTlhZUg2RUtFaHhCTlhD?=
 =?utf-8?B?bGx2WjZJeGVtL25mTjNlVzhjd1ZDVzFzaWNROEpZMkp1Q01sVTZKVEUxS1Uy?=
 =?utf-8?B?TkxVQVZCRjBBRXdnemVIZndTVmd5eXdrcE9WaTZBY1VWTklhUzN5V0FwOE9D?=
 =?utf-8?B?MmdNRXBGckRHUUFvZEVLOUMvZjhLTU5PZ016S0lORjZ1aFZHUDJWTWJub3lu?=
 =?utf-8?B?alNRdTQvQ2tKRFArY3h5eUdKZlRHZkE2MnJteXhYRDNiK3gwbG02aXJvendo?=
 =?utf-8?B?cm1ISEVOVExFWHV2VzBITXVWSSsxM3JHclNwV0ZsaExMbEZEREVLaHhldjI3?=
 =?utf-8?B?ZVlhczNQOU9uNk9vVk5xZi9LQVE0eHRKQjJlcGk1SjlPRkt5dnVNOU9zRkx6?=
 =?utf-8?B?OEl1MzI1ME1Xc1oybUR3S3NtYXpkYy9lQkx2Wm5HWWY5SVdsZjFOR1VITzRz?=
 =?utf-8?B?eDU4aTk4WlBXSlViNDBrSGVlSkRLUE1PaGF6RzNFLzNodE9yVzBPWnhsc1pL?=
 =?utf-8?B?ekQxaTh0enorV3NoNjV5dklLMXJWaTRRTzZjcDY1VCtIbGJrbUdhaXJXWkN3?=
 =?utf-8?B?YnlCQjFpbXhIdVhDeENOd2JGZ0lCOEVRSjJ4Rm1CR29KU2tJWWx5QjhXVlBT?=
 =?utf-8?B?bk5UM1Mxb3BjWXNaQkRKZVlrcDN0L1FhVGlGckFUKzErbWh5NUtuVHFjcHJa?=
 =?utf-8?B?Rmh0SzZHWHM0a1FFWmtReEhxZkZ4endqc0V5MHMwdHNJZWRQSk1jQWpQdGU1?=
 =?utf-8?B?ZjM4RnlHVXdDV1ZnR0ZOMG5rSnY5akFGa0JCY3hUb0MxSzV1akVhcmNaTmtI?=
 =?utf-8?B?UUY2MzhHcUpFMFVEOUVSTC8wVW91N3NoOU8rNkFpRFFvcUZ3SE9Cb2JGajMv?=
 =?utf-8?Q?m2o44BQd6R3UZFemXZcbIpadllkZu3ZOPD5hlWQ/sMEM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67F39B987BEB0748B463FC969FE316E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448fdf71-378d-432c-26b8-08dc5dbdfeef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:36:18.7001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkezWnYJroMRgs66EiNAGQZV2COfGUurj8aMH1aUArTWy0sEW2C1Fgm1D1vt0KszeRBSBzk/J2nGBPU94GM96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_193633_162389_E461591B 
X-CRM114-Status: GOOD (  18.41  )
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

T24gNC8xNS8yNCAwNzoyMiwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBPbiBzeXN0ZW0gd2hlcmUg
bmF0aXZlIG52bWUgbXVsdGlwYXRoIGlzIGNvbmZpZ3VyZWQgYW5kIGlvcG9saWN5DQo+IGlzIHNl
dCB0byBudW1hIGJ1dCB0aGUgbnZtZSBjb250cm9sbGVyIG51bWEgbm9kZSBpZCBpcyB1bmRlZmlu
ZWQNCj4gb3IgLTEgKE5VTUFfTk9fTk9ERSkgdGhlbiBhdm9pZCBjYWxjdWxhdGluZyBub2RlIGRp
c3RhbmNlIGZvcg0KPiBmaW5kaW5nIG9wdGltYWwgaW8gcGF0aC4gSW4gc3VjaCBjYXNlIHdlIG1h
eSBhY2Nlc3MgbnVtYSBkaXN0YW5jZQ0KPiB0YWJsZSB3aXRoIGludmFsaWQgaW5kZXggYW5kIHRo
YXQgbWF5IHBvdGVudGlhbGx5IHJlZmVyIHRvIGluY29ycmVjdA0KPiBtZW1vcnkuIFNvIHRoaXMg
cGF0Y2ggZW5zdXJlcyB0aGF0IGlmIHRoZSBudm1lIGNvbnRyb2xsZXIgbnVtYSBub2RlDQo+IGlk
IGlzIC0xIHRoZW4gaW5zdGVhZCBvZiBjYWxjdWxhdGluZyBub2RlIGRpc3RhbmNlIGZvciBmaW5k
aW5nIG9wdGltYWwNCj4gaW8gcGF0aCwgd2Ugc2V0IHRoZSBudW1hIG5vZGUgZGlzdGFuY2Ugb2Yg
c3VjaCBjb250cm9sbGVyIHRvIGRlZmF1bHQgMTANCj4gKExPQ0FMX0RJU1RBTkNFKS4NCj4NCj4g
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNDEzMDkwNjE0LjY3ODM1My0x
LW5pbGF5QGxpbnV4LmlibS5jb20vDQo+IFNpZ25lZC1vZmYtYnk6IE5pbGF5IFNocm9mZiA8bmls
YXlAbGludXguaWJtLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgZnJvbSB2MToNCj4gCUZvcm1hdHRp
bmcgY2xlYW51cHMgKENocmlzdG9waCkNCj4NCj4gICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBh
dGguYyB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYw0KPiBpbmRleCA1Mzk3ZmI0MjhiMjQuLjA4
ZTU5OGM4N2IwOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMN
Cj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMNCj4gQEAgLTI0Nyw3ICsyNDcs
OCBAQCBzdGF0aWMgc3RydWN0IG52bWVfbnMgKl9fbnZtZV9maW5kX3BhdGgoc3RydWN0IG52bWVf
bnNfaGVhZCAqaGVhZCwgaW50IG5vZGUpDQo+ICAgCQlpZiAobnZtZV9wYXRoX2lzX2Rpc2FibGVk
KG5zKSkNCj4gICAJCQljb250aW51ZTsNCj4gICANCj4gLQkJaWYgKFJFQURfT05DRShoZWFkLT5z
dWJzeXMtPmlvcG9saWN5KSA9PSBOVk1FX0lPUE9MSUNZX05VTUEpDQo+ICsJCWlmIChucy0+Y3Ry
bC0+bnVtYV9ub2RlICE9IE5VTUFfTk9fTk9ERSAmJg0KPiArCQkJCVJFQURfT05DRShoZWFkLT5z
dWJzeXMtPmlvcG9saWN5KSA9PSBOVk1FX0lPUE9MSUNZX05VTUEpDQoNCnVubGVzcyBzb21ldGhp
bmcgaXMgd3Jvbmcgd2hlbiBJIGFwcGx5IHRoaXMgcGF0Y2gsIGFib3ZlIGxpbmUgc2hvdWxkIGJl
DQprZXB0IHVuZGVyIDgwIGNoYXIgPw0KDQpzb21ldGhpbmcgbGlrZSBmb2xsb3dpbmcgdG90YWxs
eSB1bnRlc3RlZCA6LQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRo
LmMgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYw0KaW5kZXggNTM5N2ZiNDI4YjI0Li5k
MTZlOTc2YWUxYTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYw0K
KysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMNCkBAIC0yNDcsNyArMjQ3LDggQEAg
c3RhdGljIHN0cnVjdCBudm1lX25zICpfX252bWVfZmluZF9wYXRoKHN0cnVjdCANCm52bWVfbnNf
aGVhZCAqaGVhZCwgaW50IG5vZGUpDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlm
IChudm1lX3BhdGhfaXNfZGlzYWJsZWQobnMpKQ0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQoNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmIChSRUFEX09OQ0UoaGVhZC0+c3Vic3lzLT5pb3BvbGljeSkgPT0gTlZNRV9JT1BP
TElDWV9OVU1BKQ0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5zLT5jdHJsLT5u
dW1hX25vZGUgIT0gTlVNQV9OT19OT0RFICYmDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFJFQURfT05DRShoZWFkLT5zdWJzeXMtPmlvcG9saWN5KSA9PSBOVk1FX0lPUE9M
SUNZX05VTUEpDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkaXN0YW5jZSA9IG5vZGVfZGlzdGFuY2Uobm9kZSwgDQpucy0+Y3RybC0+bnVtYV9ub2RlKTsN
CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQ0KIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGlzdGFuY2UgPSBMT0NBTF9ESVNUQU5DRTsN
Cg0KLWNrDQoNCg0K

