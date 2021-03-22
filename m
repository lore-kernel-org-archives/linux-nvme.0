Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD16AC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:11:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EB461992
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EB461992
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=L2alnreFPhsg8ipu+5kmfoTs/kreWbh+7aqCroJ/PaY=; b=KsO4ftU5jlWP+xbUOAum6i+9O
	KlYuEJ4QrN+UjxFSCWgnJSpi9v9OZoWF8p+qx4L7JOipnn0U1Yi0xI7E4U76FEaB6sdQmj9jC/RLP
	kG2wD7EyD/qHkfirr5MjDCtLvPoUBJyByeLo8gyEfhgKw4zDbkQMKUKPyeKkB+Psv7n4qTh4VNb0O
	6ss7D/55kFqJcpTYCTFjM2RAxEakGPuB/bMW4GrnCGTsS5zVU/+qtMhziHQV39bLwhRl/eFuVvly/
	+ifYiMypubRve3dY1cfYUH9D/WGplia3NdobfJoa8nufOg57FtxKcyo1jJ9pCA9SrUusBBJOxt1OW
	KCLhkpPWA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOPxI-00CPIN-22; Mon, 22 Mar 2021 19:11:12 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOPxD-00CPHy-TT
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 19:11:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616440266; x=1647976266;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Ep49O808Vo8iD90vIQggcOpjMs3nSMeGv/NVzQ5JShU=;
 b=P1GtG9YsNubaBltGAUljnuZuBuD6p+deFASZEx3yjfdxHHsY0SwGCBYN
 S1zZSoQc2tYGXdqoYGvUb8XAt/RXyHmUNmz6TdUrcMngVkzC5S8KPRJXK
 HID3PktF40b+L+UQi82emMrGlczWFjxH2TwW5nRff6K8UajBNCLF61EfW
 J7rW5RYAkit6YJoewuOx7MuDzDSaHsIQg7RgFd3bl60hL6AUG42Nbr6NN
 X/MOiXbDNNkP6JUjeQIUXXz0aKQBt3lfgTVnl171EjS8s+0QltuMcfNlo
 deSwkPxxL9xDwWrfwVaTNJCV5Bjva6g0pVh82i1DWkdv/xRQ4NngcI5Qa A==;
IronPort-SDR: gGPWZ0ypzB6JGaP744ldMmfUB1SnHgLngxggzGjEdJCWQXEoJ2rN9HfE4OeOcuTDgmKTZLKXMr
 +6oE7HtmHJoPJlVJu9z+JyUgldOr+ZEE5KTu9yvrtpI/bKaylRgGH7inyGKzdqK7CJjhxtoW9/
 FGhn0PZT7GDsDJio8bB1WabppG0NzGw6NzlHnQ+8kmx3vBTuRMQ4BkrX1asbSR7W6mQlUSRr28
 7pRCA4Grxw1nk1rgLE7Ru6hOLbb7PVYXuzwqgn1y5oPP4LIzmmwGE/Y0/5mtZX/Q73KDXWLvpP
 GM4=
