Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B99C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 21:11:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BFD61006
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 21:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BFD61006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=yrkxWwbk3dpiEexkm5IDpC3L9yrvD0kVww6bxwmuhn4=; b=JHqOeLHhH8ZMr4DSqXvKxB4Ru
	wm/KjXu8RH456+5+sFZ/Bn2lIYZMYAy6jAdRP0afsuwvpYHV6cN/ShJW1Td9SuYFAcdAZFHACyYd0
	CiSqTDJk84p57K48HxLq3J7C/KXQVWylqz4d2t7kcsL9WmGSA8hYv0z2RZhBJWlf+UQWsnQN+MwPE
	5Sb5Vrd2pH8bP5rFtPFXQFDUY4UUNyxi/YUmm8XeUAPPMgI4QKCAsgoUQfAokbxElXePOubRNwlG8
	TU/m37bIN2ZY3XyZ43KUZmOuPJhVsoWU7ItXTk4EQObWo2UpQjg0JuoUKo1Cub9Beg8je9onZtVvI
	5MtFLnIqQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljTT5-0057e2-FW; Wed, 19 May 2021 21:11:03 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljTSr-0057cg-C2
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 21:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=wC6b5jT4wFkCN8aQMHa8+PtBb3WVP9Il/gf3J38uue4=; b=lR3E09JXGA1BLvVBWDbdDqNgOU
 R+NYX6bRRL9bj2SiRKMC9uxotrsFv86oJnXZndQDGZkh/To5vGdaSj2yvGJZbe8IRF10GdZEXKInv
 XSxRi6tHMpYoQ4qrpkrsIatqWZYkCKzG0wmFMd/7Bf9/35PZbaF4aXG7G7tV/KM42Hib6/DqoE47i
 dSnQuMqD7uZZpsfNKILinsBZj5J6vnlTUKy5zcMJN1GZLR+yXMZsTCP6aYnK7CvG4B+kbp5DBeny2
 NeV2vxwq3Lbf8oiA42Ny+zlDq5ZklwfQEO5mPeryAq5jzm1+gqdTLTRNCPCZSw+Ll8hWYauALW2xX
 2uD6sPKw==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljTSm-00FnBC-PP
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 21:10:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621458645; x=1652994645;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8syM5MMcTPFLFfIycTDWWU0HdfvJmhkTOQG7kICIgbo=;
 b=o8/cxGZI0Y3g0Yt7p6CJ5LcjozctUQ4BuasOmY89NtcDuHN+zUe9mnM+
 fHbd6P5S+mQmJSPPxEY12uFH5fnCjalqbFBEN/4Iwa+cpZ1KxJZXHfVff
 QQ2GMJtaXvsr9rJ3yRdDn7ARgjQOzsynvNfH3ytBtGaR87/kDNyscNocv
 42yJnm9FBJrpkoJpUAo4skznky/OI/+qJXIYG4XPJUibpAi0Zv8VgXSho
 qenV9/NzDBA0DHJUbfcSvFY9z0bC4yZcVOBpj4PVGuwU489iUdZNRn/gI
 ezW142saV6rPayJqJQhMm86kbYYoX+vVNPRaTz1cY5YVRwXKohscZHyQL A==;
