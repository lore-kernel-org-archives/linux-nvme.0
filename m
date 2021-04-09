Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B11C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 04:01:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753C5610C8
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 04:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753C5610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=6cM24Q0KExqFFn4tLzQWwKF7cZ+H2SxIL9py/UpU7qo=; b=aJZpBWejjOQvBwE+D+ze8didE
	YX4B9y0KVjWMREM2oooXYbA/a0rM/pj8V8OfLX0GFVQrmO0x5qXlG+4XJCmJTqOmqhZ7ZXJtvkVOL
	sV8zbGZiHdb62U/DXaamb9fK2QH7p5eGlQd1eTwNYR8v+hbWWnb0Oyrm7mDSkDf5NwLx4EsVTqnWq
	n25v8EQS0+8WpKqCZGl/jhr4/wD97C0vJiIutKX1isoExxifbSkgG2wf6QG/ad8gfTnLGggU018Ya
	JdTb+30hQdIEoi0Uc3nmPsis6xEQLICANIExdtmzUY79UOZgScsJ+ilUtWmvGc6GlQ21+nY646caJ
	UH3VFol6w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUiKb-009x06-8Y; Fri, 09 Apr 2021 04:01:17 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUiKM-009wyp-F2
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 04:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617940862; x=1649476862;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=gVceSqMS6NheC71oxwKXUyOOELYzYkxE88ncg5KuOFI=;
 b=V6rTkKgH4fDIqvVVjJ2JsyKeDsNEjbnpPKYcyyzy2QS21bZBknpQ56Gk
 duFaDNm64/56s4QVQ88XY+AVFbMTOZP3rQWgagbuAyxT8ZQEho892RqS9
 8DSh8mfkrVYqZ0ffRpxpJDPRrUj1UMbwaT9HSbzboKmFqENyrGW9O39bM
 Eh3ijoBvOeNNNz8a6/4MOPCEefHlCxHQfmO7IHCNdXChXABof70aWxtwB
 hO02stfw4qKpW3Of5jGA4+fFtvDLthMuVlIz9YQVN1PMU4Ory/BWIBsZE
 GiTvWwNvN36MOSviSDvNNIkL6drkuugjnjT0gnPHswjovF9rbbRyqtILV g==;