X-IronPort-AV: E=Sophos;i="5.81,269,1610380800"; d="scan'208";a="162725798"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
 by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 03:11:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj/zdqcpAVBmSAQSdlgM7f/7BPuv+jlsq60RA8KI/hcJyjo9cgx4OoreIlCbL8vqdVmM3V2J9bT3G9LE9XkbCbz5NDrHmGivSF9OLFZInHUJNtwAZPUNr9Sliu5klcPuIrPDobVb5qilEOjweNRpvXm2S7CIPbQlkP3dR3SYzGaemw42jY1/svnYKSR0wuH7utsWPIap4ZbdEIyRaykDLsEjjrT/UE0HLJkPqI2pA5EwjpAU5xI4wjHzDhhZUJfFxsjljxiSxXNPEEnXir9kLXQU7O49zxoAiZxTAUo+ugLRvd6LYezCjJSSob9ZrIL/9C6YK8Kvni96XRzm2Zm13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFk0jGfwai6vdUM79wN5F42TBsHozMVSq7EdkokJqnQ=;
 b=G3sova6x1a7TaEu5ALGr3gDahLrTg9TvvrYEQD4axDbmSqndPYBNm5XA701216gzKgU1v7hgiFI5C7HxTyrNkvYKuTKyHysTuI26U6OCiis2DSSn7orP9wB+YCn+IvxPGjglVy009WU8Hf/Ln5iYvcHkTxbUM5la19P3viLnKzSmDhLBEyuNbCPolUIjJYmAHqA9vpZ4D0g1+QUfRpHt7R1NMEzsHyijf0oWMHLOhcO6/UZR1ay/TYbaAS/FDPK4PKaL+gsXlYoSbHBcSxq2vNMBcX4hrVxf1s/8JaOWZa1Q+GLBKi+E28frdEvk8PvQIu5FLTAlCVMon6BjSUKnvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFk0jGfwai6vdUM79wN5F42TBsHozMVSq7EdkokJqnQ=;
 b=grOUiLXnERjw97KE3COPXIsWmpsbMHXqdLYc2ufoaX4qbfXqSq1UqQO8fS0apQ5RdF9AbOFcH8MBi7r69EVaCHmWT1IkWx4F9tz6szjlAWx+ULQTNcAGCBhymXt0HMecJqLb5CsyoGtRctXbvS6M0qP3RzE9m6kY7sQEna4y3bc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4869.namprd04.prod.outlook.com (2603:10b6:a03:41::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 19:11:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 19:11:04 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "amit.engel@dell.com" <amit.engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
CC: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Index: AQHXH06tqYHC8w0QLUOi6S5SvvpPqg==
Date: Mon, 22 Mar 2021 19:11:04 +0000
Message-ID: <BYAPR04MB49659DE810B6258EF8FE0E5F86659@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210322185945.10364-1-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3967831-cd10-40dd-6524-08d8ed663d39
x-ms-traffictypediagnostic: BYAPR04MB4869:
x-microsoft-antispam-prvs: <BYAPR04MB4869DC9B885EDB246D2BF19186659@BYAPR04MB4869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5p3/WlQUdN7Lt9VMOJ/gaS4BamefH5uj6983vf8O+dgZcmH5TwNcbVRLk2IpVv/9GDwfG2k0Vns8P3fwyXZ2/Qs/mNCS714y3TmzWl+8dFi29cPRScPsji57tDpIIgSi9Yzm73q5sxW+fjLRj77q2gKFH4ijNG+StUQNsKu0ujo/HqktnlXVP4S9Z77YdtgWWXaENSraZQ+0cskYlRwHUMRxlnvnK3vpPvuU2Yr4MLQ+WkmI8U3k8WVnbcb3/SC/UYsZ8ye90bWzKxQFI5ONAPDfNth2CdTmjF61ZwoP0rJN4Bus+BFi06OZg2uVNeS5ou16eKwJxZ+ps+QCF7QxFbVIbZcZB+7tMXpoPQjqt51BbOIob9q2o49Cc65BMbz5KZXfjjdN2NvL5uKueIhdfrbsvsIewTXm7EVi+AyzpULbKy37MuYE2RlTxpJ+FKk8wlps+4JZy2LQEBYkmNA4MgKIVTdKs3KRjsHF34H3StIHgzWV+Jk3JNHpMZCqeejTh5ZomQhHaSM4VETrpiafdYRDhHy1CsYxhELUrMY7L90/syaqkn6L6RfMgPCDzeigjWUvrGUmLXIWj27MDIcf8DHkIEdwjilPvcZ9SAwBKbhsIvwBKitoSm8OAroeLWDgM6M0k+VHhhpqrFh197FAghmkuN4DHtpJMoKYqea9unU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(71200400001)(8676002)(8936002)(186003)(110136005)(86362001)(478600001)(33656002)(55016002)(66946007)(26005)(52536014)(66446008)(558084003)(2906002)(66556008)(66476007)(64756008)(316002)(5660300002)(76116006)(91956017)(4326008)(7696005)(53546011)(83380400001)(9686003)(38100700001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?d/3svHSJlurRGoj5sqbqTFty0pgtDA2hrtw4TpBkyxTOxt7AI4Ixx7BolZY4?=
 =?us-ascii?Q?CLblkFox5Z4NtdiuRpvNICAjAl2kgoXa+P6diA6Z7w7jPsmyLsji0vWhzc+9?=
 =?us-ascii?Q?4jnxnpwHCbUhsrAT/YTcE/Q0gmdflyOmpNgi38DqEIvThORNLLKmw1nWIUQA?=
 =?us-ascii?Q?0xev7WPcnibxJbgGQSgtU/CzIImi9OdsgnlUhdiKgqLoepj3qkkt+Q1Rtcuv?=
 =?us-ascii?Q?F0rKmUq5urNRDJHZoqn8h9/cqRCxGVujumQa+RZ2wQhc6lLP7etX+M+Li7gX?=
 =?us-ascii?Q?UlrjJrfZwDSKv/QPwhjQOPaq3C7jLIGLDEHN/gC9pdNcnylugHOwIfBBXN5b?=
 =?us-ascii?Q?LedFNtsRldBG3/Ou5Xf6b6C9CDCo8v+OwXp7ZkI3fyUZKrZOzYYCfOQBqt6i?=
 =?us-ascii?Q?cNOXpfYTk/hjhH9I80hCRuCX4nPVAMO2RUoYOJEtBfzSk1kqB4POja41XzDe?=
 =?us-ascii?Q?JnKGIcp3K/CKxQvd7vN2zul0EQNlfRfrjnj52N+6c9KPnGsPOKcj1vj020v9?=
 =?us-ascii?Q?8pyo+Ml5MB3WhpPYsRY9CVWHCRkgP6YCpxD9hKLSE0mxX70BK2MjnPm68MTh?=
 =?us-ascii?Q?GAl/OOIUEInzT8CO7kQhb4rmYjnhjxjoYfKMlYoeVnVLiZRaFGJ/YPVz7mG/?=
 =?us-ascii?Q?7ezY/+BciNrgfSshrr7nr8fnziPWOj00tcY/4IWtRCF7us087u3ZigzClmYK?=
 =?us-ascii?Q?pSgD481lrqUx7p4qaTzXnGkwZQHruJjRy0y5/U8EpTG6CKXIwTVyp3C4II4t?=
 =?us-ascii?Q?abYLDjjJATBz+i+NUEHNSnVnu+OcMzT3R8rqr0A28w+yfpjpvVl/aVlK8Qtp?=
 =?us-ascii?Q?5fTf+eVl7d+D0UXBCeRKCn0HjWkaQ8TT7hvMjDvYT4bQJ7CBGAkH3X6qZabu?=
 =?us-ascii?Q?e6DWJCyIy32tLKadvYwd59SObGhBqkGYLCa57v9BlgKxMTIYT9GxJ+/udGZ0?=
 =?us-ascii?Q?0bgziZdN9tHKfzfmzQDxxJ7Zr/RtpczbZaC/Bcy722SsTJgnWEpfesmdHD8Y?=
 =?us-ascii?Q?GY0lrXigjUfszcAxfozpcfckO4OVcPRAPhJG6O1z8/Co8sPIsUcEbQraQbI0?=
 =?us-ascii?Q?BqpgUxp53RyfoCR5sm8WVj5iPgknVUPRKNzbO6tzg4cuos2Ykp7Tma71zZxY?=
 =?us-ascii?Q?tYFPt53zTPPJasOWe1Y8UxKteT3GmVGOP0n91VNcZEP9LZ8GSe2DyIDWNK6t?=
 =?us-ascii?Q?Ao4sYyYxHAJBTMsU9acq93KKqsWbrAcVE01F6mkqFsmtLuz+9DwBlOitIOlW?=
 =?us-ascii?Q?fmldddmfuQqii67jFozrsfK+gNefq320BfOcwgnEuSHa8gQ6ScYUTMIeh/G7?=
 =?us-ascii?Q?fYgtyw73VFJyK3fmtUDNBBHb?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3967831-cd10-40dd-6524-08d8ed663d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 19:11:04.1124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUOV77EZmrPElZWqhkTgVemsZrfI+6m/XP7jbiyw5mrRiagvb0cGwkv+p9vEDp+oo3qGTn9zD0dOPVj1P+E2erj7h6rQPrQhgOozyUesXec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_191108_471530_0DB62C77 
X-CRM114-Status: UNSURE (   9.58  )
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

On 3/22/21 12:08, amit.engel@dell.com wrote:
> +	struct nvmet_fc_hostport *host;
> +
> +	/* tgtport->lock is held by caller */
> +

Please consider adding lockdep instead of comment.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
