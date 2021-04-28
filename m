Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A57C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 15:45:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D227608FE
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 15:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D227608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SiLh8SEsURhPvx77BJ1nqmLlGOiKwW3USLKuqlBjlBs=; b=iL827MsMAlOrntRZcBVh8hKPZ
	N/vhZwozuRad+RiBaNcG3NFwqyindjoyX7v4nir9HILJPdn7OKizukXUnXSNmoc4FvXMQCRl2wyxW
	NUXjCOrVxrwxKLBPxvlaF6VDM2Uv+uVWHB7A0RLK6/jzo0SrfRA7nFBdcqV5rpULU02/kOd+wDX/U
	2AlGrsfOWPQbP3XcCkLVMZ5HPCfdT0tEFx0Nakz3zNMQcDOBFC2qCk5Ychwp5Q4qjLyq1FuKlvIoN
	B/l8EXXKTzPQvy6j/Mjyb8LIu7gWu+ZZeAyYVg2dtBLPffA1h6A5mYK4ps8kLp9Gj22qS5dAeWuO0
	0ZsCswHgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbmNK-003mCt-1H; Wed, 28 Apr 2021 15:45:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbmNG-003mCn-Rh
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 15:45:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=tuD4xyTTVEz1rZP5turkVC6Lhmwsyj8jq8dgK+hJ26w=; b=RqDGlzK7V3RaFe1y8Ms8UtgSMm
 Ql6ucrv3jHiEO8RnKIihlbvz4z8Hnyc2JjxUfVa6QgGn3uHJUB4JwdRWVe26FSYQepWnvxSMD5d/q
 rQz5Fe7rgllMTq++CWFxLjQna5A2YRA15NVcOlBDNG2Bnt/QFQZhOKv5xjhwEjRgqToZA9kAmpXqx
 rTEGe8aSX2d/TIcAib/YIAV7SV/yPEWwiW7E2NFbDc41i+rgvUX6FKb47/6KI3xkmTWwiJEaSLh8J
 KQKtopyVT4ILbQ6t7053gvXmy+KvbUoCm0IA2L0aKj8mTC0OydPYYdrP0VNHtdpMoGs2jSAitqz8P
 2OiWC3ag==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbmNB-00HaGv-UB
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 15:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1619624709; x=1651160709;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tuD4xyTTVEz1rZP5turkVC6Lhmwsyj8jq8dgK+hJ26w=;
 b=YSevg8RYQeWgEq0Bf0ZznYW/fEmfVbJiPNYz2TvawBwP17o2XAb9gv3M
 CIqC8E8wlaJR3XE4fLdNn2j5uAr/ZWpU4CxhpqC4AqTLvRlWJUEhvH/Sk
 iDAu+vqwoNbjf1BSlbXxmCB96SzEXndmRfm5Oq7d3Vtr4qVBSJTOxzBer
 X8naXVTVva0yeVOzo7inOsiuyHtID18wHc2rcgjoFDA9OvteteN7F9jZF
 iihaaGEy9O21UwWztwuacHjVZzunF/okvkamK4RuMnv+ZklqGR0Da8iip
 EOxyqflkKZijysLSVzNzY22+9L0a/lX6SJ7e6I0NsX7rY/BkZen5X4i2E w==;
IronPort-SDR: spHCR3Bw0gmpC1gZNYfbU2sRkcFANXd4Mz3ml7lZ8Tubcp5cTE2yfeI585WpaKEVVKF1byumVS
 WHQx38dQVmxDXgFfel/w2jAO9ACBCeb4puNzccpttTauIV4wN0FQCz9iI1MO+TLBNwK+TMUClK
 YWBY15YkfgdvOYo4ybAOPHTYVrNG4uHBoJ0cTif2gXVNhDN7yyM4K1Q3ZrdVZVmfF5DHLxXVm3
 hEwImCClbWp9M2ZalWafxHA+eX/lMdMD2K7zKCCxCKUmV5jHOoKBTWT72Cfr0MDDb1DvIjTkog
 cC0=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; d="scan'208";a="277568471"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2021 23:45:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT/roWXz2ACopA0SXm42CZm7iqNKHcpHxT3+fzJxciNJ4QFvce4N7toOESa+vkzQqdKMSN46aAqqEET3sgtzUmKcWp+WLWDheCzcMN+zWO40tD+SmBc2BFizHW1Yd7jVxQwdupBARg1pzziibqwQ2cFNNh35XAf3f9tsdWX5BtPvffGsYJ4YOFCyUlniemiPIN90fJnF9M0Urs7Kx6Yoe7XZnoQeF7m/uiVeJFGkGumnyW7PqZ1sd1zthF2e0HbFB5IDOgPO8/FC9SExHnwjLtVpELKcp37tYMy/yBYVpTDa9NTZG96fAofA5MGeYlllm1HfQ21npLOqIvHAMwAf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuD4xyTTVEz1rZP5turkVC6Lhmwsyj8jq8dgK+hJ26w=;
 b=XmbuFyPQ1bcwyhbFRTBChenXeD9C6c5wq1+IUgjU05/O0E/2+nb1ePCFHkUat0+bloLptxmEkpRwsoCodyoenVgeDtG6nirHdMNc9F9y7O23nJAmjJqG4+tmhWGTzvJ/SUtm2gQSe8k+MAkKZruu6SKea/hYNrpnNaOL4HkZvIjyonSdew5EwnTr2ATBG9NblKszm6WUgeukBgEsPCFMpkIJbH81lyOtjSamkRN0Hi0wKtpex5FPIs6/2AVYqFCq999669b8VHWMsFQ41OiPCUIWzXgr9Wc/zsiU46xqfg4zQ3GxbB6+71435c3453LAD7X1f5FWcIhs7kcqbvKk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuD4xyTTVEz1rZP5turkVC6Lhmwsyj8jq8dgK+hJ26w=;
 b=frs/lcRYzYGRCXlOrL60BLsXGBEaXrKftEfqQhwMk7SDD63xOqKSIbdLixYwxBjj/xpFRUV8+H6zgKsFDYke+QrW8Ic34folB6uMwwlTKs3TeXqmg1cVl8vmLhZePwC8imT3sqCQdf3Kl6y24SGf0nWhzxm/JZMMUFqfXTzNzyM=
