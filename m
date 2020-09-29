Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4EFC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 22:01:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957802083B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 22:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HbmVcSUv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CmixdGpw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Liy07hVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957802083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cRcLWquZ0FbMFIq6MPp6kiiwZ9HNPP+ONThkfzAUpzU=; b=HbmVcSUvdcEz3+OhbBBSuDWYP
	S9x+uZsMKt1qvV4X/iOFbjM2Z0twPhlS4VM4UwXJ5Vo+Kvcq5jV7h8RPCgUHesJV0JTLuOo1OZBm3
	Mjy38toDlgDqrGO7PH40xVdALPu/2EHL5ZG8pmNUFe9rUFHlQQglnbBvJvmjcUIxyNtSSy6KEhxqR
	0GWYZTxlWLUz+WKInab0SHs8X+JWiqfeYId91Xziz/VoD3xYOiz6HPYTCBAUgOVwto9TpLVQsmaKu
	FSHTAHumX+R8yrIO+75SurvJTZW74cXHPhPj7cgK0pOVj25pO562/ZofYJg0BD1Y6O6HR4yapZiyg
	hQ5C6lk8w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNNgY-0007kI-8w; Tue, 29 Sep 2020 22:01:22 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNNaL-0004Ks-9A
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 21:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601416498; x=1632952498;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=ZmSm1VF/o2c5s0+nGi9PqlXgl3Bp087eYhM72Ip2SwQ=;
 b=CmixdGpw4mmfmvWZ4mOE7TjeaR/2tiCxJZvjCe5SwrUb4EHbeyNE212y
 hXWvE7OvIMq58zfh04EspENutWBbNBUd6Ui1cvclG21hPGBhgrTdrBfDL
 5yV+l6WL+YZHPP497lynaXbZhNhg2PNm8x7ZlbbEICDMcmWU2bgeG8jmC
 lcWUaagCWcgjrQRqSWPLrXwxvi6DHeyf5TiLwSQxZNszmJ04htBO2KTHZ
 mQY+PgK42dqftJoRhTKMy/vdZ/oNQeN0CHxMi4y4HW+TVU0BXNJh8tVUx
 fMhUxzIAY8ReEFlM3DtuqW+YNcx9Llzv0LR6OS95L3et5GcEDZkCmcfnz A==;
IronPort-SDR: 1fNCKtG9LOdH8I2exC0OWpIgJmvf4/fjOlVWTcE7hsexHY00PlVZW0csPJUDEJTr4AG7LqRiJV
 eCkYfj8wnZg+EgJxqLtRHMMNblqbrfIURigQsJSKR1WB9TD/JWdXdFD4GFKBJ8chgtKxBmq0uW
 M8Wd8lphZ9E0fOEb9y68Kascx5qt8b3lz8+KSimrzjpHTOcbzSmSN2wjz/uKudbfceNG/3jdln
 bz1Y6ms03Z4S51vBNAILI39pHKG1ziAKWxQhzWuRRQcsWDvOFUZr7MQ3YLqjsCLxYWFQX5Z1ND
 UII=
X-IronPort-AV: E=Sophos;i="5.77,320,1596470400"; d="scan'208";a="152969130"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 05:54:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEip+Oz/MoRDRIlyHuOYtE6Pozg0mL3KT6YdWpDjAecfIWgtW1XlbstSFHULE86xwszzVIfhHKSvpFEJeyKsyVX58oEd3K5VepNvtWBVEBczHm1GggTRhXZGeFQ0RJ3GdxdSojugd+boMwJPMxF8iQxcuKoghWM7VTyXvMrNN/YoA35bFygKa5rExhImjotZbwiJL6kTMcLc8Aj60rtbCFcqAWJcl5Eluu1kwLMulrrg5i38dZTheW9SC1lrEp50Jk9fJVepq/TucbwyX/ule+vzhZtt8inoJDwVmLZQ+JjHu6bOMOhplopydMUbxV8X8a/+HfKzExvLyc+AyQTCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmSm1VF/o2c5s0+nGi9PqlXgl3Bp087eYhM72Ip2SwQ=;
 b=Le7yOb7W+vXpST1Qs4tadPMN23q+axr9/Vdz2WyRuv8X9gx4yP6cJKdy3bMWyS4xnlnsJjT6i5325FFSACQwKSnU2r4EXkjSnO8nG6wY8tiE9JvtE+RjDnmdyjbnGI9hwc7l3W6SvgQpBcxKDeQ/X9A9uTgqi4DwMwRGu71CW9eXc/5rQ92YxVQaj+OBZTJk1tcHWwy7Ylk2Ypjv4T6IwJ8GLPcIWkymGaw5XZfmtWZrX69XgMRViexQi8uu82LVlhK80+yHd8YTQRB8oDV8iYeQIK/UeRr+yHUTCg00XSbY91L6NxQdRGsmoaLp25e/bCjQzuYRjWt28uyxe5zfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmSm1VF/o2c5s0+nGi9PqlXgl3Bp087eYhM72Ip2SwQ=;
 b=Liy07hVxhgyTF3Iof+6k32APIKRK3CenUDJiaG1Hde4pDEV0QeVredHvg8b3JTXLbYRKtVqV+t86jFCdYO7l4t6rSiI/yRN40EnRsohgAbBJuVrrqSv2yXoTkzhPyT6gysJJ+QiDt/F9Ejq3FpWce9mIqs8xOLVNSqjswwgrlpo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6423.namprd04.prod.outlook.com (2603:10b6:a03:1eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Tue, 29 Sep
 2020 21:54:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Tue, 29 Sep 2020
 21:54:51 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 14/20] nvme: update the known admin effects
