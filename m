Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A83C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fO/eA/swWUCa1OVzL2RMhQNh2lB0q/s2IBzeRMgD1aQ=; b=ep0Twv7vy37d739G81KB/Wd/tR
	fY/70cZaf15lBL/FnTbXXrxZKm1bQCWclsNBKawrYk6Jt6KAt1DlKBfD23TU+G8G+8K8enEJ143ol
	q5tMSrrroXEhpXsVvy5HEOPm5LH1GXwBZqC1WpTYlqQThx9Zetw5uy8lTB8ZJWM+d+k7hW4I/KpMj
	6zeMMXFD23VbY5FiqE5OTrA5kjMPu3g7IPmZHCrRLVJnavDpiS3dkKH8f20zFQuPCuJwpiSRsKJ9a
	I27csD/8w2NNglQ8SjN8v6SEcZLmBA1JWDiW9wYvC2w0ohzmmBqfew3P82GrG7Wri+jP16I426fU5
	6Ya/KJCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGcAH-00AzUP-7l; Wed, 27 Jul 2022 08:13:09 +0000
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGcAD-00AzHt-0e
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 08:13:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBqSu2SKHnfqynBaDSBfATTfPft5x/4mGrO0qJAOv0ip7CQrzFuh3IKNxUgst56APtjPgp0u6mq+WQ1XGZCR/dW/+txQZy4yIQoT6fgown7DQ4RUA7P8o7cUyZ19TRQYdigkHv1HI4Qwj10WsDVlaF0K5XKSDlbCPYwH4KRPBNrmrTNuWIA77sOwbtVI/ANrxwvpr/27MpD7YUQoFeck/EnNkVY+U8IfND11lR4TsEQfzWF63EH2pJzKpcENzTCmMEzEvac1p79TOaN9tE5mhBuS0yrt7VdVdbhh+/XZVrfotIWLeWI7pQW6oi64pxCYntDEJbz9G0X3GwLmhQOnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fO/eA/swWUCa1OVzL2RMhQNh2lB0q/s2IBzeRMgD1aQ=;
 b=caeJOYwNpjgyrZQIGk+qHjTGbuIEprTWwFENKDNun4uQ2TwDtgXtKdKzIRExG+0bm3wio9cDkT4j6AWZVoa1s/ixrsroxyY4S5+onC+eUJXtWWsX6eumu/IIg05TVS7ZsHytJiHAQysoKOTdTyR1TqV4i7XxkJWkITvherJcqDANoGYxuWqI7YEjxFJz7Wd9OrATmSeARPws5ZAbELRBbOAdZd7hESmlEO6jEJCicJeOGVZDjQXZDyCykWzNQQ2zhTFqFesCV4zsKUeZHMMVJGjA9RgXbMZJWMm70CBS+64JXczTaVrYm58/ZAtld2WJhjhMloqLG1sXRrMzk1dEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO/eA/swWUCa1OVzL2RMhQNh2lB0q/s2IBzeRMgD1aQ=;
 b=V+fD4gpc4abHMk0oMhayzgHuAtFCNALdy28itlVPXJ5aFt/5b6uCsp4a8nv/qI7OlZhUpOZzGFzD2J6O/s71gAJbDH26S/JZkneD/NQP6NSZJJ2nQdL0TxdSDYgsKrf7+YhoZkCy3+sVGwz/0q/wudGpUT/MNXOZfiR/NOowSuf9U2xryup5MIkDswqmdVLpMukLG+LLYrJD9c2GmS53AbO2Sht0CRbNuybBEZCfkQScLOefBgKkH1MGW4hHz+3CkEk3V3Kx7mMu3sKjHONfrSr9fMYaJKhWjFzhUhg1smLDqIGdlwIHbS8ozzoygN0o7/wUkbeBskfM7bP5vbNGvA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by BN6PR12MB1633.namprd12.prod.outlook.com (2603:10b6:405:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Wed, 27 Jul
 2022 08:12:47 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::21eb:6424:fbf6:a189%6]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 08:12:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Martin
 George <marting@netapp.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-auth: retry command if DNR bit is not set
