Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC8C4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 16:26:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4513123D3C
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 16:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4513123D3C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=irt5cq0ucSiS3Oe3IpHuzkIopxWb3wZjKwkB4J7dXnM=; b=OXjkH8c2PxvrfXzjlcyu2kik/
	L6U7hwcifCmCnKLDh4oBcPxtfKYpOVU1J0H4/QLt9t2WUFw/7eRXyKNu+xk2a/FMWifsuFi/Nf/e7
	RSKC9ltJLC1XMwu52JyMt8i/yM7PumsISvMVnG+W79dfI5eSqBR9HJkJbXnS3hCxB6ASXrzQAmz+7
	NNJVjrRxbLID/5wE67DKkF5lz3802Eswh1gxnliwrwsRit9yD0fOOhBQDaJhYFMvUG42nN8R0/JxC
	e2XXIAc57A6L++3tS1TZ2hAkK2y8G8nfVE27H8epQ7/bwmMJz3b/pp62215gvYjeR1G+T6yNt6Sto
	ZjZe0f7VA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knlFA-0006qJ-Nv; Fri, 11 Dec 2020 16:26:08 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knlF5-0006pm-Gf
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 16:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607704088; x=1639240088;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/0LRgM6P7Jw0ITHgnURkK9KPdHGJx3EOGYmQvmd4TBU=;
 b=L3vHhOaUvbgOKSCWGUVJnJeGaI9+ulw59gsSAeigvyxicPzBUYfWqW3k
 yGn3FpKSaayHZYJKzMvlYkvulMH1a82pNaYkyrZ9cHbIW4CqLKVkP+sGW
 mEa5iYgxqOzf8UFsK29p/2121iilK0tSA8admKG218z7OyODD8lcuEecZ
 PqTBhFcEldk+aBaJPBnbqTmkththuqdFuVIKAY4MVp7KhNZU4vzZXqI4M
 LQnXm27Ld83krugvcgnYILaE+CZ7C63uXzxdytXcp3zIulg06e8gXc6bK
 pz7rKJCL6SlgaDT9LPXGyAakcfNAqXfKcN5PiYYwhpeOvT6Wk0eANobm0 w==;
IronPort-SDR: 3KFJbNYFL8JmzKKepNliLy4A9LmIeAaXx/Y0Xr3GF+GVUEk76BG9X0ex2Cs3RYbAPBPfcO/DAh
 wxxtTdFc1CSFkDhMaxtJPbtzJJCJ6oo3jfEq8iYkmJcelAmE+l4sN3hTGPZZ58f+OxBik6Qyrj
 tE3WkUkvYcDAKUVCCoz/tqmuoawmvfDmg7zvw/idgCe1UCZcCXp5RimGLiePVUAL35nOo68ksu
 oSrZlRaWuWAQDKGdb5g5MmMgmNUStrzF348M+XHQ0YtICIyI5JbaWyVH7vyo4+Pvlm1CKHGQ9c
 4K8=
