Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C0B8C64E8A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 04:17:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC20221E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 04:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC20221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ho2NXTS4MblLpKESOoTOpXruC82Pc3Nrd8tL1zta0HM=; b=pBaAfHi93PS51PKcyt94ikgmD
	qI0s/eVOyUF3B/OqjWDoj+cNhoBDy5V2iuI2IRBJxjNAidYMs7WBIOhv6eCAWEOfMx2PPSxGaFXbK
	9iz67XX+RtLLDAoid/NeAySkEWefYhJnn/VNvq5i+28lapMck8bpFOwKHeLTrFfyAkhtoolRFeHp6
	4vg8PRNR6gx0ntOLvqEjUxLQpQUpOPXBlQYSB1ncEAdG8p0+o6pcsTZUdU9NH56NtQmSoPwCn+TDO
	Soncp+5vJ/9gfumDvTu0H6O9yrS9xvJDtzTZlyWgzlh/yaEyZRS+gUDDF4x7SXaQ9sxcYT1zVigES
	ByEhM66Ug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkJa0-0004H3-SC; Wed, 02 Dec 2020 04:17:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkJZw-0004Gi-RM
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 04:17:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606882640; x=1638418640;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ke7xjwN/Qeqg7QfxZDnKzn9/w2R5beS8O54Onoykmf8=;
 b=ALE/XbhLLViInMfpUmcwZZCampI16HU0J1eogYlhRc6EhYbcC1wMC1kJ
 0EDAPwOP7fa5zkf/e/0OzsGnp9qVBiM+i8MihJoW720AzUNfzTU3FceSJ
 /iVFpE55q/vLRLIDbp0GfNBWqfZdapRLwSRR2AAMBiaxswgPI8ag79wCn
 hbF2kRK5dHKpPK0Vll06gVCSRoe52zhUua8ee1rD1tOK6s7Nj6awMb0gA
 LHjE7C/eogo+ClqHBT32KrThS/1nANeY3nLP1XHcF3+IikC8G+8wVOkbm
 FR4VZpyZw0DDjBSbgbkizXdejHoWfyT6mwGnfAFP77jDK2RLKchQqtYCb w==;
