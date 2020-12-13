Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AE6C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 10:32:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBAB22D04
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 10:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBAB22D04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O5ME3d6uDfJ989aR7r/yAI7vUhP++1dzCPSJH3OggZA=; b=IeEnPmUq129S6+MAqP6a+1iWu
	76aucXF60xzKL+Q5TJSKB/rzk9qG0ulYMpfUz4wNQ/tFNnIBnC2NanXz9e5eMcnQ41CYHtb+Ckdbl
	EAVa8rmBmfPs80Fi7XSqSmgsj7UdJMI4ogsaOVoJ9XJU3fwJVC9AAI0Qn8u5PUuE3c4W8ipaNWQDr
	3ndLeYyiGgEmxBvyHC1zf35DpKUVLj/2dM0FRKZQhRQfAzITajqit3yK/gxCZA2MFxGprIF0gNPCu
	cxGP4u3i4IBwo61XBFCqzXmORulv03DAoEe9kuRQPttCUf+VHenFm1NgbEXjnGaqCRV2/Y6i07gMY
	o7Oh1iHpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koOfT-000142-4y; Sun, 13 Dec 2020 10:31:56 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koOfO-00012w-AX
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 10:31:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607855510; x=1639391510;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SltVk6KTMbPxcyL/cYnUQ5LDq+j5BC2XgUBxaEf2Np0=;
 b=FR3GNEIPW+ARZkiPkdAej2Lqzzu4iuO835HwfG3JRmtJv9OEni1fI762
 L5eWlMlho2QCzLD49b5HD/HSGkqRfpNjQ/1f5+SmfZ5ba06U7YAEv3hhI
 6y7BKoU0YLB34Cy+4fp4RjOMPNDwV9lWwC7cIuTOaNYn2ObzC+jT1qfHx
 zUaMPCjN5Z9L7wiCPeIg0hmhoOrmsbpOsRYXObktnFAcn5aItHAIoVDgC
 bWfjUoC7QlNFTw5uG6Gt0lgDAs0Wt8qikv1i4iawWgqyS2qJtvQclPvf+
 MGf3oFQc0txqeHQR5y5X+uK07DfGHc9nLKLr9bMXP36RLznXQtzT/NpO4 Q==;
IronPort-SDR: IJdhVxahHZHGM2yZ0/REObP7QE8f4s/EF6okNon6ZxNb7FbrGURcC7xQuZ77w6ZL2U8fUgcpNR
 gIVvYiFPdQdEUqqoBycwd1ic2LZ2L14+yAMsqpDjOpJ+rqmVSo1w8j4pAObs/b/dcXQP2k6xQS
 xaJIKeoO9c3DuXIrl53SIT2IEFkU9n//aBvD+dXie1VAM6vL7OR8GYekExlCH7WFXCfgYKeVtg
 ac9mohtsHGEKJXp7yjwF5t/re/04nmnA9L/F4vU0GpCz9gHASYw9B30aWYgjk5+MBtTkeitsSi
 M3o=
