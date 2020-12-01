Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBF8C83014
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 09:57:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C86206C0
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 09:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hFcU/Ucu";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bz371wv8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZWArL75g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C86206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=46uo4RitrW41QFeemKY56bbTKg9tD41V9nu8+K8Uk6U=; b=hFcU/Ucu3MHjuYgL9cFw34K84
	TAvz9tucEPXcLN0oMz7oVDonqFUhp4eTrjs4Y5ph57BPJLnYj5xBWfdkEN9oajqUMrWSo64YIQyMc
	DvobZ0XQUoxXoZHzIlyhZGvXDoUD1k8DtyeGTjB2e7kBmlTKacpZj4vYiYoy0IOwIEvIHZ6XAsXzI
	xk0GCeHMFG2cVfhMEukxCYCF3AtqtjwI+t7ZXqAR5aJaQ6G8rvIe4l0+sjuvr35HjnLpC9Zsyvo+C
	UPrS+kl+D+D2SstEJdgawQDgmyJJAOBYx14fjX8NHHfnw9mjSalQ3f85N9SBCyjxHK9CSy8yBbyDf
	4eyMdY/cA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk2Pf-0001HA-2r; Tue, 01 Dec 2020 09:57:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk2Pb-0001Fc-98
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 09:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606817419; x=1638353419;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FD/t4QNnIm36fQy5AyIldUnJMbmBAj0+s4ZwtTzhDgY=;
 b=Bz371wv8H0Xi8oKfXhqXqwW5aQjshCCOHIO/vVvuIdvg1HPWC2nRkwBQ
 sPzrkbYyUtZWgRtDhiV/WhSEAhlM2NrK6hyeq/fjAttsBH5NoOO9xIXkW
 /w2At+3r6XRGf2YoNFi0poJShzcZofu6alz4DO6ikgxB6PM9TFiMZb3Jo
 YO+S9HS4vx6Sgk1l7A56DBGZFMlJEXSY/fYSeOjpOfPrWYQIXbiXUojcf
 tq7ierM9TaZaw0yH+DWSQYF4VQCU2VCvUBMqUb5qBjh9yD8sqOGJgyvs5
 d1Ghn7ZklADgQV66NEM8KNh+RE3W+GH26xHibHgXDbdfMmuHhkYKF7TbC g==;
IronPort-SDR: re/BAI1wD63Z0x3nLQqwKKcj9Wo441tN9Uze14I905U+O4rm+kqx3rvYpwc3Siw4e5cijMZESH
 RVF8y4fRG3X5qIwMXCNiB3IOB75HfP8mVOeU9mE6XqtjNFn4T55gd8yGitC2oSwTWsqmfUjq3A
 Pe7FtXaZIuRjUQshTaG1FG3HSpr5Gme9YwBwT3S3VXRWTjEX74e0JOl0c03QLRXWs0PRx38Jqx
 sSEkLPJhEJMW/zX17+T2JceoO7UyFm99fSRGE7OkSBop/RKVEnmi2FYf20U7Clozg55oOzJQIR
 RuA=
