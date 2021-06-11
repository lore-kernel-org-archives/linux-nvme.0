Return-Path: <SRS0=5/PU=LF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07628C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 02:35:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99CF61364
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jun 2021 02:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99CF61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=tKi1J+orn9sJpAon3yOPG76taHtb5xAhQDJTFQWMf0U=; b=WTSVINTuGDi/M9
	poOqllCHgSWX9TmgmZ+5C0PD9FqyBTjDZsmxNtsA2BJe2W533iPdmsug/bcQeJ/hnDD7jJ+wg529I
	9ah4t/BXq0fNqjMMmFhxMnuIo7UJPW250pnL7TDfYnOhwiMX0x6uFX495dibkg/8dz+lb2wwqGLg1
	kFB8p7+h+9zc5Ks+TOar5+9WPfHvK1fdc9YPfAx0z3R5vA6aq6yoGDYg7Ct3rv/bBouVOI5gT6C/k
	WhhwBRIBG4943ixgkY2b+7Qd1PIDvleSYtnLlJRu+W17Hw33d7Bo24vVmIXQhGhIyEMf2G4ejUMMv
	llbSJPPu6MWi3aHo7C7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrX12-003G9z-69; Fri, 11 Jun 2021 02:35:24 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrX0z-003G9C-CQ
 for linux-nvme@lists.infradead.org; Fri, 11 Jun 2021 02:35:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623378920; x=1654914920;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=axlX/Irgn1dsoSDqjEEBAzBzt/ccDb4md2gtWDJcu1g=;
 b=jl+HwCKwXtC41iqPwv65C72mZtvQtcm0H3yqdjmb2F7ib1gWZHEIbAVv
 Mxca7BQ8waUYtQJ/dSlT2F5Y89w6tOHH9FXfNueoazBrxAsNxr6YnRV0W
 +DAvdU5Sg6sLPBj5x0heJJjNJLEx8BZNSAO5CCBjuspSAUy7lTVpdVxPZ
 Lsg2iei5qUjo/GjlQZYz0wSLfF/m0As75Nvy9/AQJmNJuuF6zAPpxBuTb
 mhR0e/0zCTVR97P+Y/FFtYfE9ycAPs6QMicElG1vRmJiXzsmlYaol5whw
 CFZDrLdNWGwv3lQ0ZaiVIdBSUFlFS4+L9ImuCu7eEoTh10gKnunJhHciQ g==;
IronPort-SDR: MPA9sUKWKYuv/FOMJGKhvXytX61ZuNSY7ZgCcDOF1I8aON/dOXQ0bFXjRPc9zQ8quDY7tDubSr
 v1K7tAsWcvEejktqwS+eAmhdNETN8cYwFivVfYoAEIGRK0CAaN+5IMWKkWiwayoQnXQlS4Y7BG
 uF4s6mzwjdyQaIgCHMW4M1wfrawrU0jBfM5GSoH7yMFn5W+Err+eBxUEygDpGdIfI+cd3/OgHI
 bQWebEGHVJH0GrtQULC1ZZv4Yq1C4Tk3nWb+gIw78SiIeBdnaE3Efk2eSikDrmNEgp9doPdKUb
 7xc=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; d="scan'208";a="176301001"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 10:35:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWYRAiWCiS0uWqLkEIZNz9l6qXgpPicWCHirG3FMVQ7rUYtAnkbiklD37oy3W4p9y8iKfzlSzyCIWFXwDO8+up1yfu97H8X2lN/ZuS0sjq5W2C1N1WNwCaPNtllhMRBGZGs3/YEEC0wRcSuGYP87c5JTluwqkeahdButdKxurhC8rM532E8NbdcvH/1NbjoiEekv/PSgknLRx8+tABOc+Uz0HrtBYY22pOZQ/wM3G5Jc6m3vqpRcC+fSHref3BMR0Qq2WMzqlupsaQkHtMP+6qZTswMhhm0l0/xB1rt7wpbAR4jB+cvyvtKqae7Q7nr91v+72VjmascjzRRuoDeOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Ia32k5fp5RbRuBM3QOFhY7occXEsSBdjP8UjG4M9w=;
 b=LVb/QNgzJ+uBXHt9RwfVvLO4pJH1PIdGhzoXZrfMyCN1hpRvBo0ccw/PSckaM1tqN33bA9YO7cbS8vu0RpFF+3LSwvZWBT38flVTWGY09BpLAaVbpK/RSX+aoygMH4RmHKiPJ5WFvz1slhC+h/12ImHp2IEhVr12VzFnBs65N4YyLjoDkUqjGakzqIyJDex8u2tZUKfj9kP31pnaRgzkYULk8c2YfeM8z+/qAAqfBPVlayzXRBFGqTRoOI8qXBsMHGH3vlOsLBV7KoBUdCz2nhTWc/NnK5P7w6S3kF3RygOryrRbsqlZqADp9OZdItZq8KscV59w5lGUpNf5VzdC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Ia32k5fp5RbRuBM3QOFhY7occXEsSBdjP8UjG4M9w=;
 b=ZATbRZEwQJ9hpPqGkE6D+AExNo14meNxKnNi+hy1jerE+QdftoeQbihHIZ/SK0fLBSwx0kqItp74P7Vo+9LxXyCy47sMWRXbB7blOqFLp1hLezABWEy8bzDKCLOP2g3jKLzc7IEFLSrc8Y3deCEA9zrdri8RUonpD+N27WJWdBA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4520.namprd04.prod.outlook.com (2603:10b6:a03:5f::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 11 Jun
 2021 02:35:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 02:35:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Wu Bo <wubo40@huawei.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V15 4/5] nvmet: add Command Set Identifier support
