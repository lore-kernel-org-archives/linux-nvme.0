Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108AFC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 13:50:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18D5206A1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 13:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D0fOAn9s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UcjWSYCU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X00lazJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18D5206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2z/hmvba0b499fz3vJKycAU3CunV+VGVKJwM+LycO0s=; b=D0fOAn9s83bzeCRNvjP5CQIvB
	VselY96Ykqx0t+XnW18f8AGr9WnpA5ySoRNxLBKO8MT5m5bphTMFEbXNVGwZkrj+GyrUtnwASIzst
	A4iXlcwigRNKTrv5grnqdP+TmZ1fx8AqKiZ18ZiVt5POaDrpLSMV7ULtRXkWpUgUEcShi51/vsZ9E
	QPRuAYzQr70ehCy8iTZZsuG6I1dquV25UL9UxriDftkVHVNis+PgGxI9N0MkFbgh7LBMBgV1/2aON
	ziAOW5cg/6lcU/dfxe1J6ifp925RoJCv1e1YUeFzS5LUYKAzWdlh702nedtSlpwi+/M3z2XjDuKsz
	9CMQ2gqrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joSGZ-0006I4-Dc; Thu, 25 Jun 2020 13:50:11 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joSGX-0006HJ-EB
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 13:50:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593093009; x=1624629009;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=m4uu5FRpfuw6+1EcDQ3G6ION369PspKSHLfIf2AhdIk=;
 b=UcjWSYCUOypUCEvfmds37RBFHIy4Hoc9+w3mdPjnApwZ08iiq9+yuDTL
 H0+vWevNP6le4ZopfAQ5ZVNG1OlR79NRDtzCpnW5gY2nzicCyy4uSP9vb
 kBf/OfBlDWp+eLp2tFmpQRn7KtyJy6IINXVoGF/OWFD1vZ9m/D2r+nsCp
 XLePi2n17cpY+wyXsP2MtqhYd6g9JPV+hXBWJW9csKT6Xt9RMWBCbsWkN
 p1977vLQwp5HTN5hWD+8r24R7wT70j+DLs4QAGek6LPvP3IzM4fGWV4v9
 Rb9v8Tp+2VQ1c23sAlCgPQw8e0d3JH7AD4D1wS+vHLORwu/hjve1bNUc8 A==;
IronPort-SDR: swEinH2zbgmo3BK8b86ymDLn8TRZOe+BJ+UIFy5Plg0deLpu6p9XphlYTLngLFSw45R01NIJmJ
 hocivIojq2jTkEQ3yPsVRX1d+GsORXRjf7Io2a9kxOXhOAD1kIdMbbfbvOl66HusmI/nqtnHTW
 T25AR38UfHwvL6OepCFLdT8GESvsDMxuuhVGKGELefk1kBpvyD0kcTkbxE/A5K0mOXu5JksaPR
 PGqr8/cxwkibXh5kNX/Yv5YiPCYnZUhKxZMFaHPYba42SI9Lt3IzNS0uedvoDZycDIOXHOxrlg
 t74=
