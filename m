Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B6DC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:25:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2064B206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1ztySMi5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qI7X/Xv+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fSbMmW6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2064B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nLWZACHG1jYfYNDhj7w3NioP919SqXxBDV0x9mHD53M=; b=1ztySMi5YhJiL1j2K3fpuDlCp
	+SvOfEyMznsAbM5jcRoMlj4/2SfNZPUfXm5b91sZRdDfAEQXwCBrFs2zhYbIsIKkEs3CnsoH0b9mD
	DHSbQhDEijOPe8eAUbNMzTl/u46x2yH/kA7yjMLWPKi346ABugmvHMRABkcVNUEAhLwgq3CfEhktV
	G8YkpPhPevJc4GPulDd0gTh3MqlvaQkM4HB5lDdQA6AA4Nx1Jg5rKUNxfObpwYvuQPyK/IN0CuUDO
	FRf4wD2bvsh8zET4Ovg4OO7/rvHaFvc0BPAyQpYGId55i7YPfXGOiohFYl2bvG8h6dRHk/KAZqVnf
	VN/HDk9ug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5HAT-0003lr-SF; Mon, 10 Aug 2020 23:25:25 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5HAR-0003l5-5Y
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:25:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597101924; x=1628637924;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FM9pwQdpC4H+E2NAv2x24aB3Yfay1a3v/rIH+I61lCc=;
 b=qI7X/Xv+AdIbFGPZJ1YtbeH3oG0oWVXK2TYSN4SNjzBIiadKEolySVum
 pIu3nPZbcgnsQNSvpf+mpjrIEzVrN9m7LY3mZJXgx8yE4WWK4NDoAy3sZ
 Up0m0TUQf9AbysyVNP9NRnQlPcZy5gGNmCYQLwrSMk6KFo3Pg0V26Aj/X
 Z+m8hcwYgwlPa7oYULz0UCUlT9HhI5YCqtSXYSWmvmpXgM4wpJ/kY4QiI
 7WdMWjwEPHd9jHZ0cLLzAK4biQhLvEu/mqtOVphmQ4tcahZ1cxkc8ildE
 XAtOFVuKUrjFhpxN9oTn53rfOPt3PMUzZv7kwp2cfQ9qeQJQR7bIde1Af g==;
IronPort-SDR: vHAujtN3wfDWSnw0kpPpQRdd3LszQLa2GvSQtK1aIFGrAyD1hJax7OajSHWG1xgPlOc+M8R0qJ
 qe52ijiBxfn7/eFN6jNV62Y/3RJtyFjJJEYoqnh+46/y/zi5vCAx7fE6DUY40jjxTSkwD3iZ3J
 VWPY6lIh5wY7lEGM9GOXaM75KVsAh2QjOeLObdFhNcQUZf/q/B5AqEYy+x18bTbcqjYKKyBOJh
 E5xHvEBJlQa3akRT2atavPtMi0dkjuWpay8SGZsrEjslGk9JyoNWSosqKHIre+0S+ZMxXeNuQR
 DDE=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144666277"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:25:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/rUWdVBHNXbc6jFaxtno2pUCCz9vU55Ea0R26ptlMxk1N4d72JyjLIfGwYn+itAjN3BJUW0CLhyeDvvtPqpBSBZepAJKrbO5+G2P8UBwKtIgD9dOPmlyKczVuPoZ9QvNlCFtYtHb/Rs2AWM6WfE1ctu+9d7OjiBY4wlUkvlKHHl5aTe85eaaGKsorY3HGYSTcgx4X3wYPwX3RIM7ZIjfEN7ElPPcdueFFB8WfN10U+yR+n1jpQ1XjOVUOLo4mAXsmz21UiCGfvwQs0jZgk1Ss5fFfXlU61jiJZ6/mMcaJ2VvdwlK3BuHNflrdspXMy5B5vRIynZ7ssCGob0iaWODA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM9pwQdpC4H+E2NAv2x24aB3Yfay1a3v/rIH+I61lCc=;
 b=Mn3+gHb1837+UlscjwA+i96emP7etu/Uq6uUb7pzLaRzm8NcCSOMzgjnqnnJxdtqWBTPX4eJKTA6zvXpD7/WNOqvBGIOsCFVw8mqfYElBZJXPt9jg32z1yKnpOcndWkeOSv0tAnhnapc+Z+RsnVr52Lxixs2oAp98mXsY6WZvQu1pnUnkry005lwFtHlkgbMskhJxv8eusNPXCt42PCqlPtYlkNl+/11it8U+SQJtVAP5nZHAwfa8C7p3hHMo09lzjPJBkUYyv2XYTA7ontegW7OUBzHk/CAkMo7n3YKuiBFmZThEckCGdg3VZ3yuMIcwEL8St0ImF8CGSenVJ+gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FM9pwQdpC4H+E2NAv2x24aB3Yfay1a3v/rIH+I61lCc=;
 b=fSbMmW6Qo5Eis0dnaM/GoYY1BFesoyhN6gGrx3Xs+UlmVsbLQkvmnD+FL35tDdi2EMPtyWAEN/fNB882FGUTS7DTKEV2jL7kg8ZTQ4yvPuSDl0KSehmNY16HDQB6SaYzmhDhskG64TLxuH4hvbPQwGVDoKhfqev0a/3aWFEFQeU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4870.namprd04.prod.outlook.com (2603:10b6:a03:4a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 10 Aug
 2020 23:25:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:25:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 05/14] nvmet: get rid of the extra variable
