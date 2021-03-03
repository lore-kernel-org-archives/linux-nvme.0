Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8BDC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:47:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03161601FD
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03161601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=wrGLFQUlaElscIBJlMb0zPR4p79gTbRIeB4iYD0CEoU=; b=YuNzyHzz3DFsQ776GJm7LHhY/
	nIUe1ouMCaPlsbD2z9DlnP3uRCPJF2uxCy4DKltg/rldy6IejAs7d8PGKdOX4iTfulu4D4HuXx6CW
	bGpIrmVq898av+PKSNsH9lswBVC8Xq3HSYN1uPduOaGTr1RwGqyUL8LFLkIojALjmYSox8lzfC+Od
	Su5MG3dXDwIOsX4X6ilhhd7P7Fc7w39yzBDdykwVgg01F63mOQQPkmJoQejW/O9HNoPm0Ky3kgUXZ
	mCqsPMr4Wi4SqxrmXEbFx8TJ3kFS0nZX+tTdNKehF+My/4G+obBfxUeESReBVQlGzrJsfzY+xiB1Q
	KIjO2IkGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHVaw-005s4Q-AN; Wed, 03 Mar 2021 17:47:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSwQ-005Fot-Rh
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:57:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=1va4IOhXonFcEGmj7w2egSFXwWVUbcGqOus5axpYVNA=; b=Qt6O95IOaF8YRZMNVk4DtHx2G6
 RlRNL0vO/ReLo2062vnDm30Z2i/jTNjJlh108C5xW/stOHVxd53iKos1KYiTz1YUXzFO7CeA7Hsr0
 1GNcN5d1nKkZlZbQB9KYMiO3oTbbYVuH9CFc+s+2WxsT7uHDTB2S5TxVMQ5o9NhCW0bGMhUG8kidQ
 /vjMdg23ajILW6Q8/pbD3DnFXbgeB8hViI/kLVPnFIQUkyeqbB+JTxyuFNWaY+yleZkZgEor4qY8c
 nCLsXhm7sA5GHnDQh0rV8d825TNP5Z4j8fm+rK6ahT4fnPvpH7LfQBVaG32PRePi/h3Sqkb/Xsgcg
 va8ROxaw==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHM51-001hSs-Ox
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 07:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614757079; x=1646293079;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=KtNX4zQxYBes9VR9MMxq/a7vCn2DDEDYHlrWJ8n381Q=;
 b=pRM7gNxdwHPm/VDKwpOtCB5sgtiYLahc7XS8XYlBCf5fIBG0Ip430mSd
 gVhqUDzLhRTQvJohGR0vmAuGidBb2a2Kxk74iUZ4RkaPXKhYf6gJc3a4U
 auxXB74wmsGZWKyA8/cH+U2peTWdByERZPKSftxmaP1X3wCSdrpCOfwFx
 5XLA3kmJAl3btLIslQlwjXvBBUkrXlHW2BnBtxLAodF0P8IoySzRuHt2w
 0p+0vUT9kxQZfoB2gVvf8r0e7195C/HDiYYzYzsvvgT9FXTbTKAqRDywm
 btTP8cPw25/1OSmpohKvCl1hkvzsydEY1nVOCpleV+SlXLjkfzMU0G5XV Q==;
