Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD7EC47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 21:50:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A2B613C5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 21:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A2B613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=U1ingLkX8nf39V4QW/nPQ4yaMXXhgT/ROllLL8QlT9U=; b=3hisihAO3d8Ihu
	5srZQlfpk8C2LtWmOsDOdZCXfltvHhO9A6UA7YPFFNk99TmzU0BvCgOx+XWiWq5l5xc7AxOIg9PAB
	rKoK/q1slc9uPKkBm2FNCBgTUN/+Itqtaq5cUSeSEwp022RcYY1Fke8uRGIS11F6i80F2XrCfz5cd
	/PVwUwEKPW2511Az7eBq/DhnxUDV4jUJnGwnM1WRxMFjr73yek1sa0QrhfwEkbnEUO9jtb9rmZNm8
	EIU6376Carg99kLGSAeONDSUfUuqRl8qlh2xv4nd1eQ5j7rZkP3hYM9ub2hP/SAsm727Ztjn+wgV5
	A6b0vxZCkHwkwtSMznQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lm1Q7-000FmG-NE; Wed, 26 May 2021 21:50:31 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lm1Q2-000Fiw-SD
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 21:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622065826; x=1653601826;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ThLoD4CZYL3gUIaMppkNkJwWMTviIApfOMVCqT3Xm3g=;
 b=JYrqpMK8dyuGDxCADQyraHlgL5Fcz0gjHk//CSGhiHXETylW+L3vPgQ7
 DJuFnhkL7EpXym3nssiPnFsOE2WhKkWYWV9txBAuy9UUeTZCoj/gVM8YO
 OQpabDsnzleEEXGJ2Ik7yYPQYsQjCs5PAVFWDBrIWMIpii3bvgr1H3bcN
 j8z7rmj8zxLXYvjh4LSgqyrAUpOFZj2GxoMzbxZgy2THFgHLr62L02AP2
 rMjqSHxFumNBlEgY/VFnUhoqBT0VqTpecWXv/Enduj4zklJkZoAIJSqXw
 SiT4UgZhoZkoKrjQurN7FqCPHoOIZn48YuBuLnjpQQvjPanRp4r3/cPFv A==;
IronPort-SDR: qwesub9c4SsC9Fjyh78Rm/YVB1c99CQ9+oERy4o8uy+R+TwbSRuNVlak2OSW3QPKAMPIqoC84N
 qjhaqhb510PVtSlmbex2/+j6VGBQlFt+ha5SATtnTpbGUXBRYjqu+C4+cmCMmdiej4qYl5bvCq
 1QlZ1wCOVGliwObfXkagGctUZ3P0Wk9WNFMPjJwsJa08k9hGNHC9yIXUErrqASAeCskA5Poqy7
 y17F6e3xVFEi9FaQkHPN3U/TaFcevubUsxhqIcnWICqmd6svCcpeMTHzGtzsVSKDEYPoq2SiBT
 jAo=
X-IronPort-AV: E=Sophos;i="5.82,331,1613404800"; d="scan'208";a="168855234"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 05:50:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6mzkFW4rKz1559aof0SBR3hfEpNFvOiqs8TUMQfsF8uZcnEVx29FJLMHWXIgceimRnwi79S9hv1cKSnjTs2WQy4jxuC5K+gmJWDE8bLhvv6BqWZmmnZxNpm/pILPmwCnYVuGduvhITn0LRZ6RSq9T1goa9u+3+W7bFEj94cCvtyskW7/0kfepo8sz3dJfpHLxbRjGsIMnDDNDL4FD3bmUlewrpkDo44ODXiVYe8kU9C9WYaf7mvGYWvTudqFFWqeTFoEIQrq8JM9KgtAPQhP+ecEM3otLNnwcq14UwWDd45xWkuVE+68iZCVRqTZOxQVzVKnbTubk5nDz1Dw++cUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThLoD4CZYL3gUIaMppkNkJwWMTviIApfOMVCqT3Xm3g=;
 b=FLgEY8oTMMrj1kzRvm/2dCIERVKLfZ7Vb4njBaa7k+RZOOMt00fEJG8WBBQTqFZHR9oEQx53mmwPFBQCbNmpdhQFT1QRtQ2J/07JiHMfGMxGTt8NFZMjBBH9nUZFcXwmiv6nrChr3p1VGHKEzQihwx+kRay2z9vg7W65EkDuIC4XBhdfYHBdBbz5niFwt99u2ip6cd5aFjyTRfx2BdNxohtyUAv7lUyYj0RrZO+Jmmfgnk4dg1A/Ge8VnTtD+06Gi+PnpzrLpVX6BX/pJRbs4BrPQgwMOGFeOheR1go9e4HrYKDlSrTn58i2pmZSMqDw+cCtj/RFN3NjEBido5PQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThLoD4CZYL3gUIaMppkNkJwWMTviIApfOMVCqT3Xm3g=;
 b=qZvKGmTDGg2vzQTGnuCfTnG5WwPrwG8jeptlBouybL/FRr56RLfPEUI/2gHaonSkAStgkPAocjpIXeuv67tRhypCpjACv9+DqdkIwHlmchc8YOjvzR7tDEGtzS24FjY0gw4e0+oGtSirzLNnf5xpTGsXAs20UyXifmHImid0eFQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Wed, 26 May
 2021 21:50:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 21:50:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Jonathan Wright <jonathan@knownhost.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
