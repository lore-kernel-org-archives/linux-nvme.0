Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2057DC77B78
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jqPk95aPLO9qqqyGHWgc6sTCcP+mu0tvUTEXedjDov0=; b=wf4OYeuSD7oT8wtRsn2or8ukhZ
	2tMku5nkFg2ATQjMVPEhG98UNzP+IWQGwjLOhSPLAOFxyd6iRprep5+4nsCAHZtUe1xJsc3rvf0CU
	EAvW/ISQUbDeMQ4I5vfpW6NW3JkwwyYEnG2247GCLkSp7LSMBvsg3izZyfz5ENcHWaXyJOLinYO+1
	BxbuD7llYL8i4jYAcO83MjL/2o+un8DKMyjJVyht+vdyUsPSEI3vQ9ZLGF3VTjiWPeg4dUk0BmouL
	3XQkQJd7gEBpyHy4HMt7P4rv9Mdn36xflld3egE+KM9BbN1dbcH2T3GZAVlRa2vhV6YDWVsBZNBOM
	R7JVrEtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puaiz-008C39-2C;
	Thu, 04 May 2023 15:18:29 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puaiw-008C1q-2V
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 15:18:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683213506; x=1714749506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jqPk95aPLO9qqqyGHWgc6sTCcP+mu0tvUTEXedjDov0=;
  b=GhUjUe7I6kXhyb2UgmfOXkUrxbi9UBI6lTls97bPM+pAQEeZ22KGjApH
   p6k6RuQmvQ0qa/C3G+HbfcWE5KwiekWCTOOMTM9CueU0/p/Bkvg+h1G3C
   7MQ33sp/Ff4ChVQqCXYjeUDZMPLFhN4F393Zh82FPEZQ5UNOogcV4hZl0
   LtJzanaXoV9PWANAN1PIzYhx28bR8beVuNln2x1IpweTFD57vQSRm2oIg
   jt11RlQKCqljIPOF2mT2lx/pBtxbEd/SRoNjow8VOd3mSLxGAAjT/+eUI
   dn3Qp7G9a+ZN/Y4Vxqzkz9Qrv047g3oZ67mEuE2+XWp8XhcITxS8xcDhU
   g==;
X-IronPort-AV: E=Sophos;i="5.99,249,1677513600"; 
   d="scan'208";a="228093881"
Received: from mail-bn1nam02lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2023 23:18:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDpqRdKxDUaGrHdyMND4/91owAzC3B+bhB0HQ9ilCy6GNAjfxZah3oL28zZzIVDysrD74fGU/qHSLTjMaw2Coofks8MGL+rKQV8T0h9FZLHgg3Kw7zC/PkD/q7V61OLBtj4aiCxqSiOaaCkbdwB4RWXyraIdnxYPxFlX/F5y9Ek9z7E0xdGjYhE2dBc32NIRxkV/P8LAImVljzI1/JTyH1yjc+aouThIVVDk7+Z5BOLwUxh6fGOGlyYV2Zv96ecC8/D5njkINbMTyeezeZNJlAFt7J1M+Cd7Z96mIip4g/1I7JU1/3pIs489ls9dRDfvFgjc3yVU5zAh+B8JB5EIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqPk95aPLO9qqqyGHWgc6sTCcP+mu0tvUTEXedjDov0=;
 b=AgN5pq4HLc9VoMnGj8WPdZCLhzZ22K+KEL3quR4TxIo7jfYdczugO+RPbkcVnJd4EJi4V5n36LrsnBkueul5+JiKJjO7N5uCNFmnfW8siO8yyeXHh7JHsoxAI9iggJwRiFaCQ8SUasRP7YAzD0/u+6HBYzvWcpJq6/EhvXO85IVTJN9aRypp0W9sGIOPgHnIOzBRZBj7H1zGoxlEB7ZNk05Wb6YjeUWQKAT3pUqMZKnj36rT3rBphWOlWGxTg3AztCrA661ZcsnUWu/ip8rO3UeoEsJTTJgmJeTHA9vMM4fRSXThIYEF1s19clMltKsO0/1pEl+If11U4HQ6u/7hog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqPk95aPLO9qqqyGHWgc6sTCcP+mu0tvUTEXedjDov0=;
 b=hAAR6wa9gpPhzkuxzFxkOBZzE4itXfpqjsqtGC0cbSaL/GZhtT+uD6t7UUJJub0RTX1N5wSe1PKDtQx99WGPlqvB7FPZJ6okL4CNRz2nT7nOQwkeN16l2s9B+rivpNphRch70k0I8a3SnQecY+ebdjBJT3Zb1OT9iB5WuBG3FTM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB6982.namprd04.prod.outlook.com (2603:10b6:610:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 15:18:13 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fd:6db1:5165:2ade%7]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 15:18:12 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, "jiweisun126@126.com"
	<jiweisun126@126.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "ahuang12@lenovo.com"
	<ahuang12@lenovo.com>, "sunjw10@lenovo.com" <sunjw10@lenovo.com>
