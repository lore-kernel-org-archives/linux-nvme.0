Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D658EC43461
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:42:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DAD0610C8
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAD0610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Yd21eOp49aa43ZdrkBV+Ki5kNydu/hLzXdk2oE7ewDg=; b=FKHwZBKJttZgRAo3y4Wb0wBeo
	Ugd12WQIzw0B2+tKG66EMfdYJw3ynCHT0Imh3NHYENDASHq/+D+NCufCNKDwJXCT505iLuAd0ttrL
	sH8ZNLHP5Nepabo+JJ5lGXFsTKBgGv2zAnKmxVfWH7atZ0bABaCYd4hdqclvZNr2nnxBjULKa0L/W
	FrsWyZflnUzFxEnDtA2VzhhHekZVdeRR5Iu9Aj5vvshPlZTd8+ToI9jdjBs3GXEeMxL7brCUiwU/K
	GDuDmikArz/GYzs/x8igXcEdzsyEuaLgrPmTuErTjTCGpnYXX9QBncrw94JNoU9ZEzF2bdWP8Bffn
	5aylJGT2w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUh6S-009kEG-4J; Fri, 09 Apr 2021 02:42:36 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUh6M-009kCp-TE
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 02:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617936150; x=1649472150;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=mWqmpEDiwdqVB2hRZnA8rLB4vvLHr93/LVR5LnvBkRg=;
 b=gNFKrR27V3ZnLjJuj9VNzbbOr2u257lZz1V3waCaatRTr7zQscCBOY4Z
 Pb0D3M9chsEf8dQO4cElL1u+aBGu2dQV+sfOajHGaku5Iv84B+2T85rPp
 C/UdB9efucFqlimD3Tj5j++G9LzOzEgfPH/HzxNjXqOTKF0yy7Vqtoi+k
 ZYI71wr+axq5JTiAw1bNkR+zK2NarOVwkDSZA97p/5Ew2jPsitnEHDqQX
 d6TtMMZZPM9/i6DGtYJsbdBswIbpqsJZHJ1qW/xusC6o12KdaX2hLBY9z
 3dygxYc+hAzAeFAD6N9AsC/cEPmMZI2X0KGq/gdQmBY3LK06z5ClqpuUF g==;
IronPort-SDR: GGFhIY8HhXoofmQ99d6YDrLnSKzxnUj9aZLAhqAgZWii9iKrP7iJxxMexBXAQ51O5NNQHSEJYU
 DbY6/gIRPu3N4Hny1aOFLArOlGZQXyXvthoXc7TKTHPSAyIOVUNQtcF9C8Fk+V+3rrLPVC0BEA
 mFlCog0hEFfYUwyCc1MntI+x63hKLzXvPuHDDArX8k7H3hu22DTFiWPbe8IrdVotOxmKGcCCVq
 kLsz438ZPIFnPoypLMZILxCnfpsx0JkjR8s4gJ4/Cq3etmE6WJmbcwTbWoaXlWdTxLw6hFcAGg
 ZUk=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="275126961"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 10:42:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxVCj1M+VbrMldgpTOwBbtIAVNGQbQGjWK1f2nkNXsJN3JLnlLbsRbzv2W4gg8oZPE6KW75WP3nn7GR95MaXKyrWDn1PcZfP17fJ/HqdN7T0E33pw8q1zmMXTc03ijcKM0fFhTLfD1U1EopLP3dqpNcc1hAHDmc7N1IkgdOilm+mWx4mkE1KZV590ICB1KT1VBgXr+H82+gENeI6dTmgbYAbiIrANmCP4hQYBwyGnThWfJNqHaulJFtsHLg3b3UigDoR7Z5oFfiUmfGUDAXZO/lgPFDBW0DknPxA/31u5scf7VFBuTGYsG2bvFIZEDasfYAHrmQ6fsgRHlTZAHs9bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZIYZZxJDiwYszxMhADbt6m6TlZ8CBaUcRMhcBd4lOE=;
 b=WcuXTrKyjQC0DiCMXW24DsWSDUqoNjDDgAnDJIYEx/rntjESx/8Qwltdsk9jkV+aGGXgbg0AqqATSMZniR0ZI5088M4wY7kI2UNF2T00tFoGphadQvdbBaGGQ7heuJHoHJnXsqhm5elfC4rB9QnHiw2LxbLnHsMpcDh7dSaP236qQzldPc9qNKEDH77dC9giJYC/6tcrXSO1R7YmCDHRJkArgUuS0t9K8n5yL3yRTe4DsgmNrviB26dd/3WqssT6HMjl4FNJ0JiQ4uNYCOIx/2qGgliV0Sm8u5OHBVyT4Rt870dN3WGJ2oyOhgqiB7uJipK4d7S/iLST/x8Q/wdf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZIYZZxJDiwYszxMhADbt6m6TlZ8CBaUcRMhcBd4lOE=;
 b=cnLFH0fJp3jNlPZUOCZRdEaQyaJu5mJLO8irR4VrazHw3mPNhdioBjaYR80nK7Sdt6hbgrDpzptA6gJVKooFPser9/r+o/ARbaKkgJKhvog3+C+/wni9VvpdBxSp+NMztzfD7tPkCOx8rhLYE/zhttrLtNhBE/8yaWb/J9hgCbc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7025.namprd04.prod.outlook.com (2603:10b6:a03:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 02:42:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 02:42:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Kanchan Joshi <joshiiitr@gmail.com>, Javier Gonz??lez
 <javier.gonz@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 05/13] nvme: simplify the compat ioctl handling