Thread-Topic: [PATCH V15 4/5] nvmet: add Command Set Identifier support
Thread-Index: AQHXXZijvZKt+TuY7EiYul/aeS4qHg==
Date: Fri, 11 Jun 2021 02:35:16 +0000
Message-ID: <BYAPR04MB4965DAB9078B76AC9CACC8CA86349@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
 <20210610013252.53874-5-chaitanya.kulkarni@wdc.com>
 <923a0c0e-2f5f-e2f7-aa3b-b4feddd754b2@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcf69259-3a9b-4d56-8873-08d92c818c46
x-ms-traffictypediagnostic: BYAPR04MB4520:
x-microsoft-antispam-prvs: <BYAPR04MB45203A1A8E20002160FE7ED386349@BYAPR04MB4520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fib6znNN/ScU461nXZxl6hDdd0H6BYx+F/au1ujX/7pwu82x49aw5bEKb5EAKdkZku5q0RVSiWuOL8SvDCVp89an8cx5iINLXoCWb6U2STC8JXwbQ6+u70G1JEVvnh4dvgrvSvOEVKqK50k7E7LhHtyLjYfYkaax4snFuPIoNhR23e5NY5Dx3ayU9wSOPxC1bIPXYewhIxpwhcRKI8McDF3Gj2/nZ4IhfRLbM2lNQbK9NOpx8gegGPuuyxb71u1d4haRjMVZI4Wstr2yxTctRpiyQqWS49HONZq8hYPovbHPX7syxF43tKFh/Hb01koIr60uKMR6JxaWE+GwaDcl+ZzrmgH70hF0sAO/aZgqag8IddLkCN2rNWqLn0UcraKLxt5mUhMxfFpdvbOHVRnauXRYFUL/EYQ9jS0queK7KTyUJsCLq8KWssxLBhRJM569vpAa25FZfV/QG5qG94SPEBKPU51IMzNyLKqiXvCPCF8Windw5j7GtbTYZD+XCsC8Ji5ZK2GmlQD3zCneIfwSh+oG/OspAL6W5cSv/iFoz8sMk9zoLTbPXVBoPaizjFtlpNXGnFHXGKtBkO9+ueRxdHC++8fq24amqe39yd/it7Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(316002)(33656002)(38100700002)(55016002)(122000001)(558084003)(86362001)(71200400001)(9686003)(8936002)(5660300002)(52536014)(64756008)(4326008)(66476007)(66946007)(76116006)(8676002)(26005)(66556008)(478600001)(186003)(66446008)(6506007)(54906003)(7696005)(53546011)(2906002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5wMFWvGu74C2uWfiGFGMhtjgqah+AudQBcmrCBY1LVw8VIDCaUB1xna57B9?=
 =?us-ascii?Q?axA7RKTci0i2Fjf3nzOza1xWaI7fmoo4FATY7Qyt7Is6/kAe2KggVeZL18Dq?=
 =?us-ascii?Q?gvG6E6lQAIW27clvSQTHoVtVEaHMZdpQGitNB0NimwuwywvasORcDJ33d1sM?=
 =?us-ascii?Q?9C4sN5yn1CAeRhEt3GDZgIGy0tDySGSMsOe7TIugjPPoxMh+eDlw3Do2B/bm?=
 =?us-ascii?Q?WtcTI/5WpUUmAHCWvsgApvVOGSyhaIXnxaqE59hdkJBjX4nBl13sphpxU9GG?=
 =?us-ascii?Q?QADP8qsclveqxHt5V4UO8zIHXY9quoyJxjec5YSZ3ltEENmHLb4v2w4ujcLg?=
 =?us-ascii?Q?o2k1OMKw7apXAMy5CNSxSvF5trw2zHPaNhu+/70KYJgiwmoTY7/nkasUbNRg?=
 =?us-ascii?Q?RaamYPAsaqeooNb+h+q8ZAjJp3KRX7Ops83q76YTiPLDx/IDede0q3crQ2+W?=
 =?us-ascii?Q?7gQ385VjK4J4Lsi0R/8BFNEaVe9vTAjlBbv5aHCT6TlRQw8n3Rrk6AzxvVCB?=
 =?us-ascii?Q?ZP0CBa62CRfF9NLpvEWJ5ikYivzyM14UfAG45FiZdc1ZKikKYZOlrEZiJsYb?=
 =?us-ascii?Q?eM5DHKMD9c1vplDSii2HNjwAhi2D7EB58PJnmmpUAV8lwLkZ9Z8Q9GvDYxr5?=
 =?us-ascii?Q?lLTJfyMUB29Qo9PrNG3iXD0BgM+6TT8+RibOpr180V21nG7aZE0A30VBmei+?=
 =?us-ascii?Q?x1AwQdXvAC26b7Z6CU5Dgh1Kjz6jGLmlMYLmk6wj9fJO0T+u0cJEcamurSxX?=
 =?us-ascii?Q?nVH8yH56YcOEZbtjnGu+1Kw09AZzMtpuolzXTkWJA2VquKFrodtQbCdpBVin?=
 =?us-ascii?Q?BUu8oCq02crTb4X+ejXTD8MW0Bhz8Ih6OKqvvG5fvp5syk450vrXKMNucrxs?=
 =?us-ascii?Q?LQ+5aB0bRBehjSmGi/xDm1fjbsHOC36QrzZAAl3SjFYfOUTX5FKC519EUZZr?=
 =?us-ascii?Q?CPtJ8ZO6VN/Rhcz7fYBHuXbORxtWJiKiVC6fYmp/Z75GCHQS49Pz5Hu3itzO?=
 =?us-ascii?Q?XIebqjmdyKfYLYhFWbAiv/ly8tTBXjlWjKdw39wlSP0qK4dfxST0BxPRkqC2?=
 =?us-ascii?Q?2IfF4KnP8+SpmIpnZGcvPnnPmmg8W8J8w869DfOSCTUfwy+badXgVTJhsLE+?=
 =?us-ascii?Q?yQrq2726OEiMfjcp33mQ2dtCT+jWJ83ChCHcqLjoiB9r9wSvuHisu7JjyXSr?=
 =?us-ascii?Q?zit5Ye6o5ZnoXpyaNbPJzV6dIRoyrVeJjkZ1TuzBy00RrJZjo+ioeFrn7JQN?=
 =?us-ascii?Q?8VfMPgUxcC4rLYg15wpbOsSq9Xl6Dd08+nUmLphuCSK+gEg/FTr4IL3loNA9?=
 =?us-ascii?Q?0QywalUHG+dGugcblaaInmZG?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf69259-3a9b-4d56-8873-08d92c818c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 02:35:16.4542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vf/8PuWyFcykCYmPe1Iuv4nNBo62S+2aqlvlmfk8R0yvw3UVk+sMKWUoAdAAT2pBCl0Y5CUucy00xKaq4lNP7SE1FR/T2pslDbiBwqUMsVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4520
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_193521_463374_78C0BC35 
X-CRM114-Status: GOOD (  10.64  )
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

On 6/10/21 19:14, Wu Bo wrote:
>>   	case NVME_ID_CNS_CTRL:
>> -		return nvmet_execute_identify_ctrl(req);
>> +		switch (req->cmd->identify.csi) {
>> +		case NVME_CSI_NVM:
>> +			return nvmet_execute_identify_ctrl(req);
>> +		}
> Is it missing to add the default branch here ?
>

maybe for the consistency



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
