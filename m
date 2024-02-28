Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FB1C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 05:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P7/bnPEo1K/kMUnNIVX5k1aMdssPrkvwCNzJN08zcFg=; b=KmQOG8dvMFjzp6fZ6GtWlzfRgS
	PQMRSMXFRQSkoUAewAOveAqOdDVQmJ1qbLnhW+EVNv2dqZ670L43YBl/s7idaUKbCB+x4ttCRm/aD
	97pUIWwvGKcLStflkSbxFI148JaLD3cbkaiHqu+I+scPhfYDip2QhEhA9dpBAmMk+h2RwQrzk6W3v
	9SpXV65BNgAg5j+g5AjUldWPlUaHrq9wFunFc04sjhjbaHjYvMgA98arD1YTUnvsldHhrXQRoRx5M
	DT1K8EpHpKiESd9yHh31D6PcmT+0s/jLrf7Z0rB3HW4D5kG65I0iykmAEyJPdXSY2pQF88peWX7Xs
	1cH0oS4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfCai-000000085tq-3h8W;
	Wed, 28 Feb 2024 05:34:52 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfCag-000000085sR-0TJO
	for linux-nvme@lists.infradead.org;
	Wed, 28 Feb 2024 05:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liusyuyhRFT/Uo7cRaZbscFO9+zBp7d0TBJo2uLOs47JqdTXrlEfJf2qKX+atvWRBBGkdChT0PnkBntN1S5dsBsznpRKcgWsKIUEx+BFNQnCWt2RJxNlk0kdjIzFl8A6dF34QFavmDyaiLEWaAvDOVGvvSSrc1Os03pAH1NzuEj/ToTz4b2qUZO2BsLrqOiS5ZndgDEZ3O3mf9F64Y/hMT8aeBG7LjPeWW5yINRLGN3+trFO8aM+kjlLHhutuKri/fcHX5kRpKWSb0DumkC38sPwMkNDVSQRaNGNVCoYkJiTdgTjg1BkLSRF8Kfu7dG5KZ3Cfy1AUR4lHsCQFjYijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7/bnPEo1K/kMUnNIVX5k1aMdssPrkvwCNzJN08zcFg=;
 b=bR2crLBgcmWUDSglQlxaMN0NjmrKEgk3Z990wcbnbYIkOLBLkG+ZdmWTeUDKAx8qeW4NpDmxJr03HejpoEJTlzx9vyNIiMjYVxil6dKltc1p6BATUvSu4B/yVbfknYM0Q1X+G3Ow15G1B6j1pn5+Ludvl34DHZnOsp+yGLiBMapWosEAzc36M+LsNFh3ALm0vNk8diojC/lYa7iB7dgs9o3iMCV7cyY4PSUL380isvPiHw3LiTH6zENht1qgMJPEQ1B3pD12tsRpn0bhsVssOF894V7LW4zMAgf5w+jtscCUvM4AxJ1LPtL9BjZsV243u+noXMddrJjV9jEcT7pyHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7/bnPEo1K/kMUnNIVX5k1aMdssPrkvwCNzJN08zcFg=;
 b=eGsfFS31kMhZxgCXLvYgwouzrBqQL2QgelgOJvcQuh8mqQ7yG4Fdiq7tRpVrew1GvKMwdV9ATouxQuqn2QTIi60L3klkCh92DAJFzmjrZ6NRqLSETOICkxmkpKwbsEPcRhHCshzRC66+8PyFEKLu+WTycb+cCu666EDR/9FR6UTajqP/tAZpHDGRqX7RyGqflRig25kmYHeDJyHSxUaI3Lbe+SjX9SUL6nl19Pj9emhVMnEEmTwfBMP067HgkkWpoWk42KtSHwlsAWXXRhDFp6hO0CvzyLMY9zyw20q3SzMoFyeSdrCWzwyE1jKKh7ZWTB3gdWgXc0du20p4vIzjXQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 05:34:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 05:34:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme-fabrics: check max outstanding commands
