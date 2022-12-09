Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528AAC4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Dec 2022 02:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Numqckoa3763G93WErJEFgsBjJJ0p0Vkprr3kfv1ihE=; b=UHa/7HF2NEgKy1ANtVdvQsyGVi
	kDetkrm2cOdKQax5CDcUUK3szOyFeYbFo1VE1NGwlWDn9wM9HVzmvRhmNQ5SDvS3zY02/B/mN1lHi
	d0gOGgUzAsCIfryR7VnWv+CdD+UTqoWSJ29jljAumGR/H/bf8+DIKYVpsEwVCTq8nGH9h4kODExNu
	S6/etjyL7JVdEr6NtmCR6SnVTzQ9oyWBaXy3X1Dj5EyU121ItGW8CQUfQqnMAdHOFU+so9NX/cSO6
	m84DS3xG7iOzh3U1rUzls9p/9dSyGfoomfczlO3p3TVW/0Kee4L1DNNVfaOrTC5uGm/DQh4V9COg3
	RMcLkyvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3SrO-000mYx-7e; Fri, 09 Dec 2022 02:11:34 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3SrK-000mVB-FW
	for linux-nvme@lists.infradead.org; Fri, 09 Dec 2022 02:11:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670551890; x=1702087890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pqnKs6bbJ+U0XkurAF9nhMqSmKwhrh2oxSu3hQzHizE=;
  b=KhioelHmXoEPRHXmf4C0jjuoTFsG9geV4kQrlOq2zdSYYKPT/4AWZNa0
   wfU06BGRD7oq95PkN6j5O8SzQthWFD8pB38lHuI9QUgtccAeIokw8iZpB
   5jSINnUUd/YM2F5SflJx2dQNupY8/ccSypeEYprrLevV9VfaleEtSfqom
   Qcl/MaRxi5eXEYePj/l7Uk7YIwFZ2fS2E1V3gpAx+jHOkQUwo+Cevo57E
   3b3b14uxZDYjItCYvdetiSKmYt2mk2dvtk/weY+8EoebTGFmsY0ZqEAqb
   FUrNbTHTewrAslgTzqOp4BcK5hey+zdMvrJyYkRtTqaal9GLZfbdQqzvA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="319223296"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="319223296"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 18:11:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="892493325"
X-IronPort-AV: E=Sophos;i="5.96,228,1665471600"; 
   d="scan'208";a="892493325"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 08 Dec 2022 18:11:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 8 Dec 2022 18:11:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 8 Dec 2022 18:11:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 8 Dec 2022 18:11:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG8uO44y4wswkvN9t/cgeEixel/J4hQ1Fa8QghSFfcuMgg9ttUhTehrpATxhAKAEQfVhkKbBzxxdtxIrpTSEMLaFFVxE5yoR/ZNs/M9hIYgv3rzEFIA4vuoGSVfBVWX2ICz+Znmtub/bOyNlsTBt5mHZ3UuNDKJycDSAdMMU1FhpwxZU9UzDTuF3+fyg1a5lV4ZOcMYOrwxmVlZ+KjbMdTTRjYrStSkWA3dbOAW7/2Nuqx4TEt7uuLM0Cp5ZJEgKEU+byfQHJozAch4kVzYVF2JUBGhOijfKDrdosFVUc5YogLzja49B52iTTxeal42QhHvrzyqZt+51CP2OC5fBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Numqckoa3763G93WErJEFgsBjJJ0p0Vkprr3kfv1ihE=;
 b=TAyMPA+2QDowkg98Keq0hB2/L8Vw6dQK5JbBFLYeH0uzVvx8I0/nTKX3qfcxrHzhsX4IJvp59Imw2+0mctNOJWCcEoz0UlvO+a5/Jwn+am/6AebY1g4r6mgAQ7FZWOivlETH5HSJm8w5TBofpp/M/DIzi5NGjwund5Cb6zm70ku8S/yp7A7BdX9xYOKJn7vW5qrmnS8nWQkwib3C2bY8hP3NwDEw2oPrD1q54Bpc5iH682vmmIdiHT43VkEFonHNszTsaSgr4JKz1TNLjkVzVsgOmnDnMylspg4AsYr3mnsoy3YpMkp2Gz8cIHsHLWMQEE/aqmFAnl+hY4xgZOjMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6010.namprd11.prod.outlook.com (2603:10b6:208:371::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 02:11:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c9ee:bc36:6cf4:c6fb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c9ee:bc36:6cf4:c6fb%5]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 02:11:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "Rao, Lei" <lei.rao@intel.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"kch@nvidia.com" <kch@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "yishaih@nvidia.com"
	<yishaih@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Dong, Eddie" <eddie.dong@intel.com>, "Li, Yadong"
	<yadong.li@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Wilk, Konrad"
	<konrad.wilk@oracle.com>, "stephen@eideticom.com" <stephen@eideticom.com>,
	"Yuan, Hang" <hang.yuan@intel.com>
