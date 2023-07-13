Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464DDEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 06:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=P5Pex1jwxE5vOTtRWumIvLMzTG
	DxuTLPEEUNaczpTI26GBWq5EUkaR6+PUz7U64yHXsB1yxxV/+RvGYank6MNkvf9+1UjNU0/5c1sCI
	0gM5O9jj5UjgSr27tnp5KJ653PNpj/Y9D4ycL6ym+/72xr13OFEA5tpEefRAgxbyK/xDt4CzsnCj/
	XCbwA1gMSib6SwqXjKf5DtBkvEfTL+eCtJu2pXRJQ22fZ30qKQNZBqKzybjsVcx7y2gvoFLVWzwqj
	G4XFhoF4orADiAEMKuvSlT0yHePg76srap2IN2ASrLTiMEwXEEGURhbKqVc4rrC7ZLtArAahzdZJA
	36Bz5A5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJq33-0027zN-0P;
	Thu, 13 Jul 2023 06:43:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJq31-0027yA-19
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 06:43:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689230611; x=1720766611;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=nSR4pzkVe0sXC/lnng8H5bIO4fkQDlBk71CIupTrDsTkyvaMNod5V8y/
   Nzk150r/Cvt1atLMAKeiWX2MGN8Hz4DW22UPMD9XHZO+e0b3tssoBmlKI
   4XUDwbh8tGRXiqCW3oeFE4CDIWUlXMxFQkqwgEaJmQB9lVpqI7w4exzIB
   u4kTSEQKR+nyuRKj36RGPssGiKfMTH9G9nyXlqqA7hlvcbzFbxhPQn61o
   qTCL/fWPSbu9CiRRzjUnAdrwBB//BELle6BkE87oYGQxIc2mUT1H8vwPS
   ZMrbWim2SS771HjVXxT5VOckDfcGrrnyYshuVEzNGuoEsDT+xKzvR/LdJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,201,1684771200"; 
   d="scan'208";a="349844638"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2023 14:43:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vpzq/d4I/w6WcUajK6tWEBbOVrAtU9OKUM8V4DayH31pVKyAlzQIcaQaI11a7w+FmL+WkfLl9Pf2LQwfSJGqHmwgJia/uiybZiGWUPwrtP0a/8d4U2uLb+jATHOhD99gc0cypYFaPgp1Ot8v42MWHt5zFDZzj7p9OPuJNKf8z3GpzJef9XoniCuQP6qBVFe7kdY7tKU3ULQtsU2R/1VxuWhsyXe2XSDcH719QebPGewlyzriryVXlYDbrlx6mRRjNoo7xYcUHJ1z/lNZBg80OxBFMNK6Rd15e5WBW9KKcWXy+L2YpymSQwaFhKihHRXksbsJG/cQgpO2qXILUqtEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=oYdoMoVrJSQamiaH2bYfpgYAJpxCq34y63qXA2B5M0qcnjVpsLarBBEx3GCZdUlAVZ0KTGd4Xzqmkotx+DiD2iq+haCuKw88NpuEwAilbEJIRE8K0qLbpGMX6dzhzdV+Ti2A6sQJ2OC9HAzbw4wZdghcrm0L1I19c7fDSGdSBK+soVQmDAnYtVZ2TvxUhVvw+hmLmdNBLRD057OMxtOc+ipf45YYklCWd3v4YG3UcImIUTkfT06+LA67DqXIq5TvVlpxzEW8s+aI+oEUzwVlBJrGDN/4tmKdKEkW3POcZ6hFRg/sPx5mcKMqWHJaAp9+foVPK1PBF8oofuVWm5P82A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=jIIso99zX1N8o818NMIf8IfOq7FfFEsMyuqV9Y2ckGGwlwMmNlhpF84EMMpj+Y1cWfbtW/1EH1R9AYtfNWJnLgY2CHa62GIXNx0GhDMqeTJ4j/i6K1PgjhS7HTWbd0Vu8+dqtIMWl1NCUSwQF9jlIdsVFSpP7gh7XGMoglyZu7I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7823.namprd04.prod.outlook.com (2603:10b6:a03:300::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 13 Jul
 2023 06:43:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d10e:18ac:726d:ffe0%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 06:43:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCHv2] nvme: warn only once for legacy uuid attribute
