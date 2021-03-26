Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA01C433C1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 19:03:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454056193F
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 19:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454056193F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=DZYdbTbiEDFnQrLScWayMj0+rLeKs6BSDRcdhw9QbVo=; b=gSJiUSC7m8aE5HMerRNdWXrO3
	2eA/A5HlRW8CjsmLJSjNs9H6Vvt9Ju/AwzleFS/p6SOTizBtOfoFLqGdiNvLRuNGT9RUVT1Fl3G7j
	1JTgfwffK+cDREfojnHb5jbyuzD6qfgOG6Bf8QhZZOYt6ldctiIfvdWwTGoSTqed1/Pi4v9XU23ne
	u3RgvZW+TE0Fy0zClE7MfW2EGsZgWW/BYEZDSLUbZ1cHKgEh9/NDLBIi2w78lVSjSDerw3+3Qs2cl
	RnPA5MYPr9KU10YMWzRa7sOmuoyRH2sPTFumGVtpuqF7/qrJqvguK69fdUJIQfegmEWMA/T9StwLA
	VDVf6oMnQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPrjX-004BWO-Ew; Fri, 26 Mar 2021 19:02:59 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPrjQ-004BPO-FI
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 19:02:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616785373; x=1648321373;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=M01reyGvEjGtohRw6AbHcZSMitDelYGS3dNfDbM488w=;
 b=hiHfJlfY4+bFN+sxn+N8t/cteus3ynIMX8H6W0IY9SQ6ZoeR8rQ+KJTx
 FbKJVFteS3C3gw8SYf4zku6Ju4TbjLv6lUeYNQvMuOhM3vAgdtyBgZP2V
 XxLPRy/TKG73/uhKHf/gXny7xF5hOifNsFFNVdKhhyAWT1D8LeqbVgLBf
 cSWZN/KnH4/e2nklu+xHF/KkENYXDhvKmdFXrcB09FM2JcM6t4AvGQTwH
 Oe5dYn2QenoKajTGyV5JELKw3ZYJGwXmVHhbLh1WRUOUTPpZREJbuHSM3
 i8Wjz00D6beRu0xBEQjbWdJSraSxlsmv0VZ/S8h1NBrYRgFP3O+7n/gkB A==;
IronPort-SDR: KWHmF40DJHnw/dBb2U7mCuB+7GO43/SbBw4nyngzIjb8NMvUnZK9xb8pqrdNoLf9213qP5KEW2
 cJPOJ6QDRP+6jT5mhGBelpLh9aTr59I7DFuikErWBkJjiBIsZQQ9Yh8N+me0PqaoaviwyhEwph
 qc9SCXzAIiAe8amnxotHFSJPpLPJdZV12BX2F6lcZUIPVrCufJrkwOuZpkoxhzVbJkVyL8pk8/
 FdZ43aCHO1cWZKkAViR1ALT2qFjCSm1hKoCADeJYAnA1rh6WkVgfprmGBkSsrq4OtglY0CjJMa
 wQ4=
