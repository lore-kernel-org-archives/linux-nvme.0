Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893A6C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:08:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24E864EE4
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24E864EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=g1pF69t6Y6uTmwyYKBU7ErTle0wWEYGLlg23oUfl+tA=; b=QU+li088XXu3PXz44ZIR1Udw/
	oCZEgROjr3DCTOBiBzFyjwW2mgzf1svB9J931gdWAvSMAPDGLH2ysDon6JfIcCY3qDltJ6Yg2U/dA
	t6xfqJe9j6EHRgegtjuRzEuQGfXdXtmZiZ+Sxhf0nDK43390Oc4LhavKVSTPQ20leMVC0aVWq5FJn
	uC/+Lk2sEvUV35xS30A4hUOhZ0QaVkZx979ffGmamkQ2Q88gYxcpgW3YiVcD41LgrrrS2pemzXpbY
	LIl3pHlHQfV6QAngtQ3u8O59nJXr1tbuQEA/OX2JSbHEum8JfC3VJ6OVXPJ104tn9qmIh8qRPJr0m
	itmP/a6hA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHVuf-005x1C-V5; Wed, 03 Mar 2021 18:07:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSyV-005GPj-W7
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=LML9dFmYNDfi1EYJPtgWMnHgM3u/u+tjeMaZGZTbrko=; b=Qj1XSLuwvGmRbOlncDv3S4ktz9
 Xn+GLO+ytZy96I6FOnFQ4sKjY0SOS2Er9iQvRpvcmvVynWkPi4WL7OLq2dJTeXxV8eMwdmjTvNXv8
 ste9XrL85vjt9qUBm5kzNXZKh1VRd81W1w3cZUfjVa/qGV5vuVDbmn0YtQLBf0NlCm8oTAeHxdgTD
 lwLhTyy4Q/Fs2nyA4UoygQAXVXYhzbIGbHsml9L68WAOPJY4nbkGE9+wlnsuwHrqEORGeKiS4i4Zz
 ESLDMOWwOZPd5A2PxG57N8g+lzs7fziDMPjYsZ+feF45T/Q8Lp1jT9UqX966muBkXX7JV+lbBKoHo
 K5ZPjLGw==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHM35-001hAB-J4
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 07:36:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614756959; x=1646292959;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=soYDRWLl0HHrEGC18buOWlBqxgRLTopf3jSsB90/2fI=;
 b=MifVTKohujcQNn/lSBfWn7L7Szb6N8X8lTKcGLMinhBXYkKKimANo2Nc
 LWGsg8oGa4r42euY9nN/024ZxrbvobUujMD5ZxLRdqOHdQuqgni5xcs5k
 IU2qKx/jWt+kyfu4yC1OnPbspsTkh4nAGTOEZSv1Ggi9mItXb10kpVTUA
 xOqXBEi5g6GpfuFHVRcPtQX6LjvI23J6SuRi1nyjX0pY/MqdBtqqUxMtL
 Hu5EimFoT/Pg2JEpqm4XeLDKINWgn/gNkUZTi60LByG5hS2y0MSPw/uOh
 JQOTUHSy3aKw2zlLbTNRdg0uhdhSYlgEVmPhdRl94fNkBGrhSwTcGEvod g==;
