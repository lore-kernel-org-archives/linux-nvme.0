Return-Path: <SRS0=5/PU=LF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B5C48BD1
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 01:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C76E61374
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 01:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C76E61374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=DSw+x+qlnP5WwhB20h/WAaIRy90M1fv7kwaF2a94EIc=; b=115i+aZ14k+O5t
	3YmBnoiwYSZMumUQOVNu9TsU4NOytyOx6H6nAGPgPnGjq0edrmjcpl5qvXzsp2guFPPoH7yMy7aXU
	sEbmX7bqG18Op212ILISnrs9ybBC28vbXEmRxpJOratxfcCtneVnDk1VNOhg/YLxRANB7Blnd9ozq
	Gme4TVx9ZiH10C5JWlpuhppStEbjfXCnjDbHjm9aNu6T3KiH2+xKl4EZeFAvw0eT1R3cjipkw80LX
	hI7/66GhkuLFONePd8aWOWrQwdAw78x4AoozK+GqMez4L+0XkdTGPwRBSGoy27SrWa9b6r3y/koXi
	dLwnOgdHw+pO1NQKayLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrWOc-003BkQ-3G; Fri, 11 Jun 2021 01:55:42 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrWOZ-003Bji-H5
 for linux-nvme@lists.infradead.org; Fri, 11 Jun 2021 01:55:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623376539; x=1654912539;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=KDbdNjFzMKXT+ZIb7e1MiVWonMcSLRsTHV1ncApj1sI=;
 b=HAISujbnMIywBE5xJM/YUlytfLJ1qR1cqmGFKAo2CGBonaGatClhAqFV
 4X/mz+COvPDordv6amYM4XpKYQUBJjgVXuYOcEk/HzAEt+asd2f+PcWCG
 70+bB/bfZ+LQTi9ZDFeENNeJ2pSfNBduoQG4//mzQNGOwZ6f6RKxvLYgG
 VvNVz42OZtPdrzkw90cTLM/IBPO//OyQCaX8VD0zoDgjpf36I+G1OXfgA
 hOYfDLhC6wqYQOjR3HASy5gmuVINTRrS4CcRdwzjC11If1TEsd5s5RQsk
 eZwoj+uxhCyP1Qr9kk0sNQSkfFDQQV3Qvp4BCHB2JVlwdoxWumcus+1Vl Q==;
