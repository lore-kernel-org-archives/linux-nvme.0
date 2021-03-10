Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C61C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 01:19:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91039650E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 01:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91039650E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=kzL6M2SPfiAMPd8nSsihiSYox3uU9hR0TCW9OnJZrVk=; b=iharAkirD3nMiOXoM3gCL3Izt
	2vPZsVibk6t9DhpIwMc7p4JilhPznkxfN+UALt8DKzV7oqYnz78JDpevOvZgTIdNqwejHi2Af3iVK
	JkrGayzyCRdPJW0Xlw3FTYi7q3rbDvscV+B//+SmRMOAXznWx0JzdqHTOcxD87n9cA61Ut1jKMgMm
	7xvEFEH/OfKFsI/5TccNonkZcM5bqUogJ7DfBKQG27DF2rGaps/9p2y2OQQWsCfoy8kGeuy6Wy0nW
	B8Zl2/SSvaWOtc4b3Menupwapq/i/Vu1LtAMjgoN8zqw+m/vALDLMPzJ/YG9IqTp8piGMVqvSYev/
	6lxh9UBCw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJnV8-005jyY-8z; Wed, 10 Mar 2021 01:19:02 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJnUy-005jx4-8i
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 01:18:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615339132; x=1646875132;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Av4mqvO7d7DD5g/LTUrx0ENvaH3zYGrS97gF+bjHHOg=;
 b=hZOwgmHyDsupBoBXTSH/Wu822NNQKrPiqpRbKYfRwrFvxq7ZV6UssZVx
 ns1bON0lz5lHhS5PmFLQPa5MGxQrsGsf4ipqMXJ1G3FacP35wtr+41YxO
 HH7XsYtQxZrlx+AK4cSQvRyFzDF+1ngF+tA5DGd84bvOa5aOdW+I8xcj/
 3he1XFq6QvtL++WoxAANkPDfWDNFnhUycRyaD8xiQoe2Mo5830rBDqpyw
 IvzbhDEp25TA35s4nMs7YoSTZOwUHZ0TQHdHG7e1hhkhE8pv3T30vNutF
 TctqHDoNjFayF23/zlhm6zXdyBw2AqcEuqCfejRNgwwkqiAKkreP1MZmw g==;
IronPort-SDR: /0iLeGIyBApc5CWI12tgg8a0MLRT8EAViEcQxH5fCzopai2lWRor4Dxdx0SN7dABQDZMY/bFWM
 Lo5Rhqpaoi5tz+WPl858AWNgQO0qT7TY0cYu3mGz/31rHBIAXqNZ0zw4rLd/f+EOcSPJyfOJOR
 JibEOj/CIcL4bre9iCoC1tw7kE7sBYL8O06HAsEoXkic3vkku6MOTmzZ0O+DvlmoFE41mw3jIw
 41OKKPJqnI4q8FBVsY8hKXiGKPhHsdPCMXldwtAqbHjowkd8wq4lny3raTGq8+nWeJct1gapIz
 rhg=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="166268147"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 09:18:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3ch76gjic8W3E3Zd4roufR2KA0FBL7pJMZKDBAHy8ZinSWoUcSLFcz43qQ8trV5bJfgzjrep8YTL8R5pRFDzeohcQDe/4jyGcHsRHV3OqJA6UQ4pdxuzSxXWtvj+5XQDZfb30qtT/Mwmq/qlnrMkFFqUjBEK2oAjN3JpChTkE9jJ8JqI49GnpaoI5/s7X7eH84Bi87rRruJpPtL0VyS74Wi1nYjiGggGdAkBnYrGqUaqyMrlRFkDWzaBcU7aCd6AJoMYPmdNBYFd4up5MksZhCPd21hddzzS2nzaWzT4yg6TucomJIMnUcKMNpaJD+g9SVR56LauOQ1YeijxKhTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgKqstFTc+s0t4IMe2f8h9JiL2Ts3do9FPU3F7tnrlE=;
 b=fzqUkv4OaQ3kDcobPttjF1T1093Crs+lAvGsWJdeHQ7SevDceYslVpvf4Re3J8EyQseU7d3ApZC+7vJFBxqeOvYoznxLsuzNHh9gdaHWsGIaFFERBatYSSKmyvO0nOR+H2lD0HRmlD23w4uPfV4R7DodotXo0HVa8PMqhlYKOcSQ9bDAnx33251JZxh+2JwRL4Dh46zI8M0U6XHF3AejJwq+kP7D9cwBEaJ+g75L4NUt1Fvo5LJlHbegozr33UFBG2ee/twguVzGCDy5EGe50Iz0IRJ8Y7jOMPBHkeXgGyftirww06AyE8znKerVpGdg+Weh9dEgQYxm8Ryv7OiN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgKqstFTc+s0t4IMe2f8h9JiL2Ts3do9FPU3F7tnrlE=;
 b=W2a1aIAExWzwTDDIq1AECF1KMpNc1ZpPz0bir3r/60FxsOVqtgMGODm+OxW0PXTilN0CenbZvvPMS4EIXzimdUIBQkzIx9Tedls5KL5wiBVRx5U0Le/0Cz3238UdKDe46SjYveI0J7mbLYOfi4qF+QmBBXLwzEyVwrkoZ3O/LoQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4104.namprd04.prod.outlook.com (2603:10b6:a02:b0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Wed, 10 Mar
 2021 01:18:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 01:18:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 3/6] nvmet: remove unnecessary function parameters
