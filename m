Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CDFC433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:48:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AAFE60FE8
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 02:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAFE60FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=je9Qm4zWb8ThVFHSRlikunBuqLvqgXVESYXeMGcELQQ=; b=EtLPs6Zj36G8PvwkwhQ33azWF
	5SgM89VEi9XABtWwXHVAIpL5XSgdIsExecEhwHhRNNxGkcmapO65wMgeUUKuxJHEXNk9KGBlmNmW6
	RzaUzeE0R/Yl4pAGht0fkrPpWu7DADwlbKZCWr+467/5grUmM3EGPHmR30p+0V/ZC3sKhuWxu6zFK
	5hcsdpPEwZ2UUSwCN3QiK/vTDi8Vu5efiXWX+/uWoW1IzX1xUDRzgSjdudcyf3eP3ssd5lOwKOxVS
	q5DOvQngdWIGXQwrYfC2TbxuyJsTaRydO4Kl6iPJbK9tWfrnyZjovUtHf5oAVGwnmED52ZaHSe5S7
	CCR7ed13Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUhCF-009l93-OJ; Fri, 09 Apr 2021 02:48:35 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUhC9-009l7k-Ku
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 02:48:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617936509; x=1649472509;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=iiAsMmjzyNN8jrHhXsokv8Q3Vo3U1Jhu984YabgUMF4=;
 b=Oi4nU6MQMcY9EtMhzqcwlGK4T+zSgXcvwy1vKsqbkQjV0oyq3Qx2eddI
 vjf20nPrN2bJZAUGQ3KUp5GPKl2MatcW4S4O7BeKQToInv8xEKECEbWi7
 uBMe53JIMlzO6M1S0xEwRB3M5CjlO/wzw6byuGoKnE1OG9Z38IcFeuhQT
 jHhCoDCmKPRdjUapgaS0O0r0yh5fGTVAqu3AdFN1DWwcE2eVSlV1/wtaT
 uIIZ5LnxTmsRRFcWTMlyr0qxTZ/sigNf8uDmqzLdYw1JyUjAoKM3KwKsQ
 hAcr1D3uxwaakgJ8XzLRHIGASrp4S9KzaMnW5ch5ikGCbFKnqnWtczfCv A==;
IronPort-SDR: neMMLtT+sQB7eNoTroPahlM/ENVM2A6b93TMSpHsnJ6LEoiwDBAfYCFhLs8fyeHqxTcy1Dr9JI
 LqOcHVf5Or3+H1OwJsV1B9I5zLl9jpswa49rFIK5ttArfmabILGvgp9fBG+Eo1ozEw4iQUVQPv
 /zbc+7767bhCnU2GtNVfRgRW7W0XyuJGy+yUz6+KsiKccs/lWEq3Y0COYsUNGMOO0NkuZDmTKI
 ZszVad0aMAWdEzV9/5Xp3Wt6y7/5nJqrk6mtf9C4ExNq2eVzTr/6d7FODchc2nERCQ1rsBJT94
 QIA=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="163963689"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 10:46:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gi6tcx2+OIZa7k+vcnU8rH6GB4Uo7m3rUQUOdROIjcUBG53iNjShlnUNNFj7Lunx/2ivDTTYFP0HHiz0glFndolQ+wN/YI/572DnX/lSAaNf0uuvirvFBnkpHgM1iVlaSJ2s5dBOCO5vtTwf3d/8fqo/Qi3yNnAk+WFWaLVoieFlwkJlrVKyP8JOd9xELhiZmcc1CJ5y5PMhEWgQGsb180FSoMEhU0AC74UbUy5tXtSB87qd2OFUMBEAEXSXnNSBNldBLipBdDloLnyTf6tf8OzlF6+2Hl0DGhrXocvNT0fJJSX2YBXraXALtrXVR2rC96C68C7lf4rPVOtIgT1WdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiAsMmjzyNN8jrHhXsokv8Q3Vo3U1Jhu984YabgUMF4=;
 b=dsK7MyBlz8T2hzkobuNKMfqkofLqgJDJ4cf2VjbWsG/ogAPFo3EaAJprO5kXA0o8TewlK1ix8gG7COSYjrcLoHbK6dYFpT9vlDOQjtwG2jjw5N72rK0Z9nmygth46+Hfgq3j1bqaY5n0IWVxKQiSE/+2lLgAcTmC83mHBXbEk2A26yht+oQacK4N3KxlMoYT21vLNkV6mMnCyvSWPYYmabibPiVnlko3m/8/rUvj11sgXY3/MgOk+DPlroYJtwgqkhMIjqSw5TwyzDU7eMd6R/20h15sRzNdw+T1r5uFnG8vNxW3k9z+ODiGYxonaZdUveaEHEhHwBzxCPOU+saUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiAsMmjzyNN8jrHhXsokv8Q3Vo3U1Jhu984YabgUMF4=;
 b=geyNwDoQwNDgMIkmRfSE41RN9f/xjvSIZ1KeOayZN3SMzChlcSD5GpGKU1lTaSHNqPahL09uxnIlH9yZxebidp8I1/KSxElzn38IIXhh3qL3JDq/OTrTNPrx01tE13WK7GqNLxTjaZWToBjeuCeGlC8qC+UoXhaQWG7WcFeE5qc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7437.namprd04.prod.outlook.com (2603:10b6:a03:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 02:46:45 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 02:46:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Kanchan Joshi <joshiiitr@gmail.com>, Javier Gonz??lez
 <javier.gonz@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 09/13] nvme: factor out a nvme_tryget_ns_head helper