IronPort-SDR: OisK1dzPkRYHpVs3O3i011uEzF1GIhqj5Gl1ngcPMKX0wNeyHIwrnEqj6lB0DEKNkR+/MdFBIA
 dlzG8/qaw8dZVvzGguIixvgDt/C4tgHKBAEgBtHM5Kkh80AACfG7jMTGpfzwWb/ABQSnjbAEYi
 vzijVh2TFs0SQWuXjOQ1Q/Hc+XUsnUPORi8zn1M7dpJ4aH9o7SSg09UO7Yh7WcoKntMUqPpUWS
 A5dVm5ajzJggJaCf7bziY+gbf6Ev54VCtEjT8uPNGYRCSyjunF/akg7kzo3or8cxUj1COHQozw
 U4k=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="154053684"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 12:17:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfUDN2CZ27zECFkF16haOEROpCfslrEYiWZkO82fnJs6xy5k/pPsel1fhTFCwo7UXTYUx07Z+z0rYZN+LdSRlLQ5c514VZJg9Jnwak5YyDGVMnDeiasXRU5KC/400B68bjsj/Mu/6cMTUsMCLkQaMFjT9lIOizqKB/vF9DA4oQFbqBySyqwxAzAObr+QNk+Mp+YxMRDulgGt4iA9wqhIuJuFVFI7QvpxWAyY0eI2HoVyko34aY37rU9UhmAxuJIOXw8x+rKREsoYdH0i5ZLrIIjH/Ge82X1gwheC53E16HO138Rs+vYf87iI+ZjvELt47iEQ/bPwBrHEYZXZhK2qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIBesZqvcYlspZ1AOj1sjvbCBjFUTt9K+BDA1qracZg=;
 b=TKAlznwoT7nCj7UZCYd8TnX/8i3WATduVusFbqs6ulD9HDTAtqn2sD0XfbhgRXd5BVK3Tgs3g/KKkG5a0ZvzYELVg41nO5S3RTmTxR/el6b3Ft7Z5o7IMp2YCLXm9lTG49Sr5REH0AEHgKmb2co6bW/C8RSa3QxQFgGnKWGePR6PR4EVjUxJZdl/WjNVDLB+aNidcuYaaD/cw30FJtXaliqMLPn0nb47sfTHWWeVLQp/nOASpTxKL1PhGWjv2BCwVaX1Eds6htsSL2jwZh/dD/r+/h3W4376pH7lFJtY5KOfYmytq+xEXDwzbbEj372mBY5wZMHj430lANFDCYVaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIBesZqvcYlspZ1AOj1sjvbCBjFUTt9K+BDA1qracZg=;
 b=W9NSyPnIGUbdnR+UAD1VbJZAoCiMaMwV3ReQBrGMdw57W1/WhQL4EsRTN2erDkXuCM8pzNvlG6tZTRnW6KXDLj+ANTf3td/ViwkWtz3wteug7rLT1Dp2uq7JM+jlFHHBsm0yAQFOUPv1l4YFsCFB+sGQf0DEARWBUiunTST0H7k=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7128.namprd04.prod.outlook.com (2603:10b6:610:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Wed, 2 Dec
 2020 04:17:17 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Wed, 2 Dec 2020
 04:17:17 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Index: AQHWx5hxyX5y33697USsRw2vyDa0aA==
Date: Wed, 2 Dec 2020 04:17:16 +0000
Message-ID: <CH2PR04MB6522AD27DCACDEBC04EF6A00E7F30@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522A2943EFDF118FEBA264EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49651C09824B2C82E44DB79C86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:18de:edc1:5ede:e698]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20fe59c0-7125-442a-6bf6-08d896792777
x-ms-traffictypediagnostic: CH2PR04MB7128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB71287BF9F677854813C1A2DAE7F30@CH2PR04MB7128.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XHGif+v6a1FvOrovTfWJV0u6WGphreXw6ANs7J3cEp9FSKFvFmwlia2o7l6mPXcgItebtbApTWBIO6jTbUMj49ndU9FxGsyw65ZZLSeuXl38EockdNYe6+PRZOvjvnVsZvis098j+X4kaUYlakPybsQmRt2sq+cSYs6qefiupMKOT6djWRsN8g72Olvuk0DgUwADwkcFLWfixTM55rWzw9vfNleghucXs/G3zjD3MEyTGHhkatWKR9Gw8x2rwIevgGJqQbjU1Jno8G2P+k6C0ZwmyCx1UiLmJYV5tFIEt/GYE9d0n2jXhIJ6dLWNKWeC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(33656002)(52536014)(8676002)(8936002)(83380400001)(91956017)(5660300002)(71200400001)(76116006)(86362001)(66446008)(66476007)(66556008)(66946007)(478600001)(2906002)(6506007)(55016002)(316002)(110136005)(53546011)(9686003)(4326008)(7696005)(64756008)(186003)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Q4Yi+0Y075A5bLodlhTf1z0Geswsyqi3P7DFGBkG7/qgaCTZvorhkuGwgxmK?=
 =?us-ascii?Q?DdsTMG0sFdmKm8wDl4ib7caj3AQ/jZG90qL+dSaU5g0c6o9qmw4rZLXeU8EE?=
 =?us-ascii?Q?PhF0+RBLAgb9lQEkLj3fyzjjhNp7QHbKOh3jwRmbGHV7P705dIvMcpocp5Wc?=
 =?us-ascii?Q?nz1p3w4gcVBNYu1Bfx3efqadAmKWrQQ8Endx6ErFQ5yluO8KNLd5/3OGtu1G?=
 =?us-ascii?Q?aBAbrCukIo5PBWkx6dATDQVfMFtb6rt6lEocSihzPY0uAzpbKQnz5mrh+2xA?=
 =?us-ascii?Q?+iYvMqIMUcY/BaWBsiE9LZ1ZB0UzIprEl5cG9msptEnlsUNXsvdtYoOnlJS/?=
 =?us-ascii?Q?abfRRlp3hYQ0bwyWbPZNQL/3Q5Q6cwvbXpqNBWN/R9/Ekl3gvF0dtDAd756R?=
 =?us-ascii?Q?1BKiRW/6wIxxMXity6ZlVFSA19nhXNpDOklpHr9XowICGoid6MR81ZcS2SOZ?=
 =?us-ascii?Q?IxlJwcv0csYH/2BA0evNIGJw4tMiUHl0ZbcWmrz/g+ggTHKy9wFXkS/1bbi5?=
 =?us-ascii?Q?fw/fkLsyqIypSjF4XD1t1/Lg8Jfkx4dJuQc3QVinUTeeDlXjHn8pbLlHlCgV?=
 =?us-ascii?Q?dB0OPfEQTG75Z4/niC8ZYtSiLxk6OZtHn1NoJWRnna3ImQcFnfyXZk3esQlu?=
 =?us-ascii?Q?HFi0AFDGLUKdxXycKWi89SRUtfjaun2mBb2mkjUjEjvNxL/3dPBZB+vM6MU1?=
 =?us-ascii?Q?sR+GgmWax90x1s2aGfc38GxL04hmYk0PIR7ygGF1r9DD3oQ4pjankvhxu0OC?=
 =?us-ascii?Q?FXu5XlJV5EtDq/z7PyIU/Jcxtj1C1Wt4qzcJ7a7jwyaMy4VDYSrccT26S4wb?=
 =?us-ascii?Q?RhX214aTQ5f3J5gO8ZyyWkGly7XpN0L6IXB+oEIejSSjycq8JURTodNU1F3S?=
 =?us-ascii?Q?B5WiSpBtYvWsQ7qugf6uZtB7tNEaJBcVbl7+mWbmlur9BPFo5sH4B9xctgv7?=
 =?us-ascii?Q?k2xkEZGUlOKfYanUeXcybRWehcmQ76c94Q/J94MG9yx9PxT2u8IEcb5nHImc?=
 =?us-ascii?Q?n5ERQY8B5pqC61hEeku92zteIEc1HV2vu+pRtH25d28IflgEkCiNYkWANL7n?=
 =?us-ascii?Q?PTcZoGU+?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fe59c0-7125-442a-6bf6-08d896792777
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 04:17:16.8838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8o38lKuONtv6Tb5xWmhtqVQt/htfUm7D3kTbFfrn4wrVjMWx/1DMTgWASIEkK+cm/NE+LsT2Du1L9Y1S8Ab7/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7128
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_231721_315299_26459062 
X-CRM114-Status: GOOD (  13.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/12/02 7:34, Chaitanya Kulkarni wrote:
> On 11/30/20 22:47, Damien Le Moal wrote:
>> This passes for me:
>>
>> ./zonefs-tests.sh -t 0012 /dev/nullb0
>> Gathering information on /dev/nullb0...
>> zonefs-tests on /dev/nullb0:
>>   4 zones (0 conventional zones, 4 sequential zones)
>>   524288 512B sectors zone size (256 MiB)
>>   1 max open zones
>> Running tests
>>   Test 0012:  mkzonefs (invalid device)                            ... PASS
>>
>> 1 / 1 tests passed
>>
>> This test create a a regular nullb device and tries mkzonefs on it, which should
>> fail since the block device is not zoned. In your case, it looks like the test
>> endup using an existing zoned nullb device, which should not happen (nullb4 and
>> nullb5). How many nullb devices do you have on that system ?
> 
> True, my test script creates random number nvmet namespaces and nullblk
> devices.
> 
> I think testcase is reading the wrong device, let me finish the V4 with
> removing
> 
> bio checks as per your comments and I'll look into this.

I pushed in zonefs test fix for this. Please try again, it should pass now.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
