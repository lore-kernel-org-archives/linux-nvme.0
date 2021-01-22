Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA39DC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:54:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE4822C7D
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 02:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE4822C7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=R6VlMXzWhVTAyPK467HJQQ8C1MG8llscmE3bcM6QTPc=; b=yPBEyYvboK2CkQCnRBpv9vnPf
	nu6bz//4hF0HKD3AvdNYQVIS+nLswVKvGq7uOmaKJrYhs8wUCoqUMajU2hGr5/BQNXPLIoSDtG9aA
	mXQaNWALsG/13hSGconI4WP6UHJyOW9v3ZN90d2tdFp2nHp4M1H4k2fUSUEeXhrZKiG70X6I4T6tN
	S3CFh/ydtC/M0+VnSUqWWUToSwTlxSa4949wj6HWbai/RxVQko5g1YuodiIbkTG8PSxm8lExy8ef5
	CwKbYbZz2OHMzEP/oHmcqerqgZIzcYkoqaC7K5Q9yY1UKlxtnNuVDdtmlSk4lbQ0TgNGeJxDk2Sy5
	7/40jzLSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2mae-0007tQ-3v; Fri, 22 Jan 2021 02:54:24 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2maa-0007sk-Pa
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 02:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611284060; x=1642820060;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=s3kX+fUE+sDablctX4d2CDKNs8Y9dta2cZxtUwprGy0=;
 b=rsTmlxlCzo+sst1c9PSybHjz7yMG2R7QMB/4dkj/9Sq+i8xOzzNbU/+t
 3aK2+U6kk1Mld7cIRX0HJpm/TJqNx5yIFwfvimRYl92dFQIOQeP79oCHP
 6yuZrOm7EKyVbzcBBtjQzbRORa/lQ2GSC6SZzP6+0c1AQmdOeFviO5x+A
 wPZketyuWMNRMf96AFeMjjgLh9I3GFBqwfOWjmRVentNKjoFfRxZqwraQ
 Z77ufvsAnpiukedoLI9GgSy9wXOIULIe8oYkQ0YjzBF9dbA7Vp252ACW0
 nnsgVzb7rhNkJIpZ2ZZKBV/rOTlPBYEOnGW3+m+KEHrvzQyOsNuwZcD8q A==;