IronPort-SDR: VgDNcaeT1xMZ2KRMa9Bx6MDfPdD6cPTqElVo+oIJZnoaRtX3T3cCJ/LClzAx9a1ZIE6tSFq5gA
 iOrbRPfZ3Bv7xebKeIlvHeAWOFWh740ueDKm4YCiFa5t2HL0KpTnSXpMbdmHdAQ8JdMTO9eTOJ
 qUQEKV9BQzVz10vesT31ApNTzFfxBgBcuQuF/yVEDqDDgbUeUvK8oFRQxqVR52ZOqSdmrYv+2r
 mEr3Mh6xgBkh0jSLPTkGAwdX8warY9r5/rLqLwIgbnIZrpPaGW3MdFyX/l5equWk/nq1Jfx3C8
 /D4=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; d="scan'208";a="272697742"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 05:10:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX5L8zdvh2GieKDRqyJWD18KCwlIQ7e51S8iX6jLnaxNi0ztIK3zEcslXyrOhVyW0h+Z4vp0XDNi/kO7cxHva7dU3zX6yxBubDgpFS1E7qh7MibFpu4kIYJ7z/i0ndUIvh0MCYmuRXRtwrc47bds7+CdKEdUd5wQMEvYfxq77fotOn2kofh3wdzCkMSOpMc4iP0+Fo8GOg4Qp6sp3ZJ8qk0ZJx9QT7jqD9QgrkGu0eiSsShFMN4ecpfG1mjkTC3braJDT5mnjLt8igWAp5Pvbzl/78wOmSsrHdu+iJ5vMyQUN9XZOy4eGDUi5ERuRROsDVGAJ2rrJeJDTDghEYknOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC6b5jT4wFkCN8aQMHa8+PtBb3WVP9Il/gf3J38uue4=;
 b=mKVwYZjY1zQxucUPCIDWpXpcUIVy5NBsqpNaCzCDKYmDfcmksTgaT7arM/HBcsGbYBtYN5yOB760/gfgabKLtpaPl7E73idN22bXuLXPhJowZU/8JD8dW1qaLAwWqmdJHWjWjPdmr4EdD3OQtsoB8XOqqshsSom335E5q2HrEf2eBOV3wwYFexsqriMBhjlzaIcXxH2ESxq2P0DoI9H5BMHhWCabNZ96z3yXzC+TsH0Ft9q7JJWhD/QecpcC9cVyhrRO9H61br3FMgJAxSGRiHSusQa5AqwAYshCGfsqfQc7y3lBVV6FOfsy2A89Vri1fkzRVqF4OPIabD3x+37yIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wC6b5jT4wFkCN8aQMHa8+PtBb3WVP9Il/gf3J38uue4=;
 b=pO9rHCBRMf+zZQVrNRCmgrUjukVH0bJ+e55Ff1xE8plJznm4aCkyHko6NGxYp4PRqxuHboMXXJgLg8/VUGoptlxsa6sPRldQwQyhWr/4OfrKwmj0OuAiUCPPvFXvmCu0Cqb/Qb3NZC70hDSgUkLrftZttfB5cQWez7p3uNuuL5Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6899.namprd04.prod.outlook.com (2603:10b6:a03:221::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 21:10:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 21:10:39 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>
CC: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 1/4] params: lift param_set_uint_minmax to common code
Thread-Topic: [PATCH v2 1/4] params: lift param_set_uint_minmax to common code
Thread-Index: AQHXTNfMgKw8YUc18ECpgVMZC2w2xw==
Date: Wed, 19 May 2021 21:10:39 +0000
Message-ID: <BYAPR04MB49650C62C2488F8D552025B9862B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73afabea-eaed-47ad-a7c3-08d91b0a8dec
x-ms-traffictypediagnostic: BY5PR04MB6899:
x-microsoft-antispam-prvs: <BY5PR04MB68999C93365F8EE6A63188CD862B9@BY5PR04MB6899.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDDNInKDvqA1VOq9noMhctqI0SxaiFn+JTZSxdMfvfuVcYO5vPPQxZNYdM4qZY1PRZtPgz/PTcJJ6Mx0vgFYUtSX31Iq4OCPoQyCy7cGP6xuPybVbPSAAJm59LlzyrWkolL/NUI7r46mkWt2GXASXi7lQtNqVZW7fCYJIdTFPoMbzblu3OiSc+i+O094eAsO0nYwsYKNau5wJONsXbSxny2dZxLI6r0w8EM40v/B3JLw/QEUzSUczK/xmuZ1UztbP2u7VM7OcJpHIMMri9nz+BGDAyGW0biJV6SW55DjHjzQlU6ME1ySHebCzfUnJkzrb/Nxwmwgtd77Qkd1e2Z24qWYsTA7AjacknVNj43Em1pfBrUJySkblFCu8KDZfaVqp5nKPy4rUjOBbRBiEZPCpZKaiXaZX7vJDi0UOoZdH/ipDTljTkR8a6cQTiPwuel5GcHyh0TACDFssObdQMDZDHwhADK+8erfjqtMckSj49vFM0kL44jVe/Ymo3Tl97mXDhYb4rQk/MN0QmGhDHdOJxJwwg2h54MCDqtRztgO6WuGU1LpjE/kpyGGpSnSJsgNijlPazRlsG2EdMJuXwAXn6l2JKqwogAld3+fiIgkb6s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(71200400001)(8936002)(8676002)(64756008)(66476007)(66556008)(66446008)(498600001)(122000001)(66946007)(55016002)(53546011)(186003)(6506007)(4326008)(4744005)(7696005)(110136005)(52536014)(38100700002)(5660300002)(26005)(86362001)(2906002)(33656002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wmn63/hD4XHj/v9BDguhsvUFi1+o0/46qUHs8x/hT4wtMECZ8+rnRfIa43Ry?=
 =?us-ascii?Q?c1ODZKdzoG6NJpH8FJIo8rPmE689euw2CmUleYv0gX3m4Ki0mKYwFKp5DktC?=
 =?us-ascii?Q?2uuDlYsyJd3FhYsMNLtlxpUFCdwyzay62WmyqgUXURLx3lWBpDB9Hp0y4leJ?=
 =?us-ascii?Q?hiudHUEXBIrreSBVLCMALNILE8vSOV70ba919hwcVxUtD8BZTtjPIEH9glIA?=
 =?us-ascii?Q?AiSSFLt/rbarCUrHDFF+7MnqUDe+urh0hP1c2OeliGCeydhUkZp+aCOepAy3?=
 =?us-ascii?Q?VPBVJe9zzADpzGI8FB9UEFGNGnUJEYps3hhYMsDC2GFrWKaczknY4PL9Svkr?=
 =?us-ascii?Q?Tdeu10vVwSEY99ips11NJL09hbHwtmX/QKokUU9MQ8kCDDMRBp7AniJ1WlJF?=
 =?us-ascii?Q?znZOCvKkxQkyQcChoMaEUvtcLdQytI+Roicana81HID6pCgQWkj7oVPW5vFE?=
 =?us-ascii?Q?zqZZSgbcqaiNs8uTOeBKlJKH8zuk6gId/08xoZ6/vrsptXVN8bXcRsObau/9?=
 =?us-ascii?Q?1r0tLiUYaFJNiVwUMTAIRXJQUT36A0Kk90bCxgtoqm9EQ/d8RwMcwtDOpqv7?=
 =?us-ascii?Q?aPCI40Go61xjhVZk4XDg9kvU6Di+BsnAZyFg8mCmkT+m6NjQVGwuIzXy0OHp?=
 =?us-ascii?Q?95yrn560fVhgGi3BRawZcWtt4t5B1VUhBS6czvxs3ZvV2jDoQwco7Hdp4U6h?=
 =?us-ascii?Q?bf/MCqgrBg36n+rcqKHYgAIwxHeasuqAo/CcbLCkg7L0ijTPi9DLHjDfl4J5?=
 =?us-ascii?Q?OQ3zqCef9fIULa+mbAskNqtAFdpn2iJmbDiSwa4ofStCSD2sx+Wz9Hl3yPIB?=
 =?us-ascii?Q?lJLisxlYgTR3KyF9TAEUppCwCEVZMl/QsUFg6YFIk/ujmxATNviK2BPDIhrE?=
 =?us-ascii?Q?UaqFGPRngme81aZnDV8NOExZFRF2eUndx6SHUP39osyALFd8Nj+VPU2dH3x+?=
 =?us-ascii?Q?4k/48JLPMc0sQJnzLjp+tNjYy6KFFCXyR1tqIn8zuAE9jryE7n5s7nJhwr97?=
 =?us-ascii?Q?jWPhvNdDVoPBvg/fvxdb13uCuH3twEH1gINjUcDM4obUqdcZGzgF2knCWez3?=
 =?us-ascii?Q?hoqfk2GYH8pDRhYEuStt8LWNRelHW3NTnpDmNIH62VpH6mzan+MrxyQMzMV/?=
 =?us-ascii?Q?hXQ1ETeN2rp8LNpHPoYrrneVpswpVaKCHP3+jHEl49y9/4eYZ7qlF63lQ6XM?=
 =?us-ascii?Q?z7DFnAnOrrI/yX8oAuc4kKrUUEqIcd++GH6iR+Q69o3Lcehe7uCyiZtewYny?=
 =?us-ascii?Q?J5X726baI38spBjL5hjSbEa0qbBF9GIbniWKsdIzc/8ZAR5nlW6ezGBe5gWx?=
 =?us-ascii?Q?QeY/G2VaBcfPMRbHNw2SdIT+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73afabea-eaed-47ad-a7c3-08d91b0a8dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 21:10:39.3186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDBJj1Cacfo+2bD9YWzJU1jjfiB8Da43Rm3Bfk8LFX46Ikl/jhjgPIfX6cXHT4T246ZCpVpEZuR6H6S91phhGXGH3AxWclai4qk7HIKlEAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6899
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_141044_994420_35649E14 
X-CRM114-Status: GOOD (  13.32  )
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

On 5/19/21 10:52, Sagi Grimberg wrote:
>  
> +int param_set_uint_minmax(const char *val,
> +		const struct kernel_param *kp,
> +		unsigned int min, unsigned int max)

nit :- this is not from your patch but from existing code we
can try and make indentation like param_array(),
param_attr_store() and add_sysfs_param():-

int param_set_uint_minmax(const char *val,
                          const struct kernel_param *kp,
                          unsigned int min, unsigned int max)


can be done at the time of applying patch.
> +{
> +	unsigned int num;
> +	int ret;
> +
> +	if (!val)
> +		return -EINVAL;
> +	ret = kstrtouint(val, 0, &num);
> +	if (ret)
> +		return ret;
> +	if (num < min || num > max)
> +		return -EINVAL;
> +	*((unsigned int *)kp->arg) = num;
> +	return 0;
> +}

irrespective of that :-

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
