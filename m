Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63456C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 21:15:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1AEF610E6
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 21:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AEF610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=k9HUju3EbKerpmCETmVGVxe7SEPQuWGqLs8YtyMrYnM=; b=TqMqgMTlDHP8IWQsHgtrNjIXR
	Od61UmHd9r+w1eQ6Zo4ZaQAH1mwBLV2AOaJzPfwrmio/JpB2EEaicqu2GieSl9akUEAH9IpKExL/G
	wgurWZQaMuvsY/ExoQdvV+1KAogtX1MqLGRWU6FVLXsIt5C5Tt0YVHNDSeX78lynXY64KzJgF/qLO
	R1nYX8NkRXKzO78vgra30F2CGYaGTNsB1a2TzUM6f7zKZkYWHNRrOxaxjBhvkNk/+aJY3RWopzleQ
	3l7Ln0BBJqri+pNcd5wOACrT9ORmQ6svZ9glqLVZvrnfBFKlf18PW82vjNBtPwdAEijXP9KDjczF1
	f1JIxIpEQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUbz3-009HFh-UI; Thu, 08 Apr 2021 21:14:38 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUbyx-009HFI-VU
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 21:14:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617916471; x=1649452471;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nbA3z4xTfCccciOCyyAkGHXidYEll2Mrb7myT0RqCRs=;
 b=OTUa1zpv16mYXpaQqpRCyeKNYb3vexRMnZzAnrrIF4Eo9qwCr2e9vWGX
 Dz2jOkhgSb7FvLuyIhNbeLnD10lmIukDiVJI37e3rVUFKLC/hpHuWpN2L
 5uj7UA/ixrVzBMHv2GfAcwJJRmcYIuZfzWyo1lOKzP7zudaFSc4omqy9P
 Ibhyprfv2FvHizvw+Z8eWhJ9Tvkg/StOVUkeL/4subyFLBScZy87Onpyu
 P4UPwIyrnFztVIkqb9o8lB1hELggAT78qVCxj5N21X4HtucU0as4CNlcs
 POVUxAamGqTiGD+132K9zY50tQwrp3hLK6n0pPwdNdivLiHXk9urnL6+l Q==;
IronPort-SDR: zVRwUuAPjQUh9FIb3SmLOWJ8KyY1NJyqlELAQpQhCMWdThZLiKbmqPLins7yFEThoXfhmkV5in
 /0mbr4Oxj2tADRRu2r7dOrgbYBgEdlNlgW8tebCR5DsuZUECaGEEepGKN0XcRDL5Ut4HkthZHN
 dKfQfYmpORmmJgFMlm4AbWXVCfrLTBWAdgKw2PhX9ca2xFLz03H99hZwSfUiiK+KLYMFDbIbDe
 R3ZEpjTryTyd3s3+ApGpRK0yuTLFQ3bZH7F/ArBK4vXhXKJ4vQ4203marKczBQA5UtcWltiTiu
 CKo=