X-IronPort-AV: E=Sophos;i="5.78,384,1599494400"; d="scan'208";a="257587338"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 18:10:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0wOx/Xe9P6wqnLb8XkR33uIwOf2QzlkmCGz2OgZc/0xt9XpqFFi/ouG1rOPXe+1dix8B/dzYjjEEHA+WefmU+NJ1emhslMk+E2OGUR08/QOIu5yJRMxGRfKooz3iTwUnUxkgwXQfDrkihYvljS3q9byFuWfgyWZYurKiTn0/eVOlhFacP3zmDsjkTvbi+FW0LQqzcWzyZqfHtXKSnLf8oCbZXmKMMUsix3EYcj7NNeOY8GKTg2uUrynMIx0jbuqQBwo6BaEzzAF86Kf3eZg7fXZS4df6u2WMC55Og79g2zjj6zKBqVGcL7cF7c1qvD/r3kryGTF6sSuZf4WYAru9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5BkcBPSrQ0538iFXZ2rGlTZ5liWHNF9UU2Wgecaock=;
 b=FqFMRvDhFFBxdvlXV4C3nipn1yoUQWuRkhmpzXraKyN68PG4HdKpBzNvI6Tj8iyQwjNLwoPE5ON3GAPIIY8dS0Eft7rbMkYgG9eSxyx+IorvElE9BW6fS3LKR/1QUhBk20tI/nSPb3Nwv9i85GCn1lJjVe4T5IBKTYUQkMgB4ktXW6u9/Jci+Gc9mJzOA5bPlqoSp8PedyK9fWyvbXQENq0BQvcA+hX/olJe2mcQU0gOChGCFTYJ5Myz7Bp4gn5gPT2+RgimD6qZ5VDNqnMcjSmEaXPwWPi1glxTaDnlKJyRgESPE/cncN5WFUQCZqugc2DDFJDFtQZ1dx5RTvLmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5BkcBPSrQ0538iFXZ2rGlTZ5liWHNF9UU2Wgecaock=;
 b=ZWArL75gYA0h50XPqj10wv5yuYoirfoKMcjLw634DLE3sAVIR7DoCuo5FjIrT3tOhsV07inQyK3uup7MvfMBH4EAy/AmkK1Y+h+BrUq7/eqoqLUGE1P7MQCH4SS1wXntBtmmjwj0o/l+ySY6KUChoZo2KPVQuwdFa41ELay2mqo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7306.namprd04.prod.outlook.com
 (2603:10b6:806:e7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Tue, 1 Dec
 2020 09:57:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 09:57:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 1/2] block: add simple copy support
Thread-Topic: [RFC PATCH 1/2] block: add simple copy support
Thread-Index: AQHWx7Gmd3TRGW/jckGt+BDcIzWOoQ==
Date: Tue, 1 Dec 2020 09:57:24 +0000
Message-ID: <SN4PR0401MB3598163C941976D90F745D8B9BF40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201201053949.143175-1-selvakuma.s1@samsung.com>
 <CGME20201201054057epcas5p1d5bd2813146d2cb57eb66b7cedce1f63@epcas5p1.samsung.com>
 <20201201053949.143175-2-selvakuma.s1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:548d:b207:1d7c:917b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0355fd70-e1fc-4fe9-0715-08d895df8109
