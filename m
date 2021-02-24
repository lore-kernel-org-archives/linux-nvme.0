Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F2CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:21:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDBC64ECB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 07:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDBC64ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ZMFAQBici1Yx2MvJuO73Uk/bAI6xX3lCJz1yuMd5TGQ=; b=JzedD/OC8nGhDIOzzEqrtTYly
	wL/x/2XCQDg6EAdnFou3cMclVA3sisVdweDvKLTXtruLD7FGHg7QVAuJPO7hGVLlMIFCvTDyx+URe
	tA2WdITQPKijQy0HYoMT81lKytO8zGLXgUIaj0YZkLx58DIW6VYZkUOqRNWoMgJ2Ay6yf6Uc9PAeP
	gDLa1wO+u+IRvQ9BLdGKm/3lvFhseYi3YfaQaJCcdgBKMMA/u4dgMqxqPpazGakY9LusRXvufP8li
	wx8FarbGaWIMfunGaCIMks1LeobbnrvELqC+tGPzPLnvUtPZc2p5TjOSQwhwnXoMgZ87j3+0Io59o
	CicNRPwyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEoU8-0007Qw-7H; Wed, 24 Feb 2021 07:21:24 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEoU5-0007Ps-9n
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 07:21:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614151281; x=1645687281;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=LhiSZnYWz+oGYQ0WBIovK6rkuYH4gARvX4qMhEhrSxY=;
 b=V9HHltjj+P2iCcLwtxD6OI5tPZ/mV0o1gA7lCBvhNnZ2kQlRIofQeINI
 lRXR4Ejntl3Mi4d3/tXwJsm0aweHji++h+uZb9QKt/5AuMGWnXpSvXiRq
 uuEI6kmSiSVtAypba1VvmhtL4Dohkf1UDGTrVSOzSYqX30/Mno19ay+DD
 jzjh87lV2TdiT7uPYDKqwUuJ1XBMgdKLfv74olVLoYtVIQAvLmcK04zbb
 EnkvKptuPCHMARXh/vpfRoPajyWhHEio90clSeahD2cpOUzWnPCmbedh1
 DANv3zd4d2Nbkh0Xq65EaER9LODRULhYtUlBGfyMqAnmSLae1IgVLcU9N w==;
IronPort-SDR: nw6HObens9T4fNuogdQdrxrylkjaG9Mckr1GpUIBF5IjIv8XzNg9laDxCk5oi4+a00NLzgnRh/
 rA5qw9bpQO7DXfoxMoIihGA+nOfGUU0cGykcA6CEn/JUJOh+IFfLQBvl8DcGL7MgnNff1qg8Vo
 oTV+Drxli9bx9bnULha9QA2eCov75+KKwjuypXhObqD2FrVuhaYdryVUk5AkfcSM9wc3ZbC6E7
 xSFEInDrVB9hSyos4Tyj4ViTA4raZEBfhf69Snt/7F/YfVZwdfhqfGkKOoXVvRGcymzT2JC/0I
 g1s=
