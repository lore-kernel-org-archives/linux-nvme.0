Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830C0C4727D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 00:00:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF381206CD
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 00:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jqKUB4kV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OqNbVfU6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Xb6HdDJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF381206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=xKdJ+Zo3TJ+pSribhsDNehMf/klJnsUF8+n2peCY3YA=; b=jqKUB4kVCLALzp8PXk9DCvznl
	EqfE4vzo0NqExq5D2PFRmZwv2Z7aYuNdTCqMuY3M9ZuvuN21XT4CyRhuTJcjlVr6sDRTougROP+R/
	t2BHPzQNxdtO0l7rgwbFezVwqwXKNe5Egr2lZTg9mr9VSuBuzhPpTVjTyyA74+kR3JgYd+5PV4vIJ
	f71lSdmtlBP+PHLxORHyEH53cmo42qM7ACPJoLTJLzfNrBN1xQx+I38d6uuyhprKo/VY4o8xMwmG9
	i3SkekeZvyX5v0fU0V0t3r4vn1DDkj6V/yYiTfL42jeAuLPQsMcgRFGhJzNeitSLGC/gPs5WUxtDO
	Oi0RzK1Yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNPXE-0001fC-9t; Tue, 29 Sep 2020 23:59:52 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNPXB-0001er-PP
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 23:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601423990; x=1632959990;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8V2yy4pMMFE3CIRVkBSEliaAWm7z+egEhNDa+aYuXO0=;
 b=OqNbVfU6sBi2idQhH75v4tAIvdn1ZQyGM+Dz8kAyZeXxQaGk/yldAmN9
 EAgAbCXCSGQeKaNVtpyWXvt6Qe8vyZH5H149iltsPWAGDtA283ZGryoQB
 K6BWBLphYWxTks3S7aYnEhIskRyoVrT2My/Dm9ZDdi/bolGNaz9nqD1yL
 MAlHydY6Lo4xrnhArseqBLZkHnhY1tTaPPHJNubU5ZDEWBTvvTsC1VO/C
 CTtSXQVd7jK+PutAV8T6w0k0GVo++UfAKE6Jq2R56GPyivcGD9T3bsaNI
 Yq1vovMBikwT7fYxpjeMAqdcfsMVzaggaW4EQ/pAPbgEdoKJAawp3NX9t w==;
IronPort-SDR: sQsvMg5aH1/c0/x1Ae+fP+3IVJUpwm18JDaKkK7OhrWdT2p9lK8Kr+GyuEIvUYi/uXT1XvNRNK
 e+HrFvku2fNRo5ZVrRBCw1Xx6vH07AsD85tcuRxZcAQHZVS51CVJfcff5myn9AUManrm4s5TQ0
 lpk3BcKchiBWiP3mweHK55wMQkQDEx68O+fHnd4U34S/abHn98C8krQmTMNMh25/RDAjtRqECm
 eFnut/aQt4n64yR3W5LHJfibVVfAJ4N/binkHStB07CS403PsEMRjE+akPmZPQ579V1smMbSNb
 ZCU=
X-IronPort-AV: E=Sophos;i="5.77,320,1596470400"; d="scan'208";a="152977202"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 07:59:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfSzwF2LTEXHpPdFzmUbtON6BLpxzXUEobdwsOIcgfZZ7H+72AMwh9yjYvOn4hVIQwB1QcE4Dv62tKOUOxt24eamOcCwwFjgZbBZ7VFa43syOFKAFx3yzDDnI8RqKOBwDvXG0aXEj0eXJ8LjEZb2ZyagT1V4M5IBrvpg/8t1kdUe/cEUxzTYGovCSAGhi2fGllfhYeq0SXIDP6fxY/bQAgW7vqyN/iT53SVlQmsP8jaFUeyyyHrtD9H+T7FkgmpPGJwH9OrSxMGelyhzoOY/vL/dYKK4rIwWVMrKsPFuXcqyBtwRwxlQjFMWcWqnnhc2RbiJkEqqr0GqTNGGk1BOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V2yy4pMMFE3CIRVkBSEliaAWm7z+egEhNDa+aYuXO0=;
 b=gjEcuEgQOoSf/6lGm70EDcSUUSBdG6ZQk18HPQWjq0cWI2cHxoPZrJMPML7S5lfvmXMTpBrBE46N7pAVeKYPfDkRBM5/ueEAifJERCjWLkQiOwC9O1NnMJcnXKtI8EVq6MxQPEAMhsQtP3N4IUXwxozUoN/fgfNbUyKSMQfIHThCaH4416Jwx0if2ncPvk6WjmoAT4QvZuofCnuogL8y7IqLinkLqPS7cHF609JjicodofWd2mPlrJeeezE9H77grE7pGU4phx3DbAagPeCuLsBpzILPnppuZ69DpiWCRHT8EhHmz3h+NaixhpDxG+so40b88HRwYrAsKa2+FBROSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V2yy4pMMFE3CIRVkBSEliaAWm7z+egEhNDa+aYuXO0=;
 b=Xb6HdDJwKhmjMLEc1TLRrVsa1BAlHwFrld64WPYMbqUockTYo6ulWcgzeKb2qCtvU7c9D8OeGn2BcYalNIDXBnx0pVKov5zPz9krA6pvc61JJMUsE8drlmtzl52dFhDG6uL8d98WL8nLtZEN/AOE6Wn9aVWLuHrzxQgL/qWI08s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5029.namprd04.prod.outlook.com (2603:10b6:a03:48::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 23:59:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 23:59:44 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 20/20] nvme: remove nvme_identify_ns_list
