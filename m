Return-Path: <SRS0=c63/=5G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A21C4332D
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 00:43:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4272070A
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 00:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bTALwImZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bEo83mqE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZqB6pmju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4272070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=M8hE3AMKixy1+NXRQPw3xtxHLQXyg1fcMOXmOJXdB44=; b=bTALwImZgIO7fk
	1eQ+Mh2SGhicztolMf3lNukp0V7R29999Bag+s69pE6EU0by6mM/f2CxpADAEX0pEJpCcaA338Z1r
	32MolSUSH1kJ14kxjtS5CHZ8SbKDWEa5XZEIu2B/lp5HSAMvzEHYM0yixDjpXuZerulHHnm3/DYWi
	0LuBW2iDLgq7mpRbgpDjcvFAKlGFliSI9yGMG/Iy9tsKhBxRfbeJcgvivYbBqmL8yE/dkgs1zN4mG
	OZCObu8XmVT/8gumkyrFX43koDyQ/TYAU9mELRTo7YHd7Q3krXeDVc2E1dCFv+KAj8nCS2xT/jnha
	1xEzDtw/hMBHFEL+5TKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFSEt-0008IM-8g; Sat, 21 Mar 2020 00:43:47 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFSEp-0008Hw-R8
 for linux-nvme@lists.infradead.org; Sat, 21 Mar 2020 00:43:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1584751423; x=1616287423;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tjaeahou/CnXSrwjut3dNMM4JtjjU36DzYnhydO+LRE=;
 b=bEo83mqEq31NwgVK9RfAZwCUY8/KaDmJfLyBwVKdMeFr+gx0OLPZY/5K
 5L3czsyxAZA4iLSn7N9rBjj1Qe8hH9k2Gp3phXBErHgZXcJ7Mh5n30wyc
 1obdLr7vI4foWD4dQ25CdpxyBDHhamt2zbxw25qhXf0wMUO3/q95eQBwt
 YUHwezv9r1jqLtUcoFEkl8vqp1l8hVMrQHJus8qZLg07eeRt1rLqCvJmU
 Xk+X6O1s0wqEYMNqmCrNMqfdhn+xUt+XbWgGbB6y+/uLrIa688jQCWFK/
 YhQEW8QculxHmmaAvwOccQ4Gyxzat26OlT2mQ9NKo4cmEb2zKwqdqZa9h w==;
IronPort-SDR: y9b3oBPYbOs5r7ROLLXMVCP2M+9Vf+YSBZN29gu9KEhyghrY2bCe/wgkl3FHcaT3EGUlwxDPrZ
 RkQAd9vfwOFP1v2fW+MhWXb94HYVFCACfar/xnMARGQDekTID+bDQ/Gzig8DpYVCcHjl2tRc7P
 Oc/XPkxq8tLh1+yec5h/L3dTKvvUjOEL3Bk6XEyyZVfOzbwexDGVsyV5GCDRujNXXyWrt9DhHL
 UPuHusT5olVcTQTUAhELoWV2HlFr8dyTU8Je3OsRJiWPe3eyjSrVu93cUFa2C6FUeZeMfGMi1t
 UQ4=
