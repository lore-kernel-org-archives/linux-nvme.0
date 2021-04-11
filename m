Return-Path: <SRS0=56zt=JI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67EEC433ED
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 21:41:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E6D60725
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 21:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6D60725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=jO/x0B1Aa/rDr4OOX4+V8ZS5GV1fa4AIJ+kqfqSyiBo=; b=MKCPMFZaE0m8rEkC5cErq/obx
	smn9M6H5uEOpOzz94iR+OgfJtqCoZM+WaUzf2T0+jbi88dy2PoQUUtM2v39SgqPJapRbJ8J6Dk1KP
	Ly66zjDpaMNppMgNJzOL2lgXDIgWZjwc0PrOd5x4VAlqty0w1pSMI6caRVtwX4e/iws4Kryc0iSXk
	nu3tyBRaFlarsyqeC/7vEJUpfH0omG0Yux8wXSO72ybKdlbfSi6Pon3I0vrfcgmxCAMdeMRoAHRde
	mU5kEpfsJ8jvB4/dDpJkwNtKoUptFy43uhCVh10FnmJ3EvcqR+FzOe5ZtPs6GvPQYV18y+icRKyfc
	gNzTkmJNg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVhpM-0059iw-7V; Sun, 11 Apr 2021 21:41:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVhpI-0059ig-Oe
 for linux-nvme@desiato.infradead.org; Sun, 11 Apr 2021 21:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=Omma5F9wGp1IAqG/39naTybx9+/b9i5nvURaZJFtsNM=; b=kzqU85lPrFZMUSsTZIzOzuHASB
 DOOBoLvXqPoq9TAwJC9YNEm4EUL/ITF/+zVCB9iDZJ6U8zhcCqVUlqFcra4HIrwU4agvU9kjckoJR
 JMEbOVRmxykCMMahEw7zC2Ue4PdaTZYJnY4SaPr2+GgucJj+9jv0Iqiv/yqqV4wNsCHt8E7BwOfxU
 jSA4h9tZLXAMh22p8rU1RqQGNraTFOiA6zPtCYRMiAm5mARU+lSOo/dfCGH9hgheMp01D+wSgDf0c
 deClW/PI9MBsvTINxw9Q8j0jU4Wp8q5p+LytBZPMDatTAlZZgpDh5PoUd2otovH2py7dD9ZlA6U1V
 l7SXEMCA==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVhpG-005ksv-0f
 for linux-nvme@lists.infradead.org; Sun, 11 Apr 2021 21:41:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618177262; x=1649713262;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Omma5F9wGp1IAqG/39naTybx9+/b9i5nvURaZJFtsNM=;
 b=JgoJUr68cItWKDhnb3LfLSrME9nJjUh4gODe6jHDuX+DlPqfKchyf67W
 xQb0txZIXzLjNaHnlcyJtyVy2U/tdPAJyZwG6z3HRSqb7N794fSUS7uNB
 mm9FYvy7pONHsUwa6rP7Oy0gYJRX8hPN6JqfUelvk060DeQEtL1rxTwBc
 JKtbcyrKP3NOU5YGaVpzBzKrLkRuyUMhclVrmSMqZxc145Rph/ZoQLJur
 hGq0xrn2xHpBkN2WbILduRqas/iCNKRBBuIBoDj8iZaRUup20s2gkGCXk
 VeiiBHmp4tu8kBIw77QHTfI+mb/V3ai0rNTQ9Xw8hRGPHw/FHs0Yb+CeR Q==;
