Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D394CC433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 00:31:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99427206F0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 00:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qtHcuGGc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NiUi5lf+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kRTVAr51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99427206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=hKyIQ/4WyK+MmQHRRvI0orB3lEMEfHLavX0HiB2kIak=; b=qtHcuGGcU6gU7V4q4PNNC3g+U
	tqvtQaiPS10rXpsMyMjy/2hFFXyky4RNP0sJa5FtK+gr52a4F6WMa6w19xmMGWZdROBR7ePNpNhqT
	ta58uMMpNgL9LWkZrxMGOgM39oE975VRpBlhS7ziiXzxjwinMI/BbWbjQWKdnUUp0M9XDGyWOH1AV
	3aWykc17nyE4khVNpFayUyYgeqMILxHyxYd2X4SdJS1aeDEMgP1OUbM/OBb7ssu1B5A6X/cag3ixq
	LKXHfxr2h6CcCOLY2wdy+L1d0m/jtgrxI9hStprlLNzGf+pwxIXkiXb12bq1KisrTpcrJZu3kt0Tb
	szuSHAYSw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDGgV-0001e3-4t; Wed, 02 Sep 2020 00:31:31 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDGgP-0001dF-Kl
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 00:31:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599006686; x=1630542686;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Sm9mu+0NtAwvKNLPJEegf2OvfaJeBLYtVBcuOpJHNlk=;
 b=NiUi5lf+FWlUJ2HxyXRJVdGb+bVSKf4oAXOHrmnkEdh3fiYvlUq7D1Pl
 wxfNQPSTAdjBHjTmInYOmxQXOmfdvW/Erm3HPQgyCG+b9Zt1bzPhBHRBm
 NpNHPzH6U83Q6M05w6DMi2X/8bu6aHscEE2om18T7euqo15Y3D3/Il6Ag
 mDkUqVzf/scc0Kau9/w5IyxFPLtq2+at2BjMqQrrNjoeatSoBH6ClU4M2
 qh1d54t8eQSP0zf/21hEDi1qn84XBZfAAhMPFS+ym2XvYokMMd2WDsoLg
 FnyhLLNLpsSKYMRJdBLdAj5XZk5oGe8g8TEgU7a/diVsjHjE1cfgJEfJ+ Q==;
IronPort-SDR: Shjb6Mwgsbn8FuQzUPc/HCxdgopiCc7FMZ48Ut9r7QECqMgh6zz4cwaIaDDUO1u4fQ9pAEanR/
 F24hAntdlxm/nYjQSM7Q2qKPNydtC6c3RJSzUWCeqx7AoVaSMe8Sp+KUznb0/kxsA1uOiCBTH4
 TFwp00DEvWVWYpkfTFCLLr6xpiIu8b8AW69o6F3sbK5NrDdqjwKUUh3xSsxs6wYPRGhk7mJ3A0
 /uN/iveY6PHKvgiODJMtmB3Lzyhb5mMPFB9dSNmCYBgAyqwJ+Lz5XSLQK5Egdha9MZc8YcfZoW
 tqA=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; d="scan'208";a="147587153"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
 by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 08:31:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxLO34wTWJvlYLK0tn32VNyoZK5TBNu6EdZwExSb20UD4O/fBxF491XmSGxXnYVJT0LupA+2Zxj3A+o8+hB4wdjWgPgbCSgLmZSIABdfn56/qHlg//JQcOcBjUuSwRDO0uf/5QbFhG4G7rhbkaDFGaPwkiSlxbaHzS6uLqJ1o/nC80hqJ4IEWwFC7/iYOuhE7FUCwuclgXYhSO7FtHJbiJw6KkIbqxEAs0vTkK9aaY4BAMS6ZktTjO50pJFfYjfq8Lesz5m9cqPHDVIY1TAxjS/jYr5IlSdZOTRsdkN42Ht4xoPjr3sUyQltsjRORNcdRcVUFVw8x3SYEeRsfSa5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm9mu+0NtAwvKNLPJEegf2OvfaJeBLYtVBcuOpJHNlk=;
 b=oQGSfpRISNzfdPQY3kjvV/Q8duqL1qYlGbfU6Xr+I/A9qzWN4MKiGoh9e3GAjHK415KX4loikneWGQShVqFbP0HfxuRCBz3vSX5Y/XON/wdF8pYBKjxzlM+jiSU11ErF6FQfRcKRglAR9PTVr4qbIdX1ei8BYEqA35uAId8OWX3Gp5uZp+lQKBkFi4nSghHzOxsVID7hOnhtU09E4cuXPb+3qqeV2mwLkHwK1xz2kQ5peHbaXuWBBe8jMSJYbbN/C3xBxQrwE6SImrMGwBZdoC2X1AbEZKS11nLi/zkSQA0bH6kcT+Yx64eLNi+X5q/jKH0qYXg5eZr/HSvYu1qxZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sm9mu+0NtAwvKNLPJEegf2OvfaJeBLYtVBcuOpJHNlk=;
 b=kRTVAr51hrWQwPpD349JnKCxfg9nN8vr0aUSb+/xwq10aoZfXAnbPBahD3b78E2L2r/JK0F7vzpuXZWMLyKpBWG8pxg+8IODu827qXk5r31sg0XorDFmdEwP8qp3aUnUUPnkYqBIDz5hzwwdyhVsYHfp6ceWxL+jvDbSgTLr3Sg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5830.namprd04.prod.outlook.com (2603:10b6:a03:106::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 00:31:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:31:19 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH V2 08/12] nvmet: move get/put ctrl into dev open/release
