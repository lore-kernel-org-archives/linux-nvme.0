Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8CCC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 22:32:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667C22067B
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 22:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QLZzToSo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f8i/6NjG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GqI5NPc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667C22067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=zVltQjEkNHgEiuPi5N2C244JkDuOmUJ3SAVKfW3+5sQ=; b=QLZzToSoE+LifO
	fiaUtzjSLsKlGabJPce7uks9dwweoAOqFKAV8Yvau/ziZtaROkuTTENA7i74IUwS/g2l35CNu6yfs
	+Qd7ZcgJhKm597vpwWK8SA218QbgvTuDjg5b+rQYyzhmg/twkgj/IySj6VQsFRGoKxK6UMga8Q68c
	4DRjGD3TCYIPv2v3y8GOyNf6tY5y+meOhmZoObeB+wRGi7WaaUy0XzyfpKBBwQfwcCQQxtaaxXHl0
	lGyKsSF0o5EL/u8352mF52xW4GHbvKjReg9+HoojzGYVJxmwquBPHrQOThdW6ZO9hcJtqFiAbSfg0
	vP/I6idWxN99ZUTQPgWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgbvT-00033R-Fq; Wed, 03 Jun 2020 22:31:59 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgbvQ-00032r-RJ
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 22:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591223516; x=1622759516;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Pmivf6+jtAAvWvXVUf/PFxNAsIr3wfxZE+r4Yyggkmw=;
 b=f8i/6NjGJEhcYUWExbJzXFY5b/pZca4hXnhXv4Ofji7v5qwqHzDDjc8f
 fOYTK4bXJXBtlRrrTheoqYXVUvS2z7ltgKhlZya7WywLmdALhz58q7biv
 +O2NWUc5ZaFvR8iUMjQAMupaGsOgMCDMfKEBUoON3A9oDSbzOmBErx5gi
 bOgHvhik0Y430sJ/jD4d7ebH0z7UeTKOUlGBESbhiOKKbYCau0HMrhuT9
 swk8Jckq+y/wELT0K5alZR/gyZCqBtiw2Ietp1KqTDMXGbylz8QbEOlQQ
 e3m4tBzeTUfdHJzHiBhsbOk5Z+kr45SnMADGRGN4rSI1prWpYGCKcDKCw A==;
IronPort-SDR: d5e4l4GqV4PVRWqKlSEPYcfsiyIJYQBYuTGnCFoBS8recEkgpyV9unZq1NfYZDNX/FMiltsPiw
 Xa2gKU/xSPO+wio0QQfJpIse/toOXCVLi9lXNtcZ+2u3O3whdWt1uGprfgHucmBp12nrBBJKMq
 w2DyxOHJd3D6RIOfq5ILlK9FDKc6+2kTgiT2ZAkSmKfhuOFNtijdLLfgxNg+8+2O+eKq0qFgOg
 53Pkqmt4n0m1SolJ2s0Yaq7KQiK+CiyyPGgAYKjIMM4Wo0HCSMjHi1AD6AD9ivTAdsFPQ891sg
 oBY=
