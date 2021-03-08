Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AA1C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:22:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50B165146
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50B165146
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=+AJyu7cKl+2yLnOyCDxrA4uKvUXXZAkLSpBPCLNlvVQ=; b=LQ9B7cm0WT+PxIi92mc5YZi4O
	Wp0zRMmOFqb72gOX6b4No8NE2ixnpVX5KBL2K11fBH8+oXJ3UHvJYV9MPdM2sWKtq1fz+e9Ijz53C
	bpXed2gj2GkNCoyf1b1yHSrDy7dSMmhSQa6VMMpgK7n3IBusaeWLHuAdqE4NBjXAZpllNgmLou4JX
	ZDJiOlbHmyKjZDNebQcj0dbz+PVzNOSsJ8Vnl6qj3fZo2newUBo3rYqvBh5hSELEHWoMzEXBgkOdU
	KVpkWPtsP0/zvJi+2CHr1MMnt9XpBER1tJt57/mYOh2sP6JfhR6Gzv9tSP+wjvpW081IhrTYyqsOU
	Uxs50IdNw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJADg-00Fhwa-W7; Mon, 08 Mar 2021 07:22:25 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJA8l-00Fgb0-KI
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 07:17:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615187839; x=1646723839;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3qHNaCvRmY9xepfARzwVjJvrk824f8/VFH22T+4ZAEM=;
 b=eZjPVB1Cpt018jlKX/JCACQg1dTXb5tEGzeDHhTHL2Ongo03W15N8ULF
 yaMsW67BbdbD59iImhJ6ryxpO+v28w+3IKjIokLvCdJjDicidv4fSeP3H
 NorUOooIDtcUCRB5a2FkkNR48GBJgoA1gKEkTFCglSaHx9iWZrQFkzR1n
 m7dtCrFrjiDxKEsOH/1gb3fnWXWzoH9YoagtBduLBmGTav2Thp9FIGw01
 pkMg94u1uBrX+GcIwaJIENqBvaLJ/nN35rx/3gdvD84S+AMGPyKPolTy7
 0aPsQIhOsQOsaVoX7q//kBKZwNEZte6HO7roCoSVcs/jNHEzgXl14/tG3 A==;
IronPort-SDR: Y0OLTxtQThLuOEycub3hsI4D1uxLZQRTj58waUCQY8rKEwS+Snw23w9xzeDgKh12ygugmGVi9b
 wMwi+eu2ODjTEgf1xbi8EYUyuPuUjwE/OtLgpXuDPkiXD4eey/IELlUKjLwn0kXxXl2W0dPDIx
 /wBGL15J9J0adlzWd/NsgebKHyQHvZEWDnD/Vl4yFyyRHMdjV7GUxya8UijRUm5eMQYGLSD+mw
 fUXq5uDJHggzAT6CPgV9TuYetsxxpLcRCU45bW5691Vv3KWxdr7UkS5IajA5WD3jl4fMECdt7s
 VeY=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; d="scan'208";a="161590367"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 15:17:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vdh66/xCzj/z58uu3I4w4x9w4IIhPVBfdt5GRERn5q8mdwFSXuRxXby3mP3/3/UXjhCrdSBHGTziSpteSDXbBBUgD/2fUBdEaW3O6IAnlfR+WYS66clPhnRs3WtXau+lxcnwoYFTNXUSqXkMQH8UwDY1ePpuicCHoKKsoLO56hlK8kt4VJrUDeCjwmM6u61kIluG0JUFyKOZrQwMpl8DKmVWGr+i22Tx6nZMHMuwsm1IAy3eDdbDFl5H51rDDeo+NnzVu18MTYYfo+Sr7sN4FIo2WnPZxRp9v1Vj4vlQSeO64Zt0+1BGzan2RdohtC8hXlzB5sNu6h5RtqXcwxtZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qHNaCvRmY9xepfARzwVjJvrk824f8/VFH22T+4ZAEM=;
 b=lltM9SWuPl/+G/V6Sf6T4IwJJG+x57nqNxYn3Y0OC3HBJxsztKUK3UxvUri4+WlEOx3dHWhuoGLGaLCKTP3j0ZD/br72CUHxjzWENUhiPH+j7N/DoOWKGHD+PR8XvSDxooZ+NnE0sKL1vny+bsYkS9hzpyD5X0Ne+zyt+UTD/OjBzlQ7xkejbI7U2fLhkp9xNtktt3Qa9xEyFYtVBz7nCvZRlmpmN5esPIJW4CyLbQjHRY1DN5Uz+rxQjjDUpFmEqiW69+DKSNkgqBr1VhaNpw/iJEdTnd+w72RWmZ1b7/x/Xgd8TvOhcC7UmDGDcsWKb9UAcHGNaYH6BstjM2kflg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qHNaCvRmY9xepfARzwVjJvrk824f8/VFH22T+4ZAEM=;
 b=i7OFfPSK4zD7JyYYU1jxQgPRJZ4Z81sUGiNeVIk+HRCc8+7aZSgBJom5pVuHZ3FB3PbluEaNLvMCSONGZ934k2/xQWJ+y3CvRL/QAX8AdP1VkxStJqOC5tgFHeTue4Kt+57ZhDl70GA9hBFkLK7WGJPXNGuebWzWqV8l/e3Jk/A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4103.namprd04.prod.outlook.com (2603:10b6:a02:ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 07:17:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:17:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Enzo
 Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 06/10] nvme-cli: add generic logging functionality