Thread-Topic: [PATCH v2] nvme-fabrics: check max outstanding commands
Thread-Index: AQHaae853jIM1yfUFEW5CYzDBOnkt7EfO8MA
Date: Wed, 28 Feb 2024 05:34:36 +0000
Message-ID: <82fa4434-c6bc-4e73-a1c2-fbc6a90ae03e@nvidia.com>
References: <20240228023759.99111-1-kanie@linux.alibaba.com>
In-Reply-To: <20240228023759.99111-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6572:EE_
x-ms-office365-filtering-correlation-id: 3c21bef3-9d79-468e-304a-08dc381ef386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yzxG5qShpOEO8SwqE15I7GvIXJHc33+eM/dtlSF4OEGYIUg989fmX95/5r+/o8QW55DLBF9VxAwal2IiVopQiSE5PFimF8xyYHAr3IIqyRylZl7HK5PdTz39J03j3Gg88OoRBN9dup5r4YNQ+bbWTkppyOSpfpxK3rSlhTF7RGcfmN1tyi59MCLfLGTJbrRy5+u9cdq4oogfIe+L9Tw3ChlmBEeq24K+1OMQJrh9ehYkpKylPYp3XRCLGU6yCw8y2JSjRSd9JcSDiOd4y/YREYjooYmxOwo1lcLlQJOjmAUvqrjkFyMznTkmo7pz+e4KRKQ7XUdoy7dTt7D7/XQc4UGT0LhKIEyw/hVwSegZEmPpO228xUqcz+7vdG29iPMzCeko1tT9SFdXPQ+hqj7ThNcq11JqNrYGGESfbBG1SILwEbZGmJhmscsGDPQu80icezG+lBShBJcX6GYjzOuRj8ZAhqUlvUx4FyhY7Uwd0uQT58vUZZUqrAyFVX0wZfIi1lyQKdoieYTOUA7G9GaupcubdBX5twm0VCoOEbVUvxQ4HBoM79SNxpMGi6Wyonw6a7PC3cTnsyh1F0xRPs4f9V4n24zhr+EAEZCZTRL4aUVYDSZb/JAIui9FcCblRqmaVHuxVtZuoBS3ojgI1ROAoqAShtplpWo73dN5ssweXA5JD5p8FCG86F5HHvhQG8Iuwd4Mca26N8ZsLiv3kYrcazNgMukMI8T9p7oCTyyGaCI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVZKZnN2dm8wK3QrOFRZYnJEbGE2YUdMdUpyZm5uUVBwRHFOL1NiSmdGRVZs?=
 =?utf-8?B?TUJRZ3dOSURRbENtRWUrZXRNbnJJWWROZkprUE5iUXgyWk9uVzlLSitGRnBT?=
 =?utf-8?B?MGx5dnVQTWIwa1FkRVpBZnRJc3k4NERBVFdrcFFxTkZzaldzcXVUTzFNa3E0?=
 =?utf-8?B?cmlubWd6eHNMQ3pyaU9lOUtoVXJ3QnRjT044bkhwais3Vks4VTFTbmh3OElS?=
 =?utf-8?B?dTluUlNLUUZYWnBwMkd3dGQzejg3NTc0TlBXME9aSzlPeWtZOXBEVXJ4UlE3?=
 =?utf-8?B?LzEwZ3VrZFhCT0pLWDJHNStUcy9mek1kRG9FQWllaUViNTM5T1ovOWlpTlRN?=
 =?utf-8?B?azRxbVJacTJqd1M0aVBDQzJIT0NyQ0d5ZGZCZjMxa1NHdEpBU1NKWXJnMWZP?=
 =?utf-8?B?WS9EWTFaZnhWamluZlZLVTR6eVlWSnZldnlGQVFoaGlLd0d3eFltdFM5cjlp?=
 =?utf-8?B?ZjdsZ2x2NmJ2b0wxVDNYMk9iMjc4ejlFamlLUy9qckxKdmd5OG50TmRpT1FX?=
 =?utf-8?B?OGlDeWRkOVNQL0NtL09TRDZpNTBKUS9vV256dEpkTVZHRGFYRDAwcWQwOFM2?=
 =?utf-8?B?OFNCemgyR3QyWUpsWFJVbzNxUjJtbGh6eWdod1BObHM5SWhsb3Q0endxNCtl?=
 =?utf-8?B?WDFXVFdmaGNSUHVwTk1VcStzS1M2Nmxwek11QVB5NVJtTnhLZlV2S3p2bTlR?=
 =?utf-8?B?ZHdDN3pMYi82M0lPZngxMjJuU3BGS1VMTTMvZ3hQWEswd1d1WWd6SVlQeUR0?=
 =?utf-8?B?eXNCbTc2UzFNTi9LM2xhdFJONWo5M2Q1V3RCUHFHNmd4Nnh2dEJDc0R1L3Iv?=
 =?utf-8?B?NkdBWkVyeUZXUmFrOE54WHNUR05PYUlrbUJmRUUyUDZQLzdSZW5mUElhZWxX?=
 =?utf-8?B?ajd6Q0plWHZpRE9nS29pdDhrWVdUVW9vQmpXYXJYU2FHVEVaRFFBOVN2eFla?=
 =?utf-8?B?TDRZUWszNUlMRGZ1QTQ1S3VmSUViY3pFZGlUT0Z6U2xYR3NaWVo3aEVobU9i?=
 =?utf-8?B?ZDc0cllTcmhydC9kU3MyckU2ZFdrT0N2alhiR3o3KytXKzNPa0c4cExieVBn?=
 =?utf-8?B?V0I5YjRGdERIR1Zadmh1RkRkbWYrdnBGdHRCN095VGd1NWNHREU1UytCU0Y3?=
 =?utf-8?B?S2pNZnFsVGFwbEQxaTMvdGM3a2VXZ3RqQzB5NytMVDJNUFMvS3hxV0xqdkxQ?=
 =?utf-8?B?RGdmYXNnMHprMGFUNlhxc01mRVdjNHNOVDlVZEJnYkhWRW1wTTlqNFptaW8y?=
 =?utf-8?B?Z3Q3eE5MenhGQ3JGaDNYSFV5UWVESHlwdHZrdnl0dmN1cnFRRjRhUEFES2dV?=
 =?utf-8?B?M1hHUnVtbWE4NWpwandVMllPYmpPVjMzM0w2OHFMK08rc2l6blRHbjV6cVlZ?=
 =?utf-8?B?WlZNNkxKbE05KzZ6b2pCdkFSZGc4SGVPbHgvUG1SWTMrb3I1MGtKaFZUQjUr?=
 =?utf-8?B?cFQ5d1NjYUhCWGlCUXV1MG1ualJqN3dNQ1VFQmFDR1ZsN2xoSmFDUzFKSWJ5?=
 =?utf-8?B?bm5NWFpSOE5BSGdPa0tieEY2aHF3aVNkV090TXZuZ1I0MkhJVDlYS1VQanJY?=
 =?utf-8?B?T2s5djdocmNoTjRLaklMWmpiNm9hWU1TaVFZZ3VnN0VrNGh1eEh6OWdmbG9l?=
 =?utf-8?B?Rm4vSmo5ZEp0TndJTGY5YnQ4cGVGT0pCTHhwM0UrdmJRMlNSaTE4eEFNMXBO?=
 =?utf-8?B?Q2RLRzFhM0NWOEdJWDgzR280OVA5ZGVIR0UzeUNWWWRMekpqOW5lYUcrOHg3?=
 =?utf-8?B?Z2x5TFU0SEdieXJZZitabVYzQ2EzOUhrVk1pZGlFTUhCQmU2TkM1Ukh0OG5P?=
 =?utf-8?B?VEgvR0Z6di8zUDg5c2JYcEVLWUdRczdPZWNqaHp4N1RqelBWMFFtMFJzZlVa?=
 =?utf-8?B?Z3BxR0xCQ1o1WmJGeVJ4YXpZQzhtZWJvYXpxTG92L01Va05vZ1A3RjVZV3F6?=
 =?utf-8?B?WVJYMkN2Z1NmdGRZNHpoSVBJTExvZWpSQmcvTUNURC9DM3ArYXAxOHlSQnk1?=
 =?utf-8?B?aVdENDBrSXkyNngvdmJBWGY2Y2hUOEtYM2dyYzBSQ3M5WnRDZnE5Y1lZTHg4?=
 =?utf-8?B?NEc4aytCSmpWWE1pd1RFTFZBa0ZqSnduc0xSWlRiQWUxU0xiSVlVL01RK0xp?=
 =?utf-8?Q?NQB/qchZnbWB5W/6rFlPLIv3p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67FF7AEA4B48A54D857E448B5936E12A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c21bef3-9d79-468e-304a-08dc381ef386
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 05:34:36.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GR1SgeKpvmuIXsr9QDDTaJMBErDTzt4U3h0k3XsREWlY/dkH+g0ON0HuoaWzq02ShaROcSVR1Sj3h5eH273WTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240227_213450_184870_69E25674 
X-CRM114-Status: UNSURE (   9.71  )
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

