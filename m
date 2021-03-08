Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86245C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:18:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50EB6503E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50EB6503E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=8HD4YmdLg7urH2E0SDiS9XuGQ2GEGiUeoiS2ikpFqpw=; b=oVzqX+uwpmhcY6LMXkwemnwzL
	bwYf2pwb5g9XZuIULMka4CxtPr7rxqVn8g7ttM9L+fiemhMapW4Pxut7jzeZxxc/dZJ18qc6JnQrF
	AOZTojE1Ujkjtc10IMbtWykxtz7GmRwAkWbKcieESg6PrMAWlnFZp3g5uOqn2QWE9blkRzKmAZz4h
	pS3v8+PW8w16HlTC7u/VVd7K4lHuSeCJNP6QKEOIz8rLsrsuYCsLK2cqo0mm5spDsgbD1gzTuyG+z
	rAuK6vhd0r3ElpxFtlA2kmARUXQwCHBWUhyzxYqzuB+P8RHXQov741vLANHnPuWBBVP45rPhBdnNw
	BkrtG5Qeg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJA9G-00Fgjf-F6; Mon, 08 Mar 2021 07:17:50 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJA4v-00FfLw-9H
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 07:13:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615187601; x=1646723601;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=+aFPztLy7ItjQdm/GvXm9dS7pvEaOTyWMBl9frC3EM4=;
 b=OHivf8K9ZZJre5sFB9enLBZuDuVfJ7tXTm9l35a1HCzvCq/m1i0Enknd
 UkYOU6jKSsUUt2hQR/hI7h0scdr02RwjHm3n7C2W9LLdWgvv2oYCHpwmm
 kO04JDlGxq9WUhyE3TuCM/Gj0u8YJ0mgN20ZzhjISoOtolzydgZXg51qX
 fwbtz8l7mQMa+yOLDgxQO4l+40pBONhWHc9xCAo58KvDU03Aoq8LEiTB+
 KCrPiBAtOvcDXmIyMgv41hNVEAA+qq2D9egCLOSkzfxzQJTD4KVZzXGsn
 EhJl4L6+JFtzDn9EeJYI+hmlogJfh7PvpWvtEiTjpyePCAhrPFyaQNWSN Q==;
IronPort-SDR: 7PbCdKf2NpbZcZFpJq2FnNvaTZqv+ZGWGNg9yMCAP706mszieRSU9oZl0+CnsVWoCR18gs1G9W
 RGWLFPMLF6rSlaU60xcsH2ToHaOKw3h+2PGOs/ON1HBrsnHvakxDw4l3HNf2+lOyCJEcmS0hyF
 2L4IxB7wacd47vlQG25dsWlCfRoV8LFCapg/oUzcNwADysN54uMwLimFpAc+7r49WGO5ty4WJI
 81sFs0ZPqgtVzUWw4sTZega1uGJr+Pl05vsGIFcXsu8Jg6fOaLrXAY/X0lCaTMcxtQ21OTdY4N
 eOw=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; d="scan'208";a="272252004"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 15:13:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgoNmpDVpQ7gsVHWfMZgydP/q0zpsQ2CXsbVMN744Wmfor09+wh9Q7EwSy1/sxrc5ZChm18qG8bbRC7pjm02hKtYX8Q5MfDnhvGiqsKL+gSUdqr86Mo4ElMzA/0JdPyQ+0U2Iyih6m9r5RCF8BAGQSpyS5kplDSDEi0vnJ9Nt7tbEFc3N14NInoDQaSDkQSWS+Ucgqiy0L7W0n9yTm3a1mrlQBOF9/qh/dbp712feFdRhpFI2jr7LfS1Sy5a5hCpoWA/jOsUDMq2A6pPSbVs/nOCqiCrWYmHzEVXHDa8Io5yH9jRoKWYlNwZwod4k272KvCllQyOU517MAhnrlq4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aFPztLy7ItjQdm/GvXm9dS7pvEaOTyWMBl9frC3EM4=;
 b=J7Zypb2AJDcuAWPJHLBeCff4usLTGVEqhxYLj44ugpi3xSt/d4xNIZEZPuNnhAEa5hJrw9I8zookB6LI6yzVQWM5Vo5bfSPmA96uv0JFH6Yza/tjLlEmVcZI9Gaj+zilOyc/hVZShFjzXJkZS1YcQ2leRPunA8cTYHjee+rKVHnlc9tOPGeKbd6faJKj0Nlxg3jE9jBiqm8kfwwFQs4va19SwdPNNGPnRZOG4+PyWhxI/3tolr5ZAbrJBiG88JB7AIcb5uqOCKXjIBqM8mW3fr7Lt1cJZN7hzw9T7Ke6Em2nQQH9xZdz/O28fS0dfqIr3rcu91nS4/318Csytncndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aFPztLy7ItjQdm/GvXm9dS7pvEaOTyWMBl9frC3EM4=;
 b=d8kglTrsN6/Om0wyY3B8o5AMB86aO3eptepIu68OoISAMg8+RfNwmK03Swd6w86QGdm1HVRGEtIScgLWBCnOqKbEV+dfmghQSLg4OXO3lua990dEEiWuThQkuokckYN3f3gn+NuNZ6zaY7VrAlqLhsyqYqi4DoBTnEXSvB81UqI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6023.namprd04.prod.outlook.com (2603:10b6:a03:e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 07:13:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:13:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Enzo
 Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 07/10] nvme: convert some function arguments from "char *"
 to "const char *"
