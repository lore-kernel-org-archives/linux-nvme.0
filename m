Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC52C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 19:24:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B165621919
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 19:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B165621919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=vOpxUEdppGP2UMEVgn0SnUGKlFseNSF+1FN9IGC4MIU=; b=sMIk+QFG46n3KzAOqYRtAFJiy
	I6TnN9ZxKcMaj0us9ebCuNE4GD3OUy0JmW1ctELoJg45oxtOPSRnEZtcWONyeqyC7A9vKnSV2B75e
	/8gKffyoq86fDOpcbXo9X1I3BF/MlGPmfgkclGAHAJWo51u51E43gSUloOpPZXdMM14L0UfFvXeub
	k7LA5joUpJ9juoDeLz8lV68PoEhMMkNEALfyHQ15RqKE/VJ+GF0M76BRBjpfxF9+J4ahIQpWORmwg
	cNWYUAwNTDptuuQIEA4C9ARQhWk/UPat9jjm4JxlXRcNe8TbmooO7Pzzy0xHfK4CV8JcFQxxUKxIv
	OhA3zdbRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4TwR-0003IJ-SQ; Tue, 26 Jan 2021 19:23:55 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4TwM-0003I0-VT
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 19:23:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611689030; x=1643225030;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=bGLtYZ+WsgwrC4RyBYezgR1+9np2OigaMvHqVJcSwZQ=;
 b=IUI0SpSKDT/gPN7EWaHBJ8ShHQjuEx8o6P8eBJvQNTrgy6DHiMwxCKEj
 qCvf3Mko7UIzzL2x3yOr6oQsiyLaEQyD8JeRw6RCJAmtoy1ZqDnDQiRlZ
 qEeAGQ8pb2mFxJmkKzNh2IFkXuSHAWBfYQ3FHNXBKjGiIsz/8XmKAaOt7
 /Ln/npkxlBKWCbOGjLlie3SB5c1ft5Y3s+7/8aEuAOyp5wdH2lazgVwZg
 6Lvarox5vDW6LPfS9Y7fugZdJdMhANSU+MWb4sA+dXpc+QwSyyPKWyXb8
 NuKX+4EcBvaLf4lzz0Mnc2D01ZjogYvzC5CVZZeq8zlYHexeo5oWcfyPj Q==;
