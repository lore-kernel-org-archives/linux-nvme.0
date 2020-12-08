Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86149C4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 08:41:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A0C7235F9
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 08:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0C7235F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ih2+cj7j2mT8ny0dqy7M3rO1QfLVFi/eqS+SOrlvRS0=; b=iqDAtu+wwN13Oqku6EXDtLTns
	r/q4TjaFQ8roiKEKcmCTiBUuMWmmJbOIptg8GlGhEBP9j43ahw/iLe18w8ZSWqRsudAHBCsrmzWxs
	5Od+kftP1DLj/1l+2yD8mS3k5toaH6R5f6BaHYthkOmc7fFIKTC1CuErZvI/xFgphjN19jzTKYplt
	+e6O8YCPZ1nEiowE2Gz1HKXxiMErzO4PFZz9N3ihV9gQK2nqcdK5gSBNCxMp44Tm01G8usy3Xfg0t
	qs96FHLdOfXbswOtmZTPKOqo/cBxXzouOvfqMxQGp9rWyj/46KRTQHGTO0QfP6eloqHOPCq0F99Vi
	PAkLV0//Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmYYF-00088X-Ft; Tue, 08 Dec 2020 08:40:51 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmYYC-00087Y-N6
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 08:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607416849; x=1638952849;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=vI+z36yDCv11VcUgqj0e33apteJLZMKEwiGqhlwp3d4=;
 b=nwhWs2L6AnWZsCLvUCv8fk4fUoDeZmO40NL8KTiiro6TcROqlc2yNILc
 5Tlo2qIwqtNmT40ByEupvXJRMTeozqaeXN1uttt3WWqX9qq1kCgZTyHSM
 1fUO428g66nK5FnfmTZROLSh9u5K+i539/f1+G8qbpnae7nYgJ+9wfcyb
 i92eBk/sqSEyHXRQzGzTCUic6c/N+lZ1ofOl658QnXjOiZRDg6YTUdPrd
 0Bq/osvtoISgBxINGQmskmUzdxvLyGqX6q8BB15CQ+6vt8hCwir0v84hZ
 J6PN1+0k/kU/EgO+VtuUqPt9al2NKYBRf90LednCk/jYJXvhH+At4QRc2 A==;
IronPort-SDR: tojNOJt2/GDmvfTULsY7Ex+RMhlRTsTML9USz2vIZiyw6YP0ug5Nj0LiYqSToLVdZnfbnlJ01C
 Zqq4GN+UDmAnj55Z252fju5xUXm31QJ2qlPJTCCAXNmtfLbbbpVz3umjXYMsDDMCX21IZu2sx+
 xV12+JBmTtddJYCPBndQDKz5+3hLqCMfq6flxBC3gPh+XZjSBPR/Cjko3rXN/bQUTlhWKylA1E
 UA6ocLNWddRQ9DHKyDFFjlWK6/af/txty7pFPRtx+G0RAoLUxJYcyR+KcSWLcOaB6LgfqytMEh
 Sio=
