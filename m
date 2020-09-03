Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EFDC433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:22:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9695C20716
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 18:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XtlFkTIU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C2LbW3rB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eEYR2PWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9695C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/siSrnZz2LZ/jzBgc/xbukoqM6a3VqnnSSAw9w344GU=; b=XtlFkTIU/5T2lAbyALHT8WHyc
	USAScxEatN44qsJItCSWaxjvk7vLuoBWGjLf4U47mianhSdeWsAuOVjc9Ieg/WlLUxV5kPgYlHn86
	cS2ZmLE10/aHJ8joCUOh7/y+g2kWAnJblK5/pIc8D1AN2auj2xEejAHAyoDHJWtEIRm9ueXmYKPmC
	tRVeLwej1qOmzHGeNHsf7bcy82AQj13xxgZyi0k6qq/kOmeW+Zl6qqANMw3h6p01wPvlymjMXK8HX
	ucA7c4uxeFyxICcp26JaEhLdJw5vN/n6W28jBExAMIXYoOxxy2FQ3UKRtm80Daki+kKXHdWk3yD+A
	LihlXNw+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDts1-0006xV-9n; Thu, 03 Sep 2020 18:22:01 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDtrx-0006x9-4Y
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 18:21:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599157318; x=1630693318;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=knYwWRvg+LI1DS3fl3/O4tHa8YheQ9emSy0dXkso3uc=;
 b=C2LbW3rBFs6UJS0+HXm7+qUlX4h+gzRqVPf0EtUHQm49iSJvJ4FFHLVG
 mmpDDyTm2dwvKEm2DWXJporYbxYypEvj14aN+DRB/IGcrLZlQV4MLy62c
 apnmyanOMu4boumUsxAubeX5asq/cqrq6V6FDhGqpNBsq6O6a1qSJ0S/q
 MamE/a91osSF3A6PIpLZZtBz8KlLvyyejSWsE/qJMXQSIppYhMTt6ETun
 I70g1Omqj5AKOqaYeEZhwiumlvP4DnOwe7/iGCrWiZcIqikxl4ZjiLHgS
 a0DMcENvP/hXVvlYpfypFPMPX491QpQzx37YOVGy2lUpZpNQIPlzSWmKN A==;
IronPort-SDR: JCrgJhEQnhaM5OhapkHeOM1iknvfwO1hXiXjVKTseo/0REf6TOZ5hG35nQRky/nHFJpN+im1wJ
 1eVkUBrfS6RuLITPJ/lwtuVyLibjIZrRJTsInYS/zeNoZXcEczcM3/yzTfNzyMxuZWIWex0gk/
 cObTS/U6AJGPbxS3t1vHad0FA/x7NWXjynauoZgN8+0xL1rJ/58zptpEHoIls35aty7D3aNPSc
 Jw8XbhEB1sWQq4bjJw7zFc6mJCK1WxkbWNZiNTw9XWbISInVEy7v7EJKsdZ+LhMtpEdCTvm4W0
 d7w=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="146513952"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 02:21:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzP/A3hn2Q7COZVH8FKiUl6BGEal2YpLOQLLtt0v4RHL5MP0UgJEYKSkLtE8tM4bhWEYyYW8H3A2TXeNvotvQ4OJ9AxykBetaMi6x3OBsHVszyvAD2QkXL/s/R7O6BJAZ0UGjM8QCoueubeKI6xkDbd0hfKB5Mum2+fdSSmkgo0Jx8Ng8kW41xlVIkf4BxRuNs34pdF3qp01h35nJCjx7vtyVNqewOM18UBBLoYSks60LKHuBjiMFDi5YSo6djTLCjXkHCIbjj7Uu5bGbe2x2eXNtxIBm0UlJ7ZFmC4GhLXaEDzTxImZSnqEw+y4sFi4948z1gL1EZ1QaLSUuq8zAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3VdO7wHurfqJrQnK8zXE7RRocroVVo4WgfVKjW5Y4k=;
 b=JtY+3ISl2MKcV5FnMj3Qxm3uZi8Q88xItfctxOLbbBwGgo9crUM9KzOzWrHyx0dT541W8XtFplKLHMGxF3VB09uibv2cOzzCL1ZWlNfPhiNYaEx2FFLuIdZ2+bajBJuTdHG65LKSaVZT5TmyLdp4OKEoVHvM8CNbTS9f2srBm69DSNFZA8ZBTB3C6+mIBGmLyfqgNTtxDd6f+wpI/yT7wTzSFzJiXzVd8C/J+rbUvaCRYHxR3MuPqfkf489jiTcz83codgR/wjivIDQGReHBBHg9E0CbEExAqedGy9bxAyhY+A35i1VanZDMh7rxvEowwPUFAOkUbl7j1aZfXpVThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3VdO7wHurfqJrQnK8zXE7RRocroVVo4WgfVKjW5Y4k=;
 b=eEYR2PWtayrva83/D3NaBfZ45tHDBJcP3qD42jQCjTmAIjmnlQ8/zAwzANxPoty1M8sBB3VGShWq6I0Q3PDfdfGMoNEXrrnKV3Rzqhk3zObVdVbkQzJB7vgAhMSpiWt8mBwV4ygMxFwe5zYuBLZt1CWvZ2hivza8VKVFQTpAC8I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5430.namprd04.prod.outlook.com (2603:10b6:a03:c7::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 18:21:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 18:21:52 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 02/12] nvmet: for pt I/O commands use likely for ns
 check
