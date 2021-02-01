Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C5C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 23:56:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EDE60235
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 23:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EDE60235
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/vJo6gKM4ybUM23VtXz2j/iJ0Qbe/4ExtMogCzPLzCo=; b=fxpxNr4CgYq1Z7bjWOrIudSU9
	49G8phFHLfcQno/i6KttweKe4/JbYqVfdVZe6NGUW+/VG2xUJkmwmb4gOlwKX6KaCJPFT99DjkBOd
	wqkZdakf6cObeUeMQ9CVyIQSnSQTARgSO0nouLRwlrUEX5a1g7U8VLD7WoGimGFyY26pDv5xk2PZv
	MAgMHbAFrtoO8HmTq2PDKKk6ZZokJsnrhGC2l6kdSWmrPTEgvNh0mp/whkq+RUMuhwOu/1HpOhBiy
	6CDplVBZexOoKamRyKLfIFsjN7JeH2lwjlYdlYwx+JVlbKtO/C8mV8pD0johmDPfd2+95D5fVb7Tk
	Np+1cuagg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6j3F-0003hS-1x; Mon, 01 Feb 2021 23:56:13 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6j3A-0003gp-R4
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 23:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612223768; x=1643759768;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BjF5fHz4UOiwcRqxeEc8Hn1BXh8/4AV6blO3dZj4E0A=;
 b=WQQ7b6ETJwKnTHvbdY+oCAOernje/nobVSj5+c9f7mXL8FPEuRZYV2pr
 8o6QyA+dvDNiw3gCDAsumQEQj7onbv2RsrE1cIS96xjQ/W0QyiRAvOrvh
 vlGzzIIABKUgrQ6qWjawfJ/7Bf7P3aLs+TQONNBA9qcuVu7fJ0l7/fbUR
 Tf8IflU1MewmUDxEZ7SuSWhA8zcbs5krSTKakM2iXKXL+n2sa7snHtjVz
 0U4uegbx7nbqAq1cZBWmyOZFZkDv214HS9y77dOuDBOrpIEAgQBQTE5YP
 nc9enWPbRcp1NyNtwyzEu4VZbeAVCIdsQqnmIRvRMtzrjWw+y0+vkfHhJ g==;
IronPort-SDR: mzdzYih21wPX3jsRuCNvwUOD1QGRaXU5osdPhzqTt4o4pz9WEVQK57lFAfG2gGDAyahfh3gMQ3
 6xifhV5LjXCwfsu+FaDJYbZ0DWcf/R5MKOFuX8WySPjuSCBd2R5W8aXd4buk6bpLLcbROefyz9
 fuhGNZjbmi0+r4kYHgtK+vstn4qTzDtwFUfkfrL0aLbzeqSblO8KXU7Dc1Qd7gytP8Ocgkx4Y5
 ylmogBWpe1ISo3KcRrQHeJJcmISp1HFTrsb/HD/XxJtfx2lHxHYB2LBRVr53v+0K9fplIYrGlT
 /5w=