X-IronPort-AV: E=Sophos;i="5.78,416,1599494400"; d="scan'208";a="156238129"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
 by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 18:31:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYAQy2fJSeYH8p5JN8s6pqNHhusWZCjttAd6TG954Ubd/jgpCpjrISmheSe7YjBYQrMPFsq4J8JsMzrE8K+1+QzMqy1fJazQcFFp7277Q+AQHO+yf7ZquTjAlc/+8/sE0ILI7iAMwNwnG/TMSXFNJL4s6jX1EgGc4om7PjNzzPO0aGVwCwotdndvOkPV165WUhSCO0+b9tb7aw+lqhjmE4Z95FKMVD4l+xu3iupwBH05qevJokomJj3LEjDj90dIETzNP3YhmHumlc0Pwu1DUNh2x24siL/UnqtmKY6nEbY7HjDRr13yb7u6x2n3zjIPbAqIYKLPqMxCLwUG0rSL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SltVk6KTMbPxcyL/cYnUQ5LDq+j5BC2XgUBxaEf2Np0=;
 b=TBoqOifEtr3k7/zXx4TldlsG63Lh67X4MjLeTyKLt7SysojtgsK4uxKnIbRWRX3zj4hrda6eHW3AJ6DrVPZqzGZ4CTGNAE+5O8ykyyC06bDK+FK60Oo3v+9+r+zKBlrCWDC89nuQmk7ZA2IbiqVCkz8hlxihM1o143h8RjAxc8Gy3k75MUVpZGKDkSQkLNTDQltGY4WmVcG/6ynfrjukm8/Jk5+wcaXXyTF0nSxg6NgL6SETuc57auErFu19EKk/8Xpna/aOyQAwA05znnYKeMtLORzCJZ0amNvi/EGAZls+rrtFVLz5xDDMnGg8DJ6V2IYbuYUF8W2iZBs2DdmmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SltVk6KTMbPxcyL/cYnUQ5LDq+j5BC2XgUBxaEf2Np0=;
 b=b8zOw6TnTBnJTsVwCa2yZLmf/7z8/pinGwgUdPgRpLW0nRq/CQa9zZH7E/dd2yeAbpyYU/gxWdSF9bGpgGTC2mPlOL4N42VQD0CpSyaf/BAdBBc6wIHkKC9oAdxwDzoPvuXzQL6hYCFOTF3IsE9ptX9j5/PwSzNuZkY0kAjV65g=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7013.namprd04.prod.outlook.com (2603:10b6:610:96::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Sun, 13 Dec
 2020 10:31:44 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Sun, 13 Dec 2020
 10:31:44 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V6 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V6 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0RPvmJIFNb+IOkaBuk4iq3d6e6n01CSA
Date: Sun, 13 Dec 2020 10:31:44 +0000
Message-ID: <3fa59aa6a579b58ffff9fc0f95a34f93c9354618.camel@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
 <20201213055017.7141-5-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20201213055017.7141-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 502b9887-9dbd-45c9-94de-08d89f5249a5
x-ms-traffictypediagnostic: CH2PR04MB7013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB70131EB7B2A2E9E5034BA2F8E7C80@CH2PR04MB7013.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1PhZhlognbK72oGR0eXY2O0LnwcIHmyW8OyuIyRtPXxOf+Z/c9O4sxfvWs/eMilf5jS1nLff3iQgVHm3QV7aA/9ZaxrcM2xHBuiVrxnvxwDcoUzCjjgnwI4Xe6k5/hkWoluXVHzuKF8z6ducGQUQWnekfd79H/35aXW1cJxGKl4LeezYm2rVAnQMpcYrRuR3xtazxCqYNqj6SLfCNNidLhTxOSPUtVguyIuTMT8hnwK860DYHe64oL53pZmExoAJaPdk8Ef+BTAZPKAvWCGABOujNR6pawjqpAYYv9X+RUdSvTfrklK8T4NCTVfMx2L6kjB+tsVUozLBwT+efpXpxw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(8676002)(186003)(5660300002)(6512007)(6506007)(4001150100001)(2616005)(71200400001)(91956017)(66476007)(66446008)(2906002)(6486002)(76116006)(66946007)(36756003)(110136005)(54906003)(66556008)(64756008)(508600001)(4326008)(8936002)(86362001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0tMT1lCYzdhcnp6bUppajlDNERkT3dGMXM5MGswOTJuSGw0Z1k2M25BUHNM?=
 =?utf-8?B?Sk5vRWx1N2ZNM1VDRVNFYTlqTmx1cHlGaVhDL1dBVWZRejdhZHlHVW5EMC9O?=
 =?utf-8?B?d05KT2VGTzVNUDRMaGZ6elc4N05aU2hXSTRvcnN6Z0Y1eit2Y1lBM291SGJ5?=
 =?utf-8?B?OEx6b25DR3BQYnNTY2NpQ3BRVm1rdFNXMGhiU2hEMlNQRTNpVUJPZDlXL2JM?=
 =?utf-8?B?RXQrWGU3WDV3RzVxeUxCbFFBTlhSOEMreERsQ2V6U2syMUNlSnpBNC9XenVI?=
 =?utf-8?B?QkRZUFpFN1hoMXo3N05KczZPak1xRDBGVENuRzZaZklRRFBvRGxhdUJtWUlZ?=
 =?utf-8?B?UEpoeWpGZ1RGdXp0M2VBTlRIcnR2NlhocGFRSmx2ZzdEQlhlMzF0ZWRyaE9H?=
 =?utf-8?B?VFNJeGk4Nk1zeVhKaUxPYmxPZllXT2xKMWdXK3p6S003R2I0KytrUW96RHVX?=
 =?utf-8?B?SmpYbnFFQllGTVUzcDhFVFBPVjl6RXlORUZiN0dRRmRGNzlpRTJRTCtONjRi?=
 =?utf-8?B?Qm95cytMSzExcFJoYUplSnY2bjMzZkV1K051dTNiRERIZzJVWWJRVkRhNm5F?=
 =?utf-8?B?MFVxaGtyYlhVWXg4OFdnRU52a0pNWWlYMFNZWjl4aTM0VzJOUlF3WTg2WmhX?=
 =?utf-8?B?aWJQbGdycUhOdFhkclNVc1MwWTdHZ0NkUDdyMjAzcEdoY3hOeHN3dEZmaDJW?=
 =?utf-8?B?S3NkZGRMMDI1WFhGTUZWZTFqSURUd3dlL281VG5rQWRBVnQvQnNHeGFJeXdQ?=
 =?utf-8?B?U2U1bXF2cEFMQVE3VzJIVjQxSzM3RitxUTFnS3Jad3B4c1BFS09ORlcyb0JQ?=
 =?utf-8?B?WG9Jc2pxeVM4Si85ZlozMU5aRXVJUFZvTmxML0dOSXJ4T3BJZDJodzZJcWVB?=
 =?utf-8?B?SWdFdkZsUGpncjBSVVRHbTZCNGZlelFCU2tjQXNEQWlUNzB5ejlkUGtndHZY?=
 =?utf-8?B?SUl0U0JNVTlTV2VyTXl2b0tiOFUwM2FCbjBmTEhKZEo3ZWtOSkN3WFIwSmoy?=
 =?utf-8?B?N0I4NkhIL29FN3NaVzVrSytTUWJ1YmNWaDNRZ01IUXdhSGRmNllvdTM0VlZh?=
 =?utf-8?B?Y2F4Z2R2bFRnOXh1bFAyZ21ZK2c2V2xOeTIyQmlFMGdKQTJMYS9ubzdjTlBL?=
 =?utf-8?B?Vm1aeDRRRlJuMDhOOEVCcStsZG16NnJFR3V6VmVKaU9jNlp2NEJtaitLdTlz?=
 =?utf-8?B?VGY0WVNVZVFIOThWdWc2VDNlemhGOFM1eTRudWF0cXhiZGRXbVRmVVlsQmFC?=
 =?utf-8?B?VittVEZUWlpRZmU4YnNSRHpnalk0UmtiRTJ6N1g3Z0ZsWkM5MTFIQnJhM1ho?=
 =?utf-8?B?RE9ucVhWK25DV2dmYmpqRWhnZUhQT1Z2aE9QU3JvUFFPbEhTOW85bzdvSDhQ?=
 =?utf-8?B?WDNQeUtTLzRWdkpHREdwbzdmRjRDbHltYzFuVHZPTjNQN3NtS3ZFVkprditT?=
 =?utf-8?Q?cAOmjQy6?=
Content-ID: <81517740E566214380B3B9A7920A1540@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502b9887-9dbd-45c9-94de-08d89f5249a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2020 10:31:44.3323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sN3s0eZz1RUxDw4AoBKnHGvZf3gtCbBuvDMEaswv5Z9/LGI1z9ErHL9vydMzOw9sjUeqaL0KrWA735MIYyUkVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7013
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_053150_789779_87BF7884 
X-CRM114-Status: GOOD (  22.47  )
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

On Sat, 2020-12-12 at 21:50 -0800, Chaitanya Kulkarni wrote:
[...]
> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
> +		unsigned int idx, void *data)
> +{
> +	struct blk_zone *zone = data;
> +
> +	memcpy(zone, z, sizeof(struct blk_zone));

See below. This is not necessary.

> +
> +	return 0;
> +}
> +
> +static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)
> +{
> +	struct blk_zone zone;
> +	int reported_zones;
> +	unsigned int zno;
> +
> +	if (bdev->bd_disk->queue->conv_zones_bitmap)
> +		return false;

Bug.

> +
> +	for (zno = 0; zno < blk_queue_nr_zones(bdev->bd_disk->queue); zno++) {

Large capacity SMR drives have over 75,000 zones these days. Doing a report
zones one zone at a time will take forever. This needs to be optimized: see
below.

> +		reported_zones = blkdev_report_zones(bdev,
> +				zno * bdev_zone_sectors(bdev), 1,
> +				nvmet_bdev_validate_zns_zones_cb,
> +				&zone);
> +
> +		if (reported_zones != 1)
> +			return true;
> +
> +		if (zone.type == BLK_ZONE_TYPE_CONVENTIONAL)
> +			return true;

This test should be in the nvmet_bdev_validate_zns_zones_cb() callback. That
callback can return an error if it finds a conventional zone. That will stop
blkdev_report_zones().


> +	}
> +
> +	return false;
> +}