Subject: RE: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Thread-Topic: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Thread-Index: AQHZCTfLVudoTcTfbUW71RdNMUs3aK5gYwIAgAB8LwCAAAPrAIAAF5SAgAAEXoCAAAOwgIAAEcqAgAAnS4CAAHlwAIAAW7YAgALDKHA=
Date: Fri, 9 Dec 2022 02:11:21 +0000
Message-ID: <BN9PR11MB52766AC1962858248B7030E28C1C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de> <Y49HKHP9NrId39iH@ziepe.ca>
 <20221206135810.GA27689@lst.de> <Y49eObpI7QoSnugu@ziepe.ca>
 <20221206153811.GB2266@lst.de> <Y49k++D3i8DfLOLL@ziepe.ca>
 <20221206165503.GA8677@lst.de> <Y4+U3VR2LeEh2S7B@ziepe.ca>
 <2975e217-749b-6929-cd2d-4b6276ef33d1@nvidia.com>
 <20221207075834.GC2283@lst.de>
In-Reply-To: <20221207075834.GC2283@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6010:EE_
x-ms-office365-filtering-correlation-id: fe54fa1b-e8b8-4cd6-2056-08dad98aaa7b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ced/gQG+e9LIx0FVriuMlpjKDuYuWDKILrhUq8nZJezykNM5F+VN/tOOPfGZZVPCy8Zm91GFI/RlkqrKEC+53AJS+gx+RsVcA1itTxm3zbVHT7UA2ajub1Y9TkqWUlmsqMjpvkqLjNj+Bm6aBjrCjbZQ66y6G3pS+f1XUP5FfQ/VtzZYvvYukJaUzbidpuxW+DYV+WyfKOTkDBALJNf6IwjvLQ9sL8vpKnkR59KKQpZMJXp3ux6Y2jc0ciMf9JHSTseYmEDyKrTkTgq8qKASLejOUUr/620PNUjqO2mkitD7P8yqBSxd1Wl0FxcU/cUfV03bganY6eafVNVvi4TDlzJmJQhkcYSV3OkUJ32eGttBnmbZWTrMIYfhjwUUdirFssyo47pOZKK0n5hWSlJqMi6oR6z2hnpK2j9LubajMAvv61q6oyvK8vGcvkMCJg4aieWPbO7FICBUTU7rK/Mhl+a6kV+awYZ7HBn5AuFZvIH4Gp4I7lQsVo5UZjyMgE7Q4FaCZMGd4BuzrGhH1KyPo/F2k2ITExOO4lg3bCxxk29JgAe9UfTPSYOZ45nZlDz+qfgWEJ/SWWzulPq29lWqqNIBRkKAYZlZrBXUrYWSoggXboBO6tYNp0M/u+uu4Rtr41I+QVSFw3bPgSAUEggETTldq2klbk1DpSJyV+vWbAz3LVWOHOxDfBb2bROH/oOwI70c80OAJWZ701mriygcUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(38070700005)(86362001)(7416002)(82960400001)(2906002)(8936002)(4744005)(5660300002)(52536014)(55016003)(38100700002)(41300700001)(8676002)(26005)(71200400001)(478600001)(186003)(7696005)(64756008)(66446008)(107886003)(76116006)(66476007)(6506007)(66556008)(4326008)(66946007)(110136005)(9686003)(316002)(54906003)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HkL+6phhVIOajWpBhnVzShcEaQJDQKFqfHrtM+xv92paKdNifYn8fiDRHi1X?=
 =?us-ascii?Q?PWE1/Iqr+g1Iw4vT7m9mY+osonBr7NCeBQ3U+K/T/QBk4dDJDUMr5JjG5Her?=
 =?us-ascii?Q?1028E3g4n5vpAG02vAAwo9oRipsMvvDHBbHkLyaIQeoJARpwvUCq3mrGEVG/?=
 =?us-ascii?Q?al+zt2pT7hixACmP7XWKYuA5x+4GIj9s8nzzXruxgcu8Eorqvu15bWgM5jH8?=
 =?us-ascii?Q?aZjLVflijttI6GSo+r6fbucfV1arxOFzx8dV8QxJoF21vg/3072tN2KyWoKp?=
 =?us-ascii?Q?2KqhjC9TK9dwNX59TZG+c/IQ8UndisQSB+idn+vbJAVw4NeFGepTIz9kyrel?=
 =?us-ascii?Q?/7/EuTf2Um+SCr/dduRfsuhS8dCsX/ClZoCd44XrtCPY9woDPJbipAHmtZNG?=
 =?us-ascii?Q?h2lG1Td6nwYujrwbsITjiHJEjnxddkQi9b+kCpPFihpZxz+BvJvhAz+X/65m?=
 =?us-ascii?Q?FhOvA30/h3KndCRgCVhgA3xu3qSPPBxOrk3WLxk48o8cPCjLg8Kcd+UGszwv?=
 =?us-ascii?Q?9/alxQ8+tkDB3+3qH7iqkicwxahrJqXaImnN2c2znWIM1bvS7pNnFjRr8GsJ?=
 =?us-ascii?Q?YEFqV6u+mPpnAjj5BJrTHSpRTL5WeQjnMPwYo0iYqLa/LO/CVopOlq2cs2jS?=
 =?us-ascii?Q?+rKXH9G9ZOSyXWBcn8woOsewTsJSNbwYladjhw+DamQR86RQqZIUxTZXZqJ/?=
 =?us-ascii?Q?C0B54cmS+qAIMvqeWNSuD0tOHb3vRaw3O3RBHIWDOK+t1eMXoyLYgirN8LhN?=
 =?us-ascii?Q?zH+zSB9U9u5rUzM/6izHMG9/Vi+FOKoVmc0RhEVs3nDjj441T3rRIPgummtL?=
 =?us-ascii?Q?c1G+/TZrdEmzmyW7w8ZR1kzGjITh3pwJDqw18Cz8anQ06jRJ4mwFs75IPNuf?=
 =?us-ascii?Q?+xOyzW29WxLUJe6UHy5ulJJLG05v7f+4rUbJfn8drQYXHNtOjshJlGDfGUlL?=
 =?us-ascii?Q?GTHPnHZh0dJzwLKG/IKcvrMeLwKnZP8y+3ZHVDqOxvuD5eSDpQng4e13u+ZH?=
 =?us-ascii?Q?66DfGxDiJ4Vl4V3VARa8lzQw60maDvsintKHL1J2gQdfiTdBhXtv3yLRHJKS?=
 =?us-ascii?Q?uXBakzNzJzspsURGe8x4JsRIs1ic03AwFVA1obKyYzb/Wcf8Do4xam2Cq3dL?=
 =?us-ascii?Q?mk8MXS2JEdpjdI26UGtTcU6+sy59e7rCK3XAfzxwMqblsU6phrhxbOob+Imc?=
 =?us-ascii?Q?Pgcs68UkWFIHEH9VsI4LF/vKluTU/9J9izH2Tf+a8McUbYOSYQJ1NAFqIuiS?=
 =?us-ascii?Q?yNJrZyV/sHo71H08BiqeiCifthamIY97itqi0Byran60CaQw/Vny9PhOQDDs?=
 =?us-ascii?Q?HFc3cDxNX/yURpiOklFlaUAjMibRacKJGUXHOfgVLzzOWmFAXFw6CK8Qi0fs?=
 =?us-ascii?Q?o2bA3c3KNIDWv4kc2um+178DPpl2T7XK/SXNUgPRdcSzcMP+hhnoBItmK1Vp?=
 =?us-ascii?Q?u+2zzM2+3SZK+wGLhoAIS7uXyhn8Bx/5HFhark3aa8XEB+JTW6M3b9fJAbBa?=
 =?us-ascii?Q?ss8Bx6cYNe1ZfuPJZvLz10ECI0W6TCWFKSgovxLQon99BVl2z+sv89oDIuRj?=
 =?us-ascii?Q?spFeQii2e8r1Dapx8rDXEVYn2GbgfMdUO4xCEGDK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe54fa1b-e8b8-4cd6-2056-08dad98aaa7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 02:11:21.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrm7/Lkvu0a1jGPZikUIs76nirozCxDiPvgDvVui9T/53j2oSKpvA2U0vHR/KMcxWEUJKTW7ZCq+taypuPu6gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6010
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221208_181130_616362_EF19561D 
X-CRM114-Status: GOOD (  14.80  )
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

> From: Christoph Hellwig <hch@lst.de>
> Sent: Wednesday, December 7, 2022 3:59 PM
>=20
> On Wed, Dec 07, 2022 at 04:30:20AM +0200, Max Gurtovoy wrote:
> > I'm not sure how awkward is for migration driver to ask the controlling
> > device driver to operate a migration action.
>=20
> It can't.  That's the whole point.  The controlled function that is
> being migrate must be absolutely unaware of that (except for things
> like quiescing access or FLRs that could happen anyway), because
> otherwise your have a fundamental information leak.
>=20

Can you elaborate which information is leaked?

No matter who provides the uAPI (controlling or controlled), end of
the day it's the same cmd invoked on the controlling device to save/
restore the state of the controlled device itself.