X-IronPort-AV: E=Sophos;i="5.79,393,1602518400"; d="scan'208";a="163310201"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 07:56:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYNx9IPf9YfWUOtWlZT0wCh8LlsZ8KiiUbx/Fm56ctwmIKsgw2ELTUs/pIUdqJyQCNgrPf8EgkxcKwee+olIgLnG3vqBOfymVWkXkY2QrITDLCoxWyt1N+O8dbUG8kQghG+6DVrjUhp8E79bFlGPyO4B3p54GXR6tDylclEWdnY2OObxIaAJyemPteWC2m2GBd9p93JyW8RH5iV7fQZePPLw+z0I4tacKFGgGEL1+hcbDnqv5r6gUu9BaJj0v/67ADjYDDmdD0gjsOQIYX9r+u+qotgutpjHeZ94lmN4dX7tlqgwJn2Tlz/DtplnTbnmb4jK8xhXJfMyByNDAg9SYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWOXyELejmhT1uERN3OD4IKZ7+Hy3yoPYlDa6nt8dTU=;
 b=c8CxIjqAZQEVyafqF1lh6+Mx4QT23xx38FEYyHB8fkTELUHY5in4VOL/M0cnG+npyfDekorsam2RNUURD89taPOK53h1RJ8du3hTgQdLWNnsm2kmTp/HKHtT4Avtlk37pCVifzgQlsSsyL9hSyC4d5XLUKtGIPyIe0oE86JJ2UWQkMt6jF0ET0TcvMIuzQLYdZbh2BxqXqoZ8BMuL1BP4MrhfnHGDQ5UuktNkjmrnpTFpY637KVU/hQ2Z+Je3aF/7sfgMihChFqXb+Xitk7P16XFo5nCWWZTp0s7XGJPYWdBgQdKfeRxfP0YXDY5sEXFDoE+zVv+B+0oJaBCLtjlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWOXyELejmhT1uERN3OD4IKZ7+Hy3yoPYlDa6nt8dTU=;
 b=frx/1uIYrmSMGlFoB2FbC0NacSy0eIKwj+23CTXIqK83RQZC4s1d3XEnW+KjFSJyyxuEUCAlPb/AJD4VV3GEti/yArz5GFnH/GIxKpNRFSv0STK/tHuzFJMog/+ilhv7GnRhF1f9MGmTZ7rKy68vGQBT0xFAdpNWJH3Zrk5cvrY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6104.namprd04.prod.outlook.com (2603:10b6:a03:eb::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 23:56:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 23:56:03 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Thread-Topic: [PATCH] nvme: avoid "(efault)" from nvme_sysfs_show_subsysnqn()
Thread-Index: AQHW+OtzJ6xp3rhHikm7G/6HyMdCEA==
Date: Mon, 1 Feb 2021 23:56:03 +0000
Message-ID: <BYAPR04MB4965FA3C4ADF1E74056D5FC686B69@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210201223713.15243-1-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 344f38d6-3cef-456f-0eeb-08d8c70ceeeb
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-microsoft-antispam-prvs: <BYAPR04MB6104783F01F5050EEB2BB0CC86B69@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WagbwcbUoWL3RZkBl0gbJMH3H/6Q7E7OdKbEbW6ocJqHYNofgfGEp0bgTdwJD4YiLRY1Iiy2YTqNffXYR/OFTQARoQgJ+R13QnpWIFk89/mqYM9Zb8JU9/QWv/weHPCqMv+C/E4ljHzOghjJfyjsBOrkJybRo8usa6K2UrhkSqxQlyeGdND5XliFnZTsCeYXZcXVhFkpZxjWtXPAHSH8+TqoRT7sSl1kwFDb0vfOsVVv1tXmzS4aqAgC3rmgGTsV2M1gq4OVfsNmzlq6W5/O9NE2ONrOkFXelToJfPhzLMqmTCWC7qv0HvkzofnmQ53Kr84NhZXCLvRztcftQHr0jq76h/NoXDkLQiTXFwvo+QAEmms8fZGU8vWPUfmfY3mhzGrVZZNBdG5NjUhNAOkyxBxbKmotJ9Mx1u/pgkk0rrwx9xU9SrPSv9AFGs8YqFtkKzbnXC/1Xk3qp7Jc4A8HQQVGt9Gh7c9140B0YeoSNZemo/zbPwWcbkeHz5GHgN841iqt45EFk56hE/qiu02EOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(26005)(52536014)(53546011)(4326008)(7696005)(6506007)(71200400001)(2906002)(5660300002)(186003)(8936002)(478600001)(64756008)(4744005)(76116006)(66476007)(66556008)(8676002)(66446008)(66946007)(110136005)(316002)(54906003)(55016002)(86362001)(33656002)(91956017)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+02b14S1LuUHpOXY72tIt76bo+xTe1n24C412Ul+UECkWBtWxlDmF6UTI6ES?=
 =?us-ascii?Q?0ARnTlbyZW6DdKkgqgwJWTdAKvgBegHKt86WT2vHHOTHnYnecszjDHFAtv4V?=
 =?us-ascii?Q?4vbZoabQRT+4yII91UhK0PB2CGO/JBthDxSuFDwL1NQt9ETRqNgaV0VBo1Dd?=
 =?us-ascii?Q?m82sDbBYI2ZL7mbM3lrfBpfOVFnkXuZxaM1B0aKTeg7apcJz1QeHIDJTgH/A?=
 =?us-ascii?Q?Y9sVzMi7N1L3gTiGEqm8WUwFU9o9PTdpnhbdFyMtNasiAuKj7MCsSFmHvkJP?=
 =?us-ascii?Q?ozctnLqrS3gl1f18a/Dn8ON+w+VZh4cPHj/hUdGxCqN5cWuFwtp4mf6wZOJ4?=
 =?us-ascii?Q?TA30v0s48+iNnY9fhDSbnucUxE5Ma/7XOFDo7tTQgT6NQMgvK1z1BArQ+HT3?=
 =?us-ascii?Q?yXXgdvMUGSB1To0miF5F+3zp49FSOZ0qx3+u+Mi/AopZYo01Ti+AdrGD8eyZ?=
 =?us-ascii?Q?2JGeCF2/x9UyifGlCqav2bzXZ3MkqorA0kaRLrI/gETUe4O/GzpmtQNrZyJC?=
 =?us-ascii?Q?HnItzsHCg5BR4IQGhTds251jqfwNRLxog1H3hf6i6RJ3iRYQqiSCRR4ChbiD?=
 =?us-ascii?Q?55cjZ8x5O6TsHHdzvf6k+JJscLdS0LaGkzkFueGl74QbcLbB5u2SKBoii3hj?=
 =?us-ascii?Q?ZCQOo/NoHNwxJ9PuNu5dnNtaOCnM27+W00K6NV0m+lssyv+IiZ5JzocUap8v?=
 =?us-ascii?Q?m0v/5/cKBFc5mNJchnkBnvAlz0cRPwXTItjedfdflSD28/XFtzue1h+i2xzw?=
 =?us-ascii?Q?kg1/myydnhO49/bJaIQJrNYiAUlFhZ19tEkwCoABEfUlUGkp7aM/wGo+gZa5?=
 =?us-ascii?Q?cIuX9oS9K0FM24oj3XEo4r00U6GjE+4HGHIVGRjUaK7LZr7qZsaBj4u8aAtB?=
 =?us-ascii?Q?HyKFNYSyDgJCgCyY1AEcpCrD8uXTi3VDIqOA82r4CCae3JKpVn1bUMiCLrAE?=
 =?us-ascii?Q?AAC8ynytT1U73nR4sTKvBiP/rLvEra/Zf1p+j4Y3xUZkLnfXlxFzXnKNEk76?=
 =?us-ascii?Q?GM1n02Jt9QKqU4o9w1Iu7fheJCGGo5Jjng/1fJOSWyw9D22WefYRQ706xL09?=
 =?us-ascii?Q?NUaitsNqao0UsE4aApLcYQKkVyW6Mw=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344f38d6-3cef-456f-0eeb-08d8c70ceeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 23:56:03.3513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rx2/3OV3VtlIicmE1jaqf+n7EmLCr0I+qf1vUlyJDXbNW3XbRktIXattvv03HFVUkTr3jnkcIpZ4msa4pLijv1P+tQcTI4EyXeqdLcxDkjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_185609_294088_5EB2151B 
X-CRM114-Status: GOOD (  12.22  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/1/21 14:41, mwilck@suse.com wrote:
> -	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subsys->subnqn);
> +	if (ctrl->subsys)
> +		subsysnqn = ctrl->subsys->subnqn;
> +	else if (ctrl->opts && ctrl->opts->subsysnqn)
> +		subsysnqn = ctrl->opts->subsysnqn;
> +	else
> +		subsysnqn = "unknown";
Just initialize the subsysnqnq to unknown string at the time of declaration.

Also, can you please add a testcase for this bug in blktests to make
sure this
behavior will not repeat  ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