Thread-Topic: [PATCH] nvme-auth: retry command if DNR bit is not set
Thread-Index: AQHYoX/7NMtyM06TM02koS257ISQ4K2R3k4A
Date: Wed, 27 Jul 2022 08:12:46 +0000
Message-ID: <e4b3cee7-10e8-6434-6afa-0c75fa11c330@nvidia.com>
References: <20220727061144.54203-1-hare@suse.de>
In-Reply-To: <20220727061144.54203-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58e3b53f-b41b-493b-7503-08da6fa7ca3b
x-ms-traffictypediagnostic: BN6PR12MB1633:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  yey95aK3AwXnreQLcys9cufAat0ny2aAzqol9fTcBx9/FFKoFxytuaWcrV+zVkrmgPS0zhTuYYbDMq58Bb0mL4jVFIDrgKw//rLFAxVjuR65uF2q1qXEOKLkJPcw4lvNCG05j4tZvsZqszBIDFG8+8WMB4rnY25HpoQdrdlW1ZegIW8MHL/s9pK9zf74q27t/OnhS/M0+2y0ajxdGGfg+gEA6TTgBpmXaM8RRPYe874iKnCvAGCWRXy4zgltwenCl6rstCVfKNXA+AJbUKbJsp4OvdIKfPcVcJ9u9Hy0/nBtORnwPljSoLJpFaiv3Ol8YJJaofUCmTv1t0lfOQzHrX3/mRprQYy1ue/4unxXAzxhvwMg033UXKgQFEpc6dvsJpmPpvSh6uns+mYGy4ibW4Cd/F/I5FV2vFwmLD+WYeZ+4d0YTiT6/4zDX1mDrKYnqcQw9e5szAN56O9dMmCrdBSamrnsdo199v8YFiG24sL0B83rDcomJyeyA65HnhlITQl4ITy7Rv5+TIdQXh+Tw9W8KyKOV4kXmoYxmD8gJybjCh+x9k6nRI1IDxXX2Hct1MP/2uf5J2XjK6pFQ9eocDmgD4tumO04PnxMlP8WJtpZThP3MfYxHww8ORPtLsNr5npxLlbFpQ73VEzuOJWsNpoX12pY3YueQFVrvGTMkcdtsJVSwBnpK6ab81obYJQE8FhGFEFpNPIAI5tPW8d2NQe7evu6AQC0Sl4fjziE+PbpFrakYZLyrFAmSBrchGyoORmj6vxgGgiXz3d9adpCGPMakGfXO4GIJ6EHEXWrCil1tJiJrynZ2T0p9eIFiJqxCK81XsYTBzdFsBeLrO0Ei+5WcfGg6yYH3/b8Ob+QvrCGvY1ppBIW3JK4KuFnrqQ1
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(8676002)(4326008)(76116006)(91956017)(66946007)(64756008)(66556008)(66446008)(66476007)(54906003)(122000001)(6916009)(316002)(86362001)(478600001)(38100700002)(2906002)(8936002)(71200400001)(6486002)(38070700005)(31696002)(5660300002)(41300700001)(6512007)(53546011)(83380400001)(6506007)(31686004)(558084003)(2616005)(36756003)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MGUzazRyckF5eDdYczM0UGhBdWl0RjNpNGFDSE82UHQ3L01vR2NtY09GbVpC?=
 =?utf-8?B?NVIwbnkzRUNNR0JYVG8rb25LTGpqdEs5NWRzSGFJbXhkUEFZTkZmNWhxZG01?=
 =?utf-8?B?VmJQc1Y5MEpPcG5qTFdkWUNHL25TWW9XdTdXeU5vc0JYQlE1ZlVBb2tDdHlZ?=
 =?utf-8?B?VjRwZkwvK2laKzc0aUpScXo4UXhOYTFHZkc5N0lnQ1QxRks0TVhhVDVkMUdM?=
 =?utf-8?B?eWZ3NG9JNjBoNVoyc2NFekRGcEZCSGltdDFTcUozV3hKbEd5L1RWZWR6RlJT?=
 =?utf-8?B?dHlSV28vMU5ZeU5PRVY2bk4rbGluVDZvMWdpaWxOM1FSTjNTb1lkTnR5UjlM?=
 =?utf-8?B?VXBETW9JZ0ZTS0ZQSmxBbTZGKzNxT0wwSXdXcldKOWo1ZVJHS0NuUXQraTlJ?=
 =?utf-8?B?MDdFekppWk55VEwyd21wRVVTMTRtWkw5dUN0S1pZbkdNdWYxaGh6UHE3RVRk?=
 =?utf-8?B?R1RsWTQwQjd5ZlRNcTlRYnFuejJDZ2JVdEhFL1ZzdENTQXJzdnRBa2tZbW9y?=
 =?utf-8?B?UEd2MW5OUmJZbUtVVlZUUGMycUMranhJQk5aZ05JcTNuS1NLSlZYb0QwUWxu?=
 =?utf-8?B?Q2trL01wZmt6OXExbmI5d1IyL2lzSjg4eHVBYjZsUUFPK0dKS0w4MzlUcm5i?=
 =?utf-8?B?MUNJN3ZuczFqZWp1VFpuZWdRbVJMUENaZUtNQVpXUDNCT1NpdlBsUUJNSE1o?=
 =?utf-8?B?VlB6V1k3YmYyNjEvWmlTWDNadWJGMngraGlMcUtaVTVYWGVVb202TnoxMXpr?=
 =?utf-8?B?bjdtNnRyOWFNanpRMHZOWnRFcjdyWXNjeUhuekJzeEZDV0lIQWIzcUZobWNM?=
 =?utf-8?B?RHBySVhvQmNNMzA2eWxqcXg1aENwWkFJSmRuTHVFR3I4b0V0cURqb3FhbEFH?=
 =?utf-8?B?YWFkU2RpS0Zac3JTWHFtWm5XVnFiTEFxVlhMdHhkOEUvSmJ2RVpEd3ZNVElt?=
 =?utf-8?B?TUxOTUttYlloaXlUNkIzZG1ITFhqQjBXa1g4UmdsMUJYMDY4eTQzQmtLZGp0?=
 =?utf-8?B?K1dWWERjVjNRaVNENlBEVW5tSW9yZ0Rib09qRElSdVlITnp4dklGRFlneXdp?=
 =?utf-8?B?S2Y4TDNSYWxVa0tlaEllY2FqQmkzQ1RubnM4SlF4ekZ5NEVFaXhLVmtzUDJu?=
 =?utf-8?B?QWYxVVg0ZWVGbVd2enVvZDBuMGxtM1RFSEl1WXZPZTI0eVdpRk01b1lhSzZD?=
 =?utf-8?B?MGNPbmNzekYySjRWUm9tZmptYjJLWE5NSHU5YlpOdVVvWGJNcUpZM1RZSFgv?=
 =?utf-8?B?THpQWEpZZTgvU3MydUoveEVCRE5ZWTdNbERQMTdkVE9qSVZ0KzFnNlFBT3FY?=
 =?utf-8?B?MmgrRjAvdmxvNkZ1RmcvTXpiSnA3WVBrZGRycU9wZW5OS2FDaU1UQk9vdGVm?=
 =?utf-8?B?bjg1WnZvSXhOQmN0UzBKQmxCaU80dnpEa3NaWVl6Zk5ZOFh4NWFJazZDejJx?=
 =?utf-8?B?enNPZFVQdDgzSkVtcExIMHpvNjROOStNMUVWVHhIWVNhajM5YmQzN01IMTI4?=
 =?utf-8?B?dHVEVUJzRnV4d2NOUmhmeHUwTkxFTmwzc1hna2NQdmF6bVRnUkpNQlRUK2wv?=
 =?utf-8?B?TVd1N2dkYm9CYXhhZmR4NFBLay94aE0xcGI2ZkFGMGJka0dhd29iczJBSzVY?=
 =?utf-8?B?b0E4TWhvMlJyRU5SaU41bEtPWWQrMUd3bXZ5aGZhakhUR3Nid3pqWEswM092?=
 =?utf-8?B?MkRWcDUrY3k3MkZvMFg0dmI0SC9ha2JualdGOFZOdEJDdGlQYXB3Q1UySUdG?=
 =?utf-8?B?L3BCWnVwVExpUXNrUVI5Um02SnlxU0hCR1dDdU9ZeEcrUitqZ1FhWTNZR21a?=
 =?utf-8?B?OUYyalBaSjl2dTdZNTcreXUzRy95SVc5RDhJTTNSMHdObC9nWFQ3UFJDbHZ1?=
 =?utf-8?B?Q1Z1U0t5b0VYVjRhNVArRG1DMGx0MThhcmpVdUw4aituTUlKMVY5STcwVHlr?=
 =?utf-8?B?Q25aVDJ2a2oxMS9HSzNMOFJ2bmhBaFV1T1VKYVNVMUt1L1lmakFSQkFJT2tL?=
 =?utf-8?B?WFVadVRVUEF3WVJ3RGVwSURZcjJjbUttZDRMbnl1VE5UWWxuWmVROVBISnha?=
 =?utf-8?B?S0ZRR0JSelU4eEdUckVuMVNkQ1IyNHBwYmFJWHJTemVzNkNBV1U2NGxMV1A1?=
 =?utf-8?B?Q0tEV2EwWEd2QTN3a3l5RGx2djltU2FSVEMwejFtR0w4Ny9FdmFEdjlCZFZy?=
 =?utf-8?Q?MPowNQ1BXU8UYjroLC2EmjDbtU62N5xEutJbW3eB1SPj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1272B5FA56B6314293BFDE92D86C352B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e3b53f-b41b-493b-7503-08da6fa7ca3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 08:12:46.8993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJYDQHVPC6WM4Ld25qlwJcApc4Z9bTsjyJMuUnikdV5VLJK440/HNK0e6LP0wPoHuqzmWlyFDROSQxmQ/F/8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1633
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_011305_249410_441C415D 
X-CRM114-Status: GOOD (  10.08  )
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

T24gNy8yNi8yMiAyMzoxMSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBJZiB0aGUgY3FlIHJl
dHVybnMgYSBzdGF0dXMgd2l0aCB0aGUgRE5SIGJpdCBub3Qgc2V0IHdlIHNob3VsZA0KPiByZXRy
eSB0aGUgY29tbWFuZDsgb3RoZXJ3aXNlIHdlIG1pZ2h0IGluY3VyIHNwdXJpb3VzIGZhaWx1cmVz
Lg0KPiANCj4gUmVwb3J0ZWQtYnk6IE1hcnRpbiBHZW9yZ2UgPG1hcnRpbmdAbmV0YXBwLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K

