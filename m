Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE1FC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 22:34:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE88161159
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 22:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE88161159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gRHfy6Hsa+CtJnHQes/G7wNtsLiAjX03vgHn452IkNw=; b=I9thee8NK3FpVzv5xn2MEVsEz
	uv3Tsvy/r/NP2B4ilAvUEY/0xOgV5ZFOekxFlcIcHjwtEUy8X7OR0Id5hdZ+PNi1uQ3e+x+W7iGui
	DFiIbdT3s1+Ju5guMYGYfgRdZmuirYlAG1oTB7WojcIwMpLR1jsq5u7bl1uHeUigLpTae2y4B9nKa
	zmBXYI2PnivEZ8ZJoJRN53oi4epcwCZ42bu3nKz/Dp56SI9dx4GrFN4fA3nK/xT1bI+SiqKYpXQjF
	ieKYbrRFEogSjt/Tv33E3WJkbE4OdlHF2DBD9i3rO2orBLR7PLbz3WncaA6mmqJ4mziUINWj+wm2E
	aVCnKIw5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUdEE-009Nmi-VJ; Thu, 08 Apr 2021 22:34:23 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUdE7-009NlC-ST
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 22:34:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617921256; x=1649457256;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=15D+Ku7QjjlUEIvx6bc23dLiMlcItudtM6Ac8MSpjHA=;
 b=f5MtwIjvV6ra98RDfxemg5xsrV+gB7UXq8DPEww8VGWKQuUnmwSFYb3l
 jic32rYvmwOdp9MfPK7RDrh3Kagz+FGO1rtQ/9BptiJloI2heNBMJ7HQ5
 tFHPbD3BvMnlU7uVJmCrONl593IbUpGF8RVYu4YZMRuNDEExJa5a6/Ff/
 RDXu9sKSRzmYTwWOwzt40xSjEq9godWa0r/AgfCzCmyXUR+k2XjD7Cc70
 XtFYDYQUUno4MbJGDWjSgswSZDetY8gD4MDSdEhJkcxKnFvTkdru7eaSD
 J7Jdxj0IrEKsyNxCexggfgAjn6jjqFFIJwfSA2T4wdmiQTiqp/gML4Eb8 Q==;
IronPort-SDR: pOaPqqmuNIskqkLaXMg9Z1sDlQi4SBSYSKw0W6DkTBtUobSHrUFycE4BCT9PdFD3meysyBywXP
 FcHBWC4HwhjTETNs3d4zXmnuYFDLDnQsqNukVnEWQWcWr5jpX328jKKIwUEl0Dcz2Gvc22kXQ4
 n3K3QyEvOj2wEo9NG42NFVwEsX1DG0sI++40O9YfUZiHSOFvClw1ojz65JDuG6aKa5QmN6z3dJ
 FRk5zAC8nefQ4yYHdlNnwGnV9VUGYSm4sIjS015tj27e+ktjmJDw2tPW1z0YMFDZ3b1p6Gop9/
 oUo=
