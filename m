Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A71C71155
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 22:37:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D6720671
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 22:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o51W+Thj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OMC9SAbY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oPCNFwWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D6720671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=LqJQaTjD6FaI0uA01b15Pfu7RSs/6N8n40x6HiyZb8c=; b=o51W+ThjI8Jxs66UyEkvFady+
	xFOXh6n7MnxEOB78+8/LjZxhtfP9RzmvE14WB1bpLh96ISRmWDtZiPc3Yp0QRXXsrfmxtYIQnBBFr
	ty0BloFqtzKTdTvctfwRpoD0DjfDbGTnhBXmiMOsIx06RS3T308GvRoh6pBCjVxxpUWlPtjOhMZFN
	2NzDhKqN8A6/GI2PWbO3omIhM8Il7ACaryD4kODuMTbo97OavLBlSjLorGs2+xJYm765CdaqNTTNZ
	bytGaLW1ovUHFD5D/sPHqopRCAcrXHk1l55P6GJ0F6+dh5h9mDhk8qyIbhsfdbPZEfcRDLpfeN9E7
	Wae17bo0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkEHA-00087j-7d; Tue, 01 Dec 2020 22:37:36 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkEH5-00085Y-Nv
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 22:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606862251; x=1638398251;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2gVvscwDBGO/jzNcM3Rly0Pa5sdzu1M5hQCCC1m5JT8=;
 b=OMC9SAbYg4xwfWQgXgjY1ijFqlkePOv9jeFc+s8xUw92NeCEW35fAiVX
 uy5p1F1EEEAkJNfvxuasvzDfw9DozJGhDNrl0EUP7VwPtRcFMsiddiVru
 0Xvxc8lw8B6kC91lldeUwfh4uOJwTf31oizsR4gqlV9GiLiEAY5xapQ4n
 vHk9Jv6ib51xvT02hyn3irGL5sMubyHnOvdd7p221i5vy/ZUCmPaKja7B
 txUAZOBz09wjuVSiUgusTyFWZrgttrIzKVRXRyfMvMHKUPlVFR6AY0RhR
 VACZTGw6Ej2E5rDoqPkCaCmwKk9/DrJEy+1RHeAjbBgou62DKvzwV12/w A==;