IronPort-SDR: HMOhM1N+kzQrtV0pbcMGeGE4HbHWPSQ8RGqA3LeCeUBGAbflBTtWGWfJJ43CHxnX3HC/iGNCAZ
 Id/I1phC60Y29yXMyMLkvWBQJtCMNk9HbmQgdPB8Ra15b5IJ4EzU/vukYnV0XfZk/461fBgwQ1
 ZZoIjDHzUrgvHZf7K4i6goiJ6qTb4GIF00Cl6gPajXK2rCjQMo7RVAZTLpH+s05Ei2xYLPONXc
 TReahe4PXEfWuRyt7liZvHn1GMgjixVuehYaPXVfmx5jcJ/0C1zswWsO9A58zFD4mrMdjQRVz1
 0bw=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; d="scan'208";a="165713554"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
 by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 15:37:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpYoJjjSOECVS3TeC05HvIZKC9S10MeA4plmkWWltp35Gw1UV2AVIpkUJhIGXwE/PoYzazNs3vylBZIKxxstG1m78N2WoYQ4fWUi4mLjeu08mkjo5X/k9a9Je3ei48/1fRDGI3tMPf48whFMS40H13W0U8ppTnf4704hUgZJAVgcfY8nnpndrJaAlx0Ick9VSsG3yPdB4zwO3MjINWa0Q+fiqUezlacN9eIgz6SJAlLMJhUfpIeWCaD7llJIQfTzy8RJuiW2WiOewn9mQ9QJAJtVg2TDCyeSPW4WQAV500Rcqr7qSbqC2Cgr6g83kvpExQAkheCIgluD6hCymLNwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1va4IOhXonFcEGmj7w2egSFXwWVUbcGqOus5axpYVNA=;
 b=lP0JVxuZPtDsJlNWzKTgTAqtj6czAik2s3aAZogzrsLnryDAM48XJceE7L6FtXDup6Js43kDqWFFirVzdX31jOG27Pqr32T1HeX2kxm5Llal6bLeH1axcxPTwsApB6yUHNEbrMF5VzSJ+XmcIFx22ZrG7bfekxFsat9OH+NLE9BP/YrpI9fs9BiADi6ocC3Mg71h55fnZAhubUBIwQZ81qi4xgJ/Hx63SEMyYV7bBE/9oqGMQzVHiKfY6DCypb6HKsOp+9l0vUFWAz2XhjZ9f5xw3iYx1hOhdkHMNfmNW07MsQF4pocfJPr/STSwLsTXV7bubDY3FdKge3ksP2fg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1va4IOhXonFcEGmj7w2egSFXwWVUbcGqOus5axpYVNA=;
 b=bLAvy8fqWFeMWpSr6S5jg3ScN7bRBswkblV1fWapVDIEeCz4Jbv43QC2BJ1Uvk14v8ijtPNSvC7ASUpL/2ds9zBSzZ1LTGy86JjFpMasP+KuyTnMQ/k8CO49n1aF0qAcv6I9PNVt9e8aF2X+BONdCHlAXrIyd8AH3KCGJtS9zR4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4870.namprd04.prod.outlook.com (2603:10b6:a03:4a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 07:37:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 07:37:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
CC: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>, "javier.gonz@samsung.com"
 <javier.gonz@samsung.com>
Subject: Re: [RFC 3/3] nvme: wire up support for async passthrough
Thread-Topic: [RFC 3/3] nvme: wire up support for async passthrough
Thread-Index: AQHXD/4Dj/1BYoXHfUas1RoZk+MM2w==
Date: Wed, 3 Mar 2021 07:37:41 +0000
Message-ID: <BYAPR04MB496576429799E7E0C29ED6CB86989@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161010epcas5p4da13d3f866ff4ed45c04fb82929d1c83@epcas5p4.samsung.com>
 <20210302160734.99610-4-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db8073f1-525a-4809-8104-08d8de173a52
x-ms-traffictypediagnostic: BYAPR04MB4870:
x-microsoft-antispam-prvs: <BYAPR04MB487030E9CBD8DF936C365E0C86989@BYAPR04MB4870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nK1v8u4bC1xDm/Qv7RuS2omXJaP4dMKgwsiyz7W9WOg+FVhA1KU5iabCnwfsCRGneS/slcVgcbDSelPoKpeFh0seIbk7mdBg4XxVDjjpDNIWDJEdOeZGhUQ+GwCfl+A1HnJBPa7s4ikX1A8ePdAvNkdKcHXAXqWwC6tFbehshd0HjdmoyFUPEnPtMkMoCdRJO4W136LHkzZLmm3D0ZPkJOhD24Yk6YIquILr1GrvvTzZtVvQRwZF/Mdhkg83fHOsWoXIigl4enKrkc4mAUzsVJ8oenXE4zoE/yZ1FgKlsel8wnISb/n8zoDNVyukSA0KEulzGNCsBLI+zy7H49EG2hX3OgkrxBP7/u9qsSUaEHZNMU/J7hehBH4UudvPP/qC5ELuZeTKGfKsdg7NH3beEMWyc4N2lPnjACOjzSFrPIfdeTCOG288zqUPdZm5K/LmpyR2H+9XYodDfWCzZNxJ+/0y6GjDHHv8HgTG+New6t5893U6EH1f5mYNn/AUf9leBJLVHKnidUs+pakpdR1UMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(5660300002)(4326008)(66556008)(66476007)(66946007)(66446008)(8936002)(83380400001)(33656002)(64756008)(4744005)(478600001)(2906002)(186003)(26005)(86362001)(71200400001)(54906003)(6506007)(7696005)(8676002)(53546011)(9686003)(316002)(52536014)(55016002)(76116006)(110136005)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?K8UZatwJBHRlvt6Vnu6MZQrgCoDTaFAHG6JmLNOPEZ5Jr8weEcvRcVBzIYbQ?=
 =?us-ascii?Q?Ck+tGk8Ofi8FF9yoj/M0Wfk7j5HdVCndtWXVlB2GwR0Sw/uqccYXGM3EbJkI?=
 =?us-ascii?Q?x6RfevIqVazJauQMsEM0DdXuPObszqdJMyfO5xR2eIv/FJuZZhPbwjxkYZ39?=
 =?us-ascii?Q?brILr6qIbwS6yOvq8H7E7mkMYVSP5iA3cSxXte+fG+8QcEdyTDJ3/fHs4CVU?=
 =?us-ascii?Q?JoDfjwXLKwNQo2nYGgxFeSP4qAbKPK1bqXamRHraahIDx6W2G3xuiqhyJjMr?=
 =?us-ascii?Q?unnRlCtAwnYIAWWa4bRQgJUAXd1MLHK/3IHFc4FumZMgef9FOi0jelGqCoOS?=
 =?us-ascii?Q?+ab22BO3MmLgPum2+Yn8wmbIvdqYDh2MIK2JY5hD6l22LfbMu2v7Uj6lqbCZ?=
 =?us-ascii?Q?Xn1zr9bSWa6+YdaHMz4H8Fem1Y5dAokOp1rqUpsKCRKwhAKROLaCtm5qIZkR?=
 =?us-ascii?Q?s0jSRk/pzkiW2fg4iNZu8XxmQLIKEgYQc95DvTRgd9HQuCMSK0eLve+dXzN+?=
 =?us-ascii?Q?sQYBgJuZAqs5c+7YbFVch8wHwrt2FRmUMdBJXEg0+nOAjO03XDem7kZwCafM?=
 =?us-ascii?Q?0IJarYLVsRRQeXuCZ0hW03VOeRrdP7kRTVMQr6xy0mZfS8bY+IMpcBL8vJcb?=
 =?us-ascii?Q?o7pWwnofMd9ID5qWD6IZTaBe+EejJM012uxASKi3CwoKK0tEiqOKTdm4NYDs?=
 =?us-ascii?Q?xNANZ/W25eub+3t5ep7wusQIvKyNKXFIqR88oZaJN9tOEm3uBSUYfd/yNLzr?=
 =?us-ascii?Q?hRsZANv+mU7cMfXGadPxSY3lzCScaeeqsjJqs4OmKGXOm90H0oXiujtbSSVF?=
 =?us-ascii?Q?okPmCsbUCsO4ZzLotWiBGq7kSIqD6SPlgNl6g99XmttJnyRVRHLnfEe27lo4?=
 =?us-ascii?Q?36yZrtEEK8lfB3R1yC/vJq4FDTTfOLLeRmxCw2o7wz4ODMoFR+X/GkzYHREr?=
 =?us-ascii?Q?z31muA2paQORCg/jsoIb5/5V6nz/pB0XK/GZFFQnI+biZm1ljQonZzFLpXdx?=
 =?us-ascii?Q?ha0EeYUGIqqrvsEQwjjr4rwkOSDzWDDI8meE+KFVFfqWMocMeE5a2GG55fPj?=
 =?us-ascii?Q?rpqbcu9s5MZEzaCDDyeo1R8sXIlt5T6vgT+vW5pYDnK66JH2hIjv1f4DYePp?=
 =?us-ascii?Q?djkjwJ1slMQUS4ljtZ+K9PbPc2d+zvUGL8nENpE3xMnfrPNIL2RlGpmRyxKM?=
 =?us-ascii?Q?jP5k6r4gBt1+jvjEpcrKOb7EQd4MF+BAKxINVvhFYOtoXe70VAz3ki5koNJL?=
 =?us-ascii?Q?JijrhIBYDqOp8G0szk6t3ZZ12VzS1Bad1tHcL8KaV7mNmqo6dmOZGvxaV7yd?=
 =?us-ascii?Q?5jMzExwPkji5nUXhbmcUYQuP?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8073f1-525a-4809-8104-08d8de173a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 07:37:41.5365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E++vM27AXCiR3qdZr0ECkwj5mAaw3Dohnb5Er8zHTtryX+DsFdrkmvQVX+1ueW7duphWLsyGvsrJ/JhH9EunL8U5X9drRAx0wW+e9q2lst8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_073800_358729_2375E991 
X-CRM114-Status: GOOD (  10.24  )
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

On 3/2/21 23:22, Kanchan Joshi wrote:
> +/*
> + * Convert integer values from ioctl structures to user pointers, silently
> + * ignoring the upper bits in the compat case to match behaviour of 32-bit
> + * kernels.
> + */
> +static void __user *nvme_to_user_ptr(uintptr_t ptrval)
> +{
> +	if (in_compat_syscall())
> +		ptrval = (compat_uptr_t)ptrval;
> +	return (void __user *)ptrval;
> +}
> +/*

Newline is missing from before above comment.

> + * This is carved within the block_uring_cmd, to avoid dynamic allocation.
> + * Care should be taken not to grow this beyond what is available.
> + */


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