IronPort-SDR: virrtr3WaeCcy0NCvGg3o1mCuSL0Sm0rYrjxrgw83OlVdQoEtdg6G0j4NwGQ/feKh44neBBNGP
 Mr4yPvPwEKqn9IGWF7hXiRBFPWVBOPbj2HNI2KTOKY4pPFJmnUroZGfKchwaUUcfkJ2DSnOpzT
 MC8t3XYx+5rUnCQEsnaMmFfMm3ogPCvYzu6Byo0OUHKKT6KjmYlA9LcSLVVl4be5kooYgNCxSN
 SRLEdGwQISky23xYmb/7Q5J6nD+d8l98yFKcL4ylgsB/Z26UTLGm5XpGsxQVHIUuvXPT9MF/CO
 rdU=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; d="scan'208";a="170806308"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 09:55:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2+TJ2kCHhBL3NlC1Bs+yfCrc7ZTUuBlyR+EzBbmabOciDksjzretks/VsbiYgs7+L86cmVthReIjQ/pUt24DvtmpK2csg6bRcDQ9pTCKLHDUcseaq7c/34Wz4NIx/5rlMHwQ0pUuX+J35QvVkOWozxbSC1xcdSOarq2euqT7UC7+jDAcuzo7xcxDc0OyBen05JHb4dtf8sWKtVHPmnhMaZrdjEB7Z6aMy+As80MgkgBw8J0A5dJ08F3r8fGvfcu2x1iUSNkuscJ6w7LxMgOc28SIRLIgJlUbQrAAbcUrnGpBMqhbUfqL9R1ObSC+pdvpd8YDlvSzj8iMUMJdi/0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDbdNjFzMKXT+ZIb7e1MiVWonMcSLRsTHV1ncApj1sI=;
 b=nDrWgYdh54xanfCJJUr22+4wOvdeYpSNJXmQex61jzkQNVBlwy6EIQkp1G/yufs+Nx0zVH3vj6VxJ7tUwIoIsJWIjruR7VhI5DMDgcBInZquwbNCsHJyD+Y+ibpuS6HOQSK3+Q0/A86Q8eSteUOQfljiSqRgACfogcJY/ZPMV1fqOrIw0tkw3EGCovgvRYM1DHQygTE4D3qcIPTKiS7hO0yuVEXmwLkcFKiisNL35qdj4CdUPc1Y/x4ZjpKlC/udh6oEyriakeRP4ncL3/WHarS/bB/Gb4vbtKM7MWLDYHK2Xo8RnJL5VsFMZ+yFQwZtrzHUsX70aWpE65QzscanLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDbdNjFzMKXT+ZIb7e1MiVWonMcSLRsTHV1ncApj1sI=;
 b=Z4XwBc/79pc8pL0I6XsHrWUm33TYPF76zEAOLlHBuP0pR58xaAkTcIVt354ewnhsCF+z7NalU9I0ks8RnvstrpQyPjn10rxrVzvAj344in+p3g/g6ipN/kMpIRBjGEukjIpbFNsv4AgXOvBUun3FbYQUuQza6cmM7yXRXGYgqBo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7662.namprd04.prod.outlook.com (2603:10b6:a03:325::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 01:55:35 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 01:55:35 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, Yuanyuan Zhong
 <yzhong@purestorage.com>, Casey Chen <cachen@purestorage.com>, Ming Lei
 <ming.lei@redhat.com>
Subject: Re: [PATCHv4 2/4] nvme: use blk_execute_rq() for passthrough commands
Thread-Topic: [PATCHv4 2/4] nvme: use blk_execute_rq() for passthrough commands
Thread-Index: AQHXXkHswx8zN8TijEe6Ft4k0iXiFg==
Date: Fri, 11 Jun 2021 01:55:35 +0000
Message-ID: <BYAPR04MB4965C9553CF9E9303850B76D86349@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610214437.641245-1-kbusch@kernel.org>
 <20210610214437.641245-3-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f851f093-fd64-4e15-4f14-08d92c7c012d
x-ms-traffictypediagnostic: SJ0PR04MB7662:
x-microsoft-antispam-prvs: <SJ0PR04MB7662E25549E51DF53C49DA8B86349@SJ0PR04MB7662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MwxxtH2APkC+nYVPgFA3a+TJjY61B/aOdMaBPpXWzka/yXPgOejPcLjCPlqeEiKXtRdrxJ4o16m+G1SeQ9xTArWjkixHL3bW9bmHaWw7r0eObfjlWqGY79EKmvD2LnigLjOb8oNiBEtPzvY/qVR4NOdws7B7kgmqUaCnzbG5tvfgbHlujBCP0rv2pwpqtnpPbD8v5ei7v3Zb03bJRMXXS0B68jBjSmR2WmRjz4kEWa2690cNeYCQknXTrcoR1b/z7DFXhUTXhsYr5lSuY6bSTp44GWlodeZDUe6LTrRH4nfGe8bmuiRIiN6+WtuN14N2PenJLiPImy/6r4aBb5gIbc+IA3fxG/crLN4tKdUf+INAJLU5D5jE3x5Bcsr6IpaqD3N9rxp+lI9r8F/jB9p5Dx0J/+iBtBgXIixna6e25yi47et7SC4hd3Uj6WsPuQW5ZLQVetDKl7XXJ5vgfW6lyw+FXLJFjTO0t5vX4BucM1g4RQz2sovxcGD+IcU4e16/XP9vRF9ZfRhmBJB3J1fl0vdskYi+/ibAj2fJmwzKSXhzF6ySlEUyTkIojS89lse+Q6zogFQRtTjxgPm3bIPNKzLw2YO3HIkI/l9ntf1ZPQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(4326008)(5660300002)(66476007)(86362001)(38100700002)(122000001)(76116006)(71200400001)(2906002)(478600001)(558084003)(9686003)(7696005)(26005)(6506007)(186003)(53546011)(55016002)(52536014)(66556008)(316002)(110136005)(64756008)(54906003)(66446008)(66946007)(8676002)(8936002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KgA6hWuUiPwdfkaM9UndamL7C1Zsz04bjnFRizA7Bxcuf02FA5o7CLMvbCz7?=
 =?us-ascii?Q?9pIR3I3+VZB4xT662CMvYzTHf+/dUi2o0lhp6vqEm0I7xSn6fBuKYVWejXAx?=
 =?us-ascii?Q?CVtvxY5poMUSSGW4kSe7i1WZzfm6J/PRDYyM78a9Okfb9R/ouPQI0EYjqt1k?=
 =?us-ascii?Q?zTyKGSKcX66k6VzwvVjZgVB3dfxLicaf/c8gnqn3eRUx56cE9DoSeVntFq4V?=
 =?us-ascii?Q?oKCEg6M41fpid/DvRPn0dkKZJkLqonGy0HYAY5EOoJtK0dR4as4wKMAh5duR?=
 =?us-ascii?Q?2YqqR5XRkTr8SIYrQ8daEegEfs5B9uAY8MQjQ0ST+Pqr7bzEA6EaC1rdY9hb?=
 =?us-ascii?Q?GMyrBLBvcZolJnWG3AsrgX6PihbRKJSbOEzj7zPETCmLMD4Bh0RGCFHnxO3U?=
 =?us-ascii?Q?962+b+TzZVaQ4K0OaFG94NLK/7naINd6akVjACOcVtpxW21wnZz3vEX+7AaO?=
 =?us-ascii?Q?y21l/TyL+nugg++dskJmuMmKiCwrE4DcMrQFt2ZI9ctiVM9fLw0wH+5AVspU?=
 =?us-ascii?Q?MmaLHdWHCXrM/6C+wCIoFhMocECoxBbW3g3C1lyeviEjQLMuwCL2p+ivVB+R?=
 =?us-ascii?Q?QNPfucB7QlocjvMMVkozJBBSKkcX6tYagowV2H25kHlBTveJU2GU+z+/Sco4?=
 =?us-ascii?Q?f/dC9gL1N53+qdAadV5Q8+iJOxPipCx0BXlVXSYYaiBaESAdLZLzo6HVQ5Px?=
 =?us-ascii?Q?y61v1KXtbnlJhZbeYBafX53wEk9rU5qduGgcbAnXMQ8LWQ5J8XEbMwqqcvCt?=
 =?us-ascii?Q?Cd0D7zQSILPJotY39OVjV7gEPutnRViofAJXOi8UuAVdJASFRNhswBjnwgMh?=
 =?us-ascii?Q?a05mZWl7irReTc6pdGF37v6983DAAib9nD4VkP3hJVwcyIWoUG1LSkbA04Us?=
 =?us-ascii?Q?0YpEdIfGUh8QEPw6OgW5XxEnIKCsFEa4inAjbI9mnhNGJWtm+75NB3sa+gt7?=
 =?us-ascii?Q?WjGM5NzekfYpSd5l3JNTMIiwd9PU26v5q99r6wVkV3XPWX5IzBPWIFw2RAQz?=
 =?us-ascii?Q?vnrvg/YynKWp3ICx3a7z6Eg4YDg/ru43dG9vw+vpwIW797KKwlZsJkUP7ZRM?=
 =?us-ascii?Q?9jrVrj69jN64hxpH/n/2aCLXAyBJQrkYHJ1sMgB+1TwGHa3sBzs90Q4QqNYo?=
 =?us-ascii?Q?eTo8iL1e0xOvYdYS2aJgXaK/+DuAlVgplYZBGxwMtP7bXYrpfmjBMqriKpwd?=
 =?us-ascii?Q?qTnnAo9pY5GbyzyQ0v/V8sXbY+Tn8qBKimdtHcVEYh3VXJy8sJowajCepVdy?=
 =?us-ascii?Q?C7q3fHM1RNu/RsreqDtemqCfLp8LSurmlAfW8Ec3XRBSAM4XsNGrAvpIf6or?=
 =?us-ascii?Q?KUh+AaQgIYac8ejcRrp3GFcj?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f851f093-fd64-4e15-4f14-08d92c7c012d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 01:55:35.4870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2maq3rp/o7b1k4oGbOUZMYXPDhJbl5Fc5i25hlJJ7MDsmuDJrQqsDccwBlWmT9TmLF2DBGHrZK59aYBNvh2f5lw3i7lZAwrbv64nc1swMjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7662
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_185539_727302_AD79D8AE 
X-CRM114-Status: UNSURE (   8.42  )
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

On 6/10/21 14:45, Keith Busch wrote:
> The generic blk_execute_rq() knows how to handle polled completions. Use
> that instead of implementing an nvme specific handler.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