IronPort-SDR: S3py1Xf5izDw/0mDoH1rG65NRr5O+NLop51zPKYK/J43Q3nPErplIZcGSLfh8Tn3jIvkPevpih
 yFK9qGPxROLxJ8rlBsh6bb41aGvNIMo3pIzutt15NFOVvCJthshFFpnQF1KLxvbJ7u9v2/d/P5
 G9mFrAHQm4EbiyfF6g/FTFAYyKjFSdbfoWs/fBSU4NksHBJzVHvWZrCE+iQ3FE+wt7kZoaF8PD
 zBPwI0jSD58DBnPsdSwtAWRPhelo1uRzTqFs2WR1CfubmjWlaLP0/pRkzreDGLEqKUpHwRMtSt
 wqE=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="153901968"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 06:37:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJuU/Lr4tajbCbSJbNbd6SmXgUy1nj3rcJDigZ6KkoYjYbWObEsRpPg8vKZIZODxFl1kEp/j/RcJlndlAk5GoCMaF0O8v/mXcXHFhVZV8VmJK+yaNKyVakNh1joSNEyE+ZDJmIx/blnM6IyqKn1xoiCrtjZ30bmLJdM6D6Nr9CBUx6d7GwuYOY8NhhnunhQxhuBpZgszXUZtaJuV6BBKoVAuzzrVNQafkTdX6Ehd/o5WCrCiXcgTt9BLdGF7mY0OxYa21xO/07J2g1Jf0kTaQZue5Ua8BeI9ER1hSKgknH2IM9dTcv44/M9LSRe+FXX5KX004g7He2sSosckf0RYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Olr02OM1gWo+xK9ZM7ZeLLjFsW7E4+1bc+zBTapptM=;
 b=FVKjzba/N6LRanXnkazn4ero33WFBVC/JYp1hlLKSi0H2mYzdg6O9t30TrlyQ7EMuZIbIH0vPexoWIEcvNID6sEcLBK/3Goiz4XRtPyaWucj9N9SO86xObJIyzDJRxdcn5y9IbnMof2HNXNJICWSGs6w1GiuOPawNeGlqa6mdnLWCt0cby6mo9dAvckhJxHhN4D0R/F5wmDR84UMpiT6z5S23Baino1jO5BJDERobyDRgwOeTKBdossCiZtEMIwQ0B+5SvS2HYt89LhVw+DBWBfj7HYFox3GdXrfAihVZ/q9Vot3LZsZa+PySF16Ox3rY1rLN5thAosMri4nCrhuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Olr02OM1gWo+xK9ZM7ZeLLjFsW7E4+1bc+zBTapptM=;
 b=oPCNFwWRhfKw6RD+DN+7F6vJNIkoyNclGuOT9x+u9Su/CEbbSXQ+1RommQX01cFVfwWped5VRGSQIPDUOQ5dPUtivhGCfGcXaz6l82d6ooJ9KfmqnK3to5cKVq1Y1+Jl0fVYiradN9M6KE+UgyX2UYG2eFVhdCF+fF1uJ1V8mN8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4327.namprd04.prod.outlook.com (2603:10b6:a02:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Tue, 1 Dec
 2020 22:37:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 22:37:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxskIz83/zqf400uhEmx/aulqvg==
Date: Tue, 1 Dec 2020 22:37:27 +0000
Message-ID: <BYAPR04MB4965A90BF0EC23DFBCB6372F86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652237C06F44FF3C9B6DDD11E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49654A4ECB46346E8445D8AA86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CH2PR04MB6522A475CD3F0F4D123E913BE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5756ca7f-44f1-4584-96f7-08d89649aea3
x-ms-traffictypediagnostic: BYAPR04MB4327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4327FF28D1D8EFBE43EFBB7E86F40@BYAPR04MB4327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+0tBlygHGiNzajLIb74h4GhEn5las1iW4CUb3funnevz900b0jZuTYsEDRflsGN5S2kc4bDMgj5vbZDRV12NOSRSZGvfz7Ei6dV9GiSAqDhGyEUYMsgwnE7deRIVb9IV1QikaEM2NdaupmGqJ0MCct7OtI4cPWLKf4MAZxH9FFbupmWea0wTLAW7LZwaaDReWTunW5jAntj1JDsV1TD2S42iCXllhoKWAart4FcUIKlRzQkBsfQzKjvj6ws4UY1sm7fnl5cjU8VGSlgGRfM/Lxh/7UX9rB4HuQm1R8mGfcnQiv2qBZ8proOEW3U5WG9ESf4DAELis8Yq4z31Fn+Ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(7696005)(55016002)(186003)(26005)(71200400001)(110136005)(54906003)(316002)(33656002)(86362001)(478600001)(8676002)(30864003)(4326008)(8936002)(53546011)(52536014)(83380400001)(66446008)(5660300002)(9686003)(2906002)(76116006)(64756008)(66476007)(6506007)(66946007)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?k+VgUoVED6OXhFV7oNO1W3nwIzVd9EVD9MVVybEUNHgKl7oqtLyVW86tv/vm?=
 =?us-ascii?Q?61twIXECTwRqA7l/uZfHsZA0x9ykSnRWxtiqTx66fsWByI/fB84Ef+lw7Q8L?=
 =?us-ascii?Q?G2xPSTk9hJ2z/E6VKnEtwoPp5oiacmyB2X35xhSzwpz2ncVgz014D2a+fW6H?=
 =?us-ascii?Q?2NWuutCOtGyMx3mWvQxfgGKIINpn/XxpUnJABw1iP6iDyXxSd/UGi9uULOxE?=
 =?us-ascii?Q?JXPF6ALzrYirtyoKae8qTLvJ4twqo5daz8qiDI8ravUXohakzNFIAwqKyKmK?=
 =?us-ascii?Q?ErX2zj0V59hnZC7VVEGBXIXS0PJ9UrRvVJ53pGRcDwJo4lXGELvCnCWQD2vi?=
 =?us-ascii?Q?8DHCQDV3q2dHEKUbQ/6OQnb+qmfshRldX26eFt7MQa1zQpBJqoU6yNmDdm4O?=
 =?us-ascii?Q?XFm8QJf8ZO/JpG6PKWMRvTFLqKgpFtfVTlAdxJqePM+UlvumE76yKpBvXDgd?=
 =?us-ascii?Q?GvcZhKbaMI+uSU//IYq/rmF9dBekFWtW+2yhdHrzJr2a9dhV+Ss4ku8pw+FJ?=
 =?us-ascii?Q?oeEP3n/3jLKkO6aKi9HQWIV0sYj0/ZSljijk70qYn65m0z+hBZRr/rEIeeU3?=
 =?us-ascii?Q?tZYEV6DvNS2wNbJCFh7B4UnB/PDVOrwnqzmbnnpJZm03LoBxJSa3xZQlTdZ1?=
 =?us-ascii?Q?9rT2Geow3/DfjCg38qH3CJb91xv/csj3EumqqhAqsJ41zqqVSPIKj/hRFGuX?=
 =?us-ascii?Q?caT2lOGov9NorIbpL/9Ek7ZrfDQTvK1v3U+vxKMugSkL2kHWWH2wuW2FM6n3?=
 =?us-ascii?Q?0GdM0XrGCXZ9P7lZFarrHQMjmRTFlF/Rb97k81d8zbK3ytrF8S3FVIsxi+9r?=
 =?us-ascii?Q?CcQdZac0tFpZpSghs4OuMuBsaVzpi6Gn3F8wi7duPjG4S05quH6eney544Sa?=
 =?us-ascii?Q?mVf8u77/CgGWfq3c5i/fKuMa0U2W1Eje2wwCmxNqG9ppm3hTDMqGuGsnOcX5?=
 =?us-ascii?Q?NRPIE26FLK+rNmmvUtNtya58sR5J2k0tRAwAM9ZcItW/8Xck8B3dJ3jpOLp/?=
 =?us-ascii?Q?0GTR?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5756ca7f-44f1-4584-96f7-08d89649aea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 22:37:27.6172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NtsLN/GRB2XmHOJzvpf6sQ9PDtgKRoKMcojHZ8YesoFAG8TYobUD7UY7Q+wNzipdI7RSN636S9K7lr5eByHOqPuXlkWWjl/OneC8Sn6UZdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4327
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_173731_966147_9805E0A7 
X-CRM114-Status: GOOD (  16.33  )
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

On 11/30/20 21:44, Damien Le Moal wrote:
> On 2020/12/01 12:38, Chaitanya Kulkarni wrote:
> [...]
>>>> +	 * namespaces.
>>>> +	 */
>>>> +	min_zasl = ns->zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
>>>> +
>>>> +	xa_for_each(&(ns->subsys->namespaces), idx, ins) {
>>>> +		struct request_queue *iq = ins->bdev->bd_disk->queue;
>>>> +		unsigned int imax_za_sects = queue_max_zone_append_sectors(iq);
>>>> +		u8 izasl = nvmet_zasl(imax_za_sects);
>>>> +
>>>> +		if (!bdev_is_zoned(ins->bdev))
>>>> +			continue;
>>>> +
>>>> +		min_zasl = min_zasl > izasl ? izasl : min_zasl;
>>>> +	}
>>>> +
>>>> +	ns->subsys->id_ctrl_zns.zasl = min_t(u8, min_zasl, bio_max_zasl);
>>> I do not understand what bio_max_zasl is used for here, as it does not represent
>>> anything related to the zoned namespaces backends.
>> If we don't consider the bio max zasl then we will get the request more than
>> one bio can handle for zone append and will lead to bio split whichneeds to
>> be avoided.
> Why ? zasl comes from the target backend max zone append sectors, which we
> already know is OK and does not lead to BIO splitting for zone append. So why do
> you need an extra verification against that bio_max_zasl ?
>
>>>> +}> +
>>>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
>>>> +{
>>>> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {
>>>> +		pr_err("block devices with conventional zones are not supported.");
>>>> +		return false;
>>>> +	}
>>> It may be better to move this test in nvmet_bdev_validate_zns_zones(), so that
>>> all backend zone configuration checks are together.
>> Okay.
>>>> +
>>>> +	if (!nvmet_bdev_validate_zns_zones(ns))
>>>> +		return false;
>>>> +
>>>> +	/*
>>>> +	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
>>>> +	 * to the device physical block size. So use this value as the logical
>>>> +	 * block size to avoid errors.
>>>> +	 */
>>>> +	ns->blksize_shift = blksize_bits(bdev_physical_block_size(ns->bdev));
>>>> +
>>>> +	nvmet_zns_update_zasl(ns);
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +/*
>>>> + * ZNS related Admin and I/O command handlers.
>>>> + */
>>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>>>> +{
>>>> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>>>> +	struct nvme_id_ctrl_zns *id;
>>>> +	u16 status = 0;
>>>> +	u8 mdts;
>>>> +
>>>> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
>>>> +	if (!id) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Even though this function sets Zone Append Size Limit to 0,
>>>> +	 * the 0 value here indicates that the maximum data transfer size for
>>>> +	 * the Zone Append command is indicated by the ctrl
>>>> +	 * Maximum Data Transfer Size (MDTS).
>>>> +	 */
>>> I do not understand this comment. It does not really exactly match what the code
>>> below is doing.
>> Let me fix the code and the comment in next version.
>>>> +
>>>> +	mdts = ctrl->ops->get_mdts ? ctrl->ops->get_mdts(ctrl) : 0;
>>>> +
>>>> +	id->zasl = min_t(u8, mdts, req->sq->ctrl->subsys->id_ctrl_zns.zasl);
>>>> +
>>>> +	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
>>>> +
>>>> +	kfree(id);
>>>> +out:
>>>> +	nvmet_req_complete(req, status);
>>>> +}
>>>> +
>>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>>> +{
>>>> +	struct nvme_id_ns_zns *id_zns;
>>>> +	u16 status = 0;
>>>> +	u64 zsze;
>>>> +
>>>> +	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
>>>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	id_zns = kzalloc(sizeof(*id_zns), GFP_KERNEL);
>>>> +	if (!id_zns) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
>>>> +	if (!req->ns) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto done;
>>>> +	}
>>>> +
>>>> +	if (!bdev_is_zoned(nvmet_bdev(req))) {
>>>> +		req->error_loc = offsetof(struct nvme_identify, nsid);
>>>> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
>>>> +		goto done;
>>>> +	}
>>>> +
>>>> +	nvmet_ns_revalidate(req->ns);
>>>> +	zsze = (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>
>>>> +					req->ns->blksize_shift;
>>>> +	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
>>>> +	id_zns->mor = cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));
>>>> +	id_zns->mar = cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));
>>>> +
>>>> +done:
>>>> +	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
>>>> +	kfree(id_zns);
>>>> +out:
>>>> +	nvmet_req_complete(req, status);
>>>> +}
>>>> +
>>>> +struct nvmet_report_zone_data {
>>>> +	struct nvmet_ns *ns;
>>>> +	struct nvme_zone_report *rz;
>>>> +};
>>>> +
>>>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int idx,
>>>> +				     void *data)
>>>> +{
>>>> +	struct nvmet_report_zone_data *report_zone_data = data;
>>>> +	struct nvme_zone_descriptor *entries = report_zone_data->rz->entries;
>>>> +	struct nvmet_ns *ns = report_zone_data->ns;
>>>> +
>>>> +	entries[idx].zcap = cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));
>>>> +	entries[idx].zslba = cpu_to_le64(nvmet_sect_to_lba(ns, z->start));
>>>> +	entries[idx].wp = cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));
>>>> +	entries[idx].za = z->reset ? 1 << 2 : 0;
>>>> +	entries[idx].zt = z->type;
>>>> +	entries[idx].zs = z->cond << 4;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>>> +{
>>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>> size_t ?
>> Yes.
>>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>>> +	struct nvme_zone_mgmt_recv_cmd *zmr = &req->cmd->zmr;
>>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(zmr->slba));
>>>> +	unsigned int nr_zones = bufsize / nvmet_zones_to_desc_size(1);
>>> I think this is wrong since nvmet_zones_to_desc_size includes sizeof(struct
>>> nvme_zone_report). I think what you want here is:
>>>
>>> nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>> 	sizeof(struct nvme_zone_descriptor);
>>>
>>> And then you can get rid of nvmet_zones_to_desc_size();
>> Yes, it doesn't need nvmet_zones_to_desc_size() anymore from v1.
>>>> +	int reported_zones;Maybe there is better way.
>>>> +	u16 status;
>>>> +
>>>> +	status = nvmet_bdev_zns_checks(req);
>>>> +	if (status)
>>>> +		goto out;
>>>> +
>>>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
>>>> +	if (!data.rz) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	reported_zones = blkdev_report_zones(nvmet_bdev(req), sect, nr_zones,
>>>> +					     nvmet_bdev_report_zone_cb,
>>>> +					     &data);
>>>> +	if (reported_zones < 0) {
>>>> +		status = NVME_SC_INTERNAL;
>>>> +		goto out_free_report_zones;
>>>> +	}
>>>> +
>>>> +	data.rz->nr_zones = cpu_to_le64(reported_zones);
>>>> +
>>>> +	status = nvmet_copy_to_sgl(req, 0, data.rz, bufsize);
>>>> +
>>>> +out_free_report_zones:
>>>> +	kvfree(data.rz);
>>>> +out:
>>>> +	nvmet_req_complete(req, status);
>>>> +}
>>>> +
>>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>>> +{
>>>> +	sector_t nr_sect = bdev_zone_sectors(nvmet_bdev(req));
>>>> +	struct nvme_zone_mgmt_send_cmd *c = &req->cmd->zms;
>>>> +	enum req_opf op = REQ_OP_LAST;
>>>> +	u16 status = NVME_SC_SUCCESS;
>>>> +	sector_t sect;
>>>> +	int ret;
>>>> +
>>>> +	sect = nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));
>>>> +
>>>> +	switch (c->zsa) {
>>>> +	case NVME_ZONE_OPEN:
>>>> +		op = REQ_OP_ZONE_OPEN;
>>>> +		break;
>>>> +	case NVME_ZONE_CLOSE:
>>>> +		op = REQ_OP_ZONE_CLOSE;
>>>> +		break;
>>>> +	case NVME_ZONE_FINISH:
>>>> +		op = REQ_OP_ZONE_FINISH;
>>>> +		break;
>>>> +	case NVME_ZONE_RESET:
>>>> +		if (c->select_all)
>>>> +			nr_sect = get_capacity(nvmet_bdev(req)->bd_disk);
>>>> +		op = REQ_OP_ZONE_RESET;
>>>> +		break;
>>>> +	default:
>>>> +		status = NVME_SC_INVALID_FIELD;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	ret = blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL);
>>>> +	if (ret)
>>>> +		status = NVME_SC_INTERNAL;
>>>> +
>>>> +out:
>>>> +	nvmet_req_complete(req, status);
>>>> +}
>>>> +
>>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>>> +{
>>>> +	unsigned long bv_cnt = req->sg_cnt;
>>>> +	int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
>>>> +	u64 slba = le64_to_cpu(req->cmd->rw.slba);
>>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, slba);
>>>> +	u16 status = NVME_SC_SUCCESS;
>>>> +	size_t mapped_data_len = 0;
>>>> +	int sg_cnt = req->sg_cnt;
>>>> +	struct scatterlist *sg;
>>>> +	struct iov_iter from;
>>>> +	struct bio_vec *bvec;
>>>> +	size_t mapped_cnt;
>>>> +	struct bio *bio;
>>>> +	int ret;
>>>> +
>>>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>>>> +		return;
>>>> +
>>>> +	/*
>>>> +	 * When setting the ctrl->zasl we consider the BIO_MAX_PAGES so that we
>>>> +	 * don't have to split the bio, i.e. we shouldn't get
>>>> +	 * sg_cnt > BIO_MAX_PAGES since zasl on the host will limit the I/Os
>>>> +	 * with the size that considers the BIO_MAX_PAGES.
>>>> +	 */
>>> What ? Unclear... You advertize max zone append as ctrl->zasl = min(all ns max
>>> zone append sectors). What does BIO_MAX_PAGES has to do with anything ?
>> That is not true, ctrl->zasl is advertised
>> min(min all ns max zone append sectors), bio_max_zasl) to avoid the
>> splitting
>> of the bio on the target side:-
> We already know that zasl for each NS, given by the max zone append sector of
> the backends, are already OK, regardless of BIO_MAX_PAGES (see below).
>
>> See nvmet_zns_update_zasl()
>>
>> +	ns->subsys->id_ctrl_zns.zasl = min_t(u8, min_zasl, bio_max_zasl);
>>
>> Without considering the bio_max_pages we may have to set the ctrl->zasl
>> value
>> thatis > bio_max_pages_zasl, then we'll get a request that is greater
>> than what
>> one bio can handle, that will lead to splitting the bios, which we want to
>> avoid as per the comment in the V1.
>>
>> Can you please explain what is wrong with this approach which regulates the
>> zasl with all the possible namespaces zasl and bio_zasl?
> For starter, with multi-page bvecs now, I am not sure BIO_MAX_PAGES makes any
> sense anymore. Next, on the target side, the max zone append sectors limit for
> each NS guarantee that a single BIO can be used without splitting needed. Taking
> the min  of all of them will NOT remove that guarantee. Hence I think that
> BIO_MAX_PAGES has nothing to do in the middle of all this.
>
Okay, let me remove the bio size check and send v4.
>> May be there is better way?
>>>> +	if (!req->sg_cnt)
>>>> +		goto out;
>>>> +
>>>> +	if (WARN_ON(req->sg_cnt > BIO_MAX_PAGES)) {
>>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	bvec = kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);
>>>> +	if (!bvec) {
>>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {
>>>> +		nvmet_file_init_bvec(bvec, sg);
>>>> +		mapped_data_len += bvec[mapped_cnt].bv_len;
>>>> +		sg_cnt--;
>>>> +		if (mapped_cnt == bv_cnt)
>>>> +			brhigh frequency I/O operationeak;
>>>> +	}
>>>> +
>>>> +	if (WARN_ON(sg_cnt)) {
>>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>> +	iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);
>>>> +
>>>> +	bio = bio_alloc(GFP_KERNEL, bv_cnt);
>>>> +	bio_set_dev(bio, nvmet_bdev(req));
>>>> +	bio->bi_iter.bi_sector = sect;
>>>> +	bio->bi_opf = op;
>>> The op variable is used only here. It is not necessary.
>> Yes.
>>>> +
>>>> +	ret =  __bio_iov_append_get_pages(bio, &from);
>>> I still do not see why bio_iov_iter_get_pages() does not work here. Would you
>>> care to explain please ?
>>>
>> The same reason pointed out by the Johannes. Instead of calling wrapper,
>> call the underlaying core API, since we don't care about the rest of the
>> generic code. This also avoids an extra function callfor zone-append
>> fast path.
> I am still not convinced that __bio_iov_append_get_pages() will do the right
> thing as it lacks the loop that bio_iov_iter_get_pages() has.
>
>>>> +	if (unlikely(ret)) {
>>>> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
>>>> +		bio_io_error(bio);
>>>> +		goto bvec_free;
>>>> +	}
>>>> +
>>>> +	ret = submit_bio_wait(bio);
>>>> +	status = ret < 0 ? NVME_SC_INTERNAL : status;
>>>> +	bio_put(bio);
>>>> +
>>>> +	sect += (mapped_data_len >> 9);
>>>> +	req->cqe->result.u64 = le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));
>>>> +
>>>> +bvec_free:
>>>> +	kfree(bvec);
>>>> +
>>>> +out:
>>>> +	nvmet_req_complete(req, status);
>>>> +}
>>>> +
>>>> +#else  /* CONFIG_BLK_DEV_ZONED */
>>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
>>>> +{
>>>> +}
>>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>>> +{
>>>> +}
>>>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)
>>>> +{
>>>> +	return false;
>>>> +}
>>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>>> +{
>>>> +}
>>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>>> +{
>>>> +}
>>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>>> +{
>>>> +}
>>>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)
>>>> +{
>>>> +}
>>>> +#endif /* CONFIG_BLK_DEV_ZONED */
>>>>
>>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