IronPort-SDR: atrET6+azEHppVjA/w0wf4/E0qY0/51g3Ym5tb8HhqobcDL/ePgi2ETd6Dsc7B5V9pM+o0RW9i
 mug3gG1KRcmADO+sxucgMIQJmKwj2KZfVJ+09xydL9WqWDeYECdz8XoZPdTua60uCCP17BR1hk
 L1MsptcoACcic/dZiPRvPTk8E1AT+Ee8P98qBbz3HhiJqiO0KZsiBbt6wuT4HnlzvqAz2mK1vL
 tnmrsXdPSP64QDLgDUYj0EMvc1WA9h+OuOAGgbiVtDEnesNPgN+3vozQ7CJDIVnhgDbuiB26y/
 Bxo=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; d="scan'208";a="165713438"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 15:35:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqLFRU+E7Mdme3+HSl/qdSiy6zbodr9KaRFds36lZCPCPVojhN8HxA441kpXm8bzexwIldndAZNsMLcGAuCDv/5IIhCeoxLN+FtYA6oPj6gzctandNG6vy9ihgMpfXBVadLRlsM1WtEIa5/eD7nM+h4cTDpxOIuSNHGMROE4BN8+uzgpo86ykNeolSbp+2VEkzGJpRH4cBxgacrlwRyre9e9MqCxDNnxu6jM6mn3ReEbt+qSKR7bHJAR9GaTn9KskHtW8NTARxTe/SXjl994Y8h85AArAvyvOsApjAK1KerQ+y0aA0xgilHZnETwtJ0Gp/1t0fQjMbjk+2Rb/9hi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LML9dFmYNDfi1EYJPtgWMnHgM3u/u+tjeMaZGZTbrko=;
 b=W958qUD8ku+tqGHXb5nkZm3HIGrTq/ro/HT145eB+BM+xX0TbkatO3DVDmqyXtBUYxyfLGDLWuzzRp5619qpe0mZX/SXza0gn0J0R7IryQluKpr0trQr1YqjRWathRIuob6kd9zkBO1ozBDioXxb8+XMM7mZWCtT8XQJAu0CdnYNS864qGku2hcTLbVt43wsaNxqpIGQI6+CYVGc0FU4mbDKutLmNiRsKO59LKxFtD25VexTD7uAo0gb54fnJDF1uz7NF7xlWmOsygFKqr2QhbtzqrDursoMMDfornPG7Wh9z4KGvhrqoIAviXAhP/DzbaqPdY9tS8T3mkQp7udbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LML9dFmYNDfi1EYJPtgWMnHgM3u/u+tjeMaZGZTbrko=;
 b=sAlN0rlDL/7xY9oTSL0m3xF+1w9p5igAqLDatI/qefIsjoO52eC9NUd9w1VAWPYQpgEOaRtmZrsl5e1kEI8SIbFr0/jYyfz+EjWY04ejpxDB8KOwzTfud3z5bnwmqmfnAttDk5JQ+5VEuJgEWrguJcbcR8AeB1l2sDght188fyU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4870.namprd04.prod.outlook.com (2603:10b6:a03:4a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 07:35:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 07:35:41 +0000
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
Date: Wed, 3 Mar 2021 07:35:40 +0000
Message-ID: <BYAPR04MB4965E07D8D106CE6565DFB7386989@BYAPR04MB4965.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 0d602d4b-d912-457e-a133-08d8de16f271
x-ms-traffictypediagnostic: BYAPR04MB4870:
x-microsoft-antispam-prvs: <BYAPR04MB4870FAB6C164429CD1BD781886989@BYAPR04MB4870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YbnpwApkNTwN+utqVR63iVn9cSJ1JcOjamc91GjXCgSjSvxzrIoO6Dh9JYPk2kuaQWDtvW8zQNLi6CdzzMItasrgTPHK26l6INGdv29aCrDTP7tX3MQ6zf6NvGhJ6/0F9+ThuO7EeCxdhzkwLd7dNYai96BF6WVw7y5x1LBgqoRTl7PoJ5XNeu1hZBnACQsgtdvTTH0mzLGnQ3fNXjOV7gftVXojfFBb4HICU39SaRGDKjgSkumds+F7ZANdPP74fCTVaBiqs4fp6oNxYMv1G1b1kQXSCRweI2IxU1c+JgvXIrwHca6+3Ck4TMdtMSBobC0TznThOQJf3CuccaylidcpssiHisxDYNYRO97vn91d6VuGgSWPlXKSTFMVrA3PNCExIIlS1EMaqWRW8u/XeID8Nd1hTlFTOCfJWxliKcyoLBCpEpGjQdcH6krPeq+r+fx4+giao9EFgFs+/fvOqZ+zgRzgHT15Me8iNXBfw4tO68UkG8iwNnQ/Cs4v3Jk4rsp2+YhTWheaXsZW4k2GNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(5660300002)(4326008)(66556008)(66476007)(66946007)(66446008)(8936002)(33656002)(64756008)(478600001)(2906002)(558084003)(186003)(26005)(86362001)(71200400001)(54906003)(6506007)(7696005)(8676002)(53546011)(9686003)(316002)(52536014)(55016002)(76116006)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lSSdmN50cj/zENjugP4X/thdZvrSOkHzvEBl0fxEnzRbu5AlZUP4v/HqE4AE?=
 =?us-ascii?Q?ERh0ghLyKP7m6q5GOZbd8h6ORulMx22suklc4l42hdhXIr/B1kvasxP/HeoE?=
 =?us-ascii?Q?vhnuBoQ6Ru02pt3gHWr4hJFIBHg8c9XiYd09dsTrgIlNsZjRHRmDN/IiDO80?=
 =?us-ascii?Q?Ktew009iVZ99THVsGQdjIRz3fXkGNgENTQGJPXzCLM6tYmzXdkGEKcyCnFXr?=
 =?us-ascii?Q?DnC3RmSP+jSZRTkvIjQ+Fu8TYk0AtN6AA3pH4kl+hyY/UMwsRu7Kfh/aPRdG?=
 =?us-ascii?Q?MTQKOlwN8o372yLdBPBiYngN2DtAzEbdS/bpzT3XqoiQ3IhTFNOlSBxXB0+6?=
 =?us-ascii?Q?Cdv+fsIQUdAO+VUfGhHZVTyCjTTsv6tftKS1FJ/p4uCv9FLUxci2ITOTOB++?=
 =?us-ascii?Q?Ado/DVombcX9Lo7oMjm3Faca7/rFMOt4aL9EW2e/xmXvaa9qSNNRDbjTyZuW?=
 =?us-ascii?Q?Ti/PPaBpsKVZcL/0FbNONHbdtIheyVQTw7CVd7iM83WKPiTPHitzMRWRdepX?=
 =?us-ascii?Q?z+yNdUcLd/3UuhWiGX1jsdVNgJP2iC4SiVcGM1hbs6H+kvHc4LwIjFwjQOoO?=
 =?us-ascii?Q?9tI29Xq4Ingi1sO7VVKHWTriyiJdcD2Nxu+RgTAyp1MrvSENrOjH8WRUT9Kw?=
 =?us-ascii?Q?oMEoW+HK+UnlJ3TLhOZIWZ0G30dXBjnNmvqHF9+3R2MRsq0zRWo1V3/iySKz?=
 =?us-ascii?Q?NX6joi6xZSnympkdJuQmPfDslKjvuQjt1S/UnrlTVOrC5GTXot4FZ5FiJ02H?=
 =?us-ascii?Q?FnnpomysbevTmEc5zON9C3nd9wQIyxe2DSQktqsgjrFiJBhrVmdcwY3/Dv8K?=
 =?us-ascii?Q?XOjWa6qNBuyJ89Y3rUUyXtEhX+QwKbtDh3QnCsHKng/OunmHIIozinb+5fnc?=
 =?us-ascii?Q?a250LzKFcTRNkXry0QR5D7i/pMUi3sIkV3iMz7kzc7JY5w3Jjlrc/e8vZaid?=
 =?us-ascii?Q?c56GDMwj1sKCq6G+hIIq90wC1DwFM8lId9VcHBWE2egig49bQ60kQRiGNclE?=
 =?us-ascii?Q?MSQd9VjNb0reHNAtH1G7m3g7lrEASIV6CgG05YLCDJKMnWLSJ8g2uER/DMi9?=
 =?us-ascii?Q?VMOzeseWuEUwo9Fk9isxNe21v6JX4S9jBIhRVogOw21N3hJj/7g5OEvLsIwM?=
 =?us-ascii?Q?zfrz9uLpRloDJoEZap31RkcsBAhj37w9zkQnVkZvu48XhYMO0YS4XuLd0iiq?=
 =?us-ascii?Q?JTVZp5vFGfzg4A8Ha7W4Spu+3SlkDdhBMSi7hnc9VkzqYqstPPY+vHFrRHR7?=
 =?us-ascii?Q?OSHQq9YYDEPhE1bD6FdxcwL5MXUBIxLBIavQE/20UktXeQIOenW1sKRIGuzP?=
 =?us-ascii?Q?bS+ZxiYdThIlJBORvQiI3frn?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d602d4b-d912-457e-a133-08d8de16f271
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 07:35:40.9975 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUMown3Rpdb11S+dffAWFW4PD/Vfrhv5xVlm9iD2pEvAmmzib5MiAIyNNevXS41YSX80omrmJ99JL6vp74DpWqGbM1BbJ4FiLqkjNAIh7JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_073600_279016_D35DFC31 
X-CRM114-Status: UNSURE (   8.30  )
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

On 3/2/21 23:22, Kanchan Joshi wrote:
> +	switch (bcmd->ioctl_cmd) {
> +	case NVME_IOCTL_IO_CMD:
> +		ret = nvme_user_cmd(ns->ctrl, ns, argp, ioucmd);
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +	}
Switch for one case ? why not use if else ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
