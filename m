Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4895C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 20:28:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF94611B0
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 20:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF94611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=TTqUKCdxGSPWg3q8FgaQHo9SdGOMafrWEFkeleZcyQg=; b=RtuUhr2n+J5cYqEOdwXStGheD
	FnXSv3pyX2Wh5N6x+iIQnHxNeEZDMVLVaCIyyR5is7GMQKkHkHSVvWUZmFHvtfY8Q4D8I4ag/cQc2
	av5VTkB4LElHFsTRPADZ9DQomCvvAzdFV1hAmB+eeIxpMk4ZLaA+k0oAOEYooQNY3FYA3gwOidUgq
	pt7IRu1ml5Pv+kvR5KQYT4e7wOxhPgpy3gyiRhhukacicDOEka5QDvxJJHGR/CcW4ADMxQeKFu40Y
	Qs86Mb3+IIxm9Ox4jwUoIlQ8mIpKWY021bk7a89rsqyHgddy5o0uXh03LFREk/8WmTxmFyXSO6EfL
	eWx6XCtMw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj6Jq-001pBG-0Z; Tue, 18 May 2021 20:27:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj6Jk-001pAN-JW
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 20:27:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=nmFMsbVk9P61H3MHRAknfITSSv7ogOYIcOG/Rt7dsME=; b=DLa7/B8blt1kGCDj6cF+i106mf
 CUm1Q6PXhRjP/6Lu72rV8OMdwCYPx0FCfPHodrPTcunkjA28j3D2o/fPMbb8Oql6lm9TfNR+6NGyZ
 Jg2qIk140KUg13KF15hGmQpj1xs914p2eS66Rg1jCPcSjghy/lvj+DP0/iBcfgchLfhoNMA0x5Q2s
 p75RLXO1kbbdZhKpxLvlS7XwStrxXTa/C+yZC+9vFvOSNbV6bbGd8sR1g2uh90kOq8Zmpkr4EvPm6
 LubhB5T0wPMB6p9JINK7U7ognZUR8VP4frhWPRd0WF3GVnkfCAPZMSc31qlEw9l2NvstesghSUxOm
 iJl3I92g==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj6Jh-00EwmT-8i
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 20:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621369670; x=1652905670;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nmFMsbVk9P61H3MHRAknfITSSv7ogOYIcOG/Rt7dsME=;
 b=FG3Bff4jei0dTXZz+F/7/q6pi3tVV/xtoQISkLDbzzgPo7wDt2G0Aw80
 /z/wexNmNRZo85cHOfH3hrkS30myITfpchua1il3Se5SH+MI6V7xxe5az
 XAV4I5DIdtTJ/ENM9paE/QGfdu9sV1uNKhzdpB9crCrffongndXMQ4d7D
 iaQ0Zmuy+8+yid6MXOkgZxKa2VV699K+EXcVe64/i91zMIRn4BciJLfr6
 2xxZ8MXbjQcbNH9MV0eJuaw7V+Y/G9ZJa25ksd5N6pIt2obFuUQ4fDr24
 f+rXxSFKCgUnK4DhHfKur7z0eFc5N3Z3YLqu44uucc5vnLxu0NF3FsH+j g==;
IronPort-SDR: ETTd9l75Yq7Mbo0EZGPL9AxJ5wcEcuNG6B87Y+PGCAAlY+fhUh6CsKCZrdMKbnz6hABZnhD3ab
 u7dg5mMTnpQ/XOzBhiMs+S7wspSF0VGBCEfF824OR6bNY8qi7e2o3Cm5l16CQhIjciqlU+aDaD
 6rnZkMnwpst85jgPbCIhPQqdqtHx3qmKDo91d5/OkGx8pYHY1xy6AkysLObExk3Jbw0wrnO3Rz
 5G8Y966TK/tWrkooR4A4UtUZa6EmlX5A4b//SnQHy1AotNAgxWYH7BTKZRKNIXqUfhZk7eEJ5M
 CMo=
