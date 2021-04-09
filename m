Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE11C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:47:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A55661008
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A55661008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=DCgV7QP8StZ3ay3YRu2UyPXNJqjjLqr1RuMZrZqEj8g=; b=Xn0ncmNP6HloF7puTaTtxybA0
	++gC0jWZxjzVd7bBQ8ugdeS42HoF/SWesJGtSvHJDd/N8XnGqOXo3H29LITpbtGcbD8z5F2uaVC4b
	2CGO4tjPAMlB+W6HNZkRg/pfh88TPilhK6wSpQK6qqUnnzTPbLF0LcguoHPQfJNIPDo+znTE98eoi
	oqT4OsnpK+oMLogkk8uRFThXLgsZVEedVMiDi6yjUHug0EXXCrX4AbtjZHIhIN6ktCmsj1+VwSNjR
	JtI0QERdD6TRijaAlWabwi4TgflXgmp1wxEeTtsSZfSESl67jWzvMtKwMm7YESvzkcNvuL/fN6t6o
	P4ubPVIvA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUhAi-009kqZ-2D; Fri, 09 Apr 2021 02:47:00 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUhAZ-009kor-Tc
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 02:46:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617936411; x=1649472411;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xf/lagAfPXTobq+ob95HvZsbWTSsp2kr1dzuoISKl8Q=;
 b=Rz0WVje06m8kKOQitKnepwJm/WIQKKM5RPOc/vWPkaocpgGGeOm8pGNV
 Sru8FaOpq89pg2j0Tqu/XV/bN5Co3orTiw5LNr8OA6RtlqpnwYBNkSvBG
 HENuqoe+wqzplbU4JTEHYAVR3rli/EVAIcveCc04ah4EktvlqevdMtKZD
 3PN5V3wtx9XcQD14OOmLwekN7/b/iQWLAHr0qrFL5HZZ/pzp/khA8pBpf
 44df3zE4eU12snS8ZzdR2Y9WL7rml2CZYRKd1ClMXIVA4b1sdzilvBD9S
 mbzeKxWpqoiqNI4UeD3IkCfdgriAtOesfR3VZOu9/cRphL3ADILv8UOpm g==;
IronPort-SDR: 6Cqa4hWUMT5AFR9J6nQlNTe3KfTPht9d/n86aprqGvxA7vd15zD8MqVqVr+r9ISPQDFI5Eo6Wz
 ax3XQqBbmxDCE2dbdMZLKCxpF9SuRPfzCZkSXRWA/Sng0HR3sj/JfdOByrJSzH/4a/zpPOy4yS
 CuUWAhYQY4QOFqR4jEJX2SbBz8M3LeUh78U++E6fBIBh+EzMJ4BMh9BcjOsgsuIpv6uBOMhzU0
 NGL5+h1Tsws3aJMaQTjSov2AdFGoeHweSEo56buTTiF0Bpj4RnQxwCNcxdhGlzhEqirP7lQ2+e
 /jY=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="163963582"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 10:45:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+YChIlUB16y9ytq8RMlLlq0hRmBK/hHMQOZLKuZ0BD4xJ4MbjI8uFIZ84snwnZi2Geg1ZsSLSa3A7LBkyNaLxwF9idYSmLOcgswg84nmFRYwLn9k3VGVUg2nbMflm+lD4G4CZwvFDcmMXQbGtVrbyzfj3c02ctUF/CHIpbwB44BfmHV0ryQvzjV/ChLwOnFGuSpQSaz1UlySFZE2ibhkVTAclbpJdem7Qc0GKZnjcdjbgZWaz2HAPglUXPUKi9Mw5z19xwRS9J4Nvc0ADjsvcdLVy2PCq4qhGInXroUZzC5YQBbEFERHAyv38V731pIAnnfqb213XHWePFCtchJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2ElEbVD3bSIIhHvowa82QmBFu25Ds5JQfk/3T5kmDw=;
 b=fqeeWLtrs3snfx7mmChJ61tCPFafhWqiJbvI+IijjGSj4KY2NOcwVfFopPzYMVCm+742Bjt/qiD4Bu98REp89NDZUUQML3TzBkqNU5d42jl0+XU0M70T46t5b/byzUTc2fif8vGJEVKwy0AzkaXdg83oxN6VaMp44LVnaCgltfwjs9SELojAiReNGdLULHSNIx9lib0ei57w9a3sQvdV7GKkY7cG3exICEwo9w0rllNCZygRUvNgQade7G9Rr92j2haezfr5yhdostrK29vPWjhGd9SXnFEfkAFcstX6NqZS4QIbKu8TLzZHh8MJeHamYWmS4YnPKCiway6BPDiE2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2ElEbVD3bSIIhHvowa82QmBFu25Ds5JQfk/3T5kmDw=;
 b=jDcEsqQtCYF7BEi9VTZAC6yBrnEH/9dmyqJ4N8KhMdMjgeYwBYUYN22LC6ew/JpncK4Gyl7FkqxnMNSXESjKvrlQ8Q+n7umV3x+EF08B2y0PRikz+0sywn7n/VSg1St8TtBN7Q2ESts24uP2zRAdsY5NkcQPeitBogoRmU0zWoo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7025.namprd04.prod.outlook.com (2603:10b6:a03:22f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 02:45:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 02:45:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Kanchan Joshi <joshiiitr@gmail.com>, Javier Gonz??lez
 <javier.gonz@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/13] nvme: move the ioctl code to a separate file