X-IronPort-AV: E=Sophos;i="5.75,279,1589212800"; d="scan'208";a="141144059"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 21:50:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUGac1UDDXRfutzweG+8/+6ORmNrNOTp4TLjV5gsHRMOPsdQ1Yxx/q9FR8eejaaCgXBFNvXTsvk6HpLzatAqaI9OHFnrUXtrTjNId1eeP2YBqYHLPddq5HMgrigcmZ71jLfG9IgXSpB+eCuP+Xs6tkcrDreNoDSZS/5xD1t/c520VudaI5Pf9knreYzIFbhq+nEEpNeD/JRHzW3P2kifu/YPqc9d/1hKoI65JZKgKDn8VrTVRB4s6maObrrru5TJYDsct/x7nRWg1zXBwWIli7v0UfeTxBxCbK2bavMR1f8togmC1p+ho+wxY8UtJy3FD1YjWBSpgB4f0T9uTVNnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z/iOK46zhZ4QsyENO5nAYyAt/E3799okeqa8EZIkYo=;
 b=O3beq40EmxaalBJG5c0SYvof47Z1En9zqOFnbdDutdC4pckMWv90nKds7Gk1WokZxmkJsE5/8ItCjw+F+uHRj+vK+g+JDNxencLGmakjlWQsrpt6BoHvJDRsi2m69I6N24FgeUtEpAYOWL25i7ekr5UDU6o9tZ/uXdnWmgtXNa6QqOQFISzG7BQaKvyZ8Cmmnj1kOD3LtBur4Q8Wi8Za/XX+EjJ4vC1yqPccXpTYrD9rNsPUSSdbw91mMi4koCnWqIiv3U+ZYr3eYW7z6/RbZGaAtPZ5AwCNbg0bIx/1wa4to5DG1X3Ftq/f4ltHU7rk21p8ZE3+3o0PQrma/Pml+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z/iOK46zhZ4QsyENO5nAYyAt/E3799okeqa8EZIkYo=;
 b=X00lazJZKIrE+/6nt+6aZibdffnnOSXivPx16NKFBXbX1VNFk9CeWaf/9strQBGvBRmBz501SluD2o5Xyw7aITmS5S/63Nj/jSpqsmLEByclOw2QJ9ewJu7S7fB9MoWm2EZ0a/USkLBnVyZUX4jgfwrNR6dwNVSmV5WA9xHZxT0=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB4070.namprd04.prod.outlook.com (2603:10b6:a02:b4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 25 Jun
 2020 13:50:06 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 13:50:06 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix identify error status silent ignore
Thread-Topic: [PATCH] nvme: fix identify error status silent ignore
Thread-Index: AQHWSveIrajshcMSD0Snvr0XvxNFaw==
Date: Thu, 25 Jun 2020 13:50:06 +0000
Message-ID: <20200625135004.GA427904@localhost.localdomain>
References: <20200625000257.29981-1-sagi@grimberg.me>
In-Reply-To: <20200625000257.29981-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a550764b-2764-4e65-03dc-08d8190eab0d
x-ms-traffictypediagnostic: BYAPR04MB4070:
x-microsoft-antispam-prvs: <BYAPR04MB40708120B608EB1DC87FD0E3F2920@BYAPR04MB4070.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0445A82F82
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2T6L+z45+u8SQ+70muGQHtk9mHRBIaTIuYa/NlluHryRDcZpuLBL2gKJO+A4Xz0ZbsUFqdnJfE9uPeyrSfCYSeCSoyQZUbQZpXYTBgnLgK35XpuVpX+flNtHD5ZUpAV3NDFR02Iw0shf1dLUeqCzZGGOrN9Dchwyg4sTjmbwWmHdBBp0cbhbT0xa5n8sWliUEvXHLbGOgeGpKeosBO3+jatAqkE0i8qHqjxpdokZZmA99TIAfK7YQ9vm4i8vYn8rvlcVEEa93zWCd8ggTrLU35a01wWB/KNed8oeV2EQIEtb+BqjGhGoUyFZ5lf/dqE5ejd1/pGkxd0UWXY6sPiINVMh+wzxIb2UVIufG1YYyalNPs8/s2JFnkKovmL9TQBDCRg1mcOV6ymsxaPLPmKv5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(5660300002)(4326008)(66946007)(76116006)(54906003)(66556008)(6916009)(1076003)(86362001)(66446008)(316002)(64756008)(8936002)(6486002)(8676002)(478600001)(66476007)(6512007)(9686003)(71200400001)(966005)(26005)(83380400001)(2906002)(186003)(33656002)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: bTr0rAoEeHaaDmcI8eg4vUfBnHt8PevNZOQi4y+5rIxxoT1GL2eukppcQ5P0PDGfjIMbrHNYSf6xrwzJdeJ9ysGWPttcyYhv4IZv6piwfEUTXtow6OUklPWc0nIPc6NbYqJpImjgjEXVyPCB0J64BYA20JYmAmo0cUv0fcRQTTh6V7haxc6bKItajHqBRYv+ivyJS1kVJkii8CIuP2r0GTRloFvNKns2Mxn5rxRKLR1NM0khHcUUHAZNbKlosf7QjtK9pIteb3ATimnoZ0YmdOO2+Yqz+rhlsqiEnbshIuJrF8pvPhIYEtYp7c5aIqUQsL+Kat2lwBmPXDmEIYPQHNh9Fi0wgaIWZiAqwV0ugUPi4HHIa06iqp3oS+7afIojWkjdGsUWFlDtgiltfMEemZSVqd3ulOJEmjjgpbpVJKDQ+N5SOmGlh5Gu954cFK7BBcjhB579QwxI2G/lT2+hHQcOCk1t4UAXw7fPdkpeJngpF+CxOKG5Oq+bny+0aZHt
x-ms-exchange-transport-forked: True
Content-ID: <A6710190812F2545ADED9BD4DCB45FB5@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a550764b-2764-4e65-03dc-08d8190eab0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2020 13:50:06.1129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2qC/O3pHcffXevlDcbIPfAzJtlijDW54VPUAmA1eM7HRVAAM4I3tsy+6Vh3pypr9dp8O4xNS6pp8gqhlTZ6cfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4070
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 05:02:57PM -0700, Sagi Grimberg wrote:
> Patch 59c7c3caaaf8 intended to only silently ignore
> non retry-able errors (DNR bit set) such that we can still
> identify misbehaving controllers, and in the other hand
> propagate retry-able errors (DNR bit cleared) so we don't
> wrongly abandon a namespace just because it happens to be
> temporarily inaccessible.
> 
> The goal remains the same as the original commit where this
> was introduced but unfortunately had the logic backwards.
> 
> Fixes: 59c7c3caaaf8 ("nvme: fix possible hang when ns
> scanning fails during error recovery")
> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2afed32d3892..3e84ab6c2bd3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>  		  * Don't treat an error as fatal, as we potentially already
>  		  * have a NGUID or EUI-64.
>  		  */
> -		if (status > 0 && !(status & NVME_SC_DNR))
> +		if (status > 0 && (status & NVME_SC_DNR))

The extra parentheses can also be dropped now when the there is no longer
any need for negation.


Kind regards,
Niklas

>  			status = 0;
>  		goto free_data;
>  	}
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
