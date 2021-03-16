Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3907C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:38:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A956500A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A956500A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=JW7+g2opBS7rvqG9w6pUSR+eOO8yxm93L/sDu/sULeg=; b=YYmq1ETq42v5VOZ6htmpE9ouG
	SlUU+/03pPQ2yD0CL/Sg9EumUJXULnj72C+bGQpsCTqBPp7whX/KfLsWv+ElJzD+hfJDVGhHA7OPj
	1cEjtZQdShJU5EhsKuevxeJw6hpi9yjyTO8anG/EX+C1+VU8ejSYiWY83yrUtMHmOGNyykh8sWeA9
	amYyPcQkspztbQCvoXV4BjUOFBBCI042gVccBl7T6OdgSndk9/+GW0o/qTW/iWhJ73apEJ3CcqyFv
	7RRgMeIeLj5hd5rFRiwrx3a+VeApBbG6O6NG6qbj0nudEpd4V14D/X9174Oz58+6W0NetZzKdo9Km
	gFgwwpYGQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM0XU-00HKv1-3e; Tue, 16 Mar 2021 03:38:36 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM0XN-00HKtu-Qc
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 03:38:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615865909; x=1647401909;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=krH8+WAfkmi0StPmOTyPsMENXr5eLH7yqeF00FEHDvw=;
 b=TzyEPsDfLNM39v86kbX84tz1lKJYhUrrF9M8u9vG3uS7F0U+0epHotb7
 absjGfCZ3cSK/YCHjMnr9ozVTX2s+6l2FzQa7boPJxVKZMqdm9WQQ6c/4
 yHxkB0RQPCBF1/VApmGsdVsKAS7FXLHcpcmBw/4dleGg8Eqr9zJ/jSN8X
 9O9QEi7EXcETn5DYAGbL4cLKkbAdU86vDSTOpjK6Hck43pVsABWIedCRn
 3FjyYXWC2sTvisTYdWLsmBbh8xclG03evMHGnW+FwkTN4b480O34WXr3T
 HFLLJJUL86D1JHFWg6FlkN+NQKcv1FsrNW9LrSkPAG6Tb5NvtOagZ7AjC g==;