Subject: Re: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Thread-Topic: [PATCH] nvme: add cond_resched() to nvme_complete_batch()
Thread-Index: AQHZfmxhAnBWBykOJUOdfcgNJU7LAa9J5RgAgABSBgCAAANPgA==
Date: Thu, 4 May 2023 15:18:12 +0000
Message-ID: <ZFPMs6e2c3tM99o0@x1-carbon>
References: <20230502125412.65633-1-jiweisun126@126.com>
 <ZFKLxfet7qUIwScd@kbusch-mbp.dhcp.thefacebook.com>
 <ZFLxXjiQUPl+tV8L@kbusch-mbp.dhcp.thefacebook.com>
 <ZFN9aWYCxJW/HdHi@x1-carbon> <ZFOFHv8Kh/7KLuBa@x1-carbon>
 <ZFPJ7CYFEextnOqE@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZFPJ7CYFEextnOqE@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB6982:EE_
x-ms-office365-filtering-correlation-id: 94a70116-aa5d-481a-6c72-08db4cb2c6e3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5W7WT6iUlPJTnM72F7yHqAVRS6hwWz/w9z2ubaY6AJm9jeAunYjYTmy5zvTbxPH869Xy/4crrtwNGcw9A6HwlazPaRKxIsZvUq+jsNorFaXwwZcQCegGwuet1z9NqDyx1LTA4d/Vig1Npe4taPo17Pw3nl/OaB55zXF/aJ8tGDSB2cSaKLvK8lAecv3K/cLTyC6IJPNuqG8cwI2ZcYaoVDHBdQFtMVSRr5NZ57v/bf4exoiAunw1RFXXuoPo774mPKBbBw+lNKH0CtTCltYhzOAwwBvYh/JSYrVdH4+C9yrw54ROACnaxEfjsOxjCtU0Z5d/jRqoJVGkkbBLrW0WcT/J08Ah069sh/LQoONo3e2iP50AA1rubp3iybFbKBtbk45ChBpzXfsHg9pSwB11fO4r8B3408aUkEy4CouQ2eofUakL0K7z3/P5QmwREOhn18Z2szWYTchBzxT/ASUUqsRvgQYxu+zn0cYVVurbrq5Xd4IVeOX6ZegTxGrGLTfoz0OqLz7sUMM88ZQusugChxI7vlpVokL7UO+skr1ldNGMGFKZ0VFnHzJrmRIU+wd1VqDUC30xpz4ORX4HND1ENp5vTVmxCC97ySm2+UhGfSIUMMOSHozlJSDrbV7u/UXe
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(451199021)(26005)(6506007)(6512007)(33716001)(9686003)(186003)(54906003)(66946007)(6486002)(71200400001)(83380400001)(316002)(5660300002)(82960400001)(478600001)(2906002)(6916009)(4326008)(38100700002)(7416002)(86362001)(8676002)(38070700005)(122000001)(41300700001)(8936002)(66476007)(64756008)(66446008)(66556008)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?hD2HX4bunlCGOxQaxQozT0SL0meanzLX3b5tv/f4vDuip7M6+OCmkP8JaVoM?=
 =?us-ascii?Q?roNFgJpHSodfOdoBZ2mVn5uAO+BRaolUWGe0vaLE8MApSLdjcFF4jld56Ygz?=
 =?us-ascii?Q?VH1y0WQcroZkmBjJ1cWjWSEEy5kIVANM3jkNi+bX7pUIeqEbEmKf7MYlwEFv?=
 =?us-ascii?Q?17kKOgtVXv4FB4iep0k4LzvTc1B8eJaEfBPvjWE7MZRsansaPvg+2nXTVw0A?=
 =?us-ascii?Q?w+SGtieYa+ooVKM1eJTkVUAF0EvlFf22c7Cir8j8ORY1cnfyUmGQ4PUiIZFy?=
 =?us-ascii?Q?7rH0MCX7GdNhOjzzS+yB/ECQHBixhQ3x4YzuTknss2yDMEll5FTT68+N8xLd?=
 =?us-ascii?Q?DbkuoMU9KOZqUlfnGvOggSV65doGq2qm0K8xwtHlgNZ0q3s60ATM6r1+JFHS?=
 =?us-ascii?Q?STR2VQUaK4FcotiwSzPTxtDB0N7Y4i60plUZFhT/7kMpRJ2lNdMTKKVjz+tp?=
 =?us-ascii?Q?k+NWmf2whBYSwKOmJPiVp28/McMyjcSvKWPi5dVs9aIn4qrBmL0axkffcUYf?=
 =?us-ascii?Q?qXpnloWleMgCDzPzJu2BfNbApOvy3KNQcyBeaGRulLvFH0Z+lePtJIGf4yVN?=
 =?us-ascii?Q?RXVi/8jYe5UKaRuI+Dm1xu7Ad8CNGBrnoJxjHdRZ39Xb/ZbOgHufDuWnRBJ/?=
 =?us-ascii?Q?J5pW8BR+mcX4mHRvdMKgP1XqCZmLm7zuxO75D5PKLdMoaKy9JIC1VgzILNeO?=
 =?us-ascii?Q?jR4XkIAjEZSJRGpDXsThUktDDnUA1PyF/BfiuAp6nfpk0fBfLuSU2X1L+K0Q?=
 =?us-ascii?Q?sivCUbNxoi98BnvU8PktEBpW4OgPmvdtuwRPQx6PJXnsgL/s/QM8OvaiyswE?=
 =?us-ascii?Q?RrZ77LVdBHO0ZE99oGoVH6xtyKnxCzZFS6wIZrn4NFTGGjfFm0LLOW8wXlT5?=
 =?us-ascii?Q?glDfREZvq0Eb2ys0yCaMXDfcSAkdB9a5GSQvK09xgQxiSFC2vh7xzkU62ztx?=
 =?us-ascii?Q?J3PBE0fsArTNAaXrYmyFpn38qtIWqL9nDJ042x1C6BpDiLRf+GSXtjKBwZHm?=
 =?us-ascii?Q?iAmpraWmvSAShwD59UgGcn7NAkn76P3ITJlA4lRBwO6r9ktWY6dSvHDgt69w?=
 =?us-ascii?Q?CwVqyh2f1fAtw80rlo6M5HeHa48rHgQD/2YDqetQP/4xkYAsU6hJ2Bl29nCh?=
 =?us-ascii?Q?RPYz+QRiymF7gM4qPAVaQKcUuLEH/svGaTmS5wLoLBYJL3P+fXG0GIAr7G0J?=
 =?us-ascii?Q?e4tBqeOl55Oevi6k3IXDdsnagGGIQzJuCfdXHIYIA0ORuf9XrFwQwzxY+hhj?=
 =?us-ascii?Q?aNIyx1YhTw3YbKDQ29E5Jmzj3b/vcNG1dsD11HPFn3sQuqrjlP4vr34Z1nKe?=
 =?us-ascii?Q?GDOqv8fJ0kHnoXHQKpRhFKMV9OLlS7HiFLeMTa2sQsV6CiaSmX17CCboXZ1M?=
 =?us-ascii?Q?7h+qRmqBdTPo/QYaXMLGkAqXXKYv+86bCsDG+9bP7dv9L4Xw9WAj4te6dwp6?=
 =?us-ascii?Q?PbjFRyrQNhgoDZQdg9JLjxWtnx0QnKmaGKhETU4AwXfN92yBqDUcaEYzSdkr?=
 =?us-ascii?Q?llK/0OYXtlMVdLXo6c9GowS7dTSKsPM9Qb9LL05AElKeMS+kHlk55wpQluMQ?=
 =?us-ascii?Q?pafJavxBED+ef9IYj0x3JW5Eud5IMgZY2cSZ5nuFMeDR70IelKeWkwXr6ms7?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D74BD76E8278A14D99B883179EC6FC69@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?us-ascii?Q?NPDyHDQ6reIF0xlpo6LcAZ+SIwkw9++yC1xKq4Rf3ddkkNRit9C5ve++O+NE?=
 =?us-ascii?Q?bBZ8CB7KL1RqjsaP10H/Aq/XIOelKQRUo3gvJQSPCL+Alejgk+5Eyirbw052?=
 =?us-ascii?Q?YNuxMEPs9hLMfCn6W6N8DYVe7t7EOtwqCA4WEOt0N/6PA99zq2AU1y+Y7YFX?=
 =?us-ascii?Q?cyKCb4aFx42JaRLOawLCN5QqWnvv0az0iYZYzWsfdA/HvkMOrq/H76LLUca0?=
 =?us-ascii?Q?ibgXgSlf9N5b5cqJhYHT9ckXG8TGmach1tEozd1bd2jeVJ/0n68uofxlFveZ?=
 =?us-ascii?Q?0YaK0HjLDhpM48D9ZyNxGcmemp3ueMUX6CwlCJLwdJZB7op822bIhrj19+bl?=
 =?us-ascii?Q?cdS1dZputLRAdE5ltyd98UYU3D55YWqoRZ3Z1I0PYDG3u3c4v3biiLeAWGsu?=
 =?us-ascii?Q?nVzh78TDTKnB3n+qV1IEVaBuHShK4GVGQ/y4riWgpUbTKNJbKxXPu2mF1+BO?=
 =?us-ascii?Q?aSTdrZ/hDrpjCz6tosURHK1r3+ctOLMLEXVLiFhZXEYItYdQ/uJmMK59Uh6t?=
 =?us-ascii?Q?Ne6i7XnJpTU38726abM+eipKTuFxIyHRHzGWAsM83uCllOPg5olPvajK7GBW?=
 =?us-ascii?Q?4Y5WUysuJqsEFd7AN3ydfFpdA4+TuHBpSHLnm0EioNFar9231VADOMbMxm8h?=
 =?us-ascii?Q?g53ZGp5XjaJtvCUygCIMNl49jPZHkKaRZFATztCQuJ0Sq5yCXLGXJ4ct1p4p?=
 =?us-ascii?Q?TpI/osO3EVXpC5ghQ0uUtXo8LC1EOxFZjIYz4oE8b+mTdUhtsYaogPtiNEvT?=
 =?us-ascii?Q?T1O1uN8Gu8RRROy14yaakaDDbxLIAt9tLVvEI8fb17gjO7CmjaQnqhjL+9YR?=
 =?us-ascii?Q?9AsXj/FRXpLyUmriMjlWgTI59m7Szb/oemx3gQzCO0ms75mjA6re206rAfS9?=
 =?us-ascii?Q?0agf8URDIAvMRYSdxjoKsiFu90LUboz2xw/HWs1ggSjyVnzrPbTJwgG9OU/E?=
 =?us-ascii?Q?leSUW7hlA/9Nd0TYoQ82q9newgcAGgMAhum8faVDaoW2hWMxLuduhWId2CYP?=
 =?us-ascii?Q?TZDulBG6NJSf9Pvp09u9iYORJ1cJO9EopYyHVZhuY1dB3WY=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a70116-aa5d-481a-6c72-08db4cb2c6e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 15:18:12.7521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TN4cOb+0AxMNMB2yd0TlD3PjeaezerBvuSu8S6cqFMjt8wBKnx6jQha+BuMtrXeSs4dyEGoL0MviVXD/ZNhctQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6982
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_081826_877149_3FA7BC59 
X-CRM114-Status: GOOD (  24.59  )
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