Thread-Topic: [PATCH 07/10] nvme: convert some function arguments from "char
 *" to "const char *"
Thread-Index: AQHXEiDLVxpo7BqTEEKyc1ESizKlUg==
Date: Mon, 8 Mar 2021 07:13:17 +0000
Message-ID: <BYAPR04MB4965AB2E1BDE268637EAC46186939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-8-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 819fe762-2eca-449b-8a7f-08d8e201a583
x-ms-traffictypediagnostic: BYAPR04MB6023:
x-microsoft-antispam-prvs: <BYAPR04MB6023EB34BD09DA16E730EE7B86939@BYAPR04MB6023.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrB7QHYIdImgYNJJZhsM5vAYP8Mc0Sa5Zy/CTokwfTnwQq+wqWYeLv0do4TgIY1hVqIQQwAV133PHnL7vw/zsYQ1i62nQoDIIWrJN2LDiWlpZ+TfFJzY5XTZtSEYSiu0vGxAZ9CxOhexmdBSV3s5s7OgoidKUhA1zGlbFYKFkV6zvY5W3IgeVkJdWwSveEub3hiYQAn3vxuqRVEYn5FRGUAJ8YdHq3ZaXMbNZHN2QRcDDxkWZ82Kjmhyf7Hq5pGp8lVf9Iqeyh/ZpbO8V9ZR/vudB1I5DgcD9Xi00tShAYHo5VdB2p1vnvxw0Zsd4RpXTtD/IH9P0MyTKXjr4/J4FoaJDYD+WGCesWxLPDkgK5H2eGs0DWHoFDqsU7G5BbufSf0DHfZJVRvHGl2bqmS3mG8jzJQ0KllrMK2KR20TcahHqRZv5qFJdmqWl6yQaY+/aREOlO2MInfJmxjRJgy8KSrAEBqSFNejNKvterRIhPrb7WwmEZ9ml4FEmuAtA8gEFsNU9NCod4fgoCPVVBuIsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(110136005)(76116006)(54906003)(86362001)(66556008)(5660300002)(66946007)(52536014)(558084003)(8676002)(66476007)(66446008)(71200400001)(64756008)(8936002)(55016002)(26005)(6506007)(316002)(4326008)(53546011)(478600001)(186003)(9686003)(7696005)(2906002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?G5+dtMzP4ruCD70GTL9AWNuSYDwjk5O0OIN6Q+Sy8T9hum1aVttLhfV5sXzC?=
 =?us-ascii?Q?ZJbwuucvXVMb4RMBjfEXNl+FJBMtWqla9+AyWpqS4SAZqCHaKY3jrE13Qw+b?=
 =?us-ascii?Q?SXKLpw+Xda34RF7WGs7mWiIG9tw7D0eW9q6JeBV/ZJ9ZpzANsTFgV2ks5hs/?=
 =?us-ascii?Q?kNOtvS3n4g/+aVSMM0oUXpOamAfAltsdS/iTkf/maeGAD/OT0dBEn4OzdArE?=
 =?us-ascii?Q?8Iv2RCDmgbn0NyPvvFBj/eHxWIo877xybJy+MdRKxBaLNSWd54/PwhuyWvRb?=
 =?us-ascii?Q?rC/D6/be2A3C5a/s+xQmLgvm5iMKWAa2ckTlgvYYiUj31CwfQLIi6nfV2CMR?=
 =?us-ascii?Q?SfKnsv9gL2zy9vln8hYdJCqlY6zQYKyhn81XDX0ZM7EiZVNVJnnxk0qHbKSg?=
 =?us-ascii?Q?oZ0eqsG4WZGHL0EsslK7I8/E4zns4CFFwcpCu7S5fx9DByi0VezwuvJg7iOL?=
 =?us-ascii?Q?YCAyYyGvPHa69V5oc8JZIsnM/j1zlORerjsuh+qMYejnnhDpOsPlyipS3rQH?=
 =?us-ascii?Q?ql6QKnE6HCJVz14aSGepGLWNZ+2Fz7FcYTKJDPwgEIiYBSWpuH46pWx3ubrw?=
 =?us-ascii?Q?doseJxe3hJYS+o/W/AE/deDybhgsmnWdYB2loJKxpV35F7s2U3KSIpdTVWyt?=
 =?us-ascii?Q?bF+NKX/QRsR/7eP+dZsGrnaGZllmvut8cpUzvKEhj+uQowrtI70/qjH2hYTQ?=
 =?us-ascii?Q?NqozHFPCYXH/+AkWXst9YMsED6xEynTG5epcVLwKeJpsKgkU48Xs7GspRsGB?=
 =?us-ascii?Q?HxoX04env1ZWKlSXupKUCH/eFfkbWcj8KiJe/G9dTr2L21SdAavAd0Tu/p77?=
 =?us-ascii?Q?FS8QTYi9Slenwj/jgbaQw76HtmrL5AflwkM59V3LLgjWZrTXDb6s90+fIGzC?=
 =?us-ascii?Q?6dkGmaEzIWxY2KPhUD7BFa6Vz9xKkGpikBlCqHZXEHW6qPgC4Uxeb8PbtJm8?=
 =?us-ascii?Q?LEh64ytvw6UQSQMEERveP8GrHo6lItd0mO5UPC0q/+vXTH0Wz7qNmWQs0XTk?=
 =?us-ascii?Q?r5wvZZR/buhNNzc8srFlmJPBGjS0fqaineHyO87xymsglmbzojcB4ss07Bzp?=
 =?us-ascii?Q?Cwy01JAbGeB26xns1gnhgDU4fki40aWSanNxek9JWmQ8OhOWXxinkNpfKqcp?=
 =?us-ascii?Q?NL0eL1mkTyGEV8sUIdF5datPM9gx9j+Dso9iF5I3PIk7Ui4mE5lXXtbYrKMz?=
 =?us-ascii?Q?o5cydz7HifbKN9c3bKfu3xgRKuGT7DbpiKZaLd7OvONb5CrPyBO5oMk0YI/A?=
 =?us-ascii?Q?KbhOHIxFdXAls+MM/zXTXZZW7E3lGiUGKFlJ7OM182K182CA+tarC/izpv3E?=
 =?us-ascii?Q?pBMUh/MGk7U/l8m0B7Iof0os?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819fe762-2eca-449b-8a7f-08d8e201a583
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:13:17.1421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xF8UJlEv3h11JENEnYmowhWJEnJRCYwpeCW0b0pivECSk6dCHhTLPLJ5dTkIFdNaghbSesrOvtddg5SnAeMQXh3gHT3CobnAkzuOGhGt6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_071323_128170_47779CC6 
X-CRM114-Status: UNSURE (   8.71  )
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
> Make some function arguments "const char *" where possible. This
> is generally desirable and allows passing string constants to these
> function.
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
