Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40CAC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 22:19:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4227064FE4
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 22:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4227064FE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=qMi4QqxCDSHfakdlHGJizJ4MwyMtdzG8Azu9ywLLW6E=; b=GU3vy5ADqDsbddjYa1QGL7CzW
	wPDTwcb2bobDxU1Ns+tMgkMhRBtKKcn38WBUlVJPZ1RjViraSfeSIHZSaOHb4ajSG0JNg9a534ow2
	/cBkawgSGwloah/prE1XnQ+A5uzf0rEl47p2ik/8qVbRoedXKQqJTns3iimfpV+Y4upBC/1QVNGJ4
	HHW8y4bzAJ1ANx+MOdCtHdot8p1V2++NC/M7IgD8ickrXCTSAJ18C1yd8YMdI1ghQgnYBxWqK85EA
	U/e6fFTGfR377cBWEUyZh5HynrD8UX8b9GZFKGs4qC+uaix0VvLoAyIh8Gb+6FZR8/JpuhkfCrCND
	ecoP66XyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHwJm-00AQRm-86; Thu, 04 Mar 2021 22:19:38 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHwJb-00AQPL-Ul
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 22:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614896368; x=1646432368;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=VGCqWcWrH0Wo04SoSxKiWttEXhPrjShoqFA0p/ReNmY=;
 b=Q28USUedihzuqtWcIV0ZMZ0uUnS7KAcAXUl5ZVLkgggpKu2gWYdjlwML
 /2OEMJT4AFDwsujJ+KRQptbUqgrNahTcgew09SZXKHaMbGSgjVhwlQmE6
 5S+l/Q3E2Ge2KGx6M3/c44X99RyicUtih+Aj0oJ++yDF6X5ll5ZaIY4pm
 5KuFK4nCZ2NNTEJPySBJun4db/z1Ul5Aok2HRdZ/mOCReIeA8IgfqDtEU
 ZAz0RwnA3D72mCWa8v0IWDT6rG/yij734l74N2mBh6P2nHff75+Jy7KNy
 AhdbKRFUYhk41keHkRR/0W93L+UWGDECCygidIt+vROF+30E5ObBcltZC Q==;
IronPort-SDR: FfuAsU4Awd4n65/b2LtMxQNu1mjOBJ1DPVlsbbuEjN4AQqQMfuCCfJgmeOw1AIa+q0jmQ/I5s0
 fJtT/yzQEw6S4dxdJQMz8jF9O8oF9ef852ZdvcRDj0PhBsMIQOr/Cbv1NdXurgfgD8Chko3Eic
 qhb9rVkHKNR1awA1LngUazm2IVbK8JDY+Oa6/mbIZKgz5s7cWAWblYU2zOQQycr6KcM4nGJ/e7
 OgG30PiXcxNyl0MSI8hwLLhKqb33fCr/NBYkK4EKmuYF2WfA0WzMtPqaOVXEVyS1TgTNgeR0bd
 e1w=
