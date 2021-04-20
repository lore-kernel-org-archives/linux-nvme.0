Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC1CC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 17:48:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED3D613CD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 17:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED3D613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=QvOKPWXix5T0trBO6sAqgoZZLoqW4xgeC7nU+m4o4IY=; b=feCTctwaoR8DTq+AlQXazvEE8
	8y4v6q5mFeMZiocQF8URmbcGAn8H5c8lLr5RGYGaCHEF6IKt1TG5XzrciruuJGqkUKj8cOiuEMN8F
	vH2fEvxGampZb7YA+nTrZ0aQELfbnw6bBNX3aY1QobGZ+wgbSEoEVrBbxR0QtrAlnqcDJNE/uhl0X
	lc79NRaWJTdJkOmWzrUHNHHHMcZWFm6dDDN/kG8nlkvzm1ZeqO7wfoqB1YD2E32fFqsHZZFds46Wn
	IpiAk6aQndPKF5ZY3EPsykzSjRrP8nSSpquDKMJiTLceAjQLozG3Dwi+mhvf2VItDMzNzuXUA3q3U
	rWLUMib3A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYuT1-00Cmy7-Nd; Tue, 20 Apr 2021 17:47:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYuSz-00CmxZ-B0
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 17:47:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=G6f1qmuD+MUUNRbe3DPnuThnNjpytiXeVfSLa+Y31dY=; b=SorpOVwimCglQ71aQHutmr1E25
 YMFXFR/AQzAgsDNxdamb11f3LlzXicjZCWLRtNunKWmcQenK4m+k7qxE621i6uU3hm2G95NghQ1ya
 AkvnqFC67f+8KuqkRpmMxDVOlxqkvuwIEJiMV7OPR6j++nt/dEzW6To95tPV7y6/cDMLo13bdnyU/
 1Wue6FDcG0Ce7wNzM2hi61BVrN7zNKf6sA7eHGE7wZSqCCzzWCeZH5QtiBhRVwk0KTBjw835k713F
 BTXALtdtQZK30e1prZMd+W6YCa/j3ST6r9t+dkiycKvx1RNcF8IPWh/AVBEuWqhXmM1itFyDGkZYG
 kmjeblzg==;
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYuSw-00CKKZ-O8
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 17:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618940834; x=1650476834;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DQ06a54ctrv4hhUCuGRuLKOvbluGn1Db6mZuo7G+TJQ=;
 b=Cb4toallCP3In4D8zeGznBZCqacs5/d8mOfMhUcTkeJY7xsaF6sc8LYT
 Ef+8lDn0XPRdOpkDqtdjJbeppJ+dO7YtQgm0r7+J1+aqjPDmSb0wcri51
 GwEZVDIogSJfKhRJ2I7IZvU09dl/XOoh+rP2Z+84cVJcxMBRHUOkc0A09
 As/Nc8xVg9n8QRzGS4W09BENx+gdODgJ7H1MWnsyiGNHfeJbeH24USX5v
 A9XNo281w1R9hKrTby0DxsIvu3fAZIu88hhAom+28+y9J6SEvLdANc7dd
 qYRrVjjva8UR2BrAAMKmoVyNzWjBPS3YQ2CzEuPNM9ARUQYExGiy5cBzz Q==;
