Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1ABCD128A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 20:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dj2FMHJtEwWnyp6yH22PONxNlrps+yTo9ebQl+D+uTY=; b=YyqgOqxVGL64EtVRjCfbkRsmR9
	31gIJ2PkS7TmXCA/Jp64WKDFQUVBjW6zDHZSs+P4sYbnV7Qj9GAy0e3z+EU43CsjfXRzcw9ij4JJ+
	5j0qYLyC6IVYQ6iquP4mT0zcEwVGmradnDTBjKbpUma+fHPeJ3ZQAat9Tr1yx2LkzSrY42X91Vxny
	npDrucaWvB1iyCGHuSx36eAXoLm9pW4BYUW/XdV/EBV/dEwzSCGZwznHWzBtTM3oVIUWcus7BXi6c
	d9f38Clxrfx1e/HF1Gg0dmkpoDkc5M7HZBFsVOPRPEPZFBwuTo3MRhbL9+AnBB0sCyIHdBiFR0SFc
	MfJp3laA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruezU-00000008v4U-15Fd;
	Wed, 10 Apr 2024 20:56:20 +0000
Received: from mail-dm6nam11on20701.outbound.protection.outlook.com ([2a01:111:f403:2415::701] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruezQ-00000008v2Z-3blV
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 20:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFPNFbCI2jwnsDGFXUmiZrrw9vsOWqXIL2wZd5+ta7XVQwkySfqVOLbxLgWYAHQNF+1Ar9mQzH3xP/I97V/3aujmhLrE8AmiByQWFRMvmGSYXrlMfkswkkG4ibEj43pVT6BrXhdngQk8BWHUxFjNIFRtOsfrzZs2IXm77IQit9i0w9KF9vFjYH1Xyln9qrVZNLuJmZN0gP013kSQFBA/kkj+01TMWZEi9J6E26r340EjJUbcfneEtHKENKrUdSWPEMdmx1LueTEv03HECy4PPQP2aVG1TdQIqTgGDA/mjQJPTy3tv1HzPD4NCu/aGS8AmERzJYlUtTYpmE2GDpeDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj2FMHJtEwWnyp6yH22PONxNlrps+yTo9ebQl+D+uTY=;
 b=mVDQ9PpA3dWGjvyKNftsm5xdkjq9eE2/Fl3cZzcBJWmkgi2jjJX0nEgX/YAvvhDMc6yCU6Sr/slAunzUuNeGzBUTOwGYuHixV8AvXDEmuaNJXBteCoscnngbGHZLCxr224FW/hLQI8tbbQDOG7nmhTP/YIdJ/ioHwrZP+CH0Td+cvcGl6QdJwdSyy2AozkqwLhnjyVQ5A5ioFxpm5i3HEvqx9mR5tN5zvIleGySDDlNtuvOQ4BBiq8un6rwx3lb0C8PxdoThMldH4gT2aqglp+REVG0V+0DDP4i4WGiKSYaJRsVAZjvn45u4ePidBS1xqxEVsp8lUeoY3BuyZ0xOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj2FMHJtEwWnyp6yH22PONxNlrps+yTo9ebQl+D+uTY=;
 b=REqkx6JNEN714xFXYlYY6GMsbELuo/vQnVdCM3lS5U3YlM9nRtlRDxYVTfqGswzyCqhyqui0pnyOQ+7Y2BG/s4j6stZxV/3mQOdSBwsq36546BbFR3giQSj72DHiZTpiXtLPQQe0mgigtK1lIDDpTTtrSBYX3Bgz+qESqfQANEDgJZ9Mdd75oXku3rXfGghOYLHSUeojIF6iCu0YUpLY0JvBsMfHhXbedeFhvu4zVd2wknSdQtDLC9OLlYcf8UE0ooRbSgqQe42jDHppPhsAGJUz7Yrk8Iqfa5T0eSbRCxQtb2Hwz9PUpLr7n5Xc7o8mpNPOkkooN1c6obUqNP3UFA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 20:56:08 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 20:56:08 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v2] nvme: fix warn output about shared namespaces without
 CONFIG_NVME_MULTIPATH
Thread-Topic: [PATCH v2] nvme: fix warn output about shared namespaces without
 CONFIG_NVME_MULTIPATH