x-ms-traffictypediagnostic: SA0PR04MB7306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB7306EF76FA8F230E032654F29BF40@SA0PR04MB7306.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PpHLY/kbZBVdTrutryhrHde+hsykckrkyLu13hVCyJSV5CN/EInwMWjDlzT3hYfk+uZ0xGHRNsy9cgKyG6YEwdq6uQJ0cLMLGPCvKxZsmz6F8SkQMrtqz5j8IvbGyA6Y3HtC+EIO0f0qKUBfuiFsxgV/k4fqo1Uf2k+MMiMQ/VZ3PkSW9OclVQ3bD2k5B2U1+KK9J0jjuSz4euh8vS1rPJbJcl6x6CcQBrXnum5hjliGMupagSSn3dwhNQN401Rnx+BcXF8IJHDdCEXstv2B/CfXklIt62EgQTOI6uMom0VRYIeFf+HMXn3ckJoL0dub
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(186003)(76116006)(8936002)(7416002)(86362001)(66556008)(91956017)(2906002)(66446008)(66946007)(5660300002)(66476007)(52536014)(64756008)(9686003)(55016002)(110136005)(83380400001)(33656002)(54906003)(53546011)(6506007)(7696005)(4326008)(478600001)(316002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LQE860IkeP857nxBhOFfp9IPLOiHDRGqjY1ctsZAGh249oIPMrfWskzIIMUv?=
 =?us-ascii?Q?VH7Rw06L6nQvKipy8WHLdQsD0SUaSUoUXQzgmSdv/mDHfus+5ryBPlDXBW6P?=
 =?us-ascii?Q?FhQ0AH7E3/HjtF3KPeTLb3ThpPscbqXP2MaDio7+g7eSwxrLWVbIpCn+XoQF?=
 =?us-ascii?Q?pS3n0aPkAy9X/mwDlVRfFZ31ABv/DRuwS8rJgeXkLHGqDnt8HrbQt1cY0s87?=
 =?us-ascii?Q?3bAhtiEL7kMZ4427za7gSe8O91YR+Dit5z5vzgm/851WpoXSzGGiJu/3Q52C?=
 =?us-ascii?Q?W6qmstEClRoT1mwyhf9CpR740Jdlk/6spzAZLXUE0US0ZSiuCP3fh5/0kRw3?=
 =?us-ascii?Q?7m2omB1dMiwLxdCZ0j6hv6eUjmD+6H+7e4ojhJnfV8CisDlQ8XN9Lrdoh1Xr?=
 =?us-ascii?Q?LiEoHcnMea7OktLBCqBFJnd0Lxs3cOGqUZRYzYYBYMuqrrbYQa3s4QUjgDyb?=
 =?us-ascii?Q?g7sFFR6cL4JBp3KG0twV8uK0nWEjOkrjZHyuCfw1+fkZ5SbXcMACzBj9ieG6?=
 =?us-ascii?Q?ojzitwaYl/xQO8Ke2C19b1aO0kyVd8lWXCFPMNgZ94Gm9YSDFpq9Vo+/6IHz?=
 =?us-ascii?Q?ev2Ie3p9kGM/q7qSAfXhMiDKGf9YiwCBlSI+z8djcilHUV6qvOqxSNtaWddS?=
 =?us-ascii?Q?iz1P4gbcqeLH9sLv8rF1fDDwUe8PwDvo9SyPDWHJdmzPJmmeVgwVVAIBDjlC?=
 =?us-ascii?Q?eN747KclrbIBAMHcwqRTr3e9DSbxhCdk3z8JbwTkCVW8C3jaGClpIfFEJD8y?=
 =?us-ascii?Q?8fksCc+pNNJgJ4KH50uESAWwUMvrXeHEQOg29Va94MGIzslOkZ9NGLC76/Ya?=
 =?us-ascii?Q?kMiRSS+lY726HQToCH/Rdjkvg6EwaddIXmaRZHa8ZCA7y/0D4VXU+cMvXvHO?=
 =?us-ascii?Q?9it2/B85MTQxmdjlKSudeTT9wszcbzkfNj5xuSxEJOWayk2NKTfUCbhoWX/h?=
 =?us-ascii?Q?LigeeoTF1dgtVBJhfu24uAkuvN5iZkEOMH0PWgqcLWvos1Crc3QTuG4DlZ5b?=
 =?us-ascii?Q?d+pqMtRmu3ResebsJhsLq29XL0fuVSz5WaETrNJsJgXwtLyKuQ5hJ9O6eO8+?=
 =?us-ascii?Q?4Xek1CsC?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0355fd70-e1fc-4fe9-0715-08d895df8109
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 09:57:24.6883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0TOKtYgUjPD3wnvmNz2+JxWlThsypwBikWl2pjrR48FQiDgDLDJI098HroJRPbssC/GCWHwnUmiF9zkb+HPp/B7eRror0gLxJ36S0JbpYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7306
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_045731_616656_49671F0E 
X-CRM114-Status: GOOD (  26.18  )
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
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 01/12/2020 08:14, SelvaKumar S wrote:
> +static inline int bio_check_copy_eod(struct bio *bio, sector_t start,
> +		sector_t nr_sectors, sector_t maxsector)
> +{
> +	if (nr_sectors && maxsector && (nr_sectors > maxsector ||
> +				start > maxsector - nr_sectors)) {

Nit: I don't like the line break here, maybe:

	if (nr_sectors && maxsector &&
	    (nr_sectors > maxsector || start > maxsector - nr_sectors)) {

> +		handle_bad_sector(bio, maxsector);
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Check whether this bio extends beyond the end of the device or partition.
>   * This may well happen - the kernel calls bread() without checking the size of
> @@ -737,6 +748,75 @@ static inline int bio_check_eod(struct bio *bio, sector_t maxsector)
>  	return 0;
>  }
>  
> +/*
> + * Check for copy limits and remap source ranges if needed.
> + */
> +static inline int blk_check_copy(struct bio *bio)

That function is a bit big to be marked as inline, isn't it?


> +{
> +	struct hd_struct *p = NULL;
> +	struct request_queue *q = bio->bi_disk->queue;
> +	struct blk_copy_payload *payload;
> +	unsigned short nr_range;
> +	int ret = -EIO;
> +	int i, copy_len = 0;
> +
> +	rcu_read_lock();
> +
> +	if (bio->bi_partno) {
> +		p = __disk_get_part(bio->bi_disk, bio->bi_partno);
> +		if (unlikely(!p))
> +			goto out;
> +		if (unlikely(bio_check_ro(bio, p)))
> +			goto out;
> +	} else {
> +		if (unlikely(bio_check_ro(bio, &bio->bi_disk->part0)))
> +			goto out;
> +	}
> +
> +	payload = bio_data(bio);
> +	nr_range = payload->copy_range;
> +
> +	/* cannot handle copy crossing nr_ranges limit */
> +	if (payload->copy_range > q->limits.max_copy_nr_ranges)
> +		goto out;
> +
> +	for (i = 0; i < nr_range; i++) {
> +		copy_len += payload->range[i].len;
> +		if (p) {
> +			if (bio_check_copy_eod(bio, payload->range[i].src,
> +					payload->range[i].len, part_nr_sects_read(p)))
> +				goto out;
> +			payload->range[i].src += p->start_sect;
> +		} else {
> +			if (unlikely(bio_check_copy_eod(bio, payload->range[i].src,
> +					payload->range[i].len,
> +					get_capacity(bio->bi_disk))))
> +				goto out;
> +		}
> +	}
> +
> +	/* cannot handle copy more than copy limits */
> +	if (copy_len > q->limits.max_copy_sectors)
> +		goto out;
> +
> +	if (p) {
> +		if (unlikely(bio_check_copy_eod(bio, bio->bi_iter.bi_sector, copy_len,
> +					part_nr_sects_read(p))))
> +			goto out;
> +	} else {
> +		if (unlikely(bio_check_copy_eod(bio, bio->bi_iter.bi_sector, copy_len,
> +					get_capacity(bio->bi_disk))))
> +			goto out;
> +
> +	}
> +


All these if (p) {} else {} branches make this function a bit hard to follow.

> +	if (p)
> +		bio->bi_partno = 0;
> +	ret = 0;
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
>  /*
>   * Remap block n of partition p to block n+start(p) of the disk.
>   */


> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e90614fd8d6a..db4947f7014d 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -150,6 +150,122 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  }
>  EXPORT_SYMBOL(blkdev_issue_discard);
>  
> +int __blkdev_issue_copy(struct block_device *bdev, sector_t dest,
> +		sector_t nr_srcs, struct range_entry *rlist, gfp_t gfp_mask,
> +		int flags, struct bio **biop)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	struct bio *bio;
> +	struct blk_copy_payload *payload;
> +	unsigned int op;

I don't think op is needed.

> +	sector_t bs_mask;
> +	sector_t src_sects, len = 0, total_len = 0;
> +	int i, ret, total_size;
> +
> +	if (!q)
> +		return -ENXIO;
> +
> +	if (!nr_srcs)
> +		return -EINVAL;
> +
> +	if (bdev_read_only(bdev))
> +		return -EPERM;
> +
> +	if (!blk_queue_copy(q))
> +		return -EOPNOTSUPP;
> +	op = REQ_OP_COPY;
> +
> +	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
> +	if (dest & bs_mask)
> +		return -EINVAL;
> +
> +	payload = kmalloc(sizeof(struct blk_copy_payload) +
> +			nr_srcs * sizeof(struct range_entry),
> +				GFP_ATOMIC | __GFP_NOWARN);

Please check if the use of struct_size() is possible. Probably even assign
total_size here so you don't need to do the size calculation twice.

> +	if (!payload)
> +		return -ENOMEM;
> +
> +	bio = bio_alloc(gfp_mask, 1);
> +	bio->bi_iter.bi_sector = dest;
> +	bio_set_dev(bio, bdev);
> +	bio_set_op_attrs(bio, op, REQ_NOMERGE);

bio_set_op_attrs() is deprecated, please don't use it.
	bio->bi_opf = REQ_OP_COPY | REQ_NOMERGE;

> +
> +	payload->dest = dest;
> +
> +	for (i = 0; i < nr_srcs; i++) {
> +		/*  copy payload provided are in bytes */
> +		src_sects = rlist[i].src;
> +		if (src_sects & bs_mask)
> +			return -EINVAL;
> +		src_sects = src_sects >> SECTOR_SHIFT;
> +
> +		if (len & bs_mask)
> +			return -EINVAL;
> +		len = rlist[i].len >> SECTOR_SHIFT;
> +		if (len > q->limits.max_copy_range_sectors)
> +			return -EINVAL;
> +
> +		total_len += len;
> +
> +		WARN_ON_ONCE((src_sects << 9) > UINT_MAX);
> +
> +		payload->range[i].src = src_sects;
> +		payload->range[i].len = len;
> +	}
> +
> +	/* storing # of source ranges */
> +	payload->copy_range = i;
> +	/* storing copy len so far */
> +	payload->copy_size = total_len;
> +
> +	total_size = sizeof(struct blk_copy_payload) + nr_srcs * sizeof(struct range_entry);

See above.

> +	ret = bio_add_page(bio, virt_to_page(payload), total_size,
> +					   offset_in_page(payload));
> +	if (ret != total_size) {
> +		kfree(payload);
> +		return -ENOMEM;
> +	}
> +
> +	*biop = bio;
> +	return 0;
> +}
> +EXPORT_SYMBOL(__blkdev_issue_copy);
> +
> +/**
> + * blkdev_issue_copy - queue a copy
> + * @bdev:       blockdev to issue copy for
> + * @dest:	dest sector
> + * @nr_srcs:	number of source ranges to copy
> + * @rlist:	list of range entries
> + * @gfp_mask:   memory allocation flags (for bio_alloc)
> + * @flags:      BLKDEV_COPY_* flags to control behaviour	//TODO
> + *
> + * Description:
> + *    Issue a copy request for dest sector with source in rlist
> + */
> +int blkdev_issue_copy(struct block_device *bdev, sector_t dest,
> +		int nr_srcs, struct range_entry *rlist,
> +		gfp_t gfp_mask, unsigned long flags)
> +{
> +	struct bio *bio = NULL;
> +	int ret;
> +
> +	ret = __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags,
> +			&bio);
> +	if (!ret && bio) {
> +		ret = submit_bio_wait(bio);
> +		if (ret == -EOPNOTSUPP)
> +			ret = 0;
> +
> +		kfree(page_address(bio_first_bvec_all(bio)->bv_page) +
> +				bio_first_bvec_all(bio)->bv_offset);
> +		bio_put(bio);
> +	}
> +
> +	return ret;

What happens with bio here if __blkdev_issue_copy() returns say -ENOMEM because
bio_add_page() fails?

Also please handle failure not success. Sth along the lines of

	ret = __blkdev_issue_copy(bdev, dest, nr_srcs, rlist, gfp_mask, flags,
				  &bio);
	if (ret)
		...

	ret = submit_bio_wait();
	if (ret)
		...

	...

	return ret;
}

> +}
> +EXPORT_SYMBOL(blkdev_issue_copy);




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