Received: from BY5PR04MB7041.namprd04.prod.outlook.com (2603:10b6:a03:222::19)
 by BYAPR04MB5141.namprd04.prod.outlook.com (2603:10b6:a03:51::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Wed, 28 Apr
 2021 15:45:06 +0000
Received: from BY5PR04MB7041.namprd04.prod.outlook.com
 ([fe80::5d1:dd35:f322:49b3]) by BY5PR04MB7041.namprd04.prod.outlook.com
 ([fe80::5d1:dd35:f322:49b3%8]) with mapi id 15.20.4087.025; Wed, 28 Apr 2021
 15:45:06 +0000
From: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
To: Andy Lutomirski <luto@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 1/1] nvme: extend and modify the APST configuration
 algorithm
Thread-Topic: [PATCH 1/1] nvme: extend and modify the APST configuration
 algorithm
Thread-Index: Adc8C9ro5+f6h5TRSN2r8FB+X7i/AQAIChAAAAQ8W4AAAUbHsA==
Date: Wed, 28 Apr 2021 15:45:06 +0000
Message-ID: <BY5PR04MB704103E057C3DA97DB0597C28B409@BY5PR04MB7041.namprd04.prod.outlook.com>
References: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
 <20210428124256.GB28566@lst.de>
 <CALCETrXSP8RR_xu3aVwGNL26KNZCkE6D6yztMpu_MPZUfkRCew@mail.gmail.com>
