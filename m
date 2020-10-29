Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B381C4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 19:02:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD56B2076D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 19:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LIh/azkB";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="W9jDJN81";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Qvqd3yfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD56B2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=d3dKDk1AguQj4Qa/9sMpa2CQ8ilaZIZIkNsCtJa174w=; b=LIh/azkB+M4l2qX7UAcScM6l4
	6JSDNxADYVv5cpQzo81srihXGxxp+nSAJIAQMCcoW7WQSDzvV/yIBRA0RkPrUxFgATpvl6KB7GLcD
	kzBKl7V5fnWcR8mVp57WIDir63Olr/v94PjsXrD1r8MaAhorfZiTOe9EoIxDnGUWteGtw7vagTr43
	i/AX3MTTdxnew8EhF9e8zLNH3PHatmGVInARBoKT8YEqadgdoOpesFDcWi53tJQd+HJv79eFDNzPj
	miH4d2Jhur4HocEr2pHk2r+QKKvaTmFPwJc1f7jqOfuyMPui/+AqD2Q3FjY5feTAA1JYsfit2F/7R
	wzaM+fOfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYDC2-00026B-Dk; Thu, 29 Oct 2020 19:02:38 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYDBx-00022y-VQ
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 19:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603998740; x=1635534740;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3LzyX5y4WA05cQmi6ZFA+XWvQHA0OTpVrHLDqRSFn1Y=;
 b=W9jDJN812E+CxNu2EpNrfTfOFQ/CdGBOOvBXC4LbH4vudk+cEIvnHpYN
 DQ2ADdpDOHJy6nbO+8BTMG+ueajdkUxgVteauEc4PvRi7i9qKRqrhXDFw
 mzI6ywJxuenbRBiRtv/SeA8WNj7B27TbHy2HUNm8SJMgAQ2tDaKqEMpCq
 uY5tcB6Jz8I88Ge7vsSieBB2gPHkNlTZRRnl+FLipYYGE2gVZ6E3SBn8s
 9O0fPt19aEKJAVBENslCJ592TS4Ub3Byx0/FGZZBHXGoqBVaqBRaMhkJQ
 CGUkP/IwYRSKW82K/S8x7G1hFk2+eyazXfYLVqU9ZhbjGjS7jTT61zqiO g==;
IronPort-SDR: WkSwQUflSN9MMExISWNhK2rCdv4M4eD39KqwX/IIn+dAeGSihdV5I2kfT7k9VdS1GNTlmkqg4w
 NENANtXviWfCcWDUPSqyG4bUjHfzLavqAfWoHQ2p33Eo48F71ulM54sHNYALlcRuF0jCXE7gaz
 q5ObyOpKdUvlq0TtdjhkMyTh/kf4PY/BzLjURhrKOzozpHWwMzLk8oWDumTHW9btjDQrJzq3G/
 5m9ftvBvzLrnTVButWDDNVmGT8yTvS5cNIACGqGUX7/Rw8wgKM48oI8v87+AJUJfi2i6udgqMI
 8FI=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="254804003"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 03:12:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec4VAkXksSTnV2j/nocmHP5uyXWrCesl74Uy3HFybeRYJR1QUY3r9qk3tSDGg5qNFnoTngQf1n7D5ANW5sjzbm1PAoHbcXWGvfSFZCdOpnqbjKrJ+P9e63kPnNGrONPtlS6nxtLt0QcOgBKXbLR1kMnYPHf4OdGTofzl11LClMvY9RktbPTDuoK33RSylR6J7itiXOBtFrgOluQMlYIsA13VJEUg7bZ6h35J1GxlNgT0I2z5ap/XJ4njlYURcxag+iheNQXrFVozTvYVITt38cZyB3Y3HfhEO8edDgvjDDAe6Amcq5ORfdp0NwplqUKpMDHu40YH79EGrC3c9k2kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqW+OG5yGWejjVIeas/rr/poTbBwMJ0gJOsWJTPAVG0=;
 b=jLMxCcdH4O0+NTomBrcz4Xi2IHsXnfr29oObWYhA70QNOqJlgqpd9hu/TBHq21dNAuT66wiokVP64oO3tP3Svqr6/V7hmpWecwEijNnLbbWvV+1DDZauN39yjNad4o+DE/3x56CLkcazztCtEOxjTXuGD26969w16BaXyQvUCpUNXXXzt80JWxUqILx2xF25n3TduhXFq7XlNURt4TFUFHh0qBjHjXrnXs3KIggEnmfMdJ/PkpcizlhDvV7wxGIwHpBJe+YtEbNilzkkHGED8B6WqDybBYqp5nxQgPJH44sIhxhBYmIVAb3lSACmRz4n4343cns9s//q1G6cMxtoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqW+OG5yGWejjVIeas/rr/poTbBwMJ0gJOsWJTPAVG0=;
 b=Qvqd3yfWfpKi0iN5L1YCUOl02/pfhLDWkMGa3W+ZefU5Eek4yiqf72fnTOl7dWcjBN9BMpLcUlnTWH/08FcUYTsUByfyDEnqUqMkspxV4OSdG2LtAJx2afotw0+Cc/96c/poaVZbFXZYdSvQHoFyfoRsoPz9HPv9bjTghL4EMQo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 19:02:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3477.029; Thu, 29 Oct 2020
 19:02:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V3 6/6] nvmet: use inline bio for passthru fast path
