Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B358C4707F
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:17:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A74611C9
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A74611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Arj/xSH0W3NL1siA8JBhzIwSAQ835/m03AN5D1K6Ehc=; b=S3c0pImCMt8Rsp
	5Nu0+uF477AAGYou1b5naYw66mKClqZk3i97rMGgjyHG7Y8uyxp0vMXEqvc7Pyk5hAtoTmBsmHqgU
	x0oymbPqkcHLfiC2xfYn24WDG2mwV083Kb00QuNAQUMD3Dr0GBzCim0ntsFkTUNAfR5pS+5YddHRv
	NiTLzVUl82VfQMe/IKAtJqvnLNipDHqYFK4IpGbo7q3l9lWvabLQxB3633N2CdtKPFSVB4TQIxvPb
	4PMtgAufX1ZL7kscy1mvqcIoS0daMVddT3EU17f4Awv1Co7xMgeMfpvG+SHJepq3C7XisVjRN7lRs
	lWdiHUlze6eLYil2E71g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lldUj-0082Zg-48; Tue, 25 May 2021 20:17:41 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lldUd-0082XG-8d
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 20:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621973853; x=1653509853;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=VPq7cYPOZwbJqBNhXmM/CqpmSSME8YihLD4a0tBnrxg=;
 b=Fev0+eFbB9DVlwk/yoKIlevZeX/IaH2XkDcGey+1ICi7AnodzmohEBvb
 kImIbj61RGxRkSV8Eiw8gwaZ/lPUyqxWanEbIU0ahBefKSGPdOPbGBZ72
 IwDCpu3WXn54IZELYZMm854I5s/WnUS/EbWiJnp0cazf2sgqCIh5o6904
 9O5AU+l4TtEeCQGeKh9TWcEkqjLnooxE+8FooASH0HC9U0mQm0GXfmf2v
 t1AQczi1NsgDY1k5BkHxmYlDvCQq++RUYShzX4+dT5X4IPkjujnG52JHW
 LHZVbQtPOcVxMOhuo+QKfH5zrLKsrdW55ak78Y6csMTfjbDK5vLrRNxj6 Q==;
IronPort-SDR: YaXJMVdAOd37CU4VBlWu/MwDf6fCHrkpi2JS+aFXcFpoqqi/VuJGFlNCwD9WmTlHLd1ovL51oi
 MDsUHruLUHTO0Fnv1+Q1N7Q/9kVWFhf5yqq03hYPsCo9cKypzfKOIGK8/1vnnXhHqEbfBJhMMU
 Yu/9hfO9dTGrZfCQMVD+uGNMnR3ae9W/pTqo5H//XMqyh3QGc7H4V1D9iV9r3NbqjwVWYANJ8M
 34iYbcTRivrOOBJG7Ef9qoIK9fvOv1OZF1p95BWQE4DlZiaUtRJGA5m7WgXpOTTPC/NxXelRei
 x1A=
