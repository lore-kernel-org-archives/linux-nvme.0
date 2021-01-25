Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1CCC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 05:32:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B584122581
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 05:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B584122581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=kktuMI7hxf4MWZEa19CiQniDYTyThMsMBtPwURsh4BU=; b=vzt5t1/2WQtZbprGY8eXHZt7J
	N64N/s2jj/uBJXUI6MAulQJio5iF+vPqVSgSysx13B/e+L0bbxJbtMdOzJka3eZzS6sbDrMLX570R
	/1Z4KggAs501pz5IidNUfIvDeInUoZOk081VPRYLU0OxYJ1IY9hpHIsz8MM/us8SRobsgP9IxRlxe
	7DfmScpli7WTRSefmAXzP/dEJ7Jt3GCbBet+5yDYiOz2VyxgDEtFM5SzJzuxtRnKFgKQABkat8aAW
	6dwAh1qn4wASCewRV8N+xxFG75Zk9WLp3PTJxUbmsjOtve+GF2gVfzbJC818rufjignqGR6PwE39c
	rM0uquyUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l3uU7-0006WV-Kq; Mon, 25 Jan 2021 05:32:19 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3uU1-0006Tm-5r
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 05:32:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611552733; x=1643088733;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2kzLejK3DAoptV3bjjQxMyEwuDoF4NbUxSH0CeFdaTw=;
 b=J96mUCGPa3nugQ33A84p21Ip0OGecqgxNOqtQgM/xV+1KNVAKRAJusxy
 /UWVHw5tzCTtXKQhOexoXo7Kqf8NEb3TQXfJQy2xBSAg/IcqDUmldsStr
 KXLxwk53M0Yp+rRRbqWMDHNGGWiSFRi8U89WUA7dStLEZaZPOcmT2mNTe
 /4FljSCWiW24exjr42GBTNAJHpNrZaf6dJGCNlr1ib5tMjWwNEp3Ptd1T
 r1yfKn0VOKIm99VB1RyKJngsMYJ3R+eo4aQbz07kzYq99lcvLD9FH1vxW
 ElXlyohT1x8191dnYKs7m/DxxGr4BPiNVjEGeaaqRS/IDazoqBJ1P/J6q w==;
IronPort-SDR: A6HOvbbiTwjxIine4fA1LHCW3AvNFWr6mH+HvPDiErN9l7ywZfMjFAva+MfUSdXBUpumvb9bgv
 Q4V82J4TbQePdx/r/uZ1Tjkx6r3E6i2PhhZsIQI287Ev0LnAqVA9y/FkDsv8aVdmSfxPlo9MYR
 sQgnIkqjetqrqbzwsmKFUKbz9MxyNJlYM7NfDDfAgdtgXmpgn8cQFymbODxwSKD4j642emYlpz
 BoyVwB/H3rJcEDuQ8BJPV++FgfoD4VaCelvPQWSugmqMQ1y3qzGK80D+DPQeuuduNVoZccZLRl
 BCw=
X-IronPort-AV: E=Sophos;i="5.79,372,1602518400"; d="scan'208";a="159402822"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2021 13:32:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3mhTV35g0QhTUEHQHua47aPCVOHNJqS20SnFuehKat9fiCa2MLKPDh9dPpptSt2P/JywLDC1nimg6JsrrtIcdM3WEb4QERaxsK4B064iUu20SdQQbtxMI1bL1V7WPF9dAH8vWTD7A/h5p1zvEdnjkwyEoN22zfYhej3qTVOHH2cLkdRfl4YsId7mlACuVwq+FRI2TPip56/4CBszGZsnkL2x7obLK8CdOt4P4pyEzylSwurBfarmhmgR7tpOx4vq9HK6EK9fiz3VyxSOuQxC7ZenUxnvUUE4XJAGN9I/D3Z8e9zCea056K9Biwti2Wi6L5eSDq6BhKgQ5l6BoxpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkRZ9lIdgF8wL39NSLj6NKDhgglOI7YDCTFelV9AGes=;
 b=oBgz2psSJwHZsBGq8wCzCL0jhQVvdtM/HffN3/jPszY06+VVN9mSkyTWdGg85X2r7StiVnz5c4ZBAhZsaiJDZZk3pOyIMtX/WflegPawjyyH+jNJhVRkCgX0L4kzl8m75KctFdcCHQg5446egtvo+Rc16WXxJ6WaYQn9l/lCLbnN3BsGq+HW17DdiwKChWGVaheU5lFigsw2eyJPiNQQQotAlbdg/n8DUYuulEWMERAJV59tG3u97/mUrOyFyWorsLbrQ51w5Sz1zqc9pxxNxaa8ItlusB8gteORkwE6otyKx0O9G5+XkaadJd00ZOtxkZIx6nG8PJ/ko+3i3C14sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkRZ9lIdgF8wL39NSLj6NKDhgglOI7YDCTFelV9AGes=;
 b=fv5X7PB97dFUynqaAi65yqk9pB1MSBUUVmPRqGLoiiLQBMYr8rkCec3T5nEePEgo2GYM1UvDii8/7vXfpWvzCZN8FW+SpcGDvMX3r4H3a57qweQldvh5rdO0uauPSaW+CXw0LoRo7H/nvjYYkvaO1P3OSpgVH7ebMDD+TmctJ5o=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6352.namprd04.prod.outlook.com (2603:10b6:208:1ab::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14; Mon, 25 Jan
 2021 05:32:06 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 05:32:06 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/3] block: introduce zone_write_granularity limit