X-IronPort-AV: E=Sophos;i="5.82,207,1613404800"; d="scan'208";a="165118143"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 06:33:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvCc8fPxBF+XN8OxPb4JNFqHsZ1FUG366W7AW3CpNVbhi+UGZ9A07w2Yd6nIg7nfPpw0lFdMFEBrnyeF+bGF/RlTX/7nVCdJIu4tBVQvjPdfctDZfBv+ciiBVS48mwnEUJ+1epJjnVqOy1qWA6laSUp8U+oWfOUr5VhQ91S9ZsUglDjwOFx7R9Zzgp4m50rxDnX781gFJ1+kNctGO5IN/Fq3X37+ueprevymAa042blyvRyB/3X0YlA6Og1QODdfpo2gKv/AKVSVBUwQADopkdcwPNNLWPR++PvHqWZW29PVmTTxXog+kktQ9VfDc6OHZxWeD3Sr85XuXSKW5lYQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wFvgsWkPO9Gik50WwsZpOfFsVOVt0UpJm0fuiDz63s=;
 b=Jsxm8/24SF8io6sOkNWyE5bUHkQtBQGmFBehwht2Z8juMYp1rDAeTr8Zkp9LGJ7A4+JVmAuGHUCyhqPL6WhrDgC6tOzixc6ThupUxEcTd/ypblqhWbjNJGICXIgx6mSpsiM4H4RXPONImFvS2Ec4Ny6MLKRU4OagNleqFYrAPNYeo608j9v042jeRj0Tz/JzL3prMRa0zfX0SkvspFWdSNym/sDphL7EfznLOtpeUa7/+n6WycswtGGxFTtyWySO3zMlhwDWaxmVgVCPAu5ivZLGFhJSePz1nYFyyo2Eb+TjVTcpmf1mhPuzHejRP5KhJUR34wGAdb25fJT5ZDeTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wFvgsWkPO9Gik50WwsZpOfFsVOVt0UpJm0fuiDz63s=;
 b=Y1eurVJ3Bk4WtMiAZMHhAMxRy0LuyS26z0qJy7IbX/B+J+8GRR4qvVoJJ7vEufyi87OIUvyBGsQXwXZ1vblSMXYZY6sDtwT1n+dJbfD3mFXOSMwzS93cog6Ng4tz6Kp7SThHAf3I9m1lb7Bp2IrLYNbTuH+dGB9gQjRFymPW3TU=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6492.namprd04.prod.outlook.com (2603:10b6:610:6e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 22:33:29 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::387c:71e:e236:a958]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::387c:71e:e236:a958%4]) with mapi id 15.20.4020.021; Thu, 8 Apr 2021
 22:33:29 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V13 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXLAw0YQqn+n3DOkSGqRqPJyQbqA==
Date: Thu, 8 Apr 2021 22:33:28 +0000
Message-ID: <CH2PR04MB6522E0F7130595E66FA85560E7749@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
 <20210408001427.20501-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514CAFA7FDA65E10B1DCE11E7749@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB4965EF4797C51B1896D2640486749@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5eb:da03:d474:9abc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f34016b-11ca-4f8d-4f51-08d8fade551e
