Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F265C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Apr 2022 10:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=; b=Rk293w3zCOfs1sU2xaaK8ma8cN
	POiUOHQaY5SfmEa4rnEHgoKSNEdpSxjybARui0XeLiACquuzOCAlCH9ybCzp17V35fsJGrwwZy5qe
	d1T0L7oyTUM952XSTpiHM8Wjbu9f0FTl24vErbjwHrjHY5qaxseFoJFIbFeY8BvUmokQ3gfXUus0p
	h/DuBfkFli0+liCIJlPI0B8F6lMwknHJTgdd0idszq0kG4xqy+bULQImKxa4Olit8Wzz8kCweJTpJ
	nQNP+IkJEozxQjuYP9TmHZ93kM14TTUxnnvVTBgjsB2ItJ8igYDLryl5mtxhl10rWbIO0X4xMQtnq
	a5+IKB4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nc2ds-005H38-H8; Wed, 06 Apr 2022 10:12:01 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nc2Ok-005ASM-Rl; Wed, 06 Apr 2022 09:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1649238980; x=1680774980;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GkS+xzueilI0QBIEHA/6XoNI07E9i8Filud6BERZ68OmXhwsnUMIZbFC
 0vC5SJ08yQ5v+I4JQGqq5x0nowIF8H870FS8fB6szOLCB+vb/cUIFnW4u
 MtfeFx3ZG4EKH1uLmYygQr1UgyEEjFbGPMbJYhdHfWzKulEpeQmfBsWOH
 NxRp9doxUJOApMwB2bftju4h4dQeEOnz5CJhlp6DQ8G277g++jaNzY21i
 txFeqLV1rCIkLbthlWRYwED0U5eFN/B0KlQ9yjsvLKEL6U4oxh6YPoNWL
 8C2VB3tJeA49Ok5lJiXIbfVRcgENjFfxA30qig+SGhCujI542W/M195KD g==;
X-IronPort-AV: E=Sophos;i="5.90,239,1643644800"; d="scan'208";a="202070882"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
 by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 17:56:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V05NAY6D5JNITXI7Uynm69uEjjVcBnSlpyCo87ZK+7VNb/vNpbU/FGi3Zm4n+QsXvV1R2M1mgUcaKgqXWKOBs2MmOnPHYOx0mf5YYQxnoM0AvkShgu1SyoboY68Dx2zKl8Uf4iJOhncIA6vDQqIJDIdaFpGoex90SHXJLbRjto2Ef1HuPvBnk7DYH2DSgjpEIal8qfyhxm7iPcopbTERi4WlXQFT79jCEr4w8lN9FM/RSSqMKtf8VRPLa2YJcz1sapScY8eXJVZIAqJjsQ2RMIgmspOZD6lvtMEO9wHdsTMzcimJpOVt4KtmbfYaKSPV+mrO6yGHsR3rAIS7Kia8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GjJh9NCq/Gzn6rw2u6uDpjQ6iYwYWd9FZiQMYL+8Y7mbz+iUBERKxG8T6yP66B0dOfFFO3vwnwjHhL5cJ7a14/ttIVmBAsA2+Jf88E3WxyK/Iwt+gdPSl1hZzqGnhyTvPOGPa3cms9QugMUwvUl3E+fV7y9d3Vf8fvQQLly8o1BfZeop4ARAM6/koy+tRR4xEkvdn3W9PV2LAN97amtjDqfLzQJdk6A4uClpSTUQwWSKzDOf+30fisQzsnMASBz0qLgsVwakbzxZ33qMj0NcGRFCbSH5XkhyUqip/aXo9Vx4B9O6QU5tp244DdVW0Dp4N3sLx3xdz9wP97RhrVKPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=h54PSavZiCLPvRz23Tg4lVZ4eo4TKNMgHAWOAetI02cemxA+lChC4jRXXc8PjhI9PpOfpk4p+MbkbZh9C5rjse+BNktIEqyQrd9A+SZwSDKo/qziD0BGPaKZXMgxzonamG8DYo93OQ1hSVvzQSjS+8JMtRvaZ5G9kcajf+Hcwbk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6607.namprd04.prod.outlook.com (2603:10b6:5:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 09:56:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a898:5c75:3097:52c2%3]) with mapi id 15.20.5144.022; Wed, 6 Apr 2022
 09:56:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "dm-devel@redhat.com" <dm-devel@redhat.com>, "linux-xfs@vger.kernel.org"
 <linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-um@lists.infradead.org"
 <linux-um@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "drbd-dev@lists.linbit.com"
 <drbd-dev@lists.linbit.com>, "nbd@other.debian.org" <nbd@other.debian.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "linux-bcache@vger.kernel.org"
 <linux-bcache@vger.kernel.org>, "linux-raid@vger.kernel.org"
 <linux-raid@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>, "target-devel@vger.kernel.org"
 <target-devel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org"
 <linux-ext4@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, "cluster-devel@redhat.com"
 <cluster-devel@redhat.com>, "jfs-discussion@lists.sourceforge.net"
 <jfs-discussion@lists.sourceforge.net>, "linux-nilfs@vger.kernel.org"
 <linux-nilfs@vger.kernel.org>, "ntfs3@lists.linux.dev"
 <ntfs3@lists.linux.dev>, "ocfs2-devel@oss.oracle.com"
 <ocfs2-devel@oss.oracle.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 07/27] btrfs: use bdev_max_active_zones instead of open
 coding it