IronPort-SDR: 5YyMbdP1fVh7X0G8kll8TB9+kHhxXjFL/5K34Sm3hYyspKHqJx9X0AjmPIBii5SD0XkNAjsCfb
 /D7xqParJda7olCBo7Q65yB9sy4DEPgiZh9bKY+znh9bwf9AblwDcZbrTgxDCwFY/NKZLRxeYX
 VxLapmJYmXJF5BW6lovzPdp29pFxyGCPeLHielkn4BK7l30RmhezBh8W5kUmyKsYTc981dxyN2
 /KQRtQBkYLIg40XlEN/xMnsL4BIOxGP0FKsPn+aZZNjzF0YGyrrMaYWlVpWB86dZ3Yd0aOMSRD
 qMk=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; d="scan'208";a="165267910"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
 by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 05:40:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJMFhrtK4SRAbru6orGxxn5kt3ndtU6xknxK4SiJqLuVP9D6W2TSOu3iV4Htczp9AlwcGbN9v7PnnoSqlGjXPQOeRlyHnRdlWft7SewIhaAASookCrHMxXDPncLePx2wSxHiBxmHOEkx3DcVSiGxPfDKOlm/qE1OY3AkG5N1aPUvv2IQhE1mLSZtRXVxmn3EHHhr/kmrHmh8QTR6gp478Ha2NqY7sT/Ox3TFTkZPMoHNtFAOYxlQ4SO1c0TeOjaJoYo+2wzMlQ+IhuBeSlui2TIfIt8QYpcomDDQRLgsL02AGYlhLixQhCf+5nh8xoB2bY4zM3jj108EQGCsS6iVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omma5F9wGp1IAqG/39naTybx9+/b9i5nvURaZJFtsNM=;
 b=CP/pR+Y2WtUq69zBwc8RpmCLzKJNv22MWEkWVqF0AZIe1wkOrit3rCuvdwlaiVc/Yc41+Nfu0WaUovdDpw/y2A1WFaAR1YSMryXziy4wR/qSAiGRwvMUc9BDqrmVe+z6fqaTu7NICyDNEZI4zQlxbWGwgYJVj25nCyR/WPM28R4JkC7mJ0nvRhD6NEopLJWQ1aomFk7+JCxEsK4W26QxzN472J1G1x7gMOEky07T8Ed7y41RJyT7h+70rsCNhG5ZUPFJ8gEVYyzwua5Xl5nB+ZsIplVhDgjjbccLOj5FWuS5xlX4MCvA2HWoKXZS6G6V2vfB+Lx2swP15ldK7/uzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omma5F9wGp1IAqG/39naTybx9+/b9i5nvURaZJFtsNM=;
 b=MtXOF0451yY3ZrHoTVlfkdKpADu+ADFZysBq84yfNULCVnRRzh18sG08MkuKhHMkhny3PQn+6CI+t3f/3WOxcOb5k0UbyN0E1xbbaaraAwS+8RIAZ6c02V4Ny+XzkOHn9Xlf6IjNL6rsQ+0oGC9+ic/lyPbCUfwGbtZeVDxwz9g=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Sun, 11 Apr
 2021 21:40:55 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Sun, 11 Apr 2021
 21:40:55 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Prike Liang <Prike.Liang@amd.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
CC: "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
 "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v3] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Topic: [PATCH v3] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Index: AQHXLoqU+7qpNHBfHUOXalsOdlhQQQ==
