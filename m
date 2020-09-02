Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0358CC433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 00:39:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1AD206F0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 00:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t4a/9NCL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HsgXgeXW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sLdMWotQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1AD206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=awb5vKNfyluhfpfV5RANHpBCgOi5noFP5OzR9qNLBlg=; b=t4a/9NCLOM6d+E46y20e7bpIJ
	KI4JW6S0WyrgLB9BsHm78HJWeDs1BMJZGuwk6+aPob7RJg7zyLLba/3TKwLZhBA11tD2SZSzP6cEr
	w7YYM4VKS38BtxeKkJAlLZm5DAPBwS8hFdBKzI5IVVoyqoM2PKIDFo5VFBTsA8I0jYTSSjWWq3F4S
	xA0JPBNho/dDd3LDCdoJY4tJE7X4ua1vbdvoIas8iqV2qLJIYR66TOlMFmaCANKaBi2FAoWCP6TYZ
	7JaUgSMroBSJWeSWb2j1Wj0KYpFFcNJsaehunnjzWtCLL2Zez2lUoad/ULBvA3Pou5txRg5U8HoTs
	RXlrQJSdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDGnt-0003cQ-6N; Wed, 02 Sep 2020 00:39:09 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDGnr-0003bu-6W
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 00:39:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599007146; x=1630543146;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Xz0QmxHnVPgFOT51Eix4A15r8IJtTPWDbqTvPiN/crI=;
 b=HsgXgeXW0rFAaeTc3RdX1TbJm2L7Q7H2CK/0VQDmPDOxRF0RKkdvAys0
 nZxV+lTCd7M1AHo7OoinIroN5vy14CRUJVwaaScnFo6X/nW3ALUn6kyQM
 OKSXEQ7RoheTzwdxZi/N+gJ4nM4fU8fYWUK9VQVbsNZ5n8QnwxPGdnMuf
 NSVb4hXutSyJof5jGM7q5W2TqyIDJtjUtKq90kFcujVMlX21bs5VHoMqf
 xzHcZr7jypitCgtmdFT+8OvI4la4mPbn18DPzKKXt7sPzWorHpkqyJUVk
 L4WQ9ljIMskIk4MBISJye6stn6GGCD99iJLfn7VYn7lq1w+LEWLhdDioX A==;
IronPort-SDR: Q05RqNHAss3N/9XdHn9N+JzKiLmpwccjIm5TUg3OMPFrUK9BumPmZUkiP22Li9P6Ketmk9dMzV
 N/027SOQvpMWymmC3E8IFgP0p2kL7Fg63ecKOTLd+Wbph0s5zMjST1XciNY4nYnViN4VH1Rgqr
 o/FJYCdXV/oVutR36UzY6UhhnJFvmHvAoZ8fD6eSoPVtwHatUOpsTVVo7pGlcOU6AJfas3emBx
 0Sus3IvbBF/4tBv1hW1RL/ENtTQ3dQ/kJ11Zc8J9QXhNjAW1hsk4eF4kxq4zSVEFfRmNXvjA5+
 9eM=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; d="scan'208";a="255893408"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 08:39:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xqe55GDUDLw4EefCiZyJrGpLOx/Z+n/hO/MhFO587+rJgj038pEkIEL5fEiM0hRJ260fyMFTl/RBKKI6NrGcJaDLVWNdkXlihTv4RlkYXRtX56IO7nvEdXq/dxgwiZimEO0ZERYqjCJenOB/QykwQcD0kBAW8QJd6wGEWokeKx2ndGg84SersJRvaTgq32DzT7P/jLpJl9oUViyhEWevHAYcVzgjJGN0emfmTmYdFVLkW3ML/VIKiDU8kNNUfz4ks6s6rKKrENaDW6ZFhInH1lvAhPTHzgntzTzS3+9UcQksQgYC4nspFaRbya1uyPdjZ1YAjtq2FbU0aaS8sHBPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPWJoCt7JG6+MEnTEN01+/w9/kbUuXGfblrwdEnDzXg=;
 b=DRTVJRM66c66HSLlA4uSNgwdcNXwPR6W/ODYy5yxu5incJMD9JOn3DnlO6qDSrCVC8uEVrIuyoB+o9NZnaFj7u1I8i/nfVlNfltnHmTemhsbfC0ypKUflAxg7Y/QBHIwfoBwTNPL8DcCIFEvz1EzNKpLep0y4S00IvBUHmPJohsia9GQNENrKHkeQZRnY8AkM0hiaC1kp5eKtyHPRGRGmezGvYKN+YRIRbO3JzZDYN6vE7ZZd1mD7BEjsgqgWaFUC8pWmm2HYaBmLJlV8K23gt7CWcdGso579ZDCJAfUvnbvxdbTmCaVdeHb5y0gkH7yJCBHPwLqCXvk5H/v9Bt+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPWJoCt7JG6+MEnTEN01+/w9/kbUuXGfblrwdEnDzXg=;
 b=sLdMWotQImLz3oePKwrkvnZX2gSDf42YBUGVJUwn74F0kABhvf9lPMUaFPyma6M1QJgSzS+GIJIgMle9U6uaGfqFObu5Rc92ZZOoX1gi16zw+FCyUtKBrLogBI2y5z2xnh2YsDwdGuHbfuoaQBa/M86TOsSIthK/T5iaSDglVKw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5830.namprd04.prod.outlook.com (2603:10b6:a03:106::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 00:39:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:39:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 12/12] nvmet: use inline bio for passthru fast path