Thread-Topic: [PATCH V2 3/6] nvmet: remove unnecessary function parameters
Thread-Index: AQHXCxmK7dtZjU3Np06/aZ2xuUh4rA==
Date: Wed, 10 Mar 2021 01:18:48 +0000
Message-ID: <BYAPR04MB49653DFDB0C3B60194D962AC86919@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
 <20210225015642.29288-4-chaitanya.kulkarni@wdc.com>
 <7cf9d715-37a7-d2df-d10e-de2215767598@grimberg.me>
 <20210309100049.GA7051@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 245322aa-606a-4591-ab2a-08d8e362751d
x-ms-traffictypediagnostic: BYAPR04MB4104:
x-microsoft-antispam-prvs: <BYAPR04MB410442B62A7D84AD15E8FB1B86919@BYAPR04MB4104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pLZ+nDOFAtWQkkjEemQVSNT8UfC1oEqXvbL4tqeYLHtrJfjWZ+E6XYWA3AXm3bu0+hVhMEBjFLPZzVuP/tMLYGmKbKw5AE/OOThLd8AqcjA9xhfsw7mnlNgp0XkLuS05spwFYACi/K4UcNSbBl+0u0SWYS3xb7DKdKk2RPFLOjhK9cYXeF2J2LmscFaTQkrCDPxtHEHBAd57wJxSSuvbPikojTAjdWNq/5399UR7FY/tzlXNgkf12D/JMRkuExpgWmDtUZrrsVVA8ZeP0zK3k+yfDDfImxRphU0jCB95NEeoOcRyTpehsuxpKnqVxkTYoYDQsx9yD0tuiMzrUt+FXMxIMRqlK/B6RUEacevEr+aHekikNF9PWfIZzWh3SlqbFccSgSNvbEyNP4cKnTWE4ifAF9La89Of+d3K54fdPvjpA2hz1dDUsIHnnNkBayIhOkA4vAYhEjN7AQcLKm801zMAdTO9qToWqE8e71XxDI/ZqCjvrTMqHKEN049wqvec/Bl9N1AhzX/7DnuvLcWnEsKJ+swPixo9GC4uKWSBSbdoMBDvt9ptSTIEXLSnxSbuF8EXCkiGiGL1weRsR6njA3ODhxBh1R7yBbkkZTWtpd0pIekoAt6HiwCVFDTy+jJOoeQ7sZXqWspcLYOMTrzdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(55016002)(64756008)(9686003)(966005)(186003)(478600001)(110136005)(4326008)(66476007)(26005)(66946007)(316002)(8676002)(71200400001)(53546011)(86362001)(66446008)(4744005)(6506007)(5660300002)(76116006)(2906002)(8936002)(52536014)(7696005)(33656002)(66556008)(533714002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SDlSSeBiy2Cb9j0McIpA6mrkVW9q/y0j0Fy7UXbcFqDO/MatQOBnlYfxO+g/?=
 =?us-ascii?Q?DCAnPLS2De4q1r0C71LHbXo7XIsNFObhFCwO0PV+9rY2qZCgQTBRSjov0Dd0?=
 =?us-ascii?Q?pA3Tk49bm5SEe2i3tjoDUY6r8Ax7NZL2dOa2HFUKl1iNTnI4yXZsWYoQew7z?=
 =?us-ascii?Q?PH6LP8ER3OzhHqtVnibr+okW1/G/WQq8WTxrKZdzSLJ1FE5b/qdgxiXimH71?=
 =?us-ascii?Q?U9GMhP64Jb7k1W5YBKl5tqMYxYaNkra4UT59E/2LoNaW7hq8rpjnBmBi55e3?=
 =?us-ascii?Q?fumrmCUv9TVsu+3m5WeFCw7TwArmAYgRINhvDK9PzqwGK+oX1SnlcEEusGnR?=
 =?us-ascii?Q?InUoRRRs9MO9SoC3jMC3uhRHxOVEN9jz5MBYUfvekYtQfoLInDSDfPeaPCsC?=
 =?us-ascii?Q?39reAkHGtluW81aRsJlcho5+drsICkiOaJUv+q7aQD5B+BTq8G/67cKFIeLT?=
 =?us-ascii?Q?5XM1119nM6HsLCGQBDJAvAXtrGwlGKcnUpJt4GoTSh6hoDZfxFl5UkyDjp3C?=
 =?us-ascii?Q?esctMBA/5stgbO1Tsu8ugtism2zxNMDAlclXwcmZUS8y9uSGXp9jqoaBY36O?=
 =?us-ascii?Q?t4gQCWwCyBanwcQ7fgaUhwUxcN4yLWid7XK3U2R2uPqMG5zeXxJnqWjj98It?=
 =?us-ascii?Q?uKUUuOq3ai4W1AWQA7TDJPCn9N3gYiAvkDN5waf7+Yx8PILm/WM2jnoLAuV0?=
 =?us-ascii?Q?hM/CxTpkTTwQhPqiRQalqA+fDKircv+FLsnQ1a5dCmVejgbeAIachcRpC7sK?=
 =?us-ascii?Q?oZTLJ5C/ymouaqr0cxB6X3Ic3snTqnqcK0vZcTwo4NqFRp928fb/0jjkFfXt?=
 =?us-ascii?Q?Ej3RFASg8ex2L9QX1cSD3Cx0soq9OTFMMyQOQTVAF8jHLtDqMVzwwA2NAJz5?=
 =?us-ascii?Q?geujff7KteDRinRhNVa2Buwl404F0THzFgXHCQPoXA6Uz+x2VKVe0Agz9+PM?=
 =?us-ascii?Q?jXOlRC2WsAHNZG9qfpwa3INyQdOv1iZnQZBOwWXdfUS7NITzDdFwwq0rjJnQ?=
 =?us-ascii?Q?RlmeHPGO99CQyE1OTHpSyzJcJ34rGajx5rXYituiq53bOhB8hpPA8wwIQvyR?=
 =?us-ascii?Q?3ASVoSqbykXgD3hhIaGU3BY1yNkfdgA2Yai8ndPsX2dxPv+2V8GbSxdjg4G6?=
 =?us-ascii?Q?wJ812iywzubZ3tmro1eNAJj2Dfe6q10NIsbTSVukEXvansvV5H6rhevTk6IA?=
 =?us-ascii?Q?qoArs5ZCdX9WyHwn6ec0h01z4gWAcsjZpUb3xfH5odCTUtdJK1QLtY7nBUdy?=
 =?us-ascii?Q?8DNvcC8yUeAWl+QcIetmJqfKiP4BXQ+DTsLe+kelOjdnDdA8rTxZ/8mlZoHZ?=
 =?us-ascii?Q?1JA33nJpgrVnGpKcj1PhEqVb54Cf/62/gFTrorl1hLxfMA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245322aa-606a-4591-ab2a-08d8e362751d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 01:18:48.2874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJRwHC4PCZGCWEGrMeLQotWXfpuKqVgrm4QYLLAYuweRnKTsi6efWnwZX+VtKa3s3A/8Z22AkF0L6V2oD1NoXUKxQ/vxy3CEDHMiPHbO5tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_011852_724991_8F5B1A00 
X-CRM114-Status: GOOD (  12.31  )
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

On 3/9/21 02:00, Christoph Hellwig wrote:
> Yes, I can see that point.  Especially if we want to eventually add
> PCIe/vhost support.
>
> Chaitanya, can you respin a patch to just change the return value to the
> nvmet_ctrl?
>

Patch is posted [1].

[1] http://lists.infradead.org/pipermail/linux-nvme/2021-March/023513.html

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
