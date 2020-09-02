Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7DC433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 07:24:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532AF20826
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 07:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cdlbLcHb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O6kNfvVx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TL7XmXG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532AF20826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gQ/O5nEsM943n6GGPmAwMQcmYXtt6bGIHMQuu9Uk9Xc=; b=cdlbLcHbhWkBOSN1kuumTOh1/
	ob/KsF0npabDuoJ4h+XMw8cfHG3pZ4TmrNvg98NTqXrzLXF8nTFbuqWIIlZBJ10El6cbCPjkKRy0T
	y87bLRFjXuJyl3u02LYc90937SHzcZwutQ4vux0pXZ0KTM4czTB/CHtblVOGkPJddiqxpBSS2MPzR
	SRNDq3fKFDjOYg9UCzc0lElWJFmC0f8/TL3goOBu+WvxnhhQzbztqkmFfZUBB0wq4Ah4uJEof7/mj
	yAKbaf2yMNKUyjxif7QckIZLfeaptKdrU+xvRkcjrODGysKRQZDyqwDF40V2R6x9kMKrvESML6Zro
	oJtdU3ELQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDN7t-0001zO-0U; Wed, 02 Sep 2020 07:24:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDN7o-0001xc-CI
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 07:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599031448; x=1630567448;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=O6kNfvVxvq0d1tdkQ/K0B+XEvAHBgkXp7Zd4BHV4DWbALhbJihRVMPzx
 FvvSgqs65oa/g8L+96fWQhh70DLl01buvTKAdYaP0Rxhc4B/Xx11Dkatn
 Y4sNPfSuAZBJdg8bGBgA1K7KVFKExKm1FX9OJYbkh2Vc8Bgmcz6ASx+2S
 M5xbV6iqwqsYof9C2ocIlrncr/0znyctUdj+29dYqTnxJsZlZBFVUqWJh
 gDV9c0F4s83cI/dvRZGMg3/NUgex3QtrzLH5tvCYtCgGZI2hNght5H9Sw
 6T6x/1pejUZPD8SYIVrNGKIKy5QY6w/KlUTLCKWjZGIw5LA3fOccOVMuK w==;
IronPort-SDR: +isrtv2hTX26JQ0q3/zFevj3cYgquTQKlbw7m7C8wcP5SYOIQNuX4/Mz6padfKYBNdckR5Wt+5
 JKXZNCAjKgw0avk/uXMUIvm3hRMLH9A9vCrnfBtAZqZlgyRmGtrXFDN9VEsl/8CAx03blSd5DE
 Imk30bgqXTQqU8DXs37HSswd3q7zmKxrVdKJCClVj/uscfoF4xi3lvY2oGK5UR+HPTZRkrTgX0
 Hg477CD03ZxVnCi55vM6tRlbCj7lXGcLG3srBPAI3fVxJ4jnEvUQEhoPOGtO92SR8igQsq1tg8
 14o=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; d="scan'208";a="255918310"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
 by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:23:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNSX2p1QXdYz2AGvoWHDO4OAqUgf4l/gs139CgSRkb/lETLAZB3mqMOTGj2806BpuSspClZ/Nsnx+1Qe0bMLSUtdydSVbrbuTPt5RVzS+rEDJVTkKJLPB3YTNFcC3HANe0tBh0Qalr7zIozvPcQ4+iSvyM4CvCVOEYUEw4xSs576BiPmjfOoVj7AeG88OgU0ug/vN47iAB1dEU/lxyJ9uAyUtHjzIkpAsIaaXDW2YlQ4lZhaXKwcitWUbhEDz6jZQ5mDsNZQ+tDiQQxS7+/aYBLMd58UV6qsC2l4gGGg34WHRCTNcK+dZ3MAWFyjAyjwALgalRO41KXuWVIxQNeDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JdI+6y3iEuT7DoirqzLfHYBQJuM95hNLuSfhxg+tsLzyREGk3fFFACpxzvEOMbPhuETS96xWvj33COrjdKQj+Jnt2ANcIiHfMHLkApRe8gCogY7fvwLoguEWJ0ZTNPeIbNxigKJuRSk2WI1lw4v6JAQ9L79dFoWEhS3AfGQ65Lw99sMmAsfrGstX/63tA9e0sJRVMoeo+c2iOU4Eu1wpcPpC4pDgo2hhOxV4gGW1wuBRBTeAxno+g/wXhNL+UfPD52xeTxt3LeY9yGdhiYWCb/gHrJDERhvz8oKM27RRqiCPJHBfM018kVe82YLiKC7UU2HzSv0/Yj7spOoEtOzwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TL7XmXG9SD3szPhXvUS6n947+PDP59dXLrRCpcLUGaRoL2HYDaYuViGLmvFmXVpp172wMEpt3itlcZfQttgx/5DOok2fzOKBSeUm+BDyqgO0I4Ub4xda5R3ScHdpsiGGXd+xLuie4HgnBWNWokWpAgkc8iU/3o3SqYRo2uQrFfA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 07:23:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:23:48 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6/9] nvme: opencode revalidate_disk in nvme_validate_ns