Thread-Topic: [PATCH 05/13] nvme: simplify the compat ioctl handling
Thread-Index: AQHXLHM0yckifElQOkGuvqHXr7gNzQ==
Date: Fri, 9 Apr 2021 02:42:25 +0000
Message-ID: <BYAPR04MB4965C75B6A8773481B59810A86739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0053c867-59d1-4156-7e64-08d8fb011c46
x-ms-traffictypediagnostic: BY5PR04MB7025:
x-microsoft-antispam-prvs: <BY5PR04MB7025B1DB85541BB43E28503F86739@BY5PR04MB7025.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yLpM0XDTmbAMRRM5NdDXzalQLZtVEqiQ3LpMsuBPRtImHU8EXWvl0urg2dLV6PGm7VmhdmcUb/E/tpL03cm0w/GdPmPQqp+BGJAAAkqf0g9Z9lyEJtQ+LE9wSmesTiYaqOQPeYObUsJQ710SBRVwOUsb2+DX9boKm4NNxTE3kMqp4b3w2rI7EUuV2Kl4wJltb2M4+VQfCrxQqzXlRolkzu3H6CNa7p9YRsQhn2wX5vxm9U+aBr3CuHH8wouRTk4LNWx8OuCEKyxBBXvxWO3b7PrkqsRNuE2uk+9AYMNXP2d22+mvQx/LWcDfUjHJCVClIIhSKLSJUI3kCLsrEJG0N1QGcpbjf3/6FO1umZ3mtPV0Zzb3ZKF1PKYCY3i9LdPc2alqS7o+ekKzsYtV7VdvbJ0ErRvICMFZGiUF4uIhspi1usCbHRkIyRFJvUwoRpH/RJiLUQVwojXk3VTF6hJeJJ/HnzEG701CfoeJ1iR7CEEXKBN1fgh0pwK+k27NFV+t1flwFNzbasQu/HXQu7H1pDn4dbcgcz0G5f/szJrAvrnAbZt/afuqmlbswZR2Isa08x8OMSH9GW4vcfytwOL4P044zAByKF4FJSQ2H0b+2kCw84S0ah86MawFLG7PKeqxiK/8LrK5+oSXpIZhQSRF2cKE/U3zi09yWwCrcyD/OSo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(9686003)(55016002)(558084003)(2906002)(316002)(53546011)(5660300002)(110136005)(33656002)(4326008)(66476007)(71200400001)(8676002)(7696005)(64756008)(66446008)(76116006)(478600001)(86362001)(6506007)(66946007)(186003)(38100700001)(8936002)(26005)(54906003)(52536014)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DUlpkaRU6ShIwos/mGLNuynR2f17DOWhuZUM9uj7qg1Tu+2YEhsK/6r5fqgY?=
 =?us-ascii?Q?XL7Vjz2v7iQhfc6lLa6FcYQoWfVyQ6G78OgIOugN/SwG6mXihqGw23VOXjqW?=
 =?us-ascii?Q?YqCNl1H8ldiSOUM9wxFSQmP2V0fSTs6J280w3N//jl60QJpDaCUMMOGHiSEM?=
 =?us-ascii?Q?rSSiV2YQt0DzAQtog01moR7TlRA9uoNQcwc+dzfu+Nr4HN1SZLU9OZ0mBfsQ?=
 =?us-ascii?Q?8XEjSqcyhulWI++iUDJBQ/XOlH50ka9h07WwRrMwMdyeDyka3h7eQ18XnMFA?=
 =?us-ascii?Q?AdvZegiNMPcCWjFJW7nLRsBYHx1F6kQbspS2A3SHMubW1uuKEvw2h0GE2b11?=
 =?us-ascii?Q?mXn35kUnTHj5DtInUbLh73YCGvqBMSI8TBYHJ+Hl4R5XuotjuTwVTmKGv1L3?=
 =?us-ascii?Q?k+awXDYwL/8fRa+VPqBsqF6VovRPu4PPW7Z0hKRKh9GEl4QfCLuwxB5tiiWh?=
 =?us-ascii?Q?u9IpGB9OUIZD0XzViGOQWm1SHFveaRzjuA/BGH8e3KYr+kzJfynne6zkI7jy?=
 =?us-ascii?Q?x71ZXWKTkbzfZeKMNfqbYmqeXfgzianTkJbzGIoSa8bGcJAqeDwr/9CPI3KS?=
 =?us-ascii?Q?cJEyc9w9V263+e+zgFZHVCQa7dq94bRxAz3jIrki/o6cLdC17o+g+cZ5FRNB?=
 =?us-ascii?Q?6lwaZN+8dqPHYuO2IdllJzKGx5E4FlegGFryiPW6sLP8cHT8QnFLSJycMCk/?=
 =?us-ascii?Q?MvOQ6PAT/lhGsQerh22bpM6DmOf+LceY/3fmpwWoHQauNWfYB8T9ELmvw1UW?=
 =?us-ascii?Q?NlYIYWYOvqEtSJ2FLX3Bn9DhlSsIkaj4Kp9kvm5+JO+470+uuryBrAMTvs1d?=
 =?us-ascii?Q?ZJHCaUvv3x0UEeSGcudTlVuPyl8HSQpOXJqv78qX6tovGgnYnvY44oM/7KKe?=
 =?us-ascii?Q?NjL6u4rjJIM2Strju6ucEasrHktw/LDzbCAbd1hq9/dmEl5U5856fq7x3xjz?=
 =?us-ascii?Q?bcCBq5YH8DYtzxR44OiUJodUM1g4Nvs/864gyNvAVYJruBUdea7kYsrk9Chn?=
 =?us-ascii?Q?z6F1GoZDNZJVU31zqJQCemt82OfzcxYnjTmrLYdMutaI+nnTNutlym83GI+4?=
 =?us-ascii?Q?VILSR/AyRPkXmeXhqtHzdaenpp0fKxgE2xsh3aFioghW1fhMVM4xigUxz6i1?=
 =?us-ascii?Q?1Hs7lwWmwI100AqaU6AKX9++FSFetKgdxVGhfkBO3GwDjuoE/p1JwCm4JDmS?=
 =?us-ascii?Q?/2uyu8FAv+Dpk34DDp+dTV3kpvpoRcm77rTXi3b8ewPBITPt3X+XZb51RwUW?=
 =?us-ascii?Q?fVu863PRz1UOw+WwM+EGKk+W4+CqHcvo97VNL/V1EqHgx9bbs36CG7hTq3gk?=
 =?us-ascii?Q?PO2xrRLP+azrO7Bdn1Uz10wwmZFBXqAiUJYkDWZQHe2MFw=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0053c867-59d1-4156-7e64-08d8fb011c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:42:25.9656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/9xHIQrFT2nlk9gT0QjWR3UO6wKmIemlCbbhHdBKyW4zjZYar+kO/espEBQfe9EHDVSho6zPVOBt8bDc4RUSgR32YyuAI+rj4gaocpYsPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_034231_635217_871FEE68 
X-CRM114-Status: UNSURE (   9.96  )
X-CRM114-Notice: Please train this message.
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

On 4/8/21 05:32, Christoph Hellwig wrote:
> +	 * struct nvme_user_io can has different padding on some 32-bit ABIs.

s/can has/can have/ ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
