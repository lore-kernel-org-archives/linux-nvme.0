Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EEAC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 10:40:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00D46141C
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 10:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00D46141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=micron.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bq/ZMdjtG8ueN6cRag+9laTh3otsws54nS4iIqnWZDg=; b=lwa/9roHB6EBZq
	g0q+Nb/hEG8aqFyEjOp3Gy6B61CvEfb1z9bzLI6sA7PtzAVQyjlQrfx6PFPwjRsYkJGHwOI79/kdZ
	NQIEj03KKm7f/5SQzb3Ylum27CtGNg8mkmtw+kgZowQDuaKqyliJyYzte/cC3kbul7h+U3Q/7yWWZ
	BAlpmA9DqEbwMwuw1GhuY8WKSX0Ayf3LG6PX/0wSL0SZz0dMQ5dbqEpAkysPeMGC3tA4RJMXrn/8m
	gfOk+iHOu6cIyVrQ35Nl5LKOfLUh76EGMUW896EJsMp9I9i8iz6GpzDO7V/jFWsIQkY0EY+DOLIYn
	PPVdRd9iA06MkCQwhM5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0M1d-008bwA-O9; Mon, 05 Jul 2021 10:40:29 +0000
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com
 ([40.107.93.47] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0M1a-008bvF-Hk
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 10:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+Ys+z61ElsQSK6nTfMAimKRrdDKPN8T7LrxFiiGafdeHss+15NMZH8enZkrVZM4DpjJojYC1LsrnVNfkcFg8T25nolMh3TLGKX84WIYA05CQP1mKEPWfj9OJcSAG/OjVLPjl3E0QNDFk8LUNKGwVvgpVdkNZonaX9lqxRoITwPlWv2GrB4xhX1kJ8R1oJ6dAs268bz6csI5Zc073Rj+FClieQlO66YH3pnEzjh8dVviypzmGTWWKCxZnHLjgifDv6ieZ+WBLTnSO6siXtvES762AJyD3OBF8KTnxfuJbCkCZXO8OmUrTT2ZlIYkzmRBSvYZABK2obP2afA0aOnhmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8n4NC91Ol3TQAYiY3Nqp/2LMQMMcm0NhKq7KESvfKI=;
 b=mZWtd0T4X4jdTX0/tGmsc3TueVVEC1BnjCIsjnP1tZAAyygY9RnjJ5dtz7JCOIaRMaw7MQitwukXL5Y6hYjmmZ/gaXfa/C3e5G1egvc9AG1WV+2g4YK89r3n5WGrHsS+qRBiS5EbxD2wssxoE+3kH5bXDLQj/aC7fHxuYLnJ7PQC0/ey/bFt8gx4UyAH2fBgElaNtndD7tmngvE7OjPqvKMazN07eovUlL+fSYtzUqmORMQHo9PdjlRFJWFXDFtMVfpuuPPBig/EVYFSB5sTbDZ71pcznMrlcPXytfU1LQIxmK/oWsDiUkQPt3SREKzEWuTkELwTjNehVluFRwXL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8n4NC91Ol3TQAYiY3Nqp/2LMQMMcm0NhKq7KESvfKI=;
 b=gU4rXQq9Rb+1e1rwMjIi0lYo5DCZq6lnEQV3ilj8zuvxrZ2tcHpj8Ev784jig8/yD2OnmevuSREWwOD/GRhD9k6yVQZ41bl2fZSsMJL1AsRyJdf9OV4a9OgharxuLt1kTdZ5AiwUD89MmHGj8JKwnBDCt1LKBxL/1WYew2IRgIw=
Received: from BLAPR08MB6900.namprd08.prod.outlook.com (2603:10b6:208:325::21)
 by BLAPR08MB6866.namprd08.prod.outlook.com (2603:10b6:208:306::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 10:40:22 +0000
Received: from BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516]) by BLAPR08MB6900.namprd08.prod.outlook.com
 ([fe80::fde3:800c:617d:f516%7]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 10:40:22 +0000
From: "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "shiva.linuxworks@gmail.com"
 <shiva.linuxworks@gmail.com>
Subject: RE: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Thread-Topic: [EXT] Re: [PATCH] nvme: Add abrupt shutdown support
Thread-Index: AQHXcYbB/F8jcejucEauG3F+rz+Qo6s0K71g
Date: Mon, 5 Jul 2021 10:40:21 +0000
Message-ID: <BLAPR08MB6900B02E65B542A2C2F174E1B81C9@BLAPR08MB6900.namprd08.prod.outlook.com>
References: <20210705101157.1009135-1-sshivamurthy@micron.com>
 <20210705101554.GA12803@lst.de>
In-Reply-To: <20210705101554.GA12803@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2021-07-05T10:40:19Z; 
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=87f173d9-6d34-432c-b96d-eca6df33f28f;
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=3
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=micron.com;
x-originating-ip: [95.90.192.255]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61894d90-c718-42ce-b966-08d93fa14a6a
x-ms-traffictypediagnostic: BLAPR08MB6866:
x-microsoft-antispam-prvs: <BLAPR08MB686611F9C10198FA7714036AB81C9@BLAPR08MB6866.namprd08.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TGHXLKpajgadfdQE8/m2Nsdvl2S3h8ZF+3wWgV+FJCixWMf4O7VoyhQuYtg3OGx5IzZAX+fMWF2LbekXxep+p0JWpKAYPdvYCiZ3NwYkTrQO5JpbZoJ4G1CcbFCSiP4O4PnGQXl0SZ49OLAFOnfUIn0T3BVWG6g46jPaCTBcr0NuS0d/n0mmxJQ0yddSymFjPYO+etx74HDCGAcmZHXfCQCxAaXd/2p/wO4r6GC50HttdAHxE0Il0S9m7wvjbc1Ia6Qmlr+Zunf23xxb1LPSaxv8pbju1YFxVKG36u5qF9fjQw3f4vl4VsDva/U8YzpTRZD/U5eIb8kXUQJhJtnQIQc4f1cshNs4Sdzn7V2ngqd0JaRYRkeVlZFtyqp5asb7Iw5yDKrRy4+N2+aefniCCnpUPO+AmL5sZQF8tWLcToTURMYRpx3YzOMss5qP6zla4P4OaRFbdIJiUjZyqVrz9W8Xc2OSvQRnwFlWB3AxMfyPNuEDeURce9sDkb0SlBPI6M2uZh6IcB4TiZtnN+ECI3KPA+GWD/G6AsczuELQz8KBxvSVRrMl6NiYKhEKM40/RGpWKuballGjK7oPM3L3xdrS0zk/vz1x6Rw3GxP7vzIbn8TKop8NpSAcU5sLsHj7rxXrtXmwn539RqGcckXP9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR08MB6900.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(478600001)(4744005)(6506007)(122000001)(6916009)(7696005)(66446008)(186003)(8676002)(38100700002)(52536014)(86362001)(54906003)(26005)(8936002)(71200400001)(4326008)(83380400001)(9686003)(5660300002)(66946007)(64756008)(66556008)(55016002)(33656002)(316002)(2906002)(76116006)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VnHcEzIev2VSZwfrqbS/78Uc90HHQi11dQuk8+gY8Vodcw4hFvhZddiVteF4?=
 =?us-ascii?Q?FWzljbe85V5eTVS+2DuQ1IiBRubzBHGi0V7nrPwM6ga+t0msg8Kw5rh5mQLz?=
 =?us-ascii?Q?cRsEi5qhMyeQrektosEvh/J0om88c4DlmYt6gaI6UmH3EQLr1j3BAs6pp98/?=
 =?us-ascii?Q?Umi3GE1yfoDTJdDlIdnce0PReRy19qJXobbWKfKRE+BNoVQP/QaUAQe7BUcA?=
 =?us-ascii?Q?dirBND13eLtTRDguEzSqrCw2f2jZoeOENutLYW9aLmxzNNULO6nJJobyhY5W?=
 =?us-ascii?Q?LQhmC3Iva0Ty9kWDHGOtnnTbnu0xc2giCe8AIdhW3n0nk/SAbTJEu0nhOI5Y?=
 =?us-ascii?Q?8gJUE0OtDWi8+TE61+M18rIsoXhsl7h39FITRhMdrtRqc/FG8qTFLAT1ryCA?=
 =?us-ascii?Q?OwLYjQhfvr8XBV08nxq8BfwHvypuHtKmDVh6M2v4t8ARmuzOmurzo5lyXyVl?=
 =?us-ascii?Q?eBZWjfDKKb5yPRzCtP5nzBAhOCAIWO460wuehzMh3iplU1K3Y+jbFvLty7ir?=
 =?us-ascii?Q?FaVIe4OFL10V0rL82daLKYBtZBK/AoSffVC4s1KACY9XAZoSkWy0Z/9RpmJl?=
 =?us-ascii?Q?jb2z/PBTy9HYW82L7ECwoX27hfqfJ+hJ0y5Ql/1JIXj5Kt/sgEzk7dk95/XD?=
 =?us-ascii?Q?xgEdShgkAfsTGF0hUPKJkdEo0pJkLJ57DHB2fM4E9tV2pR7SPTFhv477cb4Y?=
 =?us-ascii?Q?fTWmTOuqqvEt6B98krZsiWHSokuNOc4Gis+sA+X73Gh9NaLk+/5Ayq13rjPS?=
 =?us-ascii?Q?DhOlgQWdAuWGa9cxw2Yg2SdX9bOEh7ccr/jxDywmLDSgk+Q5Wt8MdmW0hbqb?=
 =?us-ascii?Q?90CPu8xkzLycLJU47IU/XyQO4gioUqj5e0kRC5T8bloDwZUUtvFkCRBeRb8n?=
 =?us-ascii?Q?3NiS1JcBptjfc36KUvQr4IwBx1nu2ce6E9wIHOZRUqXfTi0andDeGV34F3Dq?=
 =?us-ascii?Q?6KRskbXDG5PLy+4dgXHP9L2+JzWERZzBu/g8ZZPfBqC672+5JAL/wGU6a/FH?=
 =?us-ascii?Q?4FA1GTfTm24Jr+moGoFmjDdmznqGDvvLlCZDwG6iBSIP78VVdFDyMHD5lyTW?=
 =?us-ascii?Q?hURknP4VwYM2xymU7TsWICGPWeb7YBjRKyyDfhRrx8ZQwhFk9HxZFhZSWEPS?=
 =?us-ascii?Q?3sSB99uM0ydgVMDcUWtkLylFAtrvdG0IsfDR5z9yBKLdhaF7DK9YdgCI5uqO?=
 =?us-ascii?Q?N09CBYyiXWGJVBHX80iMTUvadHm7RLTCPcRbtJrxjSLLGWvD83J4dMdKqTbK?=
 =?us-ascii?Q?70Rf7vrh16CgKNeG7aJJeH3qY869otD0hj9Rlyr5bFeWoIYmqCUlYC5Z3p9K?=
 =?us-ascii?Q?p14=3D?=
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR08MB6900.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61894d90-c718-42ce-b966-08d93fa14a6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2021 10:40:21.9303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnCDW6734ja1s5Z15P4qIk8Ob3IhCFfD9z9ANiP3a7f8EYH8FcUHf/jgup5SiAC/IM8h8A495oMRJsyQWnV8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR08MB6866
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_034026_640016_D439DF7B 
X-CRM114-Status: UNSURE (   9.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Micron Confidential

Hi Christoph,

> 
> 
> On Mon, Jul 05, 2021 at 10:11:57AM +0000, shiva.linuxworks@gmail.com wrote:
> > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> >
> > Enabling the abrupt shutdown support. In this shutdown type host does
> > not need to send Delete I/O Submission Queue and Delete I/O Completion
> > queue commands to the device.
> 
> Why?

This is to achieve faster shutdown at the cost of data in-flight.

As per the spec Deleting Submission queues and Completion queues are not explicitly 
mentioned for performing the abrupt shutdown (CC.SHN=10b).

Thanks,
Shiva


Micron Confidential

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