Thread-Topic: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
Thread-Index: AQHXUnEoFF8eaU/PYUSIccVX00aCFw==
Date: Wed, 26 May 2021 21:50:23 +0000
Message-ID: <BYAPR04MB49650971173C72A97AC8B0D186249@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <ffae89d5-05d8-e0a4-ca71-b3db18f70286@knownhost.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: knownhost.com; dkim=none (message not signed)
 header.d=none;knownhost.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16976b75-ce64-43e8-788d-08d92090442f
x-ms-traffictypediagnostic: BYAPR04MB5431:
x-microsoft-antispam-prvs: <BYAPR04MB5431892BB6E2A5BABFC89CAE86249@BYAPR04MB5431.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixalQf/bwf4OAU2xjnH8N6HoW+dtgoBUiOgGS0M8c4COwyeY5dcBnjmLSFU2KPVFV7O+buI30RWDQgCX6Vb8Qx5YXgfZeUwZOkD7aFvaCWo5MU7PHhSdfBxqa3imO0wO8koZXZZ2tmHaQ1xyiQlhewXdr1V7sFd3eenIyQodL/6LUrLDNqRgH7SVRnc2+jYFvH09hODWLI/b8I/N5nIeryc0Tj8B/EVwHVPMDQ3nvtm6vzQ+cnuIIvJbCXHQvB1AUvXu7UHDWluLVR1qdn8+1KvmEjYVG3CcXDOpRn9XR2pzQyN2rMir7jVd0wfdi6beF/vSk2FR3n2jvlLwv6lmYAt65ysy0Kd/mf775vhdPaaPBfgMi7/RNKhJuxLAQvx01AdfLjTeNi8qPgTlCD+XhiCowQ/Vh6vPsMbEIAAk7zmFsD9wFge6CTAqASPQp6/W0Yy37SWeiJX48gPLpF8NqjQw+PNEAM9yh9CcmJ/Q+O4zN1DtYVB9ZEUAV1IAy95e6T+/nPaUFMNx57YE3sg/JwdSsjbxrjR85666KshH0EErj2Z5uKSft4rbcQkUfY8+mMO/jBjeh89kBfIoLDkRAVefQGSocvjzIBJjLZHLKo0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(38100700002)(86362001)(8676002)(9686003)(2906002)(26005)(66476007)(53546011)(64756008)(4744005)(52536014)(66556008)(6506007)(5660300002)(76116006)(55016002)(122000001)(66946007)(66446008)(7696005)(478600001)(110136005)(71200400001)(8936002)(33656002)(316002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SkR0fqh46VVUDPwvTYGvi20SJbs5Zaul/6ePasf2CCa0P4MEfvXevLoDeNj9?=
 =?us-ascii?Q?P4HhS2uJwNRL2cBoNm5KQzV7VX0NgPmC1MCLcj0AToO53Rz1JhvjlzRNJiAI?=
 =?us-ascii?Q?a4Ogc3Bd+VixxcmpUfWLZ4Bt6Hm0g368VZty8BIt1PvErpnTbXhfPRhhaGNK?=
 =?us-ascii?Q?1hBmNBZsJFkaRw4qwv2/WlpZ6wYRJhDiLClBD6lxx3pitKOk0fUYk5aDFYK+?=
 =?us-ascii?Q?QWS+JyGItDWe5s/JtlfJn2j9xAzBX5P5ZaTpzsZCQOEpJkZkePgDpIfjeV6l?=
 =?us-ascii?Q?AjxiCMrrD7hELQv3AgJLP/1QbFaEZITk32AwKbExJp6PVRtiuTCFWHGCT449?=
 =?us-ascii?Q?YCtQQUGkYIMBO+SmORSs+xf09UlutxhuZZB2HrpUkITIi2M7+q1gTl5M2rzb?=
 =?us-ascii?Q?bNaPd9xbZyRO9We+tIoD+asAH3ZgaA93QFlZKg9qW/PYqmWJqUwb2LDXulI7?=
 =?us-ascii?Q?0RhBLKWzbl4LJoN1G71g4+ouv1EQjbGssdea8QAuO9YfLQWGmDtRInWswVLZ?=
 =?us-ascii?Q?DmMV+dcwvuSf2vLXFLUIEwFjp9UnLhxpdJknWrFQIhn7yONsQ+BDZnZ/CyWE?=
 =?us-ascii?Q?1eNA+tk7kcAQdR9Kpxi53sZQbytvDxRdX6MyKSxOG97WE6eGxG4E6npDqmiP?=
 =?us-ascii?Q?1vbMDYMIqdX2ENAKJzXa1tu0N5BRKORqJ+pv0ShLJJLIHOSsY0DHLEIXEJZk?=
 =?us-ascii?Q?ILnG6W+aTLrswoK3UvY9KqF8WAAfpb/SNYtx/nP0gJNYtwHM4VGhJ7PcJ/XS?=
 =?us-ascii?Q?E/fEOY96HzUVpZ1H5juw3QIavldl96lLHPs1ALfFxrfXuXIfNsazwUoRVpFY?=
 =?us-ascii?Q?/+TT26xDX7qR6SpeVoc9+llVUFBIj2JRrPEPVpR7Kgd/xAxnN7QF00UMqenT?=
 =?us-ascii?Q?EtSF/WRaFrePJBW47vahSs5/9JSYDSSRv5mDu6WuUOhPKlV9RdZkYSW4qAIV?=
 =?us-ascii?Q?rYlU5hXkglQ8rBW+JkMvb7Ndff2XlRSR3Z3ZXUsBPjgz5iyxKHQWfBS8McU+?=
 =?us-ascii?Q?8OEV072LL0dzmz/XwoVK/y60U2wbNgSAVcJQQBMSWZ2zM0aBI418xLTLUetv?=
 =?us-ascii?Q?3zZODqCXNfYIZcbS/qoGTR7L3PnM4m3eO1jELkDgBN3+g3VVnOVBbDHIbIMC?=
 =?us-ascii?Q?Ne7jtc2EL7WLAy28Uh09YDG4RE+ad/DSTFuex3u6+vq9MX+cJz9lrnSiiWmB?=
 =?us-ascii?Q?UT6WOUg1+N721W9g/0zuF2m2IaGpvNbob9ielXCi2WdrhXZQ9a58kZ8YUxes?=
 =?us-ascii?Q?I8VjuB4M9pf/64LZ5XWeWIbeyOM0EqsqL7GxvDHIMkGV1A4fBL5vwj2Z55Fb?=
 =?us-ascii?Q?WbpWvLLRbl85Gir5bp+kQ2um?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16976b75-ce64-43e8-788d-08d92090442f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 21:50:23.9917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80fFdjOttFcvJxwmIbEfRaN3E8gWeOI/mLmCU9i26y9DmOZ7lWngiWOgRql6m62+ELyfkl7Acez35DNGwpFq/eEzaPZsUfxhNMagKoPvz1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_145027_107925_442C5B82 
X-CRM114-Status: GOOD (  10.96  )
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

On 5/26/21 13:53, Jonathan Wright wrote:
> Here are some things I've tried which make no difference (or make things 
> worse):
>
> Ubuntu 20.04.2 kernel 5.4.
> Ubuntu 20.04.2 kernel 5.8
> Ubuntu 20.04.2 kernel 5.10
> CentOS 8 kernel 4.18
> CentOS 8 kernel 5.10 (from elrepo)
> CentOS 8 kernel 5.12 (from elrepo) - whole system actually freezes upon 
> "nvme connect" command on this one
> With and without multipath (native)
> With and without round-robin on multipath (native)
> Different NVMe drive models
> With and without PFC
> 10G DAC
> 25G DAC
> 25G DAC negotiated at 10G
> With and without a switch
> iWARP and RoCE2

I think you need to talk to respective distros.

Have you seen any issues with the nvme repo branch 5.14 ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