x-ms-traffictypediagnostic: CH2PR04MB6492:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6492E940CB200E280D07D0F8E7749@CH2PR04MB6492.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kwo7OWpQXwU99qJaOGz6lJTl+SSopkEmztLi02RQkus5+5TSEypiT1JaIdomGL+N7jvtb05oErH9n9EAH+ysj2JFn6iZCTxT/k+bBfbFmzk7+w5EnGPv6W/VuY2D0bwA/e+cFnRnRQTaHAohwLnE+0adbfy6pDjHs1t9algk3cuqWGeCr4XKC6zVSrWHGREwg5sG503Vn5V784uxYJl0cPIHEMN3ZKeLTrqE/7n436rY3ZApb64On0jBz0uCLfKDi/U2v5pRqXbV2HK0nlwjdZy9hAYNv+nvQ3t/Ko+tafSmZblu92oPEFB4Kt6a+fbxJCWbSB+/ItK0Lyxq4ngM4QntNHOvs6ZfH1XFTMXWTvVxNVUOus9UcVZBq4Vl7B/5R3Ac+U/S9+93gRXQdLXvs9FCUVGYoiQKNYQ66C2Qq43OMUDExFg4NQv7xRYZwkXXzVXhk4SXfmZ2VAUgC+FGLyV/Mp4E5XgJhnOZM4NMpurKDNGFq3fsU+my6Evf+KPkK/A1W8kanqHr5HfTEoutVppQQfD/wd8mlroF/q//AZRpOZ0vCQBJFk/VbkxjZJbWQiyyGs35ghN73BrCV3Jlv3AF2zsSpGzoVBCQPcgsJe66WE7qAdRyLfaSC1r8zbWAj036fYZaOg678Z1+76bDjOsd+zfxcd/Glj+pma9AlPg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(66946007)(33656002)(6862004)(5660300002)(54906003)(7696005)(91956017)(2906002)(64756008)(66446008)(76116006)(66556008)(66476007)(55016002)(53546011)(8676002)(6636002)(38100700001)(4326008)(316002)(9686003)(71200400001)(86362001)(83380400001)(6506007)(478600001)(52536014)(8936002)(30864003)(186003)(579004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+p41ZDOd/tx5GJ7lUWxy7lXFBtxkU0rctwVmY+TcqnfQXKJxytTXQpexinfM?=
 =?us-ascii?Q?Vnf+Pl+vvwR6yqliARbG7jhEhRwgWP13ksernwCUrjPYiivakfSuXMr+B49J?=
 =?us-ascii?Q?Lrrkr0bQ9w1pegiu6+f4MRfi24TJnA1JLKPdQfayjmQntQMC5+QufMV5Z63j?=
 =?us-ascii?Q?mc8C/YWnaNc/A3SXzF9/lGkFdV322qKA2FIrpen4+QUEAb4cBmG/nnWZXHRM?=
 =?us-ascii?Q?AinQyI05nOSj6YWLjfKKupgPHH0BiOLp1GMBq1AJTAkL0tYV727d5GVlVQII?=
 =?us-ascii?Q?nLu8AyeeBqbrzS/MEtlOOjsCb2E/Hp48SYW1XCoijbkVK3Il/q0YwViYrlBW?=
 =?us-ascii?Q?8XZaTgCmjfi5XFkqV7L2LhSPZbjcWXejWEuzI1VucbBuIAq7OGPwfEfl2mI+?=
 =?us-ascii?Q?sh3oGTsHZFn6rTri9ym06pUS4ke68ZmXF12MKTXn6ISZMs0nMzQR+yO7R3Zx?=
 =?us-ascii?Q?VBD/mbBK9ygHFCRHRDlVti+nWF936/je5/pZqU0Phv9mqKgf9DP0Mfg5NXmW?=
 =?us-ascii?Q?qrSvFvc6bUYMnGrqvD8PiXvaXEJAXCk/UPvNICfS4YUwWFw7g/cjkkXtphfV?=
 =?us-ascii?Q?4QRPr3WLLV2q/Kaq1uuuVkutGwYh3clIZUsIlnwyoPUz6PMtvpUEaeL0QNl8?=
 =?us-ascii?Q?Day/Epb3YZDR6ZjkpjyaWQ1DiL6fVDKY1sZUpJ1fcfSUyBDEieuzi/GxnKa6?=
 =?us-ascii?Q?Tjah9OlR01Ee0k1uDPpZgKxFq0TWxQiGeZ9VQnssSue+M2W+H1IDOFLvCvb5?=
 =?us-ascii?Q?nepqp+LxnksMzYA7anEDcDUDWbjMaSeXiFAePMJj592SIrg7UYVQyL7FwSyP?=
 =?us-ascii?Q?m8KcSQYSyhBiy1vnzU1eJ4IqJLryyK1iYPKwmr+T79LqmwJvxqE5pR3ZNKJ6?=
 =?us-ascii?Q?G6rSr8/ThkQTuw/CfjA9QOjhU0mticjXwfyenh3bFWZWETMeTx0BT+ma3zA4?=
 =?us-ascii?Q?Ne0HWt7BUKonRqiPoEgVf6rCNAWKAs2Masoo6OIb/JEBZ01Cd376/yjGVYVY?=
 =?us-ascii?Q?KJszKXZy40WN+k+v9lqghtrPyklS/yGffMhBEAAbKsGycGj9ofGOzHiLuvVH?=
 =?us-ascii?Q?rZsVwM/36Sbh/nDofSgDyuqaXZngzyN237LpDwzJqqappmGgx1coLmHXPjul?=
 =?us-ascii?Q?+rZuuesTPHWMpU21ein6Mz1EMQyc5b6iHzmwKblalE8LP8zpdY7nEP+CpdOV?=
 =?us-ascii?Q?S27s8+BEukG+HBZMwvPhnOCdERDf0wwxK7vukstS7Nv+MgZyl+ZRi53JFo+d?=
 =?us-ascii?Q?gIkxLsFO8Ho7N3nifUEZMaFXn/qRxIJCN6voyzS4VSDjWEsFmoIvvwoy8J/q?=
 =?us-ascii?Q?Cz2vNqyJbOSUZOHmtmqXUNIAXbre9PXnBi6K8Xkv2GHJBGNK7X46nZ2BhjAe?=
 =?us-ascii?Q?QkLNQqr0nqnbkGCiSe+xNRdu09iAamdmA4NgD5vX1kdgYUs3Vg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f34016b-11ca-4f8d-4f51-08d8fade551e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 22:33:28.9185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqsDLc5VpWg0GLdGY7JDKsKiUfyKrRDctj/RvUedydpQXhcz7FjLsGuj4aioq8tnze3XM//6sSWePpIvbsSSfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6492
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_233416_977926_067C70A9 
X-CRM114-Status: GOOD (  25.35  )
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