T24gMi8yNy8yNCAxODozNywgR3VpeGluIExpdSB3cm90ZToNCj4gTWF4Y21kIGlzIG1hbmRhdG9y
eSBmb3IgZmFicmljcywgY2hlY2sgaXQgZWFybHkgdG8gaWRlbnRpZnkgdGhlIHJvb3QNCj4gY2F1
c2UgaW5zdGVhZCBvZiB3YWl0aW5nIGZvciBpdCB0byBwcm9wYWdhdGUgdG8gInNxc2l6ZSIgYW5k
ICJhbGxvY2luZw0KPiBxdWV1ZSIuDQo+DQo+IEJ5IHRoZSB3YXksIGNoYW5nZSBudm1lX2NoZWNr
X2N0cmxfZmFicmljX2luZm8oKSB0bw0KPiBudm1mX3ZhbGlkYXRlX2lkZW50aWZ5X2N0cmwoKS4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogR3VpeGluIExpdSA8a2FuaWVAbGludXguYWxpYmFiYS5jb20+
DQo+IC0tLQ0KPiBDaGFuZ2VzIGZyb20gdjEgdG8gdjI6DQo+IC0gUmV2ZXJ0IG52bWVfY2hlY2tf
Y3RybF9mYWJyaWNfaW5mbygpIGZ1bmN0aW9uIG5hbWUgY2hhbmdlLg0KPg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
LWNrDQoNCg0K

