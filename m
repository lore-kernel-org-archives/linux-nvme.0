Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4779C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVL1T+Qa9xKmjvUeFwOkscikAEilDzcvEJfPjEmPX70=; b=MpuXNTMpWB6S8DjQ9k6nq9BArz
	ONyeJtIu9MKf0Yh5w+kKosbJPaaCuPR7NJOA4VN4Gi0rINCLePb+2bIu1/l7kXK1Nr9MjImn6z9sR
	6Jwa+sfvTFg7NIw2NILMRay15kvMO7YXncNcBZp4mOsHuyn4uVWCMDbYNIBteFhup6PGbu72NpwVi
	5e1EBbaRwN4/aD3onCRbBjU0EDOIC5K/fnAyXqfZ+WG3gbDJXAl7V9aU9ria8kbb6IOPdzaIFd5jH
	3wCJuCHTVd0tMQKo66zja+aVOo6Bd1Sjj5aRlQD36dTBRNlozrZS20Rzeos0GIuNLbNWWYhsbHMs9
	a7JAl5XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njlwb-002rbR-UM; Wed, 27 Apr 2022 17:59:18 +0000
Received: from mail-bn8nam11on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::60f]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njlwU-002rWM-8N
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 17:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWuooFQw16WLwecK88hTWoht1C4F2p2GAn2o9BvKJSpnIZZzkYqA7LGjq69/6IKZgr6T6pouCSeUzyE1rfHxGOEs2tp5yvFSFprvGASK3KJFQY8njx5XGflFbft/ITroDQN2B2SdZI3ZRwFFBHigLqxVNLhKLOUKRwg3sCxyaihWBxGzVKi8n7GMFnlV6s91nk3nKsEcLG7/Jegc+zze1V3piWEv5P6VUaof2Mgb/nlDtELZdbIXe5jXVcl7OBF7FhNaqHHytv4HhIuPV3sNlFFS5vszxF4InSNS7OyHBYgA7xVSaQEf1Tz16El5Fi0loHBa5oGnjUI8jBdYYCbGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVL1T+Qa9xKmjvUeFwOkscikAEilDzcvEJfPjEmPX70=;
 b=LOjSgOts669Ss/UDqTReNNAAi/Qgr3ExvGCj6r9+e3rShtiMuBywJ8MY+gG2EYwgQU4Yg1AZ00gYXbW4O/Dr1s5+uO88SJh6x4UdGOm1YdRtezRQKAiymt4cEAKC0VlBPYjKo2/3HiW5S8XoprrUJHJCDL1itjqPWl+18bblALxhmlWdikf8S0eMYalL8mMsCSgtY4c3JQKr3GbQj996NJXgDxuqQZiBrV6T2twoy8yXdqGHKywJk+E8PdnPs2SQ7xrN8iI1lYozD0IzR8RcpiKAeblskYgMlD3rR1qPDw1UrINYo4725XhrDVEhv5Y97O9txrP00h4SOXlHFSK/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVL1T+Qa9xKmjvUeFwOkscikAEilDzcvEJfPjEmPX70=;
 b=l/tsJvEq3XunZaa2J/KkykFShaNYKQhUikilIIi/tgNmT05kQbQsjeWOTTtmuMJ5iXxNX+sv31+UEjfYTUS+oqaICMsS7UI8zXhBE4BH7YVCbw8alsFuGHFVduCI+dqorh2/OtRjFUQKTXrOrL7lmhADlT2w+sn8mzVl6pIEze9OMKire+67f2KroP9IRSueqMXaS2wH+fU2iB30Rg54WuX6jxIaqTzlsTHaYlCjSD3pwkB6K4ErgnWRWjjMYGB1spiJ1tDEsTV1y8SFSzCAIJM7WF5WwS5Wzj9NXTgvRwxJu3nRkxfuErPPWHD+kIeW8ra7muERa1JidzMiIX5HIw==