IronPort-SDR: 5SUtSzrRL7h/s2K2Zy06/efTZ3G7VHFHMcmwRUVyqvWaGyRb58z7kkCTQ3sn1+GLMZ6tf3tI6q
 a6QREp8G2fTQYAVOara7KynL4ez+RAl3AQeY8gvuHsk5K1sl5e/Toznn2KAnljAJ5IADnrIdHC
 tNLRFn8UMch/umShfCVFyoDtcG18F7Tikvy2hVmmg6No0n9ItDCgls07JWH+fzcAD2bn+U8r1t
 tOZKZmpI8vQWoXsjajyFXJPoTUCMiiLpaXcT+DxP8Kq46vGFZBumhLqLcVqF0tVCXU0UfFRD3i
 hCE=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="163967965"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 11:58:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfsBwXqqJBIfx9r0GlVya+hstWGE1fjXAeysTYYQdsNByZPH+0GE97Xv42sBbQ08LojkODrXZ/u0MQM5NEhyigfnjHX+L0JxsqYiqFuaeyNQy9ZjvXAnOMx/keBm6uqaKXMoPmtbH/5V48bsfZJHfGcwcGP8UXB16j8aBjXV31a3ershc8tqY4x3vdg1mt2xppYWgp2L5ZwL9i+UeXFmEpzR4qIqvIy/+hSpSRrIV3SfFy7DLVzk9KQkhEz23+Hf8lQrBZtZZELzGcp0NEHdHCAyy9siyfQWiMb62tesqIRmUaAkA8IsizIiix86p1V+QwtSBgaSI3+48yCe5PQcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVceSqMS6NheC71oxwKXUyOOELYzYkxE88ncg5KuOFI=;
 b=ca/htqftBEeUTd4DbJje7DjG7V0J7YyJNdGoo+YfWw5h7Svxu4mcj+3llEN7hFJb8QJrvJvGGF76qbygQ/u9Ted84M/9N7qTFQE0H2t2JwA+NCfIVCbKUPNRMUKwiRnKCbMEfu8j8gqyc2H/LKe56BD4ZH0L8Tc5g08Kea+DvgpjQPfgXeYNG4L9Q8SFPBwV/mbXQKXHzFMlHIOM16PTN0lXy257oI+J7igtUcSHeIciMPGZD57S0YU0r7ZvoNP+0MvYkqlh6vZy2rN5S4z8I779qbe7IPsSmi1R40PDM1fFH0flZJdzGseni2ONCnSMQV44QXLe3Win+TjJc5rsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVceSqMS6NheC71oxwKXUyOOELYzYkxE88ncg5KuOFI=;
 b=Mc5/s9FFsSmgeDF2Ti95pq7dYMIkaAHNTrb7hQIkgCS+cqWmelW6xjXHKqF/NMjLzhv+eSJ05N5o1cCdxuMILzVneN6NI7d4iNIP87ULg5IpMA6jARk8ZUth5vPv47OB+wJUC4D3vpGyNcjS9ZIlmoqxxmPUxaN1Mvrlf6w5QS0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4982.namprd04.prod.outlook.com (2603:10b6:a03:4c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 9 Apr
 2021 03:58:46 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 03:58:46 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "tasleson@redhat.com"
 <tasleson@redhat.com>, "tbzatek@redhat.com" <tbzatek@redhat.com>,
 "prakash.v@samsung.com" <prakash.v@samsung.com>, "d.palani@samsung.com"
 <d.palani@samsung.com>, "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>, "mohit.kap@samsung.com"
 <mohit.kap@samsung.com>, "krish.reddy@samsung.com" <krish.reddy@samsung.com>
Subject: Re: libnvme questions
Thread-Topic: libnvme questions
Thread-Index: AQHXEJkDKinop2xAF0e5sqK7JXt5sg==
Date: Fri, 9 Apr 2021 03:58:46 +0000
Message-ID: <BYAPR04MB49656C8E6D8157608DCF73A686739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
 <BYAPR04MB4965314610B9338D1D6D32E986759@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210408074826.GA12847@test-zns>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 247871b2-2808-40f2-c0a1-08d8fb0bc673
x-ms-traffictypediagnostic: BYAPR04MB4982:
x-microsoft-antispam-prvs: <BYAPR04MB4982E7202CC1EF5E31A6A12886739@BYAPR04MB4982.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bYkqngPvmsZLGRInHGppssXIj4A4jFmZik9wAftZYzhHrWF54xl9HrPgDblz+Cg7An9cCGU2obDUrQta6It9YK8+RxCibt6BnXvxhhWTKG7kTSl25rXI4J6nHDuBSSNFu8BfC531tbO74+J+kyrpK+B4GJp3RSiKBlkvJV/1O4EEjBP1wZC6J6Amqi23/lpnJ4ImIwYHKFmKT2V8aJygE0lqP9/rJfJNgOrIGb1aWuxd8OofxqF7KuifaGe41eaAxsVJdzp1mxnETr+lpGQi9h7gHCkReDWaCoiTCj1C891PiZAtyvg4dswbmDkrOOR/FfryZFt8q8PTqhzxZeSaSKmDyLf/08FnIWklE/QOpWT4VjWz8bIZ0c4i7V/tG7XViH90DyilcVQ+NhCkMFqKZdZ/BCDDGllv696i+c4mGjBhNG+yBtcCBqW9uBI/uKCZWDEgXV9HbJa24aoaJYLGk094BGUxcaCuu6kX+Dv/PtMYnAAMxlrS3xPZMuCSTE/ylYgnioi3PwSeP5k6yR/J2LL/1xEQQJZIya+/t8372P8LgRuvd4+p1k663qasZiKxAHIt81okTO4iAiYUG/zOi45iWr0tm2g3xdWNIDVvhYwP6iC+ivO+rYNy/pItL8y2yES9I8dZQKeh5rRYDMiDzLralnEhi4RNEXXkvcBoqDs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(7416002)(6916009)(26005)(38100700001)(76116006)(8676002)(316002)(33656002)(4326008)(52536014)(71200400001)(66946007)(86362001)(53546011)(6506007)(5660300002)(4744005)(2906002)(7696005)(186003)(54906003)(64756008)(66446008)(66476007)(9686003)(3480700007)(8936002)(478600001)(55016002)(7116003)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B9kqO2ZYbooie5RAQJfRoRjo3w4qRWd94xQrelvph12ra2zpNA6WwFuV9/P2?=
 =?us-ascii?Q?6kIOqsUyfmhqh9+bCJ5ejndsg7y1s/9H1DL5uLjAf8ASQ62z4AMoZbwANLNE?=
 =?us-ascii?Q?SYdaBva/N4KqtmSD6Sl5GGiQT986HCOCDwuvSNBq2HnoHORQ/IQ+hoxbG8Hx?=
 =?us-ascii?Q?A0jEAUIO8ook3rim59Svqq9iNkOa1WMbpLsi7OPQS4nX2Mt0v+ksU6GaoVsi?=
 =?us-ascii?Q?cyb4GGcQOZx9IEOUQDLno59ccvGbuzFfocmGc4qH2RYpuP1gSvylfeMLTSWx?=
 =?us-ascii?Q?jV2dpg5RJ0E5R8r3S4+Y25Bmm2A3XfwCEoaWtZPkk+T45xx1bafkE45oPV/c?=
 =?us-ascii?Q?9oqfB3GSi4SNs9kBX/cKq4de9MtyPPywZCU5dZhyuh+W/KWW0HOuN5OnnM+j?=
 =?us-ascii?Q?0xld/lIC9SYMruiJ6Cb7yYUr1W0Dl1F8PZYpgAUOkRW+Iz2zXmdFXh8mhgGq?=
 =?us-ascii?Q?kz6Zou6xTYhtCkm1tMAUnCpnVldggZbokPfNd/fATUKBIOH0q7+ANPEfj3aH?=
 =?us-ascii?Q?MGn3hcOfxQ5ATsJrT4R8Mk3X4wpdingL4BWKUBBlZe1FGzkNMSs5Stsm/Lbl?=
 =?us-ascii?Q?H2Djen4v8GqDigEABxo4La/9Yj1tV77ak7XMgKTQHL37c1Xo+Kmx/d+zHewd?=
 =?us-ascii?Q?n+kWs/vqvqgDFNyTCQiVSGYjVwJYpps3X7W9iOtkq4Lj6y62A7sDQ8dUD33G?=
 =?us-ascii?Q?SYY7yFVgtRv2NAp4fJkxNJQFH0Fh8r00THdsHfMnF0ZK3Wv5XFhZa8EWtpad?=
 =?us-ascii?Q?bmUmnU6UZqacwnxIxo6LgLTr+lKuqsHTwrljUey3iRnp4K/Pofom0P3noVfK?=
 =?us-ascii?Q?cDeKhXuGDXsJUio/ya2g1XlBeS8sKgNsIZaw525uM3+r6xb+31+df2m8+qi/?=
 =?us-ascii?Q?jJ1A2JdZBZqigQbFxHIX+7KR7x60LTLTLJPstmCjjXehZbqwEzcVtFlDVZb0?=
 =?us-ascii?Q?pZqWKtVdrd4T7Gjx2Coc0FEWOEFR2t8K7fJvN48N+YKpdFBGx1nUPoePwVif?=
 =?us-ascii?Q?EOmz7eaGgwxc6t4zWr3HBtYUia98TqodD7LHSIh64Q1BLXijyIGYdK9YZid5?=
 =?us-ascii?Q?g/LIJ2ikssOkfuDamWa2suuxKajpSK/Nc3x7LUzzuWJ8HD6atR4pXqfmzb77?=
 =?us-ascii?Q?Py0YFIjjQz+7cjDbdvBMu+5KU367ZtDvU44yIkGirX+BypHj5P4F/V6X4n9n?=
 =?us-ascii?Q?umYSNit0sKLk/K75Tt1DFijY3mxXM8RFk762DfziGFqZLSKudtg0Fzl3gjqq?=
 =?us-ascii?Q?QVdVLkWm0mkussdth59H48nZonnhyAk0LA5HfzyoAs7xk6E6njaLiNTsPbCm?=
 =?us-ascii?Q?d8nqVukIxs3u7AMO1wz86MLjy3lP6mREgz7YDFQYI7YvsQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247871b2-2808-40f2-c0a1-08d8fb0bc673
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 03:58:46.3253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPWm7lAZZSiFYLuSKSN9gNILNIbPfxjBAksiMmWg6YbKeokE58hlpWr3Y1wBN8XdXMCIu3K/wKJ/odtJp30bKGcwU8luVxF4/cb55bgpZsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4982
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_050104_519153_7F15F69B 
X-CRM114-Status: GOOD (  10.94  )
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

On 4/8/21 00:52, Padmakar Kalghatgi wrote:
> On Wed, Apr 07, 2021 at 11:16:02PM +0000, Chaitanya Kulkarni wrote:
>> On 4/7/21 05:46, Padmakar Kalghatgi wrote:
>>> Along with this, we planned to implement the sideband MI command handling in QEMU.
>> why ?
>>
>>
>>
> Add MI command emulation and avoid HW dependency for development and
> testing.
>

Absolutely not. With this logic we have to implement entire NVMe command
set.Current QEMU implementation is lean, I'd like to keep that way and not
bloat it just for the sake of testing unless there is a kernel component
that is consuming MI interface and I don't think so we will have it
anytime soon.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