Thread-Topic: [PATCH V2 02/12] nvmet: for pt I/O commands use likely for ns
 check
Thread-Index: AQHWf+Xmmmveolr9nkuFvFOjGghHFA==
Date: Thu, 3 Sep 2020 18:21:51 +0000
Message-ID: <BYAPR04MB4965378B99F012F0DD0BC768862C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-3-chaitanya.kulkarni@wdc.com>
 <20200903161805.GB25423@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d46a7e21-d413-4fdd-7563-08d850363b00
x-ms-traffictypediagnostic: BYAPR04MB5430:
x-microsoft-antispam-prvs: <BYAPR04MB5430573E21DFF25365C61F75862C0@BYAPR04MB5430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nYxgcnAERRcYMbT7h5GqG0GvqJDD1qIeu3haXjM03f47Dk0D9SQs+1L0NZxrnXej2OiSnFwNbE/DPNUFYb69ZqIIo+cxu69KTSXpIO8pLjPd/MEtnnY3/Xq9YYHpsKvTD/KEE/y+9ivy6AwmH7cGtS4PRddCshQIn0SFWOSIwxfxjgx1mpWlA5PX6AMc8rtsuJIoX8Lsnb8F4RzNyJKkBE5/mZuRGaRwWJY0khEOUpK+mb+NZGAW7tqcOmCVB7AEaYDjUPzmjeXTObeme/q8/v8mYhSNPVry+onOy2BBETcO+lJ6lyGozqWgdmwdBBN7+7JS4K9A58ki/8p0xJs31w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(71200400001)(66556008)(26005)(54906003)(186003)(6506007)(316002)(53546011)(33656002)(55016002)(9686003)(64756008)(4326008)(66476007)(478600001)(66946007)(76116006)(66446008)(7696005)(6916009)(5660300002)(2906002)(558084003)(8676002)(8936002)(52536014)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 29maZkIkROtDc8VtUHbBiAMNRTu52BbY0Hbpdo5O0odfenRwWxYsanE2pMN/04Ga3ITFGmRP9wpy0QOOJSbKw8D4hK8D1ttCOorrBF6ya43yYS7dkx9s+zgY5Y9q2uiNXKl12kiVSbAcNL/52hG3YMheRJsq5Y8LqcUIZIuKBqUw1rpP7DVoZXc/r6C7P03XzNn5TqJU9XRfdjz6B1ky45LQcBJeygsiQRWLkJuQacTKlL9aF3UkdWN/v7XSII7LwBWFW/8j8ZsFFNnvv9oO9kPBJrFRck0hHCU8zI9nCl4kK7vfcAgB0wSB3SrRfajBJxG3Fs5d3XV/Ip3LxgHkjgxzCTPRalHrSARFbTNQ3rqo3ubsGFllv0SDMYj27qcVzpZn+ood88nEokYURCzFJPfobYShbhiRi9/wyXgzYXQSLol0Jddue3sjmmK8YM46h0zI5KLInEfScTtyN6ITxyUpAcGIAho7v9/pw4v/hRr0LIwnx40dFpDbQMwzuYwqsartltmhCOKB8U8e6a7X3bKx6fae6V7phC06K2AHiYgd3BP13+WHsU3XA+YsuHih2yNo9S4pKOETb8ym2LbFA4wZiBUC/CRXji3FhB86smx05kyNYCmuI4q/NL2kkGtL65TsaASrzKHhyYmBDA9wMw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46a7e21-d413-4fdd-7563-08d850363b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 18:21:51.9647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5XzbVFnSEchq51PrB5VlBjd/sAC4j+BQ9s0Ls4mOBm+nerH48/6KTl02to3ceV8H3kyi7sldpQiIdPhNttj4ZDGeSkDktVurE+my506uaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5430
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_142157_481253_8456B47A 
X-CRM114-Status: GOOD (  11.08  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/20 09:18, Christoph Hellwig wrote:
> This really seems like weird over-optimization.  Any sensible branch
> predictor should be able to find this out by itself.

Okay I'll drop it, we can rely on that.

By looking at the code it looked logical.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