IronPort-SDR: YYC0Jgi9+VMMEKXCWaBN9I5qglRPZVXd2YjlvXgfPpix9aRoXrOs8vKZSNN8sOuaIw8pnwAgVV
 W0aJ1Zxs91SZ0L0LaG4/wsTrMUnELRY5x5aDrhasAjzkBemahgbM9jQ3NooqOxGRqlpLT5cEV5
 PzXNNDTSxtrmcwhvLJjSbyfsJ8CQ7sHZUpBWzZFz748+sU4RG59Ks5fX7gnUpmTWTwuVdIW0rZ
 fGu6dJER9X4g58EkpPAa/ssimZ3iy9xsm0ic+Z0v3oqFv5C710x+ZGCSzQGPkHmCJgHn1LEJkw
 pF8=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; d="scan'208";a="158381348"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 03:23:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azoXim5JhWYoNsG6R8oJnPVAzQva2/UXuN1wAYW/Tn3hANI4//eFd1AAlyN2R06PgXs0vr69YEzbTXwk1yIxCN428czkUBlEL90DWR30T9iqcF6De7yILWAwDj8sC4JzqjGaAz2J/znd/HUMyGsRv7SoSLDWM+Suf9Bu6ocl8km0P6Rt2In6i8hWKvVtJMPoeaZrWJU3jrBk7H53a9cK/c/57NLUa4mX8KUx8Zr7aOvb3uJVyzSaEJCs0CnvP9UXxBtrCynastE+m1NQZnqTK+NSpdiT/SydSpN00SJNie/IeICdhBAIejmTMXbRBmYSJ6ur0xxfSNBfQ/a04Nfe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGLtYZ+WsgwrC4RyBYezgR1+9np2OigaMvHqVJcSwZQ=;
 b=FilcRmr8ix9V/DvQxcWyJhm7GRlmADX5hqgB57Gp5mfPpmrcC8RguzgoAi5Fns/N1wcNI0GhGxUblwA1dGeeRj3XijM6HOwHV1HRzqwpRns+lqiKwzLTTaQhTJ8YRD8m/FQUq4AnjScyO/i6W4DMqHq1rbOuScfiaLjGfwD2c5/5MdkgztH45q9SUUF+ZSdZq+6kNrvEkbveWJGrFMMMW0+MPgY+TzdsY7QPmvCwXSShUw8rJp5wQEicqM8gvnjMIBl9NdwFgEogD7XLj7bk1IpdpvJNj6XZGD8DpISHSPUp3zd2BUyIjsXWkkjq1Zx6GWL2Hs4wo8BCH8iI0Ftseg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGLtYZ+WsgwrC4RyBYezgR1+9np2OigaMvHqVJcSwZQ=;
 b=nAdPSQt9Lvy/oPdEpWYpGNnmTrl0JR/82MSwg8Vf9L2HKrEHSFV2BBHa4SIMJ6k1i4wi6XFFbmq2LsSRFvXdcOxXydaNpfrdERDUsJYb44CJwpS7KcU9po2gpVc1Y1ApwNOzcm1Zi9AYX7PCP44tBUzzRBQ6OJ3s0EvuxsgE8P4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6600.namprd04.prod.outlook.com (2603:10b6:a03:1da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Tue, 26 Jan
 2021 19:23:46 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 19:23:46 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Martin Wilck <martin.wilck@suse.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: RFC: nvme-cli: add "nvme monitor" subcommand
Thread-Topic: RFC: nvme-cli: add "nvme monitor" subcommand
Thread-Index: AQHW89gogC1mLvZpZEW/Svc7xIvEtQ==
Date: Tue, 26 Jan 2021 19:23:46 +0000
Message-ID: <BYAPR04MB4965D8F1CCBC27D60B242B7486BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <79bd830da01238e1b36dd8e858e7cc29fcbf2876.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:b091:5edc:1473:bf45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2dea4205-81e8-4b8b-565f-08d8c22fe70f
x-ms-traffictypediagnostic: BY5PR04MB6600:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB66002B88AC5373DB12F5C20C86BC9@BY5PR04MB6600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqMvXkvu47tU7jdfZKvYt659qDgig8VWgFLJ4q3qNGSnNp8bzwHDuouHTygnZcU9mvf/a/Ug6wBimVrXWe+qtG+O20V8C2MTHtVVpyHjml+LMJ+abcuzUULMFJkV5WGHJHehFIslDL6ZANyM+MJCSnFoxOaU0YKTD/FTM4uj+pwKaJ8tPYOEsmIfe7cPwB6ZNe6kllcrO+YKhX2vQpUMWVHJ6c6OokeD7JRTuxJBF65Cxn/5UdUuJ3A40ODuGm4xBtel7+CbeOFdFhUHT82e2edUo8SwaEKGaUWxqRTQvYaPQke+442VASzfwGaJfRc3qnCbvWJp/nnGNbhKsTdiJKlBTPP6ARF7ByjGEdGn9ncUkDDHZ56Hn0AHREz8pvfnZf1YxDp1EYkYdxF63Ly+2jJU9nDtwmZkcM+vW1Yn0B97VdbSXvDh003F5QRHwA4WoaRy54OGRdFI5yafUP5qbOk2NXdTyxxHMue/59ERLfDXoRrf2aZZEu13uNeceiVAxIJKFgocc/s4ZWQYzGpAF62vyQScX2nOkbbtn4yz+9bvUdOR1VsRzkbVHtSpSBTNssex6KCJNELzRcwoB+8jquYC39ew/r7JxdKZ0KEzDX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(33656002)(66556008)(91956017)(316002)(2906002)(8936002)(86362001)(4744005)(66446008)(52536014)(66476007)(64756008)(66946007)(76116006)(7696005)(5660300002)(110136005)(186003)(9686003)(478600001)(54906003)(53546011)(7416002)(8676002)(6506007)(4326008)(71200400001)(966005)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1HXneihZhDNq74iLgsMSJFnYgPD+euuvfUb9PaCsR+JMWCK46lwiysLv+D/I?=
 =?us-ascii?Q?KYn0H/bxeVVobpDtiqpCJDpivvr2Bb3R2HMzmMlyLvIMfJHBfhkrUR9VhKik?=
 =?us-ascii?Q?I41iGDSkM3Dix4aRtlswlYInukxfy92P/Fgbv43QyH1xImFujzfWmkaJJwWT?=
 =?us-ascii?Q?zU38v9RBvEj8e8f/7V2lngWLHlmrnEipMe9TcV09xlUiZzqBp1PxEakdGWsG?=
 =?us-ascii?Q?UPiURIguT5J0RcfVBzb45wfiYQpeIb4uHa1tz+frUcSrTR35KwIvMK1wbjZT?=
 =?us-ascii?Q?N+HTsKGrfEt8pQucvgTqZLfW+LryAhvhUNrnlXD9jMLGjWr/Xda1wvNs6718?=
 =?us-ascii?Q?b21rmIl5tYgz4xoNUndcbjqxAaBhZWEo0TCD3vLM9JXmKiUHQX3ZvXh007qu?=
 =?us-ascii?Q?Hf6JOduJaIy+LHfXRz/gFdYnRpRwseZVxnEvDAX1p525O5rFbS6r7gTSNdOn?=
 =?us-ascii?Q?EtTSHU48p2mjrPgnJwc5Ts3EMtmqpHKKVjP9fq4AP2JRp3yIINDqLHnW+po2?=
 =?us-ascii?Q?1qIcM7bxiV7ErGJAN6x5U8ewqH/D53uiSeZpZxUwC7svXTfc4sHXltc8SCqo?=
 =?us-ascii?Q?sC0zrQO/JCxhtGp7pVJZ7C6OFq3NEnWnauH/UpSq7lC6BFpwXFYJ9p89zIDN?=
 =?us-ascii?Q?8NBZtbg1iJu0JNHL90s3UaxGjJ3TwzU7tX5Pc+ApGBszte1Hq/F194WVWgko?=
 =?us-ascii?Q?YNyTkDwW1EBk4dAeau2Hd7sltqGZvqkmVAUp8+DXRdsg5ddcMNJg6MvK0wYE?=
 =?us-ascii?Q?rCJnMA7jAkXBkjTYl/aFWAgklZ0w3bAh1yt6K0RcNGa4G/w+AcweK/lufY51?=
 =?us-ascii?Q?FIl1At3Lj4b0nt51NdTIPoZhyQ5Uihxgu/8Opf7TOZmn2JgmIlBpD75rfbzM?=
 =?us-ascii?Q?okzzH1I2vP22JSg7f9GBZBAP96iGsLIXIqpXczXEgzlL6lldZIlCNy3XIU+R?=
 =?us-ascii?Q?HBgLf635fwwXOcTr+IU+3PKR0dyREvhTVLb1hXCQlbIqroH9YbNSbohquOx1?=
 =?us-ascii?Q?bGLZlwpbughO7aAtibmNCtKcQguD3Iglo2Vddr557rkItT9aaGOwfQBUO4b/?=
 =?us-ascii?Q?zhilUD0Z5VfWxxUagTFLuR4OwypuTf0PSULfm+OUOPbal3QMN7j6UC2Ps3x2?=
 =?us-ascii?Q?oNywmf7MWx1DaGbGZrLNpz9KbuBG4cKBWg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dea4205-81e8-4b8b-565f-08d8c22fe70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 19:23:46.8179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDGvXdXh8y4FW6Bwfo/dEtKZIT+Q6nTH7REF0zzm13lArBktITAFe/m+EK1+ZPrlpUJL0EGNLLT4lhOajZMKRRlH76pd1HcwxQxFAFVwDRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6600
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_142351_250558_1B80FEAB 
X-CRM114-Status: GOOD (  13.14  )
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
Cc: Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "Steve.Schremmer@netapp.com" <Steve.Schremmer@netapp.com>,
 "marting@netapp.com" <marting@netapp.com>, "hch@lst.de" <hch@lst.de>,
 Matias Bjorling <Matias.Bjorling@wdc.com>,
 "johnm@netapp.com" <johnm@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/26/21 3:48 AM, Martin Wilck wrote:
> Currently it handles only AENs and NVME-FC uevents, but it can be
> extended to other protocols in the future.
>
> Following the "publish early" principle, I'm posting this here now.
> My test results were positive so far.
>
> I've created a github PR with all the details here, please have a look:
>
> https://github.com/linux-nvme/nvme-cli/pull/877
>
> Issues with the CI came up after I submitted this, I'm working on that.

I had this in mind for a while especially with AENs for ZNS and other
device features.

Can you please create a patchset and post it on the mailing list ? also
please CC me.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
