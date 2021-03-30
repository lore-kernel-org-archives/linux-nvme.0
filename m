Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B6C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:42:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D80B614A7
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D80B614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=YKlZqCjPrWZBqsZuEkykqr9TFEcPUEUZKMPO6ifsdvA=; b=UCu+cYG5ocYJyYtgGQNz2ZMLj
	+dlp4H6M1RHIANVLMSPZT5ldZzK9coBOXMYiKmsqPBxozcFDbRDg1ODecy2Zhos64uW4JxJwYMCME
	oyVHF7bBjVGn5K5Ss1blG4cPxwb4Kwvz6av35KDZ5jIDHje3B7nXKJAD607nBJEc5zkXsd0q5QEDb
	Nvg7dmdBNadq3HKzohPzrykajt6JwAnO8UEjf63RbAvhlwbr2Om5U6TpVIgCFk7E77kE9GYnw2lHd
	yp4MQUa2UabYUiKKo/4T8gADV+dwgHEDNXtwlT/chsrBcQHs927UQgKF9F0A54D/GT4TzXvKmomrn
	+RjNuq37w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRO0K-0058j2-Af; Tue, 30 Mar 2021 23:42:36 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRO0B-0058i1-HZ
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 23:42:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617147749; x=1648683749;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PR5jH5jhGUl0pL/AS+izYxwiQ5/dUuly+9qqJjqb8dc=;
 b=EUlPUFTkWxABMWnnl4xv44MghmpcN9HML/gxuRFr7dvCokUY2DdDtDnS
 gIAqV57CXG6JaUqgU42yqlyM428dySKEpbTAn22/7zlkrab5vdzR+kcrF
 iIPPcUj94tb79zTG0VDH/wvPbuGna74Bsky7tC0SztHTGMs9a+DiAps0Z
 83yuXKqiuu6bJFHjJAmtldr3nbNnCfGGC2NoyahbvCTA+w8vjocHX0J2e
 ZwXuFYQ8QySSZ+gUmW0u84AIKObEXUKFLlY+HGxfxw3Che19LAZnS/CJJ
 kx8In9oYrO8OfjK3Tp+MhdiGwm/8p0rVrIRUWGIQn9pX90+NBc24Fiyw8 A==;
IronPort-SDR: kFFDagysAv2QuxPaVKR9pjiXDSsy8yU+x6vzRAiMWV7UtuHd05xHcHeZFGSXQfXSGLTPoCCO4w
 A4LJhSfLuQUyjeqAfLJwKW9eIXY35hSonM/pmkDq/c+sTFfOszLLtd7LHAQBKofbpqMIEUzlJw
 G0+PEuS6o+LsfiBVJm4ozZ3jUOg6kVLDBwglaLoCzhxbJPuhUwZeXHd6JbvkOy7AUntUICkjDQ
 mjA1kJig+ETw2qE5xgvG5RciE3GydXXQXhuQQS5tDv2ZyM5imbgZ+oxcsQyrII2QQG1iwM6tkB
 B0s=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; d="scan'208";a="267819812"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
 by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:42:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6/Q+6320DmR8rIa3aUn3/sRrGURAjDdn/4snM4KlmjGT08tsrx+BUVxXnHjTtiUE7kUsCLquEbrAnu8tLiE8t7cdbPqfmGi14uuvzsllxPRfc3F+YFNBpF1rz/hLoLt/m1AZHEgPHrqGNcp9lFZ/5P4dlSAgZ2iBuqXNv3pWpX84wVnLOcZOcpGWz1IaC2AgwpXTlMoQtxmCPky5YOtEPw+9JJTDzPj7Ei2U9ksVhWmSSZpN4NM6U5e8DUQG7Ij6OjymsGaQWuBgimLsqxG002fLPLEXXvZkwU5UpfwfZPCgLW1LxxlJRUl/HlXBRXh8LxwIXAvlL43dLTi2N1gdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR5jH5jhGUl0pL/AS+izYxwiQ5/dUuly+9qqJjqb8dc=;
 b=lg0/oQdjOjOD7FxHlvg7oKx5jNhw4/3XwMYFFu0vOndCyZyWd+IC/9CXsOQcoGcn7kdWv/vepo0RYHguTKPZEOcsVqi/Iok6YuYA8o2X4xioAykqhwZOkYHunLbBN5FV8Q+B4Ik0lamxMn55Xs+R82Hkb2GNhIwkLk+UrlL5XZFGR2RT+2UNp0a2xEv3+xXhZgktyGrzu1vhQRcpX5ySdAiop6NtoDk/E6F6BXXX3+qD5AgPPB/qmBWbjlnOhQcj86rdytLxlVbn49ZeBPki5nrK65evkFqeTAQghz22Am3SymljVDDlN4ujG0AJR+dMWUCgUPCQDB9j1YHr21lK7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR5jH5jhGUl0pL/AS+izYxwiQ5/dUuly+9qqJjqb8dc=;
 b=PWCADX5Xf3/DhSlGDd96BjogulIW9ZTWjsiJobjvpdnA4qm2K69ackB7Gyt7a7oS75GgCl7iM/LIi6uTClNwODRbK7Rq6G9cpXFkcNxHsa4ZGmPuKoz0AEQ13V5mUHyLnfAJVTjTFgE7Bz5UTFmz92XNhw1Yb0FKpxS9ZBvDyBs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7423.namprd04.prod.outlook.com (2603:10b6:a03:29c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 23:42:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:42:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH 2/2] nvme-fc: check sgl supported by target
