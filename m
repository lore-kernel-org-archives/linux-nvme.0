Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D17C47088
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:06:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5987761408
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5987761408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=54o5xzAYo/Aa3zJReHW/2B507ccLA84FM5Qe3+4zWGI=; b=ENTQ98fl64VnVm
	Qr6UvjYTrOT34L2y2Rh6BgYXd7U/nlQs0YwHyx5GiePZMPwJNlYOOWuvsIj0j7+qLgbvgJZBDThOW
	W9+zoSNN/xLMwvHRNk1W/yx5ONvLcmUhOVVO4UGJvN0QuSThWzG8sp+DYxpKOkheAcB6y2b6bj+DX
	PKUv2Awdea483X/ULpXf+AuGgmTAJ3woE3dDOlsJ+AOugfgu37ZsmheBNu7GswzG4K5+RwBxbsOx8
	xBsDQVuZJXyilUwoeeTo2VaxYihJ9he5kkJrHEP2WnVi4z1yFMy9mKXlZO2lEBQ9Ya8UqfKYAIPK5
	T7pWnnmJQka5L23NeWFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lldJd-007ytE-KK; Tue, 25 May 2021 20:06:13 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lldFj-007xbz-Mx
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 20:02:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621972948; x=1653508948;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=x4AajgbSx76OyrfW50Ff/MHJK/fdyX3i1D1+AF7IRgU=;
 b=GXmToLpuBsbpKedfoLa43XUJLVzvm3EmhzKE4YADHhVaz20Y9LhnTHOT
 64o+abW6NgiGlRSA5sclgQrja+xbVa8KHbVRZQJ1BAdG4ZFkpnrK6asZr
 55eO6PYnRt88eq2b9ahp0z+D7yyj0KqqaNvuEoY33Q8pioxLJyn2KQlBU
 BBovTlOUEeyo8GAKzIf2QJa+iBpKoIfDzVDaZ9F4DqGUpMSr8RTLgiDcl
 T5z3cXsqA1Vlkx0bj475hjWyG2Ukcpn6uTBSTZbTq/Jm/mSadzZ9Rt3Q/
 F7BO9ikD98F23lMFgiiEblJGnCr1Cj+sX8FbPMwX9EtrSBESdr5NRqa9I Q==;
IronPort-SDR: ctfIM9snDXglvM/9taeerdJAqpBBuhD4lslyNWAa7ALNvJczeV1Js5ekhot6T19opZ8lbSE3S5
 j1/bD9bPfhHxqxFaewo++aEbCPThDP/f2KPjao99zBbIyhSuKvjlOZosLBUqnnkdTdJ1Tl56+m
 zceExQsQn8qGwYSrBrQZERqlLxdZD2gHduZeNnI4RElbnTtshz5JfhaGZz5ZdXBNNqeJCSNKnE
 9Yo2qUKfiy2AgF7alw5AZqhSRaK3ZRl3Npt1HKRuT2/GpkQlTncm2TRqRtTJPKwCUG0C8Gm3AX
 cZM=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; d="scan'208";a="273306073"