In-Reply-To: <CALCETrXSP8RR_xu3aVwGNL26KNZCkE6D6yztMpu_MPZUfkRCew@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [87.68.183.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d07f902e-3546-48f4-ee79-08d90a5c98a5
x-ms-traffictypediagnostic: BYAPR04MB5141:
x-microsoft-antispam-prvs: <BYAPR04MB5141AD5C1DF37D7B1C8DD3E58B409@BYAPR04MB5141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n59bdbg3MnfY5v3Xnw3xlDHjJ2mM0/hnoG1I7C6wJubtNIr6dlfIhY/LtAjE7A/DADedYFPyz0EmR7jHgPq3V+QZXos/ffXD0xAH4QIUEsQafAP5CXhci3VgXJ+1I/gqQEUTShLr92i1V1Gfh+egRHAn1Vzh3nd5DwQooCSXOehKKcFcTnJ1UkIecGgFfZ4D5aWMHZdks3PcUF8lx9vklREmGUnDEBF6UY7WoPSl5j4RHTA5P5rzz9Fb821GbCnchKCuWviS0DGcfkaB3JgdaNRhIoffCFdSbOCJwN3B+3h0G9Zm/bhbOs5axp/jFJ4BMB3mGqpf9b1sBU3w0P9RC1/PMw+Ow5bySl2YzlyFBG6Dz9wBY+cXC9xgrMPcTgZ8CM1EJ/J4v7VNw49BWNcAjw96fZoP7ZG3NZkpYzZwkYrMN7kfulqGtALhSE0MCkqD5z48JADujepRcRXSV1lYEoLRY3yxmkzBLze1a7G4wQ04D1C9SXsI2vvmlbQ/KluKftTeXWnHFR+SGsZeXWIIC28DsmeSZI87QtmcGalpuV23wUhcZuQA6jVuXNGrPrQzVmONpeeGW8yEqlqdzSOUtOLwqSISQMg5b6Yj9wNCbdE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR04MB7041.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(53546011)(186003)(2906002)(8676002)(66446008)(83380400001)(6506007)(66946007)(64756008)(66476007)(26005)(66556008)(478600001)(54906003)(38100700002)(55016002)(86362001)(5660300002)(9686003)(7696005)(33656002)(45080400002)(4326008)(71200400001)(8936002)(122000001)(110136005)(52536014)(316002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?NjI1NlVBSkM1Q0xLVURCb2IxSG9UL3FwVU0zckxLZ1RTanRnTSs0Q3FSTHFN?=
 =?utf-8?B?OWhMKzc4N0w5TktUUTVtK3RvTW9LNjN5YzZRL3drcDhRSWFZNStqRW1jK0FB?=
 =?utf-8?B?cVBobnZkUnMrdHVQS2ovUUFqUER2STdPVWV2akg1YVMwVk8wRkMxNDRPbi8r?=
 =?utf-8?B?cVVxUUR5aDVDZ3poVHZZUWVqKzlKeFZMemhZcEY0dklhK3I3QjlJaTlXRFdW?=
 =?utf-8?B?SGQ3akpwUlhEdzRocHBNVm43cTI5TjlPNThLMUtsUGpZRzFmYnpXSERKWHY2?=
 =?utf-8?B?TklMM0lPMzdZTVJhWWNNTzBEaWhhVlJlTzNsWHUyUExmZGxBVm93Vm4xQUIz?=
 =?utf-8?B?b1FaZFduQ3FIb2xYN0loQ1ZMVCsvV2xjbkEyYm1nSE9zdURkcXFJZHI1NFBh?=
 =?utf-8?B?amQwTjVxMmd3aERrSTZEOHVhQXFYL21sMitNT3BSYUxPbVc1SFA2Y05MTnpE?=
 =?utf-8?B?eFVCRUlkSUplOURSWHh6QStWUWo4YkNFMnVkTlZubWFaV2F2aC92ZkJXMDZ4?=
 =?utf-8?B?THNUcXhNM0diTWZpNFhWMWkrNC96cVp2WGczeE1IOWRFQlVNS1gxb0pGTlR3?=
 =?utf-8?B?L1dRN2s1a2xMK1NwMzN4M0NseldTd3NwQ2toU2xiN2tubSt4bG9VQ005UHdy?=
 =?utf-8?B?cVZKQVREOE96bHI3Y1VqeExFYjlrUFNXa2w3ZGl1TTVZdWM1LzFBRDRKTElo?=
 =?utf-8?B?UFVmc0Jkd1VkUzQrRk1JSE5wSEl0emdJTmJUS09KYkZZZmxCNHJUbDJmRE8x?=
 =?utf-8?B?V2MvMTRNYXhaZWpzZXBKSUlLeSsxSmVzTGNDdUFzVzZJa05VeVU0YTJJZzBX?=
 =?utf-8?B?dVBUVitPSmI5NDJlaklSWDNYcDlKdEo0eHlKd0V1UWg0QlNGTXVlbFpKTWJC?=
 =?utf-8?B?cHNTem0vNUx1V0VzalFRL3pLNm5aSk9FTGtoV1dkMmhGWGR4TDJtZFZtWWtz?=
 =?utf-8?B?OW9naDRxc3o4eWZ4cjRMaDZMSUtpcjcrVDAzdEZuWktESDE0WVFyRnB3cTE2?=
 =?utf-8?B?RUx4RytoMVNmbk9HWnpmdTNnaXZjUkpzcE0wa3NaTFNiVnhobnFocENXNkdS?=
 =?utf-8?B?d0FCR3hjSWkrMW9WUWsrTXNJNVIxeVdjdlphV3o4bTZLbmM4Z1BNcXJHT3VG?=
 =?utf-8?B?elhLU2xBVVA3b0g5SENkRFBpVzN4a2JiQ1UrMTdkRVZ4TkZQSURndXhkdlM1?=
 =?utf-8?B?MVk5bDFSSGNXUkIzVEMzVjAvTnNpaTc3ZGVGV210UDJVSFhoRmJvZFJhTkpB?=
 =?utf-8?B?K1B2SkFOTjdmMzNjV2IzbUl3aTY2OEl4MnM3SkRiV2FFMmUwSHI3Nzk3bHZC?=
 =?utf-8?B?YUFqRFEyOGFEV1REZFFDTS9yakRyTWdtZnRDK21PTkJ1eVhxY0tVMHdTVG9D?=
 =?utf-8?B?NVZtVE5vUE1oelBWUmpaM2I2QTJmQUpNQlhEZUsxQXRsblVTTkdWa0kzR0w2?=
 =?utf-8?B?OWZCV2RWQU5SNkRFYmZOeXZxejAxWFJaSXNjZXV6MXRSb1BtT1U2enJYeFVh?=
 =?utf-8?B?SmZjWHM3MU5Zb255UnRxNUFJOXp6Z09wMGhTR002VkQ3c1Y1Zy96RHNhUWx3?=
 =?utf-8?B?eWRVZE9JYWVrNHI3b1hMckxsczlQOTIxR1lDMEx3WUpsamMzd0pDWDk1Wm85?=
 =?utf-8?B?b01hVk1zTzFybEZVSjBMUldzRjZDQjVFc1FUMWlXajFmbVlOV2dBcEZ3ajNz?=
 =?utf-8?B?T3pLdjFxbjd1cVFlM29ybVYra1lnK05TWUpIbDRwRXJVdTFlS0lrT05OM1M4?=
 =?utf-8?Q?wyo7+sHDQIbai7FrDATrXv/c984BbXAOB2ZkIwS?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB7041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07f902e-3546-48f4-ee79-08d90a5c98a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:45:06.2751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpxKEwNH3N+0SB7ZZmAaKXzGThMgNdKH+oWzPK0/mdEav42voUaO89Jsm8GRk9skROWt2RgABbjdNSmSf6WV4HppW+cBYTixgoAk774BXQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_084510_893345_1B7980AA 
X-CRM114-Status: GOOD (  34.94  )
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

On Wed, Apr 28, 2021 at 5:43 AM hch@lst.de <hch@lst.de> wrote:
>
> Adding Andy who wrote the original APST code.
>
> On Wed, Apr 28, 2021 at 09:27:36AM +0000, Alexey Bogoslavsky wrote:
> > From: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
> >
> > The algorithm that was used until now for building the APST configuration
> > table has been found to produce entries with excessively long ITPT
> > (idle time prior to transition) for devices declaring relatively long
> > entry and exit latencies for non-operational power states. This leads
> > to unnecessary waste of power and, as a result, failure to pass
> > mandatory power consumption tests on Chromebook platforms.
> >
> > The new algorithm is based on two predefined ITPT values and two
> > predefined latency tolerances. Based on these values, as well as on
> > exit and entry latencies reported by the device, the algorithm looks
> > for up to 2 suitable non-operational power states to use as primary
> > and secondary APST transition targets. The predefined values are
> > supplied to the nvme driver as module parameters:
> >
> >  - apst_primary_timeout_ms (default: 100)
> >  - apst_secondary_timeout_ms (default: 2000)
> >  - apst_primary_latency_tol_us (default: 15000)
> >  - apst_secondary_latency_tol_us (default: 100000)
> >
> > The algorithm echoes the approach used by Intel's and Microsoft's drivers
> > on Windows. The specific default parameter values are also based on those
> > drivers. Yet, this patch doesn't introduce the ability to dynamically
> > regenerate the APST table in the event of switching the power source from
> > AC to battery and back. Adding this functionality may be considered in the
> > future. In the meantime, the timeouts and tolerances reflect a compromise
> > between values used by Microsoft for AC and battery scenarios.
> >
> > In most NVMe devices the new algorithm causes them to implement a more
> > aggressive power saving policy. While beneficial in most cases, this
> > sometimes comes at the price of a higher IO processing latency in certain
> > scenarios as well as at the price of a potential impact on the drive's
> > endurance (due to more frequent context saving when entering deep non-
> > operational states). So in order to provide a fallback for systems where
> > these regressions cannot be tolerated, the patch allows to revert to
> > the legacy behavior by setting either apst_primary_timeout_ms or
> > apst_primary_latency_tol_us parameter to 0. Eventually (and possibly after
> > fine tuning the default values of the module parameters) the legacy behavior
> > can be removed.

>  Can you give an example of the APST states and latencies on a device
>  for which this is useful?

Sure. Originally, we faced this problem with WD SN530 device that failed to pass
Google's power consumption tests. The device reports the following latencies:
PS3: entry: 3900, exit: 11000 (translates to 745ms ITPT)
PS4: entry: 5000, exit: 39000 (translates to 2200ms ITPT)

Then we started looking at other devices and found more with a similar problem,
e.g. Crucial P5:
PS3: entry: 10000, exit: 2500 (translates to 625ms ITPT)
PS4: entry: 12000, exit: 35000 (translates to 2350ms ITPT)

>  I'm not opposed to adjusting the algorithm, but I'd like to understand
>  what we're up against.  If Linux were the only game in town, I would
>  say that the approach in this patch is unfortunate because of the
>  arbitrary thresholds it introduces, but if it tracks Windows, then
>  we're probably okay.
>--Andy

I agree. Using arbitrary numbers would be a very bad idea. But the numbers I'm
suggesting are indeed based on the schemes used on Windows, so they have proved
viable on a huge number of devices.

Regards,
Alexey

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
