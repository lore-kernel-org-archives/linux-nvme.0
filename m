Return-Path: <SRS0=uXiZ=6J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D2C55185
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2020 05:53:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6331C20724
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2020 05:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XXAF17dM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aAGXBJcQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="st1Downz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6331C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=b+jaLOmDmGtv3C0rBOWfiam/HTZCcRpVroqQjU1rVjA=; b=XXAF17dM5JePvy
	K96vutVw7sTVzWUakcptGM3MNHqRdkb61nkQaUUVyhctTgNmTZAEZMwntb7UMwttrZCRZYvGN0jEh
	GjrDD0C4eJylelNBPD3bZIIUdNOlmFqrxP50E05QyeEy13c59enEw9A9SkiE9wV6y3cXd2dAEdOlM
	EBGRI8auAUkz2immJI72nSkNSDURMK5P15aD+xVzmWmUhCiH0NughTz7wuJQvnl7qX3zcwLpsy0kW
	0XSw7TDLoCVx2Nn44wHtoTMrKk4pa7I0WA82iIzqLfiytvsM4CrLTLVoP7MOF3OozAhabEovEGYEV
	QueG2p+XLyYk4+iMD3vw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jSDkS-00024Y-EW; Sat, 25 Apr 2020 05:53:08 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSDkP-00023x-1m
 for linux-nvme@lists.infradead.org; Sat, 25 Apr 2020 05:53:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587793986; x=1619329986;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=iaaaoNKrfz8L5qYOw6qoVjw4LWSkbRhCeSCDg20gQrI=;
 b=aAGXBJcQDnHu3INGyNErwCtCC3ayIwJrbfOezpA4pm70OS13JINuAmue
 wDqwktmd/ycXTvZjzAxupGJUSiJrXuZ3fQjwuY99wdqIOk8JFZ/OpPotY
 Izaz3DG25gRrAJR850aFaJzvEedu29b4gKDPzBKNTTL4vZmrcupGhDNI/
 C3dRF3griiaXaP01tE/6Xr9JhTLduQHB25f6cGEoG/pgGyva3BnHMHgLi
 Q3aqzbZ0K9WS0gMxyceL84LKhHNPnvn2nrBLmebW+KR/9Qd1x7CPc+Vda
 ZGUkIirTxzm7LW6YzO1GoAByc92mEi5+xsVsZo318CAnFELfc3sctls41 Q==;
IronPort-SDR: D2F2c6Gn8bJ+FDvnKI0bDPEK8Rbq6wt472I7CIUWpeDzli4/TbN9z+DeaGiWvDSlxFJSLdxnph
 teYF/O1ksDvlIY8Qxl1Qbs/aVqzKqjgM34hAbm1U7treDBUZkOlf8Cs9IlSmbc1pA2aBEzAlPB
 H2LJPY85J3Np/cOSYAY0KVLG7znrzV5HayZA6Db0yhlUhdtsmUB+bgpW1Q4/31UIhPgzbnFvAq
 dM+wESNlSD6KBQgaf85rNXWVo6DlKKXAoazfetHxS5XMtqsWVon430cYxllXYWNnPowjAw9hg4
 VSM=
