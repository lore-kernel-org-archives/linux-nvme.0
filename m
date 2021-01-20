Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07512C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 11:00:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DB122242
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 11:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DB122242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=RqmglE6jtxlzWCcWN2ykeOw5uy+6W5N2jZ2RxGe1Ikg=; b=3UZk8LTIOGhTgSBRUKdTlzFWw
	l89hg6XgZCEiLfbJNEKSNNBjM/qc6fVUnTXZ4n4HM3QRQR08lZzxh0bf8hC8523yWmR0T+dK9JooV
	kgdJH3c3AsJovw3UbBDBMA5iuGIrH0Dg3afjTXxZF4CTOcwIh7ORuxIN/yT3hhuBkVC+QKHGIKOmz
	xGU1dV8jtladyD+VYXKyuWuq0GpGv724UkqKEGgwTMsMq7j+Bg6e/KzhB6fQyd1stk42KGkRCxxuI
	rH8YXb5OPpUyzX1DgQGP2nwgesAttqLOcvjCJjDupxF2muZ4ze00d6cITGRHrsnBknA9ltwmWDtL0
	yFOozx/dA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2BEC-0004XN-1t; Wed, 20 Jan 2021 11:00:44 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2BE9-0004WV-BC
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 11:00:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611140441; x=1642676441;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8jpX3r/Fdy2oj9h4r2jueQOqv+VSCe5zL/cp1W0AlZQ=;
 b=UhacUXC12Dvb9rOT1aov4MG5Q/SisUWM8we5L4hzykA/un+gevBrzMoU
 dBmIKdM4FSNdygBha/crPrxM6JY97Yx4zfRCMD7htzjSBEZ29c+ZSoKTf
 gd3GogH4N2x9aRJrLTi9SPvhPvBtZWyW37C3qr6Ry+L9iLzxoUKDK0J0D
 N17daKtDwgQilXTZJIwIuynupHJYo22HKPFi+SR+Kp4BqO7+TaIFJUddj
 ri4kMK0wvuk/G1d904ZNN2Z5lUrissfemwJ+/RnM0SF1l0WM/6X657AX/
 x96AVnodzegMbTa0c5ur8h/XeYC9/XzxF0zyWhCDpUiKW2v4w8HeEfl07 A==;
IronPort-SDR: 9AVa11qkT4Gind1hiJ+fW/RxGYgI58ipMXOzBYNzQ6PLbAYbggoSuTLLOuy7Fjn6xyIBLjitzO
 GBr+ufMUf1DjY/vatJ4Q0IX1MGcPGQH1KvTq6k5rCwpR6fcVg8TPxuEO3WX9aPPzZP7Lc+ZF7S
 M/f73f9aDE0TroxKkKQ9E5d13ScZQc8iqnn3chDWVIS6Q1EHp1JHkzGW+TpjtcR6RKtXO9Xxma
 SdT2xPR0CfVthoG0tkx+HvOXEmfDKtMXieXkKYz8tYf/QRXjIxwRvIourylPswOdY7cVE2pL4M
 27w=
X-IronPort-AV: E=Sophos;i="5.79,361,1602518400"; d="scan'208";a="157883284"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2021 19:00:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhZafvGGR1aGv78YocXSOSRE6XT1lNEswB06PAlPsoEwO92JEZMlvLf/vSUthHZH67dSG2J/r1LrjBjDbTOVheQrpM+f+oDqKYBCsK/IJbXyb9Fsvi8R3kCK0h1ZlAF5qQLiHHmY78jXVv+Mtzw68WzjGoOasYuYCbZcyKDGBEm/nKZ9cl2LQVzQwcJ78vUyzLKKVYeV5fOEU8qx2/R+0J/wL/WybFutWklBHNTlVmAh/BMZXVA/3OUcrH7a5JaUE6reUowFP6kDnrSNV/nBFWp7LW3yR9lZ7KVUr0bictu3nyPIwzW5A67n6MXg89bIQQbKMfYCgylrZLGo6SMtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FShjsUXU5pG6/QH7Vs4MSuu9XmYj3yeif3wWOkYF8lA=;
 b=DJzCfaFNlitSIAjfloL3fpNTmCT9il4yGMBegAWato1T22gS0A+LYuT6/4exFa2t3tpPZk+jeogEwpygE1PW1Pi7ElpEoZGDqcZXmd20sFeQbDiknyzaTHyxKTMMe9NvfRPkDwxcbOTKRbdBRUvpRrUCzbIN9JNBbRii59Qmr6ipqVOqAcfLPLrZjT1XqTJTLNgW2wc1Sx3QLqsLJTCXuR2G8hCuLOaSPml+JSf0JYuiquphFMsXGps+u6yeeIKlINTndMCRB3fhfQOCcoM6xZSRPZIG34R/qMOqnmOqQEOwEWXA8cM8Yp/q3AcDYUH/8ZrSpmdtEjv9r4QimG7kIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FShjsUXU5pG6/QH7Vs4MSuu9XmYj3yeif3wWOkYF8lA=;
 b=QuSHrPn0x3vrHLmFM7tbqE0gmIWZ1+froy0dEJR3aaKS/RTeHoweDFnlacUkP7w4qOyVHG2u2DoPj+81OsNZP+wWbbYsOFtfvI1iFyUc8enduNx78piF2++Mys2HYaMt6v19O3+744repoOwVmAWkNBr/4vA6USidWk5HrKkfWA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6862.namprd04.prod.outlook.com (2603:10b6:208:1ed::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 11:00:30 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 11:00:30 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/2] block: introduce zone_write_granularity limit