Thread-Topic: [PATCH 20/20] nvme: remove nvme_identify_ns_list
Thread-Index: AQHWlZVceH3REKuGdEyZqZnH2Oa9ug==
Date: Tue, 29 Sep 2020 23:59:43 +0000
Message-ID: <BYAPR04MB4965ED52F465D5AEE46E2A5D86320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-21-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 086315c7-c9a9-489a-177c-08d864d3bcbe
x-ms-traffictypediagnostic: BYAPR04MB5029:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5029D7F356E946E720F527DE86320@BYAPR04MB5029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q3pW4tj9n6rfBHXtWEUTMjthN/cp/shoQ9Y9kGW7PDk/WqiWOKaUPXZkSnP40xdoCaCfHSSvz157UiYOD1pZqWO3TX0CbVSJAprQuj+x+xutKN8jVeisWTj7bsHginj298izk4+pCIR11wgVoFKkyb5VVIEZhgHBTQsrol51LpYQ6HVm89oONEMZcOQcDFK1HcUxIKgLqvZGA++B4caB27aKZiQbCGKaHlY94ANCbmsLvVQdptFrMf/KYN7Hw5/Q8+sXoWfrDdZ46Eapi6vX6OHXIK0NdmAJBo4hb7Y8+oJzM2tb7Gv7sVZCdlefVm8nEEWlBLTzT90WK1xRM0jNfIkA2jdc3qW/6Xf7Lq+C+68Q+0uOW2GJb8EjQZXqsLnQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(396003)(376002)(346002)(136003)(86362001)(26005)(4326008)(33656002)(110136005)(53546011)(54906003)(316002)(6506007)(7696005)(66476007)(66556008)(5660300002)(52536014)(66446008)(64756008)(558084003)(71200400001)(55016002)(66946007)(186003)(76116006)(8676002)(2906002)(478600001)(8936002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nhXtI9qz5bIIM5SMvf4BBUiMMY/GDr3VXa5BeP4C+FRzTC85dvvNWUndz7y+A86BCBENO3t7g+qFtVv8y9WfDVsg6T7uBGiR5G3xzbV1x+YV8GPAnTRt7Okep85TSY2RhyBzmZyHAhIjT0rIfLNa5DMYgyvNw3yHGCIy0TeIwivs8uelbpZPUbEzcYCJ+rHULEKenAwrBEOYTPOUkKOQbxuhwAQqvDkabYUnIFMrsGB9Yj0wTASSlJrPGStw03S+Ey2rHLtLHsvFd0hFY+ppR7jVIIEVJBek/xg5o477UvNWgisrhSEMAStBSEm2fSnHb+TCWRqON19ucbOXrTpoiaiwKYslNg2DNlfTRzfVdew4MXTR7Q7HUFw2MOHpZgd/XIyz8dqeAl28NZKO01mYfaOw3+UT01OG4TZ+MN0KPmtoi5VMFRVja18h6qWnQ5fmDlHIH1uFarf1uZh+9nzmR7LLm5h+w/aV2I8G/gQGHzn8wC5jaLdOcbM8gZoE27EghqYHAAQ0n5cN0sORaLAza68+IdOsYvMi2/QB3P1oqDlLfv0ArI2WpNBtY5u5xXZxz9b4wx5FC0pFmNmj2ACsQDW0bn0fIhxH7dHmxWvAWuJS1VtJXX3cCiZGekQjWL0dbxJ4McMtJbPIhJM8kY/JqA==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086315c7-c9a9-489a-177c-08d864d3bcbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 23:59:43.7768 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgIelaoPQrwgjMgU/DU/neW02Qtsm7ngYyVkVPzhd532D/m7+KL+zYoEk4zWGyOJeSK1AdjVetkYjJ30R6p06HoI42GoWcs2yOAR1LUMGvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_195950_140415_A18EF9E4 
X-CRM114-Status: GOOD (  10.80  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:46, Christoph Hellwig wrote:
> Just fold it into the only caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