X-IronPort-AV: E=Sophos;i="5.73,470,1583164800"; d="scan'208";a="139143065"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 06:31:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJzAM1ePWQuuoLrXvIPBtu7pF7eN5b4xw/Aypp9JFtz7scm1Hs4PlbLXTtVla71/zS2qJipWToN3zoGwNeYiSHk9ViNsYnsHWrG1OxIMFUg3GU+l9hC9Y9TPd+s97TCVt28e/fBMAx20Ln5oseS9ftoiUNIyB/Sn5wBcD/U+87cOtnQGhs4E2CLqM4GFzvJ5IHPyo9KMbiLRoq4DmLYds5593qtHAsiQQMAEXpwLsDOAr/Khvyyhvo5yszKSkMgy9YAStlLXkqbwJyPtJ8OPLpLCE+H0S5dHl+DY6RIrmt3Te1+mUdPK8uoNpkbkMiUQODNejo78AiGvcSLPNoQq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JXM1Ols2ra4PXWnh4yGGAsCfn7gj4f6TwLuE1zPR9c=;
 b=dD8/+ZeeD8wW5c9mz5jXredlp+uI8bT8jMrIXNTWMtpVVsqXFaPb6MQgIYWLPsj4VxI+F7lFTUlRNlOoKg8pckPrT/TDBWG7cAdYVp7UcQqbsR3KYtt4JL1EfuITbcxgFFMGSEgDx9B/a0zl7THLUNFivBHzT3pcaD1IaDR2obyphMRsLGBPgQ8szmQL4pkZtbtTQQXA/xMfjs/RV+u4glOzr78c6pdl1MVIdNHOE7eNz1mqsNJWDe7c1de/z6ZkZZgZ74uIVji4c9i3Euj7K8E73FtS9QiZKZSZNYzCR5vkz9zFNGP8+7iOSDiPC6TTpBDvMhRavIFeTWUzN7ca1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JXM1Ols2ra4PXWnh4yGGAsCfn7gj4f6TwLuE1zPR9c=;
 b=GqI5NPc6Q1GYIQbYXNtiMy4HwdZzuTWDiJ+ytF5h89Z72TzVG3rVPw2vhKoxzVFN68AEncfmQBomu2fBGlWzxKcdNA1pglOvt0YfyuKwLWRc5YZVLIydUkgMC60nQEirnfLqfD5qlkDTOWuw3oWL2EZzv3dDLDoUbg/PttYBiSQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4792.namprd04.prod.outlook.com (2603:10b6:a03:12::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 22:31:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 22:31:51 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: blktests test nvme/003 fails
Thread-Topic: blktests test nvme/003 fails
Thread-Index: AQHWNIJZVRL6ENIo6Uy1ge01JbudSw==
Date: Wed, 3 Jun 2020 22:31:50 +0000
Message-ID: <BYAPR04MB49651CF1169CD33108A484B386880@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <a2b9e92a-f499-b54c-a275-c08a23467866@acm.org>
 <BYAPR04MB49651040C77627E3A70FF86886880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <fddde27a-eb61-7031-a067-5538e0fe3243@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ae77859-abdb-49de-497d-08d8080de934
x-ms-traffictypediagnostic: BYAPR04MB4792:
x-microsoft-antispam-prvs: <BYAPR04MB4792612001FDCE1D7E14035786880@BYAPR04MB4792.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kq0KHJgsCHl/ANGZWJAC0E5IGWpl9rPih4RFACr2UX4dge5lJdhYIosQV+xSbk6nmZ/PjNx5hLOkhJcddn7FgOEbfXgdVkfHXW9MuVOiQ2Ooz+0Kox0MPzhPzd8UFtenIqhwgIR6tEOS3RyPUE9Sp+TTYg/DatAcOG+P/yMVzbQRtgr9O4jBkk8C8Wxdak/NTFCWXcd1p0xOSvSECm0opukdQlFnPHfNsW5E17aDkkqgYHroACzh8hUa5P00mSUHf1deidlHawEgjohzm7uLEwsctFdD+TQr/jsfJDXPoo+pDdJyxltYAbGaLGD0bM+an9Iv6VgsM4vRXPKv9NG/Pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(66446008)(64756008)(110136005)(66946007)(66476007)(66556008)(76116006)(4326008)(71200400001)(52536014)(186003)(55016002)(2906002)(7696005)(316002)(33656002)(83380400001)(53546011)(26005)(5660300002)(8936002)(478600001)(86362001)(9686003)(6506007)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: HVjN/ShA4j+17//5L7gzDAyi3IJnpOdh519Hx9CFWhd3oqXtY/MxlwJE6XUUTwmGeCIPQUoKv3SEp1jUlgV0U49m+or0K3OYD9d/spkGoo5rzNeG3QiZ11gpfVBT+1Tx5+1z2oDPn5mNJ2Dl0UuiyHem0UAuFNfOy4M7bSZOuV1A1fnOsvdfjNmNk7aSTNy4p+QBcGdUzFqGBc+mko94+lmlzTXu8WOMDYZJl7qihK+/+yIq0N6Pnn3M3WDzCOq8HjhbGEPbtTylP9zJnT/3nmq5JRZZXElMOxU/9KGxsq1LwzNiw01soYe1bAyrdxDdlekpeDgQ/CIfi7d6ds+LEvabW8Lr3Wk4Umb01lB5Qh40a2I6qDOdzeLyysj1DTpTM8QE6GaMALvzKu45P8FK/B6Zy4CBc/xUcGX60HhFCaL2h3C4j3KzvEOCGcEEPqucmaEwUgtDXtKCXbDoD8D+eWlkMWb5ZURmsVbalspTWo4=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae77859-abdb-49de-497d-08d8080de934
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 22:31:51.1301 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zVqLamQVC9BpDMA03A2NIFjpJQrtWhOTx+2hkBAX8WaXZljzkPeq1OuqjxnEXJyfJmsmB/xzXiI+ST6FUcLfxkAjGk4A3Yp2MkWrYTyVGH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_153156_945622_640D4573 
X-CRM114-Status: GOOD (  12.01  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/3/20 2:01 PM, Sagi Grimberg wrote:
>> Which breaks the further disconnect sequence. This problem seems to be
>> introduced after commit 64f5e9cdd711b ("nvmet: fix memory leak when removing
>> namespaces and controllers concurrently").
>>
>> This patch processes the ctrl->async_event_cmd[] until there are no cmds
>> available in array irrespective of aen list if empty or not and uses aen
>> list entry if available.
>>
>> Signed-off-by: Chaitanya Kulkarni<chaitanya.kulkarni@wdc.com>
>> ---
>>     drivers/nvme/target/core.c | 16 ++++++++++------
>>     1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 6392bcd30bd7..40d80b785ecf 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -135,15 +135,19 @@ static void nvmet_async_events_process(struct
>> nvmet_ctrl *ctrl, u16 status)
>>     	struct nvmet_req *req;
>>
>>     	mutex_lock(&ctrl->lock);
>> -	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
>> -		aen = list_first_entry(&ctrl->async_events,
>> -				       struct nvmet_async_event, entry);
>> +	while (ctrl->nr_async_event_cmds) {
>>     		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
>> -		if (status == 0)
>> +		aen = NULL;
>> +		if (!list_empty(&ctrl->async_events))
>> +			aen = list_first_entry(&ctrl->async_events,
>> +				       struct nvmet_async_event, entry);
> Just use list_first_entry_or_null
> 
>> +		if (status == 0 && aen)
>>     			nvmet_set_result(req, nvmet_async_event_result(aen));
>>
>> -		list_del(&aen->entry);
>> -		kfree(aen);
>> +		if (aen) {
>> +			list_del(&aen->entry);
>> +			kfree(aen);
>> +		}
> You already condition aen when setting the result, just free it after
> you use it.
> 

Sounds good. I'll send V2.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
