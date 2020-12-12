Return-Path: <SRS0=Hsw+=FQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C62C433FE
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Dec 2020 09:25:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7DD23D50
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Dec 2020 09:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7DD23D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=jotXQSopJ0GffJUeBMv3Pr6HQLon0RsiZzcpudlTor0=; b=Rf2einvMXka5TmKc7d+3Bnmg0
	q+8jCC68Hbb/1sND8kozXQnxDHGcLYlZcj/mq8nL429dHc6ClOkRl7pd7wSDn9gBVnB4P+9/CV0zR
	OMooxNSVJM0xj/34o8Nshpne05W/veppRBX9Qfo+Vpvo2SpIwYx4BBmOvipN7v8K2gCLWgz1YPu1X
	+rP4ifBT0H+o7X466w6kTC1n0Zwuo0lRknpOnz8wl0FqOCLHQwEOf2U+yr/WzGZqSxXcl6h2niTbF
	nozVO8xHlaq9mI5EgkFsdXepQ88yVRsE8MZXHrGkiHk9icg2cs0Et/lXOYI8dERRra4SOxmOzpx31
	uT5mnpIUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ko19x-0002Aj-5A; Sat, 12 Dec 2020 09:25:49 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ko19r-0002AO-Gs
 for linux-nvme@lists.infradead.org; Sat, 12 Dec 2020 09:25:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607765143; x=1639301143;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ruS8K0iwcjBfai7ZNrbAQ7XWG9xXTe+6WH3SlzdrmgE=;
 b=fHtcxTamelzA8yCZnnPXoBRxaJDzv94YfTmvpIxrELSQ9oW2EaEVRpmI
 0pEUdDMpqV0JZ7b9VoykjdL+oSrgfop8sBnj+UB8DCLSyBdg5qjKbIVsZ
 2RAE6qRTlWGVIGOTevd88lN4DwrEysgvJIhN5yTs0OlVbHiDh7X6Ww8Ua
 Ea/D+ZKxLyoxbg9l70sb2ZHuUnnndyJzb5NCRVQtMo9AQIi3YrMKav8yV
 s8zWJsS9Sd6jfPAXWQcWFuv+BCw6lFxKYpjgG4zZPLnsD81VUZ3CkkozE
 GHTZEY2yjugd2+6set7rf+LLvEcQipJHoySCzAep/k/CxYptNzkguv+QW w==;
IronPort-SDR: Q+iw2b6Rxs8oO3SV1qOCNFBvONragGw6hlL2dIFDb8Eh8pAoV4+prDdWwF5WBxlEAeX5ya+bzX
 9xbFgFTQ8f00llMliqfah/kkoxpIQ1uqb235LzLx+o4bZ5AaMbWdZtps+l8OBhSr0FPJL0eIZZ
 jfF7uw+Sp0SEmCMLwJ0R17Fw+5WI/EU79VznId+hyfXThvxe/PhdNViqj9V1/3rgMA8PVAIjn4
 JpYmf40VUZBKu70fB7atgOu8nBfhBKVx1Kxq1UyIrr2DVGdHd6bl7nxIwimqxJdFwEecAfXYtl
 jWY=