Thread-Topic: [PATCH 05/14] nvmet: get rid of the extra variable
Thread-Index: AQHWb0fa+VhsrXoTJU+QgSwrikKDHw==
Date: Mon, 10 Aug 2020 23:25:18 +0000
Message-ID: <BYAPR04MB49656CE7B61C9420D2C674D386440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-6-chaitanya.kulkarni@wdc.com>
 <f7dfd268-9b02-4711-85d4-eebd8614f8d8@deltatee.com>
 <BYAPR04MB496523DC21401582BE98753C86440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200810231346.GD269401@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d93df1e-9667-4d45-8c30-08d83d84a508
x-ms-traffictypediagnostic: BYAPR04MB4870:
x-microsoft-antispam-prvs: <BYAPR04MB48705D57945E05B3EC01C95686440@BYAPR04MB4870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rDtTpDenEhNJcWKD642Tbk0WCiLa1erbICTZgFmQ+undY6cWRnEG/adiM0yRGlrStmxPwrilv4/+NSBkYJGG120gmwc3gt5qSMiv0LVN+jOlG4r31ALhO0JLUhX+sOpG7igTCI5EF2JhYwbYSmTHmQH5NRRH44tNhkXW/kE/TOsrQJw8MuyouSoGbOpzxO192RGdRuf6yCuOK2FzvGphJBhHAMqDU9aoP0T2H+bKcOsDn9V0sOtqDrnTmkjgxnWDhIx88rBPrDAOOIIkgT0/E9uTQlS56P6NYi0fYkXdqLYG5hxeoslv0LZpV/Sh7jrqe/oa3uISAke29fNYnP0r/MrkNax2JYzUsY1z/5NDNWp0UK1e8o3Qf/W+qDVgafQI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(186003)(7696005)(53546011)(4326008)(558084003)(52536014)(6506007)(8676002)(26005)(33656002)(9686003)(2906002)(76116006)(55016002)(5660300002)(478600001)(66946007)(66476007)(86362001)(316002)(6916009)(54906003)(71200400001)(66556008)(64756008)(66446008)(8936002)(26583001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: AwFNOZNNNVObi/rNkSw1YKgz8Bb62Op29nLQZTNTG3NmZNm0u6vrmG7ZE8llRlufUAJexCudmwzWkJRD4hfMPnn7lPZfnFoXc6RnFzKFnL6CQ444JJy4OaGECcJtqjFvLJ/QHLX9iyD0euLahv7ZgAzGtd3Plfijcz1hQ8SUEVUKlNs/f6rigGoEE5HD8cMXbd7m8ljjZLNTq1S+NKUiNxSsGXGwxv1mmpDscS49UeXtYv9HxH//tkSd5G4B45YCRZzjAlh+cgC5RYuijRKrjfJF/pWxBS1W0qd5ItEYroyvGuJeGKrkfhepSKwVvcFieoXyi+qtNBSV7+sSM3dvzpfhs58o79D+h/fV+zii3SYqjOodx66vIJPf76biw1s30vWQa7sFMdilkOpWr8873Wnt3wOTyqYEHpPEhkgvgSs5Z4k21nVVez2bs5VDIttswWjNfOBXrtn3v24NZL6CfzITD1eAJmjwx8ei74uFlC1Dzdu9j/x6h4KCSWS48F+GTNdYRI2QBbKKPMKNJc0qgT5Vzg/0a3QkPsoBSSrxn5Nz3MhP+Mr8WVTX9lGZMbhmHk4TSpw1hR9r4v2/AAAc0pFiACToDA6tJ0F2bm1RKkavZaDZab/zF6LOioD9jMuM0uvLH1nUp4hHSJD2NCTI3g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d93df1e-9667-4d45-8c30-08d83d84a508
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:25:18.5893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7g+xmrZ3YiegUYsyGzUH78/H9+VXjYKRJR5jVnFFJKMt5IxYrN7Q+yKXsX8MaPYCTRLO9kiWpNch0Rmrt3hqSx5QeK2ppjK0RumTTyaGDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_192523_377744_FDDC3F28 
X-CRM114-Status: GOOD (  10.20  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 16:13, Keith Busch wrote:
> The odd looking part is mixing "likely()" and "unlikely()" in the same
> conditional.
> 

Actually The sg_cnt check can be moved into nvmet_passthru_map_sg() then 
we can get rid of the odd looking likely() and unlikely()
and have only one call.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