On 2021/04/09 7:06, Chaitanya Kulkarni wrote:
> On 4/8/21 01:01, Damien Le Moal wrote:
>>> +struct nvmet_report_zone_data {
>>> +	struct nvme_zone_report *rz;
>>> +	struct nvmet_ns *ns;
>>> +	u64 nr_zones;
>>> +	u8 zrasf;
>>> +};
>>> +
>>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned i, void *d)
>>> +{
>>> +	struct nvmet_report_zone_data *rz = d;
>>> +	struct nvme_zone_descriptor *entries = rz->rz->entries;
>>> +	struct nvmet_ns *ns = rz->ns;
>>> +	static const unsigned int blk_zcond_to_nvme_zstate[] = {
>>> +		[BLK_ZONE_COND_EMPTY]	 = NVME_ZRASF_ZONE_STATE_EMPTY,
>>> +		[BLK_ZONE_COND_IMP_OPEN] = NVME_ZRASF_ZONE_STATE_IMP_OPEN,
>>> +		[BLK_ZONE_COND_EXP_OPEN] = NVME_ZRASF_ZONE_STATE_EXP_OPEN,
>>> +		[BLK_ZONE_COND_CLOSED]	 = NVME_ZRASF_ZONE_STATE_CLOSED,
>>> +		[BLK_ZONE_COND_READONLY] = NVME_ZRASF_ZONE_STATE_READONLY,
>>> +		[BLK_ZONE_COND_FULL]	 = NVME_ZRASF_ZONE_STATE_FULL,
>>> +		[BLK_ZONE_COND_OFFLINE]	 = NVME_ZRASF_ZONE_STATE_OFFLINE,
>>> +	};
>> This creates a sparse array bigger than it needs to be. If you reverse here and
>> use the ZRASF values as indexes (blk_zrasf_to_zcond[]), the array will shrink
>> and not be sparse, then... See below...
>>
>>> +
>>> +	if (rz->zrasf == NVME_ZRASF_ZONE_REPORT_ALL)
>>> +		goto record_zone;
>>> +
>>> +	/*
>>> +	 * Make sure this zone condition's value is mapped to NVMe ZNS zone
>>> +	 * condition value.
>>> +	 */
>>> +	if (z->cond > ARRAY_SIZE(blk_zcond_to_nvme_zstate) ||
>>> +	    !blk_zcond_to_nvme_zstate[z->cond])
>>> +		return -EINVAL;
>>> +
>>> +	/* filter zone by condition */
>>> +	if (blk_zcond_to_nvme_zstate[z->cond] != rz->zrasf)
>>> +		return 0;
>> ...since zrasf is already validated, all of the above becomes:
>>
>> 	/* filter zones by condition */
>> 	if (rz->zrasf != NVME_ZRASF_ZONE_REPORT_ALL &&
>> 	    z->cond != blk_zrasf_to_zcond[rz->zrasf])
>> 		return 0;
> 
> Since you are okay with this will make this change, except the array
> name should be:- nvme_zrasf_to_blk_zcond.
> 
>>> +
>>> +record_zone:
>> This label can go away too.
> 
> Yes.
> 
>>
>>> +
>>> +	entries[rz->nr_zones].zcap = nvmet_sect_to_lba(ns, z->capacity);
>>> +	entries[rz->nr_zones].zslba = nvmet_sect_to_lba(ns, z->start);
>>> +	entries[rz->nr_zones].wp = nvmet_sect_to_lba(ns, z->wp);
>>> +	entries[rz->nr_zones].za = z->reset ? 1 << 2 : 0;
>>> +	entries[rz->nr_zones].zs = z->cond << 4;
>>> +	entries[rz->nr_zones].zt = z->type;
>>> +
>>> +	rz->nr_zones++;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
> 
> [...]
> 
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)
>>> +{
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +	u8 zsa = req->cmd->zms.zsa;
>>> +	sector_t nr_sects;
>>> +	enum req_opf op;
>>> +	int ret;
>>> +	const unsigned int zsa_to_op[] = {
>>> +		[NVME_ZONE_OPEN]	= REQ_OP_ZONE_OPEN,
>>> +		[NVME_ZONE_CLOSE]	= REQ_OP_ZONE_CLOSE,
>>> +		[NVME_ZONE_FINISH]	= REQ_OP_ZONE_FINISH,
>>> +		[NVME_ZONE_RESET]	= REQ_OP_ZONE_RESET,
>>> +	};
>>> +
>>> +	if (zsa > ARRAY_SIZE(zsa_to_op)) {
>>> +		status = NVME_SC_INVALID_FIELD;
>>> +		goto out;
>>> +	}
>>> +
>>> +	op = zsa_to_op[zsa];
>>> +
>>> +	if (req->cmd->zms.select_all) {
>>> +		sect = 0;
>>> +		nr_sects = get_capacity(req->ns->bdev->bd_disk);
>>> +	} else {
>>> +		sect = nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);
>>> +		nr_sects = bdev_zone_sectors(req->ns->bdev);
>>> +	}
>>> +
>>> +	ret = blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sects, GFP_KERNEL);
>>> +	if (ret)
>>> +		status = NVME_SC_INTERNAL;
>> This one is a little odd with regard to the ALL bit. In the block layer, only
>> zone reset all is supported, which mean that the above will not do
>> open/close/finish all. Only reset all will work. Open/close/finish all need to
>> be emulated here: do a full report zone and based on the zone condition and op,
>> call blkdev_zone_mgmt() for each zone that need a operation. Ideally,
>> blkdev_zone_mgmt() should be called in the report cb, but I am not sure if that
>> cannot create some context problems...
> 
> Please see the explanation at the end [1].
> 
>>> +out:
>>> +	nvmet_req_complete(req, status);
>>> +}
>>> +
>>> +static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
>>> +{
>>> +	struct nvmet_req *req = bio->bi_private;
>>> +
>>> +	req->cqe->result.u64 = nvmet_sect_to_lba(req->ns,
>>> +						 bio->bi_iter.bi_sector);
>> You should do this only if status is success, no ?
> 
> I'll add a BLK_STS_OK check before the assignment.
> 
>>> +	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
>>> +	if (bio != &req->b.inline_bio)
>>> +		bio_put(bio);
>>> +}
>>> +
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
>>> +{
>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>>> +	u16 status = NVME_SC_SUCCESS;
>>> +	unsigned int total_len = 0;
>>> +	struct scatterlist *sg;
>>> +	int ret = 0, sg_cnt;
>>> +	struct bio *bio;
>>> +
>>> +	/* Request is completed on len mismatch in nvmet_check_transter_len() */
>>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))
>>> +		return;
>>> +
>>> +	if (!req->sg_cnt) {
>>> +		nvmet_req_complete(req, 0);
>> isn't this an error ? (not entirely sure)
> 
> if transfer len matches the rw len and it is zero we cannot send any data
> so just complete the command.

That I understand. But I have not checked if len == 0 is allowed by the
standard. Did you check ? Looking at it now, zone append NLB field is 0 based,
so I do not see how the command can ever have len == 0. That seems to me like an
incorrect command that should be aborted.

> 
>>
>>> +		return;
>>> +	}
>>> +
>>> +	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>>> +		bio = &req->b.inline_bio;
>>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
>>>
> 
> [1] Zone Mgmt send emulation with all bit comment :-
> 
> I ran the test where all the zones are set to the EMPTY right after creating
> a controller on the host (initiator), see [A]. With the passthru command
> with
> all bit set, I was able to change the state of all the zones, see [B].
> 
> So I did not understand your comment about how all bit is failing to
> change the
> state of all zones with passthru commnd ?