X-IronPort-AV: E=Sophos;i="5.78,414,1599494400"; d="scan'208";a="159450626"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 17:25:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih46BIlRbsR+TzTr1m4lZN+V/I6Ey/U38Mcz9N3bhnalCfjtXeNzTjiMs06iTj8rtB3K/7SqXwfqZpcARTeZmwd+cuwZVM1HBBjqt8wh0uYKswK8JLR71YhZ+TY0l3CldaOMvw79VZrxEb0QF8ucziqP9sVdzVso0BxzhdMYuVTVu1pdGQXlUlVvfIc0w5ll+tpvf0oRm1AM6EaRw7KO868rCXKrUALz0qp/FnJXr0y0TMZd6ZGQeM52eCuphwkbY0DYyNHRP2oPf2sBLEWu7jCMofRsiT0TTHBmKGuSD/tHZhwRlbNgSBHdTkFQbEu8tdGC5B++GEe8/dMT6wUdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/8FIuEm6I4xloz45qzzXZf3b5gmBO1Hr+EbG6eSRSo=;
 b=DDtoH39Ui7fYOd96cAPQoFtYmhzZG1JZb9I85f6GRnd/iBZ2tyPMxoaCnrxkf0dJ1xIF1QdmHJ8nePaSgwHI+pz/gjnY8smvZzqHoBqRxE7nelrgjDheqfseOc3bSyoyLX25rKmA9j+jbahK5jUwFBLqtJJ9wsWMWhEFzrgCOMxjTdin5qMuckY7P8VfYvbXm9qEZoito3IrZepqIeo/z6O2lcX+jLg92AfJvwo3XG6gxb10Zd5sLaXmCvY3MV95OjnhK5UAFXu2yVJquhslgRN6Q/ZE1svqksNNUnpAY0jw0WTs6CGa6nHMy3Q1lvFisgGIl5dj0dQCN3rVBhRZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/8FIuEm6I4xloz45qzzXZf3b5gmBO1Hr+EbG6eSRSo=;
 b=y5mvRCqH+TIitUvOvke8crfKKZJSGjTvASpUwX1e44I0ds4J1RVWdJqxkoaKTJZc2M1eYudnXYocH4WEGTrUg9Td/vylXn/bVcrUSkq/mjR4zoQqI3Bp/ltvFiwqU3owj+KtwtFM5oECDSL+fykCcDRvm+MdRpIF2tjApVEKBFU=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6629.namprd04.prod.outlook.com (2603:10b6:610:a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Sat, 12 Dec
 2020 09:25:38 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Sat, 12 Dec 2020
 09:25:38 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHWzr2FP/i+FdqWaEeC/fieodd2UA==
Date: Sat, 12 Dec 2020 09:25:38 +0000
Message-ID: <CH2PR04MB6522EACBA6C865941B0A79E0E7C90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
 <20201210062622.62053-5-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652299EA78B1304157CC8234E7CA0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49652F762776AC04BC2719A386C90@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5911:8225:c337:ee37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba6ad536-8146-4819-fd7d-08d89e7fe340
x-ms-traffictypediagnostic: CH2PR04MB6629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6629E5B4642B9EBCB31F0D74E7C90@CH2PR04MB6629.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pHExw9silhdb6bra5TDSp8VI+APbK5AQR6go74IZ+1hJ1uFz0qb58uOkVK3Sq7B44D1mf0nEf0k6DuiVu9aOzBaYUoxjFq3M+GbJi2kVk2XlGnh9dsUL/5iaVx1Cs+t6qZ5YmBRbHr8ovu8UJVn5ZLmhdjZ0JdiIwqHp7WtIpaZzNFcQajNo14cCJKT4CTwP8BJI6+/38KCnxRrVBdEfUeCEHwDdoF7nz7WfCHVYO40j9Y60ojHECKxuxkumwiEz7SxhnFtjHYwmfK5LfW1EUFbmvU3jKA2TkmkKY/bg1RzltKz2CkxeWV9KVZAojvVFADnHEB1nGXipPaL0VfrTIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(4326008)(64756008)(66476007)(83380400001)(66446008)(5660300002)(52536014)(110136005)(55016002)(9686003)(508600001)(66556008)(54906003)(33656002)(8676002)(2906002)(8936002)(91956017)(6506007)(7696005)(53546011)(86362001)(66946007)(71200400001)(186003)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EcLmyYXHvKLH/ErMNu1OUAEUt1oTRP6LiiClCVLgdh1FDCZcGvOi4w4NQC81?=
 =?us-ascii?Q?+5TeNvhfsw7SPv/M94VQ6t4GjfaMlGmXEu3JvKlQBX/Q1K6xEzI36UpJaY4C?=
 =?us-ascii?Q?OYTsEJA6sY15v7bxWu6Y/YDwxGbnVeRhshhmxCMScWUR4NsOkOONvbAWBaH0?=
 =?us-ascii?Q?PSryK3fW0f8WSmGESYPoNuuBvsoRYKrXX8R5uK2tx1vOnekaQNjT0E3GjgXJ?=
 =?us-ascii?Q?0kbz6baw1SZJOmEgL2n/e2KMJRZrKge9/xrDtPEVP5Tazy2ezDKjoPEY9Rqe?=
 =?us-ascii?Q?K0iQM+USrRNdbZezMOCHk11hhH0lVlEATs4H5Fuo7062PdiNpSjAjCZkvrKf?=
 =?us-ascii?Q?RiffhNZaDuH9e/Gk1Ij13l2r9QtPgb+O7W0fQeTiXGOj7dI3YVKMphI0mGoS?=
 =?us-ascii?Q?xt1fZYB9BQDEk/QY5dWvbdKug7uZdoljhPnKA2UnNcrgD5PUwK/+LFQ3AcLC?=
 =?us-ascii?Q?L9zcf3h3zO8m/hWAofoUbubYfw7zBaySJg/WSzQWhaLdn0CEkUVUKxbx4sQ5?=
 =?us-ascii?Q?jfioRUWL0TBUVJLx8WZNf+d+rqUJ+iZuYLlsY7/aYvvcguYDZrz+eq29cJ30?=
 =?us-ascii?Q?RwA2YvOTYVd7AYRsLW+Lz23tqaqnIkkyuWsZmpxf8NAfrACJivsrzMMDVlzr?=
 =?us-ascii?Q?ZyeixkuPHLhhqvbZ6Q7i+3YyAARNIx4dApGMkLVXy992biSWME5eZK36tSKr?=
 =?us-ascii?Q?AvivApe3RNb2iC5hfm9MDo6TFHO/9sFT/GG42hzW0yoia87599j8Kvp+nWw9?=
 =?us-ascii?Q?ulPXdCC+ZK4o2eFRD8A9LFaJMLisHJED9coL44Izeu6xUW3j8mvYcFIeEofX?=
 =?us-ascii?Q?B3t9TxctiUoEGv9XPDibhrCcothIcSMCC5Wj0RTCWVSDCv4v/si46MHdjCEO?=
 =?us-ascii?Q?UIn7wOp/sv0hvZrDcSa7nIXs3teyfooVpOebPTHl9XMcNRV2APZdf2zg+hjp?=
 =?us-ascii?Q?HMMgx4noxNmbuNBQr4O1IxO328Y4+0nmhURU5h2Uq/vRtwJnVkEJqB60qGtk?=
 =?us-ascii?Q?/OChV2ucaYNYshBBztUE3Jec7dEvBy4M0p030i2tNFzuNviEfnncsJ541Plq?=
 =?us-ascii?Q?OBtuwXlK?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6ad536-8146-4819-fd7d-08d89e7fe340
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 09:25:38.2771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VN/6Ge67Y14Q2lJ6Xr9jvP6rTjhvcyE0mOMpd0LIQIqeZ6Ni0qjMyTZYD8MWae44puLGfgS6GBjpC//bQw78iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6629
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201212_042543_943950_435B0798 
X-CRM114-Status: GOOD (  27.75  )
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

On 2020/12/12 15:54, Chaitanya Kulkarni wrote:
[...]
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>> +{
>> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
>> Hmm... BIO based DM devices do not have this bitmap set since they do not have a
>> scheduler. So if one setup a dm-linear device on top of an SMR disk and export
>> the DM device through fabric, then this check will fail to verify if
>> conventional zones are present. There may be no other option than to do a full
>> report zones here if queue->seq_zones_wlock is NULL (meaning the queue is for a
>> stacked device).
> 
> If I'm not wrong each LLD does call the report zones at disk revalidation,
> as we should be able to reuse it instead of repeating for each zbd ns
> especially for static property:-

I did say BIO based DM... If the backend is a dm-linear device, the bdev and
request queue that this driver sees is the DM device, not the bdev and request
queue of the DM backend. And DM code does *not* call
blk_revalidate_disk_zones(). In that function, you can see:

	if (WARN_ON_ONCE(!queue_is_mq(q)))
		return -EIO;

to check that.

So the zone bitmaps are *not* set for a DM device. Which means that this driver
needs to do a report zones to determine if there are conventional zones.

> 
> 1. drivers/block/null_blk_zoned.c:-
>     null_register_zoned_dev int
>         ret = blk_revalidate_disk_zones(nullb->disk, NULL);
> 2. drivers/nvme/host/zns.c:-
>     nvme_revalidate_zones
>         ret = blk_revalidate_disk_zones(ns->disk, NULL);
> 3. drivers/scsi/sd_zbc.c:-
>     sd_zbc_revalidate_zones
>         ret = blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb);
> 
> Calling report again is a duplication of the work consuming cpu cycles for
> each zbd ns.
> 
> Unless something wrong we can get away with following prep patch with one
> call in zns.c :-

No. That will not work if the backend is a DM device. You will hit the warning
mentioned above. DM sets the number of zones manually. See dm-table.c, function
dm_table_set_restrictions().

We could get to have blk_revalidate_disk_zones() working on a DM device, but
that is not very useful since the backend was validated already, and the bitmaps
are useless since there is no scheduling of BIO/req done at DM level.

> 
> From abceef7bfdf9b278c492c755bf5f242159ef51e5 Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date: Fri, 11 Dec 2020 21:21:44 -0800
> Subject: [PATCH V6 2/7] block: add nr_conv_zones and nr_seq_zones helpers
> 
> Add two request members that are needed to implement the NVMeOF ZBD
> backend which exports a number of conventional zones and a number of
> sequential zones so we don't have to repeat the work what
> blk_revalidate_disk_zones() already does.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  block/blk-sysfs.c      | 14 ++++++++++++++
>  block/blk-zoned.c      |  9 +++++++++
>  include/linux/blkdev.h | 13 +++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index b513f1683af0..f10cf45ae177 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -307,6 +307,16 @@ static ssize_t queue_nr_zones_show(struct
> request_queue *q, char *page)
>      return queue_var_show(blk_queue_nr_zones(q), page);
>  }
>  
> +static ssize_t queue_nr_conv_zones_show(struct request_queue *q, char
> *page)
> +{
> +    return queue_var_show(blk_queue_nr_conv_zones(q), page);
> +}
> +
> +static ssize_t queue_nr_seq_zones_show(struct request_queue *q, char *page)
> +{
> +    return queue_var_show(blk_queue_nr_seq_zones(q), page);
> +}
> +
>  static ssize_t queue_max_open_zones_show(struct request_queue *q, char
> *page)
>  {
>      return queue_var_show(queue_max_open_zones(q), page);
> @@ -588,6 +598,8 @@ QUEUE_RO_ENTRY(queue_zone_append_max,
> "zone_append_max_bytes");
>  
>  QUEUE_RO_ENTRY(queue_zoned, "zoned");
>  QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
> +QUEUE_RO_ENTRY(queue_nr_conv_zones, "nr_conv_zones");
> +QUEUE_RO_ENTRY(queue_nr_seq_zones, "nr_seq_zones");
>  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>  
> @@ -642,6 +654,8 @@ static struct attribute *queue_attrs[] = {
>      &queue_nonrot_entry.attr,
>      &queue_zoned_entry.attr,
>      &queue_nr_zones_entry.attr,
> +    &queue_nr_conv_zones_entry.attr,
> +    &queue_nr_seq_zones_entry.attr,
>      &queue_max_open_zones_entry.attr,
>      &queue_max_active_zones_entry.attr,
>      &queue_nomerges_entry.attr,
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 6817a673e5ce..ea38c7928e41 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -390,6 +390,8 @@ struct blk_revalidate_zone_args {
>      unsigned long    *conv_zones_bitmap;
>      unsigned long    *seq_zones_wlock;
>      unsigned int    nr_zones;
> +    unsigned int    nr_conv_zones;
> +    unsigned int    nr_seq_zones;
>      sector_t    zone_sectors;
>      sector_t    sector;
>  };
> @@ -449,6 +451,7 @@ static int blk_revalidate_zone_cb(struct blk_zone
> *zone, unsigned int idx,
>                  return -ENOMEM;
>          }
>          set_bit(idx, args->conv_zones_bitmap);
> +        args->nr_conv_zones++;
>          break;
>      case BLK_ZONE_TYPE_SEQWRITE_REQ:
>      case BLK_ZONE_TYPE_SEQWRITE_PREF:
> @@ -458,6 +461,7 @@ static int blk_revalidate_zone_cb(struct blk_zone
> *zone, unsigned int idx,
>              if (!args->seq_zones_wlock)
>                  return -ENOMEM;
>          }
> +        args->nr_seq_zones++;
>          break;
>      default:
>          pr_warn("%s: Invalid zone type 0x%x at sectors %llu\n",
> @@ -489,6 +493,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>      struct request_queue *q = disk->queue;
>      struct blk_revalidate_zone_args args = {
>          .disk        = disk,
> +        /* just for redability */
> +        .nr_conv_zones    = 0,
> +        .nr_seq_zones    = 0,
>      };
>      unsigned int noio_flag;
>      int ret;
> @@ -519,6 +526,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>      if (ret >= 0) {
>          blk_queue_chunk_sectors(q, args.zone_sectors);
>          q->nr_zones = args.nr_zones;
> +        q->nr_conv_zones = args.nr_conv_zones;
> +        q->nr_seq_zones = args.nr_seq_zones;
>          swap(q->seq_zones_wlock, args.seq_zones_wlock);
>          swap(q->conv_zones_bitmap, args.conv_zones_bitmap);
>          if (update_driver_data)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 2bdaa7cacfa3..697ded01e049 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -526,6 +526,9 @@ struct request_queue {
>      unsigned long        *seq_zones_wlock;
>      unsigned int        max_open_zones;
>      unsigned int        max_active_zones;
> +    unsigned int        nr_conv_zones;
> +    unsigned int        nr_seq_zones;
> +
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
>      /*
> @@ -726,6 +729,16 @@ static inline unsigned int
> blk_queue_nr_zones(struct request_queue *q)
>      return blk_queue_is_zoned(q) ? q->nr_zones : 0;
>  }
>  
> +static inline unsigned int blk_queue_nr_conv_zones(struct request_queue *q)
> +{
> +    return blk_queue_is_zoned(q) ? q->nr_conv_zones : 0;
> +}
> +
> +static inline unsigned int blk_queue_nr_seq_zones(struct request_queue *q)
> +{
> +    return blk_queue_is_zoned(q) ? q->nr_seq_zones : 0;
> +}
> +
>  static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>                           sector_t sector)
>  {
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