Thread-Topic: [PATCH 2/2] nvme-fc: check sgl supported by target
Thread-Index: AQHXJbifBnkLtL9T/USD2ByVa3Mgdg==
Date: Tue, 30 Mar 2021 23:42:12 +0000
Message-ID: <BYAPR04MB496516848BF2ECE9FAEB32D7867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330230120.268671-1-mgurtovoy@nvidia.com>
 <20210330230120.268671-2-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d49fff0-88f2-4fe9-392d-08d8f3d5710e
x-ms-traffictypediagnostic: SJ0PR04MB7423:
x-microsoft-antispam-prvs: <SJ0PR04MB7423408FEAB620759632607A867D9@SJ0PR04MB7423.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7+W0RwKYvsxK7s3tkKzF8cTq4bSF3hAzRDOqDmpVi1Fzz4GQxgA7DAsOEexX3PNWCNq0sNXDnG/5tiQOrCpWfxEF9WkP19zc2pnqCVdenBuAs0eGBTZxK0RuBFGL6bS6ouKB6hjC2SCwRxqNGMoHOhnyUqWAo9Ei8bJxY4FqG6Ma+V5rbnTWswqgklvzPVW0TRuR1oNm3EraS3oo/lVHEU27glQ+Mdq5CWdTeu4IKeqsKZZMFiauepWomID6be1ZnV1Qpy604F2+qeCzakQza8JAbGkXkNZBWbVOojCm5DIB+X32SfJGyLDvW5LbtYfKqCHUuvTOPilFEdk330N7hP0ZAYEz1eI2ZRSmhRpwtgDFphK1srV1BGsg9SlggHUq51pRSHvwJzukIse//FAl3HzaCoclELCUPSTVfI2koRNgX/Hpi1B+yd7/6hBGyJanOOt33KeVr7Q5rIARk6NOtm95Yl67wKDmobrX2L8nhPqSWBTEYjESUhcGxiX1hHIp7vpDnsKfT4AwsVQ46Xe6fQPJp+0ONyRNyRZyOhTrrzV08iIxX7+RdckTRR4Ir0TK92NJvuTQCZyLx8j0pZoFsSWh+RPx3ivABNUulr9U/jCBdl3wtbU3Ei11epHKUi3MzCuxZOTiXzWKU1sDl9qi6nDCtJGDWdCKe1qO9UIDva0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39850400004)(396003)(136003)(6506007)(110136005)(26005)(86362001)(5660300002)(4744005)(38100700001)(33656002)(2906002)(53546011)(9686003)(186003)(478600001)(91956017)(71200400001)(66946007)(7696005)(66476007)(64756008)(66556008)(55016002)(76116006)(316002)(8936002)(66446008)(8676002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lG1ZlLspDy3kOvB5GPx52kzB39520CgRhi+uVmR05/TWhcnHcJuBLPX1+WQo?=
 =?us-ascii?Q?dk0r4n02shht5ywKrsdJHVrUWB8J/8enZkjQj1kTtT37Xe696XNjKmvEabp/?=
 =?us-ascii?Q?KM6O3OdHFOLZbaUwxBYd/vpvQ6Mz65Z1fHLOxFRcFvRAwmmibUHc1CGmxZqC?=
 =?us-ascii?Q?ZDKFrTVUUfGVSl0hrqzu2wbK+9z7UHH3o01Dhw9fHVyWttxI/ImmVq5o6Ocx?=
 =?us-ascii?Q?wZguegGqMO50m97qUxOzCQf63y1bRA1jkjdOlxfae9J6O9qKPeLHZpSuWtSY?=
 =?us-ascii?Q?4xX4eX4ff30RS6vJIwM9rA+2zMESu+qPTvWvkvhRsTXUj4UvOz0rnwul72Q7?=
 =?us-ascii?Q?gg5rcP7dv6pzovuGZOztXarIHc10BAaf8cQdQ65KNEN0rZbpfpOc5+5tNNav?=
 =?us-ascii?Q?YiO004CmEIz0oE3lqzVfubNgI4e6Uu3+SUPtCQHwqTaBVBDwSomg00dODej1?=
 =?us-ascii?Q?7QZn071zZl1P8A3pTmR9IOq46ko9SZQvgZezW1el9CWIiovUNmfJKzPnH9yh?=
 =?us-ascii?Q?CnVOdUWibfjpKXBzkUVzu+ymAAF+vuczCfIWrZ+nHUAgx9mALXOKw0k6Dm95?=
 =?us-ascii?Q?zITzyViPQkCd2SwMsf0Zy3Cd7McQxRBmS1NdPyDBxRdbr3W9FLuec8vOT1l9?=
 =?us-ascii?Q?Lrr/SQWxLbsa6AGBYPrZxp+U7l0tJFHJ8R4F+AggA3ggqRJ9vqjt+Vl21b4e?=
 =?us-ascii?Q?wHs+42g7e2pmxwc80956SYHzlRRNJi7Dptoet+gEaTJ2eUjExZdtRWkO/BBg?=
 =?us-ascii?Q?ceaQ72pzV/ivcsm3SoSiIeHiOl0K4eVoXeMCeS51du35vRjOPSmSP1DmOyVM?=
 =?us-ascii?Q?NRLLHXUBGNoAQ6ISpHilSPr+b60NIY5pzkNNgtW2QuXhj8F5PBuhYxy9qsY1?=
 =?us-ascii?Q?Pnv8AhE9Mwp2bGpgw+6iaq6I4qRufvtE9WPheVDhzcAG8xJg7Tjndkzm1LT7?=
 =?us-ascii?Q?0DEIXV712++padqluCpbHYnYTzhM6vhuSf4cM6YK7b78XnXogHJayqj5x5il?=
 =?us-ascii?Q?HnjC3hEg0TlpG1eLrRfe5xQwXA2n+REMktzGkSKpHd9kzEa9PUFYmf4ZWbuE?=
 =?us-ascii?Q?AydZznI/rw8wuVWy9prTawlhe+jZj+oA9LzNzd4xvva7RbhmgmfQ9+bI1mod?=
 =?us-ascii?Q?vr+XL1cuuBPSme4KzNV7BV4UbqqYdB9Lx/RCS9LSLkDATkDELNVnDYiJyZrV?=
 =?us-ascii?Q?eTqNCCWC0pAMbPIYva5ARUjjDBpJPN8hM7b5rY/ugY2G6fVZmH0BHQu0Gx6S?=
 =?us-ascii?Q?WPIqVHyUbNDyQApo/ninhS6HDT3DLvWiuhTVUzOiWyquFWEggcBYpLpuUSAt?=
 =?us-ascii?Q?puretFh1C5C2xw2jPhgi/Woo?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d49fff0-88f2-4fe9-392d-08d8f3d5710e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:42:12.1887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLcqzOHNEI4e1C2e+sgNnaxtaPOPVdat0etQ6Q15HD4iIWCJ7HosXDlcyGCWRfHE2RYX4hYAH6u0YrLdYJGmSw+a4VqBgJ9Yg0m8IHTI7tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_004229_823271_444C48F7 
X-CRM114-Status: GOOD (  10.87  )
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

On 3/30/21 16:01, Max Gurtovoy wrote:
> SGLs support is mandatory for NVMe/tcp, make sure that the target is
> aligned to the specification.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

s/"NVMe/tcp"/"NVMe-FC"/ ? if so that can be done by at the time of
applying the patch, if not just ignore this comment.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