X-IronPort-AV: E=Sophos;i="5.81,223,1610380800"; d="scan'208";a="162559244"
Received: from mail-dm3nam07lp2049.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.49])
 by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2021 06:19:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3XfybvrA8nE2N7/5FZOM8j5+ZW1oS3bXpb9vuqMysVzQcpkJf+Cch8RvcPKcdR4WJ+fkiAttlJZuGfcAvMZGV8DlYd8MEGgLka70OxZ9woUzAMxGEOkxCi/fHnWHfELHiZEXorsxLNE53hLVN9WVSlszQJN0qAH3Qp3jSo42xnzQIZrHata+MujH95DTiNt1cHJd8qoLeCWsohgLje6K3FwyPeg6v6l7WtpStFEmuX1uqeK7Q5ayu24n8dhkaqbcn11NiPcunrOaArzAiFmAT9tBs8JcIThz7Baal+NHzDvGDwex21cx3Ieg/GtC4uIoj6OU7uIzBAnHIBtaUl2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGCqWcWrH0Wo04SoSxKiWttEXhPrjShoqFA0p/ReNmY=;
 b=C77RYEro07ghBMWPRgpp4eYz0vMXqVQ+SbYL6h89bK/6OvGJFLhBXuQC9eQlBlK6AoupeXsZy49BGh+ek/J/DY8N3h5VvfrDJ4J9lc7henKPcP6BUH+X+6uRTnlXFQ6hRn3vE7cz4Q/Tfy+uP/IMTP3VRXJwz0+MiD56MEXB4MZUomDAL3eCvXgg6sTrK0QST1s5DutFRvbrcfF5XmdPW12k9Z0qCAhs/k2Nrf345l921PseDXpleVBj+FzWNFZIzmaL1uM5uxqLt8Frq+8vS4SO7uX7JwhTbbK34x24Jve1yDR0jvmjnnQKc/vaHvJ+FQQcPYPXUC447DwEZqPOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGCqWcWrH0Wo04SoSxKiWttEXhPrjShoqFA0p/ReNmY=;
 b=emMsmDZPDaUBRewGLM1B3fP08B5Gy0mbY4CUDiY3ftDYq61gVSW0eKubW336Wbt5AQq0XwPg1xPRfosxyS/6Ln+LgbSB93pAo3zCSQTK0RezXL9pChUZWsFet8xavRcwxBXQeLJX8yKfyUjoCnmg0bpOLDaFvUDJkNTB5vjYsPc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4663.namprd04.prod.outlook.com (2603:10b6:a03:58::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 22:19:13 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.031; Thu, 4 Mar 2021
 22:19:13 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>
CC: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Switch to using the new API kobj_to_dev()
Thread-Topic: [PATCH] nvme: Switch to using the new API kobj_to_dev()
Thread-Index: AQHXENz14KJTiaaWk0CSO5RqL5M4nQ==
Date: Thu, 4 Mar 2021 22:19:13 +0000
Message-ID: <BYAPR04MB49659C667C427F1624EA4E4C86979@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1614850889-68174-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d05d2ddb-f6ba-4085-e989-08d8df5b8aae
x-ms-traffictypediagnostic: BYAPR04MB4663:
x-microsoft-antispam-prvs: <BYAPR04MB466313EF542A20AF2AF40E7786979@BYAPR04MB4663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iuye0NzBPgHyy0lSy8zkPfNgdDDu4Q/CZyxi39akr1QkAqBeFWezWK1HzYtHybNJjKkG0dlClYeAa39RCkz9kI34cMSOUXEwZO0rfvP5bMPdOn9iYJQJDOGi2m6diWat4unft4vmI1DkSjnjOloEvKdwaZptG9MicJdPaWpKJOaGuXsWyrDRZwAGnwvBEcpQGCnVseq6EKjXLntvZK3fME/tS60yT1LRfSjsHT9A4atn1QKx1wpXcbAav/zOXrtAFeXyQvO9JFywf/wh6Jvn/rfdkQjchBiMw7Jx6BMvcUrlTW66uIEPxbEZoVaqPJWrgn8kH/2wpwaytGog4aGAzWk1M+X4PvL1xkAJIxGJpwzSYeFHnB2crfR57LfCd4NfSTAd2PM7tCMKjRvtLArVO3c64MWQ5RqtHTn7WO+AZYnrM+8X/6p+owhwQRqT5f/uXJlasgSi/GifTTqwLpeNQOl1lZyZCFO45dh5trnzyzzmtAbE5Q8W3728roP+tvDfUzF/YWa+yS7gc3fBGEp7/w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(66476007)(66446008)(66946007)(64756008)(86362001)(33656002)(316002)(66556008)(71200400001)(53546011)(186003)(26005)(54906003)(76116006)(55016002)(91956017)(6506007)(7696005)(110136005)(9686003)(8936002)(8676002)(4326008)(478600001)(5660300002)(83380400001)(4744005)(2906002)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m40pPUnQ9BOC07a4fCCcxuawhuxg1PgABe2R1MxeN6aBGkBR8hAbjBs9BGoq?=
 =?us-ascii?Q?aq/ENsUJKQal6cPbUDr1qKeLLWpNm0n0n1ZGV/6nXJk8V7B9FnRY+w5wH33G?=
 =?us-ascii?Q?tLfHgtyqV8PD9UB+Ux/P9BqbDOxBSqKBXMYISe2gm1ezus6f8KJ+p2RpTPVU?=
 =?us-ascii?Q?sQov7GpMmjaXsPAC73kiXiUbMot5Sz2GTpLyuQGOulBG+f7jDpnRtVmlkxc6?=
 =?us-ascii?Q?TsNFZUb4R68JlJQrmXvIKFyoeMeSFaQlMLA/A0LGvR9kMZ3jE14E8EMXU+Dt?=
 =?us-ascii?Q?IDPBXPigMB+kky4NvFA1P/j4dFyRVOtbHk3ManS8hWsALw30itZvDp5FSAKA?=
 =?us-ascii?Q?YWW8+dB6oD+3Sgm1UhbUGQGKezXQCeaabSXyXe75yve7LrF4tO/nUemwfirQ?=
 =?us-ascii?Q?M2i3luCYDm8mF2NFX7Oljl7+epOc1JOPK5Y/X4R5ez6Z21nfkLGqUIIYO/fD?=
 =?us-ascii?Q?Gh6nM7vArbMJuX2K744iWqhe8j2i/bmPGwIernUWOOmtORkP1TcrTJUqp7qH?=
 =?us-ascii?Q?rqMBLa++S3FHPu0nilFjN0dU0XnyBH2XfpTxtUpcu4DhQkuhh54WJx1zITnP?=
 =?us-ascii?Q?jJRrzC0YoaeX9VsztKaJDNqZuHK634AUMFgZTP/2xyJDSy2wfmARPN6xToOi?=
 =?us-ascii?Q?2DHmVh+mT9qHx5elmM8L3pCzVCrcthtsQ9MxavT2feJcBwks3fFx2PmGtBRV?=
 =?us-ascii?Q?0kKICyo25RznG5OQlOsqiSql3vpz2192oVtKDIYmPmWXPFep7JdUcNuoz4ok?=
 =?us-ascii?Q?XzUAHTb2t1gBdz5gzRI3nY/7vF8FRrsRDdfU70jI7XiVTiN7PsFVHoHrnViI?=
 =?us-ascii?Q?s5LE0Q7XkQZM3VXJXxRaxMX8IgXNdTmPTLxFihjAJizY4nD9KF8iwk7nrLoE?=
 =?us-ascii?Q?RlThF3JHOBT0xWWGLkN1zXqzIqzZ/xDeORXp1CiA9PvdveIi1OTdCH5G0xqh?=
 =?us-ascii?Q?pWoQg8g1scVHE7P8EN2z8nfnB6yyk+1xkHNTTGE69qomyVp51Hvv3doW5gI5?=
 =?us-ascii?Q?Bmog2pjMvpBK5S77sO5DiCnl1gL9mSxkGBdlffiUhBji1unDkGme+eLiUEtf?=
 =?us-ascii?Q?HpgmnkE0HdCyO32qSr0Z6XZK/wSJeGLs7oEXwQ59dfao5FN1Aecv3o/1J/gC?=
 =?us-ascii?Q?jIodzBHNJTWeU9T0surY1Sa7usffY4YDnIcdS+a5ACmXnE5yZXnjdkJM+Q28?=
 =?us-ascii?Q?f+Uh5HhcfaqeRQ1HGUZRCGbiUAI83B4qipyiJKJD/laJQJWaNIbZMCcoYpb9?=
 =?us-ascii?Q?uKQGUW55Q+BXrTKEKuSESFJdWjNXy4+FgUt9EV2AxBb0UUMYn7ZWgpY5cwe7?=
 =?us-ascii?Q?WaLbLWz+UER4xSlln/xW0WLI?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05d2ddb-f6ba-4085-e989-08d8df5b8aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 22:19:13.3632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CL3oQu4vGAoqR6a711/mssPkr+yQ0bieOPRJEbNOEcEOz/Y6Ca6otHmx9hKaszNmqYVYN6L57+Yilik68keBUV5cLxL0A522FKd86RJDZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4663
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

On 3/4/21 01:58, Jiapeng Chong wrote:
> Fix the following coccicheck warnings:
>
> ./drivers/nvme/host/core.c:3714:60-61: WARNING opportunity for
> kobj_to_dev().
>
> ./drivers/nvme/host/core.c:3475:60-61: WARNING opportunity for
> kobj_to_dev().
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
This patch is already NACKED.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