X-IronPort-AV: E=Sophos;i="5.82,329,1613404800"; d="scan'208";a="169403620"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 26 May 2021 04:17:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hnf82CU+emqS7VmzxtU/3eYb4MirWjK19u1EWjP1JFhzh1ZNfKejPbcH35OYNeETx0zCH9tZMCZVsabHgen0sSlDIvobHrFqxlqsc8GPrOEGiEzspU9U6JNxOzkkL85obHmOl5jcRTN4bAJrysLhMdUOOFnoxmC9L3BT3Tni3MDf7F9Ri4MVDh8xl4XxFzypBhit4m+FjYIgUZudtKW42NI05owStCzg1tnUXvVazo2AxMtJK9d0t/yCLP0RyQtW2oHL799zXFTIIQAYEuBBq/ez+W3AgPNLVMMpvRiTBhvnfS2OnZF5H3crOC6dKI702Pcryn6OD4von2vSgtZzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPq7cYPOZwbJqBNhXmM/CqpmSSME8YihLD4a0tBnrxg=;
 b=Xo8KPbnI9vfSh+avGsdI1r9HDJzDu+Jiucef0nO8EVO6aP9e546arVDSt881m+W6ObX4yM0W45EtmK5L87OP6Fyx7frxH5PwBG4fTT8Dn/aRvK6NWfobJXmJZ1VWs9AH5JzvH3P1JrfLiafzu1/Tf9dfRYKtW+mC12aNiPovNIJEHIyv7+MsFP2ioemJoofrvwump7hBLBKPqSZV/gO+pau3SF2/w0pwd4OzYCodBb11sf/iI+9o0sfOgJHCbVds+Mod6vLuo4jBPsJj8u0QXOE6e7Je8nje9bMY4bcdGyo8HfEqUovvj+0uGOCcQ5EMOjcAMX1nFzUZYg2Sb7YSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPq7cYPOZwbJqBNhXmM/CqpmSSME8YihLD4a0tBnrxg=;
 b=0PPx9rfZmtKOj9MpORiZ8MJ/5uUwPfUcd7xjQ5QCJhuWdfpMdHljXgHD1nsLZVZXAUu4IQMBsmS1JaT97kj7/Dp9ZABGFXdopv5lYnr71EEM17ZrA9QvFHUmpZTbh2d0mWiW+Csa9qCeNlMh9bMRnn0ZiEQAYS295cUBNbuOwhQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 20:17:31 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 20:17:31 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Have NVME_FABRICS select NVME_CORE instead of
 transport drivers
Thread-Topic: [PATCH] nvme: Have NVME_FABRICS select NVME_CORE instead of
 transport drivers
