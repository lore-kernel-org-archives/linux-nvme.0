Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB21C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 12:01:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1723160BD3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 12:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1723160BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c+/IQzOt51ca/bq1VdOs+NmQJwoJ0NIdHRu7vk5lZGo=; b=M0tJTCig+HqTvA
	0CUcEPIAiE05O7exRMeRzs6uefp66e8Io1tmoui2PbfF+4VZ1pkrRAvHbcJpLmDeT8HhcXoC4vgXb
	4tzZ3nyZCNlqOXtu8fNxIxOliSpE5JCh8qSx4OafqjDcymk8B55Wn517yvRVexfeRtRJDxjsZ4g1w
	OLblpt37bNvCiK2FTPDObvUKDQVQGe/Cm2rYFyrZ3EqOJrPn4s+szwwvJwsql/OGypIQh+mCVRLrf
	DMwl+izMPNfUzC/H4TamQF/z+rfxSU5MGfB3jh0cstzlYum297PQq0nMAR2LcecWzJ4Xlwvf/ckGR
	Os/sCKP8gmP8R/W+gbYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD3xb-000RWg-7q; Mon, 09 Aug 2021 12:00:51 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD3xX-000RWF-Hx
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 12:00:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1628510447; x=1660046447;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=NBtsivjeXfNJ6xOzuuHQNemAcVR9FpDZBeCOrcozGlQ=;
 b=Jnm+630Ob/AA4e+IWUS1YSmDdgRLsGsOptNTOcVIGUIlmKzrJ66Jmt3a
 zJQjH3/YWbVlczRsgxVWckPCUfhbW/+vzV6TKfVnvzNOPhPSqN5der0EK
 7UtN3STEamo8qholbO01DTZ/9bJseS1pj89hfzkbPZNGbFnxeht+AxV5m
 LoTxnq+l97YjNZO+T8Y549CutE3Xa4rpP5088Jll0UoxnNx0PR3AY5PQf
 RaXE0quVguLxLvzyvLy9aNxdYQq5tY2/joHnRV3EyihVSEC9Q/M3OPB/A
 OZuSaIAboWLC+yEbaFE0/hPj5G0jmfQccsCizREEsYB0JRA4CGDb3AUS4 w==;