X-IronPort-AV: E=Sophos;i="5.72,286,1580745600"; d="scan'208";a="133106678"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 21 Mar 2020 08:43:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQpUV5ZvROfe+6cE7GAdUPPIgk9+cjZfkRDe188xZbM9XsH88sUhww7ShGYUKTCZL59SbtN3g11FN86rRl0z3aI87ftABbMbymIy3ImZC2u7PTUqbLa1xbF2mXvnYWsymtion5qPj9ZXFBGuCyVso1WtJ/AQkZdAhL+s+apTTjJ1avTbftHRfgNBwauOtbSNol5Rj2yhusFkroXHuOPl6zcTCS/gpB+2dPq612yqgHHdsFW1a0x6i1YxjRu/TGw5Ik9EyrfIOX/k69trDijBXMQ9UVDv4SR9kVj/zBpk57BOjwoqVWHm/yshms00r9q7R3LkpLkulNfB/f0T9dWlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nQ/+bahJ5ENLZbMILTexKzhUJZdiwm3E3ygOQL/sXw=;
 b=eMzKlL0jILdChCrGttQyOBOz6w4jXKn0SWNqztIvwhxMZVerOFKL54rxcuL5pJKSvzEoYNKfA0gV+tp6hUjbmFflLTLKi50mGn9YGSxg2UedS5SAUebWVaAKH/zD+MeK5XApT+8AJf4gMIbODeyyklAAa/59UduVPNXwjSbyXWPmGr9Gg0Idpr1Q1OWEABx6oWchpPoqFiIMUIrFUnuDvCyFkSqKzbQC8ypXA8Z2lgW9zQWxd/G/pzbUCm5P5nK+c6hhYuST1e6H7/1kpUOsrNduKmFzgeZG5GiOrWHCWczpV7M2jqGTv0Q8TgR6yaMOEsSEtvqW4LRtKgMffyP8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nQ/+bahJ5ENLZbMILTexKzhUJZdiwm3E3ygOQL/sXw=;
 b=ZqB6pmju+dIqWev+K/Xil+ZGnIwf3volY/mc7dukS274mSA5wJdGCebjIUY1/o4K3Q96HwC0oWUjLG8UiIdblfeipkrU9qsqA0XAnyYch2cdMFgF/X2ba68+3nfGoqLpVP6dmTW7kb/ix7Akk0un1TmRgJ+hv+Wp/E6yLIa76Gw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4534.namprd04.prod.outlook.com (2603:10b6:a03:57::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Sat, 21 Mar
 2020 00:43:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2814.021; Sat, 21 Mar 2020
 00:43:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "tasleson@redhat.com" <tasleson@redhat.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvmet: Kernel oops when doing mkfs on nvme-tcp device
Thread-Topic: nvmet: Kernel oops when doing mkfs on nvme-tcp device
Thread-Index: AQHV/v+4UHRulWo1ZkOrantftUuKDQ==
Date: Sat, 21 Mar 2020 00:43:36 +0000
Message-ID: <BYAPR04MB4965E360B649BF0EB0D1BAA586F20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <17c25d8d-0dc2-9dc8-2b65-954034c23646@redhat.com>
 <507887d2-96dd-b0ee-bb05-519039d98359@grimberg.me>
 <f18d9173-b94e-69d6-022a-20603e8cb42b@grimberg.me>
 <7b56c65b-40a3-0172-6e42-7158fd88361c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f16a30b9-f1a7-414b-5bab-08d7cd30e45f
x-ms-traffictypediagnostic: BYAPR04MB4534:
x-microsoft-antispam-prvs: <BYAPR04MB4534B717AA8D21B0D095B54186F20@BYAPR04MB4534.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 034902F5BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(66476007)(66446008)(64756008)(66946007)(76116006)(55016002)(9686003)(66556008)(966005)(478600001)(33656002)(86362001)(5660300002)(7696005)(316002)(110136005)(52536014)(186003)(71200400001)(8936002)(53546011)(26005)(8676002)(81156014)(2906002)(81166006)(4744005)(6506007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4534;
 H:BYAPR04MB4965.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w24386AmSHWVrx5eZlQINX6JGcS0JWeSEyqnad160ApkEEh3pdrZ11ZaSDZs2UbyE8wn1kb3a+G4g1oFC6uTOVSoQ5jIByJhXrDpJumDqI4gBWYzfzOIieB1mG+GI8fmFr6iU0W6yXgoTi+DTvDCiiczHBbZS1DSVn51AIsd4f2cK5oos8veYOeFMLpSJ9ExxkCsjoGHmN1bcgxd8Fh2N9h06p8Wx5zo+BItWaCd2uh5I8dEKCC/d7BmyBepYhBztgjjrvPcSTEDdr2BnDIFCjA9rsWMgPG49/Z6ExbRmKdw3UfKTY6lPXde6YLn8SwKYfa5fXizO3qYKrboDJG66/Bse4xkwf2sTmFkcBeuHLjcQlDeg23ExcpnqOJYUm5whZcVGJmmIIgj3+VtfTFMNPkIEOL2sghEAzeejtdgrP1ZAq9vIREiK5xIbHXKAbwh1o3UDN7gLVgQ3jOj6JMyeZamFT+jovUzyqmJQLQ/Lu2Camj+Q04Zf5z49jsu/0ufQ5QJZps/6rzGhAnHamgyJc3Ollt1qolT7l8E4PJluFluNwifQnfs/QkHwQoDHm8cuCJHumo8YHnDXnR+FC9XNA==
x-ms-exchange-antispam-messagedata: Wkyju63GFt3GZroZI1rpHDJe6r/nBC2KEiwjl6oaOwNoEHzjcX4BbsFSKiAmgepPXoKXsUA+75N2VGN1Jz/PsZzpj8jMqfxVaJIHiTFb6wG209syDWYc616BinvqNmlr6xzn1cpd1FEO0oqsh26G6A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16a30b9-f1a7-414b-5bab-08d7cd30e45f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2020 00:43:36.7824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qp7J7qU2RnLFB9MfklOBmgtaGDP0x1f883EcpWdlefY+y/XMe+fFOVGP6Xazjo8ZtV0CCTQPs+dD9tdU30Imbr1243xkDRZJ0Eqniis6O0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4534
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_174343_985465_EFB1081F 
X-CRM114-Status: GOOD (  11.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/20/2020 04:46 PM, Tony Asleson wrote:
> On 3/20/20 5:59 PM, Sagi Grimberg wrote:
>> >Also, does this reproduce with file backend? I'm not able to
>> >reproduce this on my vms (running KVM though).
> Do you mean a loopback device using a file on a FS or nvmet using a file
> on a FS directly?  I wasn't aware that nvmet supported a file back end?
>
nvmet does support file backend, please have a look at blktests [1]
under the test 025 in {BLKTEST_HOME}/tests/nvme about how to setup
target with file backend.

> In my particular case the VM is representing a block device that is
> backed by a file on the host, it's not doing pass through.
>
Not this file. (which I think is VBOX image attached to the VM).
> Thanks,
> Tony
>

[1] https://github.com/osandov/blktests.git.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