Thread-Topic: [PATCH 08/13] nvme: move the ioctl code to a separate file
Thread-Index: AQHXLHOpwG2XF0Ai0Eu+v0yGHYEe6Q==
Date: Fri, 9 Apr 2021 02:45:11 +0000
Message-ID: <BYAPR04MB4965ABECBDFF2B773D5D8E6686739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 018c115c-7ab9-4e24-8dae-08d8fb017efb
x-ms-traffictypediagnostic: BY5PR04MB7025:
x-microsoft-antispam-prvs: <BY5PR04MB7025B35D569EE755CC1C69AF86739@BY5PR04MB7025.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vQIAEZZNRAXUitMK4LR7I1utKOMF0yOdKPCa76vlRfW0Uk9IOVqMenbSl8CmfTnrlilNCqiYokSQFVyWmJ8E2j1yjFPgetkV1E9zRdqjMYwemXH+uS/51QNcOKqfBXDLvhDCKCaWdbdlyZIGO1wAzOVHY7E3I9FV6wvfKxSVn3uWqUA6bqXnIxUGsGGiH/fBrAP36qobXN+KfDrsFZ/12HyhIlcozHeztk3p7jQvYbhgTIHAWkMxFLvrKSx8P349oOv7v+jOGUrulYM9ISl95pNOs/IP30dKuuCxSz+dvKJ72FC/ClG7eyY3Jl1H7FgqWqZ318qt6Yv2C7BPTzYfwY9UN83r8CJ6cTzsrnJDpMJiYyvzUAkKcvbhse2tnqpqT8BinGZ9R7/qzvyjWRalpgGkonvfZLVj8IkhFxFo/cK+R5dHLYvV08y4nUY+Db8BnXBs76GppSemvRSbftsXtpYhAwzaP2gPNB8ryJx1Tb950rpzL2vFn7nNVUKTuljnzdm+ltYppiCgmoguTZs3QHa9Te2dXWSXZFs0+FYbdo+LoB1EzxVpQiQFWiO0ZrCPdJhRMO7HBoBgw4z7/8Q9LVcYGxjPmPfQgSBVFjQV87dBQxIo/Ok10URAGbcwk9EINzbUoLmuZIyf22bHVskYe5/qqDgDYpIuBE+AI2AkILU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(9686003)(55016002)(558084003)(2906002)(316002)(53546011)(5660300002)(110136005)(33656002)(4326008)(66476007)(71200400001)(8676002)(7696005)(64756008)(66446008)(76116006)(478600001)(83380400001)(86362001)(6506007)(66946007)(186003)(38100700001)(8936002)(26005)(54906003)(52536014)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gGXR+zeRVRxKnQOWHGTNizDSZx0aNLdYsaor1dJfTCViKOFy0JR4tsnTcXpu?=
 =?us-ascii?Q?jabyvwu7kMlCJ7k8EB5G48/L94wwIt2MW5+hw3MSM5jVr+FUa1sOe868Hld3?=
 =?us-ascii?Q?LlU6kEV3vbpjmLu7u4CKwEx8++o2JZSfA7AIDx2+xJ/bn2NYb9JTsDQBKOju?=
 =?us-ascii?Q?6I466oAnV2GBCpsEoaYV40wnZkFjd6CYZ5JGFkUVuYQ81HKotH5p520Kcw1O?=
 =?us-ascii?Q?3QI6hrQ+GZTsconr/PvL0M6emC0hFVq8jLvbZZxpJFaexmJ8RRWyksj4FFzY?=
 =?us-ascii?Q?8PzOwx0ASPgykbuy3CAl1gaK1aAc35HuHn9yyyspfbHGkb5jnXZmmiLd9pQh?=
 =?us-ascii?Q?3VVH2MbRSFXMeFB/58qWNVz8MRzwlHc/viPtOBhEUSoXpayO5I8WUKw8JHIe?=
 =?us-ascii?Q?cLnRLzolZIuRZgmbZ0XFI4K4e7Y6tyJZBTZOmpuPWTVM/JMoN22u35LvAzuA?=
 =?us-ascii?Q?0ByyHiB0lfNAVbGfDWgQ8EhRnhwMF3tHrSSpYk41F80LXcOqYte2BwtKQudL?=
 =?us-ascii?Q?WfctjYvqko9piKOGhmW79yeM/yg2kv4oIJvtC+NabNgGEXtXvq8o0WdzSJ31?=
 =?us-ascii?Q?jLsdiyvFac5Z3wXMhifS5caRCsiCPMvutffmgxS9mqVBr1mwdBS19/cFFjfj?=
 =?us-ascii?Q?vbz0YaC9NXQnGC43KUAjVyC0MyuR8nueu3EQjikCgrks7J/HRzEm9NMOsn61?=
 =?us-ascii?Q?ie5VOkGqXk1G+44DmjDXGAHaNu1mkXuCBaz5sbtbF5vmFHMYPZU8RezNmwo+?=
 =?us-ascii?Q?8j0UfP/u9dbEQKnBQ+GK02k111XrpRq7vfgV+DbGJyx0Cug0KHYmUPSpYREE?=
 =?us-ascii?Q?3rHG0eYBx2wsaOJjowXr7YWGWahYi2igOc/CZamU9lAp5L0TP3mSXXHbFGTg?=
 =?us-ascii?Q?nGxvsgUC+CjdFjjV9VxThETKJvKLU629eGcw+56T/G4umD3Vyt/nxmBHGhLp?=
 =?us-ascii?Q?JMnnHlkaFNdoDq1UQX0ZA+SNt16G8No9WSjdgFS6yaDsj9rCYqX1LDTEb4BG?=
 =?us-ascii?Q?rzyzC1TO6A7l8POL6DsS1rEhFxrChihUeZ2z3G4wpNuZ8NpoJkCSjaO5WZ8Y?=
 =?us-ascii?Q?hvHGb7fRbVSvxfzTRdPS7tWWGTvxgeYL1z6GR4boHlsmIQxAxYK06C3EpUiv?=
 =?us-ascii?Q?l3gsQ7xhL/R9Le4nN8MbOUi1xLTyEI7mCgxJGALXfDMIkkRgg0Ual4PSauz5?=
 =?us-ascii?Q?BB3So5WhR6BOZujEe7C+I033VlzLAw6CV7myy7UyFxv1H8KyiRJGar7thqr3?=
 =?us-ascii?Q?NOn/SHr1Hdg/zrI2PVhJ+61aIDqx94lMNuWmhuNipfHJWX4NMzYPZ8nsAwFK?=
 =?us-ascii?Q?f93KH3Y6UtHEvhBBcdFlFvkM7wi7o4mTnhC4u2Zcv7W1PQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018c115c-7ab9-4e24-8dae-08d8fb017efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:45:11.5929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biuuBsHqaaSwyadYb6cl23iZ4Q5W4SS4oP0DwaCIvnFJJJ2AgNsy2GmKtP1VDBkXzwMcAnwZT04MJRBfr0MKAlK2/qnW9rwJvzPSUxcEyWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_034652_419825_5C81C468 
X-CRM114-Status: GOOD (  11.34  )
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
> Split out the ioctl code from core.c into a new file.  Also update
> copyrights while we're at it.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