IronPort-SDR: aY/y16eMMzzDUptofHAl8ObYZRhDaGGRB5EiNErsvUCay5/7w4ac6WoT9JLayWjGjPuuQWUdEX
 6yRsenhL4k23i+9mMggso5eY2LxZyktN7ChpsSfnE2CMcyfhkPx0UT2OoP4ZIxLlwl08JZSFTZ
 Nd/nHHIxRviCeTh1Ifsm96wOv7nhYlo9gpCz7CCRMXbupqLFDh8wBo0YQdHYG1rVDxVIqFuzwp
 1XxF9UWkKrYJ4D9qIuVFR087RPgYTdUrUf6AC5C9n6vMEopkn0PIuLqWOny6D1tc+CyE564gb0
 Xu4=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; d="scan'208";a="162203495"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 11:38:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYXynlAwRd6Uz+NTayKPPx/nGMDuh5JtE1yBAoANH+yKIiE14ermGxdgbhoqvyLIO6/GSPraCWfNeL91ngrdZ7u+V5klP7YkeMX6I53ZydWBApDlCWIxuCCBpXnYrvV+4LsDyid442dVjdW3yY+ws+Cq9cyJ6rujY8a/vDH15/pURJWr0VaNRAUyww9j97mCNaNT6XGuiAyXNZhoYjzRISTvKbfGrACBsLw6kqLL03uBC9W5LYK4bjYEPeF1WHj9vBa4GD8Ypzkp1a/E2krh28ELnHXVZvdsm1qZTG7XrJ+hbM/OpT8eU7TfrB3pmIz9QldXE5D2VH8wKXpx9v7B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krH8+WAfkmi0StPmOTyPsMENXr5eLH7yqeF00FEHDvw=;
 b=Hk3Vquh28eLuR9/FEhDXZMWN7TtkXQF1CSmG51vXs8n7NmqckhOb5KjVYS3PwwNsp/jNN1RirPHEHsxlsvxFGRiFFVW9MJ8GFMrAZn1n0tyqXWXG6PbQfyKlqC1c78P51O97CQyOjraeDwa6A0Xf8ljzHnnXDccwgr1F89yDhGEHPb8/lhFMw77zbeFcI36UeNIDjpRKjNYmWnq1BZjFp+IoJ/NAupZ6qYgjD1tLg/VTFQVAUjkVQ5dKGQJ8Rfs5yusBlQ5wi2tD3xqGLD+FS3xcWdEEPHWmEOV5/7wHiSVDJBNXS1S+6tkKw/fA2I0k+UixNkFdWF4ELQh9hJNzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krH8+WAfkmi0StPmOTyPsMENXr5eLH7yqeF00FEHDvw=;
 b=WplDiuR5Dt3Ol30uGdGokB7DSPZb8S6AJHP8e13c3lMBTrxF5HAsCj9Hwz7Svy3cMBjuc+w24uFeKzOIGSWUyBe05G4XfW5qO25gfzg2hB0Qc4LC4nhMHZWbG/nOqgsHBFfe95jvFo65PVFcFtEgPPSDC8P5K2zoo28UfTTQ2Hw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7025.namprd04.prod.outlook.com (2603:10b6:a03:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 03:38:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 03:38:23 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet: don't check iosqes,iocqes for discovery controllers
Thread-Topic: [PATCH] nvmet: don't check iosqes,iocqes for discovery
 controllers
Thread-Index: AQHXGettK1roiLKtJk2xDSpnGOH+DA==
Date: Tue, 16 Mar 2021 03:38:23 +0000
Message-ID: <BYAPR04MB4965A1560B3258E7E4DD560E866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210315223451.380437-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 741ec369-4402-47a9-8b84-08d8e82cf357
x-ms-traffictypediagnostic: BY5PR04MB7025:
x-microsoft-antispam-prvs: <BY5PR04MB702521C069C58BC1BDFF6A85866B9@BY5PR04MB7025.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fp1iSpvnmk1xBBIzFvvpi3PGiFv492YUD0XC/GT7WwGGcigU7r+HtC5VdGhJ81V9W+mnOpTzZ9mW7FvpEPE3WnxCV+uK8cVgB6aSC1T41I3LgBRWzuFmGEfbTqFCQ2IHKZITCQkN37NdtbQyYwoOOBcdfHx8wZF+sRkeal0SywyU6nB89ZCV3YVV1WFMZIcG3feg84R6wflvYMuhKuYV0+7fI/yerIM5TPcNDCQhIWIt6ePt3HLwbrCxWU1Pd4N4ZenTLGbgctbhhr7VzPENZKDc9I4cZf7NsCIz55lpDHmgUpEEcIvqWyK0YHM5VGlLTeVNCTDreH5aotAN81bkYlydex+zrGRpkCzwh1I9KEYQoQbD5HXWgk0sFzqmlLOlanK0T2Tjpb31MxZFA9+PDxN2zVSoAf8sEaySRaVcRkMGcP4e3rFgiGzGb6Icv2Q01PDn84gXQzr/dwEWHwSsaCBjrdAMyPEok63iSB0Lp3+JAZt1YN5KKf96QrsEEXnPsfGtRDiLThmasVDwpMUVPng2EkuHwFCiYIO3t3NF4sp9duSxoVw6885ckUwk87Qz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(55016002)(8676002)(9686003)(52536014)(66946007)(5660300002)(26005)(76116006)(66476007)(91956017)(316002)(86362001)(186003)(33656002)(6506007)(2906002)(7696005)(53546011)(8936002)(66556008)(66446008)(71200400001)(478600001)(64756008)(4744005)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?V3GGSuEEEN+t8tS/RsYOdcr9iZq0MDQAHYFFWwCDRyzvt0MfqRiJKM4P68g9?=
 =?us-ascii?Q?/bArJBKEDKFKSE2T7aXH2WVt9j1aXS+NMeoOZWY3X6fHixMyA8lfrQH2THU9?=
 =?us-ascii?Q?w5tlr61G299OZ3JNfLQBq2n+6EWO3xLlscgY4cZu785Hfr981jmH2dGUeACN?=
 =?us-ascii?Q?z3cUcJVG/IsGJL9AY63JmmRpgSGJo8IU00Vz+yV00JSsAjCIVpDbs28V8OAA?=
 =?us-ascii?Q?Mtzcs4Tt3DusLKVlrcWk6eNg3e8H3kO1c7SQ36Mn2gpDYAWS6ig/hSTfgjzQ?=
 =?us-ascii?Q?Dg7lwe+UHU5OcV1WO78bylMra+d61myC417gRhSI/1NP9MvNkTLwwTCJVmD5?=
 =?us-ascii?Q?hxdT/genRxxNDs2lQ2kLlpnNcyORa6VQuMZ8tsrhql+YrpcYYHLlC1fGBjgB?=
 =?us-ascii?Q?TfsFTQTgP0aEPusR5WTlGcSpEK4F3SS4m0/mhp5ymKgNDIiqHrwlzigylohF?=
 =?us-ascii?Q?st+5UxUIxwSevuCQrwaBsFlntHT06HnUTPUdPrT2xO8XOLZQltpPww6bUKLa?=
 =?us-ascii?Q?wr5G5oQYchaE/1IDRjfH7oiEs3x03yqe6xW14TmFkzqEcwDU9qQRGMKQU0vP?=
 =?us-ascii?Q?A933hUKgMcaXrT+HXwk+4Eg3H/oMNIo9uYsaTLNYR+T0eF5mAHCPq06ZyVpb?=
 =?us-ascii?Q?vnpG8LKhOUz3eN32UBZayh7aKXIrcNpbEOI73u5FzPGnsuiVuFq5fy8d8yZI?=
 =?us-ascii?Q?l/xR3u3DAam2Gzs3rjYZoz5elM5IJI7QL9tbad/z+L0qhHTHs/Q7Pfhpg2TJ?=
 =?us-ascii?Q?lD9G6FNnom6kqgfMnE0vPehhADXWNIsWQV+MGOZ5NFccW1IKjPdgULMwFhT7?=
 =?us-ascii?Q?9L9/UeCzM7IS/i7hoWw2/bCIv0H3plQlIhFFQbO5G5GFuWoM6zCVv5tp7d1S?=
 =?us-ascii?Q?ByJ8E1bo6C7X2y47r2kXtRhBsIjFFaQd7PBA6FtnLRME3Ht6wn33ujmr5x/E?=
 =?us-ascii?Q?1zM0WqCSmehyi7FlcbarkBt6jcLGY4IY6iRiwJArKYeB5lF472e0awKYljBO?=
 =?us-ascii?Q?JjmGvTdxg5Z/g2kBYPRtBS/rzyVFHRZPxgTjP+ZPkjbBcXtnBiLrauSwgbmI?=
 =?us-ascii?Q?dR+lYJqss0WbIjuQ6WB1ikGhJEy9g45P8TP9rG42EwbIY4Sh6UeU/eY/kSCG?=
 =?us-ascii?Q?Gv+A2hVMm9PRvC4k2R7QyaDpp6fZCtxp96CG2zmDsmbtGyAPIq23q7raKc4D?=
 =?us-ascii?Q?jsIjMLF0mm7vvCnKKNyqFNAo4QxAaOv8bangzYozxNSuLrynh+V5PBUTNELL?=
 =?us-ascii?Q?UILjzPDsyS5EGW6wFFLieL/B6ioZTP0D+HMK/LI0Wif9IJlqqtk4BbBsuuhL?=
 =?us-ascii?Q?UNjETdacMD7QrNNOMp/WaLt/?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741ec369-4402-47a9-8b84-08d8e82cf357
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 03:38:23.0528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3qBDi4bW0LdyeAaLZlsWYLlPHGp5QcmobviFaI2eEbbmq5VbKKHxxMNyhqsrAxCQcZNaDK6m8EaUBv2Hl5qQKGA60njrUz4DyJAtHT+n3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_033830_254122_CC6460AD 
X-CRM114-Status: GOOD (  13.24  )
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

On 3/15/21 15:34, Sagi Grimberg wrote:
> From the base spec, Figure 78:
> "Controller Configuration, these fields are defined as parameters to
> configure an "I/O Controller (IOC)" and not to configure a "Discovery
> Controller (DC)".
> ...
> "If the controller does not support I/O queues, then this field shall
> be read-only with a value of 0h"
>
> Just have this check for I/O controllers.
>
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Reported-by: Belanger, Martin <Martin.Belanger@dell.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