Thread-Topic: [PATCH V2 12/12] nvmet: use inline bio for passthru fast path
Thread-Index: AQHWf+YBc1bw7By16EmuKiv3MbQcYQ==
Date: Wed, 2 Sep 2020 00:39:03 +0000
Message-ID: <BYAPR04MB49657E669921B89DE66357D7862F0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-13-chaitanya.kulkarni@wdc.com>
 <5f8c3740-9056-2eb2-90b8-1e7078492b4b@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 403d94fc-8d2c-48d1-122c-08d84ed897bb
x-ms-traffictypediagnostic: BYAPR04MB5830:
x-microsoft-antispam-prvs: <BYAPR04MB58306FE23E37294F221C1582862F0@BYAPR04MB5830.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I5RVlA958nij3w/o+Tioyl/2k+k7T7zFIR7UFBJIyj2w7DO9ar5Q4OvJtqy8L6pEO0yW4Nyj9hXEkcIdmaius/KZFg8e61QvYnKwGOgQjj3fdPTgvMBPcDdabjLauobo81ghbHyCPOfEiYywocunDiH11zhNpFPu9cJahw3NXU5FDu9AzzKZCfLqMDpRfCdwOtwANZhnR1Fb39Zc/2C3bRvT90MrirXpzzX+CK0h4xufAc8fHoumyq2nRUAfpDKJnKWhfpJ4R6XODHEFf8Yxs1yEW9UcTqvMxMA9D3fzmXkbGIhtpZ1F9TWiSzGl3iOp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(110136005)(54906003)(316002)(7696005)(2906002)(55016002)(6506007)(76116006)(53546011)(9686003)(66476007)(8936002)(4326008)(186003)(8676002)(33656002)(5660300002)(66446008)(52536014)(66946007)(64756008)(86362001)(66556008)(26005)(478600001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Zh7DjJAYqJTW/1WaKTe7vg/fP25DfeJoIPjkM0/aT7QFEkPDyImrkOTAI6ALTW8wiXEDn0jGgEPv+TeCnYYnhYCPAEpdhdjb9wPSJ26fVXHA1A1g0CvbmlydlqnKysrRo0EMoSsQ0014+9U2K7Mxh9N9NQrT1KxcEXaUfFEasUdbOIesLwTMu7I2M47lnHDxzr9iKPE6reJY55aMHv3yDdtmMV/kq1IXQYQXymgCiwM8e6FHyZ39Zabb5nZ8RV1Uk5QSPpKGj5dLifRPoStjBT0xj2r1I2YwiRAvPQjki89tFprxLe8OmTlxjJ8nMAkvCNk4ILCHZyBTbLWgY0j9kwF1oAQARiIZitZXyxWnqCmu/5FRM4bO2LLWdT2hsJzujuLS+9vHxvJQKSNeFYJ023CzacRna3pQ8052caJ93jdnyRM04Y0nc7ZlEUkhd1vG6qKejRpFT+FEB3R3fmYN+k4KPzFfFnBgWwzqbSzzlhbe0EyhoGYpi8ynhQFrJW3iaHvbAPM32wnASWlTuw7qJTslG6yeOFSFqhFoHL5/0guukPgd6UXrYJzbdieOBVddI1W+r7WjpFj/fSl1XuLreH1HN9Wy3tks7gZ8N0RI3+kjUdd5YYozC1zgH1tLLgr5PVKD+BldC/SvKsQivEYYZQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403d94fc-8d2c-48d1-122c-08d84ed897bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 00:39:03.7017 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWyCnSIvKjEjcJlK9p/X+pnLrVHu7396zewXcMxVtC8CYYKAGTMQ7ANdQunsPyMCJqdgjDs8dJnBw2Df2Ni0FZVDHzQaoS2Wfibpq40DrI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5830
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_203907_432679_FF964AF1 
X-CRM114-Status: GOOD (  13.29  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/1/20 10:29, Logan Gunthorpe wrote:
>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>> +		bio = &req->p.inline_bio;
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>> +	} else {
>> +		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
>> +	}
>> +
>> +	bio->bi_end_io = nvmet_passthru_bio_done;
>>   	bio->bi_opf = req_op(rq) | op_flags;
>> +	bio->bi_private = req;
> I still think this would be cleaner to just do:
> 
> if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
> 	bio = &req->p.inline_bio;
> 	bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
> } else {
> 	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
>          bio->bi_end_io = bio_put
This is intentionally kept consistent with what we have for bdev-ns.
> }
> 
>>   	for_each_sg(req->sg, sg, req->sg_cnt, i) {
>>   		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
>>   				    sg->offset) < sg->length) {
>> -			bio_put(bio);
>> +			nvmet_passthru_bio_done(bio);
> Then just open code this function here...

> Logan
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