X-IronPort-AV: E=Sophos;i="5.78,411,1599494400"; d="scan'208";a="258685781"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
 by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 00:28:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJJpMSdn6mH/E43AdtJz35QXgn5BNsWNoFOxgeKGKFP44pruEXKMGH/Ffrz2d6WMJF8Dplk2BT6uEClJwkI0ZFgZIJjuvGaZBX0jvkrHGb7sgEiSc4BVR5X1CrM5BSwl+MZ8gJ7UobT0VrIRFrzzlomgu8SgB+UjoCF5MvA3XD/5e8ZCW0kfAutjKK21PWUYDmpBBTJfrCOyU5DG3HDpgkDXgo42aNBAe3mZvRZOYxB5PrpZUU19YcGDJx0TlaTdmdb4B4Swj9CH4YuI0lb2ALQ0UxKxaOwB+9AdtKNMnmXFt3ItCog8kzJBkxkmRgonMf7ZWm2CNvzWAo8ijwggMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU8po3KooHPk9dZPeptM1TmsRMACH+3oAr2oqpho3zA=;
 b=aJPwqxsJphJXyXwBXrIb5Sx5PTZWCEmGogBVDTzPhhAPNM0qAyA53T3tM8uIcv4qT6F4r6NVY5oqWHIzIs7PzneJ4dzW5VrQ70zwHbCx+TLkh+2xb/aOYPh79QGaMcIz5J7ystB5oNm+IN/HB2zgA7UeMobV8Obp++HuH/s1HszZOULR60t5TLBEjS8R47Gb7BPo4AwbtwoxSvN7om6ktWuxkYckcpK9EMo2lQWNxVGK6nMdbodmfZpTNzKc2UM456yKbg/sgooBp34HCje9ugPEw/QXXaDiXxmcFE1+E1L5nTHt/G7zHxl2Pnywh7I15R+xcdQrLcoNE7QMlc1BuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU8po3KooHPk9dZPeptM1TmsRMACH+3oAr2oqpho3zA=;
 b=TmB0pZg5Lp/yhBiTBEJfNLu1/Wy6fC4iDxwz1tYUehruRv2s2TvDbLbTOBinFHNS+rGrRysFt2oT5orWBShGzznEnWEqPRgceUZ5CUyF9vvGzgqpIWsPOw+zxPLIIPJuAUQ1crHRHsAXJqkJwQD42Xh3ilizMpcUETf6As8ub20=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2143.namprd04.prod.outlook.com
 (2603:10b6:804:e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 16:25:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Fri, 11 Dec 2020
 16:25:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH v3 1/2] block: add simple copy support
Thread-Topic: [RFC PATCH v3 1/2] block: add simple copy support
Thread-Index: AQHWz83y7bUu+jQhLUujuAOdfzAPcw==
Date: Fri, 11 Dec 2020 16:25:57 +0000
Message-ID: <SN4PR0401MB359867B95139ACD1ACFF0E709BCA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201211135139.49232-1-selvakuma.s1@samsung.com>
 <CGME20201211135200epcas5p217eaa00b35a59b3468c198d85309fd7d@epcas5p2.samsung.com>
 <20201211135139.49232-2-selvakuma.s1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 350dcab8-f7d2-4aef-4f64-08d89df170a1
