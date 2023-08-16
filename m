Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C5FC04FE0
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LdtkcYpByDwIpXaxC/K1pOjnNwoFrrMyM1YYohgI+yY=; b=okOHd1bgP+O+h/RFRwB5s/CwDI
	b+LyaKDrX8jAVy4H1ehNLi2+kbZIgMV0tkkDDihtUrjyFEgJYYDX6L87ZFsVllZ/kYWIF960aV1ac
	5O1MeJKCImTt/ZwN0wwYPxHFneSGceB8ENWFWB2GMctD8LFcLohKnSuhFMuhhvb8hEalvsG8S639d
	o8JAdf41Fh9h2DT0W9mSnrfTfF703Lb0XEWU4g4+0O4fXU/7xXEHg8ukNSwz1vcNWgfwH2xCXsPmg
	Gc9McdGltLJ7AF6NROlGNZ4jUPKXTbL9nRahnZQ1gGiapTQSwax27I7Nd86m9t0YWE6XiDcfyvHuR
	od7aFF9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFGO-0043WR-0t;
	Wed, 16 Aug 2023 12:04:36 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFGL-0043Vx-0o
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 12:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692187473; x=1723723473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RasQyXGQN3XqReQEr8kfHj8kBYlT9R6NVl9lxQo+9+Y=;
  b=WrHhSC7D+bRelC8i1VRQFmzaUhd+TztXfXOqY01PJhFpyy/CVmrp12Jv
   WLoUDpb95VIKqc523HRv1izj27NLGr9aVHLmKH70H/tqLx3bxH5Cn1pri
   tMH/LK12Irkay2LummJAoPi/YK65WvMj2cN8Sow1U1Qu76Ward8lz27vj
   rfpIoqEpfbwJiFPcnabnWoUciT91SafxWgi3S6d3qQGr9V5ae/4rQWNRb
   314PpjoyFr95g9pdADDobIlvdaGNGRYYvrMjy/ouwj0O5XRnQLEwgF3F1
   Ll+eb73yRTIYDhJL5Uh8Y2SZwH86Q/lu0E/5OFlJCAsaQlpZF58kNEy3h
   w==;
X-IronPort-AV: E=Sophos;i="6.01,176,1684771200"; 
   d="scan'208";a="346442895"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2023 20:04:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4DkEGLbv2ugZHXzkBsGTsa7EaN9WH0fiDjAmzVrzYbiZXVJ9sXpLDpl9SKq/NRJcVGC4MLFmpLuOW0Ni2F44J/B8g4cNDB0HIiCdVRgMHpDgsdS0cJX31jQ/UWgt+60OlnwNrxN0KLsB9tIX+DuCHMsxf1tnsJfkUvJQJcpci2Gqgbs6gZgXQse+bRc9+Vh+fsZxYQrOhKHi8ZB10vVGtODfTHX+BinzojdMgLJ22LEmw8QBMOP1jFv5rcGqsW5zrLToEaMWeU7W8D1qt0wUutLwN2Hwv6T1dAd4AvCr2t8n1VzVD7lN31MVoLVuJkylklgHgxSH/t5bb9wBcfivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdtkcYpByDwIpXaxC/K1pOjnNwoFrrMyM1YYohgI+yY=;
 b=TuPWIhOtFTogKx3vhMLhNKL0NpjcpZJhihs9yVzEPakNoFFbMfRXS1AzKdbGHm0RbYr6nCbKYuZBgcmRDMkcPqf/CegERZ+ljFdDci3cjIsRVqNZfscFWPqDaT7dK7fd8iUUZ+PdnpT2V4PUqbpt9QTQqcB7icdqTi8sfN2ko1/cK2+7i9igNCSep+qleqi1tlXkur/eILrdUvMJgxdZgsP6BbvRn/xl+INlzs36AOAmUqMI7DRiknAl7/TICc3/F1y9KoSZ/57EzdI6eDJKhURaTzJoEo8EkqYe4yh//9krQD/H047v9+BqflAle4igr2UswYHVE3ELmdIEIpJyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdtkcYpByDwIpXaxC/K1pOjnNwoFrrMyM1YYohgI+yY=;
 b=F2BYz4S0lsG9nMtVee9oGOAbXyq1CskKEqCc9HQ0gUi9x7JoNkpV7SCRhRqXNICQ08bbEzcQ/tv9uqnQOKmZpeZ6IznSyYhGDxzsZAwqRu8buIhTWFhHIfCIrW6ZMFjsHSC5Oh1ctZE08YYtaMMfj5VEfUTAp06xgBuSDqu9Ius=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Wed, 16 Aug 2023 12:04:25 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:04:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Thread-Topic: [PATCH blktests] nvme/rc: fix nvme device readiness check after
 _nvme_connect_subsys