IronPort-SDR: sSJGvr41EB8XbWXuJtF0HO4iwdOOG+HUrS/6q9usFi72bT1W+jFQv+NtEG+/HKL8hMAZkw/hO8
 c7VUDtiKZM+tpcxmqfLmmZujCr6+0UloRrz0h71YTCzGL6UFqT5Aqm9QWnE2x6xKcQDHXZarQk
 PmP/0Jxm2/4I8lugwGNriHxUcBI71QYA11SboEZhY2VyJjV6q4fmKDylClecx21K0xa6LF0+Ne
 EBlQBK3JjbYFv86TowqlPvk9ge39TM+neOaT3uMt+xHzPC7qDvppwSyQf5JsCC2hwDXs6SpJNW
 fEk=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; d="scan'208";a="170107819"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2021 01:47:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsoKLZrXIwBL47wLF23hlEuejlmcW1FVK7jqOMWD0yNS+aC5NyI8veldXdWF7TDGn6Zt+kdlnhs3xVHXlFySxZQKcWx+aOQe6C8A0V26heFzAv79KkmRz1FKXKQ04s4CmUT87x6SdTC6XqLgiJE3+22YWALMGdo1HjFyrqYflZDK4/rgOE0pT2WAV+wgiUzsLgbyMWSCvm/3ZCH7uj1W7C7MbB7aEIli+WJ5WUbqbKcF/A2uptizSM+gjymOXRSLdEODGdJth5fYMIAV+WYa6V7NjLKghh+k+hbp7grO/5NiIu/K7dSmIT9n1+8vr4i4vwtPFjISQjZXq9UzJFAYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6f1qmuD+MUUNRbe3DPnuThnNjpytiXeVfSLa+Y31dY=;
 b=YJ1Q2Sf7fLhC+LznidY3CKJvejqMaLCHHrtSfA0pQ/3ZE4sWr0KSULQmTzGZQqPMQcY0gJLXuFidl/SmvIfmsPmwYZONVxoyI2zc5/6exIa1LvDAqE334qPZg1cUOBdv4KvrllEyd40jWJZgDfDhJD/TLPmIdozr0wjOUY5uSJ0MX6FtXEHoUKL8La7Q8FiTUzkaA7yZ/pC6JFMHhvpvkyFuM51dv9Molw0OOUoEbfyvvxmLXxLLlzRaOs5Gd1XQC8MRzj6X7uxKHHJaR+I4CwpcCd1HQTrYbwzrqhXqd1wyH6IYaVACd046eHYJP/oCs8S+DAROpJrPtqxWx9vbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6f1qmuD+MUUNRbe3DPnuThnNjpytiXeVfSLa+Y31dY=;
 b=dbI2ef1l5Lo0Mncav0tKikIZg9hgEQhyMp++KvQAx4u7zNgbjQmIOzm5OELLycWaE1W5k07h44Ve0CS7IRgaEuHy3ajcsxwfmQMnh6wBCAIwPYjRMhIF9scqjLYQRFK41zB7j2+iYgVKQF0cTMM4PIbJtjuJxoGWBO142cjnQQ8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5430.namprd04.prod.outlook.com (2603:10b6:a03:c7::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 17:47:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 17:47:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "oren@nvidia.com" <oren@nvidia.com>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>
Subject: Re: [PATCH 4/4] nvmet: make ver stable once connection established
Thread-Topic: [PATCH 4/4] nvmet: make ver stable once connection established
Thread-Index: AQHXNcTY3fiTtEHfWEG+MXP8IUoT4A==
Date: Tue, 20 Apr 2021 17:47:10 +0000
Message-ID: <BYAPR04MB496522B82F4480CADD4FF34286489@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
 <20210420090903.595664-4-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2526e12f-61c9-4168-9acd-08d9042452d7
x-ms-traffictypediagnostic: BYAPR04MB5430:
x-microsoft-antispam-prvs: <BYAPR04MB5430B2401BF8CBE95E1C417486489@BYAPR04MB5430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhnG+zTvvdEdxhhyHlimr84pKH5h0Osw+OMXPSxswMrNy2sjomwTRuqBRhmUDxlZxWrCNocuqL8MFLioRhAvS6MNtJgfbgYi3RT51tcF7aUzeiPbpt/FfYLj5E2O+iGHsAXSbwDYSjuVL1RHxkd8aG3cU0dmd4nOsz7KBFouq0Z+uxhBGReibp1xc21HNbTTTtgjpqn3JSg2MRQrt1W2etGlL4wOGPkn7ny7zpZyRa0XsAYS3KrcnIPfKIrc+Y0R1kayHqyl1j2kXTcKT6Pq9ifpR3hz9uRvKESHRl4NAFDHOGhftHkbdMNzqJF0Rib09a1COV1oY41W+UmHTz3+GUky+WaVLcxdEfQPNBv6ubw81OgqxDpWiQfTbxUhbf75M4kYvBWYNElP/y+F+wixes6HuZQtMVSxVyWj0eWwZu9trKfVFNkbjhlgdzjrjvnNx/mdLNVv535zdFYMVL47BmF1fyqON4VFn/6Wu4EU/7ZgWwJ8/rNxy+qTO8qDT3wl8DJeNJNuBteH+2u6zF0iaRiC4VKznI7ORaI9yBkia3lRRzEF82eWDohI0Msa87HKsTIDSH1LZnaz6/UtlsXQeAJy63+ockl1AJjKJ77SLmA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(86362001)(55016002)(66556008)(66476007)(5660300002)(83380400001)(2906002)(4326008)(186003)(9686003)(26005)(8936002)(33656002)(478600001)(8676002)(52536014)(76116006)(54906003)(53546011)(38100700002)(6506007)(316002)(122000001)(110136005)(7696005)(66446008)(66946007)(71200400001)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6h0aLVfjnQPjQjF18gEVkFgtfVHgUZ5eBTWU3TRP7+eN67dMIM5ln4j5otcI?=
 =?us-ascii?Q?w1sMQ8fMCC27GfMGPhwE8ZtEzoLjtg97WqeYX3ZnPR62Yi/I/oizlpA9NBqU?=
 =?us-ascii?Q?q0YRvBmaNqNVknYKBZ+JZKMWI+rabNWasGyZraivdkDCSDBpomVhAXxWx/c7?=
 =?us-ascii?Q?3FiwAS5pnIyili1eYMSh4nDN1dzwl+12MqC8cPN9/fU3hWpdf/gm+s59EjDx?=
 =?us-ascii?Q?8A95DLgzcwJOidp6ZNOfTdin/aVIrrP6GVW62hrMpW11sUcOCgltXfhsJGI5?=
 =?us-ascii?Q?L51P4yPSDIqfMXgB5fSZy+5g6BU6NUvahbBqYLf/juaTCX0AAQt9yGzG6z86?=
 =?us-ascii?Q?+cfCupVA/K01vW8a0n/kKod0oAT1XZnNHpDhuxATSnYHNuhhgXAyNhQrUJWd?=
 =?us-ascii?Q?tJREfk6HaWA/Td3yS+vf1ua+0krSDLbN9IdSPGpjIq1nvmPxOXGdjrVUHU/X?=
 =?us-ascii?Q?3gA9OKHr6RVOyC6zELU8AfNIa7ni+fIJZ6Hu3S2jUa+FQatW0rhFMhwNcXwD?=
 =?us-ascii?Q?jsRWvBLXlQk0uc5uH52/xoKTQ962Klt+HRxvAqd8Ig7Zl0GepEXqA+bZvJpY?=
 =?us-ascii?Q?Gd/NffZGH3z8qK56w9AC4TPa3E4tHNhbzOsqq0/5YFRjXoOCnW532cbdTORd?=
 =?us-ascii?Q?e3W85x78c7FOJ68VVp95VfVT0IkHBRAvTtR8sRyMeyKPS9P5N4+SllKN8NKj?=
 =?us-ascii?Q?fGTAfGz6y4M5Gfz5wQzoYgiriCnwTx//tIuVtLpjfmv7wNHMWcTq2ZzCwAAz?=
 =?us-ascii?Q?fOwWyPkQ9pUR7tV6W5fwWvMsl0Uryg8jAwzjclZlj8iWFi8171EqKVhbpxVx?=
 =?us-ascii?Q?Qx6eM8vYgQPmxvmY/TOHTNPlElaS+AaR2bm+4yaHMBaFKQbwixw2aD0T1+35?=
 =?us-ascii?Q?C79mmieoIg+il6eRTKs/+8MpzLE+e7gLLioGRL05Tp9ppTXh6d6EsbfpEb64?=
 =?us-ascii?Q?xpCSD3XLFtYe8P8mkJVA7n+e7dOjanTsOJn8WrNHEfKnI7BXVYg3H2lq7cYt?=
 =?us-ascii?Q?PEksW+Pwk4fbGVLh9f/VoUT9zvSRCol+mGLH1PwWV50+i10YWSZCxzX+ubQD?=
 =?us-ascii?Q?VuqSKPOr1u1nK2k/6TqO2UzXZ2D6t6G46VUisgac5ezjI2RMrcQWQjKujDy+?=
 =?us-ascii?Q?YPCPGz2/Ae5Tyf7aM5I2Az5A0F10cHzuumPcp0OFhuSS/15kv4Iju8ftalJY?=
 =?us-ascii?Q?lPWU3N/IBt/PtbaV1h2FiizbH6wAqAEPTqP8wjmR0Nu1byDK4EsDI+1r8me8?=
 =?us-ascii?Q?M+F0HmRyRXZkivste+bdtmITAjGls3rSMk3+p8iD5ZFmJofOusgpfJ2GPOKl?=
 =?us-ascii?Q?GzMsDYH03VZc9YUwydPpAAMq?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2526e12f-61c9-4168-9acd-08d9042452d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 17:47:10.3422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3yc77BMckl93dicarAl8C6gAcNlG0YbI/Vv7WCXgemNZpvrJoUBhDaI1fOZF1DKHIJq9TNJ2d5mV/ng5KCwyBDoFhUKeWkI7KWIAp98zTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5430
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_104714_821434_12EA9911 
X-CRM114-Status: GOOD (  17.81  )
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

On 4/20/21 02:09, Max Gurtovoy wrote:
> From: Noam Gottlieb <ngottlieb@nvidia.com>
>
> Once some host has connected to the nvmf target, make sure that the
> version number is stable and cannot be changed.
>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
> ---
>  drivers/nvme/target/configfs.c | 36 +++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 61a9a52da30d..2c7aebd4d529 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1007,13 +1007,26 @@ static ssize_t nvmet_subsys_attr_version_show(struct config_item *item,
>  			NVME_MINOR(subsys->ver));
>  }
>  
> -static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
> -					       const char *page, size_t count)
> +static ssize_t
> +nvmet_subsys_attr_version_store_locked(struct nvmet_subsys *subsys,
> +		const char *page, size_t count)
>  {

Seems like we lost the indentation in above line which was there previously.

> -	struct nvmet_subsys *subsys = to_subsys(item);
>  	int major, minor, tertiary = 0;
>  	int ret;
>  
> +	if (subsys->subsys_discovered) {
> +		if (NVME_TERTIARY(subsys->ver))
> +			pr_err("Can't set version number. %llu.%llu.%llu is already assigned\n",
> +			       NVME_MAJOR(subsys->ver),
> +			       NVME_MINOR(subsys->ver),
> +			       NVME_TERTIARY(subsys->ver));
> +		else
> +			pr_err("Can't set version number. %llu.%llu is already assigned\n",
> +			       NVME_MAJOR(subsys->ver),
> +			       NVME_MINOR(subsys->ver));
> +		return -EINVAL;
> +	}
> +

Can you create a helper to for about error reporting so we can avoid
extra long lines whenever itis possible something like :-

        if (subsys->subsys_discovered)
            return nvmet_subsys_discover_err(subsys);

>  	/* passthru subsystems use the underlying controller's version */
>  	if (nvmet_passthru_ctrl(subsys))
>  		return -EINVAL;
> @@ -1022,12 +1035,25 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
>  	if (ret != 2 && ret != 3)
>  		return -EINVAL;
>  
> -	down_write(&nvmet_config_sem);
>  	subsys->ver = NVME_VS(major, minor, tertiary);
> -	up_write(&nvmet_config_sem);
>  
>  	return count;
>  }
> +
> +static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
> +					       const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	int ret;
> +

nit:- ret variable type should be ssize_t
nvmet_subsys_attr_version_store_locke().

> +	down_write(&nvmet_config_sem);
> +	mutex_lock(&subsys->lock);
> +	ret = nvmet_subsys_attr_version_store_locked(subsys, page, count);
> +	mutex_unlock(&subsys->lock);
> +	up_write(&nvmet_config_sem);
> +
> +	return ret;
> +}
>  CONFIGFS_ATTR(nvmet_subsys_, attr_version);
>  
>  /* See Section 1.5 of NVMe 1.4 */


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