X-IronPort-AV: E=Sophos;i="5.81,201,1610380800"; d="scan'208";a="165150990"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
 by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 15:21:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPBhX2/OjX6G39KjQlTS5DN+ggpZK/YQThZKgR19PN21QihLh4zsRL2EvJnjlqzQMNzqD2JzT4LbH0Eo+TjvKZDbdwHKpAZJCg00yEiFiJySCUwsApO8Wzs6JNiSpDwSig8ROUadxPkTJBr/hYgrVwDdHY3R2li94yMTO+MBdWT48xCBOrv0GG+KGAvQlCnNWRlkhLy2UnNO4KkXzjmk2P8nzM7lAnydEFJAheCz8YOVw5L9VLQKeJHZnAx9YVOrGeF0v8IJzQKUugd9DW27H6huvDBoWnZR2U/NXa9wOc5MoRyfmXXbseNE1ijDckVwts+upWPm0KG1WRTH/5C1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQB2DxGJldpLk8Xu4xlafQakqFK/sIH1QDimJDtiiIg=;
 b=SL5YkT39vZ/ETMI3GbY/pyeeYHl0mCknl6BVPxTIGtsyJcibNyu3mXTSchQ6FK2U+6otQ9FJFBQPuCvi/YYMjE6jf4ew74SM5Lwyfz0ZLiW4lE7oYw1yaZJNsb8C/Cijz9SHQ+wzulc06pPqCcpsJJ2guAU3mmxzGG0LIkvf6SfVqoDXsy1ntmei3uB0S4SLl3rhRbcNUE/aiIWcb8NOA1UtYnu7t6GSkJ/fOnXdAF9Jx3f4I9bKEYed1m8xhmbW2NyF/z0XvBxZBdbi5cEJ3o9lTwOw2YWkJTsv5cMLdcUb02Pf4GndkLbjt2aZ1qkNFmon/V/gwg9u0Zhinsvv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQB2DxGJldpLk8Xu4xlafQakqFK/sIH1QDimJDtiiIg=;
 b=mkn3spX5kPwLfdDA4z3kKE/W9u1Dl8T/ttDq3NMexR7PkAIj0V1K7M3q3OkkMWL9yLSKvI63gQ91UwlKYC7224bibA1EG8tOWJttqL5GqN606KF4T6/q5gfyfSiOx1dhpXHQMdx9yFAqVmYu0P2NlTU6J51x459rVskbleBRdXU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5336.namprd04.prod.outlook.com (2603:10b6:a03:c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Wed, 24 Feb
 2021 07:21:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 07:21:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Pascal Terjan <pterjan@google.com>
Subject: Re: [PATCH] nvme: Add quirks for Lexar 256GB SSD
Thread-Topic: [PATCH] nvme: Add quirks for Lexar 256GB SSD
Thread-Index: AQHXCjFgFvV/GtVn6E2nXy/pC91MaA==
Date: Wed, 24 Feb 2021 07:21:17 +0000
Message-ID: <BYAPR04MB4965BFBA4BF10F3468348768869F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210223221046.3367795-1-pterjan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54975eb2-ec6c-4e84-b159-08d8d894c6f6
x-ms-traffictypediagnostic: BYAPR04MB5336:
x-microsoft-antispam-prvs: <BYAPR04MB53365DFB919C6C47A7694A1C869F9@BYAPR04MB5336.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q7PENLbFG/Kb68DHHXHlmDS5pMyc1NB23aaOziYMVaFctPII4/ZjOvKcI/ONlfhHRzG8zIt2T3ib9d5f00fiv/BJPV5e5pmtrh9GcNhZh837m9w+cgo1IVDpTOp4UXEJJ3Ezu4BuG5xfov4Q9AvlQebWCdR4GWKgN1Ew+Y2LAky2//PuVyaB27ovLLmZq32RZtttUCw5nzhog7HnI18c3awU0T2e0KMGbdditSnKcNzKtwN7Tkh6zsMG3conVreIo0+fp8X6SzcJfqS5SbKgJOrwW42k6M1kMTd5kdPziPRrMd5ElkwS6wUWCe6u7q41ZY3GMv/+5grDenp94GprB2JkljPWCer/MW9FSbINMmQg3tMl2dX/FWbXbwBgCaMIZVC52JStqZbfhyAXyWQNc8LUTbvYUdAm01wnXoVvb6GbM1i63xhP2suwUA0Log18felU8fZ2LvrVHOGMJPwVRPkNhbkwL2lTCr+pzUNScga9Qbi1531PpnnZU+A7009s4LEP7a09Xnt0Wxf5TMP3roIJeaGOEmAlcOm+GOr2MpoixhmqgeO4TfP2rfjxZ1nKYtVmdbj52zZvBbMygDYAoZ8Kb5mpn4BNesIB1GhABdM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(5660300002)(71200400001)(8676002)(2906002)(7696005)(52536014)(4326008)(33656002)(9686003)(83380400001)(55016002)(53546011)(66446008)(478600001)(66476007)(66556008)(316002)(76116006)(4744005)(6916009)(8936002)(6506007)(966005)(26005)(86362001)(186003)(64756008)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Fwk2nlWw+hWLtQ2KLIyoM90AWoS+1mfHHG6R1X+d7jyblbS7TjF6NH4srMIv?=
 =?us-ascii?Q?OeTvG0TaLxImD3REki88Q7W545nlqHozsFgYAyUtps0czftQ4/5k0RtNphDt?=
 =?us-ascii?Q?ncUPDUYana+2uhHmWJ/wCbHuclmEuh0HD/XZaoQRZ8KS1KW0uCE95RO9q61m?=
 =?us-ascii?Q?TJDP1SiTPxXM8KuUf2yinbLuIXWUhuyOQlRVIp4AkDK6AZV4EzSrWeE0Z6vW?=
 =?us-ascii?Q?HdS/0TnGiFdHwng7ohi1makqTKX9fWkN5HV6yGzuZx90TB0cqQcaUWHPMNit?=
 =?us-ascii?Q?pM4TzeZ5yYDpF9yoENxbLy8SRdgNIX0yU9xD2XTWWKI0KG39m+Vc2VBJWHQT?=
 =?us-ascii?Q?qeSflwfztPYTA8LtRVYPwXQozJQsbzWP6pO73lGpmok5hoFFIIHi4LfsJKYK?=
 =?us-ascii?Q?uCOfQC+FnV3vRD6Icf0q+9dxeIXNxUSNsW1ZrFPKCFhto7b1D9eZHhzXCqYQ?=
 =?us-ascii?Q?7TF15PLKcsb2wmVVu7ddQMdDzqNnkL/lf4w5LGrzNy87SiPw3mrPwRds25uo?=
 =?us-ascii?Q?uSeZc/IIAjpuWvbqW+U7OvDyrU6hK+Lp3Wu3DQmzmhR7LfQHiDvQpC68wyQt?=
 =?us-ascii?Q?zVuFri7B6GZ2dZGkBi2eXbj9Xa/EE8bd31FzXTBTQfB7yAvxuM6i/nOPtzaT?=
 =?us-ascii?Q?16Oquhyz3F0E2vwhPrkoqev3hJ5o00bbjwuo8DIOkOx7Vhmn5pAzJ9fMuM4T?=
 =?us-ascii?Q?UIZWsAdxIEXYw4kaeHdU61f2kTDYOnD7KMs8IF1SNX9/3na+eZ4Vu6LkgXeJ?=
 =?us-ascii?Q?IZ+tu6XYfieXgiEWydnmHUQgBSF+ePOeyNVqfpAhgLasQxRyHiGjzxtCDpCq?=
 =?us-ascii?Q?js9B5pzOXYpfDPTki97s0ZjPVaVtYirTZCQf2tSUbI27jRXZpCzqMCcF59c8?=
 =?us-ascii?Q?9zbTu7UAbEVDEum7ZcvehZTzjGZUYdrzWCqTrutvi9WIAtS6yw72KQASH3MB?=
 =?us-ascii?Q?NES49yxK93LtD1ngjjUDqaXV6IWfEGqZHSiI8fpooUdkZS/XHGVorgGPsqZ/?=
 =?us-ascii?Q?izTcsnpEQe5h6VCDRHqACWClhci9QZAxim9hH3VrCnRq4Aeu2+PwTf9DOpZ2?=
 =?us-ascii?Q?wl8hpuUQ2wLqCrqOTLgn7+k+SN9/+yxK1vo5J3NvtNDCN0k/GXOEBDKfo2c2?=
 =?us-ascii?Q?GhRW5yhLjrUuxzeua1bUWUvSF6IhFAKfsM1Af7h9luQejVdi0FmjKX/O4G5D?=
 =?us-ascii?Q?JKQ/DaRkt6xpzp5YinAqigWN+41eSBIZod7m1vo5IPpMWuhdIySRGO8Likmq?=
 =?us-ascii?Q?Uuf6DO1jyYULT7X3tzIqdRyXo2VurHArSlR/o2HrixKKYqDEnQOOxAepR56w?=
 =?us-ascii?Q?+xsY9+0xWZrAfuhx6Gbopf25?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54975eb2-ec6c-4e84-b159-08d8d894c6f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 07:21:17.6691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3lSFrhhF4Wjf5uVhfcxMg8k4a0ILYtjc+nZpXZMJZJHylO9rsuHtI833WbIhIZorduqpZP5RHG+eor+jIA6bR/cWDEYBTJZocpMnoAtLmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_022121_547264_5C2E796D 
X-CRM114-Status: GOOD (  12.40  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pascal,

On 2/23/21 14:15, Pascal Terjan wrote:
> Add NVME_QUIRK_NO_NS_DESC_LIST to Lexar 256GB SSD to allow it to
> work again, and add NVME_QUIRK_IGNORE_DEV_SUBNQN to avoid a warning.
>
> [    0.637476] nvme nvme0: missing or invalid SUBNQN field.
> [    0.638399] nvme nvme0: Identify Descriptors failed (16386)
>
> Reported and tested in https://bugs.mageia.org/show_bug.cgi?id=28417
>
> Signed-off-by: Pascal Terjan <pterjan@google.com>

Do we need to add the Tested-by: tag ? if this is tested by other than the
patch author ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