Thread-Topic: [PATCH v3 1/3] block: introduce zone_write_granularity limit
Thread-Index: AQHW8JU6qVihsq4M3UKmhepNN6tFNQ==
Date: Mon, 25 Jan 2021 05:32:05 +0000
Message-ID: <BL0PR04MB6514C3C43A5E3DA84632188CE7BD9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210122080014.174391-1-damien.lemoal@wdc.com>
 <20210122080014.174391-2-damien.lemoal@wdc.com>
 <20210122084209.GA15710@lst.de>
 <BL0PR04MB6514A2655635DFF482E4252BE7A00@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210124100724.GA27580@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2db5:5c10:5640:816d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fc6db22-8344-4cd0-9b24-08d8c0f28d8f
x-ms-traffictypediagnostic: MN2PR04MB6352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6352C4FBB893FF5005BDBE92E7BD9@MN2PR04MB6352.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jMN6fEyF9WlvpnnY8NnjMJmyTr8DdIElB558OFfCN3CHIT4nZOhNU7z9vn3/ThpyLopwpP4gP8WVev1jnnmYbSAasdX9lKXCpO7d4/SAzyFn7ngcKV0fhixy85yJ+NeQ4BRdiyeRYfpFjEsX6xNzmgP8zlcgUtcJsGXbZODKLfpFYwrDK/yCWGhvghUuk3rdz6utoO8N/P+fCWb0L3tZvx6Gk8g5cOFWuV/h1PKc9IVvlYVoBHNo96sxUg0flPu13mhJDzQv7/EtYnMmIB+iUIytxE/n8v44cixwOI7gosM3AqBXdQ8j+ByyzAbQfHlZ650EtIEv4e/NSlYaNHoWZEm0z/MVoqSMN/ncU1T6KOQSz1qkvCZe25yoHCy4xSqffdkS7ATgtUYhVuX3zp0iMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(5660300002)(8676002)(64756008)(86362001)(66446008)(66476007)(66556008)(76116006)(4326008)(9686003)(2906002)(186003)(6916009)(54906003)(66946007)(55016002)(83380400001)(6506007)(53546011)(8936002)(478600001)(7696005)(33656002)(71200400001)(316002)(52536014)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Se7P12tqHcEskIehSalCtsQpJvdeTsQpNkRbiu0bo62nBIbHNDiO6Rb7Q3J9?=
 =?us-ascii?Q?vgw16DCDLlyfTdBXw57xGh1wI/tCi4zTUHk1y1eVDI5lDuFg1J+XLwg+EaZ3?=
 =?us-ascii?Q?DvxULTeAFR/iHvEqnzoROJkJmqJ1ekb3AcHJKYaKbqpajjzO6mStyIBMTnjd?=
 =?us-ascii?Q?yTKGVvLFrO0apwB0b+zTP/YvXGZSwTrxxz4DhOch8FoOi+Z6CS2z3a0+LJmx?=
 =?us-ascii?Q?CdULtEUw1IgqO5LMZ8EqCmWzHxweS7WrEFpZSUuv5bwjEH5R0wy5IjN7kK0V?=
 =?us-ascii?Q?PyI4/KzWjDvJz4hnWqpVOMGiOPVMFZ7cwh+bjfmHjaA08R0PQt+mSgGOS/rJ?=
 =?us-ascii?Q?Zq/bgQfZ8s9XhvqjtUvF3vL6VJn8e4nJ5qQVgWrHGrtG6Ykkr8YlzSvnRWB4?=
 =?us-ascii?Q?T2OdqIlQSM5Nre3NA2HxLUq/swWqlfcooD1YH6RZeQNRfvqHMUoht86fBNab?=
 =?us-ascii?Q?syCH4wxgbaeU+n9nBIy7z3tpczZX7ig6CPcLv3Vqd0qYblmQ5nqrRPtWOJWR?=
 =?us-ascii?Q?qJBK4pGHUx5yiEGkdA0UynU1txfcbzRCf3QrvjG0agMzqWDPdp+OvzvZLpr6?=
 =?us-ascii?Q?se5hCwO/Tw6wn+0Cmf/c19VaNf6Wgcuubg4KMijZEvGNmQG0fSTZzR/Qo4Za?=
 =?us-ascii?Q?/os1Qr2fJkQdnSiwzEt/onfkmzpflVudF8elE+i7gUemzJHjgUgKMEChWyxR?=
 =?us-ascii?Q?IJSW5r8xvaFqf2eZ358Pkh9HzYigzlGWh3LPjzXyYug85AZHIFf+c8lOjQOF?=
 =?us-ascii?Q?7zMqgzhHZ2WQDlXZl40LDZEXB2wvBD0eGinj9cF8ULxzn3aVoTrHDvRBDagJ?=
 =?us-ascii?Q?+ffa0skbzOjeqawObDYvIYl4G95CaOqPoc5ORdCpyD1C2aphfwnR81i8Bs1L?=
 =?us-ascii?Q?sPqg0aILaXNDHG6GNanFhpWWEisdPslIDUOWpjrGhkKBxGvbVUuSkkG2Z3MX?=
 =?us-ascii?Q?7Kwuw0C1yIO4SzvvsgcV9vh9otqmnNKLxOeySKvyxpDj3YkITaJceXkeS4vP?=
 =?us-ascii?Q?+BCEmyd/4D9XIsD+j6WPt8C9AloQhTEgKlxsCGwYpVUPWFJMgdi2jBEHKWkn?=
 =?us-ascii?Q?eIY/xyLjBH/ytleEGKpd+xtx1/enPGGZPlQBTCnuoPB5k9nDRfmOT4pqT+NV?=
 =?us-ascii?Q?WshHvk2oBKwz5dxValFm4q9W2s8KCE+zAg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc6db22-8344-4cd0-9b24-08d8c0f28d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 05:32:05.9257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKz9z1rmlKF6FNIKVH5DSaG6TOGNTOGkYDuwaRRBWR8wVHgpZOl2kddhUGoAuV0Rg6GPxQb9T/jGliBELG/iKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6352
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_003213_537676_68892224 
X-CRM114-Status: GOOD (  15.04  )
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

On 2021/01/24 19:07, Christoph Hellwig wrote:
> On Fri, Jan 22, 2021 at 08:56:58AM +0000, Damien Le Moal wrote:
>>> This looks a little strange.  If we special case zoned vs not zoned
>>> here anyway, why not set the zone_write_granularity to the logical
>>> block size here by default.
>>
>> The convention is zone_write_granularity == 0 for the BLK_ZONED_NONE case. Hence
>> the reset here if we force the zoned model to none for HA drives. This way, this
>> does not create a special case for HA drives used as regular disks.
> 
> Just inititialize it for all cases if you initialize it for some here.
> That way everyone but sd already gets a right default and life becomes
> simpler.

True for nullblk, and that also simplifies sd a little. But not for nvme,
blk_queue_set_zoned() is not used AND nvme_update_zone_info() is called before
nvme_update_disk_info() where the NS logical block size is set. So some
surgery/cleanups would be needed to benefit. I could add a cleanup for this, but
not entirely sure if calling nvme_update_zone_info() after
nvme_update_disk_info() is OK. Thoughts ?


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