Thread-Index: AQHaiuIlrLV8uL9ENEGRF/A9l127NbFh/UEA
Date: Wed, 10 Apr 2024 20:56:08 +0000
Message-ID: <07ff5506-ea5d-460a-b144-208b881b1f9c@nvidia.com>
References: <20240410005714.4112157-1-yi.zhang@redhat.com>
In-Reply-To: <20240410005714.4112157-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6569:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3Y6eodeU/G3TPJvV2nisqrjG9pVMuX5HxUeXt0Y6fQ1YjTCnxYrrgkcp7Mevq5voXpP4D2hilZG2vpYWtBqnHQK0pWwus+uun0ruKx43r9hMLgA33L4PWrLPcufUlFdyVLrrClmeL9H/Qe7wHMr+AkvRPtKiunxqlTAFc3/nRyhT97arwQza8WwGUBG+K2sJKxXKqUqw5gBXnsQHWi4ClRQYCbNls4BBAu02BnxcL7mpHkjm+UctD1EAeitEt5JZRkL/n4ChhiwsDqnUy1i2SEwz+c3TRSn5VeaTxfSnQBw+J9Y0RLzDNb9cUTV2piwrnEyZfC2GhOMnT4uK0ZN5rsj0BSmw4WZoUY7tvkaVT1Z9TZEjOux5fS3+Jp00yQWg8PAeQnhlUpTymji2TUUJwxkV96zSazO2C0uu5g1NwIYmS7RtDaRoR/Eq/EtEVK86CT2QQQR3haGRyu/BFAWN59mKcXRyVJzvsVV64KLejBMsZ6LR3Ax4QAHjnmADoe5geGIfqEEsgsY8ZrT33+YiRXZIH/3/hb3qgUv8jy/xga1Qxup/w420/nGKWFLEtWIWTUimS8vRIBQGtf3YihRN2SOW5RYgwfHvSlXmgwD6JENNHaBPUeGMXQ4PNhGd3MSe0OJ/fMG0+AbkJTJc4OJ5LnrW/nI7nPyUP/bhkQ8+r0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEpJQWd0azM5ZHNad3JTM3lHMTgyY3BUN0o3elF4Q2hTUllMeVB2YkZ2YW5C?=
 =?utf-8?B?Z0VFQXErWWgycUtadVZhcC9UM1JKTjVQVnZiOW54aEVXZDd6SjlDMlh6WXda?=
 =?utf-8?B?ZXFkMGllYWlDZnlTRml6UVBmRTA2c2RGcTRHc1pJQWN4cHp4YzZCZC9BR3I5?=
 =?utf-8?B?eHI0bmNVbGQ1Ukk3OHozaE9IYWNmYmJWeWROME5hV2QyYkFZSXUwM01YUmhh?=
 =?utf-8?B?bWsxQkYrSFVWZDJzeWhiSHNLUG1aVEpiNlpkb3E5RmVaNERsMW93N2Y5aHRy?=
 =?utf-8?B?algvYWVudWFkK3VZYVI5ZHZkbVZiRnN4eU0yRk43TXhrQXBCZEk3N3JuVFhK?=
 =?utf-8?B?amNvQThqU3MxL2dxVlg2UDZBSXRkNFIzTHNYWm1WbXdWcWZDRXFUVTh2bjZT?=
 =?utf-8?B?UXhYMWx0WnJ6TUs1QTlxQ3Rrbk1FM3dNV3JnS0xES2gydjNuVjZxTXJEZ050?=
 =?utf-8?B?OEVyRU1xQjh1L1F5b1BrK0d0c294dG5oZmFOSmNTQUVaZnp4NlQ1Q1lhdVF4?=
 =?utf-8?B?azN5Z0hFNlJlSWQ5ZVVvMC9RZnZNVEM2QnQrOHp6OVZlRkQvVndFOGxpN1Ez?=
 =?utf-8?B?OWZHWlV0amhMcXBtYnFLUW9vYkwwRzRMYzVidlEvNDE0dFk3NlVNem5vYnZE?=
 =?utf-8?B?Wk1aVVJvc0tkQVhTdUtZL0lEWTIvUyswc2JLSHdZQXFQamJ6ZmpYN0VwRjll?=
 =?utf-8?B?TXFtaUQyMnFsaDRpOEJMZXR6ZFZlMGVwZ1ZuY3pKRk9kNEhTb3JNWkdOdTRr?=
 =?utf-8?B?VHJZWUloL0xVNSt6K0FJaS8xZFk1a1B5MmpzbXU3K2xJVU5RZXpIUG1qNkh0?=
 =?utf-8?B?Q3RIdEk4OUhjemNTaEpTZ3hFWmV1cExQV1pETGNnTDlONzc2aER6QTUzRldX?=
 =?utf-8?B?cG1tM293N1BiSm9icm1TcHhxTG5TWVJ4RzRGU3FqQS9nK2xSRWFUeVpjT2pW?=
 =?utf-8?B?MWJLZ1NURXZkbmZ4VzQ3Rm9jbmVZd2ZwUDNqZENKcy8xbFpzK1ZWYjA0ZXRo?=
 =?utf-8?B?QmxZbzQyRUp1a0pMMVJjQTJPMHdBb3BBSmM3YW5lTFVuWHRSZVVFQVJ5NjEz?=
 =?utf-8?B?YllhYU50N1I3YzNZNnBtanJmWE9Cb05OeFJqdFdYVWNLMVpjWGoxM3hDcG45?=
 =?utf-8?B?R2NxMkZXWkNvTUZHYmI2d2krUWNSemxzYWc0Ym1EWFpRQ0ZKYXhQanRqdHdC?=
 =?utf-8?B?UGNYVGN5ekdBcDlKemVHdEh6VGZ4YVBCR0Q3MFdoVXRyMHM3aFVvVXI0NFpC?=
 =?utf-8?B?VitMb09kQXNzcWxLNWZvNDBTVURQVkhpbVVldEpXMlN2TVpsQldyTWd2Z2Zp?=
 =?utf-8?B?aEtzUmVDUnp5ZE04N3hpaEV4U3FHaDh5RG4zQkZSM0lBL3BNRGozTVEzRndz?=
 =?utf-8?B?Y2JBaFRxWHdXbGllWVVsOGdjSnROS1RtQ1V2YUxWVE1UMFRwY2JhaWNpL2h5?=
 =?utf-8?B?QXlhZG91QzlqNEpBQ2NNTEpTamNEWFNZMzdKQU1sQndZOUZwVWx5L3dMTjlu?=
 =?utf-8?B?SXkzREY1U2U0eHlxajFxWEpqQjZNMFIrMDlOa1lFbDJrRVNyMXVNUHhmN0Nj?=
 =?utf-8?B?c2xJVHhETmVySkYxaE8wdHBPUHl4ZWo1WS9uVVdkVjNmVXNXR0hVZUtIQWEw?=
 =?utf-8?B?UzdTMng5dlpieGRSRExialh4NkdHMHdPdlNnT2tUdE5WNXdjWnY4eUlyRXZk?=
 =?utf-8?B?MkJPUVRpdVJsamZ3ckROQXR0NjduWTNPZGNQM1c2bWo3SXYzVEw2QU9rS2pK?=
 =?utf-8?B?QXNSTHZQYzJQa2x2aUlxSGtqSnd3dDBiZUtDSy9IZHZIOEgzZkphWGYrN2o3?=
 =?utf-8?B?ckFFYnA1VWgycklEc2c1UUJKTlhzSUZQdTBsb1RWOVBMVUtWS0FGNHYxSU8w?=
 =?utf-8?B?cWR6eEEyK0dSNysxSlM3WnJwc3lYWUpyTWxrOXNIWTlLdnhPNVNqMjRKS0g2?=
 =?utf-8?B?YTcyN0p3NDBNZXJpUjVsb3FhUkkwcHdxR0IzSmxTUmxuODdGdHRmM25rQWlC?=
 =?utf-8?B?S0dod3JRVzh1SDB0anpnTHFubEVKcHRiaHFPbGJUL0h0YTk4Mkd0L3A3ckdw?=
 =?utf-8?B?Z2w1MUhlQ0hOQ2tBTllqNTVoZ3pBMXlyWktQcGp1RllEaTFLQm5uMmkzeTBU?=
 =?utf-8?B?VXMyb3F6VWxpSk9WUU03WmVDKzM2SmtUbnp5SnRmTzBXc3hWWjhDTEkwc1FD?=
 =?utf-8?Q?7quA/2hVC4YHH16EzCDjWPjaPcudHifq+8Vm/5aDiKD+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1578109D6421524DB25BAE5BA7F81716@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad048241-c2c8-489d-efde-08dc59a0a531
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 20:56:08.0813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4RK1EfcUWc4I+rzIUao4LO0cq/xSruhOttpplIRPwXVj5ciK1bwVnXIExXM/i19oGRnnG0vK9215qk0K0Ahpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_135616_936976_22D91A64 
X-CRM114-Status: UNSURE (   9.60  )
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