X-IronPort-AV: E=Sophos;i="5.73,314,1583164800"; d="scan'208";a="140479542"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2020 13:52:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiAYu+51Env3xCwu6rtimf3LQyQLyqEQzxeEqaaYXypMjXsJiz0xcWROfK+6e3iOV8OMrdNeNk4aLhcdALc6HVC1ZcO5hx1o9XoN+dq2lucoUJxXMBPGIdIugiS0Esyh/5r9vafhrc2J933epp90yJWbhyujHC09g8P5kxqspQQTTaWEWDt8IVnxqmDEpdDw0Lo2HKURgqNO0kaE5eLVWHq1FwwGiREIqF1/ybZAK0vUftc2mMcBNsxzUKJKARcWiyusp9AMyDfrTKDtfJ+Laefu7mWgoEbR+TbVutFpRS4eFJXokUwZa6GjgflvhaMCNkdG2Y7vlc+j4gn/sUAj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaaaoNKrfz8L5qYOw6qoVjw4LWSkbRhCeSCDg20gQrI=;
 b=EofqzHEICQwFgYsPMD1iaq/FIHzSzzaR0a1E38RsemopZXArdIgdyRdNUbTILsUF7J2Tu+56wRG6OvketWZTU5+HEw1D7SMNZcmRDeCVz2azXRm6NXGeCJFjD4r74MEF9dmzgsnnxMDJdxrOnqmhohKTXCsQIwyrbdGS9ndBDF8MLTWtH7SXvhHa6pQ84NfZaoGZo7PW4KwZ2dzB/7T0rf4NF80sF1i5Z755uvs01Z9cL5a5NNS9rKv6gNmvJ8VV+0TUKd4Y12fEXHL8yMTNPZwB1RjZu+RVJxyjvheRsE/gVXmj5LuFL5xEh0PSvIBF8IfjmfogtFe8FUDhomeXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaaaoNKrfz8L5qYOw6qoVjw4LWSkbRhCeSCDg20gQrI=;
 b=st1DownzrugR5jCTRkEAF7SIE624nfNZyjQ/01KgIVtxdiXuOZddv3nEZ4JiKjxLrYbIdM0vKpKhQe0DrRIrJjcN0Xqp1xuek3gTpFha7l9JlG6lIeEX7JRUl78c3YynRfg1NKpJ9frL813tgcufX9/UCUYlv5ABJGsQPlSfnfA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3926.namprd04.prod.outlook.com (2603:10b6:a02:ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sat, 25 Apr
 2020 05:52:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 05:52:56 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kev Dorman <kdorman036@gmail.com>
Subject: Re: [PATCH] nvme: fix compiler warnings
Thread-Topic: [PATCH] nvme: fix compiler warnings
Thread-Index: AQHWGdXGFfNgJu1/BkKsctBqizyRjQ==
Date: Sat, 25 Apr 2020 05:52:56 +0000
Message-ID: <BYAPR04MB49654C07FE4D6AFCF3F447FF86D10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200424011453.11156-1-chaitanya.kulkarni@wdc.com>
 <CAN4XXPDjXcEhR9AuPXf1hv9hoe67om9BAN72EbfFGWzLt_Sgrw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54af3515-c2b9-436b-1bb0-08d7e8dce6f9
x-ms-traffictypediagnostic: BYAPR04MB3926:
x-microsoft-antispam-prvs: <BYAPR04MB3926E739B2204A096E588A1A86D10@BYAPR04MB3926.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0384275935
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(9686003)(86362001)(8936002)(66476007)(6916009)(33656002)(71200400001)(66556008)(26005)(4326008)(55016002)(52536014)(66946007)(76116006)(6506007)(7696005)(186003)(8676002)(5660300002)(558084003)(81156014)(54906003)(316002)(2906002)(64756008)(66446008)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MWIWyKccYyjL135sYn8U/8XBTPcSnCz1HJk86PddYhkBZiU1nXV1YW3cbaZYZnOHnixiwSlmYymcL7sltvgCJpvwVHh2hpLARFHx8P0Up+FuYOY2PNL4hI0kMCrzCsBTVveK6um+x5hKx4dEwVDTqMvgiYRKA7ub2g3kdGwU0jajPQw1Dr3wyqaYmOA0isBx41l2kB27mLAiRiyOH18XLaDXXifREwLeVLFaVNDr3MTYnDar6PVKNs63xt/VMx0xmbXbkNwp6d+aioPRnMlB2XnNmvJbq2iMYZY5Q2/yAmb6/0Vc/H4iPy0qv0XcFad1D+Id9f3FJHEz4+M/rQN52nag+FTg4s3ocbShyUKcyqUHhHdyq1b8jNWBy7Tsp/rhUePbwloTjuv+zcgzRFJrVJNOqcyFrWYGS/wDeyzRkv7hnqcbVFobTbY8qVfryYdr
x-ms-exchange-antispam-messagedata: 11CgFM0L4jyTU1HrnnIvND8k/+ougNuKAnFV3SKKGfvGwE3k3q6/kJ2hVqirebP3ZTKRbl+B34FP3WA2r0EwTutgLZ9VK109Ha/CAyu8TgmMHhfPZU2dIZKeBZPJYoVWfqO3zMC4NOUR+vQy9Q8hoPaOzYisA/rCI55EtPNxvOnM8QotA+M7Qnniafsfmubtr6TNyxd/hb8MJl9ALjz5yLiSqHBsvmV8EPFMuJmLMeF/bMmNHN5LYIIbBuNn35VTj4++HZSYiSqadSht5qkrsa3baFAO5e07ZFRD4V7uH9tuTf8SFmvJ9bR0dvBoEq778MhqWxls2Myrsf9MrOnk8xCp47R0LR+UXQAmQcp1SD63FcKudqdbAZHoUfopQ/2baN3an5lGvwjth12aMgxNGs3UEdW8V9kbV1trG1ni0JGmZN7RAxDwTr+s5FxIjixfq0LnzKYpPelF19HTttx2wMvCli44iHXsoZz17rTMzgRpxO8Ao3VbOagRsPhfBJesL2K1nS/+WuIJ6oSZIa0zczoaQ4OfRTsIOjKYTMOvX5WcIVekImi633UdfXZW/zcLJx8QtLRpStVavodbSfxT+reKp4iUoa6+sV8WI6Dpu1QnVsKn3SS70oqZLpT1jljw0TsU0/yHfC2/Ev34WFq12yUVfcoHE+fOnV3r6QLuudiTxWo0ngfnGXs9gSy1okjzOGKrzPJ326t9Nd444+KOueEXNJYxqZX0yfXXM91mae92Oms/L0sfllq9fHDRxmjKhfY0A4LNgHvGU+6MK4c+nS6w7h/Evsq0xEyZfd7thXQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54af3515-c2b9-436b-1bb0-08d7e8dce6f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2020 05:52:56.0349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1vZcKsaLMTxf+cN/NhBb8U3SuTWf6eKqOMAPHVdpJAF+BKkq5j6PdbZkZcgSGXLsewtCHyetWLAzui/VFjyfW9WbzGDjxiNjbeDlwtwz4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3926
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200424_225305_201684_0A1EF9D3 
X-CRM114-Status: UNSURE (   7.70  )
X-CRM114-Notice: Please train this message.
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> 
> asprintf() returns the number of bytes "printed", or -1 for error, so 
> it'd be better to check for -1.
> 
> Kev

Thanks for looking into this. I'll send a fix.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
