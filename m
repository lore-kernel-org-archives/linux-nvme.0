Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA9EC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:21:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BEF264F5F
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEF264F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=4065kTnj+njTqoL4lQoo6xLoGanJ+Bz/ewZaKFRWKK0=; b=bbnhdnyr20W/HUw4GjDYJ7ol/
	vz13/vOHOA5X8mcwGI2bGWIuH3AJQLYuV9aU8V2Haqf+hUvHUyOGcMYIBsMMZYqv4JDqpzollKN/F
	/4KTZsF+eucOCo0/325d3Yfu0Bxzdi3MHbfY1VJxhVpdlFisIELZG+M85qLO7+ckIx0jrtJJT3d6o
	agHxrSct2cB1D/ZgTAYGXwNfi3TaJQGU7Tpf6eSAa13hsaO3B0peK6g2mLaCv1+dBdeezIIih7UEf
	MZlam/pFEkDpphyI+p28gTQFYpz99/ZCxuOqU59RBhYwQx/FoPAVWjm1bhaRkWmadsA++9nUJT67X
	Z2Ezr4O/g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJAC3-00FhU1-MZ; Mon, 08 Mar 2021 07:20:43 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJA5N-00FfWb-Av
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 07:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615187629; x=1646723629;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2BPg7mqfbvdcNBe3f8F/yNCTt29gpn7ySiv955WBKbc=;
 b=CTMokSZJX73L7ZpbGWgh6/gnSrULjyY206cn2bfn+glpVbwihFXtkrBh
 7pYx0egdyCqTgxfGyhMP7A5TM7fFs9NBZi0e/TYsUkrE86tZ/G85OTWSY
 BAP5w0wsFfQp5HedLq1vHapOB1Tv8qHb98ChnAE5A4yN7QMP68/ZCkdC2
 SBXchkj0shoSfMl1tD5eJ/e5bCkbCYegGEPONvHVko6dme5YGHj+k2apA
 oEGKqT0xNPMktIwwBNwhJ7raM670vryuJLZ8DPalI+fKSoncl1aacJdMC
 MvHGMq67eal32WWnKfUmPIKOFIDUjgqV3vXe+ULgRr4urJUhejeHazVAs A==;
IronPort-SDR: Aazn2uL+l0737EFhTqaPGp6EbOTMsUEvezzNsSQq1Dl7iaSsVLtDbr/LaN1KRI4qUWVCYkpsd9
 zZikkuZfbOvek6RgqCuup0zEdPiXk+Iemaa6DaAXHnnJLh2V/iLnjR4P5cCDpYcWzI7yXOXZY+
 chnWXxxWl0KcfzJnt8NiP79j8LVxdQ5eNhhdPLn/q2ZnEPS16vbiGEMNCCTFilBxpqexZbFLyY
 wFyVVxZBxsIH1LFDMq2gSkPsSFBJTfS7NQHL6I22v1t6Vl6Dxefy8OlqEu/jVPVN9M6hm0Sfn6
 EjA=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; d="scan'208";a="166084077"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 15:13:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VasvujBSuv4TYiPQypBPYqXgGywNumL77MvYLcq7HH/tBcb6e+D2gcH9Qr4q3MINEL4rpaebH0DJKUTyGSnnoMHpaY+BXvDYjBx7CSLXyJ0/YXv+szc17lSvUgGzZ0H2+CjHmRo9FBdNtA7jHTaAEOACQg39d3ZhjvwGo/fj5l/NX90O7bhEQs05ck/yOK4aplF4DFxOEY/OaeIJpXRFYuroi0C376eK2e7HneHGEzeI5XJO1MiiNSNk5F2ft49+9fspw23JTko1NPnpB9XhBChr+SENDHgbdUB6MelAqpJ/+GN7Ze9usF5JUDss/12BRNUU6cUQd8bdaGp2Piglgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BPg7mqfbvdcNBe3f8F/yNCTt29gpn7ySiv955WBKbc=;
 b=UrkGNyb5d01Q2YHET6aWgLX/G9J1q96G82QqBkTRwa0p/ipNGo4sLRFtrjN5jgvt9bdq8D8vrFvPat49ZmjJ+t+d2GIy0uVc3pSOxDnRZuzUj0h+FzuRTvsw35zSMnEobtPCmr0hS5WBrWIkqLPz3+3ItbIpPExls3AVqoBc8dbEewltzkA7TE+ObrL9x8xRTljpBAkJZaEKJsrjVSfLxf3bngHX7m8oC+GV9sIF1a07wwEB67YEUKbSit4ZJUEDmGxseFnwpTNnh/Q6yEM1Lxdgd9yKqlIogQMIHUvzqylWEy+9VqboCwrH/9UbC3K637GRw/WNqIaCRirTAIKCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BPg7mqfbvdcNBe3f8F/yNCTt29gpn7ySiv955WBKbc=;
 b=Pz5YUcKaSWoX5zvvGMDh9debkRXbF+idKUSmRnPpOzwPxuNezbu10kRtct6G87iggK7c5MkhBxVim47zetcKG8oEE8dA7BRvuJNmZsVPJXONxSsc4gQDKSbP5rPI2HhiYsgc7NyVWxO/a7Or06pVxAcBfJIBIQI8W9Qnk+37x1k=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6023.namprd04.prod.outlook.com (2603:10b6:a03:e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 07:13:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:13:44 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Enzo
 Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 09/10] fabrics: fix some memory leaks
