Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4161CC433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:51:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA5D61008
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA5D61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=MaiEbYi4tfQ9ij94+hiFPLSKmEHwKXZROKgU6wGyT8M=; b=DDqpIFzad7+m3sr9lpAIgWKbw
	7I5PTmJepwIZfNljr0R1yskMfhRnjr3L+H47QUTctqX6mClsqOm+Ewb6KOii9/CjlL1KQ9aJu3FzF
	7RZAvmtZ5KOSFdaQ/GLz3Sfi6DABVxt6KErVjlLGSAlIhm9tDGqIk5OhcXpo922wsyfCyiM9rLLUt
	SrUoQU4wBs/gg3EaTSLd3+aYe/+0F+LZRA6JwTIuROneYqx0uPlZuRZBK7KMT8PXlXa1IsoBiNxiX
	0QFz/kE47M/JBEjz1rIhKzSrTeuV+UFVGwZD6vdqzR0H76dm2I/X7WRE/lKSB5wNHkuLve1f7uTHR
	b4yVT+JxA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUhEN-009lV2-18; Fri, 09 Apr 2021 02:50:49 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUhEC-009lTT-Ca
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 02:50:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617936636; x=1649472636;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=tkZlJNJdE4HCqsZAbMYkXniHkTcQm7cv/8lY85d/bvA=;
 b=QNePwtoPBAZM/kwXnmklR4QX5WggWCYsujmzre/l4f1KMhFT8Ud43h8i
 SKUGbt7khShMaCjZit23zatJf7Kw1rWyJTTAkYQ3KvPerekAdlXd00ohi
 GrOvLzOD7mVIwwwP7o28w/Hg1pXS3G8wHeKY7kmg4tQeW50KH3nJbky/7
 PZLv6uISJrWlFlCzvFd0uqs92DsErarokmS+FDDqWoDHN+3J7hYbbl0C+
 azHJzXHvVmhEnwx/WAx6wq7iqIWlP3pkwCBSh4Tu7jpMltX3p8TIT1n6B
 M+WP540KkpAyBxVkW51r/IBOVrIAyRvC+ugm8ZMdAH2Rf0/FKsUYfdndF w==;
IronPort-SDR: B3tPz/p1H1ZKZsNieA/A47Gk7ebMTtxwdjcS8ksNCX4qpS42xjPN4VoOwgl9ie3sM4Ap4/RsXg
 NGZvgn0ASz3BUOGOxa5JIMeyu4sONib1A1eXNiHjU/Xt+lM/SuDHbctEs3HV/2o2pOr6ZUPfUW
 cSRlnTDurgPHH2fVIFacLpikYupK5YD6OqLZWF+kEE2sWEUUkA/4RIBv3FlJTtGW4Le3BBbedM
 sWVvJ6TqHIFCIOW7w2nurMlyvNeaV5G4UlzhFf0zxiw8QA8yOW7cJLQphmdktbw4g6vF+Om9zm
 ehs=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="163963797"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 10:49:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coKN1HrDev4xQZSE8GpgBPGTVmfa9EAoZLmxeGXmjce1Zj/EpssD1b/GsUdnapXulYBd9jXZSzx6dUTIg9CtcryxuBWmYBC5BcQOYd6uIKsCcCm1Jmj6yImV97ef411/UZIIuRCdjBSG1a1VwFNfFpMjvt+IjgEZzUSGRr1FCMxrL/NH9jdhvdVR9eHPGtIHb75cs642Gsz6B1qW5a3D7Btx2rg2Jf66w/WFGP3yeUg3pxREzLd41fRd8cgAr5j6MjD3SuOD3TivmUWhu8oGeZVwC3igu6ftt0GqzwAoqEk2FgCA7KLyDHpgL/CIB436mD/DibAPSWMnDLRXbSs/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkZlJNJdE4HCqsZAbMYkXniHkTcQm7cv/8lY85d/bvA=;
 b=R8ajBGX0Hxh7p52xr6zJrSi+/mVSsjIwX5Z2sZ5v7sIcSAmg81CrUiUNIGC4a1VL6o52WcNWfyBfoCG7rvNYrYnY0hYk4V5XNsx5z6t3W8ypKPPomCtb75SFvQ/usafvamIqZSC1iKuTmO915lZbUFLdcjbf2ydCxueCGC8Zymivi7zJjSNmjRZhnKJQKvbJivACe+I58blDVCNhGPvXvZMf+lLMMOHU+NNNVhltxGVkzmgG4tD0S3cQK0gtga1+lh+44a73t2TajaQhNqYMtHml8vK6y16KjmFcmsU3LshhHyNPBDXB9EJOEKP4rnkUuDZYqw6xz2trhLgJiNc0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkZlJNJdE4HCqsZAbMYkXniHkTcQm7cv/8lY85d/bvA=;
 b=AFXTRvZzp/FCOyLTWWtoJBQs8axfn0RltgfMkubq+qNnBlKIrDLck3AZNgcM6CkkPaWM2J/zYpidaqG4IAit8zwrL9k0lSwpa9+6u8WqlFKYlXM7gnHlzMW0xDdFV7xMC92BCAAI+8ysZDPzTEqI1M9duTf6juGkZxrUv697LMI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7437.namprd04.prod.outlook.com (2603:10b6:a03:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 02:48:29 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 02:48:29 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Kanchan Joshi <joshiiitr@gmail.com>, Javier Gonz??lez
 <javier.gonz@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 11/13] nvme: factor out nvme_ns_open and nvme_ns_release
 helpers