Received: from mail-dm6nam08lp2047.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
 by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 04:02:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1o9Bb4+QnwzJgLvfrHdI5sjicHhfSNskzv1sdtpU2M4r9qHS700lHUaLzKvfh6juQGF6tjFfkCTnz/jpRLx40kJVO3U4ZoiwscyyRQTPvzixWuJlod5EjwrtbYR5/CPgQTsYRMsHAvuZSfFp0FWj/XnURptO3bap+9nwTa3/S0j8zlgLMDf16VwjfWQ7Pxam2q0O2dpB7pDjiZnxLKfWNRm+l10vGGrsN7fq4lsNTMWdFdJzvbi/Sp+AdGn97wLgKKy/fCDvxaD/OfoSOxhgvSyP1CrqpsBxmKDnNpie4c4GaNLgHQpeT7KJ0Nx1LwdK4q+s67ddNyMfE6GaRX56A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4AajgbSx76OyrfW50Ff/MHJK/fdyX3i1D1+AF7IRgU=;
 b=SqO9oNMt8rLfAs8Ui2wesb9ngYQSf05iNhDeyK/VNPWHCNPeZj7vNvUzHDmyDZmSYs7p4xRj7FSxY6fml7kTC4D/KqoTowatArKF8WGVtB2HO+9lA5QXvlX4C4Ey3AX061k+eOR5CGoGoX1Xa26Nl5GZBeeVZo4Kh0LZD8Ix6TLGIkeUmYhf1XSeMYXR+/hg5gD33UxsrWT/EXUEXff+T1MTbMXFeLKjaylJe3DObvCQa6Ckp70sXfjQ4BAnrTGddWrZ3J5RXihNp37RK924ry+v26aBp72KrkS9LU3OABEYNCNJGjKkh6hmIXppz+d8tEL+GdcWlQ4Lz/0OBksXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4AajgbSx76OyrfW50Ff/MHJK/fdyX3i1D1+AF7IRgU=;
 b=p2oTHOEo2t4H8tvtmYQFS0AVNgWpE19GYToNXX4Al7RNmiuw7P70HU03nuGeQyTckpjr2U81LU5Ij297KZNGzIIRAHAF2QVGFHXIkMC7IpEB+GggXU2kwkP7gsvYZt5DaPj3gY5YVTwRTi184xWMEqql5/4g2q3HO7HlvNZJUP4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6022.namprd04.prod.outlook.com (2603:10b6:a03:ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 20:02:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 20:02:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Hans de
 Goede <hdegoede@redhat.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURwhK1Lw0YxWYUGp0t8HJYIa/w==
Date: Tue, 25 May 2021 20:02:04 +0000
Message-ID: <BYAPR04MB496518C475062BFCDAA6326886259@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525141631.GA12576@lst.de>
 <BYAPR12MB26939EE6323113FA9C43E875E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525174505.GA3704559@dhcp-10-100-145-180.wdc.com>
 <BYAPR12MB2693CD60B17E4FCEED7DD5FCE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9595de57-fcfe-40f1-a423-08d91fb7f81a
x-ms-traffictypediagnostic: BYAPR04MB6022:
x-microsoft-antispam-prvs: <BYAPR04MB60227F496D7023E27F3504A286259@BYAPR04MB6022.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xXV5H4h3uc45oYng1Po4MP7zQp1kxUMOQjeuwZ6AMmgnpRzd5Y8WBZh5GPRV6el5cAlghFC7HvxUMzym3mc+HliJg5lKl3RXSbzY6bow9zriDmTVaqRmIZGVBYXdYfJS2kSQ59q7M3VPS8HqpeFwGDtmCUTBro68tztdqd2FZOMhH6S28a4V8GNL42V7tKq1PGBPAhBK31z6u16ELkbUtljilDJtzkD0Yi58PwJrn9xNX/EgAgN2vrfbgqcF9UhukNRdFB44B/HEP4kael2DeUedAerowV5tzS+q0J//OSCt7fDuJ3NUR9lICah2F4jtqB/Kp2zcqNixq+LxSKlHCzBiidfpdwPQ98oEi0QDFvlIRFaBoSuXOnuLrN/W4s+vdQEp6ghdRukSDHFS6g3QwpKALETO6jKvLdMq/W87C0R6J8vNkyRS5q0T8MjqZQIbTr0dwKJtOJ4jYmTW+XhoqLgCLB1dDiXxU+nr71wizlCzLeMmkIHsQw+NcbMBrrwHQ1PlKQvT6cn31dtoXZW7YTLlTAmAm364ZYvPEoNeHTu8E47n2h2w2ptw0KIWH7UA979MR4Ft0m7mODMzfWuslMKd6W7M3+cUi6U9pod92+8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39850400004)(396003)(376002)(366004)(122000001)(55016002)(71200400001)(26005)(53546011)(8676002)(7696005)(33656002)(6916009)(52536014)(6506007)(186003)(316002)(64756008)(7416002)(38100700002)(76116006)(86362001)(9686003)(54906003)(66946007)(558084003)(5660300002)(478600001)(4326008)(8936002)(66556008)(66446008)(66476007)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h9FrxmuJPur57xBNF5l1i5plQAyyWv32yZkJOkwhO7DprOuQ7K4nmHDROVEm?=
 =?us-ascii?Q?VzS4BidFjrKsSxNVkWUzV2M8Y0Z0EBwjViMF/RMOKuxZmv3v+P8y3JPWrGrO?=
 =?us-ascii?Q?0s72qjK9hFvaSQgjoJvIKmiJSsK+la60/pKJMwyVYp+i8+TkE6qOsYIah5is?=
 =?us-ascii?Q?Sk2DI2jTGEu0+RMTWwvYoc5KPg54RuiO3yMPpLVqKfHu6q0yEoxfTGf2F4du?=
 =?us-ascii?Q?P8MvehksTtFDxtrVQ3yTtmyfauc9DBUnol8gzamo4I9c30WazquYH4gGdQoz?=
 =?us-ascii?Q?fVGLrA9EVgMDcwYMOG2ebF+UmObk6tNQg5rerwhAfddEEoCFfU/n1W3XM7n1?=
 =?us-ascii?Q?LvMiSfFV2rqxa01zxs64qNO+CP5XvB5wuMHQObl8JAI9VfMCZj1TpQlRr4Yl?=
 =?us-ascii?Q?Zjdl5BfGUJpitYeVj6e0/rJ4lX7khdAMUGTSaW68msRX5crOYIXght/hX7kn?=
 =?us-ascii?Q?z7SYh5nZWPo1ZNgMsELRGC3ToPHz57yXXCV5sOaZlgnu4f4JgL15QPkUBQG/?=
 =?us-ascii?Q?ZqK0bb4PDdLQgBqe6un6MuVpsK0Wyfv/RdSw0ghnhp90MdZx+m6IVBHdtqlh?=
 =?us-ascii?Q?6gMa0opAeMzWFWsWELRqHKneW3tKT4PaOcHPybaIdhV7UqtahSwMqLOz3DfH?=
 =?us-ascii?Q?S/icO5QMK08lRsnwSOc7oF9yAoQN/TWkUEtbZMm3K/bpBd0rKCvV1VGDqMdU?=
 =?us-ascii?Q?ENJ025NeU7Ou8O4nAlv/1I0uX8b+7PKcT7kkpgX7I7L4KtDCE0siqIBCCBPp?=
 =?us-ascii?Q?E9vmm9SsJ5dHHIJeGEC2TBSHW4wkVb1NQNQqfWx2Lws9GChjGFM2aKwS5mC7?=
 =?us-ascii?Q?uE6qNMQ+i1meXW9lOa47k5rgLbJpmX61Qn5bUyTFRqc6zpA8qrqgrYJ3lGEO?=
 =?us-ascii?Q?WMmPtGIzENgzvpkgH309iFbCGKW0xBIE/66ozZA59RMyeWu+ErGFU7RJXElZ?=
 =?us-ascii?Q?c0gHWFz7msUIwJqlIveVfYteTLhgBon1RfHNF0dfhZep3r8tNRxTatOSjGP0?=
 =?us-ascii?Q?7pWV00nURX9fLcwblpHCKz7IvCraZ4zPVx0M3Cwy7jyPseAE1SidE8wUh/GR?=
 =?us-ascii?Q?VRD4y9/7qIGgpEAHZ+edg8LHDC5L9IoGEF12yB357w460TXQ1f2MGkeM4NlH?=
 =?us-ascii?Q?3WQ9jRaft373bmQguzcV6Lat85OKG8A+qfWzE8ZApzEmE9w1htuMNQHtQeI+?=
 =?us-ascii?Q?nZA4w0HA/RfrFNPJSNej03PV1MA3sQBr5RThdc8Gvob5Mw6QVOCFW7/lubsj?=
 =?us-ascii?Q?OGuoQn7H+s/lnP06gfCWdHSoAkbDx0oS11kFPu1ie3jx3AyV7d++k/xEfISp?=
 =?us-ascii?Q?Hl7VWLW6+ni1PPeOHPLRW4kl?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9595de57-fcfe-40f1-a423-08d91fb7f81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 20:02:04.7539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wPpLnYk/Y//ZUv09pot7NmMvnsAZlirvSvPsUgSvBdKIlCbG5cDJJwh9igVYboArVjFHCRoytwcB/TUoHTe1EqjZE3tgZeQYTap3Ux7mfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_130211_930203_76342F51 
X-CRM114-Status: UNSURE (   8.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Limonciello,

On 5/25/21 11:39, Limonciello, Mario wrote:
> [AMD Official Use Only]
>

Please avoid using this tag on the mailing list.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