The behavior of the management commands is different based on the ALL bit being
set or not. E.g., doing a close zone oeartion on all zones of the device with
the ALL bit not set is not equivalent to doing a single close zone operation
with the ALL bit set:
1) With the ALL bit not set:
  a) imp and exp open zones will be transitioned to close
  b) the command will fail for empty, full, read-only and offline zones
2) With the all bit set:
  a) All imp and exp open zones will be transitioned to close
  b) All oher zones will be ignored

1.b and 2.b is the difference. That is why you need filtering and cannot simply
call blkdev_zone_mgmt() over the entire capacity. Doing so will result in (1)
instead of (2). Similar differences exist for open and finish zones. I.e. Finish
all will ignore empty zones whereas a finish for a single zone will act on an
empty zone. Please check the specs to see these differences. They are clearly
stated in section 4.3.

> 
> 
> A. All zones are empty.
> 
> # nvme zns report-zones /dev/nvme1n1
> nr_zones: 32
> SLBA: 0x0     WP: 0x0     Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x4000  WP: 0x4000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x8000  WP: 0x8000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0xc000  WP: 0xc000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x10000 WP: 0x10000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x14000 WP: 0x14000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x18000 WP: 0x18000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x1c000 WP: 0x1c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x20000 WP: 0x20000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x24000 WP: 0x24000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x28000 WP: 0x28000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x2c000 WP: 0x2c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x30000 WP: 0x30000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x34000 WP: 0x34000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x38000 WP: 0x38000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x3c000 WP: 0x3c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x40000 WP: 0x40000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x44000 WP: 0x44000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x48000 WP: 0x48000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x4c000 WP: 0x4c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x50000 WP: 0x50000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x54000 WP: 0x54000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x58000 WP: 0x58000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x5c000 WP: 0x5c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x60000 WP: 0x60000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x64000 WP: 0x64000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x68000 WP: 0x68000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x6c000 WP: 0x6c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x70000 WP: 0x70000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x74000 WP: 0x74000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x78000 WP: 0x78000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x7c000 WP: 0x7c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> 
> B. Now we send the passthru command with all bit set  for
>     zsa values RESET 0x04, OPEN 0x03, CLOSE 0x01, FINISH 0x02
>     in the same oder as above. All the zones state are changed.
> 
> # for zsa in 4 3 1 2 ; do
>> nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x${zsa}
>> nvme zns report-zones /dev/nvme1n1
>> done
> 
> + nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x4
> zone-mgmt-send: Success, action:4 zone:0 all:1 nsid:1
> + nvme zns report-zones /dev/nvme1n1
> nr_zones: 32
> SLBA: 0x0     WP: 0x0     Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x4000  WP: 0x4000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x8000  WP: 0x8000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0xc000  WP: 0xc000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x10000 WP: 0x10000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x14000 WP: 0x14000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x18000 WP: 0x18000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x1c000 WP: 0x1c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x20000 WP: 0x20000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x24000 WP: 0x24000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x28000 WP: 0x28000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x2c000 WP: 0x2c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x30000 WP: 0x30000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x34000 WP: 0x34000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x38000 WP: 0x38000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x3c000 WP: 0x3c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x40000 WP: 0x40000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x44000 WP: 0x44000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x48000 WP: 0x48000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x4c000 WP: 0x4c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x50000 WP: 0x50000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x54000 WP: 0x54000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x58000 WP: 0x58000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x5c000 WP: 0x5c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x60000 WP: 0x60000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x64000 WP: 0x64000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x68000 WP: 0x68000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x6c000 WP: 0x6c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x70000 WP: 0x70000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x74000 WP: 0x74000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x78000 WP: 0x78000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x7c000 WP: 0x7c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> + for i in 4 3 1 2
> + nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x3
> zone-mgmt-send: Success, action:3 zone:0 all:1 nsid:1
> + nvme zns report-zones /dev/nvme1n1
> nr_zones: 32
> SLBA: 0x0     WP: 0x0     Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x4000  WP: 0x4000  Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x8000  WP: 0x8000  Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0xc000  WP: 0xc000  Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x10000 WP: 0x10000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x14000 WP: 0x14000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x18000 WP: 0x18000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x1c000 WP: 0x1c000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x20000 WP: 0x20000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x24000 WP: 0x24000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x28000 WP: 0x28000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x2c000 WP: 0x2c000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x30000 WP: 0x30000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x34000 WP: 0x34000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x38000 WP: 0x38000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x3c000 WP: 0x3c000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x40000 WP: 0x40000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x44000 WP: 0x44000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x48000 WP: 0x48000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x4c000 WP: 0x4c000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x50000 WP: 0x50000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x54000 WP: 0x54000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x58000 WP: 0x58000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x5c000 WP: 0x5c000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x60000 WP: 0x60000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x64000 WP: 0x64000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x68000 WP: 0x68000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x6c000 WP: 0x6c000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x70000 WP: 0x70000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x74000 WP: 0x74000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x78000 WP: 0x78000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> SLBA: 0x7c000 WP: 0x7c000 Cap: 0x4000 State: EXP_OPENED Type:
> SEQWRITE_REQ Attrs: 0x0
> + for i in 4 3 1 2
> + nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x1
> zone-mgmt-send: Success, action:1 zone:0 all:1 nsid:1
> + nvme zns report-zones /dev/nvme1n1
> nr_zones: 32
> SLBA: 0x0     WP: 0x0     Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x4000  WP: 0x4000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x8000  WP: 0x8000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0xc000  WP: 0xc000  Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x10000 WP: 0x10000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x14000 WP: 0x14000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x18000 WP: 0x18000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x1c000 WP: 0x1c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x20000 WP: 0x20000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x24000 WP: 0x24000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x28000 WP: 0x28000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x2c000 WP: 0x2c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x30000 WP: 0x30000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x34000 WP: 0x34000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x38000 WP: 0x38000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x3c000 WP: 0x3c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x40000 WP: 0x40000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x44000 WP: 0x44000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x48000 WP: 0x48000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x4c000 WP: 0x4c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x50000 WP: 0x50000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x54000 WP: 0x54000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x58000 WP: 0x58000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x5c000 WP: 0x5c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x60000 WP: 0x60000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x64000 WP: 0x64000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x68000 WP: 0x68000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x6c000 WP: 0x6c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x70000 WP: 0x70000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x74000 WP: 0x74000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x78000 WP: 0x78000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x7c000 WP: 0x7c000 Cap: 0x4000 State: EMPTY Type: SEQWRITE_REQ
> Attrs: 0x0
> + for i in 4 3 1 2
> + nvme zns zone-mgmt-send /dev/nvme1n1 -a -zsa=0x2
> zone-mgmt-send: Success, action:2 zone:0 all:1 nsid:1
> + nvme zns report-zones /dev/nvme1n1
> nr_zones: 32
> SLBA: 0x0     WP: 0x4000  Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0               

This is incorrect. Finish all ignores empty zones.

> SLBA: 0x4000  WP: 0x8000  Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x8000  WP: 0xc000  Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0xc000  WP: 0x10000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x10000 WP: 0x14000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x14000 WP: 0x18000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x18000 WP: 0x1c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x1c000 WP: 0x20000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x20000 WP: 0x24000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x24000 WP: 0x28000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x28000 WP: 0x2c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x2c000 WP: 0x30000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x30000 WP: 0x34000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x34000 WP: 0x38000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x38000 WP: 0x3c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x3c000 WP: 0x40000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x40000 WP: 0x44000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x44000 WP: 0x48000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x48000 WP: 0x4c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x4c000 WP: 0x50000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x50000 WP: 0x54000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x54000 WP: 0x58000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x58000 WP: 0x5c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x5c000 WP: 0x60000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x60000 WP: 0x64000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x64000 WP: 0x68000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x68000 WP: 0x6c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x6c000 WP: 0x70000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x70000 WP: 0x74000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x74000 WP: 0x78000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x78000 WP: 0x7c000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> SLBA: 0x7c000 WP: 0x80000 Cap: 0x4000 State: FULL Type: SEQWRITE_REQ
> Attrs: 0x0
> + set +x
> 
> 
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