Thread-Topic: [PATCH 14/20] nvme: update the known admin effects
Thread-Index: AQHWlZVjRQx5PA9lCE6CqOJXye9lPA==
Date: Tue, 29 Sep 2020 21:54:51 +0000
Message-ID: <BYAPR04MB4965FDB5CB11EC528DF6180586320@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79c4bb7a-4703-4cba-2e2d-08d864c24ada
x-ms-traffictypediagnostic: BY5PR04MB6423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6423EB7F4C7D0D973D99245686320@BY5PR04MB6423.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tUXAS831CWH5ZtLJUls9NkeO8F85l2w63q1smKr4Cc5e9tH9D5sHTVqZxvRStl0o5AdZWIOMiUyKcdFeHxbjIaH+igKFMXZ61n6d0BbhVWJxflf2rmwkqG2pfgh1ZYXYE9gAzeC1nBW3KkaUo6N6cRmvmnHIWhKj/yUzWrxYvdn/yoALorxvfCjsz2LucI/N/fiS7roODNSw9aJ/P1WXDPOyUVCgcc5t1WhhnbO39v3ebf+qAhkMOWx3u91gciLPYGzA8DDcLgPi2R76xAn0WNU5celFzzTL29IQlnilISErMB/kN68ofll804R7DEPxLpxUhkHpebdefC3jJNTLAaDbUt+9KbYRhyv9fD435tVFUFIGBqBbvMLlvDhTWRrP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(376002)(346002)(366004)(396003)(83380400001)(5660300002)(66446008)(64756008)(66556008)(66476007)(76116006)(71200400001)(66946007)(4744005)(33656002)(8676002)(54906003)(110136005)(316002)(52536014)(8936002)(55016002)(478600001)(2906002)(86362001)(26005)(7696005)(9686003)(53546011)(6506007)(4326008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Wkhkfnzb7D6OemOhznlch+BIS0l4TyyuIN12uOe4HdnWP7u4Z2J9a++8MmrfYh18tKkhzTBzJHNSka4UO1KlpG8m/jdBf6NAbyT2wwvI8e8YKARVj+MBKCxVhiq/wB5Q+CxOiLUGSsXGO+MRrD8YkjgjOamaTb9TBEN/4SucRmJPqOjFQccZEw9lgOQHO2L6rKjzrlNByu55koXSS7dSW8WodrO9QoT9Iqs49zEJyTWNC7Da09Uc+92aIPIudD4jFAh7GhdKoEyUoLcpvh6SPiRO6JiaHItQPCdAbo68JERMxz0RJeLrb4jeICaCp4QXWKd5zCUS9bd0u5XQCnrLxl8h+M1lcRDBftMA6xH0jtF8+h3qtRX2yRLNCOy+Cd6btjlICHV4IDHlSyo9c56Fl+apriIpPMQOYkx9HGvhv+ghAcvju5VbTNtBWzMxW1Wkw4xuWvAQa0R6EgzVS6UesfcJybOvg/jQG8eVb/jZvR3DRiruYIVDqDzpfJbNOwHYzKvYOvqeoz36Gf6EuyvzJWy7JFqhTpydgt/vsGQmLPfhHJ1CDK9z6WeyvH81ILgK6RQK+hAaB+/UFNvrCgeSZ3M0V27v1DJSGu/dlbq9y8BvX66Br0hXO1Moq00l40SRnIipOxt2IQ9eG6CK+qwNWQ==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c4bb7a-4703-4cba-2e2d-08d864c24ada
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:54:51.3371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDN9HzX/SLgvvkJy7fbDKseheyHNnNiDzJPspAg8ZR388Ilhuap9/w6KovTk7SH6HObveSuHe5jQVYJxcLwyUkQjkA6T7WfQ8H4JXD2Uw8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_175457_500272_351AE501 
X-CRM114-Status: GOOD (  12.61  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/28/20 05:46, Christoph Hellwig wrote:
> A Format NVM command can change the capabilities of namespaces, and
> Sanity does change the Logical Block Content, and must be serialized.
>
> Also remove CSUPP bit for Format - it is not a mandatory command,
> and we don't check for the bit anyway.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
