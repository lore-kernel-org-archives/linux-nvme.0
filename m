Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CCEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=SojUIEYqe8cfBdXstKGR0BVYqNq04WIKDI4XcGvedjY=; b=K3goQ/fv1/OCyqTZS2y9puKn20
	OQCqRL3aJbKN+8BzIvfqSkE6Q0kKHReIgthFpvcGPFY7gQuL3Xvx6EzKx2u5QplOWlNmsqQQ79S58
	esY1dzCjELBavTJbBXsVR1yd0DZ6L+n2WyiyFeHrUzqZrjlzAEGIOXbpk/KEG8dHUbuKDEPuOwOnp
	VKj+gSWelNjcA4RxJHbvK/KOYB2peBk3XdRvYSRS34e85gps1QAr1IsPS14t18z6P2f5mausS+EGP
	Osasj6hQfcQdQEKUWkEH8mUWjGEXb6TrDgOTb4vs0kRFXt4WnnL2AluO7hZlJWH7fwOxWFJo/vb4c
	tTNwEEaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr4B-00BuGJ-DG; Tue, 17 May 2022 06:52:23 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr2p-00BtbD-QX
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:51:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1652770259; x=1684306259;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=SojUIEYqe8cfBdXstKGR0BVYqNq04WIKDI4XcGvedjY=;
 b=X5NGqd3yIQ55F/i4wAnaBU/+5wkToK4Z6crM6ejcQq8x0O1dUeEHaYDG
 EOj9aL4fe022a1Pg5s5M/8iQYn3FMiLrL00D+D4074sRLEuOKqwJF9UIf
 ZGm0TphDW4n8yMZiuSMIUEHTgRvkjvD+/YOsOxv5X5B44ou5QxUHkS+tl
 XVtUOhkHXUbqYxXXEbTsrqNHZBUENCInzjL9yJafP5/STvjS/A0Q3Z2aA
 3DQjXzdQz+O+F4gOaM8aips9rZam1HyMU81M741D6ngkDDkTSSG2ENcwd
 m04yAL3Pu+9EaPPaCT6U+/0R5bI5l2nThUiO9qJTOUyhJVKGdIQ2GLBXw Q==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; d="scan'208";a="205395433"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
 by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 14:50:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3yHctORlJQqd2Mc8094MnIqVNi+iyf+yY0kn6yC40UBEAIRZoYGDii3JvWQOUL6+lVIhQYWqRQosT5rCwUfRuiUVGqGHIyeMQ4Deb8C6yxQJNu/8niCDEDdSbhKmXWNaEeZd7XjI7IhTk/LtMQCPtTHRsHkKwrGbra2FiMSlBlbZy2Fkp23tFu0nAV9yQ/xrf8ukukX5XY2KnhA4QAi46uQozAsMbxQ7ZrsZs/s2BawSMNVPHXPaCLOI+HzWiVx8HNJ+CKQCinv1svGhkO0lxEiXgIyFV5bJgZY2N6M1LE5WzJ/nAYBeVlv5oYmhIClmiyG/koCoh2N8Za+joxb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SojUIEYqe8cfBdXstKGR0BVYqNq04WIKDI4XcGvedjY=;
 b=Tp3XLE+LYzNcm5gEEBoucQuvy1JU/SA/Ff1tMb/HwuyhEPuIcprNgmZn+GXwnPS45y2IwrKUpCcZO3zKi45OFeu8mukzIXcKELN+Au2GN7zMTSbuzrKIXImdxbpLe2oz4pwBO6o26sH6P2sQbRbl62t7Adi9bHJIMGdtngGR5W7sTLi8yR25zu2E9rTV2Gc0CZnzLI+aEn5fhYwTOUo/dlODi5xclKVGya5M/QEEBxr5CWZjZ1q3Ilr8VijYKtZuwrHIafZEGCW55ijPMSrYghfYEMNJfCfjVRiIiNfHZv72TqRQlfSwq6DCfPGJk5bQIS3OS0tGyuAkNoSp6muAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SojUIEYqe8cfBdXstKGR0BVYqNq04WIKDI4XcGvedjY=;
 b=dAzsOlhHVE4JrEK4DbzXZ5QrUSBmxBusJbkaJoM9dc2niukuea37c/2Mh6NSlJ3deOcdv3Mbea+hKjDEQQ4bUaVIdxVmKJW8EQ2BBz1wA0WcXJ5Y2U2svaDkpImUK1DO7/F+QPgYoKp6djo6q3nuMsjx6Dy/ZUXmcPgys8Xe9ic=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3816.namprd04.prod.outlook.com (2603:10b6:a02:ac::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 06:50:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 06:50:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Pankaj Raghav <p.raghav@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>, "dsterba@suse.com"
 <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "gost.dev@samsung.com" <gost.dev@samsung.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices align
 with sb log offsets
Thread-Topic: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices
 align with sb log offsets
Thread-Index: AQHYaUWvGG/TZMkJWESbmBi0yiTiyA==
Date: Tue, 17 May 2022 06:50:53 +0000
Message-ID: <PH0PR04MB7416DFEC00A21B533E86110E9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
 <20220516165416.171196-9-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6b3a256-a096-41fc-a1e4-08da37d19607
x-ms-traffictypediagnostic: BYAPR04MB3816:EE_
x-microsoft-antispam-prvs: <BYAPR04MB3816133F9C79F22B15AAAA7C9BCE9@BYAPR04MB3816.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ilEEZpH79JHFziUm8Q4NyZFseJATqR+wtA8xnQ+asOD93BwFwQ3u+sRGho7+TzVDl2Duzb11eeypdNyMgRT6Hrrx9uiqJFUaVuXF4I6e5S68QGnJnlLA4XaEs1zKRpyfpXKm0MhkZ8Op13CI0/NxVA88NB4FZyVVdd+Ncz5dfihtwSPTM9s8EQWDgDuUmnr9F9FVBoySwBSrKZhOxxp7xQyRKZjjvb+wfLCbhupbjQrRIGpRqBXq1rV5ciYf1CGicAgFVt99b8lE+HFxbxpijG32ja73OV+N1G0dFE+pn5ZJ0AUrMDLWU0roQ0I3sqGgGQOxEWfIcWPUxnRbAkVHFJOmq2vusFuCvLV034ndpW2CZQXob7Pw6urlZcgMiHbg0/xvTDuykxevhSCJYd5gzJ3vA5mNS2A9vPaPhMxFbMJD8ZQ2SInC0ZE51yGSCQZBc3bMJjx3Y+AbcZ3rwEEE0m+uAd3hnfs1ZcXEDqJ0XyW6PNa3GGpM+risnoDmIjkv9FMNCMnrduy1CMHG+8Zf2Pe50AB3clAAJILxFxauhJe3n3hvMBe444w4hunNHNSJkETIW6hijrwW1mw0PQ1AQX3UJY3kgBwEfcmpy7P5dFygzNBFrVrnQn9Cr6vuvQPNVD5TAoHK6Ic94hpeyZDrNZkOc+bQSWvdpZH64PGa4RKSrzNJKSR1NpOAfhpdt6cdeT5OxLhuvSG/LwSYE3KwuA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(122000001)(38100700002)(8676002)(64756008)(4744005)(91956017)(2906002)(66476007)(66556008)(5660300002)(86362001)(76116006)(7416002)(66946007)(8936002)(508600001)(38070700005)(186003)(55016003)(33656002)(53546011)(54906003)(316002)(83380400001)(9686003)(82960400001)(52536014)(71200400001)(66446008)(110136005)(7696005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3LZ32nKeZjXeywVwc45a0jMJgEncxtOq8Y6/gge5jVaYLqzmeDqAcZ5eVhvY?=
 =?us-ascii?Q?ZtrC4a2YVcax0Na1WjvSYueRVK1Rhaq6cPLKVHWG0SqrOabK9v0e1PcVpcxf?=
 =?us-ascii?Q?KnyD6Dfsqd+Hpd6jraaUFJToEMBJTyFBjq9cWlGCWy/6Lyaefu+kPS/yR7jG?=
 =?us-ascii?Q?QOwlPWY5cUYq8h7jrrWScHP8woQOklg+aCG7TQhaRq/pH3Z5UNK9BKa6ZiU1?=
 =?us-ascii?Q?qYPmCTtEw5ZFIroMkjNGAsjTMjybZaPkLbn9rqPYgs9WxG+YNr+Wope3hVb3?=
 =?us-ascii?Q?LPo51Zw/akHtv3wI5ZHqGTMXmu+lKvVhcDXneHqu5C8/pCWdg2C/BnP6c3kh?=
 =?us-ascii?Q?UeThEGX/YpSGo+TsV6fb68XLb15TUYh9i6BEqcbyfUP7Kr/OUsSXdbGSq2sU?=
 =?us-ascii?Q?JwFMlMTuvN/P3jHuiVP7UMG79VsqphI9YdcWZtmZ3hQGXit0wsZrk/gk8kWu?=
 =?us-ascii?Q?FD+Xx1SY+XbI/BA1bQ4K8qp/XoaZCwmLNY9cwdKSh0gjzX3fkWGv89ldqwVb?=
 =?us-ascii?Q?8ROsPmMDGDmU2NUj2tlCjeTeLp3UO3OV7Sde99TvdW3wLefLoMf9Qr5tKGRB?=
 =?us-ascii?Q?ZO5zAle7f14jR57UUPPeTfA0W+ZYIiGBrIjtfSNuIFOP3uYupxVmDjzNYDMC?=
 =?us-ascii?Q?zx8OsXlvfX/CeVJ1+wBGSqFEk00VX7XEje3uRDAmxqDW90V2W37/C00YegGe?=
 =?us-ascii?Q?Z6JSWymjJY30gTdsP5XARtw7vhCyvSBYDznPjlAOWI4XSj4km67Cnc4kFcw5?=
 =?us-ascii?Q?Ki/Rytz/YNi8e7AZVYROSCpQ1aT6lTCvFJIbox0fKwx3vt4SiiUWhIv8FV2S?=
 =?us-ascii?Q?S6cohFh4G8GD+5jjhXbAbtW8NYnXH1lKNGC4QzZSaqx4ab8ghdMEh85+PO/8?=
 =?us-ascii?Q?eBWiCUtBkKMPd0QZcUyC+vN7fHuLqXsoBfMMhka8pUB5Yh7VsrdKNjwMajh5?=
 =?us-ascii?Q?D5t02VxhsT3JBqhI0VXpXM+FkhbAgDjPwsNAQx/139YEg1prTvou6z2eve/P?=
 =?us-ascii?Q?FjfOWcctOO/E3pId5oecBpKaOgJWOaXonyF9MDgPJKrXQRdDwPYevBSRDd+z?=
 =?us-ascii?Q?KdPxeY/s5WneMYSCnje7o+6xIcyjvpvhc97woy/e0Kdj0rDaQIcjxZQF3NfZ?=
 =?us-ascii?Q?qGD/nTfgSkPq5+jVWQen4pJ2W68Ccfg/IhrG7Xnhb+RI2ffEvdAZJ6/gyQpR?=
 =?us-ascii?Q?2EA2/cLyOnhADz1NnO3yH/YBOMQ0umvQvO07nkxrJ4HoiOHxUkfXwx4lI3wK?=
 =?us-ascii?Q?PoVsWM4h167VyrpmsOi5abFgBA0KgrP6nI0wvC8OPZ/UkrUs3UEpGKOCoPNq?=
 =?us-ascii?Q?UDzsNvMCAhQuSrZooXSsoNy4+lB2lsGHoEs+ZODrciXOwVjDPFx9chbuB3Im?=
 =?us-ascii?Q?q6Zc7jtRUga3oYmZXdKr79zxad6YEEVX8Y6W41UV+nan3zH5gwKgtPNHjl9Y?=
 =?us-ascii?Q?Y4NcDtcV9ui9VRXDFtuF6/v/7Emh1rBfLCUGxtbs+EJr1nuWsKXbi17of6v8?=
 =?us-ascii?Q?V9wqm3d/mpfqznatSkiTWlBbYjs48SfxzV5IAfsisnyJzoOATO+9SFRoDyjm?=
 =?us-ascii?Q?fhnwY/5Dqx86ESLafSnjrwwPOjTWFOaSBEECIzUtCgfYAnyNAx/5pf3aOU4b?=
 =?us-ascii?Q?52XndwHzXZRDy4jG1apMXSkblA2KzCx6bJi4Qqh+j8+pCQIzwb06YMcbAe4J?=
 =?us-ascii?Q?IADir7ln7T3S8DwK0oeBDd8JMkWhirXKxFX14zTdcsYQiYnunHw/nZfqZfVm?=
 =?us-ascii?Q?mmnrLRTrI+ceNeIVZKO4mPiFKmTFJsQjwJ7PQU1X/NFI6NuaqPo99GJk+azJ?=
x-ms-exchange-antispam-messagedata-1: pnBBFb1WuvaMgZ0F9Mv+JzYTg/j0JU6pPfhVkG/fAqrmhnqv7d5NaSLu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b3a256-a096-41fc-a1e4-08da37d19607
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 06:50:53.0809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPBszXRcKXTXObgPvRC03m/V0GqF+ED729uih601hETzqTRx9MZrV3SOBzbgAl5kh+W8x8F1oRU0Q2qAwj2mjJ18LrKjjONQECiwNmrJxaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3816
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_235059_900211_9E571B25 
X-CRM114-Status: GOOD (  12.62  )
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

On 16/05/2022 18:55, Pankaj Raghav wrote:=0A=
> Superblocks for zoned devices are fixed as 2 zones at 0, 512GB and 4TB.=
=0A=
> These are fixed at these locations so that recovery tools can reliably=0A=
> retrieve the superblocks even if one of the mirror gets corrupted.=0A=
> =0A=
> power of 2 zone sizes align at these offsets irrespective of their=0A=
> value but non power of 2 zone sizes will not align.=0A=
> =0A=
> To make sure the first zone at mirror 1 and mirror 2 align, write zero=0A=
> operation is performed to move the write pointer of the first zone to=0A=
> the expected offset. This operation is performed only after a zone reset=
=0A=
> of the first zone, i.e., when the second zone that contains the sb is FUL=
L.=0A=
=0A=
Hi Pankaj, stupid question. Npo2 devices still have a zone size being a =0A=
multiple of 4k don't they?=0A=
=0A=
If not, we'd need to also have a tail padding of the superblock zones, in o=
rder=0A=
to move the WP of these zones to the end, so the sb-log states match up.=0A=