Thread-Topic: [PATCH 09/10] fabrics: fix some memory leaks
Thread-Index: AQHXEiDLp5HUXKv6AUuF/mwjEfkPqQ==
Date: Mon, 8 Mar 2021 07:13:44 +0000
Message-ID: <BYAPR04MB4965BA78DC9DE616AB79D28786939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-10-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a0dace5-196d-4405-74c4-08d8e201b5c8
x-ms-traffictypediagnostic: BYAPR04MB6023:
x-microsoft-antispam-prvs: <BYAPR04MB602346DE3EF897C65A52127B86939@BYAPR04MB6023.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKl4UVtzxKc/fMDAQuJ9QGq5eRco7XEKQSlVU+rGeFLwXVZFDLfDsnph3t7blZ2C5BQ3KevS9DQu9UVEYM+OHRDIC9vsrw+TPgSAUwz0JWdPnErjUS3BRmYZliSTiJWaLgNzGibgqKuvb9nq2xbeqYccfz1yqxvsqT2PexAEczUnNddZLoRzq/7VTsikNfQCCi50lyr+qy93qdz80ygcR7JsKTiDC/GfD7u3zmpjBVeD8ORynXzX5W0fkvoNNUWocmcQ11HACoaz5Jt86a05b3jOuFVjf8nNLxacGH2m1gMGkdM9QqanjLejy19YMadYhA4Eoj0GbvXr9i13OzJR+8MSUlkt3K6uP6IKaeH2ltmvfDBF/yMIHTDsRd4y+N5oIVI58+mIj0mHzM+5lJeRp7hfYBR+nX7unSkszxuDZ823EbCbtwAhbmx8gIgrhX+VhceT6YEiustujEOP/e3VX5lei8Md6+sOxuq+TUOWjuEc/dDu0WqL+w/B2KnhApchSY/wfCyI3ENI5fgkySeYxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(110136005)(76116006)(54906003)(86362001)(66556008)(5660300002)(66946007)(52536014)(8676002)(66476007)(66446008)(71200400001)(64756008)(8936002)(55016002)(83380400001)(26005)(6506007)(316002)(4326008)(53546011)(478600001)(186003)(9686003)(7696005)(4744005)(2906002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D4RvJqxXj6/o4ppHnptLt/uBwRlryEdYAkldJdQ2Eu8sq676IqhNjWXsWXR5?=
 =?us-ascii?Q?qKFWicNxoKTICf2FmephmS+tVYNbWN4sW+7JbnlPwyzF/lp4US90iu62afme?=
 =?us-ascii?Q?iLug4m2VFZtDmOKHnVZ/6hka8c4Bn3ld2ux9aTytYR+cH47epg+0f/wu0eyA?=
 =?us-ascii?Q?/coXuBiKVQofs9tc3rL50NFDWQt1b8+XZjSbPRhVN2GrU0fGoyym2jOXfXgL?=
 =?us-ascii?Q?WswVViGBvqqRIkzY77kafYqm0k5537mIJpcIHet5Rhe2oNqZB3zWCgGdur2G?=
 =?us-ascii?Q?i7urBmW0eYEm1BWbmUkZaczV1MkRODHiviU+G5YdD6q+n651uGFq/ZEu/RXS?=
 =?us-ascii?Q?uiwTd5BLiwA09/unSvnH6m06+HTY8ogOTUeFCGTRLLkHV3NID70r+Uo6YBk0?=
 =?us-ascii?Q?xva6zlvRG8+goE4mJUf3Pv/7HwJgo+QMfT5MgiSEIgUr+IqIR7hkrJoVA0wt?=
 =?us-ascii?Q?AawlFG3mAYfR1qb0UOvJlFlRK36NYv2xvHGaByqrsLYZVBX7bYz1mipurKmd?=
 =?us-ascii?Q?7RZ7+Xq3udz2aGO5MvT+vR2OEQkHx3LUygPoGbIDvBzMsHHjl5fsAP6UOoWz?=
 =?us-ascii?Q?P/7Y9VK2X9XUt29+D4KAGgbcZ9fc8S8lUytIbheTVJcFRCXc/cbR0IzoMB34?=
 =?us-ascii?Q?dUyyiDliPKUtoT1/03vg08ORUFpatR6beuU9IXyJOuMg3273j6AyX64GUW/N?=
 =?us-ascii?Q?twF2qPNBGAD7vIcanq3nzhvjinBnsA8HOOrmb8YL4nU1rH9uPYjuFloGE5Ag?=
 =?us-ascii?Q?ue4bdv7QMi1Po/DP9fl6gNrgSnkqwYlf3G+Fgbx6TN8NzTez4C++ZWxHdQIC?=
 =?us-ascii?Q?onqPGVHO/vTCrstpVueBhzi42vcqFJd2MsZ+wuNRhGjApOkdbAACdWT01zuf?=
 =?us-ascii?Q?jkHmXHIKTyspyKqqz2sxZgIbnBCa0gWf7bi1d0iLvEsRiA2RxFr7HWdtgusV?=
 =?us-ascii?Q?RkbnHL0ldz/4mIWlTw/gti2nFc935l+ibB1IfllgVbSAQgIw+hVS2W/j5WGr?=
 =?us-ascii?Q?JfctZ47cXt47AW6bge6l+nQS6NwZlb9yg2WR5tmzFUv0ThTX8xUDyXVW4isf?=
 =?us-ascii?Q?qAmQLhDLH9AiJX6/rHQkta4bL1vPXWvDElo4QkLuZSH1Pn5plsyKquJcUbQ5?=
 =?us-ascii?Q?V0tdznt9aW7waldx658+T4ihlEHCU2M4+aYFNSJP1EFppnDJfLFY7m6YOwSP?=
 =?us-ascii?Q?//X0IAhZQEI4XxIurgra+nAi6GU9pFNIA7dGJArHp3aQ3MIsy36eUS4K51oa?=
 =?us-ascii?Q?JRhdEU3GGj+SKwO3AwWuPvE32swzoQxSweeFKUMTrV9+Rmdzsy1QZVpOh+Yq?=
 =?us-ascii?Q?U+ln9B3SqMg4Y51T1+FFTaEp?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0dace5-196d-4405-74c4-08d8e201b5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:13:44.4753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXn8+bQW6yEb1KbHAQ6PCbDYGLNBOW4FbpHtAIZ8LnWz9lIxWcox+Z3S1cTqpLGdfGgaZ0jAnrKvdS/R5b/RM8bLkBSKEw78Gxh0EF0INy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_071351_103233_ADB499C4 
X-CRM114-Status: UNSURE (   9.92  )
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

On 3/5/21 16:36, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
>
> None of these are critical for "nvme discover" or "nvme connect-all".
> Still, silencing valgrind's error messages by fixing them gives some
> peace of mind, and a longer-running program like the forthcomint
> nvme monitor, leak checks are more important.
>
> Use the previously introduced cleanup macros for this purpose.
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