What about this:

static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,
					    unsigned int idx, void *data)
{
	if (z->type == BLK_ZONE_TYPE_CONVENTIONAL)
		return -ENOTSUPP;
	return 0;
}

static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)
{
	int ret;

	if (bdev->bd_disk->queue->conv_zones_bitmap)
		return true;

	ret = blkdev_report_zones(bdev,
			get_capacity(bdev->bd_disk), bdev_nr_zones(bdev),
			nvmet_bdev_validate_zns_zones_cb, NULL);
	if (ret < 1)
		return true;

	return false;
}

All zones are checked using the callback with the loop in
blkdev_report_zones().

[...]
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
> +{
> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
> +	struct request_queue *q = req->ns->bdev->bd_disk->queue;
> +	unsigned int max_sects = queue_max_zone_append_sectors(q);
> +	u16 status = NVME_SC_SUCCESS;
> +	unsigned int total_len = 0;
> +	struct scatterlist *sg;
> +	int ret = 0, sg_cnt;
> +	struct bio *bio;
> +
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
> +		return;
> +
> +	if (!req->sg_cnt) {
> +		nvmet_req_complete(req, 0);
> +		return;
> +	}
> +
> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
> +		bio = &req->b.inline_bio;
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> +	} else {
> +		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
> +	}
> +
> +	bio_set_dev(bio, req->ns->bdev);
> +	bio->bi_iter.bi_sector = sect;
> +	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
> +		bio->bi_opf |= REQ_FUA;
> +
> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {
> +		struct page *p = sg_page(sg);
> +		unsigned int l = sg->length;
> +		unsigned int o = sg->offset;
> +		bool same_page = false;
> +
> +		ret = bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);
> +		if (ret != sg->length) {
> +			status = NVME_SC_INTERNAL;
> +			goto out_bio_put;
> +		}
> +		if (same_page)
> +			put_page(p);
> +
> +		total_len += sg->length;
> +	}
> +
> +	if (total_len != nvmet_rw_data_len(req)) {
> +		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> +		goto out_bio_put;
> +	}
> +
> +	ret = submit_bio_wait(bio);
> +	status = ret < 0 ? NVME_SC_INTERNAL : status;
> +
> +	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
> +						 bio->bi_iter.bi_sector);

Why set this if the BIO failed ? There may be no problems doing so, but I do
not see the point either.

> +
> +out_bio_put:
> +	if (bio != &req->b.inline_bio)
> +		bio_put(bio);
> +	nvmet_req_complete(req, status);
> +}

-- 
Damien Le Moal
Western Digital
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