On Thu, May 04, 2023 at 09:06:20AM -0600, Keith Busch wrote:
> On Thu, May 04, 2023 at 10:12:46AM +0000, Niklas Cassel wrote:
> > On Thu, May 04, 2023 at 11:39:53AM +0200, Niklas Cassel wrote:
> > >=20
> > > Something is fishy here...
> > >=20
> > > (Perhaps the maintainer did a git revert instead of applying the fix.=
..
> > > and accidentally squashed the revert with a proper commit...
> > > But even that does not make sense, as there simply seems to be too ma=
ny
> > > lines changed in 2d55c16c0c54 ("dmapool: create/destroy cleanup") for=
 that
> > > to be the case...)
> >=20
> > It seems like the additional lines in
> > 2d55c16c0c54 ("dmapool: create/destroy cleanup") is explained by the
> > maintainer (probably accidentally) reverting additional patches in that
> > very same commit.
> >=20
> > It seems like that commit reverted all changes to mm/dmapool.c since v6=
.3:
>=20
> Spot on, thanks for confirming! Somehow a series revert was squahed into
> the final patch. :(
>=20
> We reached the same conclusion pretty late yesterday, so I'll wait for
> Andrew to suggest how to proceed. I think we have to rebase whole series
> with the correct final patch and resend the pull.
> =20
> > $ git log --oneline 2d55c16c0c54325bf15286cfa6ba6c268036b9e4 --not v6.3=
 mm/dmapool.c=20
> > 2d55c16c0c54 dmapool: create/destroy cleanup
> > a4de12a032fa dmapool: link blocks across pages
> > 9d062a8a4c6d dmapool: don't memset on free twice
> > 887aef615818 dmapool: simplify freeing
> > 2591b516533b dmapool: consolidate page initialization
> > 36d1a28921a4 dmapool: rearrange page alloc failure handling
> > 52e7d5653979 dmapool: move debug code to own functions
> > 19f504584038 dmapool: speedup DMAPOOL_DEBUG with init_on_alloc
> > 347e4e44c0a9 dmapool: cleanup integer types
> > 65216545436b dmapool: use sysfs_emit() instead of scnprintf()
> > 7f796d141c07 dmapool: remove checks for dev =3D=3D NULL

Hello Keith, Andrew,

Note that the first four patches were not part of Keith's series,
but they were reverted as well.


> Andrew actually squashed that fix into the original patch.

Ok, strange why there was a revert done at all then.


Kind regards,
Niklas=