X-IronPort-AV: E=Sophos;i="5.81,281,1610380800"; d="scan'208";a="163105296"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
 by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2021 03:02:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wb4hIP2yN5FFu3CNETIymaXGC5+IhwSVKLDMudW6A8UsRkz6gzmSJJi9N3vgHGcZiHArivWXCT5/A0IFYnoSeAQVbPA+8UlR2OBYjSDlJotIUH/MsJ80HiabLAT61nvIEUZwvmzblib+3KeVWtqLe+eF63p9ikdrjqhXGRanh9TrbUuyLcsap+2iFtGWZ60EdBMxZdfoirt/YKvPpJATPAorNJHz1WDZvwNnWybc0CBtg2xpVlRQaCCmF7i6tCpJESBwrvkEy08D7Q1muhuYYqnFRXe75TllQ8uxYDtXjxRfGLiFdM7dEUVUz0cCZabLf7FuJISte00MZatKOr2Tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M01reyGvEjGtohRw6AbHcZSMitDelYGS3dNfDbM488w=;
 b=bUi4BaiEkA5zSQCuo1XKKoG4HAcadOn7y6U0HDdf6NaKWlSjJ/ngDqUrr2st3ahX/aMpuPen9mlj8N09qjnpYLK02M62bKTnt04esmzudHCHhv2qFz6vc7uAugUqtGWCZZYo9Y+3FHEoRrDsn9FClj6aV0oQqbMYzrXpzf5emlFygNrEIrSQ+IH4uawjuB39eIeqidpF2weASP6Nhxx5iACPisY2cGc8mSIYryeXJMbPU5tI5NKqaK0E0FFPHxb602B1pPFqvbIPg2LR26HrRGNLagEtlu0P8ZxlD4Z4qkGhj51mfIj9gkllhCzymvgEx/T/aE4SeVLprstCUkjYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M01reyGvEjGtohRw6AbHcZSMitDelYGS3dNfDbM488w=;
 b=MHc/MCezu+lCPVdlI1Ob49ZZrapK4j6YFI5+C8Bhe2+5kebHm39s2uuzEypdgA9+Qfbj8qF5hp5OV7EcHTVlutU4AM/o4UzOAjIwN52kSdNXQYgWW13mKU3FiWrnnpKZ9GL1J/CotWXv7SRMFMfz81DlnpMl0+sM2gIznjqMqzE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6245.namprd04.prod.outlook.com (2603:10b6:a03:f0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 19:02:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 19:02:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Engel, Amit" <Amit.Engel@Dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "james.smart@broadcom.com"
 <james.smart@broadcom.com>
CC: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Index: AQHXH1WVLcQtkgKwTE65HaVNrQAkCA==
Date: Fri, 26 Mar 2021 19:02:44 +0000
Message-ID: <BYAPR04MB49651D211A8D26C40EB52C0386619@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210322195717.13094-1-amit.engel@dell.com>
 <BL0PR1901MB2020C91B6489355411A00578EE619@BL0PR1901MB2020.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: Dell.com; dkim=none (message not signed)
 header.d=none;Dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0caf8c2-432f-465e-0cef-08d8f089bd5f
x-ms-traffictypediagnostic: BYAPR04MB6245:
x-microsoft-antispam-prvs: <BYAPR04MB62451A72D58D97F41B57280286619@BYAPR04MB6245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IwZzttUT40EFpvNOBeWuG98Lh7Ey74PmiaNtWNGrO53YPprWV68ClKK7gQFF+Dy3Ds0kVLNwjLx4S6mRjjz7BgHcgpxyG9tT0Wf+bcqysRiJKws89JLhD2LoxEKqVp/8x/54bUNmlk/pz5sj1mL7Vy2/zJ5pcW/XZSkb/6jTQkcqeAqWMAaVtVCq9soDG3UWx6zlrue21u83YnNGH4rSTZF59hdPE1Yuxg3Qy2tdqY3RUKcx4R62A/merA1P2C3uF6jESU3/bkOvYEjH9TmN8uj0g1S0R7xYKPf2rLP8wjVtdhE0yQi36qdDQu45VTSWQGFcpbTBlQpmy9eYTCH4vy4TDxt1CSKPkGswJIt59RJreKBpTLRIoqnx1H/+q0tXEXxpe2sibLAjcO9dSSDT7A/m1NYXcZorU8NQfe2CKcaw53JTA0olZ9U44M9JsuY6XH9uIE8FyDHTuA3Hxt98XbZVceZIG1JwigZutuGxdSZ3N9wrome9Ghdv/WvcHfciQCcckEpv2ZHiom9P8ISXN6GlYIG6/fRcM5Yy6Pdf6BMNIu8wnQ5g84cHjFlEgXcY3V3SCbKD0MtnqfjfnOOb7tf2cZvH8Ov4OXv8+01yXo1OTnKuAwK9wM6nXNhCi8iPl4mDnSkmi6W4IVuzWFSY9aPlL+mUrcT4wytE6rj7VrU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(71200400001)(9686003)(33656002)(55016002)(38100700001)(316002)(558084003)(8936002)(186003)(86362001)(4326008)(7696005)(26005)(110136005)(5660300002)(66556008)(6506007)(91956017)(76116006)(64756008)(66476007)(8676002)(53546011)(478600001)(66946007)(52536014)(66446008)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PPx+ymHFFlFJ4VPpVZbNm8+Px9uHw0U5f+kNXAhw0u1lpzOADyw1Ymdhqds9?=
 =?us-ascii?Q?ypGRPeiWrQYSZ8k/5J3uSfD7uf9xBiOXOlalYIBpq32jGtCzWwhmwlgafwJB?=
 =?us-ascii?Q?ekOi9LDKZ8t2l/G0XjBMW2CpTgZsVenWpkrhCm9VuD+kasvufQDZE2mKfsdN?=
 =?us-ascii?Q?vZ/Hypcj7Wc68RH1cKZsR0nEMVXOKLRlbo26vTc1WSL/bZAbRfZMkhAeVPqS?=
 =?us-ascii?Q?A6zOCpzDQzMvuyJp9CcuB0L47HYtQbBxwDcEvrlJ1uSW/J7trfEPSUIiCS1T?=
 =?us-ascii?Q?c8fS1f36sJL0JcKOVTSVsjgmd1vkkhN4KVsUZAu//e0IukqJ72YJBk5gfXsg?=
 =?us-ascii?Q?dQhczae+4rgulIKclMvYmRuqCuabP3pzBUXCwLUx0wO8QInyzEkAG6qBn2pF?=
 =?us-ascii?Q?YH7gOrHSgpjf5nZ3lCcOwCKlI9yLkYuiVDZ4Uz2XxHCuz5FgNLtu/LOWXwZx?=
 =?us-ascii?Q?+NV72eeI9tZr1LLqJFMPjA2BQdePttZXoZD63LA2y4I+ZcIWle/mFywhVKfi?=
 =?us-ascii?Q?/fN+rMvLeNNHW3f4hKEyNZK7jMJSNvuob2l7NuvWxt5COhmNOezpR2KvTZlG?=
 =?us-ascii?Q?LIbGnzJaSEPgiHoHHuCzPPmBtA68N72ioejRqE/GRvlPNFbxfZ/b+BlSiJuG?=
 =?us-ascii?Q?e42cIG9RoxI1MVmkgxleNeoNNCyNIH/1/s4mK7moByEYy/pFfNs1yXLoEq0p?=
 =?us-ascii?Q?XGdr6NlDII+5jPh+7yZjzWitUfzAGZzCidk8ytbIghzWbFhcqeFOPpEW86XI?=
 =?us-ascii?Q?aeLFL6xHjUpevUarrEV5MvRuMa5D2cjrkrZsC3+A0j7i4LSUgqDDKML9aF9b?=
 =?us-ascii?Q?ckozUUI4ln1JREWyGNYaBE4r48qICfKHfLQTfwV1KLCVAy192Va8tHrhNA3a?=
 =?us-ascii?Q?E5Cv0Ds9dksqKUQPJ2ujgUtcwzbRpx0Vj5i7vLUJAaAW1BdwF2MvQIbiv/Ul?=
 =?us-ascii?Q?T7gGJrQu/A76fhelnk1RvyD6TwB+HTlP44E1sBtlKQHVWfcSDC0pfAbvGMJZ?=
 =?us-ascii?Q?ZmuE5p92tOlbOBX4QaCYuHBzsjWn9RHeB6jU0iPBFG3rHjpvKJ3AbV7XTHt2?=
 =?us-ascii?Q?femWOZp3G6oum+5fxO0sIn6qBHjMbPRUw3DBqs9jQJ2cPLC4YImDPcJqtSFV?=
 =?us-ascii?Q?+dasKKSAtJGSBmXQuqsAeNLoU/JWuDqCERhkX2EK+PowNPicaIDZOnchzNCj?=
 =?us-ascii?Q?ZnhMwL25aOhCU0FXihvorwZnnq0jiWqp/VlRNZbEKKY9EWCnWKm0vkPk8nzx?=
 =?us-ascii?Q?yYjQ4vn3ktK/gWzn+Ofn1dQA+VDiqzPb8GwvCsvBG/c3FuKaEDMzCKtQz6K1?=
 =?us-ascii?Q?G/l1W4UM/YlIntd3crbP/Ccj?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0caf8c2-432f-465e-0cef-08d8f089bd5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 19:02:45.0114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpBUi1sV4+HHAvPPkpxYkrIjFOs0Fr85UcaHYuo0sev/Pl1LrJM9yb9jgFoBLl7D1uly/HISJStyLF00iV+KISvpmINa+NqNfP0NOpRfXbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6245
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_190253_050586_CB03B018 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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

On 3/26/21 06:32, Engel, Amit wrote:
> Hi, are we OK with this patch? please let me know if there is anything that is missing/required
>
> Thanks
> Amit E
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