Date: Sun, 11 Apr 2021 21:40:54 +0000
Message-ID: <BYAPR04MB4965AB3813E1BC35EBB6C50686719@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1618115015-8545-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fddd51b4-788a-4de8-6f37-08d8fd327c75
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB4424A6BD22BCA36F18AEA9BF86719@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Sny0WAm5WSw1GESZda3xP0FepS9Joryz2jkwE4ptaYKb3HrBYB+oy2ZTz8yhsW3Lw3Px4DnyxLmGUKo6DBRuAcLeYNU+PX2zeFde6F0cFLefugYI+wSKH7rwECMPK6UhPdgDG17qnvEvIxEibG8WprzmlDnQmLP1D3p95JHZ+qUZUK61TXKoqfjFD962mfv9VJsEt1ktLhZ+fMuyZUiS+DdzZSn7PxRRkQR57mrsTiZ9g4O4w9cKPXlEWvUWqxOCl/AkgRf4Ljhgfdhf0f6d1KFBm43kZ3vNpJsMMWXIU1xFTC5rFeWbY2t/A/FtyvniXkEVjntwihibutKDufuQ9hQo+X7Yz/VS3rH43YVdUIgZLaQkAnd6zxLiy+XwxK27EhRBgBX6iKKshPlg2Yco5gRfwLiBrB6Ni+Vt3vbxAKIsd+umn3P+rc22tSlI0bsy5n8T2JnMJtXg3bRwzAHDDD2fOWZZqVyQD5HM/yWSbzk3G4xe6cWVCpDRah20cyAjSbN4vlKEpEH5lg45wav00493L6EAgWmB6KyZ9vHiGk0fGyc/I/9OFmnej4hHftoN7OejQbtpmEj98GSidW72Bpp1+oO2CylOrlC+VkR9s0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(55016002)(110136005)(53546011)(6506007)(83380400001)(5660300002)(2906002)(86362001)(33656002)(64756008)(66946007)(9686003)(66476007)(66446008)(54906003)(66556008)(76116006)(8676002)(91956017)(26005)(4744005)(38100700002)(316002)(52536014)(186003)(15650500001)(4326008)(71200400001)(8936002)(7696005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uMQF9MUST0wxNnDh8OsDjpWp5VRLNOXolhutm7nE8JzqWC58miJdlmsnLEAM?=
 =?us-ascii?Q?iFtwAcDk9p6LHr9sEF8pDHaQmGiZGg6wV4pgUWn1xLyjsvW0VovuXFN5SlIl?=
 =?us-ascii?Q?QMWGSwQ6s9eUBb3eVeIdLXLK79afNRnWlggIIPBDfxKCvQQzPZdmKczXL7gy?=
 =?us-ascii?Q?YydYXUoXvkOcltRuI2MQGpokyn8mkk8lCV+mR7CGDttLCFQfMo4FShLTMNtn?=
 =?us-ascii?Q?0mBVSdtLWfEIg5d/RsPC2SUT7u/Qjr7QkrZDbbXZlzdshAus0/oH1AZr35oR?=
 =?us-ascii?Q?KrUSp0DDKeF+ksNyevpBBSYuRfh3pgjt6ddXaGfUAeoNKDpS0wy/t6f2ulBL?=
 =?us-ascii?Q?iv+1qqmYLJLGH2SPU7gFp1VNM7Muuy8g/GTeGer44dEKFBSzGMTOTXLfi73L?=
 =?us-ascii?Q?Zt1TZkv+kRnL2pIz3ZI4ragYasTErhDeTL0D7t1fFH+uF0gqYPL3icfSj6cf?=
 =?us-ascii?Q?z974A7+7vmBm2K6p7sv6RjrBNhGA7Tob3wfDFNSoV7SdQjGsXHlfPtJJAOqF?=
 =?us-ascii?Q?wTsLgFuW1ve4ptG1DXFYbFN4Z6Mbrj1AO6HPWKRP1wAbxdbL+vivUTJymVmJ?=
 =?us-ascii?Q?7twHkoPl3nVXLUdhY+uHmEChlZ814B6HI6+v7vU2wMZs0vOWKSF5YpT1fC1b?=
 =?us-ascii?Q?fqlU/dZcGFr7hk66kAL/zWrHbw/+ScDnJbNW3qou5ZqkRBuUZtVmlg9RNXTQ?=
 =?us-ascii?Q?T6R/u6dCsY4N/Hcu+BWFJkcf5ZzAGFNyo9wk+1pRl5War2B5D4AfmzMAGkfj?=
 =?us-ascii?Q?uxMvsSGAbAswj6jpvJMYdl/ahnSk7HX9L3p7Ikx0Qn+DdEOj5Yyr0vIQRCHl?=
 =?us-ascii?Q?x3ofDLTBICcJqUHr2a4yshlIBLArcz9jhA0Dm1IIeKkUE1HHwmk6C17eWgWA?=
 =?us-ascii?Q?u3yDcW+8i0c9gUIRcF4NNiUHvG9fdY1eq9iYCKraOnYEN9p3e5qf320cWHkK?=
 =?us-ascii?Q?O1G6SjohHYor7oW3zu5kRz247oelnYY3lScoSMxX5u5Ewbr1BYXXoOFCpvAu?=
 =?us-ascii?Q?0n/+c4AEpoyQbVPw6OMuAAaOVxWATIW6+pyUSPbZRlbc+EFATXRPh+4mPKbI?=
 =?us-ascii?Q?uJ1RqTAs9ZmRk/k7jveCukh2Emh+3Ln0wSLWRaf68Pi8c1vvKBTaIYsYAhdK?=
 =?us-ascii?Q?EDcQ26HDTXvYKu0c/ov8B6pnTJTgBM6hV9401VEAPcsUfBW1KXxy79Kny771?=
 =?us-ascii?Q?nW0yVCLPth/MuqQLk44Hi1TmkzR9RaEIXhiCXp5Gb001/3wQ1UkdnB30EgXU?=
 =?us-ascii?Q?oDFlGU9mc7jO6FuvIeDnkgv52f+OTDRovbk2CfsFF1ufJXhkhTWsHSO1hDBH?=
 =?us-ascii?Q?FUZbgpyPksOmWtVaE2b7xGq+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddd51b4-788a-4de8-6f37-08d8fd327c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 21:40:54.9939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utqnWcGf+bketis5LX6xEnbeyeia5HjNeJ8MBIgQNT3K4xr08hgi7z3/6dTqF7F75qlFC3JTTvXQuJcd+KSf/7TOn4DTo9QSyuhEi8pwqdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210411_144102_168637_44507B42 
X-CRM114-Status: GOOD (  11.56  )
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

On 4/10/21 21:24, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need PCIe
> power setting to resume from RTD3 for s2idle.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
