Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2A0C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Dec 2022 16:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+OlTISppdjhfNuG3gzAj3r1suHN3KScOLzhYkd4V2M=; b=MUoQNTYDZtEcFdwHQP+4n399iU
	ZmTxiqTelyE/+1hEsXjUP65O6M4Mvom+hn0n+BAtdzx3sDJKN1Wq410qdqQ6XlYbp3fVJR7v0u15z
	a8qCXdiIeSUKQkz1rQzhR/0WY/IihG3PWp9IJaIS7UO0q733H4bSSUInI7k+SywxxR3eX2OMYFsey
	QeXf6hu+fni0iZDk9NC3KPJMqgQSAZKpLkjYG9eGd4lIALMtidI2WxfJqq1LxQliH24bpccCWqlHu
	Ysdzy8M6PWL6IXe8INXe/f3D4jC61cJb5feUhv9Qpa3sks4/3km7Dv8dObZYOKFa0iUSyX0I743d2
	rCXcJ1NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3gdO-009oSb-8E; Fri, 09 Dec 2022 16:54:02 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p3gdL-009oR1-0l
	for linux-nvme@lists.infradead.org; Fri, 09 Dec 2022 16:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670604838; x=1702140838;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nbymsPeKBXtyjdZ9Myqaj8IOOPZZq4zMDdOlmuCoQ8s=;
  b=a38oOv4ZNiAeWh1Baz4Mel86lZeSWq+mSONa15TOKRkfmd9WSzK6eLzk
   yqHDBySUYkesqj+xVJYIbCAP250Xz98VUJdcTTRqr0h+/yXBTLuaFbKo3
   kaKUYL8T8lYt8tRMtTWF6/YwznW0bk0MsC6EIGU7WGEhPOaavOmBacVEp
   wouvzgxn/il4yKUwMwoFNouOXt9jpVdVwHjfcXw2wtRXhxPD3bmucjRF4
   McUqL6ekI+uo4GLMZgqjJz+6YeoIQqK6dFVHTW8DKy8gnroelIYSmzS6K
   ODTtOdvM+fKzdVscYeWOqwAPiTBVyxK/xRoEmXBTp1s6sqvaC1anmK7QA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="403753130"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="403753130"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 08:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="641070343"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="641070343"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2022 08:53:53 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 08:53:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 08:53:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 08:53:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP8adjAbeJPNOiivb59S6TKoX6lzHXNWPYbEbp2yXC/gY/F7X9Ej72g6AIw61y7FxSfEBaDTjuICjiXwsLyN4Ww5Nd10EBh7KlOFAXkpiXmbpB8w1N5Q9eQke5FTeNskdBfOnQJ1A/5MR9vdU5Y8dCbmHIpc4wlq3BzhKFORatBS36AEouMSfyO0mNyYggUcrOPxWB/0l0K7JguatN3Beqkik7iXKVaazUSuxCjHmraVDdj1Lr46Wzmg5xbgO44SudOpAMIJ2SWifPc5IaP19gFb4gdcdM5nzO6TlP0u0W73O2s7psLJrOqRwFohuM+mxCc2i2SvZUkbPYf1B/GedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+OlTISppdjhfNuG3gzAj3r1suHN3KScOLzhYkd4V2M=;
 b=DKZLjx8jpfbnp9nWuQu9tWwb0sIy+HsQolSCCoDcLAc63WDeB0LTEP+Bd5Ty9/cZhzA/Zmvrh7GCVqcj+soK7kHyvMh5nFAe8sfyVODq9R3cEO8vDM24yqbuev3nGmD9FFmViXR1+2j5QaU+CONqFiND5q5XNlxd8a8W6FkeFSNncTgJcN/Ngn0EPdxO38vn2EpGSJJn2zfMj/nryHYWbO9LIU8R4WrHw4jIXXBplQ5BU58ETbyd/kUF0i8sh4fqKv0P/eCgLUGFzNn+Mae9P3UxC+g8xX/+xkaZuz2rkN7i0jdE1QfZWCJ89od/6dxlBIMgQxVLfWAHbKnZ4kVO3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB6025.namprd11.prod.outlook.com (2603:10b6:208:390::16)
 by SJ0PR11MB6720.namprd11.prod.outlook.com (2603:10b6:a03:479::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 16:53:48 +0000
Received: from BL1PR11MB6025.namprd11.prod.outlook.com
 ([fe80::468e:f9e6:8010:f64f]) by BL1PR11MB6025.namprd11.prod.outlook.com
 ([fe80::468e:f9e6:8010:f64f%7]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 16:53:48 +0000
From: "Li, Yadong" <yadong.li@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: "Rao, Lei" <lei.rao@intel.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@fb.com" <axboe@fb.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"yishaih@nvidia.com" <yishaih@nvidia.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "Dong, Eddie" <eddie.dong@intel.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "Wilk, Konrad" <konrad.wilk@oracle.com>,
	"stephen@eideticom.com" <stephen@eideticom.com>, "Yuan, Hang"
	<hang.yuan@intel.com>
Subject: RE: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Thread-Topic: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Thread-Index: AQHZCTfY2Hu0IZ4QyU6N2a3B8uatUa5gZMsAgABvfICAAAEagIAD/ZGAgAD0IHA=
Date: Fri, 9 Dec 2022 16:53:47 +0000
Message-ID: <BL1PR11MB602591A00CE052373BB47EBCFE1C9@BL1PR11MB6025.namprd11.prod.outlook.com>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com> <20221206062604.GB6595@lst.de>
 <Y48+AaG5rSCviIhl@ziepe.ca> <20221206130901.GB24358@lst.de>
 <BN9PR11MB5276EBF06791EF7B39648FA48C1C9@BN9PR11MB5276.namprd11.prod.outlook.com>
In-Reply-To: <BN9PR11MB5276EBF06791EF7B39648FA48C1C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB6025:EE_|SJ0PR11MB6720:EE_
x-ms-office365-filtering-correlation-id: ad22cd8d-b7f4-44c9-9497-08dada05f108
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iBfhRS8z0U4QvEJ0uHf2C8//YlRuoYbCI9fButEEg4wavK6EslvJ+2Yya/wc29JGjjtcywOy78am7HGZm3WpBw08JLhuwE2bdLqpVwDqC2EHPlxfRfyDXdm5Co2mdMeyQ0PHj+ESQs/VM2+sfliBu7CDAqrW/p1pIjfBh9SANDnsSnlHqJnCJuE6VouDbQjHUyanDi+yHc3YJ3hzSyZ3peh3r2Jbl7f6d1lpkh9N+OFDZVqodaffnMLP1peUEAavKr6f266OtDsZNyTc7vQGrZkNns1NYFzNZ1Ut/T4MOuMC4gpxHd+2+oh7cLEguF/XPfxydqNpWUqluu4J8uxUYZF89rA4fqzHmU0QfjaB+DFGD9qtGLQhJvKvgQSBEN1Au4ieSxmXgAbHW3Wmi534f1cTGxHh9X1+X0ula0V+HDkI1rHBjk5yvD+ac0bjbEcvifaTEsVhyZjdYDBBWkhoQHk3bvl5HT1zJtcq3fXx/xB+h1NwE7e+iGnn0BEfbmViYzF/SR/67sSENaTtpVnO5iLut/mVu52AyecgVdmzGhnyOENDnLe6sSW+TO6K2xUbBVSof4eSJMyG+gnh+rILQJTYYvyWb4pTfURvXpg7mezdJFTtF8V1cChPNkIPTlt9gxBKgoBmAqPN/JWDWgOf2EVb6po3xQ2krwyV6G5klxNkjXYET7vhQY6lI73HvUO+iGa8Cv9FAbhHLN5i5ZDB7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB6025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199015)(76116006)(66476007)(66946007)(8676002)(66556008)(8936002)(66446008)(4326008)(64756008)(33656002)(52536014)(41300700001)(38070700005)(83380400001)(186003)(9686003)(26005)(478600001)(86362001)(38100700002)(71200400001)(7696005)(107886003)(6506007)(110136005)(122000001)(316002)(54906003)(82960400001)(55016003)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kbaDHumxgYHCewTQXFZi6G2tax18h+V7x/E4uSa0EbQeJT3Gyoc86LylZSGC?=
 =?us-ascii?Q?q9d/vJLO5YzJAWtnDpe979/jSqBA4vym0xBp0jmp18P7Xum63AB9RFBrB/ew?=
 =?us-ascii?Q?K3Y1qYZ7/l7onXFMPGRNu7wO8aC2d4gXWtHyJSLZXwIZRh1vQCIvkJlUcf2V?=
 =?us-ascii?Q?ksAT1rewyRr5A1OS/w5DjiFRgPrC621QPn9zl3+FqWW+H2e0P27/LX2bhPEU?=
 =?us-ascii?Q?XhqQYhYufvmNiwIRKd+5/wctlUV+C2vhtD3Lpav/YMV/hAcfTwxasDVFyJrt?=
 =?us-ascii?Q?SQcQTKVhiqFwj/SYp1iKPiwqqn5IOmKGflzjs6i+88z/M/W0WZgx31uBUnQN?=
 =?us-ascii?Q?UU4HyD8oJxKEVQiEvPDSGWr+yqsRBq1+X9412ER+Fki2kzSfCGYOW1WH7ueV?=
 =?us-ascii?Q?oe3CxdX5gQ/fpaqGTWpYayQEPJNgiBQEtt2CtGNdUR29aiJKCHu+8VmJqRld?=
 =?us-ascii?Q?oOIfdM+sCKpWFWyXRZpwAHvdOqvAF8M8so+4iuacMo4xFDVGaFULlXIZITRy?=
 =?us-ascii?Q?64I8ZKrc4B2DKtgX85Edthr3NLoqAOHAbYpYJGt89C0Q0neUIpksBqdddbn7?=
 =?us-ascii?Q?yNxx+8LNztFX1rJ9IMuqdF492j//EWE7vR34bg8RqcBEQ4tDv1M1bwjToggv?=
 =?us-ascii?Q?SXNiZYArW6Jw/mOqsBUUz6qvO5bG+rIULwh9eI2roQoYKlF0/KPgqza5DiTE?=
 =?us-ascii?Q?0xQzGfYCVw1MOTYC/xmqSMhqWrR3+PoYpc+AlGUR87QFk4UOfVy5hciUfJAD?=
 =?us-ascii?Q?XHjOOZ7a2KpCFPEAwrBGs7E9O9dJkbcNEKLddJApv40sf1NULwhi9c+A1IZE?=
 =?us-ascii?Q?8eKXrEE69dwkukmocIgAk9D9SFyyz2/lR5xLXSos6Ik/OE0YI26Yo32cfwDB?=
 =?us-ascii?Q?6wOuPCSN0tdp2kyqCFh/erLmOm4NDbLmkiqykGuRNEeksysfayk21m43ngPv?=
 =?us-ascii?Q?067urm/EWu8Q3WqYoDbkUAt4Nc67ZIOkZhNXP/lAjRQxDlZy+XTB0780V+ZO?=
 =?us-ascii?Q?sPQxT90QPzhs/Pq/9xe7b0RFAdiiNCqWkxo5RizJyDjDRn0KYmqKEoaivswW?=
 =?us-ascii?Q?UuM8oWGBFv4HuBJEB5mpa9i4NFA9S3cABpe8CIS3y/qC0EAIme89WNG1nYD3?=
 =?us-ascii?Q?iPQwTvTfPq8TppevL6fLE6DVpkIhR8hueK7N3TU9uJinK4AAiwyVJQdZiPZ6?=
 =?us-ascii?Q?38tY/3Gybo4xCzrLFApK/3FBVMJiOK8hYjXvYwEGlWjnCaL/t4bTr/hqwt/b?=
 =?us-ascii?Q?zHh7ahAwoi86LkzNjkdNdpW22Om5MEg2tLcDRQ5of7Zsk7/7LOxOwXoKJqVH?=
 =?us-ascii?Q?ZPIt6PRzSqQT/U7iurjh9b7TUFdAR9RRJDipVxvGaILKcbSS02rTtvTGhK6X?=
 =?us-ascii?Q?AO27eJAtG/MZkJMi6KmdPNUGN/teRCgUk0qCKvU0Yrbu+fytLYWYhHlG+AJu?=
 =?us-ascii?Q?2dm05a0hzZXGEsCsU+zozuBOzt2qByscnoE5qO4MKWhdYN9VgAPYiw7qOClQ?=
 =?us-ascii?Q?pczO+qjB+58m6pLtGgeo1oDj3G3zGh0lkNOD5kynsm7HQpMcWphjPtglHagZ?=
 =?us-ascii?Q?0wMlR5ncGi/ue7+wmHK15fgUecxgXvkIehJM3FVW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB6025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad22cd8d-b7f4-44c9-9497-08dada05f108
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 16:53:47.9597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zE0R0JRwDmmq0J5Ow0r7O7TZ6oBlZyMlR7LrLUIVt+6wQkFK0hk8wXNjP4fXKi8ekolGC8ljxWS20isAZEL+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6720
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221209_085359_095070_2F5746BB 
X-CRM114-Status: UNSURE (   8.40  )
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

>From: Tian, Kevin <kevin.tian@intel.com>=20

>Not a NVMe guy but obviously Intel should join. I have forwarded this
>to internal folks to check the actual status.
Intel team has been actively participating in the TPAR definition over last=
 month.
The key leadership in NVMe WG, Peter and Nick (from Intel), are on top of t=
his TPAR,
and help influence the scope of the TPAR to better support IPU/DPUs.  IPU/D=
PU is a
new type of device that desperately needs a standard based live migration s=
olution.
Soon, you may also see more Intel people to be part of the SW WG for the NV=
Me live=20
migration standardization effort.

>And I also asked them to prepare a document explaining how this
>opaque cmd actually works to address your concerns.
There is nothing secret.  It's the VF states including VF CSR registers, IO=
 QP states, and=20
the AdminQ state.  The AdminQ state may also include the pending AER comman=
d.
As part of the NVMe live migration standardization effort, it's desirable t=
o standardize
the structure as much as we can, and then have an extension for any device =
specific
state that may be required to work around specific design HW limitations.