Thread-Index: AQHZy/J3Glbz+YK/PUq03CAsK7LAl6/kpM8AgAg244A=
Date: Wed, 16 Aug 2023 12:04:24 +0000
Message-ID: <dsb7kr6wzpebiruz3uqrl2mfhahsv4pgmvojeaeshn4to6csrj@iape74ngcwg2>
References: <20230811012334.3392220-1-shinichiro.kawasaki@wdc.com>
 <6x55ggt7k2kjgd6lr6ykubwmo2qfilz3k32ywfuun2zhat2p5v@7aohs7kgb23x>
In-Reply-To: <6x55ggt7k2kjgd6lr6ykubwmo2qfilz3k32ywfuun2zhat2p5v@7aohs7kgb23x>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7261:EE_
x-ms-office365-filtering-correlation-id: d47975b4-edf0-4c44-88dc-08db9e50ef18
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wTVhmnyZ6feU3eFH6dNNdvz9JdzHHY+cg2a8xECoy/BPKoGLQGEW7sCVMcJ5T+qPfPDspFlAkptfHpnl5B0m3T8o736QGO9YvJNeAVUK0NBrT+7vLiQRwtKk8T4fV3y8Xuq3jSt+5dkgTHb/uEGfK+0qx72T3hREH8/2CLkLY/jO06ddk4DX8srMlG4UZkEGjkLYfuVFvaMADtkyS5dJ198XmBbh/QGa2oWOYYrGm4v+68MFheV14czO6deUzpIDCvfGBypfhG8Z6uy/va90RuN7jfxMBXcwq+L1NKsMhPuGYxaYQWfhwBFrpo2Bugfp7CeRQOXUvJxI1OktBQxwJn+89TK3B7JXwC3qkMCOlrqRZ3mAlvaDoG0CNq/EALoZGiITfwZ+ui8SEE2sIzM/ZQvlfhNeXpmF4Ld/Pldl0B9YJZfZPpIFuS4d9WvYCbhM/P0SJ+w6TH04rxNfXPLW8f+rdOq8mwUruGtDhINOuBy2B3AnfQSvNp1PrKA+fCP8w+iCbTJyvlb4U6c+qeW216voMowZCtokD/tzdeM4G+GqvONVFmp5a3HaK36W6JE4/IuA0NFiXT5qaKRbBacqfy2N9+9u3PGSg8wNsvT5Ph2KHnmujaxE8HT3dCXjQg+h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(6916009)(66946007)(91956017)(64756008)(66446008)(66476007)(66556008)(122000001)(41300700001)(5660300002)(44832011)(38070700005)(38100700002)(8676002)(4326008)(8936002)(33716001)(82960400001)(2906002)(83380400001)(26005)(478600001)(86362001)(9686003)(6512007)(6506007)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TXiem/XKHniIPyhbkx+ol6TyyidbJpoRLSqMfbOTPjXSaG38zvAPC6lYAWjf?=
 =?us-ascii?Q?G0ym81kanN2NCaZvG4VEDkOt9MCoFX1M1neG/ia/J2bWzU/lem/+Lq06zdyy?=
 =?us-ascii?Q?blqBCov2iOsLrGuFtExdw6MmdcqM0KY8IlsHeR8YKKPnPpQmp5nKGapRM4Fg?=
 =?us-ascii?Q?AHruhnuteCqlSUTyl20hNxK//yCBr1a3IuLoecbYLPTtHS8/WMLcVsX2hGWi?=
 =?us-ascii?Q?pf+A0j2XbFPehdZpVPKf9+WrYvS5ZqU3ef1HmGQaOYCdOF69glv8fJs52584?=
 =?us-ascii?Q?lQeObSNU9Irg7/8Up4eeeW1LytRXCLOR8N/Zhob6gRYhUyVoMVMajZfOSIVM?=
 =?us-ascii?Q?pcX4Tb3aN38Py+t+gY0rRLTRRmCBHR4vpme4B4q7PdmE5RQPyoZXWGCdpQ+r?=
 =?us-ascii?Q?BgDis9AvxXeq4C4A3IEq0aePH9nSnjaCsGD+L26M34X118DpX4PrEuFyT6Bx?=
 =?us-ascii?Q?9hnVsGILsYjpMBv4Dc2T2FNIL/t0MnEpXX5zRFiMiaFeuf+WhI8G+uhq1Ulp?=
 =?us-ascii?Q?G+bL4eYvhHdfvEMwX2gl3Q90tQo8LqZq+Bt6Y4UWr0j3TZsMUTHBuyC8jFxu?=
 =?us-ascii?Q?LE9Q7F+cqZb7NuWQngCHGhiAqjzNfgU1T7QNa52PVKhzYCzGYN1aDsQeKhEr?=
 =?us-ascii?Q?YT3aw4d1ptRJFb3zdiviRbs1lLBYbpvGJ+b5DfQ8sDV4Wg+9Gh6eWkJye8zX?=
 =?us-ascii?Q?uVFvbsKn7bli5Fuz5pGvrXECSDUWkYqAJo+BL0hwbeXeAA7Nf2oAJhh8B9E8?=
 =?us-ascii?Q?LRoQFv5JCwsbYXDL8tkJeq4P1ioGde1p8S8f4m4qV4jvj2KtVfAy5sIi5LEH?=
 =?us-ascii?Q?E/N0nbcE/Up2d50fZslvMYN8RmppOcrjoSyvdhn16qzhzYoubBAmqZo2G3iZ?=
 =?us-ascii?Q?tFpA9Vg/oSPwzN1kL1fcIRE2HULZS1JGHyzIhD5oEqR1dLlqZKj5eIneWvM1?=
 =?us-ascii?Q?lXz/EXd6Z1mQtpMMEeKjTP43jMNblSHlNXwd5ChjJbmCyAvafS444wuouD57?=
 =?us-ascii?Q?M4Qf1xWZJKrGQ7G/BTWLgEOyoGvwCJZf/VpUvQyU8fBCAVyx9nZ2oggn5hqk?=
 =?us-ascii?Q?9JZVwPF1upguA3kGMvMh8qNEq5/n8YoL0aIiUj6Qqt7RK6RyCGJfR+bYxbqS?=
 =?us-ascii?Q?Zy3RyGlN7HzRLinVnrV42fGNi2s3N9EdMBTYN5U56aYyI+O8CyGl+AjspQg1?=
 =?us-ascii?Q?OuzigXf4ln/qYsiTV1SbJY4tdMmVKbJyK7j7RXEnz+VyupoepliD1JLwn8wk?=
 =?us-ascii?Q?ReCZnD2D3CPrM5hSnypeqCe9ZL6ypySRECoB0NqJFDMe7c5WoY1xKAgvFV9T?=
 =?us-ascii?Q?5X+DgYwfrEBehZv8DrgLTNc6/SOPVy9N4HLDvlaSeuUMwDU1W8e6yAGCJ1bS?=
 =?us-ascii?Q?epOGxV+M0AJnWwk/aDdXkQoMqC4FFk+OBXqGssE1k3mudmveP4sv3l5YjoWe?=
 =?us-ascii?Q?/Qo3b2kEBzVGG8R3gwvr9KwBpJ9XJGC0Ryqh1aKQ8RDK7wio/m6AR0H+hz3Y?=
 =?us-ascii?Q?6ifyzQA8Qe8pNlm4Fg1UtJzt7gaPPZvJb0idMGRQXoCxOaZRYBdQMReHuQi5?=
 =?us-ascii?Q?DGc4kOisQV7hh2pxspuRp7QQQVFUcTLuZaeJrirkTcNRF7vEruLmi+Ke1n1f?=
 =?us-ascii?Q?ms6eceNB28RjtDv2gz5rXyc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98056D0F507B7A448076652BFD83CF40@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kw0gm7J62u9uAqINvKyf6mRvgAySDjY7mJa7hHjGtq4Id209TQaU6Iz0PaUjpyAP04Djf5F+3KojISslcS5c0a3faRLNRLm/wrwaS5nXeG0r+canHHZvxesZEDQkb6F3jQQSPUrdghVy37eoLCXMxBibXuWS0VWSjK11fRxcvVJ5cyRUygUlOIyO3uuOleTnONH3TBITVwYkzsHMlMCgwdFUUeRysfw8M1aIgnKhyBrg7ziJJvf7H7ms3qMImT4lyRT8klO/SHjm1grskY4GuYilg5oqkAsi6ZIjES9oi3tQuu56IP9u8srAWj+RvAOUmx/PIWEa3+02hbYp4kBj+H4j36xQoWFTM72e72X0tX+eunUEjVHTgQAHqFc3BfmPkZ4Jw8YhaKlAWxYcM0ipPUE30J4QFGpzopBXMC7siHPv2kLlvUNXk+X0+eSJQ4cnW60+SluEBhsA1l6KQDU6bUQ94sI9ciN+4xHARVftkXOL6yzEZIWyolPWB1yx360OZ0vs4aMSlu3nIE/lJTpe9Yhd7C6gy27IHyQOhAFNnyqzSKsCQCjENaju0Eads0kwHrhNQJDDFv2Kl/IA0asx3bSHucXDEMDcygeth5TqaR4jojiSicBGJf5ylxZUFMl30h9MSk8IgxRhNTO5SHXuDZfZyISJw2ZQ38ZuvGXJJ+Ah9cl4Y8fsBg69NLqyPCgXdIjkNEP3zNhzivmSE/AEyRnLMBBL7/kr/cPEJYz9giZQmFfyI/mHhTogoNw2U8EmLg01kS+HVrNzH1KNGpnW5x9rd2oxPfpe83KLtx99jtX8T/4mMFnTmefViW5WZIAntoLpiVHBDsDMyeRhn1UHn9KfUMf90HluNfRAYFe4aZvOs6NPuQdoA2UIpvftIlDD92Fn56E6ndFQZ6hjE2vbFw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47975b4-edf0-4c44-88dc-08db9e50ef18
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:04:24.8508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAbPrFDFIaHpACOkzsii/87AW1cWH5NWX5WJQQA4Ck3oBZFejL7V3fuDu0+ck6p/CVSTujGfBxc3g4ZX7s2UTQfLWSgt5RrMVVAAi0ypK3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_050433_423909_A0BD2FCC 
X-CRM114-Status: GOOD (  29.25  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Aug 11, 2023 / 08:37, Daniel Wagner wrote:
> On Fri, Aug 11, 2023 at 10:23:34AM +0900, Shin'ichiro Kawasaki wrote:
> > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -425,6 +425,7 @@ _nvme_connect_subsys() {
> >  	local keep_alive_tmo=3D""
> >  	local reconnect_delay=3D""
> >  	local ctrl_loss_tmo=3D""
> > +	local dev i
> > =20
> >  	while [[ $# -gt 0 ]]; do
> >  		case $1 in
> > @@ -529,6 +530,16 @@ _nvme_connect_subsys() {
> >  	fi
> > =20
> >  	nvme connect "${ARGS[@]}" 2> /dev/null
> > +
> > +	dev=3D$(_find_nvme_dev "$subsysnqn")
> > +	for ((i =3D 0; i < 10; i++)); do
> > +		if [[ -b /dev/${dev}n1 &&
> > +			      -e /sys/block/${dev}n1/uuid &&
> > +			      -e /sys/block/${dev}n1/wwid ]]; then
> > +			return
> > +		fi
> > +		sleep .1
> > +	done
> >  }
>=20
> Not sure if this going to work for the passthru case as intended.

IMO, the check above is not for the passthru case. The function
_nvmet_passthru_target_connect() has the code below:

	while [ ! -b "${nsdev}" ]; do sleep 1; done

This checks readiness of the device for the passthru case.

> If you
> look at the _find_nvme_passthru_loop_dev() function, there is a logic to
> figure out which namespace to use. _nvmet_passthru_target_connect()
> is also using _nvme_connect_subsys() so it is possible that the
> test device for the passthru case uses not namespace 1.
>=20
> If namespace 1 doesn't exist we just loop for 1 second. So in this
> particular case nothing changes. Still not nice.

For that case, the check in _nvmet_passthru_target_connect() ensures
readiness of the passthru device. The drawback is that the check for
namespace 1 consumes 1 second for nothing.

>=20
> Thinking about it, shouldn't we log that we couldn't find the
> device/uuid/wwid at the end of the loop?

Not sure. For the non-passthru case, it will be helpful. But for passthru c=
ase,
check result log for namespace 1 can be confusing.

I can think of two other fix approaches below, but they did not look better=
 than
this patch for me. What do you think?

1) Go back to the fix approach to add another _find_nvme_dev() in nvme/047.
   I worried this will leave the chance that we will fall into the same iss=
ue
   when we will add a new test case with multiple _nvme_connect_subsys call=
s.

2) Rework _find_nvme_dev into two new functions _find_nvme_ctrl_dev and
   _find_nvme_ns_dev, and do the readiness check in _find_nvme_ns_dev.
   IMO, this confusion comes from the fact that _find_nvme_dev returns cont=
rol
   device, but some test cases use it to operate namespaces by adding "n1" =
to
   the control device name. If a test case uses namespace device, it's the
   better to call _find_nvme_ns_dev. But I worry this approach may be too m=
uch.