IronPort-SDR: qZd1dy3EMGkBG/xjf8CAuUpym77FwDAnHD/7xL2U4A4MA8FtZSC0nCE0bBS/fgF293tvAzWkQ1
 iP84I7vn5nsD8xBpunoz6TzmgTQzzUTdl4azvuBWTyYO/bBBI8RMUIHVVUdrNHpAkoWB738Ieo
 3c3IoZEFFuWlOg7+djRAFxaTWemK9EQKovi61UNpXOpFhS7dKQ7vpQnMyzieME8kisNwNfqzIg
 HcxJQMTtsE7wc7hJyxPRa43vYfVDZOleCL0dWKJ6nnWW1icrM04Jp2uWyK3TWi5is8AvyMFp2G
 D+s=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; d="scan'208";a="268380845"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 10:54:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoNeqDieNxhFyMSOmSvA0NWr+/ae9JTIZGrWGFSBUy5VSOjlgP8p7MjK2cNq69Pd/BdkyqyRk6Bzz1ZZZ1DyCKaAMghfBo8Sy9/pOW7WM2t6/7kUxtF8gq61ScQC0ap48MZ70Y43kyXcx27kpi+iJtNuMWgiFvlxW2NGKCYO1L9XWNkp0qUSTJOw6+9ylH5Ze2p4DN5toQtsSehQ5Ix98hPrwHgIM/9nyXHUb9b41ImHuAgQFhRQzbMyqR1ObhPn8W7tz6DqfZHeZoNDb1xX6ib/727C3UMJJ4Xy/rA3nIdRFQHqJB6u4nL0R/jEA4xe2TQwBdeqnTk4eS03Cg+FOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOtcNQg+eT/2J7cTFP3BcHgwDXNGVZAqV1sEBMMwOPw=;
 b=G93FG+QbSloqUYajNzZrpNFF8a+5oVtkKUPbZQC5WazZU+uO7/Sf7tCvE5zkK/2b5vzd6Ltpg0U0gdj4GlsNdjy6FirA/+RWtTUSHqfHbZN3wBOwvDWs7OmJq7iyY/n/COnPSgLxjCdfjzx/PMAfVxCrig4yeEwfZ1BvybzZYiRE4nYEpbQUCv3fMpZfh9+0zy+HrVAS1CZYpvfY77bB/Za+N5fTWkP5zPRAHMirbE8QHP/lvxpOO+Lemx6tSXVNC3jX9gKzDwaRUhT8KPVsh8keHyzBky/bHRr8vYiQMV49gUpynjKP8MC1T6N67Q4gvYCPzWYOcmnZk/xfeUqKmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOtcNQg+eT/2J7cTFP3BcHgwDXNGVZAqV1sEBMMwOPw=;
 b=YhelOgvMwiUzDRWkkEIsaJA0wlaxCFcVnwqAcD+zzwxAJrOgj44i7fNB25zO/o84IZWzO1wckw3+F99U5AW2gZlKLWvJ1xw8IVFzGz0BZTvaisrGfTdzTglZ5zCjFyD/5X6CS0zeaYCJhIGQjxXkXGlinaDbfEyIAk5TiYrhpdQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6898.namprd04.prod.outlook.com (2603:10b6:a03:22a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 02:54:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.014; Fri, 22 Jan 2021
 02:54:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "chapman6235@comcast.net" <chapman6235@comcast.net>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7QO5MtNnJXjl5ka4VClzrgzGFg==
Date: Fri, 22 Jan 2021 02:54:16 +0000
Message-ID: <BYAPR04MB4965CCC3F7FCAEE6C0A60DFB86A00@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <96083ad4-e065-c071-bdc9-67517dc1e5a3@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:475:2d41:83ae:3ed5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96d577be-9665-49ec-c9ec-08d8be8102b7
x-ms-traffictypediagnostic: BY5PR04MB6898:
x-microsoft-antispam-prvs: <BY5PR04MB6898C8E401664E333030286D86A09@BY5PR04MB6898.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b+j7bi/cAhTS09W5FdcvdaOmGKo2Ypn5CG8ir4GklLNdXlp5qffLT3zAlGaEnr/6BBuLxFrKm5TbCPcEKkW3HlFqEQxv0SNiDnQz8eYRLq++1HpelJTnDtuzDtlmeQaWvmX50cyt1kcD9eHMmY4djtkCe2owxJZ0sX6z6XSE+0R8muG+4w8W2ysK4HeJgPUjCEhktHDVcRYZsZUcrkJHQqpuRtuBThsE09XcWavaajju74aWyLOKvcYgWyPbbOA1V2ZcAIjnhdP19zW34vtecEmUyrpz+hjag99Kysv6qw3uRfw6ohyxpsAaE/SRya6Ls/1jwUdyFWMM+mLbr9mVbOeH2+/jO/t+BHYg5KjwURSh2yzgcVYiILFJLwbyY7bp9eLvuUvtTP6iy+XJHgQnVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(71200400001)(55016002)(9686003)(8676002)(2906002)(86362001)(7696005)(52536014)(5660300002)(66556008)(76116006)(66446008)(64756008)(66476007)(66946007)(6916009)(83380400001)(33656002)(4326008)(6506007)(53546011)(8936002)(316002)(4744005)(186003)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?X8wH0rfoh7ewZaHzPPxz07HJ8fHWrrtAoadH6IDHFg9i/Zmuwwb3G/lVYbuK?=
 =?us-ascii?Q?KmM+p3zMpbvFp6djTo4b/8Zq3KDcyGW24jw6xrT5NAfsrLfpgCDC1faz1+pY?=
 =?us-ascii?Q?svayqFQY/K7uqN9cHWjDPQ9vdD2AbRLmgd0w6WwNEmy7ldEWAtxd9xdvfLS2?=
 =?us-ascii?Q?QeBHbwdm5dXSk5MhDeeR7i84m5SkGaD3Cd8Mj1Naub+Lym7RvHO3kbNXbZhD?=
 =?us-ascii?Q?kVl/2nEn+h2YwQpIP4HXOsVvGUcH19rf6SPEapmd2vbK1IRlkY1jkVpikuy1?=
 =?us-ascii?Q?/dtGMxAxb0QaDg22MkcdlIGZGPOxfr3BYTPaRyX4rndSjebZui9k9Aj5CtD4?=
 =?us-ascii?Q?jLorODQy4WcvpouRuZH5f8++JQeHX7KRonsgx3NcpRF3hvnpAzp5CtP9WVlB?=
 =?us-ascii?Q?zGJ1S32SLotQjCT/5BrI7c/BCBtcj4ftGBoyRp3Cgu3LY683eUNpyPNa5bJ/?=
 =?us-ascii?Q?ibBXPlNgkjVQe/9Q+ggQCmDohtPsBwWsZ4cm9uzwzeu7ybsWPHTIzsVqpi1+?=
 =?us-ascii?Q?BmWZiyLys5/qahgwylhZzcjusPvpyaDW6lQUAwbmyQTiYlfIiX2sK/zuqMwg?=
 =?us-ascii?Q?URRQE+CjIbGe91NUbCejoBBFD8HzdtGLeDoCT0Hs+85RbKxbjTXX5rr5y6Li?=
 =?us-ascii?Q?7twotwkW1L1wzWKK4Q4jWYB1A16xSq5DbLckzr+eibG/gj0Xo/RYWPul6CQM?=
 =?us-ascii?Q?B2/Q+pCImbeQSGZQmxQMgt5fbgsgDDHnFgrF3J+kp/ZP+Yyc1Li0zGimBwHL?=
 =?us-ascii?Q?c2bWKQ+5ZoXWPSGrmm7pYr3sMFY1Z192k2Ni8bbIosNGuKGrzT9KD0b/da4s?=
 =?us-ascii?Q?TMb1bzhX9EJKEFGm/msShm9T2hyl3qOFIy2A4B3T4Sv+AhYK+x7lDiWx1kf8?=
 =?us-ascii?Q?az+HwBeWRlECeJcfg/3jzC+SXY5iQKPIGZ1FWnE2YTmIMW5TqXzJBgh9YIXa?=
 =?us-ascii?Q?LrgGT9miN1ApzqMJpFAz68xYnAMg0h0F3NcwB4LtZOOc/Ph3h2UA0fcVCBO7?=
 =?us-ascii?Q?Bt6LeyLrd6F2IJx2DxQpGjOmN4YxXwnW+EYw+KV8jXs+vRl1KzC0reXx924A?=
 =?us-ascii?Q?A8GXExSS?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d577be-9665-49ec-c9ec-08d8be8102b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 02:54:17.7714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/7iT62Csn+RCoeHnC2Ooi9v5tif2lZHmwBXZGNUveIXaQtCUiT+p/DHybguRNpYNEs15qV3rq+uraAxod54giCtDkY1Rw7h/u6ToCCo6/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6898
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_215421_143447_93021235 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/21/21 6:32 PM, Bradley Chapman wrote:
> Thanks for the pointer. I've downloaded the code and will add it to a 
> stable 5.10 tree and a 5.11-rc tree and see what happens.
>
Please use the latest 5.12 branch and boot into the kernel.
If you can provide device's vendor ID and device ID I can cook up the
patch for you based on 5.12, will be waiting for your response.

These IDs can be found :-
cat  /sys/bus/pci/devices/<your device id>/device
cat  /sys/bus/pci/devices/<your device id>/vendor

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