Thread-Index: AQHXUYWMIBMEpQMC3US3Aa0hW4fp6w==
Date: Tue, 25 May 2021 20:17:31 +0000
Message-ID: <BYAPR04MB4965856C617D3241B499EDBC86259@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210525155946.2249322-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c18b8d6-abe1-4db0-814a-08d91fba2039
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB6884121E8C65F695F95EB96386259@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8nhmh7bHIPQqRs7B/jaYJaBOsDmYWAFT3c3o1EGeIulDnSgNgLINmRC8Y/r6ZQLRr0vkFM9dqffBrXcochTP5do+B8GvP7nFPKQX5ygp44tmk6kFP0hPCGL4fYxrMq91xjEbqDN1kbRZ/zir2Z3PD31jj9BaGtWfU+fF0YwtzSP62C0zF1bjHcKRJMq7uw/qBuUMk13TDrz3YyDhG2Hj1yteaAHvxBJZQJgD/iMYpXukIZgrf0Fwmt3lg8SLwCqC1MGs2F3Bkvt5M5SwL0gUHp8GJriU5pHqy3WOQX1c3Ejr4I2ySjK9EltEywEis6+XwqRB8sEiDRVNMFCh1jePVIRn9sCjIl1bsySFrfd6Oed6DaROvEoexbCmnr3egO4T7yk3QIfngk1OVjnpCKDRtG3UL+kW4w1Ie+/+lIweHWO+OrLuS7s+SGGuwU3fT4ThZKKTBB9Waq6HGSHceb36cbISgatxBVBT/AGrrHKD8sLD/zVZTZ8vaktGainSi33SdRz99UdBnne8t0fkpswVkTJpT5HnioNvQVOuPqQ04/wfAbvkFarW1BlMvUeimCTcRWNHmNfCjEULMhPNWjgC40+yGx4W5iEr3drgf4m7tLk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(110136005)(8676002)(478600001)(5660300002)(316002)(52536014)(2906002)(86362001)(26005)(8936002)(186003)(71200400001)(66946007)(6506007)(4744005)(76116006)(66476007)(66556008)(66446008)(55016002)(7696005)(9686003)(64756008)(38100700002)(122000001)(53546011)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/qJEP3+fnDbZ6QHfbfqMh0ePz1tcBVac1te1Yyr4YmzZGxpEM2PXYWFNQiIa?=
 =?us-ascii?Q?6f8QDVJrRewyuujjjWkDoskrGzFiuKmgrSQ3JpwGg9ZKXXP7zf8VqxCuENds?=
 =?us-ascii?Q?CqYNiL8Z8KMnEHgJTBdTRsAGRaF+IJ/SeggW5YfiiUOsdindnHUYcudDHi74?=
 =?us-ascii?Q?sc2A+BB/zbsoDJBpMlchO1R2ZcoCFmT+KaEIGqhOClVM0CkOf4BexTt9Tkwc?=
 =?us-ascii?Q?0Uvbe6XgbO+tn4OuxaKQsmIr2Qqcy78fbzoNMfksEEKJd/Z6/WuaFbjSmBR6?=
 =?us-ascii?Q?pkfAOLPu0CF4rU422IaBU66S5nHTBexpDQhLKXayCHSgwlZJzYgIgdXnHa3C?=
 =?us-ascii?Q?pMLdbCB9KeNbxLczWdNLmz+jlg+oyFDGCl7d+f6GVp2XyZPd2SO9L11Y1HwL?=
 =?us-ascii?Q?hCJ5w7X2DWlh4q0g+7ckZGjOQbut1q9caXDJfqwW81XwCPskwZadJGG2t26M?=
 =?us-ascii?Q?4vLv2FSMbcMnBdSM6aYoyxpZrKoqXTa8cTdYnoewoOfTQsbai7mH0y92lncs?=
 =?us-ascii?Q?LI2T5kacNXKyPJ6i8FOV5VLcwmyAzZFimEaIw8FCGkgu7ZeaCwpIozulmonO?=
 =?us-ascii?Q?+rAHkDC7oAD0KAtrTtd1ErDijH+fYGZZsH9nPytL/bD7P/bZTnRKxoCHIden?=
 =?us-ascii?Q?HXrk0iJWGT3J9zoif0+pOXiPkWxlbAJgn1An0wCKnOdheoK3cDGYVQVpuSfP?=
 =?us-ascii?Q?kVckKyp6DDqajH2WcV+e3tPrLOddVHNFbIzuVTt06ESre+dpqdTJJnToFpl0?=
 =?us-ascii?Q?XGQpbpYqWneFxoAEhyBHpt2WG0RUD1eS7Xbb+gWs8aKRewrq75vFTsaeEJH0?=
 =?us-ascii?Q?nl4AUlCTm/fRGb/rJKnN9Srgqka1ppOqqfCWTT8beMW8sF7xr7X3AcEskU6f?=
 =?us-ascii?Q?G0KSyGrwbL9xjE+SiNV4lNdbobvVmdiCdp1wppdWfSDo1sL7gtFj0DbdxE5B?=
 =?us-ascii?Q?ZRFW+Vo7++lQs08sY5TXlL3rYCyiJtfVgppZc/uJ6uC96HoITAiyhEdxQVQl?=
 =?us-ascii?Q?6MC8u+xvIljE5vZAdLC6eZnPCnVVcPE05yZ4xtClnuADX4RWPd3m/JK05hWo?=
 =?us-ascii?Q?eejoJeQyG39M5s9rdQcUo/vS8EuecokZttdXctaG7zx7U+yLRdb8ljGAdHXR?=
 =?us-ascii?Q?gRWQPplGo5nrbI8q1lONhnV4iuJLR1NhwwlKIOVC2hUQcXjdF8u+lJFnq9bb?=
 =?us-ascii?Q?qMg7DiIuqrfNOLUIyR8Vm45sD240KQiW3M2QWk7DIa3Z/9EMc6PdFyKC+N56?=
 =?us-ascii?Q?YFu54YwGycVwXGxcqbwUGq5+RLEgATOOf7e5wwvLNSwJ4QLLFis21sleeo7V?=
 =?us-ascii?Q?8/7lCas0lAu3yXJI1B34FjKq?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c18b8d6-abe1-4db0-814a-08d91fba2039
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 20:17:31.2754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UMTIo7mp7drA7Dpi43/3KZKVXOUNQ1YIn52/fJMZlBlQs9yUfemhoMh9LEwwJiG8mdQHZbunzh8RQA/V7b+CLjh6fU5PRxfSTBpXR76fqlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_131735_384715_AAC52848 
X-CRM114-Status: GOOD (  10.07  )
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

On 5/25/21 09:46, Sagi Grimberg wrote:
> Transport drivers need both core and fabrics modules, instead of
> selecting both, have the selection transitive such that NVME_FABRICS
> selects NVME_CORE and transport drivers select NVME_FABRICS.
>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>


Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