X-IronPort-AV: E=Sophos;i="5.82,310,1613404800"; d="scan'208";a="169153602"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 04:27:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+sTGbbgL70ikpf/7N6LIgREScX5F3hN9ikOmwqdrlKiV+virRWzp8E3NG9QGNLo+tbsn3goeOEuw+a0UIt4Lg1ILrWErtWu6QJe2VhGfmH2w5ZlaXCQYbPxArY3LGSxrG02ybPzr4a1jmW3FX0uD0RQdOUMaCotGF9RbZYr/93KCJTN25cG+i858rgQzoNxK9MgpBXEHMJ3d3+Fo6EU2NQJJzbW3SzBFd/+5PrtBSxc2wlQkA44aD+71cWlrJa+i+e3k1oRacZSFzLjV/szh3feMBwaugdXGo7i06g9jKuUf2UO4mp05iBqLSmg7xNYzLniwOcrhZcNL9Pl20AXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmFMsbVk9P61H3MHRAknfITSSv7ogOYIcOG/Rt7dsME=;
 b=B/K6xSeCOXyusU59ILdGHAfveMAAzd1QIcSsKdwrhgc5Xs7JflWnfgRHUSB1PmMdOKJqcuFxgQkJQ0p9hsv6p6+urv8iYqlzHO8PA9U+8TlND4uGXgy/GfIvYIkepjcoxNN/AKRGu86j9VzqTDbn137KLb/OIZqD/MRTF8wkl6pKsf6DJM9lICiM/FMYAmC0F8ASrrRWgZGOiE9stBaEUdC/7RkNALJgK9lDEWHUOYWYjJqJvsPyNdpDoe1P4iC8C+6mc7TKPRn5oy/gEyoPDk6r3F+sctmmT+SFR0imnFsMIE61hVGsSfd0ljh9CKYo+kzsBcRBPkGPObgLrdofzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmFMsbVk9P61H3MHRAknfITSSv7ogOYIcOG/Rt7dsME=;
 b=aAQiDcpAVZmCAN65+PTQ25U9Nydka/ylbSceAc5rK4lle5bU6x9FJYXudc9wS4H8w4BYTUNxO59+BqJBy1Tw0klaq388XRfxCPGauB4r761VNClt+g6q83OKb/pTbtLYNSuE2HUDRWjOxjrUFJ3cPBz3h1yWulBfeviqhWGa+2M=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5029.namprd04.prod.outlook.com (2603:10b6:a03:48::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 20:27:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 20:27:43 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Wu Bo <wubo40@huawei.com>, "kbusch@kernel.org" <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "amit.engel@dell.com" <amit.engel@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linfeilong@huawei.com"
 <linfeilong@huawei.com>
Subject: Re: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
Thread-Topic: [PATCH] nvmet: fix memory leak on nvmet_alloc_ctrl()
Thread-Index: AQHXS77BXPlsENBRfkCDAiaeiYCKqg==
Date: Tue, 18 May 2021 20:27:43 +0000
Message-ID: <BYAPR04MB4965E8D55C4349EC01EF61FB862C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1621327598-542045-1-git-send-email-wubo40@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27d7066c-26b9-4ed8-6c5e-08d91a3b6452
x-ms-traffictypediagnostic: BYAPR04MB5029:
x-microsoft-antispam-prvs: <BYAPR04MB50295E7506F213A28C534B29862C9@BYAPR04MB5029.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:212;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBb40Ok9bmhD6x0TgP7rsxCsSvGv+KgP9lATRc9oO6+6fdtXEFt+1FE1MRgsh8dsaV6FzceH8dCpW/mlWTEk7ame2fw9vJFC888W8tsvaleEpV6XwcPPhUIUMPfm8pTO4tUvHmEHmeqVS7qkDW+OF+oUyl9PLPTkFd4nR2aezp/1WRs8AJ7iqT9QdA/NyEqwON2cBbmMd0Biy4rQGreSgnpEoDKHLjZKi3MCgV21+bWK6XgjPJpV7AM19ODtUvLfuRAhY6ARPQBLhdtNQ/zDFXVnG1fy8O3hqgnzkE9EBBrE58pp8wpYuIKR2fSvpuKixy6tmrxQ2+2qtzHmENA+JAP7XfB7I1eBLJuusUm8YcCoGSCNKNMKkPVTk6BVFO6OmMp5EpbYACrNiEgOIgMvAV9Ey5TEpJ02zPPBYQ8jOlzF+pQktTb01g27eHreoK6c4RsLB55L+MdpckwZBr+XTQpC5T/nKGyLzhdvPmOT6itX9l9ZwAgKns4M9MTa/eoU79HeM7xQQbxFEv1mvCJQokXIS7YxRoCvwhpGklsyDc3cUFv5sf6f94qZphkkL4VNzs0QYNqKwPyppV5T824evtMuk0wmGgb0yIs/SX/uY88=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(52536014)(478600001)(5660300002)(122000001)(316002)(66476007)(2906002)(54906003)(4744005)(76116006)(66556008)(64756008)(66446008)(71200400001)(110136005)(66946007)(33656002)(86362001)(26005)(53546011)(6506007)(8936002)(7696005)(38100700002)(9686003)(186003)(4326008)(55016002)(83380400001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QuK8AcPyQP7ud6IY0LBp05i3ubyHnxj1oBlmKzM52nikWrBN659Hakr3xhY9?=
 =?us-ascii?Q?MUEAp3FioPMCfOtXjV0ekJjbMhAOCElaenlvC8LHAdlC/7yEui7mRCq3VdrR?=
 =?us-ascii?Q?P9PrEqnz7cQP8Oq9+nBEafCaZj7PJC0TeNnEfqZfqjTvJAYQnIdh1qywBQFW?=
 =?us-ascii?Q?x76X2Vf7uhhDk+TkyJTZ7LEWj4QFEY4MKfbBthZuNJdxcrEMK5G1NVIRWhsh?=
 =?us-ascii?Q?+oD70XoRuXomk6bkUh2uOd78czUIvGwrEkM0rNuxiPU9mBlOloBo5BQBays2?=
 =?us-ascii?Q?rF5QMpw95TIYEppKJBcePunN2eJGa+KrGv+lmCoAoB0JT2cNn98oSwOuNRar?=
 =?us-ascii?Q?CJTYeH4pWailJHhZzby2+wS/EGcKLQpraLdsmkCuB+ZJDIJNkETjH4ey4nkS?=
 =?us-ascii?Q?nDctwlyOssDv9nDuR1lfWHuEXRNwdmRtSyrpW8gBZp6h+uplFZv6XvX00CgC?=
 =?us-ascii?Q?XTshMRWW9E3V0VqnJN3q8cH4wqlIUdRhLyELTZdkts/ikUsrFs9ZH2DpFd0/?=
 =?us-ascii?Q?PLi9f8CjhVwprhU3wZX1uxwxky4M3agk9ZH8KEsxiBR1w79sZ18nHuzKQ6hZ?=
 =?us-ascii?Q?glhIqqT6UyXKnaIpc8A35Hs7NyTBcp25vDZtYoAJbtPcksKgB4YtwYbNcn4Z?=
 =?us-ascii?Q?zd80ev0m6WjKHYuyQqLJ/scWYt6SKwpOMduS1v4hhnM/iGiTDEtGLOWetaDK?=
 =?us-ascii?Q?Y+90HTdHh1DqdCeQx0W4xzF1kTXRZGs7kh9X6CAK+kxoLI7livQEyrmM6S2H?=
 =?us-ascii?Q?rDWW6m/YgFebFUg4ngTIOmT5tqqahqKk377QfcHbApIW+HWNEeNu4KLCzYwM?=
 =?us-ascii?Q?Q9b8jHHnuAh+KTgxdfehHMQgYxHiXCteh/0/AOC2aaEnT46a+awJ97OVM2F3?=
 =?us-ascii?Q?fjbs9mVfEvW1eyOmeWRzJjPPGu4QvQZ3CQ1q1XllKKYATkDXIG3fsQaBz/Qr?=
 =?us-ascii?Q?JuNdl2ht/uKji6EbMc8E0e0OdnuTEvkNHftzJbx47+LFT3MikBtTZVbcIsyP?=
 =?us-ascii?Q?oZKtbm7YtzVNpmjPeGQDlZIlvZeOV7JLYq+VAMJFHhUqeDUFTDJ/nAVCRpZD?=
 =?us-ascii?Q?NEE8coBFAJ8gRF+1cPm7AhQEgfSr4PdhSxdl+hzxutx9Sx3IPJ3POWh6iXI+?=
 =?us-ascii?Q?ZDQv6iPWVi2nfNrr5klKoFyd0tcd4PNjbJ/GdW97j2PlobsqFhfkQuhIodyR?=
 =?us-ascii?Q?3qRcCfGfL8R4qOwjZR+kSGkmfS26I1BZP9OBOYth2ZLJNHGNWVEBRUoxsT8l?=
 =?us-ascii?Q?96I5mA1diRasSrivPU74jS2sitodV+YhA7O9ViKB2E6wl4tAEGg6vBlKkbMt?=
 =?us-ascii?Q?f2Me9Qdrc2DgMxpiyCdgErdp?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d7066c-26b9-4ed8-6c5e-08d91a3b6452
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 20:27:43.7092 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULyJbF6vH9EYXN0ByH7qOawqw94yru0HOGJKkbpkzfq52PdpznWm15lFWZIyijsb9w9MmuRMIzN12Q6PLTz3PwULitS+4ngXp1MdvNRZpSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_132749_458137_B8946531 
X-CRM114-Status: GOOD (  12.60  )
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

On 5/18/21 01:21, Wu Bo wrote:
> From: Wu Bo <wubo40@huawei.com>
>
> When cntlid_min is greater than cntlid_max,
> goto wrong label, should be goto out_free_sqs
> label. Otherwise there is a memory leak problem
> on the nvmet_alloc_ctrl function().
>
> Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
> Fixes: 6d65aeab7bf6e ("nvmet: remove unused ctrl->cqs")
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---

Looks good, except commit message could be better :-

When cntlid_min is greater than cntlid_max, goto wrong label, should be
goto out_free_sqs label. Otherwise there is a memory leak problem on the
nvmet_alloc_ctrl function(). 

Fixes: 94a39d61f80f ("nvmet: make ctrl-id configurable")
Fixes: 6d65aeab7bf6 ("nvmet: remove unused ctrl->cqs")
Signed-off-by: Wu Bo <wubo40@huawei.com>


with above :-

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