X-IronPort-AV: E=Sophos;i="5.84,307,1620662400"; d="scan'208";a="181491548"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
 by ob1.hgst.iphmx.com with ESMTP; 09 Aug 2021 20:00:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIhp/oT9Si4v4IDjYEQ4H0MYamuEQYej4JqQcZvledfFs3XmiiT5KBgRWnlAn+sKFi4JTdjNzrxVIt06LMhYFPDyBe3XR6/e7z0KggV5uY5bnJ4MTNh9szvAQtQhCf4hjuB9Noyi1U9/iRAHJEfd0WIuv1QQZRfF09HsNqZGNfCq20ha59qIRd4AXh4yn4KbrPpCluMUKHEOVkupg2lxnMVhT19vLt4VpvA5BipbPQ5cwdTn2u1XTfOoYf49/bE5UB7WE9W5g9/RDylxDdU4pTvhLoGw/FkLP5QClmlfDruslisLZhIKBF+GD3VfOiK0DSbjvozhh5JZgaJI7018xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+YlgNSbg1MgmZ2FTMrtdkZ1Q97ItYtpsLG0urHHzaU=;
 b=atpyo5L7NkGRlfBbyGQbfRmmnppqki69K+BXS1rsXt+pDpwtVAHfGxYQ5jaMRXjTOhm2lNaSTRl3YV7uYV2PsUbSAqlArdgaGUsMxFUfjhS/GhYYOB0PvkfJ6zfSRP5gVsT9wtTLXSXyeZf1tLuR1QuSL7cDU8ro6LqNSbjkMP2ZA9y6Lj18SOLo9T0y4JkjdIzwapis8TD6tK85QzmHGdVusZR59R8UPTpYJy/lfJ7XYHnDDMkDg5cgH/c0HMJWcmOtP+QVwaor8ho1BLWA7XMvfGwfaRrFYf7Ty8lP4OwbfPwUpxxaHbFPnMWkQhBl5SwonBfuH+vuhVYKYRixMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+YlgNSbg1MgmZ2FTMrtdkZ1Q97ItYtpsLG0urHHzaU=;
 b=SVp7iqFMtq2llLzL+f78rZuh94oi6gBtlwphlZdBpKDNiUyUUemRiTPrCpc9dswLuaxke+MTmsLwaXetZ1YlIe/ET/doVKBVlF45Ea6dqML9EaJ3/mij1z5PW45Pdx9T8uQykY6XntoAeUyzjy14a8aW7tVNENniBl44YVAnc8o=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7205.namprd04.prod.outlook.com (2603:10b6:510:13::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 12:00:41 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 12:00:41 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Sathyavathi M <sathya.m@samsung.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "jg123.choi@samsung.com" <jg123.choi@samsung.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>
Subject: Re: [PATCH] Formatted LBA SIZE[FLBAS]
Thread-Topic: [PATCH] Formatted LBA SIZE[FLBAS]
Thread-Index: AQHXjRYsCRs5e3HGGkyi7i8hc078OQ==
Date: Mon, 9 Aug 2021 12:00:41 +0000
Message-ID: <YREY6HBbaBebK8Th@x1-carbon>
References: <CGME20210803061146epcas5p4c8970e93f59edec1d2293f8c6b4d4cb9@epcas5p4.samsung.com>
 <1627968552-32502-1-git-send-email-sathya.m@samsung.com>
In-Reply-To: <1627968552-32502-1-git-send-email-sathya.m@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 166cdc12-277c-4825-e32d-08d95b2d4f94
x-ms-traffictypediagnostic: PH0PR04MB7205:
x-microsoft-antispam-prvs: <PH0PR04MB7205A3535A6047F2144B6BCEF2F69@PH0PR04MB7205.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StXTb8SQAEMIqcNjy6hEwrBjNltbR29ki2Vt1MWlcu/6ie22v71v2+su1NvFMsEZlh/vzk9w35+CVqQsIp5wV0MsmNqlBTlOU/Lic2jp+drUJV7T+ZcKM/HGFRtwOicuNYP0e+N4n4PuVBSSa7jlSe5V/kV4MLXT7+NcuS0wiFUbc0r21nzYK3/OR/oYId45diuiK3Fb8Q0K2jYtcQhklTblZMsFL59B/Qs3z9pgIQeOnqmpXiJA6orus8A6tFun0xhjqkbrNlGCSvR0gjwPYx/jYJi/Z/nrV5LzrtyK1oyQgQYVMGx+jEvijZ64siX/IYkUlBh6UgdiyhRvV2qoX8coD6XicRh2u7qMRbLLprVKAfUe49dCXIICVTl+Ih4AGGYGAyZvhI6PDRvMwJ+LGhVQDfNb7dkXBsvltMUVztY1jZXEScdKQyVJXxBDZyOzIj41dhXIlpIHZp7f8rfHalMTnl794sDI/3qzbeO6yGA622mVBOxZh9+ZOKkNNhVpaZanCyy75oFjOP8DmPof4OSEkV4hWgBRLklTyTwV/TcVFUIkpUeKTdXpYo+MPBGz/8Y5GqwXftNcFBfRsVBW1Et80oujeTO8A8ZQ5EjwCRORaOJC6OXKsfvX1+oR95y7itImprez2uostDyz5IrjHSbJi9AFqkGx4QyaD8dfK8/GIKLvmXbDzNLiuIjcSjHF+pKXkORzbJ8r9BnVTAI1kuvOjNA11umXoP+fdhw45q7jBnR2UldN5+V29BQvSVQRYm+DsgTASEDoh+S0e4r7UnptGs/YGoVmCptlDAGUQdc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(66446008)(9686003)(91956017)(33716001)(478600001)(64756008)(66476007)(66556008)(4326008)(6506007)(71200400001)(76116006)(38070700005)(6512007)(66946007)(2906002)(6486002)(86362001)(54906003)(966005)(186003)(8676002)(8936002)(316002)(6916009)(83380400001)(5660300002)(26005)(38100700002)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vP/CLV3MSFbcaO/e9jpghVae39s0qw4cMOMRnobU+loOgkRO/dF/euyzavhs?=
 =?us-ascii?Q?qNQLgLmiUSc+KxSodO6RW6R2teU0LbZ3NerOJi1fXzb61E0wXbvQHRMQojfc?=
 =?us-ascii?Q?qGhrmLHCFYY5/n9ezHAd9ATm1+p5WIH2lFhz6b9XF6lBk/947xaa8B4SDzwT?=
 =?us-ascii?Q?RAacNRXs3g7jSVExOhCtc5wQspRm2FKvyTpS8klupFBSOe4ExqS3qtMjfoZp?=
 =?us-ascii?Q?Cbj5yqOMbDnf8LP39daufBhwrYtqQhzRrsW8UiJbFA0E+w6Wq2wwvVfaB5Pv?=
 =?us-ascii?Q?fMNpSXCIaskFY4eAyi1xmR2rRVZDlpMQZFxC5kq8QlCZkfRA701pdO0n+MBN?=
 =?us-ascii?Q?2j4Ua/0ofIkT82or5WkL0hizx4JHxthk10JmKXNEHFFpEmvEU3O94eejZaWW?=
 =?us-ascii?Q?/k89g0QEGdm7sxl7pIPXWVgdi2nzesK312x7pCEINkq7Vk0hnTt3mRS9pzCW?=
 =?us-ascii?Q?EApZDCoeXG9K2fPpO1pbCc6Z3xqR23f5oHrqwOZK0eCUBg+OgLM4Xjn5Ydh7?=
 =?us-ascii?Q?JKRaafawMawl7S/EFp7MeZAa93zfYh7geYChX5Xxyfs0VizQApkbagM0Y9KD?=
 =?us-ascii?Q?gmeMBROlo/HVMMc1v49tNAB2/15BBEg839a2DFks9v8Ju89byKwVcK0dVK0F?=
 =?us-ascii?Q?dVsWeOpsZNdyqK9ikqAqvsevCAk7eSrEOA2WrDIGyNuHwXOKgN0JHK8jWryQ?=
 =?us-ascii?Q?lFfkx7R6RCKfnbNu/+sv+rA48ncX2syccETIVfmTChVmHvjyqz9pmxQnIED2?=
 =?us-ascii?Q?5ok6EZd4Wf7W1VTLX7C/9mDe4wWxNnr1RcxmKe2V+7jPTnsFSLfO/uZP5RVY?=
 =?us-ascii?Q?S8KhGHbdU6rbrrC8AWxuG//WDkgqVhgmMC6/OnoY/wpD3BWeubLrq2xSwA5c?=
 =?us-ascii?Q?NE2vbB7PQcFJuUdel7SEdRfPj6Ea2hgnDBLg2ctEZ6JCKxh9wuwnWbgzYGY9?=
 =?us-ascii?Q?8H51gF+LXPCslZP7JalQx14nKFnNOVZcA3mB8ENRJaVPSKYUotxbXTah18Vg?=
 =?us-ascii?Q?I98I80Q9n6QsudQX0KmEF6uvMin3xTp8f+69W/axsqYU5dbkCvsOlOECJA45?=
 =?us-ascii?Q?ixZxNy6GbfGc7S6NW83yxO+Bfcm9T/wvdcK0Z+WgQCgTV0bfpjmLYeOWjbXD?=
 =?us-ascii?Q?sW7TdTbzkBEA5Wn8rZRzmIfayNqnjgblcdpVaL8Ti/o7Hs/VVnIkIEt921Qp?=
 =?us-ascii?Q?KFQ44JJGly5CZdB3RnJTN3ejFx4kd2NumBU+vi9o4OsBZxoc2LJ/b3jpmEt0?=
 =?us-ascii?Q?H+EsNpepXYz9v6xovi/GHLinha9wmaiTVb0mvHWF9+X4CjFAwpZMLznmR+NU?=
 =?us-ascii?Q?ORdO+LUiNUeDNc7C/8PJHcW3?=
x-ms-exchange-transport-forked: True
Content-ID: <3226D53067E02340B3526D3FC2957F14@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166cdc12-277c-4825-e32d-08d95b2d4f94
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 12:00:41.5045 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gRXy1xCKTeHKpSyVy1CAjyRPCnsiqw3pjG9mYi5cuSUw+eBCS1pN0ZjRRbsi8N7KKgZqjXRPB22TULxAvfaGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7205
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_050047_762325_8F4E93EA 
X-CRM114-Status: GOOD (  22.74  )
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

On Tue, Aug 03, 2021 at 10:59:12AM +0530, Sathyavathi M wrote:
> The NLBAF(number of LBA formats) support in older spec was 16, but the new spec says the LBA support can be extended to 64.
> The namespace data structure FLBAS(Formated LBA size) field bits have been changed to support more LBAF.
> 
> Signed-off-by: Sathyavathi M <sathya.m@samsung.com>
> Reviewed-by: Jaegyu Choi <jg123.choi@samsung.com>
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 11779be..49cca79 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1683,6 +1683,9 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
>  	struct nvme_ctrl *ctrl = ns->ctrl;
> +	unsigned ls_lbaf = id->flbas & NVME_NS_FLBAS_LBA_LSMASK;
> +	unsigned ms_lbaf = (id->flbas & NVME_NS_FLBAS_LBA_MSMASK) >> 1;
> +	unsigned lbaf = ms_lbaf | ls_lbaf;
>  
>  	/*
>  	 * The PI implementation requires the metadata size to be equal to the
> @@ -1855,7 +1858,9 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
>  
>  static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
> -	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
> +	unsigned ls_lbaf = id->flbas & NVME_NS_FLBAS_LBA_LSMASK;
> +	unsigned ms_lbaf = (id->flbas & NVME_NS_FLBAS_LBA_MSMASK) >> 1;
> +	unsigned lbaf = ms_lbaf | ls_lbaf;
>  	int ret;
>  
>  	blk_mq_freeze_queue(ns->disk->queue);
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b7c4c41..e64194a 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -376,7 +376,7 @@ struct nvme_id_ns {
>  	__le16			endgid;
>  	__u8			nguid[16];
>  	__u8			eui64[8];
> -	struct nvme_lbaf	lbaf[16];
> +	struct nvme_lbaf	lbaf[64];
>  	__u8			rsvd192[192];
>  	__u8			vs[3712];
>  };

Hello Sathyavathi,

Has this patch even been build tested?

I would expect the

BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
and
BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) != NVME_IDENTIFY_DATA_SIZE);

in drivers/nvme/host/core.c:_nvme_check_size() to fail with this patch.


Structs in NVMe usually have a fixed 4k size, therefore you cannot simply
add new fields without decreasing the number of reserved bytes accordingly.

In this specific case, the additional formats take up all the previously
reserved bytes, therefore you should have dropped the rsvd192 struct member
completely.

> @@ -395,7 +395,7 @@ struct nvme_id_ns_zns {
>  	__le32			rrl;
>  	__le32			frl;
>  	__u8			rsvd20[2796];
> -	struct nvme_zns_lbafe	lbafe[16];
> +	struct nvme_zns_lbafe	lbafe[64];
>  	__u8			rsvd3072[768];

Same thing here, rsvd3072 should be dropped completely.

Kind regards,
Niklas

>  	__u8			vs[256];
>  };
> @@ -454,7 +454,8 @@ enum {
>  	NVME_NS_FEAT_ATOMICS	= 1 << 1,
>  	NVME_NS_FEAT_IO_OPT	= 1 << 4,
>  	NVME_NS_ATTR_RO		= 1 << 0,
> -	NVME_NS_FLBAS_LBA_MASK	= 0xf,
> +	NVME_NS_FLBAS_LBA_LSMASK	= 0xf,
> +	NVME_NS_FLBAS_LBA_MSMASK	= 0x60,
>  	NVME_NS_FLBAS_META_EXT	= 0x10,
>  	NVME_NS_NMIC_SHARED	= 1 << 0,
>  	NVME_LBAF_RP_BEST	= 0,
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