Thread-Topic: [PATCH 6/9] nvme: opencode revalidate_disk in nvme_validate_ns
Thread-Index: AQHWgHjs6OAepj9H6kWBHRxoz7ysfg==
Date: Wed, 2 Sep 2020 07:23:47 +0000
Message-ID: <SN4PR0401MB3598F740D7978B51F648672E9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5169cc8a-2f34-4ceb-3468-08d84f11223d
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB3966D912E48E8002A21136649B2F0@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XV8PsCfqAgtG6dH7Fd/cIFCOtQ0PRFerIErS5bJEczjQtN3AyUWCKF8fOLfQITrXb9yWGz9v4wTKhLr4LKdcUXOn5yoo9hWSDUtCGJiO9/aqWMGsvs61O1YsASMx01doJ/n+sdcOxy274lcLHgXH1oCAJ9CkqN3itVs1AdTxvmYss2tNjDnQNQ9VyhvO65h2uYn3WRn4qyHcMtT5TqMrF8vdfq75ny1RSRS/C+tmUjyZS88c/yg2kb515FdhB7BOn+M+Y4TpeVj3GWHCaKR23qNUO0kqMjrh9LXoIgcCGTJxyC/bowhBUFT84UbxeAgkFP94gPlo6nbdDpTuW9QDzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(55016002)(4270600006)(8676002)(110136005)(54906003)(86362001)(8936002)(186003)(478600001)(2906002)(6506007)(19618925003)(7696005)(52536014)(316002)(558084003)(71200400001)(33656002)(66476007)(7416002)(66946007)(5660300002)(76116006)(9686003)(4326008)(66446008)(91956017)(66556008)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: wigWMfyO6LvWMMXN3LRT+2lELfzQjDOj+l4CpCOMCAsiT38TcZpAYVbCWCOFT3tFDcWzVemU+84DadVpLJr1j7UZ0A2lFdU+bmRSL9un0LBoQDFFjYX25p5N60O+jsRNhPoiepDiwe6x8YaI/+R7fRfCZzJuGQ8pUABidg34Yk/6i+6jjIJrF06vlYlczv+mT2XrNsS7GhxUloYY4tp8EpLIvzy84YGpou3woUQj5ib4Dnq7MaugycvZy6U2rZvCIcNQAlhftoCnzCvFgdUZ1qi/081TdXJAHQn97OzQv8Rx5TrQFrEtyVW1mehbT7q+twZ6swvfNQJHr3/E9614EE0iSsD1FADwWkiviQ1pfUNGVB4qXkQ8nmcBsOnVsDBjUcLEQIunWByb78w/bdzrPsD3sGH54EkI0m1sp5RhxDgLCeAZgPiDXLZjf+6q//Sxv3Bhj0uVmmT70jnGyoWpSiCuN+quv/53iSPGFFYNmZl/5zxmhSdgcSSDyd6erzcODwloIykeogFQ6O49uCBzRbuDmSdRUDReaeVPlzp2Hlw/XP9oDV9pPx63i9bm/pHWmzxZJNFzyT8i14OY8FQ/GYas2GYRP5kjxrNj+pzrsbENt7UqAOhl4Q51vu2KNRq7x/HT/pyB9vY8es85WtMDavnUPqrYlJKjsJ5NG81UkeoHMFdDiTBVTZ8RAUWD3LXUiCJ58tCHcGdGLf4VAL7DuQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5169cc8a-2f34-4ceb-3468-08d84f11223d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:23:47.8810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ml4u55+yQ2yWUP6xTN2NXFaDG+I8YEBdwduVuzYHskPzLNMDCTwSyKnWyj3CHk49Xbd9xGDmQRxZf2F6n6QOGurMl3KIjjwrt6Fj07jZYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_032408_583681_2EC05B48 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Josef Bacik <josef@toxicpanda.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
