Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D751C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54564206E2
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 20:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fw8H24cW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nKsmYYI3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WlzMemTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54564206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8dbhTxJQ6lXw157WDgGl9cH6zD/+5i2v+RFfgzUI8YY=; b=Fw8H24cWeWTgvv
	5bRutI2iPtgrurbeWi4khjuTjkoxeQsdb7IeHFG/vCsdy1Fy2ikDBKc/gnjvxNpyHoG1WcA5pKIwF
	Sg9iKof2BcO8D44f+7P2HfsxXjDm8HpYwGxis3lZqO1b4QzGbmwQfLMC0VYwUrAwwzBlk6791d6OR
	X1FHA62Gvp7pMSkfGcBMNoVMTYEolcHwx9uKxlxSSLS71BhBquXE2wot73VqKODMCgv6xagCdsssb
	AiCLKrscbCHhCyxyXXHkLY+UqO3ZgP1CATo0ZJo+4dRYMi2rRJyE+RbSp1ZW8rTT3vwIMZCghZ/R3
	7VeB4tuJSVxCqZhC7AIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKScT-0008TH-8B; Fri, 03 Apr 2020 20:08:49 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKScQ-0008Sl-Ep
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 20:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585944530; x=1617480530;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=n3by7X60X+9HkZrh1V2aVN41cKX0FBBH9eag+FNKWfA=;
 b=nKsmYYI3h4ZcV1Chb8HYnR1xUsuRjqZuhxyGVld5IcCFIWGXjRSFb1/f
 9yPjv7Km4NHP+XyQQ375UaXvnz5oovLV08nEIyMMRFbH/9323xsBe1UMb
 7LNreKnH58l52kQwI7BSIySMEnzn6rV8+90zWb3DE4AWywaz9/vfN03ij
 Ds10FWu8bn6Chuuk6NZAlJFZTVr7ceAQdeodKRgcpqyQk1zEyE0qJSuCE
 0Kc1PseZJjVE3cI+BmPKjYZH4kZmc+yjVzDnnRhsoLk8gx1C9iAIWxiL7
 Ra2+8E7m5r6FCZlirmr/a5pT0qL0R1yGGROXjvADzPTsXC6/+MLPuC67z g==;
IronPort-SDR: hwwBs1wpuZRBguePSYKblkZHUAfR1s892jdI4bv6zhbi/BcD9Tn5RKUd8eMldqgkNg8Fez+3y6
 VecngWDUnRvx1Zr9bJT9vgFdEFYq9AgrUzNUol7dd1a4EF6Gzw5ShwbhJbkkCRitRPO1jvyX4t
 RW6vELdZiYN5wKXcKuDNkFCmAxdAZwDdH7P20qwPC2fhqSWzEJ4g/nPO2MlG/aCzgqe9P3E5PB
 klTYVrYEjOeF82IB28nWN47JocKEaqxpb0SileJ0zI03TSX7DENIr6Rc9xNGd9f4zVRVkKxU5E
 168=
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; d="scan'208";a="236836634"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
 by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2020 04:08:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWNqlBffbgrgGGG3xpZoMXTCSlnweq7/kkYwtkx7TFQ2AoWD5+rXCEt2jPuNNAh1kVDChfkxaH8MmTW0GvJQus4sx6eTI5CUZKu4mpp2T3HED30OvhxxKSvl9A1+U+4QtGU21qtdfcd7ZNs1I+TdUJK4TJMhNtt1pfV1B/iHxFpzkUpcpAG9CQiHg71A4PwQKQSCFiMD3uWUV84cyv5Wo94XqhUA0AeeV26Fcl+Y6wNStkzwc7Ss0RP8KAq7ly1zUPjh+11DiB2R1mrfT0QtdMSL7w/5QtX/DAAXHwHbX50pglpu04xP/e6O69VNT5krLuRCLwLT7E6TxV/n0gd/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3by7X60X+9HkZrh1V2aVN41cKX0FBBH9eag+FNKWfA=;
 b=ZF17U6ylN1kaGWefSbQkJkYGrmolrI5dFwqdldZD571yEzRUFBtZU7E84UkRIWOnKy5Y+s26XuZiVSyeFWWPciWo3AsoZoZ26+wf/sAw/3VPaWUU1fWqh4laWs8jNbIvllqf5YtbfcBI6egItl9kxzZ2IqL7HUCKcUe9yxsvd77f3nISbrtjT4Xa/b8pmub4MVjzysXoXDzC24FBACQt+soB1A5SA1SKG0jurBFt02lMT6bCINGop/tN7ZD4w4HHb4L52hAW+dOlqJpFschc3SRAT0xbILAglmZ11/PNPpdvQx3gIQodJ/G5ESRU9zWgGDGyZjJ+72If35TFyhonrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3by7X60X+9HkZrh1V2aVN41cKX0FBBH9eag+FNKWfA=;
 b=WlzMemTz7xIH+TsHhkuk7rohVDX/BW5DEgGA/T5tLhiGH2IT0P/ZE+H6vj1ZVGOmKxs+Z7liMMObOQMYKj1Wv36HHyrku0RNG1ya7tvD6Zuk9iZi8gsCQe7u+k+eEy9QXZTT8Kn1ccoiEkWlmDZbn+ZAk30Ugwf8LIw0UJBLKrs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3877.namprd04.prod.outlook.com (2603:10b6:a02:ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 20:08:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:08:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCHv2] nvme: define constants for identification values
