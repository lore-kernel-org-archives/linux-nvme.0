Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B290C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:09:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B3965253
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B3965253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=JH8g9xnkigzo5/pwmZhiCWP6/6AvoSi45HtytSTgYio=; b=PD7IpceWqfJiQ4eqOALf+nM8Q
	9MtbSoQitgTAIJ55xjjbnCJ4kDkEUvzwJtVK7xRV1hbZt2QaFCxtoJozvpJBEOatF5M8pzREbR2Dq
	1uMTc0LfQte8KlPRRadZs+UV3PMdQL1gNjd2+3E19htVmiRmKMmSTiTDcVLmtr1ZmUnF7LWpoBBsA
	uWdE+V3OlA6Lcz4YEnv1MrQB1onZ26fSQzVwxcdQU380k8xp3qFVTdzBVAh27ByBJ1LdmuTdZ80FP
	PfCoZZ9ihB3SDGqsPdXeA+sjsaIF8KVo89V38/6/45EPe6XAZmUvoFJ1z/iqWaZVOpf2jys8t7zlD
	qzIiRIgJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJjbk-005PvX-A0; Tue, 09 Mar 2021 21:09:36 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJjbe-005Pv2-80
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 21:09:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615324170; x=1646860170;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=cVajOilTx5WcaAjOO5iwXPSdxyo89a5PooWLwuUCgyo=;
 b=TqaJIxC4bsQTFdS7t/7gTN4Rt4qLJOqxzMTTV2UTy+mrCuy5Afev1Fkv
 I7PJBtYCDhFZsPQAahRcMnmtZbrtu/BbqMVdvBXZAzgcDgdas9AuRO4hf
 esVKu2cCKJDjmNvi01z5eT/8fesWJdahcpZZwyBOVwaDjxeM/KyHyYpjs
 J3Lxoxh3YeAFEyL2hxO+bPF2h8GdLQdietj/cjSzi14McUWia5gWnabUU
 tVaZbiAZFqC9V2NbmNyC9cxRmYWamG+jH2CI/CsuPQqcY0bAGdESuJbLg
 MwhX2jV0tF0LYjsTFUYaxHoLBgKv04aXG5Utrp/ojooVD+Oz6p0+lMws1 Q==;
IronPort-SDR: c3Fhbdh8y9UGD0mPQv/JSyuZYmN5go3INcx3INC+xr3vjDheE4Ovw8lU1Jh5+oKCpDeVsLAJ/L
 JBUak1VRlafFr89L1iQgUP6TfAv/ClHJw2od/XBavcO16hd5npamCjRzVEFLyiIX3Mz7FvDEdt
 /6sGH2ivrwpUjP+mfn92+C05UsJhpoCGIrZ32wrNC3HJwy1TDe3Ui2IBFqiHcJYnVF4p/SHSiP
 aoAbXZnLz6JPhMwZS+fHkyfqIbR1m20mNEMFxSmNmXnrQE8xBIm8Eofecgv+e/BJO7YKhLs8H9
 3nI=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="161748217"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 05:09:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXPDOgk/SVjHky0unneSsfXSKzXEapZPTpGlUjoapDB7zIFSn+F2cq4AsEQqwT/8TKuxeU/v8liYm41uvTDziCr7T+Oz1N4C7Xn1xU5h1Cy43mAve0Qx4FjSVioPwm0sdTTYx8XrYTuvHeTUovvfP3wJ26p4qNtow29GNu6xjn06ac5oeC/uRhrDKEOeTKXRjy+jRUSyAyJHa+0m2jhuP1Eo64MkBm9HcfznP2gWq2yGcwItbfEn6WiZNyZIUrQkSRZS2UI9pVhOc4RVt+nLDo6F0Qs3Snxfd9E1sNxJ8hlNsLjTfgL01BdvN9TRsDUUFyiil14Ix0wM/R1J4wBSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVajOilTx5WcaAjOO5iwXPSdxyo89a5PooWLwuUCgyo=;
 b=OCkE1Rc/sKrbi4WVWsIVSxF563gr8DbYAZwJLnKlr9qMvtqbZzlZmrNOzwJgPTgPnfjgiZUXgg5rxKiF1cQy640UomE5R9KLrbNAMH07YJdgNm/Jg2JGpoRCcIMnu8ZRQHI05o//kBdFmCDG2yuveYIlyX6nFAma6gqEnarTBLAXgjNWbcjKfKHEduHyPPVMSOaQRBOtkswibDF4FiQyMGZD3ZEYPKY7eX35iQCbnXbLmIUL3HuRDHl5xiXzJmAXCLgJe1oPO0NeYeLXkgL93rt5vuFa6PxUOvcHQkviIK/Fy3VWAzXXyk1O2ccScPj9/39ZCizzcvIuG+0gRY1cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVajOilTx5WcaAjOO5iwXPSdxyo89a5PooWLwuUCgyo=;
 b=TaA/XlT4fmhdMj2zsGjRD2VOJhTd+3hmmBf97efn0aHJjFQUlPLM/X5uhTW7gSdi0zx/ELVXUn3ZnMoxJ1tCpC+UNo+RFdehQDi4l3OjTcX0YmaZcs4lngp/BatWrZN7eI9mPgYkXwk2sayMJFMNT2nul6sP9y5gVYx0gLrlros=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7744.namprd04.prod.outlook.com (2603:10b6:a03:32e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 21:09:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 21:09:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V10 3/8] nvmet: add command set supported ctrl cap