X-IronPort-AV: E=Sophos;i="5.82,207,1613404800"; d="scan'208";a="275098125"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 05:14:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDdQiTRLZw/DI/4NXD69TbAFMUsdilljsdnlk9uQHuYat6i9lF9E1RH2vdczZ8DJn9JbfoD4wcpGvYaIsD7R9EsYXQ9x/6SvbySBd/JQLzihaais+pw1jxUrehsGMOBLH5hKHJMCpkaHlcB37YAanPpEWhnCCjcnWVW6LXnH13a4BdASrfZdZaW6p1BmwddJbK8XxH81E6CGuCPDFmw0rvLrsJolOjFnjKhXnVWqzlfExZcNGj+oApICxLCkmvVlbJgkx7iUty0/72ceLI2HG4nP61LjKi+Cwa5ldDelKD7q2sdOpJ4opeWtx+9oFkOJ6jK20LML7CvtHwPZ91UZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3FGJ+/tbOBbY+HP09p7BZ2bSSu2WiQlG/THT5LL764=;
 b=CMuDJQN1kqgyAJZW5+xVc1AbW8Ixwrgx0K8p7zPi77Uuw34BWSmNrEkbfgcjZI8szO1saIOR5/7Bln48rtPCCOEp3q4lHA8IgzwEsHZe6M/74igt2vjC3zMtx3A5WJM50Z7uGRdIO2EaQ7RkSUcnJv75u3QKKu11beXgO3RG5+nonT9UR2NPRvRzNIURqHfNYHhZAr2O7SNj4af4l1PTl+lwXWaeERNbsWZpXBDOBMusbQ/V0/nncBiNrHsfakqD/zjIf7AAlwjBZ49A7Y3T/70Is4GOtCmDveC3kja50JNmYODRotDHSrP1kzPgDjMHaApeJX+2lXJvHQnqvsCbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3FGJ+/tbOBbY+HP09p7BZ2bSSu2WiQlG/THT5LL764=;
 b=EFUteARxC3vtgpZ+E+tL1Vt9iBKReDFFZZcY/v+xG3E/yVVF+cU/udbpoHS/6LgGT+UzudRZf8a1oQMGQxqgLaXPP+N67pajZ3QkDfCprySoFLhdc6JURsr0xK7miZPB0jcoTk8CxqokZgWV37uI72altR98I5tQLCAFbuij83s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6803.namprd04.prod.outlook.com (2603:10b6:a03:21a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 8 Apr
 2021 21:14:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 21:14:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Damien
 Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXLAw04l3W0N5us06JCpRfHcvipQ==
Date: Thu, 8 Apr 2021 21:14:24 +0000
Message-ID: <BYAPR04MB496576AC2F66933D9509A22286749@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
 <20210408072337.GB24502@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f352e77-cebf-407c-d904-08d8fad34924
x-ms-traffictypediagnostic: BY5PR04MB6803:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6803CD40184A711F9E09A12C86749@BY5PR04MB6803.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DtaxS121AcLXoA/tl5WGdrvgdEe78lCydRBFUqc/oWd3J5yj5MjEHkloruztd2ecSLMKR3gzmq9k+oiDYooHWG3vHn0NXoc1UMDQgkVHUMovD338IBJOn2OoyWmpbGXI2R5eU7O2TyOlVdT0XokTxNmxm2nQdPi/XTFp3di5N6eTNyuXpOoUmy2jAuZOIeYy3HaceDXQ+h5umMb6E4hhvPrH5WqtsP38tu1+DBXDr++3/4PH/nhX9M/sPgc0QtlpKUpAkYuyGxbVRbXZFp/ViopwxA6sWpclmi3aJkgyad2IKRRbuBdZReDKk2CcylrgNuoyOjxOA6BXxe0nZVS7ZF44vriuFBpVMEqfc56BD0yt998jv4MvMjhkx+JiGvut9uLuwI47z6oKt5fE7FTW727Y4XJlmr6dagZsvwpxONHdxoRvWRJRW9Fg1Kr2CoLaZ235/tJ8hk6nAbJFSK48YUG174LYLVtoOrJS8l2Qb/RJQIh/DMoKTd6NFnKMRT5N+QkG5gPS+ZCupUu6eTEDjvbi7CVVxY8TS58fMLgPDTXUXoQIxtFmaLf1Kf+R4WJEtLS42Lw00+2XLlM6/o+TrBFeBTlpHmOgob2UopNsqhL1j8qKG/qUndJomcepZP5anwBvgTxV1rLvZmmD6xH6BVGqTehPceonQYZW7qY1RfI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(86362001)(9686003)(33656002)(478600001)(186003)(71200400001)(2906002)(7696005)(6916009)(83380400001)(316002)(52536014)(38100700001)(8676002)(8936002)(26005)(6506007)(53546011)(4326008)(66476007)(66556008)(91956017)(54906003)(5660300002)(66446008)(55016002)(64756008)(76116006)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/ip3pl8JibSwPZG3WfUDNRNwfl6SIq8fEjHGmLvK3PzU8PgU7cT5sDrk37E8?=
 =?us-ascii?Q?zkfH1Qv5qiono+ONrQI+kuIKnm7pPN778xbpn011H0x0EDuDjlhdjeNEcMUw?=
 =?us-ascii?Q?Bwg97PQn733Rvl4/zadOEZRJBsP1tOf6xyOImHwBVMhTZsVIi7y+oqc5RqDM?=
 =?us-ascii?Q?qDeOjd7CBTbr2jqrcBcwvm6JVfuKiVdJiipxwQ1iAbpVUlR5LQEBANRjK7t2?=
 =?us-ascii?Q?CheQS44xbM1mgk4xo3oNHb5BaXTtutpNFXv9Bv+4iWVVM1I5BoTHTh5P7q51?=
 =?us-ascii?Q?Qohk/DEb/k5k6lejhNgZjnYmOjem/wdm3RtoU+UOAYcDe5EiLfNvT35sqhWY?=
 =?us-ascii?Q?nhMYlKpwp1a/icweVY/wi9cFuvxiJGtA67iKXPfFCznnntBM7YDPTz4vFq4b?=
 =?us-ascii?Q?HmXOysqH0XldLrLGZ0GnkIQS8QaTpDUJtEB93MclJC4r8LkBZhquyk4OuPyq?=
 =?us-ascii?Q?W5d6gCyVXyxIdlp6sEtxW+W1SB2T2M+txuwLWQP7iUrUpZwhrBCGkL+VFLx7?=
 =?us-ascii?Q?gFaMr71UKLSaN5ywOu4erxc1w10c1uzKLkiMPhu3A05L4Jb3htG5455vxuft?=
 =?us-ascii?Q?Z12Hgi01m8UzPp0LmNgowsz6IGEfipWio5bkf0DQIJwwGvaic+M9oI6+mSTW?=
 =?us-ascii?Q?duyItJ/Iw/aT8Ml573lr3yvM0HJSfn3Zd07uujOZFcgirOC+zeGEGuWB2m2R?=
 =?us-ascii?Q?KvnSWZrS698gMXdfB8ip7zp/Cl5OJFI5YGgaXx1B6kUcToZqVAOGr7WSa903?=
 =?us-ascii?Q?RsfEsH/rdW6VvXFFwhwEljutuAeNo/Mlierj+vUoBB9FxA1x1Sn7RfxfhYv2?=
 =?us-ascii?Q?uSff/8JJ03g9dOfn3axqjmH5zksEhoxGWz31auBGWi2cVBGjWruUyfRy8BJE?=
 =?us-ascii?Q?V0UmIOb/ZUWIEWZkw/6amnBdv/nnY71xVS5KkaeeWORXFd7uqG6LawP0yvbv?=
 =?us-ascii?Q?1ST73KkigzkMMuNwiqQ4eA/5sCkh6Mx1FT6bD5revXCAQdR5UdGpACRfit2U?=
 =?us-ascii?Q?1juaoTwrpL5lO3eYkyzqAiMci3LdKDgbbqi2BO3DL20fReMHs6oPGqwbWd/E?=
 =?us-ascii?Q?KhiUUFiVggK9x8Z9VOYhPK+e+b+riwJrlZdu1bjVWwgTlJZmQwrVh5+qPWP6?=
 =?us-ascii?Q?CYLdDEh4nrhKHg2SWnFfFFvmJqHroJwgSNX/sjeiROnizovcwLtsXg5KnWwy?=
 =?us-ascii?Q?xiN3QYosb7v1IoMxRDubgSdE6eK9L+x8iXEaspZ+y/myVxTPLHg9H4nF/2UF?=
 =?us-ascii?Q?czGkVXbibZkCGCcOhllWuAPoXU5R7hYN+zcmObXuVL3E6hIgs+ZjKmGmyh1l?=
 =?us-ascii?Q?O1TrNPcDkEqB/U6hH067XNee?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f352e77-cebf-407c-d904-08d8fad34924
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 21:14:24.3161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEavRvnVZWBw6HU2/qdUaBYvHIyBXsjM6EJoVAjYWJynKGbLv2HLPfU8O+0Ul3QbCZjxM3D+O6XOZUW4QSvNLLKNGEIN4ksl7UXV9h73T98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6803
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_221432_831839_B36177C2 
X-CRM114-Status: GOOD (  12.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/8/21 00:24, Christoph Hellwig wrote:
>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned i, void *d)
>> +{
>> +	struct nvmet_report_zone_data *rz = d;
>> +	struct nvme_zone_descriptor *entries = rz->rz->entries;
>> +	struct nvmet_ns *ns = rz->ns;
>> +	static const unsigned int blk_zcond_to_nvme_zstate[] = {
>> +		[BLK_ZONE_COND_EMPTY]	 = NVME_ZRASF_ZONE_STATE_EMPTY,
>> +		[BLK_ZONE_COND_IMP_OPEN] = NVME_ZRASF_ZONE_STATE_IMP_OPEN,
>> +		[BLK_ZONE_COND_EXP_OPEN] = NVME_ZRASF_ZONE_STATE_EXP_OPEN,
>> +		[BLK_ZONE_COND_CLOSED]	 = NVME_ZRASF_ZONE_STATE_CLOSED,
>> +		[BLK_ZONE_COND_READONLY] = NVME_ZRASF_ZONE_STATE_READONLY,
>> +		[BLK_ZONE_COND_FULL]	 = NVME_ZRASF_ZONE_STATE_FULL,
>> +		[BLK_ZONE_COND_OFFLINE]	 = NVME_ZRASF_ZONE_STATE_OFFLINE,
>> +	};
>> +
>> +	if (rz->zrasf == NVME_ZRASF_ZONE_REPORT_ALL)
>> +		goto record_zone;
>> +
>> +	/*
>> +	 * Make sure this zone condition's value is mapped to NVMe ZNS zone
>> +	 * condition value.
>> +	 */
>> +	if (z->cond > ARRAY_SIZE(blk_zcond_to_nvme_zstate) ||
>> +	    !blk_zcond_to_nvme_zstate[z->cond])
>> +		return -EINVAL;
>> +
>> +	/* filter zone by condition */
>> +	if (blk_zcond_to_nvme_zstate[z->cond] != rz->zrasf)
>> +		return 0;
>> +
>> +record_zone:
> While not bad per se I ind the structure a little odd.  I'd move the
> checks into a level of indentation instead.
>

Can you please elaborate on this ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
