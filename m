Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2F8C5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mudKu77TYvx5Wc961AnAqTG5a0YjtyocFHB5JP0a8Y=; b=upk/vo4azFf6GG/T6coMPu9zzF
	T4x+ENzj5rHTrb0eN5J+WHBJRCBfwh7QX/YJ948/SRE9cjpy+AuukQprcDTeofDJQX3NabyH+MyCE
	XOZtB+pu/pBcRD8JEsmgdlDFHnM91pAYwazQHCJ1y0Bj1/DVBPisBkOJH03YAeTVQC9n8X2CPfQcv
	iSYTIUXEqNnATb80Ly3L+3vSP+5sOFJ2p/Aa7d+FPTx7cly7dtl8NgsNFfnPTGeCFRIXFo3WuPXO0
	4OctcdHVbDrvQ8srtzYT8crMVqmSkAK2nPCZNiP/pM8K+X4K7sT12fjgh+dd42u8bH/TW/4TacyHB
	LqJBU3DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sibdK-00000007oK3-1nmi;
	Mon, 26 Aug 2024 15:27:54 +0000
Received: from mail-westusazolkn190120001.outbound.protection.outlook.com ([2a01:111:f403:d001::1] helo=SJ2PR03CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sibd4-00000007oBd-2hY7
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 15:27:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9H1+DkuJGmGHZ/DYVqqWfwl9z5r8jNnprrkg4c6iq0JUwBtEjuyFxLozYvUULsbxyQATjTy9TZbR3iRsXGkB16rQ3MkYV0dgnn6OzAblHWuNHXoLPemY4qBdUso4+s2VRFVLhcdtibcTHEHcARn6QTf+DoMokJXfG6jlWQbZqSXlgVcj9AE75JKXCQ4/yVZJR8L/JtIfFNbEzC+HgzAXpVPrZs6JfYyTNtqPHLZbpAIEbuDwjgkTMm0V4dBOqBcdGVTiCG5T//umb5hQ9V2Dmvfk7dvwk4iS6QbcFNskqsm3rJgAfWJFH1/2Yt4lVTiRtmSdrDXoDaVFAkgBPdXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mudKu77TYvx5Wc961AnAqTG5a0YjtyocFHB5JP0a8Y=;
 b=ExFHqENbnnJNTaOXAjs1KJcXozIOrj2dAvWN4M1eh2ViwcmtNmFPS1Gg8QyDbJt+i0IkJoRbQfa9RvRAlRXulrMmBmnTrZAFw3mLUwJoW0dD38zkPTWjc86BikleBmBEUWiDnGefBXsXK0hCNQOpQO3XIyb11p3EtkMgtbpP4VeN2cL5Hb+enWfrOHvLCUSa0fhbi1gEawGcIhToPNxoQhD8zJGGKycfArAHpvGOWh18xyKusLcprvxZ1ZiePZwpocCclls+ozHpOFKcSU3NEH50JYW11t1JwHWP6NrMmLgkvhlQgRH/WVn8bHucMMaEPZYvAR7dahde5BwabvmPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mudKu77TYvx5Wc961AnAqTG5a0YjtyocFHB5JP0a8Y=;
 b=ppOXEFGHV3buaLu2/nLC4WFqLsojJNWM45+2Iuetxg3/8MyohhmxqabwihWCqLb27SxYCcGgst2pe8yvlQMXdY4EC09NL66P+xCHiYyywmRf6VvPuvmLtC7UtX34lBt/9un5OwvTpoig/SnUD1ttCq+AXJy5OHnkO4PAK8jE/5ZIGPkpgwsJmZvf+W2vyRi0TQMQArpPB8OhDT8OTUmwp9qvQJkgaEo4CdclWlZ7bwz+BGL6BR9TZ6dHojM3m1eRdphW9ciwytZDaAtcrOre0JrxMm6ePn0eH8IgNDGcisZ3FAES2A7MCn6frfFxUOm/FFAd3THOG4hgpQYsNtNmcQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7397.namprd02.prod.outlook.com (2603:10b6:510:1d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 15:27:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7875.018; Mon, 26 Aug 2024
 15:27:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "petr@tesarici.cz" <petr@tesarici.cz>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: RE: [RFC 0/7] Introduce swiotlb throttling
Thread-Topic: [RFC 0/7] Introduce swiotlb throttling
Thread-Index: AQHa9MJuV8zHlUlbFEOu4P5Y/AqjALI2EkUAgAOYOYA=
Date: Mon, 26 Aug 2024 15:27:30 +0000
Message-ID: <SN6PR02MB415753359387FBC8977A9598D48B2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240822183718.1234-1-mhklinux@outlook.com>
 <20240824081618.GB8527@lst.de>
In-Reply-To: <20240824081618.GB8527@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn: [UtZ6MtBY5zmwwb3JLrbRfcbWjbAk8MCv]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7397:EE_
x-ms-office365-filtering-correlation-id: a84d859a-14a9-4ec5-263a-08dcc5e399a6
x-microsoft-antispam: BCL:0;ARA:14566002|8060799006|461199028|19110799003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info: WJglet5RGfQv8F13bmg4tfifFr9cwxwF3+HorjqEmA5D+1IbQA6sORsf/tZGpEXQ+ba+69R70PDLBL67LntHSXd6+WBIAC4KeurVYO5oThCpujGAloIjuLkunibp2P/L4MxIdW1GTfW59tsBCz2wwZpij8mUdIbYMaZM8kfvxssEBPvvWsY//OHcDP6s2cL5N78yIiWkP4v3r+LSRNwRFx58GLaTfT0+QpXPedZO2AjAZXWEL/9LageoMjXDfVtUa+UVI9bLo7gfl0fudbd6GlN39IdRrFPwWwXk8t1KXwzawZwUQgO25LV7Da4aK6xgbmUmVEeIqZcJLQc8HpJXlzRNhitBCL8uqoliYLK+DRrmlwbUiRgsjhAgoNgt13xYGpurGsWbUVfF3985l9sXcOuWxMkAETmx6BG+RJW6GaySG8uxeKaurXgKtAddH3FmVbfBSRbSzd1cjdAy78zZekx4HMvMdh9goYrPuVoflZ9vxgic8Tco0HAsFpRH2O5kZfry9c+HXTe0NFPh0kVVB86G2X9oD03h1M9XRMefC14kpJbfiSLW9iSN1G14Oek6kkmqKHXE01mxdaOJB0t9QJoyu8JSZrG8JQvoaR6ZxyZzRTWAf+LwYwTc4S2dnIYPe479FOSj5CZn+pp3AMd1pvykRWFElUgAcSuQdM3gq58drLalT+qKzu50rAj5LDUw
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zVwWPjr7Xu3tar2V88mq5duC4vH9rcG7nn1CadxsEJY3DlmnrIgp+AvyB7G7?=
 =?us-ascii?Q?V5lFan8vnhaMTXBwHej5SzQLuGGUSmxskUUOVGo4QvhXKikvAWLxwoQpj2h4?=
 =?us-ascii?Q?UbRcglcJyljtb/cqdM+A/Ul9s81PGe0OYJyawxoyQvrm8bi9mulAY8sAFzCE?=
 =?us-ascii?Q?ELr+2cnfWVUB/CaYg9KixY20Pw7GdTS6eu46j3ROSl/89MZWh77Plh+NqvZ1?=
 =?us-ascii?Q?FrDMuCZvFm4gfqyCAy8OF9FDiQUKkABYRvYWM4J8yIWD5CwS9yUlNtXqAgOw?=
 =?us-ascii?Q?ZGHpgZEfWvThvU1D1eNo5khVt1eEm1vNSWxVumSp0zqf4RSSWXaGAA86Y+Vd?=
 =?us-ascii?Q?UvrdtMzT+GZzAA+nhL0R4pQ3Yyoyd2QuG49dBn4RZTkL+cVA1shT/NkYAo6e?=
 =?us-ascii?Q?clBD3nRTYl0S/DzB+ZjIILQmkVo+DDpL6A2tNSzEYNfeUF0nXnUfKHVSsW6L?=
 =?us-ascii?Q?nOjSl0haxN11s4ttrRAiCNH9lmCvRES7/rAMKzTyACe4ADeP7CO/6zTMW8BS?=
 =?us-ascii?Q?Qv5Qm1KjTyBte8hwxCCbAaLN+6VpOw7dv2ilrvGlV8IVZqpiHbiqt+EJTXuY?=
 =?us-ascii?Q?MkcEJ+w638dEq8d5wnbE5G8BzGLvIpbSbSm1j8EXbCY47kdWlxacUap/5pKZ?=
 =?us-ascii?Q?oCYivpiJEQg6ELgl7KTP3WH4U/AtNDbMggHNs8bSD7+Y0qloQNqMEcyJsV49?=
 =?us-ascii?Q?ULSbpMEoVTh3pGcTgsfX8cH3tiMk8unbCdyNSZ6NyyPo4DLnMkuyYD6JFcFW?=
 =?us-ascii?Q?BPz+hp74yNhd10jvCLjLA7kzjf8Y8aH3oL8J9LzT4Db0bEhmQuxzpBEqpMjH?=
 =?us-ascii?Q?d0bjQn0gPS2WNd5xd+PCrtgblQ71/Y50o1chBsVX/qNxqSxGD4UPTMG+29cN?=
 =?us-ascii?Q?edW6WPai7pzJbjxoiEs3sbMAwTwDAoEYEdMfwmB1AhYZIeVYaEd6yN079+wr?=
 =?us-ascii?Q?uyRA0r3Vk6mo6DVEH4qG/5BQYl+Y+gEFt3GW8lXCUZGLOsTM5w0Y+ccdTN0q?=
 =?us-ascii?Q?vSAeAsyd4lN0kso4MTpxdIJjUPfE77vNmGufd/dPv5M+6/Mp/BcrPDAqBlyq?=
 =?us-ascii?Q?gUclGKpDDnNEytJ6+Bpr53fhaSkvC9fVrabhJOnUNIJIaesYi7R8Pk3HkF1B?=
 =?us-ascii?Q?rjVegzRdPCzwmMrawCliDK7Im/L68DaMGAmj0xM1xVeor0/lszosAZy5f7Ft?=
 =?us-ascii?Q?6y/VRbZi37JItHLZl0KtNxYT9V8eDlys/9URo/1zwRiipdxOqlwEhH5Zzfs?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a84d859a-14a9-4ec5-263a-08dcc5e399a6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 15:27:30.5339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7397
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_082738_724172_432B368D 
X-CRM114-Status: GOOD (  26.69  )
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

From: Christoph Hellwig <hch@lst.de> Sent: Saturday, August 24, 2024 1:16 A=
M
>=20
> On Thu, Aug 22, 2024 at 11:37:11AM -0700, mhkelley58@gmail.com wrote:
> > Because it's not possible to detect at runtime whether a DMA map call
> > is made in a context that can block, the calls in key device drivers
> > must be updated with a MAY_BLOCK attribute, if appropriate. When this
> > attribute is set and swiotlb memory usage is above a threshold, the
> > swiotlb allocation code can serialize swiotlb memory usage to help
> > ensure that it is not exhausted.
>=20
> One thing I've been doing for a while but haven't gotten to due to
> my lack of semantic patching skills is that we really want to split
> the few flags useful for dma_map* from DMA_ATTR_* which largely
> only applies to dma_alloc.
>=20
> Only DMA_ATTR_WEAK_ORDERING (if we can't just kill it entirely)
> and for now DMA_ATTR_NO_WARN is used for both.
>=20
> DMA_ATTR_SKIP_CPU_SYNC and your new SLEEP/BLOCK attribute is only
> useful for mapping, and the rest is for allocation only.
>=20
> So I'd love to move to a DMA_MAP_* namespace for the mapping flags
> before adding more on potentially widely used ones.

OK, this makes sense to me. The DMA_ATTR_* symbols are currently
defined as just values that are not part of an enum or any other higher
level abstraction, and the "attrs" parameter to the dma_* functions is
just "unsigned long". Are you thinking that the separate namespace is
based only on the symbolic name (i.e., DMA_MAP_* vs DMA_ATTR_*),
with the values being disjoint? That seems straightforward to me.
Changing the "attrs" parameter to an enum is a much bigger change ....

For a transition period we can have both DMA_ATTR_SKIP_CPU_SYNC
and DMA_MAP_SKIP_CPU_SYNC, and then work to change all
occurrences of the former to the latter.

I'll have to look more closely at WEAK_ORDERING and NO_WARN.

There are also a couple of places where DMA_ATTR_NO_KERNEL_MAPPING
is used for dma_map_* calls, but those are clearly bogus since that
attribute is never tested in the map path.

>=20
> With a little grace period we can then also phase out DMA_ATTR_NO_WARN
> for allocations, as the gfp_t can control that much better.
>=20
> > In general, storage device drivers can take advantage of the MAY_BLOCK
> > option, while network device drivers cannot. The Linux block layer
> > already allows storage requests to block when the BLK_MQ_F_BLOCKING
> > flag is present on the request queue.
>=20
> Note that this also in general involves changes to the block drivers
> to set that flag, which is a bit annoying, but I guess there is not
> easy way around it without paying the price for the BLK_MQ_F_BLOCKING
> overhead everywhere.

Agreed. I assumed there was some cost to BLK_MQ_F_BLOCKING since
the default is !BLK_MQ_F_BLOCKING, but I don't really know what
that is. Do you have a short summary, just for my education?

Michael