Thread-Topic: [PATCH 06/10] nvme-cli: add generic logging functionality
Thread-Index: AQHXEiDO+0ZhO54F3Ua6PauGKnAgfA==
Date: Mon, 8 Mar 2021 07:17:16 +0000
Message-ID: <BYAPR04MB49654E6E79919FC4B3F3A31286939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-7-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8794394e-e18f-43b3-63e5-08d8e2023427
x-ms-traffictypediagnostic: BYAPR04MB4103:
x-microsoft-antispam-prvs: <BYAPR04MB41037DD99B7D303FADC0C1E286939@BYAPR04MB4103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAVoR3YAAoX6KOCc4dnMyz3CVO4m7U8yPXhLD0cBtjR6oOET6QZLawoRO+m+YXDkYZKXNdT/9RMnlNZ/+W+p8VoCzgDM1dJxyEWbYqDGFafXrQvEwGrCN/g1Ow0UcCppAt+P6QwW5vVzatZq7B5j0iF6VZ4GV/eSbZ5qCVdsVyeCBgW+WmyzdADYy8gOiSvvBdkCB+NvFSbwGKmdeR60vGpQ0eSkrOzAE9mnlWBDXMf7tMgV4jsvhRCJWnuIwvjBDd9dhtvWAadDnWOndjw97oeEWzpDUKspzjgupC+TW8b2BUaotFs32vdV2wyOnP7mmUpt01gg7cPk/pQHDGN8yfm0DiQCADho4CurAedKw8gk0E0T27Yr30UCQIC+Z5og8/dCOu2jWj31DaSeu1hGAnwrp/HzDURa0BavjGtB4hNQH7rxTYS41sUr4wSO6bMC4mQZyWuQfpYWEiFPQTnd6LQef+Bk9+cCYSccZN74d5SKNwrhnv30BSe2IET6bVfaiFuDF+/uUIFl51AN/BGxOKBXirxaSG17HCDSovF8GMGNS/JaxsJkwcR+teKU5uhL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(55016002)(4326008)(110136005)(54906003)(5660300002)(316002)(66446008)(8936002)(64756008)(66476007)(8676002)(66946007)(9686003)(2906002)(66556008)(7696005)(52536014)(33656002)(26005)(186003)(53546011)(91956017)(6506007)(71200400001)(76116006)(83380400001)(86362001)(4744005)(478600001)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3u99VAgo7V/BL0Nxp0rQGAEYXqx/LHUuwVBnvWS/eAjWko+FTAQbAK10J6hp?=
 =?us-ascii?Q?4B10a3WU6ZLocpbgl2yDBfwdx9HsSCl9H3vDJWDvzWDZ9ziQ9JquyZwt3sDD?=
 =?us-ascii?Q?1K/H08gwDNXfzEz0sQOxeWCAihBAy9bc+8u3B5fKGok7xGwi2uQAmJESECyE?=
 =?us-ascii?Q?MoFw/ZbW6uBP7WWjD0zEuxaflWKuJONfPHWcSZ6d49+8rPOp3LLrl09WOHJw?=
 =?us-ascii?Q?fW3mxmPNNlUCBNUoMPtnVSia1KHCjAaEDUwUtNtEHMOWLIi91zZRwKjLXS6X?=
 =?us-ascii?Q?K2fkweiAEdDip4hjvYM7iNAMYLXq18y5gwyYi2+59js/ujTZLJNbV2clscFh?=
 =?us-ascii?Q?PPGdBu1ze3B8XvFFvuJj6RLFtUOfKMQHPIPuycQn0ZnpENwButsQ6i2bQyxb?=
 =?us-ascii?Q?ZAw20Cf57ipBX4/nbeE52MPx9sad0uL5fsWfH5eAISsCn2eRQdIbi83tnyuP?=
 =?us-ascii?Q?c2r4bH1kTOQ87L1p1LXWQ612xudsUu8+rYUFc51JGxbm26Dw/nD5auJxOBvV?=
 =?us-ascii?Q?Wt71CiOHrt4u9GemIZoHSEgjsHP7Wja5Ctu9vIe48sEAHW5y0WDRYPXcYudB?=
 =?us-ascii?Q?FK9fHx2c3KqPcGHIGHxf6wPe8jwT5iTZof1da56FEKeo6O7vD/jd0nuou72V?=
 =?us-ascii?Q?feHhwKw1MivNhHjmOYVB/bzv35w5XN0nYCaAnNhAsJhXmUFR86KfuG78j8pQ?=
 =?us-ascii?Q?1jGCC3ihhDZSaetfOPuxsqWSwiYV6PBu2/m2BVcB8PE9CdE7yccNPSvZfVoL?=
 =?us-ascii?Q?524fraapfeleoQ9XQRjwGW/dl3dutEE5UORJHE2eTdIw/AdsFQRfqmLWmAVm?=
 =?us-ascii?Q?C3qa6MsM1/d1vQ1A/0o/AG7vribDJfP57qq//XZlRwB75jB/FAO2wJD/Nsny?=
 =?us-ascii?Q?HTmIuOEdgXhUE+DkeC9WATnhga1HzOnWx0jLy9ARQ1/D2wLmwcUqPvUfCVFb?=
 =?us-ascii?Q?gD+9QYyisR2noE4ZkyOSlj4tFnnD2FbzcoZK4Om/SXBt1KRmjhuXWIoLfGg+?=
 =?us-ascii?Q?ix1j9yRbOXC+HkTrFctkhjfuRxppfz5ocgeYds3Isd6z7W4j+HRD9Qt1+1Bv?=
 =?us-ascii?Q?yK0ON0aBz0nX7/yy3GfrxxtZkuoczReJgrNzSuH/5vaczsi6GJs494+dWpNh?=
 =?us-ascii?Q?aEZHJMXXOhsDclmNL0uJksYeZydjT0Y29xLcKjPKPAGPTCSmExD5j1h9iR0E?=
 =?us-ascii?Q?3pNmV57Kigw5XXJ6Efzp8LMac0uAM2fkJi5Gxtf97lyfR71oBfFBmuw9ndKv?=
 =?us-ascii?Q?5V/X5qcAZ6v2AD7Ub4CLD6eojHwsgzZglM5VVAYPyyeE4v3mHTIWNPsutG5l?=
 =?us-ascii?Q?tBGhJK7meVWT0Lrv4Umk8dU1?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8794394e-e18f-43b3-63e5-08d8e2023427
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:17:16.4334 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/v8yAD6kSXWlM9nvWPmVLJqAJUj5sQsarxQlzyR9xWwlzYzuG0pRZReDx2PTBCy2ojwpsub29zOYTxOIeTdKF3C1SHhUETH9QF8CcB41Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_071720_839759_F0CA2905 
X-CRM114-Status: GOOD (  12.15  )
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

On 3/5/21 16:36, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
>
> Add a msg() macro that allows more flexible customization of logging
> both at build time and at run time. Allow several log levels, using
> the well-known standard sylog levels. Also optionally allow printing
> of log timestamps.
>
> Put '#define LOG_FUNCNAME' before '#include "util/log.h"' to enable printing
> the name of the calling function before the log message.
>
> Use this functionality in the fabrics code for now, wherever fprintf(stderr, ...)
> had been used.
>
> No functional change except changing the output channel of 554db7d ("print
> device name when creating a persistent device") from stdout to stderr.
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