Thread-Topic: [PATCH 07/27] btrfs: use bdev_max_active_zones instead of open
 coding it
Thread-Index: AQHYSZhFjrFhkOtPTU+vji2wK2+0AA==
Date: Wed, 6 Apr 2022 09:56:17 +0000
Message-ID: <PH0PR04MB74169FBB31E68E76E34DDAC59BE79@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220406060516.409838-1-hch@lst.de>
 <20220406060516.409838-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcb98ed4-cc62-4a3f-8a01-08da17b3b1bf
x-ms-traffictypediagnostic: DM6PR04MB6607:EE_
x-microsoft-antispam-prvs: <DM6PR04MB6607721F18B062BF57BF16C19BE79@DM6PR04MB6607.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nk2MJlm/r7uGtMIckrZ8/20DB84cHxXsyMPbPfGUVCbeLXDLxGaUBQM+iMbI0TIDMo8ybZcbg05B1l9oYxnCRDXiZkCfwL3sn98KZz49BhXqro2r1QD7cS1mUSAk52FIyznZ4v0Klb7TdN7t9KQcVo5GmjUcoyVro/T9NgdLhj55YUmzdMDKplWtvSR6br8YGC4S6tSCcTufSCuVvWT4UQ8n1zjpHCFVe4BHJ9HrIIcshXSnzVylfjU4RVUlTcWWznKi6E4q39IhnKk5tf0BjqmepnIOk3fA/n3MYk5dt47VBb3YFRTpkcX4/AFxtQC6VeUbKz9kKrwIxEi0zkZzLqmByyavkn9KDz7K1VUmM/IBgoJr+SdhhFpqcVBbjI34GNuS4i+tZ7mVmk3cHDbtKp8ZKZQB9EbL4QTCET7woB2SFLYFet5MlheD4eympyeAVgxzOTRGC0mQ7sBtQju+XlfkXIn0knIcLEYqswn28rGiCm+seMTcuTaukFfRvCjLv0fCsdkgIkp1enerhTohsdwWdDbZ+yq1L0ErZ2hSg1TGMszTXRTYRgoHxgKx6q6lnVf/EjZaac5fApQ86UVZVvJk2ZmXDrDAHY9W8X5FhQ65nRgId2WPz7Iaafh/jz8PnSfbw8pn8JGOOzrL06MADBo07mPq7omMiRg4rfqsamruR3NxRnLLR0oUXZQi/Ur9Rb8aQlEHzL6upjizBkGf+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7416.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4270600006)(9686003)(508600001)(186003)(6506007)(7696005)(2906002)(7416002)(5660300002)(55016003)(8936002)(54906003)(19618925003)(316002)(71200400001)(110136005)(66946007)(52536014)(91956017)(66476007)(66556008)(4326008)(8676002)(64756008)(66446008)(76116006)(122000001)(86362001)(558084003)(38100700002)(82960400001)(33656002)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OcznZgIADteDPeFOUq+CN6sBYP+/kmW3D5j7xx/K5X/J7+64nNzLXNZa+5ah?=
 =?us-ascii?Q?0ZgohPpwD570vI6niIUBqcq2mCCC4bPs3HF9If0pDTXYMHbI5tpo+6uU1ajy?=
 =?us-ascii?Q?GGFzW70IH51vjuIirLPrIWVPk5C5eXCcUNZzJcSEIE6PNPIKJh8vD3O1Gvk4?=
 =?us-ascii?Q?1JMEcCgnGyp8YHCCJNHAPDicTDwIRgbtUTLad92MTeu9qzZjwWCkwywcvQwt?=
 =?us-ascii?Q?MQCZ8nki7Ux40zqnfiHYW+AhE2QGn4PDo5ixzVfwJ5/CUh3lM+9R2CPt1KPy?=
 =?us-ascii?Q?xMEWdeuD60BMfglDOIbAaCEfUj65VFnSDiAftlXQ+XaObFIxp/QPxtBkAMAk?=
 =?us-ascii?Q?rjtGO6aBO8v/hwlPRrlzKYyRMFzUupk4CNGmWt3Z2IlK23bdO/HzsNLxTdvx?=
 =?us-ascii?Q?F/ab1WHMG/SfMEs+/cPEMU62hGIc40jgnlkSc4dGNIFAdBiguKYZaGG40axo?=
 =?us-ascii?Q?QLghxYfv64zM0N2OzXk9KtGnE5SAQwTZzdmHpSj/wkFPfGDPZSJcP/D8E5q6?=
 =?us-ascii?Q?e4ZjHnyW0TJ/kaldqrqvKSXkAYfCuDulEO9Ab8xhUwNp4Z6iVdFGrfFukliC?=
 =?us-ascii?Q?l+OkRH0ECfZcpim6uUsWVelANXXl0CYIxLtvhYnbWq7F9uER2Gkwgy7QJsaF?=
 =?us-ascii?Q?a628Srj0r2WumyRX4DssaZU2WCZdNF3VVjs8bZD1nIlEGU9begPUu+HJu5+k?=
 =?us-ascii?Q?x1i/41euwTUu5uPNfIvdcGf9IExlDD8h5yt9mzd1KFjeMoll1jNgV6rNH27u?=
 =?us-ascii?Q?n5RoeaGlsbgmvdc7mJ/LXpfVAwT4SqZjDcAintezx/IwTSs1nMq0ijtjMwj5?=
 =?us-ascii?Q?ktv0vvU+Seq3y6wA12FQwXNEnpCfZv6o3c9BSVhlkXduwFn0p9Qt/8y9VCoL?=
 =?us-ascii?Q?XSPsZoCBzzT2ubGt9sHwVpS1BkHCBUBhQoQewbrEeCa29DVl3ed+DkaZ8ob+?=
 =?us-ascii?Q?Nc5IThF/mXr1dysBDqiFaJyPY8uUJxrJOYRV7lKrRp4UsCFiyI+7/o2Rgpmr?=
 =?us-ascii?Q?fTzaqvAujVgknGtvFcFfmCIjItgOkWsyLomudA7hPeq4uzzkCKSK0pOdMohG?=
 =?us-ascii?Q?X0UwxPRIaa0N4ZT+pMwBlMt5dzNpoaPZWDDf4JU4m6hNClFZ/x+wQyKM7e2y?=
 =?us-ascii?Q?UJsUD6GGV4bwKlrdEdWAOgCxyxpiC2djuoWWy4g85tnBZ+XqkQfUw0RZXcbQ?=
 =?us-ascii?Q?fK9KiSv+3KpPfWsDnOvBYOPszdjmONcj+hhzHBnSIYEbG21zO8z5mklY9mQg?=
 =?us-ascii?Q?7oYXPYninSoU/jB0VOwqNhE0A0vfGE6us35k0t6QTwwy7q5O+N4/zEl0qjI/?=
 =?us-ascii?Q?1I+wpUkDObvtm8TDU0hWXPgNkTPh8rsoO8KSJKQNVkU+ZozXt2Tscv8yBG1R?=
 =?us-ascii?Q?W6JpbZs64SuI3PGS7YENHXSzLCdWvwvbrl1brK2kEsB9pZAdOVRNpYXpfZk4?=
 =?us-ascii?Q?jkdiLxCmn8+Pcw+yl9h2w1w7W/ZHIyg9ueLehxJUo/iNEEGOuZzyejQK+rxe?=
 =?us-ascii?Q?crCPwopA2pduPyJjACdthNl8guUPhrkN6l9z3DswDYdOLK8XUOmi1J6cRYPp?=
 =?us-ascii?Q?YQE71i+MmFCGHlMV5PsmiLWXzSqROnXLPiyWMThDmeKTHGbO4cWOsQUXdgcw?=
 =?us-ascii?Q?ThDnH0E0c6RYiqUF0XGnbh/5zrSNZ67EW1UzQM2DDgrbheYQZNPfPnwzrsX7?=
 =?us-ascii?Q?wGWLt6hh6RYPBUxbuI06xXGPdpEjZtYHTk9G2Z1PbKhVxooLrjGgvlZepxHD?=
 =?us-ascii?Q?ESS+vxrYZAlXP1aqBsNdF0KHRkGfUwam9adbrdHQogei2n0gj35+KZLyAQRJ?=
x-ms-exchange-antispam-messagedata-1: srMZBCvbXKwnVy/kz7Xcntl/ozUqZq/HpIw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb98ed4-cc62-4a3f-8a01-08da17b3b1bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 09:56:17.3333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPW8HtDsBeFYCtcSfoUiCOuBbQaewM1lFtcu2MbVcViHTWVnuqNjO14Ik1QVllpEu4CmuoDpR6lIPDCOe3F2OgQTSlM/31m3s23SGbVrgRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6607
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220406_025623_216896_7CA5DFB5 
X-CRM114-Status: UNSURE (   7.99  )
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

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