X-IronPort-AV: E=Sophos;i="5.78,402,1599494400"; d="scan'208";a="155882990"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2020 16:40:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIpmGPbZkfv0LFBUZ+L5agt8KdZcqTglzH2XE0N+f7XhkiSOBQCoQFUX8Eof7dRITT6kBMTBjNhwWbHss5RwP58waKOv5Igg7xLSECI9rlN8bieRWnkWs0sYqBlKf/QKb5Wh5j9l7RXsmFe3TDl1rrDhArGs6s6ooDfsg7TzUkkiVFGXcjH4EtTX4Gv6Ll2sRv6xjB0f7zp1WDO+0G4hWxVI/n8kLJbWCZWBNdzg4gesAGrZ3uxO9lU2ifavyfjvAjTY6i300Be07uznbazjYqINm8sw2YA8hd/0C079oQrhVazFIyiMcXzONdzMB3zOHFNJatBwQtLpTQqGwr2NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI+z36yDCv11VcUgqj0e33apteJLZMKEwiGqhlwp3d4=;
 b=Ri2NHO0lJxNZ5VAPTfAtfnnxZtdCvaqd+LYxdS8YKhs6/sopDKYUkDaPVxFba5+Z23RcziUN8RNK1HiuvJoeBv+tjnlgENtvW6Cx56M/f8cqqU/yelrOEjltBop8A6V7BBcA4sjsOaerNNU7PpAAxe/yBeM298R4rJpxo8e9uPmdnhFICRaHlOotaJMjNKglGjd9pJsdNCcUm+OtyI1g13sNI1gYKYgU58GSS9D3A5x3xIGlcp/TebXd/YIdVgd82MDYUrxiQ9OI0QSnD5j3WI2bOP1nkW3kU/Bw8NnjLnwJ9Bn30Z3kmz6OV0ipQjutIF7xYbT8mrDYTZm87YoU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI+z36yDCv11VcUgqj0e33apteJLZMKEwiGqhlwp3d4=;
 b=vwI+Xs0XJNrdlcENIQgeTfcp9OVIL2BvQ+ocbW9adzycUNXwGL1tGv2h/fcX0q1S1Skn0mVvR0Mc4BUirwowUAEYYAoIfJqICqMgC18K2dPABEFmGCits2qMxbxOtP42Ly5bqgPVtA10CVmv2tiphnpi16tw9+CHq5ZJ0AK6LLU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4685.namprd04.prod.outlook.com
 (2603:10b6:805:b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 08:40:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Tue, 8 Dec 2020
 08:40:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>, Hannes Reinecke
 <hare@suse.de>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Thread-Topic: [RFC PATCH v2 0/2] add simple copy support
Thread-Index: AQHWyi08xMuKL73ZZUaIarInYKlQvg==
Date: Tue, 8 Dec 2020 08:40:41 +0000
Message-ID: <SN4PR0401MB35988951265391511EBC8C6E9BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
 <20201207192453.vc6clbdhz73hzs7l@mpHalley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6232f46-9985-4873-c699-08d89b54f26b
x-ms-traffictypediagnostic: SN6PR04MB4685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB468539606AEF3F2222671E649BCD0@SN6PR04MB4685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3LGgpj+gCMajQIOvXv6NE2Yvr+S+Q1P66exy7VZIj3v+SYh7buoJLneeyRfyXroNOn0ztxHnYA8vEr1ClPe0qtqyKg6zwndfc7fjEDhnH5PcwJ2Vqkre7QfkGd3FGHs43tmOlH+vxomkrEBmAlw4l8bLR1bdhC1K1BFV57Zz9cd4VVmBrVrZ7qIhTzjCioerRdgJhT4e3hYc4Xty/+N4Rm5BwoE1ni6660ItRIEY+LUNwJ9Nf3ePK+ogGWv/2zjIQQMnWUUET4vtDfakzNClhKVEAsPsbzKF5t6xUPv4W9RNkeJ9x+Za/NUlL/tMius2IdEHBpVPdaxQcDgOFsVi7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(8936002)(83380400001)(66446008)(66556008)(316002)(53546011)(2906002)(33656002)(76116006)(26005)(5660300002)(6506007)(91956017)(64756008)(4744005)(55016002)(86362001)(66946007)(52536014)(54906003)(186003)(7696005)(66476007)(110136005)(71200400001)(8676002)(478600001)(7416002)(9686003)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?zdk5Tt2WBtEqw48/dhHoSqKtOC7Mkap7mP7x02BhRb89x9Kz0r/A/dL+Hl?=
 =?iso-8859-1?Q?rMQJtq2xoyEAEAC3TH50VDGdKV68nYZgHE61YJmm2UwpotHzHfN2Wq3MLD?=
 =?iso-8859-1?Q?yMlanT8t0mNBPxLXulRU/JWfxISYV0/55ep+vEMLLskBC283HvHmw/QXxF?=
 =?iso-8859-1?Q?Ix6Q8BLzRZT4FH2KsXYdl547KhMIK/3PXYdayMBj/f6ZxY9EHdCIW38C3L?=
 =?iso-8859-1?Q?g1aH96mu9Y/l0ovlRxm9w4zSsGWSxdba8aNwwki7+njchhG0IbpyzbMPaf?=
 =?iso-8859-1?Q?Ayvegty6B08b3sCJwkGf2x5XgCsXpyegpyC476RKA2Z20V6Ck0W6aZNn4P?=
 =?iso-8859-1?Q?4rNGres69GcVpStqKpKeFziHwIJVSKL7ZLBPeyvezic/FKJsP0yXWUZM3Y?=
 =?iso-8859-1?Q?3M+E5vBO4FMgyRElazMRlcfYLHw/Os5FDDI6Thq6dAaguKL4aslRxGeiZd?=
 =?iso-8859-1?Q?c/5zNMd1Jg9Z6quL1+z6MbakacoBsBIosX9JJSANI2Gbe/pdyIU5VzkdEG?=
 =?iso-8859-1?Q?GyIth7tDCkEUMG62a7FKVD+ivUfYZ2NmdEo9B9ra2gFL7jeF1b5KanEw/Y?=
 =?iso-8859-1?Q?hXYMzUfdHIdFZjzeJhGZLwY730JhAP+mKFFiVHIFAmeiLlL1x9EIPCs0Qd?=
 =?iso-8859-1?Q?q+Uy38r8I8CyxPMi2AbWzGMjpE24lWeFScvSjE1pri5wMc8QmT+yCJyJb/?=
 =?iso-8859-1?Q?+EDO5md1Ra5bFA21pLUa9An45rfBkgzUWFeHftnS7VGTpx/Ye4VEHW/0vz?=
 =?iso-8859-1?Q?L0aS0WUfsS7kPq9ivP6hWjKRrAYD5Y/ez2lJx0pWMXe3ZFkoftJDAteUaG?=
 =?iso-8859-1?Q?/y/w02L7j9LfWvvEG3mBSeCdK3Co8sTCRpdo79HoK9BqS7UXsOqsIQ5I6B?=
 =?iso-8859-1?Q?diE8N0Uniq6A+RUKqWDTTEsl+rcOyeGEORBesZuv9fVXvRLfd/OhsgV806?=
 =?iso-8859-1?Q?xUdRZRc/aWJlPIWZdUpaRicDd30S6VPk9ydrqyTI7OSTn1JjPhCpa2E9W+?=
 =?iso-8859-1?Q?CAvpfN2l7wdsgkfWfyMxtFyoJfG6UsT3TTY60m?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6232f46-9985-4873-c699-08d89b54f26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 08:40:41.8083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5f3SENs6K3SN1aPr2ineoVlrRSyV7/y9Og3cAswZBquhygTMpX45newZQyzpPDZnTOqJ4hXAboptAb7uqc4chBEDr7rMPngq6rkla6rsm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4685
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_034048_893350_BD0B0BFF 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 07/12/2020 20:27, Javier Gonz=E1lez wrote:
> Good point. We can share some performance data on how Simple Copy scales
> in terms of bw / latency and the CPU usage. Do you have anything else in
> mind?
> =


With an emulation in the kernel, we could make the usd "backend" =

implementation configurable. So if the emulation is faster, users can select
the emulation, if the device is faster then the device.

Kind of what the crypto and raid code do as well.

I'm really interested in this work, as BTRFS relocation/balance will have =

potential benefits, but we need to get it right.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