Thread-Topic: [PATCHv2] nvme: define constants for identification values
Thread-Index: AQHWCeDu21TVQX7+vESAj806OjPJBg==
Date: Fri, 3 Apr 2020 20:08:41 +0000
Message-ID: <BYAPR04MB4965A47C87B4708DE836F4D286C70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200403175346.1571822-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b711387c-b256-49fc-3e41-08d7d80acdf9
x-ms-traffictypediagnostic: BYAPR04MB3877:
x-microsoft-antispam-prvs: <BYAPR04MB38779914E5BDA18B3CA649C986C70@BYAPR04MB3877.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(8676002)(6506007)(76116006)(53546011)(110136005)(81166006)(55016002)(9686003)(7696005)(8936002)(5660300002)(33656002)(26005)(86362001)(316002)(81156014)(71200400001)(64756008)(2906002)(52536014)(66946007)(478600001)(66476007)(4744005)(66556008)(186003)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tzm6DFGn3M2XP+GoIuKj6xRV0tczw8itNHlaGZZpRBgbIRPgDkVGgu4/gqQtr8VGlKMihQqoqL8Sl1uY8zCcZThiKAR8jlj2a1LMeZLV6hk1bz1Ov470i3ON66VfRa+Z+mkQfvubxbZTvF5/el58CJGdh4rlVV81vWIOaO7p7SDT+gxMnH6kegTCTs3M8L7lRcYfDo+UjlapaqTG8z+qpGslt04xWwjG3YFlg9ZuIpXzfYZKkERjRvkechmuGiYk9arz5Vi31joPvWMfk1Q18Ec0jOyPiY6GHsBl07n9Enm7nHnS5CwxdqPNxpayztY+BsVWGSDxD9RT1aOil8V+Lw8qk9/6AXbvG17n50vKZNK1rMtOfDlRvYew8ioOSlR0nzS6xJG5bDOLn7v8PX7xIV8alm0XhLjt0MQan450bezOWnUFcxN8hVRdxzw293zY
x-ms-exchange-antispam-messagedata: 4C8Pn6felb0OEYAmF4BFNvMf6X6nQ9CEzuTatC9T6r+ZToW/tZ3/3mKJKWwmptWRwDEJ+iCeO5GYTwgcg1XQk0wR7mwxXc2XlO6Laame7I6QkR4e9guKynnxSQjet72wAV8bdj132PEiz9TUIt7OOw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b711387c-b256-49fc-3e41-08d7d80acdf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:08:41.1961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UrcDZA+7otmCObRFqKTH/MRGdUGqxd4q8DB/XoErfzon9er5XnjcJNIZtlyz1RoqRbUkKFEq+nTYa4KCzwm26ocFLB+EFPp8SL4p1GlrpDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3877
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200403_130846_635571_B7EEEDE0 
X-CRM114-Status: UNSURE (   7.33  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/03/2020 10:54 AM, Keith Busch wrote:
> Improve code readability by defining the specification's constants that
> the driver is using when decoding identification payloads.
>
> Signed-off-by: Keith Busch<kbusch@kernel.org>

This definitely improves the code readability.

Thanks for doing this Keith.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