Thread-Topic: [PATCH v2 1/2] block: introduce zone_write_granularity limit
Thread-Index: AQHW7nGonvlnySHUdEmqZY+rP0bp3A==
Date: Wed, 20 Jan 2021 11:00:29 +0000
Message-ID: <BL0PR04MB65144D0B02939681617B61A8E7A20@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210119131723.1637853-1-damien.lemoal@wdc.com>
 <20210119131723.1637853-2-damien.lemoal@wdc.com>
 <20210120101018.GB25746@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b0d5:1d20:2559:58ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8e09067-537c-4e8d-0491-08d8bd3299ee
x-ms-traffictypediagnostic: MN2PR04MB6862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB686250FFA5F0882A8C0ED2E6E7A20@MN2PR04MB6862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0s2YYncY8k+atKJi70OSpGUR/atrvFN9+Sx1y2Si8L0khKpQh0ctFZAvqmEr7O0atC2x+Eocl6z7r1gGUSP/I64ixsZgu9upYmxfpWlzU4suYNgTxSsuM+PxSK2OKEkGbXiiCk3qWZgY+WmcTmJp9+vlOolaQu/4/ql5S1kDzCru/b1ReJgn227DBjkRzEyUMBQsKRTmp6Dh7nIOtAusQwVkRkNaBc7dSXGXFgvUywwuRFzaJOkOzs7mM7APS8kAdVeptQBxZLKSCr4fV1FSkjyOHlgAOwQydoc0kBNpWrb4eCWWxn1T9gO2dRkQiid7lkCD5EkSgyH5lCafT7Lz9x+3GfQi8xXG8TlVudGWvtfGH25XBJDgoV/TX8iRF84ypPjxEv0oE59mywVaeGXOHyDocArwWVc+Xz6CF+1VWwfV5AwHnQAwHDtedxLZOt6tsWxa93P+YYZIjvDZ0oaUBBfm3utM61jyQLfOtVSKs+LcqqmAgtipm4kM6e9KFo5BR68aSUiWA1EIrO6IeOiHYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(53546011)(5660300002)(6916009)(55016002)(478600001)(71200400001)(33656002)(64756008)(8676002)(66556008)(9686003)(66946007)(54906003)(66476007)(316002)(76116006)(91956017)(4326008)(52536014)(186003)(2906002)(66446008)(6506007)(86362001)(7696005)(8936002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fw1XkmRBs0d00KUsYKFqZSpQoxsXSuIzTbWk92dJiZ44mxH+Fa4ISlKP2H07?=
 =?us-ascii?Q?lSLHtP7OG8Z0UGWyU9q6heaWHMgHhaJCtx2KGJJPZoKyBLoVztqAGbuZKnsw?=
 =?us-ascii?Q?PJWThTMTfV7nJY+5mgAx8LaDGDpg5LbRYKlInmLwclh5J8f0reCNLo2mpumH?=
 =?us-ascii?Q?O+qyIeXNhzRZM+SdwcS5vPEhOrz9hyburczSOkYe/W3KoSGqXyJrReVYPbYK?=
 =?us-ascii?Q?kbGYaWZLR2k6bLNtjeXpGM5FdOCH+etM96u3fwu9odkroxW2SL0q2ABr2K4X?=
 =?us-ascii?Q?kcW92u2tifvRn2EBSnxhUq5KIS4PUAscRxv97eki4uWTEMylftg08SLA8WVE?=
 =?us-ascii?Q?ejgS8MFlZG2totviQauDXWMgq2DMAXRQDM60pXHZGBFv/7/F7Z1AQqDx1pJH?=
 =?us-ascii?Q?KYRsBMHqidmZKHX4O7ckgxLZa2x18yagPQwJtcjknaqQNb8zC0ofJFxPDuwI?=
 =?us-ascii?Q?10sRP7/85B/w0VBw5WKlzaxWMhy1QGQbdnD7RNxj8Nqtz+BVEYnM4PpbCW3m?=
 =?us-ascii?Q?C213t9fYl4l4cadr6hO80iu6xrXFBlNsMj/pGUabQ+0uLeXJejoNOSXKKk0S?=
 =?us-ascii?Q?qiNbRbcde3zW+qeks3/eRmQINCGLm8z65dUgmzhK/ifHMQ2vtk5KfmYPnQ+i?=
 =?us-ascii?Q?UI65sLBw0fG4FeCOnTIds1D0IQq89Gkae644oG7lzphWnmssEH6ctaaqXD/0?=
 =?us-ascii?Q?hQp0TZvy1vtQmrY2QEXQn+jHSFWttxQO+gbEjjtLxCz5HtXnb24V7sP8NdQR?=
 =?us-ascii?Q?idZ5bfgSHgMq6t1wQ1j+tykwyxxJDoSWvqulInijm+VZJ1zID9sxq8hUPM1T?=
 =?us-ascii?Q?2SW7+1u77XvY9r8uAQuwC4LIgfmQZuhHRJw1bvi8/EDSi90pfl9/uWJzbfee?=
 =?us-ascii?Q?X/nRK4DYA2f9HiCTcTIEzcrK7QQKVIibsWTlUBnTo7NVOki3EmWAxjkz6qZg?=
 =?us-ascii?Q?En5MhRn9NBKccDSyUFubDYjXLNNHrqydeo4AZSHLLbdQdBHf1MZXU9GJNy6Q?=
 =?us-ascii?Q?NPDJF+YswQrnohUwsrqRivHD5+9Xf7AylM2vpPg6oW8R4xybf4AwQgpCbqvM?=
 =?us-ascii?Q?hB76zT4hXIJY1tv1QPLiVECYDK4H5HzgVnjvlRZ+0F8KyQ4E8hwkp1fOIhfu?=
 =?us-ascii?Q?ZSMCop5JpF+JBxXTblcxP8shye+XUi8V5A=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e09067-537c-4e8d-0491-08d8bd3299ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 11:00:29.9978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfaShVThAwRkglCKO0K9u9whs8Ryg+vJyA1cRTXdLvgys+uiHc9kRy5ZIYvT2i/+qNuKvgQoecOvNCIOE35SpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6862
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_060041_649646_C8762F45 
X-CRM114-Status: GOOD (  27.69  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <Keith.Busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/20 19:10, Christoph Hellwig wrote:
> On Tue, Jan 19, 2021 at 10:17:22PM +0900, Damien Le Moal wrote:
>> Per ZBC and ZAC specifications, host-managed SMR hard-disks mandate that
>> all writes into sequential write required zones be aligned to the device
>> physical block size. However, NVMe ZNS does not have this constraint and
>> allows write operations into sequential zones to be logical block size
>> aligned. This inconsistency does not help with portability of software
>> across device types.
>> To solve this, introduce the zone_write_granularity queue limit to
>> indicate the alignment constraint, in bytes, of write operations into
>> zones of a zoned block device. This new limit is exported as a
>> read-only sysfs queue attribute and the helper
>> blk_queue_zone_write_granularity() introduced for drivers to set this
>> limit. The scsi disk driver is modified to use this helper to set
>> host-managed SMR disk zone write granularity to the disk physical block
>> size. The nvme driver zns support use this helper to set the new limit
>> to the logical block size of the zoned namespace.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>> ---
>>  Documentation/block/queue-sysfs.rst |  7 +++++++
>>  block/blk-settings.c                | 28 ++++++++++++++++++++++++++++
>>  block/blk-sysfs.c                   |  7 +++++++
>>  drivers/nvme/host/zns.c             |  1 +
>>  drivers/scsi/sd_zbc.c               | 10 ++++++++++
>>  include/linux/blkdev.h              |  3 +++
>>  6 files changed, 56 insertions(+)
>>
>> diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
>> index 2638d3446b79..c8bf8bc3c03a 100644
>> --- a/Documentation/block/queue-sysfs.rst
>> +++ b/Documentation/block/queue-sysfs.rst
>> @@ -273,4 +273,11 @@ devices are described in the ZBC (Zoned Block Commands) and ZAC
>>  do not support zone commands, they will be treated as regular block devices
>>  and zoned will report "none".
>>  
>> +zone_write_granularity (RO)
>> +---------------------------
>> +This indicates the alignment constraint, in bytes, for write operations in
>> +sequential zones of zoned block devices (devices with a zoned attributed
>> +that reports "host-managed" or "host-aware"). This value is always 0 for
>> +regular block devices.
>> +
>>  Jens Axboe <jens.axboe@oracle.com>, February 2009
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 43990b1d148b..6be6ed9485e3 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -60,6 +60,7 @@ void blk_set_default_limits(struct queue_limits *lim)
>>  	lim->io_opt = 0;
>>  	lim->misaligned = 0;
>>  	lim->zoned = BLK_ZONED_NONE;
>> +	lim->zone_write_granularity = 0;
> 
> I think this should default to 512 just like the logic and physical
> block size.

Hmm. I wanted to keep this limit to 0 for regular devices. If we default to 512,
regular devices will see that value. They can ignore it of course, but having it
as 0 makes it clear that it should be ignored.

> 
>>  }
>>  EXPORT_SYMBOL(blk_set_default_limits);
>>  
>> @@ -366,6 +367,31 @@ void blk_queue_physical_block_size(struct request_queue *q, unsigned int size)
>>  }
>>  EXPORT_SYMBOL(blk_queue_physical_block_size);
>>  
>> +/**
>> + * blk_queue_zone_write_granularity - set zone write granularity for the queue
>> + * @q:  the request queue for the zoned device
>> + * @size:  the zone write granularity size, in bytes
>> + *
>> + * Description:
>> + *   This should be set to the lowest possible size allowing to write in
>> + *   sequential zones of a zoned block device.
>> + */
>> +void blk_queue_zone_write_granularity(struct request_queue *q,
>> +				      unsigned int size)
>> +{
>> +	if (WARN_ON(!blk_queue_is_zoned(q)))
>> +		return;
>> +
>> +	q->limits.zone_write_granularity = size;
>> +
>> +	if (q->limits.zone_write_granularity < q->limits.logical_block_size)
>> +		q->limits.zone_write_granularity = q->limits.logical_block_size;
> 
> I think this should be a WARN_ON_ONCE.

OK.

> 
>> +	if (q->limits.zone_write_granularity < q->limits.io_min)
>> +		q->limits.zone_write_granularity = q->limits.io_min;
> 
> I don't think this makes sense at all.

Arg ! Yes, that is a hint only ! I misread the comments for blk_limits_io_min().
Will remove this.

> 
>> +static ssize_t queue_zone_write_granularity_show(struct request_queue *q, char *page)
> 
> Overly long line.
> 
>> +	/*
>> +	 * Per ZBC and ZAC specifications, writes in sequential write required
>> +	 * zones of host-managed devices must be aligned to the device physical
>> +	 * block size.
>> +	 */
>> +	if (blk_queue_zoned_model(q) == BLK_ZONED_HM)
>> +		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
>> +	else
>> +		blk_queue_zone_write_granularity(q, sdkp->device->sector_size);
> 
> Do we really want to special case HA drives here?  I though we generally
> either treat them as drive managed (if they have partitions) or else like
> host managed ones.

If the HA drive is treated as drive-managed (i.e. it has a partition), then the
model here will be seen as BLK_ZONED_NONE and we should ignore it, or better,
set the zone_write_granularity to 0. If the drive is actually used as a zoned
drive, then we will see BLK_ZONED_HA here and we can use the logical block size
since HA drives do not have that restriction on physical block alignment.
So my code above is wrong. The else should be

else if (blk_queue_zoned_model(q) == BLK_ZONED_HA)

And I think we also need to add "q->limit.zone_write_granularity = 0" in
blk_queue_set_zoned() if model == BLK_ZONED_NONE at the end of that function.

Will send a v3 with these fixes.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