Thread-Topic: [PATCHv2] nvme: warn only once for legacy uuid attribute
Thread-Index: AQHZtNWrmHQHxJRaf0ydszElS1rCfw==
Date: Thu, 13 Jul 2023 06:43:24 +0000
Message-ID: <PH0PR04MB7416C73CADE18026F458641D9B37A@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20230712152639.281545-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7823:EE_
x-ms-office365-filtering-correlation-id: 9c0d51bd-c92d-4531-ddbc-08db836c74f4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o50X+9oEhriSAkrZvkCXZgQzypIWYBYk9MhBEXZqWhoabCX/fc3yOBpQdAF7ZvV9yADuxu048pcbxnecd3udOGrl4ajdwtyy/mtn9VSX6JlcOi00dBkPctCWnHuiFUmXmGZGMGLd4xfiLTSaTvIEjy+dQHmbJDR60GCmZxt0QIiL5VOx0uUt1/WJfIxFVNs+0fpagtTD1QnjMBRY3z5jOm3EN09iCVkYRNYYXaAJ3ZxzpzVR458LSb6rSgox6RCYklKECiAy/dpumsX59ZrjQbjZNp0eSQFVOIzMvepWc/N66zGdxcKNW2jSLPDyRV6UcfGb5gE8HMvn94oqQcUD+2Ggv8mWGuh7lskp5IZ1gHg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(52536014)(8936002)(66476007)(76116006)(66556008)(66946007)(64756008)(2906002)(4326008)(316002)(66446008)(91956017)(41300700001)(8676002)(71200400001)(7696005)(54906003)(621065003)(186003)(6506007)(4270600006)(9686003)(73894004)(38100700002)(478600001)(110136005)(122000001)(82960400001)(38070700005)(33656002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UK9beTKno4w4ODvIHj5LXBU7rVkqZWifXlm5A5ySJ5aO5xuj4Tb5ufGaoL?=
 =?iso-8859-1?Q?2TjOt3vl5PubsgjOzlAVInPQNzLVy0btXspjUTZz/Aj8pMbyaCVztSJfy3?=
 =?iso-8859-1?Q?UKd+nnS0nG4CkSrZEoK2U01b3D6spfKqmGE4bfmdKSjEy8n0a0orQnuqlz?=
 =?iso-8859-1?Q?SVDu3XbsozXplDk5N/mQHmi8IRgE13zgmh1+TJMtDao6oN8c749V9ZOyXf?=
 =?iso-8859-1?Q?Exc8R+jiX6wKvavWvOcvHSZtr+sAlDsQ/PMm44PZmWsDib5eULO6WdSmOc?=
 =?iso-8859-1?Q?v44yujmZvC59B68/I9wbMe2QujL9aHVgyHwPuQsj7MEbKDA5H5bI5KIgFN?=
 =?iso-8859-1?Q?h5SnxAYyoWs81TuRFALXk8oKNffPUJy+3uPJNP/sQ+TaGgRZSTNZw0o7PA?=
 =?iso-8859-1?Q?slcaCZtoJJjm8CYHtyq+SUckige24T6PbMB7JCabcF57cPD/Mm8lr8s9dd?=
 =?iso-8859-1?Q?saefxYy8hF9rLgdQQ4virDGiAgxi/kON8dHpF6+vuImpL6sqjMsM4Yy9BH?=
 =?iso-8859-1?Q?HF48IjQqvhPNwqLrfoZHkL/YKyOpAbOl3GeMDeNcMD0uY0vBYHciisqzhH?=
 =?iso-8859-1?Q?W7YDrrSLGeSzxCKB7aB0zb+S0yyjPNEph+D9029WJhnnAWNdYp8oxrQdTs?=
 =?iso-8859-1?Q?/IThteAJN94dkvCM9DMJ4Bc9jMPRdKSJIOOYZuhoR/iONHZ6QHzz3KM9XD?=
 =?iso-8859-1?Q?RRHDh+wXhaebfCCjvSaYiD+pLu6YyQvdqFUt5vxC7ugMiqT82ut5sJcssv?=
 =?iso-8859-1?Q?JRJJwOCoJvxwObPNgdptjPuX7/bjp/P9QOihfAs/3melDFxSFu/oyUkHnR?=
 =?iso-8859-1?Q?1e82V6oQ3/kifAhDXcUGKHrZXxWR9+z/IssCleHouSTg3GEhttPWfTbHmM?=
 =?iso-8859-1?Q?n+MiGo4ZyI/fgA+L+ustUk0Hv3i3uX4+NSnr99uuqkbDPo+8w+yNxpf0L1?=
 =?iso-8859-1?Q?B0xSGYujPdqCcyipVkXIBi7Np0lNKRCUZm8vBJ1uDHFh5gDsIeA8F4r8Y1?=
 =?iso-8859-1?Q?Hl21wyacAjdDthr2Ie95DdRbmglN90ziLUvHHbvlWiVJu4BQmjGkDcGf23?=
 =?iso-8859-1?Q?20tVTx/ERavH/7zqHax8BHOL1NRuIEkelKI/3DIA+PkeXEYoSUx1wpFbeH?=
 =?iso-8859-1?Q?AcYnbdMEJmr/UGjghTfGITMklmRnAwgzB+7eNRpPpY6cCCygLM8LQC8A03?=
 =?iso-8859-1?Q?m0/uX6k5LoDHYoe9444uv2asKhO79LhpYXme1xgjoQgrMp1oO78RJE/3Oo?=
 =?iso-8859-1?Q?24xFSITyeeE6tS6wPzMZm1PXatG9RbbHyee8v1XhTxgBy4Mz0YCgU3XJQf?=
 =?iso-8859-1?Q?8QoJfRQNSFXX3OLbv4AZzm3eeEnmfu/ms8eB+T1eJkRoJ18NuuXOYiudoA?=
 =?iso-8859-1?Q?9MgcxwrDnBN5fI+YHdABiFCqqbGDM12KYLw0i9RzhP1R0BCZqVh6d2SazD?=
 =?iso-8859-1?Q?XVbElLN+IMpCH83PRBR/0XdDdZXPQbnDXY3n/9CQxpMbQ+ptFrp4xQ75Ys?=
 =?iso-8859-1?Q?yHgkzINS0VOMwnvNQqByo9bS4ORSDYqCH7qE+DOv1uiUldgu8gLcvPsqXT?=
 =?iso-8859-1?Q?hDu3rkmkwLNQRizP5WhXlSUrxKEVsaRJjrqxm07/8n1O0hs8ZR4W2uMova?=
 =?iso-8859-1?Q?TRS6aptWVTJ9OAkN/LmFxnEd6wZMXBXq2av6LJoBv3gRa3rU7k17BxnY9p?=
 =?iso-8859-1?Q?UNLijWLa9AyLdPByGxMAlYypAjPo8jm4XQLxOR1glhZNFnh6PdwdE2xAdv?=
 =?iso-8859-1?Q?QaFg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 25a7Q5wZrZCGhej9IJfd/vXWPW4U9zFv/l3rTc7lw2h/Hhxacd3BwxSSzk6ggHc1V525AvycE/OYxXOOetDVYjHN0Ar9oLRFMfI2iNvHJnAeZUxstbxmOyL4GrtzMkiStxTh4fH7m0ndma4WjmBKpxli85rOuyk2grBSCJLZGkscbIQP5rBnh6ywN+HdUaH7GblPORYXnejCmw91Qc0w/vR5jcwAw+XR57+vxzG2G1xDxyJJSVf2N+ZqtygRaJKihIIXQ6V4VxpmVieH7igTUstnFuVghNb6Fn9gUCJi/aPCiUXj4v78R47zriH7WWhCpEAHOUhblFZCTqqWcrt6zNWtY0BimEHC8tTeeHo9h9pQOOPlwCdBVDtOTgDiSoKFGCpwQmnrSPAhoyy/CUtNPCKDYyJNZu9FhiV04ps+7GmlLTV7GZRIWoC9QTishr8l8SfwWR69SnGrYE0eCimdg+pbS5guf0xkkVacGI1ACAGO3YJtN2G+A5g127JgE1xg3fIGz8GJJil5i2WGoJn3XvcVXjlJKgw3AYnD2X+L0vRpJqSnU2F7kDPSgCseeVis2va3WV7z9qsaBTF0920TpUjIGDBG1xq2klbWiOT2gpFw8I5UkXTBx4gtTrDmEHeXIsc8p0/ZC2XHur+RUSkUVG30oeB7xU4oh7NWN/8NaeByRvZX6CjAeF+2213XbreoJpWL0SX4NoyowKrBYvwis7GdAGfnkdz7KdMpIJr3hiJZVH280Ovm7+KvFPesnc/exSk9I/Ix6VAq0HchqMzF59oByxn9kyAr3w/e03moHCMKi93O3VtmqbR9nrTOSBgcnL/PA0JTtDLI4QS+nNucz+K6GDzYSPt8ZhBWo5P2wceyZu/IuCUUx/Mqe1kfAi/BfndjGNyJqb/u9+ZSB0uZzPVOXuaoVNFqhE9/QRdflcY=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0d51bd-c92d-4531-ddbc-08db836c74f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 06:43:24.4628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+pkRfmjjnVVkp99nuFHJiQgjuA3l61FlGVlN4XlwZwsQfwgI0KW/etXI1HOQ7Ob7WhB0ePdDvfrAqc0LNlQyX2n+sti2IORJuYnOqeAWSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7823
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_234331_507112_BD99C439 
X-CRM114-Status: UNSURE (   5.96  )
X-CRM114-Notice: Please train this message.
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