x-ms-traffictypediagnostic: SN2PR04MB2143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB21439BAF7E03A5EE175205B59BCA0@SN2PR04MB2143.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0/z9C2lKihgmLqDmO0DBr1PGZyf00HH7Ob61BT6gRF43tEFb/ZsGSQcXGJ93yhS1JWh12J6Y8WIOL1CEdH9F0Of+l6NCqGJVQj1bYipHxfltEK/1vJmSGobAboNiu/VP2FiezXjeppSwVNmHhIWM2iknZ/u6neQ6oUyADEXq++EKDqqZlV/bOpEudkP5bavTPDyWGjVVzZzU9Lf1HVe1Su9Oq9o+4UkCT3aoSUmKp47J3V+hs5HWEkn11RbvTizEVJQjWUMfpURqBdqZZp5ItHO/dHR6jKSP6HpjkSOSm45LU1hpZ8vTHoowt9jYdNCZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(2906002)(76116006)(66476007)(64756008)(186003)(66446008)(71200400001)(110136005)(53546011)(7416002)(33656002)(55016002)(52536014)(8676002)(66946007)(8936002)(86362001)(7696005)(83380400001)(66556008)(9686003)(4326008)(91956017)(508600001)(54906003)(26005)(6506007)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?o/8mc+OP6SxgDy2SY29553XGgMWUazCqlMZ/q7HEJN0FxceCRvbYOLZ3Tanu?=
 =?us-ascii?Q?/A/4I8KgrP67ni/BwPHFOOA+2Wtim9bhg84QAfq1oXKfHYsMmKtQjzffjVu2?=
 =?us-ascii?Q?lEqs1wwEBB59nFJlKHpBrAm6JBUN6GinBc2wWpi+6LLXO3M+ovivARgVctqm?=
 =?us-ascii?Q?Tka24Jjx0EA7eULiMDgJyeizzxnYmjLggBkkoER7Gho3rfQBkny1MRDSVuUJ?=
 =?us-ascii?Q?KtGr5658jfXz5Rse9wktl4L3gHtXpiHS3AypJKuDFjE2AHRkz54u201GtKvN?=
 =?us-ascii?Q?uzjxkZLAn9AHU7usg89Gev2sb2sYaSGB5jsixjknObyE9EyofhrWj0wcbEud?=
 =?us-ascii?Q?jIEm7rZO+3UqI6kLBgIRwoktzilB1ZuDsoDObX3436vLScDyu1hCLWlhzY1u?=
 =?us-ascii?Q?EtE51lgejkbncUGvnZus718YG81NGL9ylXx1R3Lget+a9wOoiOIZMy+2sF4V?=
 =?us-ascii?Q?KyeTLQG0Ilpz4XuO84883FURUKJBl+3u/2pT8d8nouMrNFJQFTknXsxnXv5H?=
 =?us-ascii?Q?EAzvfpPyZXSiqUZgDXuSACA/XfSQ9LDlte73tXDEd/945NKQMC9EeQxbluP7?=
 =?us-ascii?Q?0lp3UhWASumQMmCrsFWlzAnglQICpfBE7+JUrG5GmlH9B5yKsYA9Pi+yywlK?=
 =?us-ascii?Q?gRJbo1Aa4icr3QB4Dt2hnxzgLggw/zXPC2YS8vS2OPROe9ggBMe+Z8/0r6DS?=
 =?us-ascii?Q?OEjfZ+/HKaYHIBIOaI1DX9LVPchVZIJZgnV+TqN1yAqvLsxcO7mKVjB9O/4s?=
 =?us-ascii?Q?zEBuC7dP/Rv8SZXhZERznY8HzqdeuYyPBFenWz/vmaeuzKBzWWWtYFrJSdj2?=
 =?us-ascii?Q?rpvPkQLXc0a5NwUXlqM66MxJRBSB5OVYRhChA2ncFA55DlvVc6I1+xFUpBsI?=
 =?us-ascii?Q?qOoRvIteb6KCNVCL25ohU1lXc+skO7wPSgA/15LS55UcQs91YaiFmNtGVNr1?=
 =?us-ascii?Q?r9Q4o1gQxa2iDEBO/5Q8NW40wCr/uNZAA2TRdmNF+bavxG0+9r0TFVfC80Cn?=
 =?us-ascii?Q?Wl3R?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350dcab8-f7d2-4aef-4f64-08d89df170a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 16:25:57.3695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djyFGdR9AjKUyY8KLcZJgBfxKBS+dY9MYgddnJvK575qF22vOpzJ26qaDm+jl3oxtgEGEWDkuazNWm9hj4Faqg2nvJo7nYsgbgksG/0Yd9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2143
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_112603_803974_B20C14DD 
X-CRM114-Status: GOOD (  15.12  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>, "hch@lst.de" <hch@lst.de>,
 "bvanassche@acm.org" <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/12/2020 15:57, SelvaKumar S wrote:
[...] 
> +int blk_copy_emulate(struct block_device *bdev, struct blk_copy_payload *payload,
> +		gfp_t gfp_mask)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	struct bio *bio;
> +	void *buf = NULL;
> +	int i, nr_srcs, max_range_len, ret, cur_dest, cur_size;
> +
> +	nr_srcs = payload->copy_range;
> +	max_range_len = q->limits.max_copy_range_sectors << SECTOR_SHIFT;
> +	cur_dest = payload->dest;
> +	buf = kvmalloc(max_range_len, GFP_ATOMIC);

Why GFP_ATOMIC and not the passed in gfp_mask? Especially as this is a kvmalloc()
which has the potential to grow quite big.

> +int __blkdev_issue_copy(struct block_device *bdev, sector_t dest,
> +		sector_t nr_srcs, struct range_entry *rlist, gfp_t gfp_mask,
> +		int flags, struct bio **biop)
> +{

[...]

> +	total_size = struct_size(payload, range, nr_srcs);
> +	payload = kmalloc(total_size, GFP_ATOMIC | __GFP_NOWARN);

Same here. 


> diff --git a/block/ioctl.c b/block/ioctl.c
> index 6b785181344f..a4a507d85e56 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -142,6 +142,47 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
>  				    GFP_KERNEL, flags);
>  }
>  
> +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> +		unsigned long arg, unsigned long flags)
> +{

[...]

> +
> +	rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
> +			GFP_ATOMIC | __GFP_NOWARN);

And here. I think this one can even be GFP_KERNEL.

 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
