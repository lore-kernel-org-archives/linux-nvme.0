Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F3C4361B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 23:41:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA312207C9
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 23:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA312207C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=f8DlnTH+7aRj8Aqh1i3AmZJic8dc865OBtr0NaCVlbk=; b=tBihkM78yiKPs6LWE6NaZzIpd
	Znw/MqxP59INMSI27aubJdH3byxEjHMOppSa4Myex0qb3dKW4K/fVsEQd8McmXgHXQ10nTHFcwcHo
	ctFUyeM/WxUPu7+iktlgYIknllKNyCErL+oXXNXIjxRPqLhZfG2nEq4i8fVwWQFmippUL7HTbEC/w
	Jy3Ge9Ppv82XxVvBLCKRCfPFdXQ8ZXO44eLGxl4WCcMyohB3ku2rWR/slKTiICNh2N46jmtLbhTZY
	TXaO+dvk53HV/EzrCVvicXehkyRLiNHmqHoKwkGZAgtDbd8SJSnO3xNT9DygyN92RID86omd0FRK6
	XOoWAppVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koazP-0001sS-Cr; Sun, 13 Dec 2020 23:41:19 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koazK-0001rO-Ta
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 23:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607902874; x=1639438874;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zGCbjUo/rtqC2B7+DaoFPb7AFG+OQPydMKy7ZR8aTaI=;
 b=CekcVJ3baPA/azH3YJ/Meh0oPS1VzIhEGJ2/GCyy6bgG5G5RoQJrJlH9
 qqotQBukoZGarS4ZFg2lcDeDRPMJjb92yGoKhVVOR5tGQ01s44wzxdI8M
 YDyD5v73CWAXohB9+v+CNpkOY0jYjBQ1jPZdXmsTHiJvPiGkbYHQvHgmK
 T3lzey+lPyFIKKUV1O/PpLn61lNpNcaYnBf0ZW0I/8wBcjZ38qrZr8n9f
 lE/vfDuiMsde5VqrE4iVLgWwQbqsZnzNPphImSjUjH1qvdztgp/w0m0ZZ
 eETzYOOkFo4ZicopveC2BwuCybmhX/aIBwDfHeI86HYZdWwWOawZId418 w==;
IronPort-SDR: m6ArrXcApdhc2XoRbWaXNZXxST5GioSpGc8fX/AzAxfA3CRn5a/YomE7wEnZZbzUEN+vI5TyAf
 uUSoT1Mf7Gv+8nBC6sY+aPPHoOOr1dy9SQPHQROeGUCmyuN4b7HF2EMJm1r39274Ju5Pm0iB7H
 MbnY1qUXpUKcy94HF5t7U7cUI9Szk9NIJlygrIUlLDR0RRBRrXTVIi756Nq+dAxDKr/KPLyBFB
 T732YZiMtc0Nkp/SXrY45e197GNK8dyHHFurHJuvUjxV8qNtF+8jO1lxJrGBExhlcLGAfCf/uL
 4NY=