Thread-Topic: [PATCH V3 6/6] nvmet: use inline bio for passthru fast path
Thread-Index: AQHWqA8qLBNZ6QHjoUaEQNPs2ZQYFg==
Date: Thu, 29 Oct 2020 19:02:27 +0000
Message-ID: <BYAPR04MB4965980B745F28E069B8460186140@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201022010234.8304-1-chaitanya.kulkarni@wdc.com>
 <20201022010234.8304-7-chaitanya.kulkarni@wdc.com>
 <9ba9c9ba-7caf-e24c-1471-62c199cfcd4a@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: afe86fdb-7913-4198-ad9c-08d87c3d2da2
x-ms-traffictypediagnostic: SJ0PR04MB7261:
x-microsoft-antispam-prvs: <SJ0PR04MB726176F56FDD1D60CF0DFB1186140@SJ0PR04MB7261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g73cSP8a4iL2EGdYmREkbeSCg5afB5t0EOpAnEAKQ1WwmMJ4dplviRQULHweOVHUs/8pc8/Dffkc6q7IC8QLO82acJvP+RxlEhMD5nGHrBnXbMfXROPGCEZwyHSk6XZXtgaKIigtwYgl6HzZtekNPozEXFln7A/e3dzXnQ86W2ETJw/oxrquuTL0fjeJQi7cXF4lAQY52En494v2kJhdcQS2+G+wvBMeWPzvG8i4/yCGbIuewOkaPOLNxw2b//mg5MEtbnH+TiHDdVbJ0aymPCdNZkYoFHFZCoVKYL91l+blpZTuLM1aMdCgYy1TvpxGx/ZMyEAHL69ye6EVhK9vlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(54906003)(110136005)(478600001)(76116006)(55016002)(2906002)(86362001)(66556008)(5660300002)(71200400001)(66946007)(8676002)(66446008)(8936002)(52536014)(4001150100001)(66476007)(64756008)(4326008)(9686003)(7696005)(33656002)(83380400001)(316002)(6506007)(53546011)(26005)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: +AdLY8+xx3fkau4kaDyu3q9HyXduDOoc4kjzZB7GUWO78/AKlZgVFDUuDoeAvtawrgeJSYnuRa9QLfVyLwXELTsWIYQBLBaOMy90dIv+nVhhOUKqba9HChcInZmJsOgSLejxuZkv25qeZitH2Z8rjWdujVyRH9W69HezHitiqH002kFcTjPxCVp1NV1XeR5nmIsL7WowIrGGScNn6B2Als3S1IFzxMSposdyjaAh8j6/OP5XBdtGut/k/IabzAxLp1TG3/9ZPJGl+RM9/r4C2wXmcur2Exlsn8QmwHjxq3EHJ7TIt29EcpLaMUl+tZxcwKeukwudPPzzEUgFMSjikYjg31kMijpPG89SCNxltcdzp0UcYU2F+DsuXY8DzvaBKQHTbTOSdtTQE52twFtfNZk3DfhP7EopPaAWe3z/DMieSjzY58xfiKgC7+DvqDqBR3y8WuxkuRqTypsD++B+3QDyIJC7V3f/iDXI+b20MDevaDmrXL+vvkwIAh+9x/qx15aFa8XydRKLVD0vjam+zo+stVF5z1CNOelxsHWxKgmh3q3122knh3tPL1TligCiLWqN18vGfI4WkCTopY/p3b0m6S6SGOMIi4DKSWpUdne88kSpO0yTezyRANGktN/Gh031PLsiOrqXzUE35TbH2Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe86fdb-7913-4198-ad9c-08d87c3d2da2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 19:02:27.2421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWdHGOtI32Gbjvv6PgkNtaLjjSlqq0/x2D50P2S9n6jbiviXo3QLcoiNB56f2Gq5CX3erGjgkJ2CPFcVvjOzLHpmUAwcRS5n8CqPOQ6qXwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_150234_251767_0D93CF2A 
X-CRM114-Status: GOOD (  21.67  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/22/20 08:58, Logan Gunthorpe wrote:
>
>
> On 2020-10-21 7:02 p.m., Chaitanya Kulkarni wrote:
>> In nvmet_passthru_execute_cmd() which is a high frequency function
>> it uses bio_alloc() which leads to memory allocation from the fs pool
>> for each I/O.
>>
>> For NVMeoF nvmet_req we already have inline_bvec allocated as a part of
>> request allocation that can be used with preallocated bio when we
>> already know the size of request before bio allocation with bio_alloc(),
>> which we already do.
>>
>> Introduce a bio member for the nvmet_req passthru anon union. In the
>> fast path, check if we can get away with inline bvec and bio from
>> nvmet_req with bio_init() call before actually allocating from the
>> bio_alloc().
>>
>> This will be useful to avoid any new memory allocation under high
>> memory pressure situation and get rid of any extra work of
>> allocation (bio_alloc()) vs initialization (bio_init()) when
>> transfer len is < NVMET_MAX_INLINE_DATA_LEN that user can configure at
>> compile time.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>  drivers/nvme/target/nvmet.h    |  1 +
>>  drivers/nvme/target/passthru.c | 20 ++++++++++++++++++--
>>  2 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 559a15ccc322..408a13084fb4 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -330,6 +330,7 @@ struct nvmet_req {
>>  			struct work_struct      work;
>>  		} f;
>>  		struct {
>> +			struct bio		inline_bio;
>>  			struct request		*rq;
>>  			struct work_struct      work;
>>  			bool			use_workqueue;
>> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
>> index 496ffedb77dc..32498b4302cc 100644
>> --- a/drivers/nvme/target/passthru.c
>> +++ b/drivers/nvme/target/passthru.c
>> @@ -178,6 +178,14 @@ static void nvmet_passthru_req_done(struct request *rq,
>>  	blk_mq_free_request(rq);
>>  }
>>  
>> +static void nvmet_passthru_bio_done(struct bio *bio)
>> +{
>> +	struct nvmet_req *req = bio->bi_private;
>> +
>> +	if (bio != &req->p.inline_bio)
>> +		bio_put(bio);
>> +}
>> +
>>  static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>>  {
>>  	int sg_cnt = req->sg_cnt;
>> @@ -186,13 +194,21 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>>  	int i;
>>  
>>  	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
>> -	bio->bi_end_io = bio_put;
>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>> +		bio = &req->p.inline_bio;
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>> +	} else {
>> +		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
>> +	}
>> +
>> +	bio->bi_end_io = nvmet_passthru_bio_done;
> I still think it's cleaner to change bi_endio for the inline/alloc'd
> cases by simply setting bi_endi_io to bio_put() only in the bio_alloc
> case. This should also be more efficient as it's one less indirect call
> and condition for the inline case.
>
> Besides that, the entire series looks good to me.
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> Logan
>
Sagi/Christoph, any comments on this one ?

This series been sitting out for a while now.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