Thread-Topic: [PATCH 11/13] nvme: factor out nvme_ns_open and nvme_ns_release
 helpers
Thread-Index: AQHXLHOiTOQ39YfwcUaOjKWubsFCdw==
Date: Fri, 9 Apr 2021 02:48:29 +0000
Message-ID: <BYAPR04MB4965EE9D70920197F1A9156D86739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f834a0c3-5593-437d-2835-08d8fb01f512
x-ms-traffictypediagnostic: SJ0PR04MB7437:
x-microsoft-antispam-prvs: <SJ0PR04MB74377F4F97074DF8849FA2B386739@SJ0PR04MB7437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRPS7nezc2tYq7RnAoIdAAVLdSm5E/Nc7kOozJC2yo4ZaXmmXwJrVqu3KJNYk4SlSXEHc5yLV0rM1lkZke3gK4AMgTgl0UOAD48nnZ1imZoxOEVUygblVxBRYLpM0yn4d7g1ujphso4nicWghPK6x1c/D8wB1qkrwHYWK/XiJxZ0aLpJ/wWgAwretPLVr5VCMJXG66ZWb5/spbsfmABToNqZZ1b48S62uUfQNR8xWmZp2Siesp9hexJU/C9ywubff2Rsx5P3zmdv6f4Q5Dz1Dm4EGp8+Ni7hyZdgIzJajiSvtOKvZAtjij69ez+bickHBCiEoQf08KGKRwNBi4PjquNIQS+w/heuoqjaS9VqNaFLfmpwXaNtBQaPi/85qnnYTwv5NbcirpA1C9u1exS7/g7OxWRlyllfBbWtJMtEX8ZdR0zotOnv+QuEgGu/iC17fWeQ3WmJMtuDrgTLWTgk/+2H3Wg5og/RtDp1JA5fl42i03iiM8abKze6S4/Rk+G68lueFvGfRnj28jOMFmoQVKfFaCW1DHTNoK/Kg08/6WqmsBgWxgf1BxPBip9Ijr/A94+Ne7AqWow2lmgiZbOn1cYyPurlRmmfbedVkphYVlOv2MZf05lGutCXkMDG2dIzxuXL2H1Sy8tnntTw6puXw9racBP/0dLx9gIuIs44cW8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(2906002)(52536014)(478600001)(53546011)(6506007)(54906003)(186003)(66476007)(66446008)(64756008)(110136005)(66556008)(86362001)(66946007)(76116006)(8676002)(71200400001)(8936002)(4326008)(9686003)(33656002)(55016002)(38100700001)(7696005)(558084003)(316002)(26005)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cwXymuxMg7SSr88A99PDHo9V1qNPg6RV/PyQfHPWoRMfdh5WAbNHsaOMkZ47?=
 =?us-ascii?Q?rklj6GOl0hm9e0BWE/I270oaznaFhyZDjPPK22ee+2TE+MnRuVGK4iskwGa7?=
 =?us-ascii?Q?uun4KKH3h98jxIxjTWbs+o7DU4uPC/dPr/DqXGnen5t33uRCcc5nmA5/nOcp?=
 =?us-ascii?Q?LBpbux1uDdMU3fNhqzqE84RkYY8OJ0PWDZnXiwixYbqBWZuB06sWwKfFBW3x?=
 =?us-ascii?Q?Oxjtbed2igxJT0U/77D2hmFjajfxsKNZiEzQgkcgXS9WqajA4Fo8WXIIyc9O?=
 =?us-ascii?Q?cm1RpZKlIvW6lwZ0jZZTFzPGvkJuAmjySF/Atcj0UTQm0sJCuC9xOkqTDtcF?=
 =?us-ascii?Q?6e6X+mbNrgpvrmWHk7Q7pVVmX+V+QHMrjFhJPCBuNWZ5F8hLpclaDZfD4PSR?=
 =?us-ascii?Q?q0Alyo5Ik9aH6wrusGwfTZOYOvMbpJ0mznjM1ZX6DEOgMOg4i8BbWSBLSgkm?=
 =?us-ascii?Q?qdSAVR+XC+4V76aSlmv4Cx0jmxmktY4FZuHfB6cLfMQ7p+EDZ5acINH443Xb?=
 =?us-ascii?Q?PMfTFqSRapxqi6uh8x+F0bPAr9QCVQZ5dIiPlNklI9YmvsqGgzsK9h3bUXEQ?=
 =?us-ascii?Q?hcgm0Ux7E6/R4TMA/UNfLCncv1oFHIgqJ49J2vFLEPGvYHxssrwGaGdLkR1d?=
 =?us-ascii?Q?s8TUoz1vltE2+LaANM8/jM86/UEv/TtTgZpOIiDwUqOpj1h6/O95B1B9z1TK?=
 =?us-ascii?Q?RxTb8+88zMVePcHcNqcUMlEUO527lU/uAZcI7g6XjUr8Qtt4NIyX18xwx9qp?=
 =?us-ascii?Q?OUDFh91WqwuCqPJXYjexILMBgHkWuwwStbL0xFJP43HfKPbd2GZh/ODkwcYh?=
 =?us-ascii?Q?Fz0nwCgZOFeG0feNQgdQBo0lAD1HiJvGyUtZYByuUA9VcYb6kIZI/n84zHrx?=
 =?us-ascii?Q?O4HP6wVg/FCx4KdT2EmCcN3OoBMvcZ3YOaZMV1uSOZhBmVqw+1tUS7UL3nrC?=
 =?us-ascii?Q?5N7kSBEOURzODLSpzKuVT0iEck0cBil1TqKAnm7qntRNLAKn5arAZ7D9COAR?=
 =?us-ascii?Q?DsrIERg1klKQqC2qlI2fManHJmUdz47SZD7mc6YkRL8nGFIG4U5FT36Lzhl+?=
 =?us-ascii?Q?yhbl+cCfK3nBwTfkwggMo7H2xIGtPbwN2sIa6q9ZSzhZ558FcveUPF9fzzUM?=
 =?us-ascii?Q?0+V69MIS+F4ISO7ev2SfU9XS5U0U7dDXUkyLVVp/s0k+PJF1Q5xOK5iYlEE/?=
 =?us-ascii?Q?twqTqKzz7UlzBhyF6xCHwFU1MOXKZUyZb/UHd9bEHd1Y7HYnTcM6A2hmky0H?=
 =?us-ascii?Q?5m6htRqZopg/HMAu2v54eyZBlm1n019yif5fC1UDM2G28Gm37+HuGKc7/KZK?=
 =?us-ascii?Q?VMGhm7iG9YTm4piIJyUr3VeWQIY4szjLmm4fESqg4xPLfA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f834a0c3-5593-437d-2835-08d8fb01f512
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:48:29.6572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZBngca5ku5Zj+w03K1ZkJUK2f+lQsk/sSkqJBMNuBHG9j5Kt7n3Ko34HH3a7MXkVksxhujKwT7oH6Ftf4urQYu/U/mqoDZKI4kzrwuE/fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_035037_639590_5A5C1625 
X-CRM114-Status: UNSURE (   9.52  )
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

On 4/8/21 05:35, Christoph Hellwig wrote:
> These will be reused for the per-namespace character devices.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