X-IronPort-AV: E=Sophos;i="5.78,417,1599494400"; d="scan'208";a="155091429"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
 by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2020 07:41:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E121o/ygONw1MznySWlJXFAtkZagvksziXlr0J7ID3INGP/nSD4WZphYf0sI69LSoWP70QumkIUDtRR5uqvux4nV1tC7jOYOSHhWuJzG8s4BLfPJ5reD99R8VMu2AHc92s3Lm5J81vweHtDV7J1QBV2r4ZXXx8W+Ojtt9LVgx12QCyCv3zWJPbWYhweWcRRhfHXoLMS6OprTvT4gRz9wfkgksA0xQt4he8DgpvUk+iswcOPbQeZpo/mSZGcNxT7e1vFp4ZjDfTIN2SgbtHY//P5hEvvPPDFrjjH8Swkszf9QgmftsJR8P+0UJn6b94NXgDb52qKDEBXpxf2i15L4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n8XjT23O2w62Om6APwnKDdeuYIPauKQoRLnUEraUXY=;
 b=N5zhBGgjtAkimR55yeimPATQQy+3pVIVD9Qdm+5G9/gKqZH64UyinA1UOy3G+PtKGVyMzukSSLtqG/7yX1yltaeFa7WJ8Gryj0H1s4LLJWf/IVLeJj4Jiru2T36hb82Y7abhcZ1zohBYN1vvRnxGW3h2bP2xdQRfg/zZrk0A8FKNqHBLIs6IgBdZQXOn9q5Fw9Myhgwgf7Na0oWULFqWpBbf+QWBTjpBgZUoXlF2ksys38JveraoRAZSw/Uv+kUQ3W4raWytnkX+Oy46QXJeWjA2M/8cCdZ/VeuGy4n2522bhvXerfVIDGLM1Rb9LRlTRx3rjv44hh7lOgl1QtB6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n8XjT23O2w62Om6APwnKDdeuYIPauKQoRLnUEraUXY=;
 b=gaZABZspjgMX9Uzw0IpNZku9CKMRq69bXcCZTAwbBFtKDb2E/nAL+cntO4mUWzP8o5yj8ClZUg8qQZK5NGYuqi5VQXRYliTDBf749VZCG0Ca4SfiXvZTrO80KalYQXSD5qGqv0it9WjyLgmCYf1k96rVOgfswnAPYXzr/ewoULQ=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6965.namprd04.prod.outlook.com (2603:10b6:610:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Sun, 13 Dec
 2020 23:41:09 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Sun, 13 Dec 2020
 23:41:09 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V6 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V6 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0RPvmJIFNb+IOkaBuk4iq3d6ew==
Date: Sun, 13 Dec 2020 23:41:09 +0000
Message-ID: <CH2PR04MB6522C565F3EC80FBBDD7CEB6E7C80@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
 <20201213055017.7141-5-chaitanya.kulkarni@wdc.com>
 <3fa59aa6a579b58ffff9fc0f95a34f93c9354618.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a7714a0-37a1-41e8-b354-08d89fc09172
x-ms-traffictypediagnostic: CH2PR04MB6965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6965B012C51478450651442BE7C80@CH2PR04MB6965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NthkR8UKpvbbx0JbtXaJfJLnJKV8xJvC0sULKG5LLddq35iag8vXny7TJBIq7ZCtnScm4RlzolH6epmSsS7GdB5eYbxYNyxxffmH58o4wIk88XNt4k3/M8io/bwyrBRhEVswLwHDcLn5vV0PjTgtn38x2vIXSRoflB5mcQ++Guupmdf1S8hSXnqZHnXuMEcc/2/FKltFEpr81yQuOmPFrvu0MzXm6YgoKc18B9MYw2LYyxb2/wCkrRvl3O+LzU20l9h9QbeoUTX33kCQ9Op8NRyChTVpujouPT1/WmfV5Zpa8nptT2RKRdVfnBUP9G6qVzmJhA1YLI0AngXZlN3duA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(52536014)(76116006)(91956017)(4001150100001)(66946007)(5660300002)(186003)(6506007)(7696005)(53546011)(83380400001)(8936002)(26005)(2906002)(86362001)(508600001)(55016002)(66556008)(64756008)(66476007)(8676002)(66446008)(71200400001)(4326008)(9686003)(54906003)(110136005)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Y16veIlVurXOpqh0lo3JZnFoK1fTx4CoeTj7POXwBqtZe8y7L9fsUhZlgcRP?=
 =?us-ascii?Q?11+DjgnO9qIi8BaG4JdAyx86/zKxRZr1eCOJ1VgZUft3NUI5S2QeLxpNYBzS?=
 =?us-ascii?Q?cXFqfE+Lsta8PzwQEHQACvY1MmJ4jXeJCyNmGSzIZNKoqkoUcR97hJVnp26I?=
 =?us-ascii?Q?8tfF3yiUJmefDj3JPfiKBOS0PhYC4dNQs1x3qdnlhWodb4nTghqWYz3f7+VH?=
 =?us-ascii?Q?JncXDuDqxkp3JyTh5INvPf+Uld0gUUGWWUkdqbu2meqFnwvEqVt707uEGC0b?=
 =?us-ascii?Q?rsX2wMxmFETC7owmp3dYDRHu0BWWZQPOGZjBaAqKM1H0l4V9aR+qhSXcTgzr?=
 =?us-ascii?Q?jXlnKAdN9SmfT3i+TuRM29W/ZIrbFnkEzHwd0jaDMsnhbbzZvP1gVwTmmv2B?=
 =?us-ascii?Q?NINvaFG+zOud75lDSmgEJWQenGhMTTTEirzv6RURxk0Kb66seCfJWKLuJMuR?=
 =?us-ascii?Q?Uj1thl4yXEn5lqYCZHdRFKW1wZXVQ83ZWLU7Bv4K0Oy11U20IZhlmH06tFTU?=
 =?us-ascii?Q?wtQiPCpvi5NT7ieG2aFLaHiLBFYMPcKV6n0umTrYOVRMvbJhpWrKf7G5mBnE?=
 =?us-ascii?Q?Pn/YaETRX+MhZPuOY5/VuVFvV/dA9lPQfrdk57Zx6opqc5ViwBBWWdf0ZJA4?=
 =?us-ascii?Q?E6JoVEpn2hYgiRGIJQysfS61FYZ8fsgtMLw72Oz5p+lEU4+ZHXRP1KHioASG?=
 =?us-ascii?Q?ylqzYD4AFygIBMXVH/xMmk1QpCtql/VOpJP8r/WI0QWBLXa0Lr8gsv57868Y?=
 =?us-ascii?Q?d2mELsb6QLBtoK0bMg38et2d58OCjBg/oBgE2bRQQbyK1s+9UUWjW6RF08Rw?=
 =?us-ascii?Q?saC5QMWpD1bxdwkyV14QmNH1rclPy1d5ERoyOZBnJp4BeqDFbjVCGjebjFX6?=
 =?us-ascii?Q?TU7jAokWsaXzs87yG4WqWtxBWYaz77tdaKqCz02Si6b7PBF9nDndniPlUimn?=
 =?us-ascii?Q?yMnRE+Xj8Aoqh8PEIbKQrcYRkb3JIvNv1ZTNFSGuJF97Me8ZejsgYFPdSNuj?=
 =?us-ascii?Q?FhXY?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7714a0-37a1-41e8-b354-08d89fc09172
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2020 23:41:09.4839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YUBoIn7rKQWR6+f029TF2V6Vp5Xppx/8vvFASBeafW468QXcXkeX4zERAvrA059TgQuuygbg47tLZ5bw/6M+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6965
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_184115_338845_25FB4457 
X-CRM114-Status: GOOD (  20.67  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/12/13 19:31, Damien Le Moal wrote:
> On Sat, 2020-12-12 at 21:50 -0800, Chaitanya Kulkarni wrote:
> [...]
>> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
>> +		unsigned int idx, void *data)
>> +{
>> +	struct blk_zone *zone = data;
>> +
>> +	memcpy(zone, z, sizeof(struct blk_zone));
> 
> See below. This is not necessary.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)
>> +{
>> +	struct blk_zone zone;
>> +	int reported_zones;
>> +	unsigned int zno;
>> +
>> +	if (bdev->bd_disk->queue->conv_zones_bitmap)
>> +		return false;
> 
> Bug.
> 
>> +
>> +	for (zno = 0; zno < blk_queue_nr_zones(bdev->bd_disk->queue); zno++) {
> 
> Large capacity SMR drives have over 75,000 zones these days. Doing a report
> zones one zone at a time will take forever. This needs to be optimized: see
> below.
> 
>> +		reported_zones = blkdev_report_zones(bdev,
>> +				zno * bdev_zone_sectors(bdev), 1,
>> +				nvmet_bdev_validate_zns_zones_cb,
>> +				&zone);
>> +
>> +		if (reported_zones != 1)
>> +			return true;
>> +
>> +		if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL)
>> +			return true;
> 
> This test should be in the nvmet_bdev_validate_zns_zones_cb() callback. That
> callback can return an error if it finds a conventional zone. That will stop
> blkdev_report_zones().
> 
> 
>> +	}
>> +
>> +	return false;
>> +}
> 
> What about this:
> 
> static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
> 					    unsigned int idx, void *data)
> {
> 	if (z->type == BLK_ZONE_TYPE_CONVENTIONAL)
> 		return -ENOTSUPP;
> 	return 0;
> }
> 
> static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)
> {
> 	int ret;
> 
> 	if (bdev->bd_disk->queue->conv_zones_bitmap)
> 		return true;
> 
> 	ret = blkdev_report_zones(bdev,
> 			get_capacity(bdev->bd_disk), blkdev_nr_zones(bdev),
> 			nvmet_bdev_validate_zns_zones_cb, NULL);

Oops. This is wrong. This should be:

	ret = blkdev_report_zones(bdev, 0, blkdev_nr_zones(bdev->bd_disk),
				  nvmet_bdev_validate_zns_zones_cb, NULL);

> 	if (ret < 1)
> 		return true;
> 
> 	return false;
> }
> 
> All zones are checked using the callback with the loop in
> blkdev_report_zones().
> 
> [...]
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>> +{
>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>> +	struct request_queue *q = req->ns->bdev->bd_disk->queue;
>> +	unsigned int max_sects = queue_max_zone_append_sectors(q);
>> +	u16 status = NVME_SC_SUCCESS;
>> +	unsigned int total_len = 0;
>> +	struct scatterlist *sg;
>> +	int ret = 0, sg_cnt;
>> +	struct bio *bio;
>> +
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>> +		return;
>> +
>> +	if (!req->sg_cnt) {
>> +		nvmet_req_complete(req, 0);
>> +		return;
>> +	}
>> +
>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>> +		bio = &req->b.inline_bio;
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>> +	} else {
>> +		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
>> +	}
>> +
>> +	bio_set_dev(bio, req->ns->bdev);
>> +	bio->bi_iter.bi_sector = sect;
>> +	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
>> +		bio->bi_opf |= REQ_FUA;
>> +
>> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
>> +		struct page *p = sg_page(sg);
>> +		unsigned int l = sg->length;
>> +		unsigned int o = sg->offset;
>> +		bool same_page = false;
>> +
>> +		ret = bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);
>> +		if (ret != sg->length) {
>> +			status = NVME_SC_INTERNAL;
>> +			goto out_bio_put;
>> +		}
>> +		if (same_page)
>> +			put_page(p);
>> +
>> +		total_len += sg->length;
>> +	}
>> +
>> +	if (total_len != nvmet_rw_data_len(req)) {
>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>> +		goto out_bio_put;
>> +	}
>> +
>> +	ret = submit_bio_wait(bio);
>> +	status = ret < 0 ? NVME_SC_INTERNAL : status;
>> +
>> +	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
>> +						 bio->bi_iter.bi_sector);
> 
> Why set this if the BIO failed ? There may be no problems doing so, but I do
> not see the point either.
> 
>> +
>> +out_bio_put:
>> +	if (bio != &req->b.inline_bio)
>> +		bio_put(bio);
>> +	nvmet_req_complete(req, status);
>> +}
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