Thread-Topic: [PATCH 09/13] nvme: factor out a nvme_tryget_ns_head helper
Thread-Index: AQHXLHOnpSw6gjdWI0mzzQkvozx4/g==
Date: Fri, 9 Apr 2021 02:46:45 +0000
Message-ID: <BYAPR04MB496582CF89AFF355FC0738BC86739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4641e35-57a2-46ec-04f6-08d8fb01b6be
x-ms-traffictypediagnostic: SJ0PR04MB7437:
x-microsoft-antispam-prvs: <SJ0PR04MB74373940DCC2B7562D852A8586739@SJ0PR04MB7437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H8Tst9PXTjBMg4klbUUIPy17egQs2RQ5xwypDbtXh3UBlnxFenPXyCFfirsCPQQhZwDL0TcomuSREDJ04CS4nf8huwXLDnCs/YtCiynuKrMflzjCkxyZahivwWp8/RmHHtRH+MTceGzs5RQfyxBwYhpgGRnZlL0+P1832vYkoPrH1iCVMKjE6QKya7uUjiWGEEeHDaUTeU9FvcRqHExvUNzUieDA8yr6BZSgpmSU7OpU1aYbd1vwnDbS9GRCCZ6ANOrxtXIwlVfyMZzG2U/vPTYUi3bVMZQl2dVDwZlRPxoN+Iq/dV4BaXd8tMJ1UtD91cg2wMQoAehjtphqdoFQ+ot3bHAQo8TmuxyqyzGn5Fs0s14rhk4G+pcUOgIwfGCcksSA781NEla4S78OPuxWjsnJjhVT2VJ8f80y40zqzaiGiH3qRZK1yqEfYV+NNdNNFt/b4u6fY9gygidx8iDRook8QIHpfxsSLSmPbOaWgyiLZ0VFoltSN5HLmmTFWP0o5+bZ9f0Xnjj6TwqLXs6ZZXVitfDt5BoP5Gdpawmh3v4pKb6IzkLBUu0OCow4ntUJ0hLeB0c45O2S/3jXoi+eU8x+Th+ND1tAmIDWUgy5TS6T4I/3KhcbT8wENHpb215fsweF4PF0LHEt875Cno/VPheGnl33G1ALpLPwnBbLWMg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(2906002)(52536014)(478600001)(53546011)(6506007)(54906003)(186003)(66476007)(66446008)(64756008)(110136005)(66556008)(86362001)(66946007)(76116006)(8676002)(71200400001)(8936002)(4326008)(9686003)(33656002)(55016002)(38100700001)(7696005)(558084003)(316002)(26005)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+tMe/vTACzVl3T7PVfJuWTTAfOleRLuP99PV5SyFKp+WI93Q278lvzLmonm8?=
 =?us-ascii?Q?S78PmzHfnycBFMsPkvmdIr12sx4sMHs5kemtVoN2eHRvOvPUu2Dc0A9CFYxJ?=
 =?us-ascii?Q?0I8DzYXHyvsOiYb/Q3FEvcTknznEs3zdw3UJlhyJVodhVgkQJJw4tJHYKXgT?=
 =?us-ascii?Q?xUYiEPnqqkS3lY+LUrFI7F2y7xGqqu7uSSfmg4oUbndvh7vFcOm0vU0/Z4N5?=
 =?us-ascii?Q?/YnaH6/3dcyfB7bJu91R/5VcoFO0+q5bdqos22421Z7yt8vHz/cofaC9P7Uu?=
 =?us-ascii?Q?ScTRr18jcZJY71otw/pZGOFSEAM682F9CQ0+r+rXzP3TWvbfhYnJsst4Ah2E?=
 =?us-ascii?Q?kEtjUFKNAMYaCoMw3eW6M3mWRY2umj03Ojsn+muVxmLxm9sMaJAr2jS6v0I8?=
 =?us-ascii?Q?cBXunfOjh2h/hAmFPjUhuqH9a62erMdWLe7/VJInf8oPkVhaPEyKvzRnRdV7?=
 =?us-ascii?Q?J+Kb2q6aVIq8YhD4zGywNQZxvQ8wT3S8CmjgTLv0q+1qT6FL4khfUgx60b+M?=
 =?us-ascii?Q?IYc4rRJ4VyrosevEWqiVi0ZYv4OqYg0qdPfbeiKjI3psJtbtv79PJuw9YdJ5?=
 =?us-ascii?Q?nDR0YoWpIOz7X833R0kRtX0NCbdsYdZEAHT6xPsSDktUxBcWtzt1X2qFGP9j?=
 =?us-ascii?Q?sG5gr2V7EKpw0X0uknqq+UgBF3jqEOiTCMxIKVQAP7zutUi059/3rOMK9B79?=
 =?us-ascii?Q?GxcONyq8yHZ0vkhPi4gBBmSaiAa+D0ZEH2rKwfEZcOSSFSik2h8nrWEMwNuM?=
 =?us-ascii?Q?Ek4QA7o0VcOQ1fa+PE7BPdzwYz7eX0n4Aar/21HFUJ4VMfrSzg7oofNEmL5o?=
 =?us-ascii?Q?15RdxoTXH+jNynyow0Qqutx3zMs2d9ITOq4KQdVyFuZNDzbtY0fYmy4ByngU?=
 =?us-ascii?Q?N6M6eSrExC/fLlVunmfDaQecDm+OK0Sa9Nnf8FWTYViAPl/CNGltXgmdToaT?=
 =?us-ascii?Q?ppgSaphhSADe3jwBlh9ySRPvmvmz9jK11vPqpHVnpr6lg0DmcRXYxYj2O1+v?=
 =?us-ascii?Q?iTypARuhzDWRC7zuCwXdUfv9nNpIXbuNdH3P2WvEDiMFl4/jldAN/yQmqBIm?=
 =?us-ascii?Q?QgUHO3Gl5mpOfVn8iF/Wo+e5Lc9HOLtkwed7zee2goEvHzJZstZzT7lrWknk?=
 =?us-ascii?Q?Q/6VUlwL6JmHhCdC36/0dZMfHBe9uyIW/NrBx5bamNo+ACsuHBGpApx+g4GM?=
 =?us-ascii?Q?shgNLEu+UgSe+0sIvIhSaeZ3U/YYDQij+kQ3klr3pzK262x+p1y29F5eP1wA?=
 =?us-ascii?Q?GF2bNv7e5c4BI7Uj1Ifp+p4DnW5ZO9seqG/IvNbpzqoGLIK9ahIJONFIv6Cl?=
 =?us-ascii?Q?K1JhsBoZUK2p4JOoR4sMQe30NGaItiSgZhZ1LJp7rycIYQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4641e35-57a2-46ec-04f6-08d8fb01b6be
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 02:46:45.0691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1R2ZWDO7knEcWMf9xRXLPDOEZKFUtZ7t1KwqHGAlFAk4NELELupYaaX4kac+qpH/bWJJQCq3BcFm0NQ4KKrbWABAT9OjuwNJ1E59J1uExY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_034830_044439_51BB7C88 
X-CRM114-Status: GOOD (  10.62  )
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

On 4/8/21 05:35, Christoph Hellwig wrote:
> Add a helper to avoid opencoding ns_head->ref manipulations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Should we wait to have a second user for this ? unless it is there
in next patches in this series.

In any case, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