Received: from BL0PR06MB4291.namprd06.prod.outlook.com (2603:10b6:208:49::15)
 by SJ0PR06MB8657.namprd06.prod.outlook.com (2603:10b6:a03:3e8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 17:59:02 +0000
Received: from BL0PR06MB4291.namprd06.prod.outlook.com
 ([fe80::a0a1:61d4:c2aa:d15b]) by BL0PR06MB4291.namprd06.prod.outlook.com
 ([fe80::a0a1:61d4:c2aa:d15b%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 17:59:02 +0000
From: "Nayak, Prashanth" <Prashanth.Nayak@netapp.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Thread-Topic: [PATCH 06/11] nvme: Implement In-Band authentication
Thread-Index: AQHYWmB5Q/jazGl0gkyUrw9fP26WEg==
Date: Wed, 27 Apr 2022 17:59:02 +0000
Message-ID: <AC1767B2-F6F0-4DE9-A0C4-F15D45DB9E79@netapp.com>
References: <20220328133938.146146-1-hare@suse.de>
 <20220328133938.146146-7-hare@suse.de>
In-Reply-To: <20220328133938.146146-7-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 919de41c-0256-434b-e351-08da28779cef
x-ms-traffictypediagnostic: SJ0PR06MB8657:EE_
x-microsoft-antispam-prvs: <SJ0PR06MB8657A026167144D20F94B9C592FA9@SJ0PR06MB8657.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9YRnEHQw4RBUu5av7M71JnGXVgNYVeaCqenot5hAZU/YiHoIeGwdHeQjkSjGdv4P6FEbL6oiyEPIrpladQWXujCc3TMKbL4q6cNBPmNn0XNec/rtKJtyxVM7kLNsv4xkYIKpTXsE8FHbXr1PPJnO8QaCdAooVKxWshP28XfUXJHiqrUEEduiped/Pf7v+rjnn7IEbC8ujNII3Hjm0feJ9LRSBlbXplNowsd5Hada/KNvYDfZ4gbTy6rLVwNmHbusilbJpspQ2USZzmfiRMZd6QYCGXxdjVhdychPjlWAzX5RS3Ya06UmOZIHPMc6m/6m5Q6E/6gOg2WjH/pqd73kUw2N24QssyMbMFOr1sKstmo3Eo2/ACSvzZtub/vhfE+V4RC4oC96S/I2jBsI30Ok0W6pB1jpbtwhkt7yoxQSoBL8mPPWoryselfOTsdf0gVq3UciM5Pyqj7Lx9ODyOlIp9VB1SHMKD1wxfyCRQSiaKpz45cGJrxZRsjvEl17z0Szz0/Fl1So8+wJFkaTSEHsHSeKDRYDfFqBxwT8ghzPuA1Ba+1ffGbEF+EGRllKagVwFQB37Q51bTMwV4OchxbV6Xd/XXT3MoM8mF3HdWVJu5tIjV3oTbERT4J3lSi4reTOSB/JsiH7GdQ1ElfVOA4zWJuBLJSIUhn0DMEzzGhE7qo+eHZGjiknyYVhfV9HLKL6MjA1lmHpzeMvJth/v22oLO0igUkfAsC4C/LrfUAnzkbVSbDlXbonihslDZw7yhHQn+htkx98tiq9sEQ71e1RCYk67olZRDEy6/C5A5B3zIdNg8CiO9VQFNLu6Y9Oafm5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR06MB4291.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66476007)(6506007)(55236004)(2616005)(26005)(76116006)(66556008)(53546011)(66946007)(6512007)(71200400001)(54906003)(6486002)(966005)(316002)(6916009)(86362001)(508600001)(186003)(122000001)(66446008)(38070700005)(38100700002)(83380400001)(30864003)(64756008)(2906002)(33656002)(8936002)(5660300002)(36756003)(4326008)(8676002)(45980500001)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P1Gh8lgMs3VT5suDjbduwB3ERFEbVC7MT7fwR2mB2ZDpIBe58VfIQgQzoC22?=
 =?us-ascii?Q?pAXQ4xcKElxH1ki6UCUXcUi+T8Ms9Ray5SxqhT/Qek4Dr2h0ZLHOLZ4Avoje?=
 =?us-ascii?Q?xrDulb8LLVS4Frcz7GwTc3V1hKZWfbHs72H6NjwVYhaB+b9i8tCTJeRvMwz5?=
 =?us-ascii?Q?361tNaLREyR0gMhzMMSStaggpoNMt2kQVlT7PL7EBgZARdchUFDLMSM6Yc1r?=
 =?us-ascii?Q?OppwjWa/OHvEKB0xg5U4bBLe9pedswHdc6OFPLDtl9JuJMvRl14y2gxCv4qL?=
 =?us-ascii?Q?wTwSKAi1S73oFPQaPoDB4KTct2Ouw4LZ+qJ3US3q/jm93nbvdvmo6m+FVFaV?=
 =?us-ascii?Q?OOGxF2WIMUnO5ZLofcKL6U0XXL2sU+LNJ1e9EJfJk9+dsRI9lvCjy1bG/O2T?=
 =?us-ascii?Q?j/mioPaQuhyQWOGVJrZeZW3J0mm9N/Yfg13Wrd4zc5k6eooK0YmboVy+dxtT?=
 =?us-ascii?Q?27/KHs7TRnav7P9K+con/4B3B6MK+daEvVqLcAIdJKZOBoYRtPMYTadKaQ77?=
 =?us-ascii?Q?2cENc+25F9EFVpYl1DP3GX0CYaZsOYCoso9cCnm1u2AD9AlKjR9/+jp8wsL/?=
 =?us-ascii?Q?YFiBZUPjxJGxKoIANZ41m7sqh1pbZgRTsbbYph53JeBi9g522jL/dkx5akT2?=
 =?us-ascii?Q?gQe6I68EjHjyvf2uCASnV9W2uAcbPcTzDwmA8sB1s6oipV/J8f19pL+iHAE+?=
 =?us-ascii?Q?KEKFgrWQutuitGUKUG7E2Fk/L3S2blW57ONVTXDArDbj8gsY8O9wapUJHh7O?=
 =?us-ascii?Q?YDWbZScfwI9LHaGP7mOjL/GrRPoqNQkXAcMNxOP5ycSNWIjJP472McHjrbPU?=
 =?us-ascii?Q?m330VzjvglrJR5+28eJTZ4JjLLT1YPUHKrn6eVxLGq8wt1MRN8OOXx0/x/ME?=
 =?us-ascii?Q?VnbD8trGOmUKwLhgpuqiT9WqHHrOZ8gWwgyDbJdXEyrPJUYgoYmnp4QuCf2W?=
 =?us-ascii?Q?fUv2bC8r+7U20nxl0rI89YAOG5Q+tEcSJeA+jzNJtjx9wEtVpBHRb+QxFpfv?=
 =?us-ascii?Q?dW4nCFtnbUlVfYNMRJJOx0hJ+JkduyPs4n4nKcRt9e4PkrdeN003Sf1JBAvX?=
 =?us-ascii?Q?4My+WmLA9tT6nOVVmhY+IbBp2HnH1x9PpapPgy/NlKU7CqzUGYMn3/aKlq8g?=
 =?us-ascii?Q?n9g1BdPMwR1I4lLeBBhJBOxPRPjvnlT1gHJ7feFRnm2gXoyhHTc3RD94Ueko?=
 =?us-ascii?Q?Eab3oRTg4Dw74D1d8fIUioXk1esSIZ/Jawu78SNl484nkpZsnBaVHGJ1jb3m?=
 =?us-ascii?Q?ZycD+pXsY6tXzJ8W8pB7aUjfNLRUIMLfNi/RwqtIl5WrroxrTxZomPQj/fXv?=
 =?us-ascii?Q?lsf7eiTwnnzLY5nOByPs70m0V/hBpautHKw4ySMA9VrzXghX78MMcOP/XyLw?=
 =?us-ascii?Q?U+VTyRip47HoCUpl6tBX0Hjfo78SWysIU99rpIVJ0KpoJ4zDHpL58Ynv2sGv?=
 =?us-ascii?Q?B5YwuQo2T01Kc+lFq5PObTO2RUYc9jG0mt/jVi5dqcBVhP0CS60MQOFOgldC?=
 =?us-ascii?Q?T0WuLko7dgCCr1fKWNE3rvJnPjxklNlsFhvo9Z9TY29/a+dOcCpYfx9U+4nU?=
 =?us-ascii?Q?k5tgY9pE8U64I7eTGhKdAeAgzDBX41bn30d7nI7++dPKebv5c0+DAqKB+MQC?=
 =?us-ascii?Q?Yi7891ribHgmTZ3yvB20pGZV3JCKvaM0aMGylv/1cz2oTmljqfLVTEw3oLFv?=
 =?us-ascii?Q?uEM1F4wQBR/ggT2OrxJ9npAXYoayvvgFRXqOVQE8Bu+awSCgFZZHIe5T/kEk?=
 =?us-ascii?Q?SOR2/1QgSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EEFBBEDA55FF140A3A3AFD295662A27@namprd06.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR06MB4291.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919de41c-0256-434b-e351-08da28779cef
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 17:59:02.5376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qB5oq9IdAU5DciFdNyxJVEoDc6RREcuBVNzTm/JIJFwtFUA5Pl2Bs6KJChKFB8VL2G+3AMMEXqUxCpEqosXC2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB8657
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_105910_666080_0E51E6E9 
X-CRM114-Status: GOOD (  26.21  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Hannes

> On Mar 28, 2022, at 9:39 AM, Hannes Reinecke <hare@suse.de> wrote:
>=20
> Implement NVMe-oF In-Band authentication according to NVMe TPAR 8006.
> This patch adds two new fabric options 'dhchap_secret' to specify the
> pre-shared key (in ASCII respresentation according to NVMe 2.0 section
> 8.13.5.8 'Secret representation') and 'dhchap_ctrl_secret' to specify
> the pre-shared controller key for bi-directional authentication of both
> the host and the controller.
> Re-authentication can be triggered by writing the PSK into the new
> controller sysfs attribute 'dhchap_secret' or 'dhchap_ctrl_secret'.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
> drivers/nvme/host/Kconfig   |   11 +
> drivers/nvme/host/Makefile  |    1 +
> drivers/nvme/host/auth.c    | 1123 +++++++++++++++++++++++++++++++++++
> drivers/nvme/host/auth.h    |   32 +
> drivers/nvme/host/core.c    |  141 ++++-
> drivers/nvme/host/fabrics.c |   79 ++-
> drivers/nvme/host/fabrics.h |    7 +
> drivers/nvme/host/nvme.h    |   31 +
> drivers/nvme/host/rdma.c    |    1 +
> drivers/nvme/host/tcp.c     |    1 +
> drivers/nvme/host/trace.c   |   32 +
> 11 files changed, 1452 insertions(+), 7 deletions(-)
> create mode 100644 drivers/nvme/host/auth.c
> create mode 100644 drivers/nvme/host/auth.h
>=20
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index d6d056963c06..dd0e91fb0615 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -91,3 +91,14 @@ config NVME_TCP
> 	  from https://github.com/linux-nvme/nvme-cli.
>=20
> 	  If unsure, say N.
> +
> +config NVME_AUTH
> +	bool "NVM Express over Fabrics In-Band Authentication"
> +	depends on NVME_CORE
> +	select CRYPTO_HMAC
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	help
> +	  This provides support for NVMe over Fabrics In-Band Authentication.
> +
> +	  If unsure, say N.
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index 476c5c988496..7755f5e3b281 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -15,6 +15,7 @@ nvme-core-$(CONFIG_NVME_MULTIPATH)	+=3D multipath.o
> nvme-core-$(CONFIG_BLK_DEV_ZONED)	+=3D zns.o
> nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+=3D fault_inject.o
> nvme-core-$(CONFIG_NVME_HWMON)		+=3D hwmon.o
> +nvme-core-$(CONFIG_NVME_AUTH)		+=3D auth.o
>=20
> nvme-y					+=3D pci.o
>=20
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> new file mode 100644
> index 000000000000..f15754d1bf45
> --- /dev/null
> +++ b/drivers/nvme/host/auth.c
> @@ -0,0 +1,1123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Hannes Reinecke, SUSE Linux
> + */
> +
> +#include <linux/crc32.h>
> +#include <linux/base64.h>
> +#include <linux/prandom.h>
> +#include <asm/unaligned.h>
> +#include <crypto/hash.h>
> +#include <crypto/dh.h>
> +#include "nvme.h"
> +#include "fabrics.h"
> +#include "auth.h"
> +
> +static u32 nvme_dhchap_seqnum;
> +static DEFINE_MUTEX(nvme_dhchap_mutex);
> +
> +struct nvme_dhchap_queue_context {
> +	struct list_head entry;
> +	struct work_struct auth_work;
> +	struct nvme_ctrl *ctrl;
> +	struct crypto_shash *shash_tfm;
> +	void *buf;
> +	size_t buf_size;
> +	int qid;
> +	int error;
> +	u32 s1;
> +	u32 s2;
> +	u16 transaction;
> +	u8 status;
> +	u8 hash_id;
> +	size_t hash_len;
> +	u8 dhgroup_id;
> +	u8 c1[64];
> +	u8 c2[64];
> +	u8 response[64];
> +	u8 *host_response;
> +};
> +
> +u32 nvme_auth_get_seqnum(void)
> +{
> +	u32 seqnum;
> +
> +	mutex_lock(&nvme_dhchap_mutex);
> +	if (!nvme_dhchap_seqnum)
> +		nvme_dhchap_seqnum =3D prandom_u32();
> +	else {
> +		nvme_dhchap_seqnum++;
> +		if (!nvme_dhchap_seqnum)
> +			nvme_dhchap_seqnum++;
> +	}
> +	seqnum =3D nvme_dhchap_seqnum;
> +	mutex_unlock(&nvme_dhchap_mutex);
> +	return seqnum;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_get_seqnum);
> +
> +static struct nvme_auth_dhgroup_map {
> +	const char name[16];
> +	const char kpp[16];
> +} dhgroup_map[] =3D {
> +	[NVME_AUTH_DHGROUP_NULL] =3D {
> +		.name =3D "null", .kpp =3D "null" },
> +	[NVME_AUTH_DHGROUP_2048] =3D {
> +		.name =3D "ffdhe2048", .kpp =3D "ffdhe2048(dh)" },
> +	[NVME_AUTH_DHGROUP_3072] =3D {
> +		.name =3D "ffdhe3072", .kpp =3D "ffdhe3072(dh)" },
> +	[NVME_AUTH_DHGROUP_4096] =3D {
> +		.name =3D "ffdhe4096", .kpp =3D "ffdhe4096(dh)" },
> +	[NVME_AUTH_DHGROUP_6144] =3D {
> +		.name =3D "ffdhe6144", .kpp =3D "ffdhe6144(dh)" },
> +	[NVME_AUTH_DHGROUP_8192] =3D {
> +		.name =3D "ffdhe8192", .kpp =3D "ffdhe8192(dh)" },
> +};
> +
> +const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
> +{
> +	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	    !dhgroup_map[dhgroup_id].name ||
> +	    !strlen(dhgroup_map[dhgroup_id].name))
> +		return NULL;
> +	return dhgroup_map[dhgroup_id].name;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
> +
> +const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
> +{
> +	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	    !dhgroup_map[dhgroup_id].kpp ||
> +	    !strlen(dhgroup_map[dhgroup_id].kpp))
> +		return NULL;
> +	return dhgroup_map[dhgroup_id].kpp;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_kpp);
> +
> +u8 nvme_auth_dhgroup_id(const char *dhgroup_name)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dhgroup_map); i++) {
> +		if (!dhgroup_map[i].name ||
> +		    !strlen(dhgroup_map[i].name))
> +			continue;
> +		if (!strncmp(dhgroup_map[i].name, dhgroup_name,
> +			     strlen(dhgroup_map[i].name)))
> +			return i;
> +	}
> +	return NVME_AUTH_DHGROUP_INVALID;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
> +
> +static struct nvme_dhchap_hash_map {
> +	int len;
> +	const char hmac[15];
> +	const char digest[8];
> +} hash_map[] =3D {
> +	[NVME_AUTH_HASH_SHA256] =3D {
> +		.len =3D 32,
> +		.hmac =3D "hmac(sha256)",
> +		.digest =3D "sha256",
> +	},
> +	[NVME_AUTH_HASH_SHA384] =3D {
> +		.len =3D 48,
> +		.hmac =3D "hmac(sha384)",
> +		.digest =3D "sha384",
> +	},
> +	[NVME_AUTH_HASH_SHA512] =3D {
> +		.len =3D 64,
> +		.hmac =3D "hmac(sha512)",
> +		.digest =3D "sha512",
> +	},
> +};
> +
> +const char *nvme_auth_hmac_name(u8 hmac_id)
> +{
> +	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	    !hash_map[hmac_id].hmac ||
> +	    !strlen(hash_map[hmac_id].hmac))
> +		return NULL;
> +	return hash_map[hmac_id].hmac;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
> +
> +const char *nvme_auth_digest_name(u8 hmac_id)
> +{
> +	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	    !hash_map[hmac_id].digest ||
> +	    !strlen(hash_map[hmac_id].digest))
> +		return NULL;
> +	return hash_map[hmac_id].digest;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_digest_name);
> +
> +u8 nvme_auth_hmac_id(const char *hmac_name)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hash_map); i++) {
> +		if (!hash_map[i].hmac || !strlen(hash_map[i].hmac))
> +			continue;
> +		if (!strncmp(hash_map[i].hmac, hmac_name,
> +			     strlen(hash_map[i].hmac)))
> +			return i;
> +	}
> +	return NVME_AUTH_HASH_INVALID;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
> +
> +size_t nvme_auth_hmac_hash_len(u8 hmac_id)
> +{
> +	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	    !hash_map[hmac_id].hmac ||
> +	    !strlen(hash_map[hmac_id].hmac))
> +		return 0;
> +	return hash_map[hmac_id].len;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
> +
> +struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
> +					      u8 key_hash)
> +{
> +	struct nvme_dhchap_key *key;
> +	unsigned char *p;
> +	u32 crc;
> +	int ret, key_len;
> +	size_t allocated_len =3D strlen(secret);
> +
> +	/* Secret might be affixed with a ':' */
> +	p =3D strrchr(secret, ':');
> +	if (p)
> +		allocated_len =3D p - secret;
> +	key =3D kzalloc(sizeof(*key), GFP_KERNEL);
> +	if (!key)
> +		return ERR_PTR(-ENOMEM);
> +	key->key =3D kzalloc(allocated_len, GFP_KERNEL);
> +	if (!key->key) {
> +		ret =3D -ENOMEM;
> +		goto out_free_key;
> +	}
> +
> +	key_len =3D base64_decode(secret, allocated_len, key->key);
> +	if (key_len < 0) {
> +		pr_debug("base64 key decoding error %d\n",
> +			 key_len);
> +		ret =3D key_len;
> +		goto out_free_secret;
> +	}
> +
> +	if (key_len !=3D 36 && key_len !=3D 52 &&
> +	    key_len !=3D 68) {
> +		pr_err("Invalid DH-HMAC-CHAP key len %d\n",
> +		       key_len);
> +		ret =3D -EINVAL;
> +		goto out_free_secret;
> +	}
> +
> +	if (key_hash > 0 &&
> +	    (key_len - 4) !=3D nvme_auth_hmac_hash_len(key_hash)) {
> +		pr_err("Invalid DH-HMAC-CHAP key len %d for %s\n", key_len,
> +		       nvme_auth_hmac_name(key_hash));
> +		ret =3D -EINVAL;
> +		goto out_free_secret;
> +	}
> +
> +	/* The last four bytes is the CRC in little-endian format */
> +	key_len -=3D 4;
> +	/*
> +	 * The linux implementation doesn't do pre- and post-increments,
> +	 * so we have to do it manually.
> +	 */
> +	crc =3D ~crc32(~0, key->key, key_len);
> +
> +	if (get_unaligned_le32(key->key + key_len) !=3D crc) {
> +		pr_err("DH-HMAC-CHAP key crc mismatch (key %08x, crc %08x)\n",
> +		       get_unaligned_le32(key->key + key_len), crc);
> +		ret =3D -EKEYREJECTED;
> +		goto out_free_secret;
> +	}
> +	key->len =3D key_len;
> +	key->hash =3D key_hash;
> +	return key;
> +out_free_secret:
> +	kfree_sensitive(key->key);
> +out_free_key:
> +	kfree(key);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
> +
> +void nvme_auth_free_key(struct nvme_dhchap_key *key)
> +{
> +	if (!key)
> +		return;
> +	kfree_sensitive(key->key);
> +	kfree(key);
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_free_key);
> +
> +u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
> +{
> +	const char *hmac_name =3D nvme_auth_hmac_name(key->hash);
> +	struct crypto_shash *key_tfm;
> +	struct shash_desc *shash;
> +	u8 *transformed_key;
> +	int ret;
> +
> +	if (key->hash =3D=3D 0) {
> +		transformed_key =3D kmemdup(key->key, key->len, GFP_KERNEL);
> +		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (!key || !key->key) {
> +		pr_warn("No key specified\n");
> +		return ERR_PTR(-ENOKEY);
> +	}
> +	if (!hmac_name) {
> +		pr_warn("Invalid key hash id %d\n", key->hash);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	key_tfm =3D crypto_alloc_shash(hmac_name, 0, 0);
> +	if (IS_ERR(key_tfm))
> +		return (u8 *)key_tfm;
> +
> +	shash =3D kmalloc(sizeof(struct shash_desc) +
> +			crypto_shash_descsize(key_tfm),
> +			GFP_KERNEL);
> +	if (!shash) {
> +		ret =3D -ENOMEM;
> +		goto out_free_key;
> +	}
> +
> +	transformed_key =3D kzalloc(crypto_shash_digestsize(key_tfm), GFP_KERNE=
L);
> +	if (!transformed_key) {
> +		ret =3D -ENOMEM;
> +		goto out_free_shash;
> +	}
> +
> +	shash->tfm =3D key_tfm;
> +	ret =3D crypto_shash_setkey(key_tfm, key->key, key->len);
> +	if (ret < 0)
> +		goto out_free_shash;
> +	ret =3D crypto_shash_init(shash);
> +	if (ret < 0)
> +		goto out_free_shash;
> +	ret =3D crypto_shash_update(shash, nqn, strlen(nqn));
> +	if (ret < 0)
> +		goto out_free_shash;
> +	ret =3D crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
> +	if (ret < 0)
> +		goto out_free_shash;
> +	ret =3D crypto_shash_final(shash, transformed_key);
> +out_free_shash:
> +	kfree(shash);
> +out_free_key:
> +	crypto_free_shash(key_tfm);
> +	if (ret < 0) {
> +		kfree_sensitive(transformed_key);
> +		return ERR_PTR(ret);
> +	}
> +	return transformed_key;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
> +
> +#define nvme_auth_flags_from_qid(qid) \
> +	(qid =3D=3D 0) ? 0 : BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED
> +#define nvme_auth_queue_from_qid(ctrl, qid) \
> +	(qid =3D=3D 0) ? (ctrl)->fabrics_q : (ctrl)->connect_q
> +
> +static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
> +			    void *data, size_t data_len, bool auth_send)
> +{
> +	struct nvme_command cmd =3D {};
> +	blk_mq_req_flags_t flags =3D nvme_auth_flags_from_qid(qid);
> +	struct request_queue *q =3D nvme_auth_queue_from_qid(ctrl, qid);
> +	int ret;
> +
> +	cmd.auth_common.opcode =3D nvme_fabrics_command;
> +	cmd.auth_common.secp =3D NVME_AUTH_DHCHAP_PROTOCOL_IDENTIFIER;
> +	cmd.auth_common.spsp0 =3D 0x01;
> +	cmd.auth_common.spsp1 =3D 0x01;
> +	if (auth_send) {
> +		cmd.auth_send.fctype =3D nvme_fabrics_type_auth_send;
> +		cmd.auth_send.tl =3D cpu_to_le32(data_len);
> +	} else {
> +		cmd.auth_receive.fctype =3D nvme_fabrics_type_auth_receive;
> +		cmd.auth_receive.al =3D cpu_to_le32(data_len);
> +	}
> +
> +	ret =3D __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len, 0,
> +				     qid =3D=3D 0 ? NVME_QID_ANY : qid,
> +				     0, flags);
> +	if (ret > 0)
> +		dev_warn(ctrl->device,
> +			"qid %d auth_send failed with status %d\n", qid, ret);
> +	else if (ret < 0)
> +		dev_err(ctrl->device,
> +			"qid %d auth_send failed with error %d\n", qid, ret);
> +	return ret;
> +}
> +
> +static int nvme_auth_receive_validate(struct nvme_ctrl *ctrl, int qid,
> +		struct nvmf_auth_dhchap_failure_data *data,
> +		u16 transaction, u8 expected_msg)
> +{
> +	dev_dbg(ctrl->device, "%s: qid %d auth_type %d auth_id %x\n",
> +		__func__, qid, data->auth_type, data->auth_id);
> +
> +	if (data->auth_type =3D=3D NVME_AUTH_COMMON_MESSAGES &&
> +	    data->auth_id =3D=3D NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
> +		return data->rescode_exp;
> +	}
> +	if (data->auth_type !=3D NVME_AUTH_DHCHAP_MESSAGES ||
> +	    data->auth_id !=3D expected_msg) {
> +		dev_warn(ctrl->device,
> +			 "qid %d invalid message %02x/%02x\n",
> +			 qid, data->auth_type, data->auth_id);
> +		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
> +	}
> +	if (le16_to_cpu(data->t_id) !=3D transaction) {
> +		dev_warn(ctrl->device,
> +			 "qid %d invalid transaction ID %d\n",
> +			 qid, le16_to_cpu(data->t_id));
> +		return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_MESSAGE;
> +	}
> +	return 0;
> +}
> +
> +static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_negotiate_data *data =3D chap->buf;
> +	size_t size =3D sizeof(*data) + sizeof(union nvmf_auth_protocol);
> +
> +	if (chap->buf_size < size) {
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return -EINVAL;
> +	}
> +	memset((u8 *)chap->buf, 0, size);
> +	data->auth_type =3D NVME_AUTH_COMMON_MESSAGES;
> +	data->auth_id =3D NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
> +	data->t_id =3D cpu_to_le16(chap->transaction);
> +	data->sc_c =3D 0; /* No secure channel concatenation */
> +	data->napd =3D 1;
> +	data->auth_protocol[0].dhchap.authid =3D NVME_AUTH_DHCHAP_AUTH_ID;
> +	data->auth_protocol[0].dhchap.halen =3D 3;
> +	data->auth_protocol[0].dhchap.dhlen =3D 6;
> +	data->auth_protocol[0].dhchap.idlist[0] =3D NVME_AUTH_HASH_SHA256;
> +	data->auth_protocol[0].dhchap.idlist[1] =3D NVME_AUTH_HASH_SHA384;
> +	data->auth_protocol[0].dhchap.idlist[2] =3D NVME_AUTH_HASH_SHA512;
> +	data->auth_protocol[0].dhchap.idlist[30] =3D NVME_AUTH_DHGROUP_NULL;
> +	data->auth_protocol[0].dhchap.idlist[31] =3D NVME_AUTH_DHGROUP_2048;
> +	data->auth_protocol[0].dhchap.idlist[32] =3D NVME_AUTH_DHGROUP_3072;
> +	data->auth_protocol[0].dhchap.idlist[33] =3D NVME_AUTH_DHGROUP_4096;
> +	data->auth_protocol[0].dhchap.idlist[34] =3D NVME_AUTH_DHGROUP_6144;
> +	data->auth_protocol[0].dhchap.idlist[35] =3D NVME_AUTH_DHGROUP_8192;
> +
> +	return size;
> +}
> +
> +static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_challenge_data *data =3D chap->buf;
> +	u16 dhvlen =3D le16_to_cpu(data->dhvlen);
> +	size_t size =3D sizeof(*data) + data->hl + dhvlen;
> +	const char *hmac_name, *kpp_name;
> +
> +	if (chap->buf_size < size) {
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +
> +	hmac_name =3D nvme_auth_hmac_name(data->hashid);
> +	if (!hmac_name) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid HASH ID %d\n",
> +			 chap->qid, data->hashid);
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +
> +	if (chap->hash_id =3D=3D data->hashid && chap->shash_tfm &&
> +	    !strcmp(crypto_shash_alg_name(chap->shash_tfm), hmac_name) &&
> +	    crypto_shash_digestsize(chap->shash_tfm) =3D=3D data->hl) {
> +		dev_dbg(ctrl->device,
> +			"qid %d: reuse existing hash %s\n",
> +			chap->qid, hmac_name);
> +		goto select_kpp;
> +	}
> +
> +	/* Reset if hash cannot be reused */
> +	if (chap->shash_tfm) {
> +		crypto_free_shash(chap->shash_tfm);
> +		chap->hash_id =3D 0;
> +		chap->hash_len =3D 0;
> +	}
> +	chap->shash_tfm =3D crypto_alloc_shash(hmac_name, 0,
> +					     CRYPTO_ALG_ALLOCATES_MEMORY);
> +	if (IS_ERR(chap->shash_tfm)) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: failed to allocate hash %s, error %ld\n",
> +			 chap->qid, hmac_name, PTR_ERR(chap->shash_tfm));
> +		chap->shash_tfm =3D NULL;
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_FAILED;
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +
> +	if (crypto_shash_digestsize(chap->shash_tfm) !=3D data->hl) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid hash length %d\n",
> +			 chap->qid, data->hl);
> +		crypto_free_shash(chap->shash_tfm);
> +		chap->shash_tfm =3D NULL;
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +
> +	/* Reset host response if the hash had been changed */
> +	if (chap->hash_id !=3D data->hashid) {
> +		kfree(chap->host_response);
> +		chap->host_response =3D NULL;
> +	}
> +
> +	chap->hash_id =3D data->hashid;
> +	chap->hash_len =3D data->hl;
> +	dev_dbg(ctrl->device, "qid %d: selected hash %s\n",
> +		chap->qid, hmac_name);
> +
> +select_kpp:
> +	kpp_name =3D nvme_auth_dhgroup_kpp(data->dhgid);
> +	if (!kpp_name) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid DH group id %d\n",
> +			 chap->qid, data->dhgid);
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +
> +	if (data->dhgid !=3D NVME_AUTH_DHGROUP_NULL) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: unsupported DH group %s\n",
> +			 chap->qid, kpp_name);
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
> +		return NVME_SC_AUTH_REQUIRED;
> +	} else if (dhvlen !=3D 0) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid DH value for NULL DH\n",
> +			 chap->qid);
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +	chap->dhgroup_id =3D data->dhgid;
> +
> +	chap->s1 =3D le32_to_cpu(data->seqnum);
> +	memcpy(chap->c1, data->cval, chap->hash_len);
> +
> +	return 0;
> +}
> +
> +static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_reply_data *data =3D chap->buf;
> +	size_t size =3D sizeof(*data);
> +
> +	size +=3D 2 * chap->hash_len;
> +
> +	if (chap->buf_size < size) {
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return -EINVAL;
> +	}
> +
> +	memset(chap->buf, 0, size);
> +	data->auth_type =3D NVME_AUTH_DHCHAP_MESSAGES;
> +	data->auth_id =3D NVME_AUTH_DHCHAP_MESSAGE_REPLY;
> +	data->t_id =3D cpu_to_le16(chap->transaction);
> +	data->hl =3D chap->hash_len;
> +	data->dhvlen =3D 0;
> +	memcpy(data->rval, chap->response, chap->hash_len);
> +	if (ctrl->opts->dhchap_ctrl_secret) {
> +		get_random_bytes(chap->c2, chap->hash_len);
> +		data->cvalid =3D 1;
> +		chap->s2 =3D nvme_auth_get_seqnum();
> +		memcpy(data->rval + chap->hash_len, chap->c2,
> +		       chap->hash_len);
> +		dev_dbg(ctrl->device, "%s: qid %d ctrl challenge %*ph\n",
> +			__func__, chap->qid, (int)chap->hash_len, chap->c2);
> +	} else {
> +		memset(chap->c2, 0, chap->hash_len);
> +		chap->s2 =3D 0;
> +	}
> +	data->seqnum =3D cpu_to_le32(chap->s2);
> +	return size;
> +}
> +
> +static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_success1_data *data =3D chap->buf;
> +	size_t size =3D sizeof(*data);
> +
> +	if (ctrl->opts->dhchap_ctrl_secret)
> +		size +=3D chap->hash_len;
> +
> +	if (chap->buf_size < size) {
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +
> +	if (data->hl !=3D chap->hash_len) {
> +		dev_warn(ctrl->device,
> +			 "qid %d: invalid hash length %u\n",
> +			 chap->qid, data->hl);
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_HASH_UNUSABLE;
> +		return NVME_SC_INVALID_FIELD;
> +	}
> +
> +	/* Just print out information for the admin queue */
> +	if (chap->qid =3D=3D 0)
> +		dev_info(ctrl->device,
> +			 "qid 0: authenticated with hash %s dhgroup %s\n",
> +			 nvme_auth_hmac_name(chap->hash_id),
> +			 nvme_auth_dhgroup_name(chap->dhgroup_id));
> +
> +	if (!data->rvalid)
> +		return 0;
> +
> +	/* Validate controller response */
> +	if (memcmp(chap->response, data->rval, data->hl)) {
> +		dev_dbg(ctrl->device, "%s: qid %d ctrl response %*ph\n",
> +			__func__, chap->qid, (int)chap->hash_len, data->rval);
> +		dev_dbg(ctrl->device, "%s: qid %d host response %*ph\n",
> +			__func__, chap->qid, (int)chap->hash_len,
> +			chap->response);
> +		dev_warn(ctrl->device,
> +			 "qid %d: controller authentication failed\n",
> +			 chap->qid);
> +		chap->status =3D NVME_AUTH_DHCHAP_FAILURE_FAILED;
> +		return NVME_SC_AUTH_REQUIRED;
> +	}
> +
> +	/* Just print out information for the admin queue */
> +	if (chap->qid =3D=3D 0)
> +		dev_info(ctrl->device,
> +			 "qid 0: controller authenticated\n");
> +	return 0;
> +}
> +
> +static int nvme_auth_set_dhchap_success2_data(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_success2_data *data =3D chap->buf;
> +	size_t size =3D sizeof(*data);
> +
> +	memset(chap->buf, 0, size);
> +	data->auth_type =3D NVME_AUTH_DHCHAP_MESSAGES;
> +	data->auth_id =3D NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2;
> +	data->t_id =3D cpu_to_le16(chap->transaction);
> +
> +	return size;
> +}
> +
> +static int nvme_auth_set_dhchap_failure2_data(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	struct nvmf_auth_dhchap_failure_data *data =3D chap->buf;
> +	size_t size =3D sizeof(*data);
> +
> +	memset(chap->buf, 0, size);
> +	data->auth_type =3D NVME_AUTH_DHCHAP_MESSAGES;

Auth_type should be NVME_AUTH_COMMON_MESSAGES.=20

> +	data->auth_id =3D NVME_AUTH_DHCHAP_MESSAGE_FAILURE2;
> +	data->t_id =3D cpu_to_le16(chap->transaction);
> +	data->rescode =3D NVME_AUTH_DHCHAP_FAILURE_REASON_FAILED;
> +	data->rescode_exp =3D chap->status;
> +
> +	return size;
> +}
> +
> +static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
> +	u8 buf[4], *challenge =3D chap->c1;
> +	int ret;
> +
> +	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n=
",
> +		__func__, chap->qid, chap->s1, chap->transaction);
> +
> +	if (!chap->host_response) {
> +		chap->host_response =3D nvme_auth_transform_key(ctrl->host_key,
> +						ctrl->opts->host->nqn);
> +		if (IS_ERR(chap->host_response)) {
> +			ret =3D PTR_ERR(chap->host_response);
> +			chap->host_response =3D NULL;
> +			return ret;
> +		}
> +	} else {
> +		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
> +			__func__, chap->qid);
> +	}
> +
> +	ret =3D crypto_shash_setkey(chap->shash_tfm,
> +			chap->host_response, ctrl->host_key->len);
> +	if (ret) {
> +		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
> +			 chap->qid, ret);
> +		goto out;
> +	}
> +
> +	shash->tfm =3D chap->shash_tfm;
> +	ret =3D crypto_shash_init(shash);
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, challenge, chap->hash_len);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le32(chap->s1, buf);
> +	ret =3D crypto_shash_update(shash, buf, 4);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le16(chap->transaction, buf);
> +	ret =3D crypto_shash_update(shash, buf, 2);
> +	if (ret)
> +		goto out;
> +	memset(buf, 0, sizeof(buf));
> +	ret =3D crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, "HostHost", 8);
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, ctrl->opts->host->nqn,
> +				  strlen(ctrl->opts->host->nqn));
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, ctrl->opts->subsysnqn,
> +			    strlen(ctrl->opts->subsysnqn));
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_final(shash, chap->response);
> +out:
> +	if (challenge !=3D chap->c1)
> +		kfree(challenge);
> +	return ret;
> +}
> +
> +static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)
> +{
> +	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
> +	u8 *ctrl_response;
> +	u8 buf[4], *challenge =3D chap->c2;
> +	int ret;
> +
> +	ctrl_response =3D nvme_auth_transform_key(ctrl->ctrl_key,
> +				ctrl->opts->subsysnqn);
> +	if (IS_ERR(ctrl_response)) {
> +		ret =3D PTR_ERR(ctrl_response);
> +		return ret;
> +	}
> +	ret =3D crypto_shash_setkey(chap->shash_tfm,
> +			ctrl_response, ctrl->ctrl_key->len);
> +	if (ret) {
> +		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
> +			 chap->qid, ret);
> +		goto out;
> +	}
> +
> +	dev_dbg(ctrl->device, "%s: qid %d ctrl response seq %u transaction %d\n=
",
> +		__func__, chap->qid, chap->s2, chap->transaction);
> +	dev_dbg(ctrl->device, "%s: qid %d challenge %*ph\n",
> +		__func__, chap->qid, (int)chap->hash_len, challenge);
> +	dev_dbg(ctrl->device, "%s: qid %d subsysnqn %s\n",
> +		__func__, chap->qid, ctrl->opts->subsysnqn);
> +	dev_dbg(ctrl->device, "%s: qid %d hostnqn %s\n",
> +		__func__, chap->qid, ctrl->opts->host->nqn);
> +	shash->tfm =3D chap->shash_tfm;
> +	ret =3D crypto_shash_init(shash);
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, challenge, chap->hash_len);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le32(chap->s2, buf);
> +	ret =3D crypto_shash_update(shash, buf, 4);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le16(chap->transaction, buf);
> +	ret =3D crypto_shash_update(shash, buf, 2);
> +	if (ret)
> +		goto out;
> +	memset(buf, 0, 4);
> +	ret =3D crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, "Controller", 10);
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, ctrl->opts->subsysnqn,
> +				  strlen(ctrl->opts->subsysnqn));
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_update(shash, ctrl->opts->host->nqn,
> +				  strlen(ctrl->opts->host->nqn));
> +	if (ret)
> +		goto out;
> +	ret =3D crypto_shash_final(shash, chap->response);
> +out:
> +	if (challenge !=3D chap->c2)
> +		kfree(challenge);
> +	return ret;
> +}
> +
> +int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
> +{
> +	struct nvme_dhchap_key *key;
> +	u8 key_hash;
> +
> +	if (!secret) {
> +		*ret_key =3D NULL;
> +		return 0;
> +	}
> +
> +	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) !=3D 1)
> +		return -EINVAL;
> +
> +	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
> +	key =3D nvme_auth_extract_key(secret + 10, key_hash);
> +	if (IS_ERR(key)) {
> +		return PTR_ERR(key);
> +	}
> +
> +	*ret_key =3D key;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
> +
> +static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
> +{
> +	chap->status =3D 0;
> +	chap->error =3D 0;
> +	chap->s1 =3D 0;
> +	chap->s2 =3D 0;
> +	chap->transaction =3D 0;
> +	memset(chap->c1, 0, sizeof(chap->c1));
> +	memset(chap->c2, 0, sizeof(chap->c2));
> +}
> +
> +static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
> +{
> +	__nvme_auth_reset(chap);
> +	if (chap->shash_tfm)
> +		crypto_free_shash(chap->shash_tfm);
> +	kfree_sensitive(chap->host_response);
> +	kfree(chap->buf);
> +	kfree(chap);
> +}
> +
> +static void __nvme_auth_work(struct work_struct *work)
> +{
> +	struct nvme_dhchap_queue_context *chap =3D
> +		container_of(work, struct nvme_dhchap_queue_context, auth_work);
> +	struct nvme_ctrl *ctrl =3D chap->ctrl;
> +	size_t tl;
> +	int ret =3D 0;
> +
> +	chap->transaction =3D ctrl->transaction++;
> +
> +	/* DH-HMAC-CHAP Step 1: send negotiate */
> +	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
> +		__func__, chap->qid);
> +	ret =3D nvme_auth_set_dhchap_negotiate_data(ctrl, chap);
> +	if (ret < 0) {
> +		chap->error =3D ret;
> +		return;
> +	}
> +	tl =3D ret;
> +	ret =3D nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
> +	if (ret) {
> +		chap->error =3D ret;
> +		return;
> +	}
> +
> +	/* DH-HMAC-CHAP Step 2: receive challenge */
> +	dev_dbg(ctrl->device, "%s: qid %d receive challenge\n",
> +		__func__, chap->qid);
> +
> +	memset(chap->buf, 0, chap->buf_size);
> +	ret =3D nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, fa=
lse);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "qid %d failed to receive challenge, %s %d\n",
> +			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
> +		chap->error =3D ret;
> +		return;
> +	}
> +	ret =3D nvme_auth_receive_validate(ctrl, chap->qid, chap->buf, chap->tr=
ansaction,
> +					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
> +	if (ret) {
> +		chap->status =3D ret;
> +		chap->error =3D NVME_SC_AUTH_REQUIRED;
> +		return;
> +	}
> +
> +	ret =3D nvme_auth_process_dhchap_challenge(ctrl, chap);
> +	if (ret) {
> +		/* Invalid challenge parameters */
> +		goto fail2;
> +	}
> +
> +	dev_dbg(ctrl->device, "%s: qid %d host response\n",
> +		__func__, chap->qid);
> +	ret =3D nvme_auth_dhchap_setup_host_response(ctrl, chap);
> +	if (ret)
> +		goto fail2;
> +
> +	/* DH-HMAC-CHAP Step 3: send reply */
> +	dev_dbg(ctrl->device, "%s: qid %d send reply\n",
> +		__func__, chap->qid);
> +	ret =3D nvme_auth_set_dhchap_reply_data(ctrl, chap);
> +	if (ret < 0)
> +		goto fail2;
> +
> +	tl =3D ret;
> +	ret =3D nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
> +	if (ret)
> +		goto fail2;
> +
> +	/* DH-HMAC-CHAP Step 4: receive success1 */
> +	dev_dbg(ctrl->device, "%s: qid %d receive success1\n",
> +		__func__, chap->qid);
> +
> +	memset(chap->buf, 0, chap->buf_size);
> +	ret =3D nvme_auth_submit(ctrl, chap->qid, chap->buf, chap->buf_size, fa=
lse);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "qid %d failed to receive success1, %s %d\n",
> +			 chap->qid, ret < 0 ? "error" : "nvme status", ret);
> +		chap->error =3D ret;
> +		return;
> +	}
> +	ret =3D nvme_auth_receive_validate(ctrl, chap->qid,
> +					 chap->buf, chap->transaction,
> +					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
> +	if (ret) {
> +		chap->status =3D ret;
> +		chap->error =3D NVME_SC_AUTH_REQUIRED;
> +		return;
> +	}
> +
> +	if (ctrl->opts->dhchap_ctrl_secret) {
> +		dev_dbg(ctrl->device,
> +			"%s: qid %d controller response\n",
> +			__func__, chap->qid);
> +		ret =3D nvme_auth_dhchap_setup_ctrl_response(ctrl, chap);
> +		if (ret) {
> +			chap->error =3D ret;
> +			goto fail2;
> +		}
> +	}
> +
> +	ret =3D nvme_auth_process_dhchap_success1(ctrl, chap);
> +	if (ret) {
> +		/* Controller authentication failed */
> +		chap->error =3D NVME_SC_AUTH_REQUIRED;
> +		goto fail2;
> +	}
> +
> +	/* DH-HMAC-CHAP Step 5: send success2 */
> +	dev_dbg(ctrl->device, "%s: qid %d send success2\n",
> +		__func__, chap->qid);
> +	tl =3D nvme_auth_set_dhchap_success2_data(ctrl, chap);

Host should send DH-HMAC-CHAP_Success2 message only if it requested bidirec=
tional authentication and that authentication succeeded.

> +	ret =3D nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
> +	if (!ret) {
> +		chap->error =3D 0;
> +		return;
> +	}
> +
> +fail2:
> +	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
> +		__func__, chap->qid, chap->status);
> +	tl =3D nvme_auth_set_dhchap_failure2_data(ctrl, chap);
> +	ret =3D nvme_auth_submit(ctrl, chap->qid, chap->buf, tl, true);
> +	/*
> +	 * only update error if send failure2 failed and no other
> +	 * error had been set during authentication.
> +	 */
> +	if (ret && !chap->error)
> +		chap->error =3D ret;
> +}
> +
> +int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
> +{
> +	struct nvme_dhchap_queue_context *chap;
> +
> +	if (!ctrl->host_key) {
> +		dev_warn(ctrl->device, "qid %d: no key\n", qid);
> +		return -ENOKEY;
> +	}
> +
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	/* Check if the context is already queued */
> +	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
> +		WARN_ON(!chap->buf);
> +		if (chap->qid =3D=3D qid) {
> +			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
> +			mutex_unlock(&ctrl->dhchap_auth_mutex);
> +			flush_work(&chap->auth_work);
> +			__nvme_auth_reset(chap);
> +			queue_work(nvme_wq, &chap->auth_work);
> +			return 0;
> +		}
> +	}
> +	chap =3D kzalloc(sizeof(*chap), GFP_KERNEL);
> +	if (!chap) {
> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
> +		return -ENOMEM;
> +	}
> +	chap->qid =3D (qid =3D=3D NVME_QID_ANY) ? 0 : qid;
> +	chap->ctrl =3D ctrl;
> +
> +	/*
> +	 * Allocate a large enough buffer for the entire negotiation:
> +	 * 4k should be enough to ffdhe8192.
> +	 */
> +	chap->buf_size =3D 4096;
> +	chap->buf =3D kzalloc(chap->buf_size, GFP_KERNEL);
> +	if (!chap->buf) {
> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
> +		kfree(chap);
> +		return -ENOMEM;
> +	}
> +
> +	INIT_WORK(&chap->auth_work, __nvme_auth_work);
> +	list_add(&chap->entry, &ctrl->dhchap_auth_list);
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
> +	queue_work(nvme_wq, &chap->auth_work);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
> +
> +int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
> +{
> +	struct nvme_dhchap_queue_context *chap;
> +	int ret;
> +
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
> +		if (chap->qid !=3D qid)
> +			continue;
> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
> +		flush_work(&chap->auth_work);
> +		ret =3D chap->error;
> +		return ret;
> +	}
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
> +	return -ENXIO;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_wait);
> +
> +void nvme_auth_reset(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_dhchap_queue_context *chap;
> +
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
> +		mutex_unlock(&ctrl->dhchap_auth_mutex);
> +		flush_work(&chap->auth_work);
> +		__nvme_auth_reset(chap);
> +	}
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_reset);
> +
> +static void nvme_dhchap_auth_work(struct work_struct *work)
> +{
> +	struct nvme_ctrl *ctrl =3D
> +		container_of(work, struct nvme_ctrl, dhchap_auth_work);
> +	int ret, q;
> +
> +	/* Authenticate admin queue first */
> +	ret =3D nvme_auth_negotiate(ctrl, 0);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "qid 0: error %d setting up authentication\n", ret);
> +		return;
> +	}
> +	ret =3D nvme_auth_wait(ctrl, 0);
> +	if (ret) {
> +		dev_warn(ctrl->device,
> +			 "qid 0: authentication failed\n");
> +		return;
> +	}
> +
> +	for (q =3D 1; q < ctrl->queue_count; q++) {
> +		ret =3D nvme_auth_negotiate(ctrl, q);
> +		if (ret) {
> +			dev_warn(ctrl->device,
> +				 "qid %d: error %d setting up authentication\n",
> +				 q, ret);
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * Failure is a soft-state; credentials remain valid until
> +	 * the controller terminates the connection.
> +	 */
> +}
> +
> +void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	INIT_LIST_HEAD(&ctrl->dhchap_auth_list);
> +	INIT_WORK(&ctrl->dhchap_auth_work, nvme_dhchap_auth_work);
> +	mutex_init(&ctrl->dhchap_auth_mutex);
> +	if (!ctrl->opts)
> +		return;
> +	nvme_auth_generate_key(ctrl->opts->dhchap_secret, &ctrl->host_key);
> +	nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret, &ctrl->ctrl_key)=
;
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
> +
> +void nvme_auth_stop(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_dhchap_queue_context *chap =3D NULL, *tmp;
> +
> +	cancel_work_sync(&ctrl->dhchap_auth_work);
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry)
> +		cancel_work_sync(&chap->auth_work);
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_stop);
> +
> +void nvme_auth_free(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_dhchap_queue_context *chap =3D NULL, *tmp;
> +
> +	mutex_lock(&ctrl->dhchap_auth_mutex);
> +	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
> +		list_del_init(&chap->entry);
> +		flush_work(&chap->auth_work);
> +		__nvme_auth_free(chap);
> +	}
> +	mutex_unlock(&ctrl->dhchap_auth_mutex);
> +	if (ctrl->host_key) {
> +		nvme_auth_free_key(ctrl->host_key);
> +		ctrl->host_key =3D NULL;
> +	}
> +	if (ctrl->ctrl_key) {
> +		nvme_auth_free_key(ctrl->ctrl_key);
> +		ctrl->ctrl_key =3D NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nvme_auth_free);
> diff --git a/drivers/nvme/host/auth.h b/drivers/nvme/host/auth.h
> new file mode 100644
> index 000000000000..73d6ec63a5c8
> --- /dev/null
> +++ b/drivers/nvme/host/auth.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 Hannes Reinecke, SUSE Software Solutions
> + */
> +
> +#ifndef _NVME_AUTH_H
> +#define _NVME_AUTH_H
> +
> +#include <crypto/kpp.h>
> +
> +struct nvme_dhchap_key {
> +	u8 *key;
> +	size_t len;
> +	u8 hash;
> +};
> +
> +u32 nvme_auth_get_seqnum(void);
> +const char *nvme_auth_dhgroup_name(u8 dhgroup_id);
> +const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id);
> +u8 nvme_auth_dhgroup_id(const char *dhgroup_name);
> +
> +const char *nvme_auth_hmac_name(u8 hmac_id);
> +const char *nvme_auth_digest_name(u8 hmac_id);
> +size_t nvme_auth_hmac_hash_len(u8 hmac_id);
> +u8 nvme_auth_hmac_id(const char *hmac_name);
> +
> +struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
> +					      u8 key_hash);
> +void nvme_auth_free_key(struct nvme_dhchap_key *key);
> +u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
> +
> +#endif /* _NVME_AUTH_H */
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cd6eac8e3dd6..dc10ba7cfc6c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -24,6 +24,7 @@
>=20
> #include "nvme.h"
> #include "fabrics.h"
> +#include "auth.h"
>=20
> #define CREATE_TRACE_POINTS
> #include "trace.h"
> @@ -334,6 +335,7 @@ enum nvme_disposition {
> 	COMPLETE,
> 	RETRY,
> 	FAILOVER,
> +	AUTHENTICATE,
> };
>=20
> static inline enum nvme_disposition nvme_decide_disposition(struct reques=
t *req)
> @@ -341,6 +343,9 @@ static inline enum nvme_disposition nvme_decide_dispo=
sition(struct request *req)
> 	if (likely(nvme_req(req)->status =3D=3D 0))
> 		return COMPLETE;
>=20
> +	if ((nvme_req(req)->status & 0x7ff) =3D=3D NVME_SC_AUTH_REQUIRED)
> +		return AUTHENTICATE;
> +
> 	if (blk_noretry_request(req) ||
> 	    (nvme_req(req)->status & NVME_SC_DNR) ||
> 	    nvme_req(req)->retries >=3D nvme_max_retries)
> @@ -379,11 +384,13 @@ static inline void nvme_end_req(struct request *req=
)
>=20
> void nvme_complete_rq(struct request *req)
> {
> +	struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
> +
> 	trace_nvme_complete_rq(req);
> 	nvme_cleanup_cmd(req);
>=20
> -	if (nvme_req(req)->ctrl->kas)
> -		nvme_req(req)->ctrl->comp_seen =3D true;
> +	if (ctrl->kas)
> +		ctrl->comp_seen =3D true;
>=20
> 	switch (nvme_decide_disposition(req)) {
> 	case COMPLETE:
> @@ -395,6 +402,14 @@ void nvme_complete_rq(struct request *req)
> 	case FAILOVER:
> 		nvme_failover_req(req);
> 		return;
> +	case AUTHENTICATE:
> +#ifdef CONFIG_NVME_AUTH
> +		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> +		nvme_retry_req(req);
> +#else
> +		nvme_end_req(req);
> +#endif
> +		return;
> 	}
> }
> EXPORT_SYMBOL_GPL(nvme_complete_rq);
> @@ -706,7 +721,9 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struc=
t request *rq,
> 		switch (ctrl->state) {
> 		case NVME_CTRL_CONNECTING:
> 			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
> -			    req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_connect)
> +			    (req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_connect ||
> +			     req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_auth_send ||
> +			     req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_auth_receive))
> 				return true;
> 			break;
> 		default:
> @@ -3563,6 +3580,108 @@ static ssize_t dctype_show(struct device *dev,
> }
> static DEVICE_ATTR_RO(dctype);
>=20
> +#ifdef CONFIG_NVME_AUTH
> +static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	struct nvmf_ctrl_options *opts =3D ctrl->opts;
> +
> +	if (!opts->dhchap_secret)
> +		return sysfs_emit(buf, "none\n");
> +	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
> +}
> +
> +static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	struct nvmf_ctrl_options *opts =3D ctrl->opts;
> +	char *dhchap_secret;
> +
> +	if (!ctrl->opts->dhchap_secret)
> +		return -EINVAL;
> +	if (count < 7)
> +		return -EINVAL;
> +	if (memcmp(buf, "DHHC-1:", 7))
> +		return -EINVAL;
> +
> +	dhchap_secret =3D kzalloc(count + 1, GFP_KERNEL);
> +	if (!dhchap_secret)
> +		return -ENOMEM;
> +	memcpy(dhchap_secret, buf, count);
> +	nvme_auth_stop(ctrl);
> +	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
> +		int ret;
> +
> +		ret =3D nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
> +		if (ret)
> +			return ret;
> +		kfree(opts->dhchap_secret);
> +		opts->dhchap_secret =3D dhchap_secret;
> +		/* Key has changed; re-authentication with new key */
> +		nvme_auth_reset(ctrl);
> +	}
> +	/* Start re-authentication */
> +	dev_info(ctrl->device, "re-authenticating controller\n");
> +	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> +
> +	return count;
> +}
> +DEVICE_ATTR(dhchap_secret, S_IRUGO | S_IWUSR,
> +	nvme_ctrl_dhchap_secret_show, nvme_ctrl_dhchap_secret_store);
> +
> +static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	struct nvmf_ctrl_options *opts =3D ctrl->opts;
> +
> +	if (!opts->dhchap_ctrl_secret)
> +		return sysfs_emit(buf, "none\n");
> +	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
> +}
> +
> +static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
> +	struct nvmf_ctrl_options *opts =3D ctrl->opts;
> +	char *dhchap_secret;
> +
> +	if (!ctrl->opts->dhchap_ctrl_secret)
> +		return -EINVAL;
> +	if (count < 7)
> +		return -EINVAL;
> +	if (memcmp(buf, "DHHC-1:", 7))
> +		return -EINVAL;
> +
> +	dhchap_secret =3D kzalloc(count + 1, GFP_KERNEL);
> +	if (!dhchap_secret)
> +		return -ENOMEM;
> +	memcpy(dhchap_secret, buf, count);
> +	nvme_auth_stop(ctrl);
> +	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
> +		int ret;
> +
> +		ret =3D nvme_auth_generate_key(dhchap_secret, &ctrl->ctrl_key);
> +		if (ret)
> +			return ret;
> +		kfree(opts->dhchap_ctrl_secret);
> +		opts->dhchap_ctrl_secret =3D dhchap_secret;
> +		/* Key has changed; re-authentication with new key */
> +		nvme_auth_reset(ctrl);
> +	}
> +	/* Start re-authentication */
> +	dev_info(ctrl->device, "re-authenticating controller\n");
> +	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
> +
> +	return count;
> +}
> +DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
> +	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
> +#endif
> +
> static struct attribute *nvme_dev_attrs[] =3D {
> 	&dev_attr_reset_controller.attr,
> 	&dev_attr_rescan_controller.attr,
> @@ -3586,6 +3705,10 @@ static struct attribute *nvme_dev_attrs[] =3D {
> 	&dev_attr_kato.attr,
> 	&dev_attr_cntrltype.attr,
> 	&dev_attr_dctype.attr,
> +#ifdef CONFIG_NVME_AUTH
> +	&dev_attr_dhchap_secret.attr,
> +	&dev_attr_dhchap_ctrl_secret.attr,
> +#endif
> 	NULL
> };
>=20
> @@ -3609,6 +3732,10 @@ static umode_t nvme_dev_attrs_are_visible(struct k=
object *kobj,
> 		return 0;
> 	if (a =3D=3D &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
> 		return 0;
> +#ifdef CONFIG_NVME_AUTH
> +	if (a =3D=3D &dev_attr_dhchap_secret.attr && !ctrl->opts)
> +		return 0;
> +#endif
>=20
> 	return a->mode;
> }
> @@ -4450,8 +4577,10 @@ static void nvme_handle_aen_notice(struct nvme_ctr=
l *ctrl, u32 result)
> 		 * recovery actions from interfering with the controller's
> 		 * firmware activation.
> 		 */
> -		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
> +			nvme_auth_stop(ctrl);
> 			queue_work(nvme_wq, &ctrl->fw_act_work);
> +		}
> 		break;
> #ifdef CONFIG_NVME_MULTIPATH
> 	case NVME_AER_NOTICE_ANA:
> @@ -4498,6 +4627,7 @@ EXPORT_SYMBOL_GPL(nvme_complete_async_event);
> void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> {
> 	nvme_mpath_stop(ctrl);
> +	nvme_auth_stop(ctrl);
> 	nvme_stop_keep_alive(ctrl);
> 	nvme_stop_failfast_work(ctrl);
> 	flush_work(&ctrl->async_event_work);
> @@ -4554,6 +4684,8 @@ static void nvme_free_ctrl(struct device *dev)
>=20
> 	nvme_free_cels(ctrl);
> 	nvme_mpath_uninit(ctrl);
> +	nvme_auth_stop(ctrl);
> +	nvme_auth_free(ctrl);
> 	__free_page(ctrl->discard_page);
>=20
> 	if (subsys) {
> @@ -4644,6 +4776,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct d=
evice *dev,
>=20
> 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
> 	nvme_mpath_init_ctrl(ctrl);
> +	nvme_auth_init_ctrl(ctrl);
>=20
> 	return 0;
> out_free_name:
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 953e3076aab1..f5786a60931c 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -369,6 +369,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
> 	union nvme_result res;
> 	struct nvmf_connect_data *data;
> 	int ret;
> +	u32 result;
>=20
> 	cmd.connect.opcode =3D nvme_fabrics_command;
> 	cmd.connect.fctype =3D nvme_fabrics_type_connect;
> @@ -401,8 +402,25 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
> 		goto out_free_data;
> 	}
>=20
> -	ctrl->cntlid =3D le16_to_cpu(res.u16);
> -
> +	result =3D le32_to_cpu(res.u32);
> +	ctrl->cntlid =3D result & 0xFFFF;
> +	if ((result >> 16) & 2) {
> +		/* Authentication required */
> +		ret =3D nvme_auth_negotiate(ctrl, 0);
> +		if (ret) {
> +			dev_warn(ctrl->device,
> +				 "qid 0: authentication setup failed\n");
> +			ret =3D NVME_SC_AUTH_REQUIRED;
> +			goto out_free_data;
> +		}
> +		ret =3D nvme_auth_wait(ctrl, 0);
> +		if (ret)
> +			dev_warn(ctrl->device,
> +				 "qid 0: authentication failed\n");
> +		else
> +			dev_info(ctrl->device,
> +				 "qid 0: authenticated\n");
> +	}
> out_free_data:
> 	kfree(data);
> 	return ret;
> @@ -435,6 +453,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16=
 qid)
> 	struct nvmf_connect_data *data;
> 	union nvme_result res;
> 	int ret;
> +	u32 result;
>=20
> 	cmd.connect.opcode =3D nvme_fabrics_command;
> 	cmd.connect.fctype =3D nvme_fabrics_type_connect;
> @@ -460,6 +479,21 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u1=
6 qid)
> 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
> 				       &cmd, data);
> 	}
> +	result =3D le32_to_cpu(res.u32);
> +	if ((result >> 16) & 2) {
> +		/* Authentication required */
> +		ret =3D nvme_auth_negotiate(ctrl, qid);
> +		if (ret) {
> +			dev_warn(ctrl->device,
> +				 "qid %d: authentication setup failed\n", qid);
> +			ret =3D NVME_SC_AUTH_REQUIRED;
> +		} else {
> +			ret =3D nvme_auth_wait(ctrl, qid);
> +			if (ret)
> +				dev_warn(ctrl->device,
> +					 "qid %u: authentication failed\n", qid);
> +		}
> +	}
> 	kfree(data);
> 	return ret;
> }
> @@ -552,6 +586,8 @@ static const match_table_t opt_tokens =3D {
> 	{ NVMF_OPT_TOS,			"tos=3D%d"		},
> 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=3D%d"	},
> 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
> +	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=3D%s"	},
> +	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=3D%s"	},
> 	{ NVMF_OPT_ERR,			NULL			}
> };
>=20
> @@ -833,6 +869,34 @@ static int nvmf_parse_options(struct nvmf_ctrl_optio=
ns *opts,
> 		case NVMF_OPT_DISCOVERY:
> 			opts->discovery_nqn =3D true;
> 			break;
> +		case NVMF_OPT_DHCHAP_SECRET:
> +			p =3D match_strdup(args);
> +			if (!p) {
> +				ret =3D -ENOMEM;
> +				goto out;
> +			}
> +			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
> +				pr_err("Invalid DH-CHAP secret %s\n", p);
> +				ret =3D -EINVAL;
> +				goto out;
> +			}
> +			kfree(opts->dhchap_secret);
> +			opts->dhchap_secret =3D p;
> +			break;
> +		case NVMF_OPT_DHCHAP_CTRL_SECRET:
> +			p =3D match_strdup(args);
> +			if (!p) {
> +				ret =3D -ENOMEM;
> +				goto out;
> +			}
> +			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
> +				pr_err("Invalid DH-CHAP secret %s\n", p);
> +				ret =3D -EINVAL;
> +				goto out;
> +			}
> +			kfree(opts->dhchap_ctrl_secret);
> +			opts->dhchap_ctrl_secret =3D p;
> +			break;
> 		default:
> 			pr_warn("unknown parameter or missing value '%s' in ctrl creation requ=
est\n",
> 				p);
> @@ -951,6 +1015,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opt=
s)
> 	kfree(opts->subsysnqn);
> 	kfree(opts->host_traddr);
> 	kfree(opts->host_iface);
> +	kfree(opts->dhchap_secret);
> 	kfree(opts);
> }
> EXPORT_SYMBOL_GPL(nvmf_free_options);
> @@ -960,7 +1025,8 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
> 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
> 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
> 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
> -				 NVMF_OPT_FAIL_FAST_TMO)
> +				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
> +				 NVMF_OPT_DHCHAP_CTRL_SECRET)
>=20
> static struct nvme_ctrl *
> nvmf_create_ctrl(struct device *dev, const char *buf)
> @@ -1196,7 +1262,14 @@ static void __exit nvmf_exit(void)
> 	BUILD_BUG_ON(sizeof(struct nvmf_connect_command) !=3D 64);
> 	BUILD_BUG_ON(sizeof(struct nvmf_property_get_command) !=3D 64);
> 	BUILD_BUG_ON(sizeof(struct nvmf_property_set_command) !=3D 64);
> +	BUILD_BUG_ON(sizeof(struct nvmf_auth_send_command) !=3D 64);
> +	BUILD_BUG_ON(sizeof(struct nvmf_auth_receive_command) !=3D 64);
> 	BUILD_BUG_ON(sizeof(struct nvmf_connect_data) !=3D 1024);
> +	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_negotiate_data) !=3D 8);
> +	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_challenge_data) !=3D 16);
> +	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_reply_data) !=3D 16);
> +	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_success1_data) !=3D 16);
> +	BUILD_BUG_ON(sizeof(struct nvmf_auth_dhchap_success2_data) !=3D 16);
> }
>=20
> MODULE_LICENSE("GPL v2");
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 1e3a09cad961..15c142b277ab 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -68,6 +68,8 @@ enum {
> 	NVMF_OPT_FAIL_FAST_TMO	=3D 1 << 20,
> 	NVMF_OPT_HOST_IFACE	=3D 1 << 21,
> 	NVMF_OPT_DISCOVERY	=3D 1 << 22,
> +	NVMF_OPT_DHCHAP_SECRET	=3D 1 << 23,
> +	NVMF_OPT_DHCHAP_CTRL_SECRET =3D 1 << 24,
> };
>=20
> /**
> @@ -97,6 +99,9 @@ enum {
>  * @max_reconnects: maximum number of allowed reconnect attempts before r=
emoving
>  *              the controller, (-1) means reconnect forever, zero means =
remove
>  *              immediately;
> + * @dhchap_secret: DH-HMAC-CHAP secret
> + * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directiona=
l
> + *              authentication
>  * @disable_sqflow: disable controller sq flow control
>  * @hdr_digest: generate/verify header digest (TCP)
>  * @data_digest: generate/verify data digest (TCP)
> @@ -121,6 +126,8 @@ struct nvmf_ctrl_options {
> 	unsigned int		kato;
> 	struct nvmf_host	*host;
> 	int			max_reconnects;
> +	char			*dhchap_secret;
> +	char			*dhchap_ctrl_secret;
> 	bool			disable_sqflow;
> 	bool			hdr_digest;
> 	bool			data_digest;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1ea908d43e17..f110437a3190 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -323,6 +323,15 @@ struct nvme_ctrl {
> 	struct work_struct ana_work;
> #endif
>=20
> +#ifdef CONFIG_NVME_AUTH
> +	struct work_struct dhchap_auth_work;
> +	struct list_head dhchap_auth_list;
> +	struct mutex dhchap_auth_mutex;
> +	struct nvme_dhchap_key *host_key;
> +	struct nvme_dhchap_key *ctrl_key;
> +	u16 transaction;
> +#endif
> +
> 	/* Power saving configuration */
> 	u64 ps_max_latency_us;
> 	bool apst_enabled;
> @@ -928,6 +937,28 @@ static inline bool nvme_ctrl_sgl_supported(struct nv=
me_ctrl *ctrl)
> 	return ctrl->sgls & ((1 << 0) | (1 << 1));
> }
>=20
> +#ifdef CONFIG_NVME_AUTH
> +void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
> +void nvme_auth_stop(struct nvme_ctrl *ctrl);
> +int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
> +int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
> +void nvme_auth_reset(struct nvme_ctrl *ctrl);
> +void nvme_auth_free(struct nvme_ctrl *ctrl);
> +int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)=
;
> +#else
> +static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
> +static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
> +static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
> +{
> +	return -EPROTONOSUPPORT;
> +}
> +static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
> +{
> +	return NVME_SC_AUTH_REQUIRED;
> +}
> +static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
> +#endif
> +
> u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> 			 u8 opcode);
> int nvme_execute_passthru_rq(struct request *rq);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d9f19d901313..bd63568c0068 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1197,6 +1197,7 @@ static void nvme_rdma_error_recovery_work(struct wo=
rk_struct *work)
> 	struct nvme_rdma_ctrl *ctrl =3D container_of(work,
> 			struct nvme_rdma_ctrl, err_work);
>=20
> +	nvme_auth_stop(&ctrl->ctrl);
> 	nvme_stop_keep_alive(&ctrl->ctrl);
> 	flush_work(&ctrl->ctrl.async_event_work);
> 	nvme_rdma_teardown_io_queues(ctrl, false);
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ad3a2bf2f1e9..be52902b5f3b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2174,6 +2174,7 @@ static void nvme_tcp_error_recovery_work(struct wor=
k_struct *work)
> 				struct nvme_tcp_ctrl, err_work);
> 	struct nvme_ctrl *ctrl =3D &tcp_ctrl->ctrl;
>=20
> +	nvme_auth_stop(ctrl);
> 	nvme_stop_keep_alive(ctrl);
> 	flush_work(&ctrl->async_event_work);
> 	nvme_tcp_teardown_io_queues(ctrl, false);
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index 2a89c5aa0790..1c36fcedea20 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -287,6 +287,34 @@ static const char *nvme_trace_fabrics_property_get(s=
truct trace_seq *p, u8 *spc)
> 	return ret;
> }
>=20
> +static const char *nvme_trace_fabrics_auth_send(struct trace_seq *p, u8 =
*spc)
> +{
> +	const char *ret =3D trace_seq_buffer_ptr(p);
> +	u8 spsp0 =3D spc[1];
> +	u8 spsp1 =3D spc[2];
> +	u8 secp =3D spc[3];
> +	u32 tl =3D get_unaligned_le32(spc + 4);
> +
> +	trace_seq_printf(p, "spsp0=3D%02x, spsp1=3D%02x, secp=3D%02x, tl=3D%u",
> +			 spsp0, spsp1, secp, tl);
> +	trace_seq_putc(p, 0);
> +	return ret;
> +}
> +
> +static const char *nvme_trace_fabrics_auth_receive(struct trace_seq *p, =
u8 *spc)
> +{
> +	const char *ret =3D trace_seq_buffer_ptr(p);
> +	u8 spsp0 =3D spc[1];
> +	u8 spsp1 =3D spc[2];
> +	u8 secp =3D spc[3];
> +	u32 al =3D get_unaligned_le32(spc + 4);
> +
> +	trace_seq_printf(p, "spsp0=3D%02x, spsp1=3D%02x, secp=3D%02x, al=3D%u",
> +			 spsp0, spsp1, secp, al);
> +	trace_seq_putc(p, 0);
> +	return ret;
> +}
> +
> static const char *nvme_trace_fabrics_common(struct trace_seq *p, u8 *spc=
)
> {
> 	const char *ret =3D trace_seq_buffer_ptr(p);
> @@ -306,6 +334,10 @@ const char *nvme_trace_parse_fabrics_cmd(struct trac=
e_seq *p,
> 		return nvme_trace_fabrics_connect(p, spc);
> 	case nvme_fabrics_type_property_get:
> 		return nvme_trace_fabrics_property_get(p, spc);
> +	case nvme_fabrics_type_auth_send:
> +		return nvme_trace_fabrics_auth_send(p, spc);
> +	case nvme_fabrics_type_auth_receive:
> +		return nvme_trace_fabrics_auth_receive(p, spc);
> 	default:
> 		return nvme_trace_fabrics_common(p, spc);
> 	}
> --=20
> 2.29.2
>=20
>=20
>=20

Thanks
Prashanth=