Thread-Topic: [PATCH V2 08/12] nvmet: move get/put ctrl into dev open/release
Thread-Index: AQHWf+X1edjVMuKng0yIe5i9t+L/Tg==
Date: Wed, 2 Sep 2020 00:31:19 +0000
Message-ID: <BYAPR04MB4965A02439DE8BDA493B42CB862F0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-9-chaitanya.kulkarni@wdc.com>
 <7310435c-5341-d95b-55e7-605c0dc7130e@deltatee.com>
 <92a8029f-88e9-abbf-a30a-a339df3c6dff@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fb32cd2-4841-45aa-f720-08d84ed78324
x-ms-traffictypediagnostic: BYAPR04MB5830:
x-microsoft-antispam-prvs: <BYAPR04MB5830AF2A22E9206345C84160862F0@BYAPR04MB5830.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uI0yzzlfiJg9GwEoIaTAZwzFgFwRh7YRaW0QIKe81Aok0ssL9Q6uLT80EwHr/Cs+cnSBVn01bbQRUj6FkJnOf5+MaunAQN3eLAdSBifk5SwutDBifPgyXAQYPxhsm069Fex9Hx4SBSASj8KviuekYqLztSx9E+sY+Vmhivzy0oP2dVCRFrdYk8pU6T/Zfff4pvOwTYgkEJl6NrLUXBuSOPO3Jk2vlAkDcqsieQ5gcTQM9ZJ7+o4f9kNHHgTQupFGY3k6ms/biBhr4ogZzBNAFqKGe+L2XyDbfbOzOhjLigq3n/xNgPeXzOz8uRWpvAx7El85ootXad5vtDTMlwcXFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(110136005)(54906003)(316002)(7696005)(2906002)(55016002)(6506007)(76116006)(53546011)(9686003)(66476007)(8936002)(4326008)(186003)(8676002)(33656002)(5660300002)(66446008)(52536014)(66946007)(64756008)(86362001)(4744005)(66556008)(26005)(478600001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: IXkzbFNZ1s9xw5gZ1qMsWhRZuUcnTHq8KwalToAEgHXPfxvv+HVQ24XgqVs/sTjkQby2zqRLoN3CDrkI4oUeWyRyB0U8fb+uHJbpBMg9WVCIahJnw3icBwE//mNMnePrLHsKg/tLprf90hq8QmCq43qfng6+YYSvFkMsnG+gmsRfCovFoMMecsi5PgdJVzXNXaGYUggQdhPOi+PxhNLSXg75CJC8GD7tEWFHtU1HCgQJdcXEGww8074fpLzqohbceMPN0PTQkAifsB6AofVK05NmiKaM3BeIhBevzgmueQdziKNsJ3OzrTKdGYvoLmb5Z4FsVjB4+/9Bl6bp7xHQw+JDxkvh+dpVlcA4OeXLwPgOxJkl56xM+We40wEBZzJv3E2R3fgQn3jCzlRkA1sHswmJ5mRDFQyWgWNim36bSktdl+dyAUS0fCB4p2WoNhFdQvawMxg1NUX2QzkqaNxH07jVT8VVnqEboUCTfpYpVMZd89L/ha2qhiu92x3VEfyuGFetpbmuPv3HSt2sKLUBjCdYyWPO1PYaInFjIWMYIoMrh9yshKJ0jERrbGNScDiyXHiLDH+JBML1NAhvRH32sgRETUUKUhW1o3F36guxz70SwvpslK7OVQVvqlds97JeT7J6DQ8264I4K5t/24cLiQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb32cd2-4841-45aa-f720-08d84ed78324
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 00:31:19.5989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UydNLRlTjThH2wLTtlAsVFSa3vqzNfjM62nH+fuq0ioHT/Wc3Y4DOZEsvCRMFP+On2Bjuaf3S+AEXfRSVPAzEe1xkwzHd5rel2Wrh7AeF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5830
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_203126_250067_200A7287 
X-CRM114-Status: GOOD (  11.29  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/1/20 10:18, Sagi Grimberg wrote:
>> Seems like everything above this is necessary and fixes a real and
>> obvious bug and should go in separately, first.
>>
>> Everything below this is rather unrelated to the bug...
> Lets overall split bug fixes from any enhancement. Bug fixes
> should go directly before we handle enhancements.
> 

Okay, let me re-spin and we can continue the discussion.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