Thread-Topic: [PATCH V10 3/8] nvmet: add command set supported ctrl cap
Thread-Index: AQHXFKDqkfFBzzzlLEWAOuIWvtRxmQ==
Date: Tue, 9 Mar 2021 21:09:24 +0000
Message-ID: <BYAPR04MB49650F49B235C7F57D38121D86929@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210309045823.18545-1-chaitanya.kulkarni@wdc.com>
 <20210309045823.18545-4-chaitanya.kulkarni@wdc.com>
 <20210309113815.GC9520@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e43451fa-0ad1-410f-badf-08d8e33f9e20
x-ms-traffictypediagnostic: SJ0PR04MB7744:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7744F628F7E6388DA5998CB686929@SJ0PR04MB7744.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DAbSJtCa6+NrSYfjlaMpHjTrAMnGIIqSMAXRf3R1K9BUhuneLNb9XcgsLmYyLSTGZUgtHT4jSyjEWc+nTsLJEspOs47EP608n5r2FOT7Phbe+Rep9FecwWAakktQxvLHNOFiL3xg6Nc/SgzHMN8XKBdliqGqwpXamS00pg7Qtjw3IgFTB19OGGmHxBG8cdxWdfm0Dxfn8PD2p6npACahoeIswRRrzk62JnMkf+4L3xLapKJ7b/EN0ojB+t/J9JpcvmkSMTBwuEV7azuVMY7zXMVDhrzoPWQrUvdgiqhXsq+/AP/FIXzFS6mbzqrIDJNaWsJ4nSFheXMGDcA0pdW17umKkjGqyStj0XnM83QWzfp3VmAVUngpegYa68obDR14mBsFWNygkLRoIH93y0rDRqlXydUe1Ga2yKrDRcUu6WpgwKRZybqOUF5z2sYoghdE2YFUo+QTV8PhXrFD9HKt4kVC91Y5kNUmh0d4cmJuNBqteOZxTbx39cUraXOJ5BsudYExk1yOjlhLFRW4a0RaKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39850400004)(396003)(346002)(376002)(136003)(86362001)(52536014)(8936002)(4744005)(66476007)(7696005)(2906002)(55016002)(5660300002)(76116006)(66446008)(478600001)(6506007)(8676002)(71200400001)(54906003)(316002)(53546011)(91956017)(66946007)(66556008)(4326008)(6916009)(9686003)(83380400001)(33656002)(186003)(26005)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3sdXehiaZGhIouf6qFhSo570LSgrWyVSQRu8dRELiXRuW+iOXg7afqLqEcAc?=
 =?us-ascii?Q?F1702RMS+A7Cmxzy2DuEekjA5tXpDWQZp84HaReVqceiLZ0igtNCOkVCM5+U?=
 =?us-ascii?Q?L2rNDYmUCBXiNaEZzrjQCZ7uOaXAkZt25F+NlPnVQi6G5WIOB+lxoyBbakqX?=
 =?us-ascii?Q?FTqhjHskuRWGzkJu6YTOhFLJfho6iZEZxkTJ2CH2hfHNnzFXMf6UWZDkirV0?=
 =?us-ascii?Q?/lI3doJgPwUszn18vwntOaw4A2Pqk7+WxoX4Yj1jQCu12y+rWI68SMsOcBwD?=
 =?us-ascii?Q?17518WizTzhHRwSy0WWbWa8Sf5XVp+vdsJuQfYe7DA2P6HjkoJwQzBz72yM2?=
 =?us-ascii?Q?GPQo4BRv6+MKqDfIEJ2Ok1U81/tHtVCT/XexHGJ660005JL9HNDKwZeqBLG6?=
 =?us-ascii?Q?m7xQlnzOPS9EtjzpGIvBLChEqx0TLt9G/AS+WsT9Rm+aOlDMwL33YCCe2Ndk?=
 =?us-ascii?Q?94XKJFQoxqgNLTjZTQwaPkQmvKnHzT+7InbwcawZgwZQWiF/fvJaNE1+NDW8?=
 =?us-ascii?Q?1R9+UiSR65hocTjVQWVT9U6B13rwH8QXwpveggPDJxatlLSitJwRtdP3zRqs?=
 =?us-ascii?Q?5fu4MrAGuXWB9YQtIFeC0+Fpj3p/WJzp8aMLEPwoVUpbRbBW9u2Ool9YU9iG?=
 =?us-ascii?Q?3uEWz3eilAmU0Kwv17hsXdjFhwdHIdL0eYS8MG2nu3q0XzBkw6zX60MLqr1c?=
 =?us-ascii?Q?AhBNYyI4fAReyGTAKGNrHV80wKQTggzXZxY8880HhzPuwEduKcEdNnWeooS+?=
 =?us-ascii?Q?AXaj4TkKxptKlXbvSAx+DE9JtHcinNsQ9F+B1Y8Xp5mkPXpBPU7iZ29R/bLZ?=
 =?us-ascii?Q?mimrOaK7pW/zGzs3OnQ6rTwbC63PHkw3qWOWzCRHmLfkili1AMF+KvcQSVTB?=
 =?us-ascii?Q?dSOGcph2Unqo6vvilIuNhiRmYUzM72ZTylC5MugwLLBeUFHHUxUGu0zYy93L?=
 =?us-ascii?Q?r7jaZp5GigcPJnMUTAvN/Z0s27E7BVY1tkTF3JHUwfgWkgioqpp6CkIeINLe?=
 =?us-ascii?Q?AYfkIH2fHyn4GHHiXmJz0wMPgEIedTVpEo2NjX4/qqHOwL5Hw9twXXkTjYnL?=
 =?us-ascii?Q?iF6ty2pLVyc0YpENrJHGWaguwhosD+HAhlnUxKjPBuVUawvodyStPqJqhspQ?=
 =?us-ascii?Q?tOJDNN0ny1w1fC1SWndFFFseqqHpl3GpGgUg6Q6S5eH01K1wuecJ8n6G6HIQ?=
 =?us-ascii?Q?UoBnItOd1Scen84r/mUELhbkk/lZbnAYJnaQ/eSM17SOPm14rqcv9X8QEZXa?=
 =?us-ascii?Q?uhvanfnRHIBVmBykxAbdudUpJsvtDlbQmS5SIaMObzyzw5x7/23zdbYEC1tF?=
 =?us-ascii?Q?MzPxsnlv1QfEoZ0iUtDGyxEz?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43451fa-0ad1-410f-badf-08d8e33f9e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 21:09:24.6945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JuxmlobF6Eg4aNSn0DkSX/Q3p5ON4D1VDvYW013HVgmcvIISqpQvm+UgfQEEBTrgJfW/we0RjpSZmUwEjmK8bFOmfrqNMTal1jgJhYNaqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7744
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_210931_805934_30D2CF38 
X-CRM114-Status: GOOD (  12.39  )
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

On 3/9/21 03:38, Christoph Hellwig wrote:
> On Mon, Mar 08, 2021 at 08:58:18PM -0800, Chaitanya Kulkarni wrote:
>> Update the ctrl->cap register export the Multiple Command Set Supported
>> features support.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Looks good, but this is part of the CSI support, so it should be merged
> into the previous patch.
>

I'll merge previous patch and this one minus the ZNS bits.





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