T24gNC85LzIwMjQgNTo1NyBQTSwgWWkgWmhhbmcgd3JvdGU6DQo+IE1vdmUgdGhlIHN0cmF5ICcu
JyB0aGF0IGlzIGN1cnJlbnRseSBhdCB0aGUgZW5kIG9mIHRoZSBsaW5lIGFmdGVyDQo+IG5ld2xp
bmUgJ1xuJyB0byBiZWZvcmUgbmV3bGluZSBjaGFyYWN0ZXIgd2hpY2ggaXMgdGhlIHJpZ2h0IHBv
c2l0aW9uLg0KPiANCj4gRml4ZXM6IGNlOGQ3ODYxNmE2YiAoIm52bWU6IHdhcm4gYWJvdXQgc2hh
cmVkIG5hbWVzcGFjZXMgd2l0aG91dCBDT05GSUdfTlZNRV9NVUxUSVBBVEgiKQ0KPiBTaWduZWQt
b2ZmLWJ5OiBZaSBaaGFuZyA8eWkuemhhbmdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+IFYyOg0KPiAg
ICAgIC0gVXBkYXRlIGNvbW1pdCBsb2cgYXMgQ2hyaXN0b3BoIGFuZCBDaGFpdGFueWEgc3VnZ2Vz
dGVkLg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQo=

