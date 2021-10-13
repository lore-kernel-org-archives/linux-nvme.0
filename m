Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B744C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 04:41:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA55610CF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 04:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FA55610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TTXNrU6cxVHmLAOQedl4Qkbi4HuzmTXDAzQ5sW1yddU=; b=4AVgTHCpM8t73C1WapOlJubZC1
	zz88TdQNU8dljmxZJdwPWOklQGPLp55vXCaeCUTXjxuXqDN7zoEs70VvX4VfGU5v8o008NHaAkfbh
	RPAf/iS4Z0K3Ye4+Gb+6tDdTfE11oT1L16KZqxhFhmN5/MpB1mb8+YapsLATgdTWOvUbyz9FETJFA
	KpoKdPX6wcXxcPUo7sbxNAyIc6aHqIGkgwueqZgdMBFL5z0hJ8cov+3RwZe7Nt/YBVmE6mJ9zwnxF
	RTRxwiley/Br5OCB3/X2tqNy8+xmmaULgkO1Q7l5xsUPM4Byr0wCiTLt+e6bJLC28t12/xH8+CIyu
	FGXgBvLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1masYe-001Wq8-4S; Thu, 14 Oct 2021 04:41:32 +0000
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com
 ([40.107.237.54] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mampb-000stf-Et; Wed, 13 Oct 2021 22:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAxSmRzJhWlzGghVWvj8qOXTAQjHJ/5hFbC6bTmNWA+tx58SSiOrMeu6qQW8bLBPNtjTa2cmmgXkMTC2IkbJ/IAnzmhapFC9FDRwFozivK2k2JygBjrI3InvAB/dJPFgNW3URNsmdYvJFaPkDI59w72PhSZakTRPd5ybz7GdIUJ1yFZWIR8GQ0w0OyzkC6xXXOk+2oINWeYDfKtlp9GG7oyi8Krx1z4h1m/4DhYCK0nkKrVCqOevpnKl4LGNy9hhElCFhcDNC0nQiPvdrT1CCxCoNhTh5rh4ABzHFS6nlCLh8JaQh/mVLjTmiPPwNvfh+vJAMGVU55m660NucTz5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTXNrU6cxVHmLAOQedl4Qkbi4HuzmTXDAzQ5sW1yddU=;
 b=bX0LpMAecm6J28xUpm28n1nA8Tvd9FIc2ZXi6Kgh8gLbjpsLzfMG+c2VyqzS2Fz8k5kKoI11h8iQWhTNCUDycMINZxlwk97RjnXDcrXNC5C48NrnZ8DaWmYC6XZ+vnmlGjyRFvKMwq9DKHOqC0N24Kv90XqWA/U7ATCL4+zYqAWuWoceREZKfCyf1FTG4AR8Ng8erlztcYOTgV7DMaYu58HcN1AJOtFNkwvhJ12XOh+IUt3nJ8l52J/eKTSVDHy4gaXZGxWFllPFXOWc6JIVIxakVvNBIBvtilEZWy5eOJuqKJ/ZHm5kecyiZPU09lS3SdE1frhaJ19hddn3ryhiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTXNrU6cxVHmLAOQedl4Qkbi4HuzmTXDAzQ5sW1yddU=;
 b=CfAPPuMPXyWCoM3vgXpGZhyq3kCEqMkyi//a+oqG3Wj2fazqlVWL/8EayqdwrbGninHpZICyqv57PhJM+RFX1iH8x95/jHvgGWlUQCkZd9O/99gRHV4avgWIN9IJNB+WB4CJXRvCRUI78zHAd67IpNRQX6EowcW3bkIoPgPDDyj+uh2b8XcwnegIW6Tv1uDzQwX+YdmrdDlRVqKiO4zgWUAjTgjBrFPUEM+vV+H5gGtVpXpR2YzDvIAnjpao8TQjhHntB/LuMO6vNNsKEJblbeUJR9Abl96x53fGvZ1f9pZtmexgJTFrlXdZ1AaRrdYn5gqtz2am2S2cDTS98iOF+w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 13 Oct
 2021 22:34:36 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 22:34:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>, Song Liu
 <song@kernel.org>, David Sterba <dsterba@suse.com>, Josef Bacik
 <josef@toxicpanda.com>, Theodore Ts'o <tytso@mit.edu>, OGAWA Hirofumi
 <hirofumi@mail.parknet.co.jp>, Dave Kleikamp <shaggy@kernel.org>, Ryusuke
 Konishi <konishi.ryusuke@gmail.com>, Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Kees Cook
 <keescook@chromium.org>, Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara
 <jack@suse.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
 "dm-devel@redhat.com" <dm-devel@redhat.com>, "drbd-dev@lists.linbit.com"
 <drbd-dev@lists.linbit.com>, "linux-bcache@vger.kernel.org"
 <linux-bcache@vger.kernel.org>, "linux-raid@vger.kernel.org"
 <linux-raid@vger.kernel.org>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org"
 <target-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org"
 <linux-ext4@vger.kernel.org>, "jfs-discussion@lists.sourceforge.net"
 <jfs-discussion@lists.sourceforge.net>, "linux-nfs@vger.kernel.org"
 <linux-nfs@vger.kernel.org>, "linux-nilfs@vger.kernel.org"
 <linux-nilfs@vger.kernel.org>, "linux-ntfs-dev@lists.sourceforge.net"
 <linux-ntfs-dev@lists.sourceforge.net>, "ntfs3@lists.linux.dev"
 <ntfs3@lists.linux.dev>, "reiserfs-devel@vger.kernel.org"
 <reiserfs-devel@vger.kernel.org>
Subject: Re: [PATCH 23/29] block: use bdev_nr_sectors instead of open coding
 it in blkdev_fallocate
Thread-Topic: [PATCH 23/29] block: use bdev_nr_sectors instead of open coding
 it in blkdev_fallocate
Thread-Index: AQHXv/UY3+v30jgLpEyzTPRn+nXvE6vRhRWA
Date: Wed, 13 Oct 2021 22:34:35 +0000
Message-ID: <929af081-c794-dd38-21da-32d585680194@nvidia.com>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-24-hch@lst.de>
In-Reply-To: <20211013051042.1065752-24-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a4ae89f-54c0-4ea0-7a8b-08d98e99a2b5
x-ms-traffictypediagnostic: MW2PR12MB2379:
x-microsoft-antispam-prvs: <MW2PR12MB23794BAE24DAC36C038BE554A3B79@MW2PR12MB2379.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hUP331YAayu3mNKM5yn0kE2WHAS16PcbYBgOlfTvyn7XJ+BzSWQ2s7AF0iR/p78/WpYeDM/avouMwd7xHlmxqCokKQ9lADCBWKcYCn1rnuWy5+JdCSTpRzgg7uCgk/GIhD9RQ1QoumRh91VKq0U/Fefi7BzU1/rEfxOxwjpFIoLd+SPJpKQoc+PGKR2jztQFEznOdb07NS3WfuwOVYLRZgjXrnQQLbWTlEFqKq8xluirJEozRhBDW9jL1je9Np0kOOSXiAp/JEgGenoWvC/wo5M1hH/Y7SWTBUk1qrjYAjP154cI4PbeqoJEArNsNDjSSwqFOXiuw8BCxv6vjTCeT5ZaqHNT7LI2w3IY+Wr4v4gOxXCz4+YCicSzUwwNS2/kcw3/Su7N8D7zkQ40dLukutv0o+K3L0ioNOyQTQJ+b/9CojlU8Pikr+ZezSVhmM3hpqDfXUMFAucEkloy8YDnzCIhyc8IKDUwjNWTkF8anKap5cOBD68AgGtB0jPlEZEKDV0XMB3xjS3HEs8BuRUnNY86+P3IPqq5x2s6mZASTZSEJ+uuvcC499aU1TTXswhRXizCl/+UaduEitR66IBgvnMmipNNeURp1mO5SU4w1hgaFHH3ib1TrR6lNSoP/3q6vE+nOZWe5FZEBlSyJd8pQ0OrK91VKd/tsJSJDtQB6cexYmaQAqA+6/IZmrJ21lwSgqZloeN0Ohustp1zulOLDK5IIU1mzY7xEk+lPoy/RSKFS9QYWpkVDGhFtJYrxaxIBL3+hyARGMdSkkUYHi2AYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(122000001)(38100700002)(36756003)(5660300002)(83380400001)(316002)(6506007)(91956017)(66476007)(76116006)(86362001)(6486002)(8936002)(8676002)(66556008)(4326008)(2616005)(2906002)(110136005)(54906003)(66446008)(6512007)(64756008)(186003)(66946007)(31686004)(53546011)(71200400001)(38070700005)(7416002)(558084003)(7406005)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVNWS0xyM2laa1M5RFhYaDJJTFFsK1NONlFIUFVVbVZ1RjgyejIrS2hsZnpt?=
 =?utf-8?B?b1R0SlIzQ3N5MDgzV2g2SFNHWU42VjhGVERSeGxQakE0UUZzbTZQSXJUcFVV?=
 =?utf-8?B?eVR2R2Q3d2ZwMWpiN1VTQnd5TG5xL282dlZOV1lGUnJ1TktvZmU5bEJxR25a?=
 =?utf-8?B?eStFcVVJUkw2Uy9IZmcxQlc2SmVReU94d1ZnOUVITnZpZ01zOGhwUEltVjN1?=
 =?utf-8?B?Rk1WSTlldDRoL3ZncG1Ub2tvQjRYdUFWOUd6OTJXd2lEUGJDSC9NMTRZeWZW?=
 =?utf-8?B?MkxTOWIxUlJhOVZ6dEQxa1U0NytNcEI2Yk5ZZk1telpHeEJTMjR0ZUJidXhy?=
 =?utf-8?B?QnBkaVJIRFY5dEs1NEozUmZmRHF1QkN3ZnhjdnV1N3A2b3kvZ0pXckh4Qy9F?=
 =?utf-8?B?Wi8yM1RiaVhmTnVaNXpzRFBYbHVQcGtYRXluU0VBaHJpdXVuVVA5VzZmVVhQ?=
 =?utf-8?B?ZlpDZUh4UHFlcDlhMnpIQlpzaWluVGZSb0RQNzhuMTZLalhiT3VZVy83MVEr?=
 =?utf-8?B?eURieXVueXVKSytZclMxaUxYMzlFaU1HUXR1WDgzQjlZMVRrQ0VVeGMrSFdO?=
 =?utf-8?B?dzd3SkFKeWJnWDdncjl0YWdkR1NvUU1mSHRSWFZIbDhmc1Y4OUxLVGV3ZGJv?=
 =?utf-8?B?em9mclB3TW9xVmVScDBYWEdZbk1Xa2NDKyszUWIrMXlKdmxhcGllVHN3MXo1?=
 =?utf-8?B?UzNFenBzS3paTGVWVThOZURLcytaNi85VkhHZXJPN21HTURaSS9Ia1dULzU0?=
 =?utf-8?B?bTNxYThOaCtKaW5zK0Q3N1R1YjJnWHR6UlZJREMvQjJEdWtUWTk1S2dhd1lD?=
 =?utf-8?B?a2JoVE9rZ0RJUVRNbG1zb0RURlMzUi9BSldmcTNlTWZ3NE1KelBYdTUyeUxs?=
 =?utf-8?B?d2thTmx0UzJhZlBybSthVWVqcjJWSndMQ3Vobmp6VWpxdUdNRHZjR3VtQVhy?=
 =?utf-8?B?TnIrVHBGWlVWSUVOR3FtalVpaTVmbHFqbkpITDlEb1c2Y2szUEhKY2tiM0tq?=
 =?utf-8?B?bXNROGtBSTRna0dONytIVlAvQ05oNmR2TGFFTFBHb21Ya3VxRzJCbW1PaUhD?=
 =?utf-8?B?SzV6UGpwM0lDZUpPVkJaUkNBeWpxNmp1eDBwYkMrelh5WHZUOXJieVd6VmhK?=
 =?utf-8?B?NzVtcElhMXM5SDVOYktkeFl5S3BrMjBuY3NrQTRHcGkvbjVZRE10dE9mZzlj?=
 =?utf-8?B?d0dqN0xMNStpWUpvQitQOC9RZFhUeXppdEova3JvOUdCSkpQZkFLSVVMdFpB?=
 =?utf-8?B?SEZvd3hiT1lvMmFzMGVjN1IwbitZajBHWUE5U3hhd0h4a0ZKa0xHOXpNU0xr?=
 =?utf-8?B?akFxeW5MRnkwaUh2ZnhKQVZQZC8yYzdxL2NUcnpTQTdRckhZc3RSbjlTN2Ix?=
 =?utf-8?B?cGxxOG5lODYrN3pVL1ZXeWdaVGI0NTBKL3E0R2s0bmlvUG5LQlVseFhJN09j?=
 =?utf-8?B?MzhVRFZYM2MxSXZUaFo0V3hqenExM0NnU1dTa2FpTDRaajArUGFjNHRmeU5Y?=
 =?utf-8?B?VjBSQ3pTMjdhanpWcnpSdTFmZHNvSWRIY3BYZUxsdVpleHVtS09FdVRIRWgr?=
 =?utf-8?B?ZVpMSW50b1ZNZ1k3dlRaQUIzdkgweUJpOUpHbmgwemU1NjVTME1YYzNmNWh2?=
 =?utf-8?B?TXlBZ0ZxdzJabWpuMnZvWjFhNEJ4Y2ZQSkRuV1ROTEJLb0pkMjZjekc3Q0tJ?=
 =?utf-8?B?U1VWWUtvajVZNzVKM1VEekhxeHpxNTJLNFdmWUFxV3VRYXFSb2pkclJlR1ha?=
 =?utf-8?B?cE1DYjg0OTl0UXBHMUZPUVB0QUV0US91di9lRmEyNldqZ3JVS013S0hHbDRT?=
 =?utf-8?B?WHpQSFNBcFZaYUFCOG5EMHJGeGFGeG5wV2U3Z0VON1IyZEhXV3laYW5Rc3VP?=
 =?utf-8?Q?QX0UEnENZE393?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDDFDB2C29E4994CA98FF6A1B819685A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4ae89f-54c0-4ea0-7a8b-08d98e99a2b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 22:34:35.9219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s40RYjePxKgxd5rYX0Q+hYk3Gr9drH2ZRzVjrCzbJepqiyyzRopp15cbaDopGq8+1P4IhjP3ix38CXsymGdTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_153439_551764_AF4E34A9 
X-CRM114-Status: UNSURE (   9.01  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 13 Oct 2021 21:40:48 -0700
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

T24gMTAvMTIvMjAyMSAxMDoxMCBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0
aGUgcHJvcGVyIGhlbHBlciB0byByZWFkIHRoZSBibG9jayBkZXZpY2Ugc2l6ZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KDQpMb29rcyBnb29k
Lg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K
DQo=

