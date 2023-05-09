Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8935CC7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KwfM10w0kiNJdouGdVHQLq+qTxE1Ko56Z1kMyEkFZos=; b=RX3u4Y8gqz3ptPmbmWTVB03V4X
	f6CDwS5B8xsW7O7o+pxUrnut+2OPNNUE5CbEYsdRQZlAfIzXyUHoezRiytKiNsJ3CCAbfVrwk5xRI
	Bi59veO449uuM8LlYI+aWnm09HAcg17dap0vNw/CSGeTzNA9w2XLChrsm0NUH4Q4NLvxrXVcDdvWy
	Aaw9zI6HnJ9OD9g+juVm8+mJr1zJEzVSf1EK7sD6pdJNwVOAM9AqaTIbz3XaDXmqqk/ocInLc9Kac
	OAbFkPJC71DdLhWGJUpKNAQcLsnrAY0EftHNrt3O/+urgt4zLZtiT98j0qBZQ5Q2krLzQcHYoaAlb
	2iHAPCkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwV87-004LO6-2c;
	Tue, 09 May 2023 21:44:19 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwV82-004LNK-0m
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 21:44:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683668654; x=1715204654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sfcwv5Iea6Zz6XkOmvFGnbQMdhBQXzf++OyugmkFFtU=;
  b=AkNKajjZyqXXzhR6OdPwTG7WXPmVpL7d1DCdAhVy2LNDNLDJetCsXE2g
   mD3+o7pI0YoYT0D65SpvqBrcPm/Hc3b1WVtEkQ3kOOytSFZEt6mDsSPNf
   ZnofzfTa1jbGldXS/UX6qmlH70RJc3kwN1NUESiULEPRwzSWUpVg51m/P
   LkO2r93109E9SNMeaxkohSwEsmLDLb52T0cPMgkMt0tHvaFdRcEkp0w7Y
   6ADCeBZlWTeggfeYuuC0UKq/MyNXZ2R0WFrHSX8fxlmp14BAeKlAsLMwj
   g2xykc4RWfKOqOAuJk0UES/zDUQ3A4cgvNUSJrvUmpE+lHZDC+xNBMM2L
   w==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="235251446"
Received: from mail-dm3nam02lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2023 05:44:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkfahDdTMRhdK9xJPp3MyvmIQRRdhJS4/d3t/MFN3VBGXLwWtczyACd02bYrS8N7bwRMNMgAEatXD21kKk+xoHCDqFlrBjQXDGyLGaZ7RnL7Y2k9Qvz3+xwNDY2zSztziSkUKTsodMSZbDl5lpkj5W5oIKENm9wkVInK19YuCqvR6mWq6VnNbthpuvVDuL+eE3+NB3kX324rDweB9Mf5514uKguHgB3aadiuIFnWw65Fc91VoxniwEbq06OjPwId0wcna/s8z4KM2STXu0oL7oxoR7dwUqaZ42ggJzXU0fStnX3RSGw/JXS9YA2REdNnc3lUiYIozy0vlNtYiCGA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwfM10w0kiNJdouGdVHQLq+qTxE1Ko56Z1kMyEkFZos=;
 b=gdJbPgSrK8sE5nZoXmRFVEijEyY3ALTU9XqhC7FvRJVu/l92t/s5IGOnr/+ydr/p5ejxGWvfoxaPbjOkoAR2IzNkS8HxTxBj3xl+5OeHJVP0ttYcCz8wb1n+ADi9UjB114DmmaP+XJ4dFaa8LSmMWkCiR/UY3gd2/7+KIAoURCPWy7vy3lDGkLOt3G4PVIMMEeH/EZYmusyxZ7KTCL3MN5WodAGtKf20W7rXWoNm2ooiGvmhOI54IQXWUW0Tr7XmY3dhshKuulDKjVoQ1CGXqhXdCqg6ZLODAC0HPR/76dFu+YQl3RSk+FOVpgW20uX8uxx/ckfCboydTdvhUyqZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwfM10w0kiNJdouGdVHQLq+qTxE1Ko56Z1kMyEkFZos=;
 b=Zb8ZHkUr9lPslAgJPOEYjnYLzuiGuycsJcU7kcZKHepY4TvDW2MYvwAyGEi4osFUDnZFBOlvDl1kgqtnZSK2puTcONenz5YoAemMw+tzNc+pLURX35q2H85NGTr4NwFy+jac43xJBRAFLdL7/GzWP/wBXeG/8F+DFdik30c1bS8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7273.namprd04.prod.outlook.com (2603:10b6:806:ea::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.18; Tue, 9 May 2023 21:44:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 21:44:05 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Thread-Topic: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Thread-Index: AQHZgn4Rs1M0AvndvUq4yG9OZZfZr69SecAA
Date: Tue, 9 May 2023 21:44:05 +0000
Message-ID: <ycdptic5i3aerzpzml7eitzb7wn7wj3vwk3bric2ogus6m3uaz@33zh62c3mmco>
References: <20230509135615.2061227-1-bvanassche@acm.org>
In-Reply-To: <20230509135615.2061227-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7273:EE_
x-ms-office365-filtering-correlation-id: 4fb90ad3-db55-423c-2835-08db50d682fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  dqCIkba8zuJvA9+JMqNmBOujL4Gljv/prPtxaFeN2OzT7UWshY6Gd4djOpiT37S10cta2gSfYif6hLC5UcmlwgJAWNPvwf3/W07ZKL962kTyw3QV3WJ5AheQ3OdNiAZ/MCNVJwKpT7a8Y3uUn/rjQs2QflEl4mSDYKA1gx7D7hP1nhI7dms34fj6wirBYVXtQBwaIbAYTh7SOB9QSNUnIkmdRAhQGqhUxgATGG6CCHjqzAVXD1bEDVe8NhOlPBfYanacsfzbHsA8kL2XCBGH1faG2EgfRmtP1Ui3kPDuQaP9PESStBZ4IorAns1MzIMcnjsRbTKrB9sBMX9DBfrWnEDXjs5pGfro0q3lvaTaYW65o5uJvigm3hiB3mfa9TjOVat5HS9FST8jU6cZek8Ymga3fuIP3sD7dvjuUg7Fan41yeZqWLX2/YfF/PKGqWJyc4y+ZvoX3dnjZxJ+KTJ6Apor/iHAr62TCHKIQxEws8eozxalChiwsOrsL6+AwbkZIO0rtD/ty9FJ7TN12E+Va5SAdtra90FrrXNbgRAjxQFBHefTuuP5X9IPB4dkATPoQoxREPoD6A3YIGDDhBsQFjCZpY5Y8pKZ5Y/4bfJpk5c=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(66946007)(44832011)(45080400002)(64756008)(91956017)(4326008)(66446008)(66556008)(76116006)(66476007)(6916009)(966005)(8936002)(8676002)(5660300002)(6506007)(54906003)(26005)(9686003)(6512007)(478600001)(316002)(41300700001)(71200400001)(6486002)(30864003)(2906002)(83380400001)(186003)(122000001)(82960400001)(33716001)(38070700005)(86362001)(38100700002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?0W4LJCqW2Dat6nvcmtyb/gHgNfJjHujj5BhWBC7//+SyTPU9dNpSOIJjIdcM?=
 =?us-ascii?Q?ddicg9obUhWWwZsqstvBEcFtkljjynKBkRQES2umrmmvIZchKuhVeIBpbqdb?=
 =?us-ascii?Q?Z8eli3U5VnT9uvvaMSZpXBYxeE5V1j4PY9qCnBcknh9thLPgXr04vS/rtt3T?=
 =?us-ascii?Q?b+ZwKDPNsAj8SVue3VmHcvTQGVMtFiXw0aU5fFyM1sVm4ieePwobbz6hiB90?=
 =?us-ascii?Q?Hcp4Vjhjof6YMMc7goafl0m6Yq95iGCvTpB+++kjJxESURcs5tW09dbUqkrX?=
 =?us-ascii?Q?+sM3PpEyjWFMozyo8EbkH0V2622fxBrqIxwL0CVjRrKsuFbppKzW6K2HXUF3?=
 =?us-ascii?Q?jWIYKWw53ktO0sxTfB/Hq6ZRmkn4OTfQ/2VgVamJO14e+2nn+FdCscBwO6HB?=
 =?us-ascii?Q?VYO08hiJkSmW9mqhblvT5eejI2QOk6I3baHieEmaD3CoKXKYWVUw1ikh44zd?=
 =?us-ascii?Q?MvPT6vX1rpdTiSURfvH3Qyy9BGhrnIaJaRdM5WiY28yA3AiCngakKz5CW2+E?=
 =?us-ascii?Q?44NKZWnbA2nHpOZ+9E87H3zNqiSfrrcoyeHaI6Urd3j1RIRzf6mPxaBFDUXI?=
 =?us-ascii?Q?PDOj5MyvLUCUdam5X55eF/sKGXU7BjpqKJm9dEfTmo2i0+gyXfauhhhMj8n5?=
 =?us-ascii?Q?GzxI9u62gDxu7YVhbn74C6x6xccaWryPR1TNWasL5M2HTwVcVqR6Ec++D0lp?=
 =?us-ascii?Q?WwUjukUov6N8OkPRC1T9af8y0imkL+1xWISihlqRXlTrUnvtUJmdAmX59rr0?=
 =?us-ascii?Q?yMA2XuHwytfVvNHMG6LN6rMQJ8OxPbpg22HvFbAutgWHSEqR/fk/QiYIPGe3?=
 =?us-ascii?Q?j628qlTnrtW6QFC9II96MCYTpNX4+yaowD3nYrW2SjuuZB5kz+CgA9yqVyap?=
 =?us-ascii?Q?L6FlMXIGk8IJKjZz+63dGWtoYTCvG7rVIEEJ5cfYTx2WSSprFeKGT6uFtkGA?=
 =?us-ascii?Q?dmCrmVQQ25Ohg164kpD3UVvBa4IgUJOuZYzVna3hLulKaAZtBbCo5adCIU7K?=
 =?us-ascii?Q?vjj21owZxkRau70Y9VOC2/1W9SPzSmNYZIv+E2Nf4OgDqxXYmvU15ojMHa3d?=
 =?us-ascii?Q?ISG2Dg8VxPtC1ll2IwAKOyk/odisIIqbPLg9wXG2CwOrMpkfhmX1RF8N0ywE?=
 =?us-ascii?Q?z9sj+X1TltNDoIGIuce19/IK3ASrQyXtmjaj9KJAtNa4CCRsCJmUW3ntXLdI?=
 =?us-ascii?Q?oVD8z9IW4JJIG7q6OOdk4Tl8kO4BJILksFy/tt1EJ/WX3q1te9ifCsmlf/rI?=
 =?us-ascii?Q?/u86zaNfgXYoveDsx2qpeFHm25df7DxlZOHHM8n2K+i1t0sqdewPbMgNokh0?=
 =?us-ascii?Q?enYsfBAo0N3c9Q8f9HwrJQ9lSG2R2iyObeROAtprm0dURbyNUK/bZWQRxdJI?=
 =?us-ascii?Q?45eRcG5O6PccnsWFEN4cyejs6FUZ5NwnUZLVVTmiFKWSk2oPMDrDaSXGcf/8?=
 =?us-ascii?Q?6z5ifFjOphFYvcmIzE/tSpzikSBe2RTmU8/f1QpXprpxuwdYX9UIOY+IqZOV?=
 =?us-ascii?Q?kqadHt1bzrXtz1KLwmmENduXWz46KCd88dk398Bvggi3E3PDnT1tyPFRfGmt?=
 =?us-ascii?Q?vFXLvDADmkR4vbdiQ+fW6tucI9LlMJJ0N/leqY6OT1SGCgSQD6JRhBoAKxAb?=
 =?us-ascii?Q?Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EE7ED91633CC14DAC4CC51DD0C2CE68@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?us-ascii?Q?oQ2ZTf4TBO7PMMPlJiRC4Xye7x4guSI0Rb8PKN5Lq6LBwqNxPe0v2OXRZ3D+?=
 =?us-ascii?Q?SwUj9Vu6KVq6yYTE1xgDITlxFzVU06YMB1kYn4oPl4bt2YgDDhY/KVntQ1Si?=
 =?us-ascii?Q?xSfremyk4tYa8mnD8rovjfqkYJIKuplLSbw06AyMdDIMoZtsCQSF7wS+Qz0y?=
 =?us-ascii?Q?LpPECqc2ZWw+FoZPfNrLykoEaIkE68/k+yNbLiDGJHTDfYM91RO8b5lOCSTG?=
 =?us-ascii?Q?kWuZq+SE8J5vnaMVEwPz2upNCHqRjpJMAH52sK+s2JRIWLaZ2VCOI+bJ2VGE?=
 =?us-ascii?Q?lqyjZgrIO2/aNaYNmyqhITn+BG7w34Z+X47goJRrpegjKlidc1g5r2AK2xtc?=
 =?us-ascii?Q?GMk0wkESK3VgxoXDOj963/rMv5Tzl7K1s55uGsFasSwTnPvWCtec0s6aTuh7?=
 =?us-ascii?Q?e57p3tKg8WvwcGx7f+YayTzpNlh04qfx/tqj21lrxU6dG1mfdSIc5BcMPFii?=
 =?us-ascii?Q?4nyB3wO3fnqDG+8qOGnXcg7Sj+cDZVLWH77DeYgAa2JctG3Z6Dpky5nYrUYM?=
 =?us-ascii?Q?2XJr7mK2YsqhMa9GS8+HywOwj0vJi6NXY0eDhPRWl+Iiv6iossRLZqHaP/00?=
 =?us-ascii?Q?iaAhxC9EaJtJ8Rjk4dRponEcSfAAY9r2NJwBH7D1NmPHCQdJWwEOlCXa9TDZ?=
 =?us-ascii?Q?L6zBEvL3eY/e89ofuapGwciOPlp8NEf7v8DnPeshjvE9Dyo9iveGFjgpswfX?=
 =?us-ascii?Q?RubGsiLwgis0W5AyK65dTRlGrMDopj0v6LPJZ6W6Vw4C5F74i36buZ4XJLw+?=
 =?us-ascii?Q?PEfbmsOSUMr+03uPPuMEPuoZhlUmSzj4eMWKKOsNeObLljC2kSwd3QvRNiv7?=
 =?us-ascii?Q?9faeyzPyc931horf4rpd1qOXMYAi5U8BD/tFQFyHfapO41y7Gixaw2mNXWoE?=
 =?us-ascii?Q?bVEQaQkDgW48srJgo9u7iG5Ii6kqA6Y31sqYNy4lVnSWZDvMd335xoQm0VnZ?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb90ad3-db55-423c-2835-08db50d682fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 21:44:05.3621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WmN2UgCOUKDS9rK3NdStspeCttaBiMOzA1umzT95KbjhUINWzEWXH9gl48XJLYVqWpjHXV4QwOCNysXnGAykgMcgiD6HPVZ78d1GYGQFIoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7273
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_144414_378404_8376F212 
X-CRM114-Status: GOOD (  18.24  )
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

On May 09, 2023 / 06:56, Bart Van Assche wrote:
> Waiting in nvmet_rdma_queue_connect() for previous teardowns to complete
> (flush_workqueue(nvmet_wq)) confuses lockdep. Clear up this confusion by
> by using dynamic lockdep keys instead of static lockdep keys for
> queue->release_work.
>=20
> See also the following report by Shinichiro:
> https://lore.kernel.org/all/rsmmxrchy6voi5qhl4irss5sprna3f5owkqtvybxglcv2=
pnylm@xmrnpfu3tfpe/
>=20
> This patch avoids that lockdep reports the following:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 4.19.0-dbg+ #1 Not tainted
> ------------------------------------------------------
> kworker/u12:0/7 is trying to acquire lock:
> 00000000c03a91d1 (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x6=
f/0x440 [rdma_cm]
>=20
> but task is already holding lock:
> (work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3c=
9/0x9f0
> which lock already depends on the new lock.

Bart, thank you very much for this immediate action after the discussion at=
 LSF.
This is encouraging. I applied the patch on top of v6.4-rc1 and ran the tes=
t
case with various transports. Unfortunately, I observed kernel panics with =
rdma
and siw transports [1][2]. Also I observed another lockdep WARN with tcp
transport [3]. It looks that your fix unveiled more hidden issue/s.


[1] rdma:

[  152.976378][  T972] rdma_rxe: loaded
[  153.026858][  T952] run blktests nvme/003 at 2023-05-10 03:45:55
[  153.113227][  T989] (null): rxe_set_mtu: Set mtu to 1024
[  153.127322][  T990] PCLMULQDQ-NI instructions are not detected.
[  153.285421][  T989] infiniband ens3_rxe: set active
[  153.286007][  T989] infiniband ens3_rxe: added ens3
[  153.406495][ T1005] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
[  153.416153][ T1006] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[  153.458713][  T110] ------------[ cut here ]------------
[  153.459534][  T110] WARNING: CPU: 0 PID: 110 at kernel/softirq.c:376 __l=
ocal_bh_enable_ip+0xd4/0x140
[  153.460296][  T110] Modules linked in: crc32_generic rdma_rxe ib_uverbs =
ip6_udp_tunnel udp_tunnel nvg
[  153.464985][  T110] CPU: 0 PID: 110 Comm: kworker/u8:5 Not tainted 6.4.0=
-rc1+ #4
[  153.465584][  T110] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-1.fc38 04/01/4
[  153.466370][  T110] Workqueue: rdma_cm cma_work_handler [rdma_cm]
[  153.466884][  T110] RIP: 0010:__local_bh_enable_ip+0xd4/0x140
[  153.467361][  T110] Code: 09 00 e8 5f 7b 3e 00 fb 0f 1f 44 00 00 65 8b 0=
5 6a a9 df 5d 85 c0 74 5c 5bf
[  153.468906][  T110] RSP: 0018:ffff88811d0e7458 EFLAGS: 00010046
[  153.469398][  T110] RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ff=
ffffff4cac45e
[  153.470022][  T110] RDX: 0000000000000000 RSI: 0000000000000201 RDI: fff=
fffffc1c78c5a
[  153.470649][  T110] RBP: ffffffffc1c78c5a R08: 0000000000000000 R09: fff=
f8881302b2afb
[  153.471313][  T110] R10: ffffed102605655f R11: ffff88811d8a3300 R12: fff=
f8881302b49e8
[  153.471937][  T110] R13: ffff88812eb96998 R14: ffff8881302b2000 R15: fff=
f88811d0e7590
[  153.472563][  T110] FS:  0000000000000000(0000) GS:ffff8883aee00000(0000=
) knlGS:0000000000000000
[  153.473296][  T110] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  153.473820][  T110] CR2: 0000561acc466184 CR3: 000000010b3ce000 CR4: 000=
00000000006f0
[  153.474448][  T110] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[  153.475097][  T110] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[  153.475721][  T110] Call Trace:
[  153.475986][  T110]  <TASK>
[  153.476248][  T110]  rxe_post_send+0xaa/0x29c0 [rdma_rxe]
[  153.476692][  T110]  ? do_raw_spin_lock+0x12e/0x270
[  153.477124][  T110]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  153.477533][  T110]  ib_send_mad+0x81d/0x1270 [ib_core]
[  153.478011][  T110]  ? __pfx_ib_send_mad+0x10/0x10 [ib_core]
[  153.478522][  T110]  ib_post_send_mad+0x416/0x2560 [ib_core]
[  153.479023][  T110]  ? lock_acquire+0x1a9/0x4e0
[  153.479414][  T110]  ? find_held_lock+0x2d/0x110
[  153.479810][  T110]  ? __pfx_ib_post_send_mad+0x10/0x10 [ib_core]
[  153.480341][  T110]  ? cm_form_tid+0x16f/0x210 [ib_cm]
[  153.481615][  T110]  ? __pfx_lock_release+0x10/0x10
[  153.482894][  T110]  ? do_raw_spin_lock+0x12e/0x270
[  153.484175][  T110]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  153.485439][  T110]  ? do_raw_spin_unlock+0x54/0x1f0
[  153.486700][  T110]  ? do_raw_spin_unlock+0x54/0x1f0
[  153.487937][  T110]  ib_send_cm_req+0x21b0/0x4730 [ib_cm]
[  153.489261][  T110]  ? __pfx_ib_send_cm_req+0x10/0x10 [ib_cm]
[  153.490554][  T110]  ? __pfx_lock_release+0x10/0x10
[  153.491806][  T110]  ? do_raw_spin_unlock+0x54/0x1f0
[  153.493009][  T110]  ? _raw_spin_unlock+0x29/0x50
[  153.494160][  T110]  rdma_connect_locked+0x80c/0x18c0 [rdma_cm]
[  153.495406][  T110]  ? __pfx_rdma_connect_locked+0x10/0x10 [rdma_cm]
[  153.496678][  T110]  ? lockdep_lock+0xca/0x1c0
[  153.497792][  T110]  ? __pfx_lockdep_lock+0x10/0x10
[  153.498943][  T110]  ? lockdep_unlock+0xf2/0x250
[  153.500063][  T110]  ? __lock_acquire+0x242c/0x5f00
[  153.501184][  T110]  ? __pfx___lock_acquire+0x10/0x10
[  153.502284][  T110]  nvme_rdma_cm_handler+0xa5b/0x2430 [nvme_rdma]
[  153.503441][  T110]  ? lock_acquire+0x1a9/0x4e0
[  153.504451][  T110]  ? find_held_lock+0x2d/0x110
[  153.505434][  T110]  ? __pfx_nvme_rdma_cm_handler+0x10/0x10 [nvme_rdma]
[  153.506562][  T110]  ? lock_release+0x378/0x650
[  153.507530][  T110]  ? cma_comp_exch+0x83/0x110 [rdma_cm]
[  153.508571][  T110]  cma_cm_event_handler+0xb2/0x2f0 [rdma_cm]
[  153.509630][  T110]  cma_work_handler+0x106/0x1b0 [rdma_cm]
[  153.510648][  T110]  process_one_work+0x7ed/0x13a0
[  153.511580][  T110]  ? __pfx_lock_acquire+0x10/0x10
[  153.512500][  T110]  ? __pfx_process_one_work+0x10/0x10
[  153.513448][  T110]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  153.514395][  T110]  worker_thread+0x100/0x12c0
[  153.515285][  T110]  ? __kthread_parkme+0xc1/0x1f0
[  153.516181][  T110]  ? __pfx_worker_thread+0x10/0x10
[  153.517092][  T110]  kthread+0x2ea/0x3c0
[  153.517911][  T110]  ? __pfx_kthread+0x10/0x10
[  153.518764][  T110]  ret_from_fork+0x2c/0x50
[  153.519606][  T110]  </TASK>
[  153.520329][  T110] irq event stamp: 894255
[  153.521144][  T110] hardirqs last  enabled at (894253): [<ffffffffa49838=
5c>] _raw_read_unlock_irqres0
[  153.522425][  T110] hardirqs last disabled at (894254): [<ffffffffa4982e=
6f>] _raw_spin_lock_irqsave+0
[  153.523682][  T110] softirqs last  enabled at (894234): [<ffffffffc18aac=
c0>] process_one_req+0x270/0]
[  153.525008][  T110] softirqs last disabled at (894255): [<ffffffffc1c78b=
e3>] rxe_post_send+0x33/0x29]
[  153.526308][  T110] ---[ end trace 0000000000000000 ]---
[  153.534478][   T62] nvmet: creating discovery controller 1 for subsystem=
 nqn.2014-08.org.nvmexpress..
[  153.540392][ T1007] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpres=
s.discovery", addr 10.0.2.150
[  163.615001][ T1022] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvme=
xpress.discovery"
[  163.640384][    C2] ------------[ cut here ]------------
[  163.641373][    C2] DEBUG_LOCKS_WARN_ON(1)
[  163.641381][    C2] WARNING: CPU: 2 PID: 72 at kernel/locking/lockdep.c:=
232 __lock_acquire+0x2903/0x5f00
[  163.643653][    C2] Modules linked in: crc32_generic rdma_rxe ib_uverbs =
ip6_udp_tunnel udp_tunnel nvmet_rdma nvmet nvme_rdma nvme_fabrics rdma_cm i=
w_cm ib_cm ib_core nft_fib_inet nft_fib_ipv4 nft_fib_ipv6g
[  163.651432][    C2] CPU: 2 PID: 72 Comm: kworker/2:2 Tainted: G        W=
          6.4.0-rc1+ #4
[  163.652977][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-1.fc38 04/01/2014
[  163.654420][    C2] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [n=
vmet_rdma]
[  163.655846][    C2] RIP: 0010:__lock_acquire+0x2903/0x5f00
[  163.657050][    C2] Code: 08 84 d2 0f 85 d0 1f 00 00 83 3d 93 f3 18 04 0=
0 75 b4 48 c7 c6 a0 1c ce a4 48 c7 c7 40 11 ce a4 4c 89 5c 24 10 e8 ad d2 e=
5 ff <0f> 0b 31 db 4c 8b 5c 24 10 e9 ba fb ff ff 4c 89 1cc
[  163.660132][    C2] RSP: 0018:ffff8883aef09ce0 EFLAGS: 00010082
[  163.661476][    C2] RAX: 0000000000000000 RBX: 00000000000006cd RCX: 1ff=
ff11075de136f
[  163.662915][    C2] RDX: 0000000000010003 RSI: 0000000000000004 RDI: 000=
0000000000001
[  163.664311][    C2] RBP: ffff88811b7cc218 R08: 0000000000000001 R09: fff=
f8883aef3084b
[  163.665758][    C2] R10: ffffed1075de6109 R11: 0000000000000001 R12: 000=
0000000000000
[  163.667166][    C2] R13: ffff88811b7cc1f0 R14: 00000000ffffffff R15: fff=
fffffa65622ec
[  163.668650][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[  163.670124][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.671561][    C2] CR2: 0000561acdb9d6d0 CR3: 000000010b3ce000 CR4: 000=
00000000006e0
[  163.673002][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[  163.674440][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[  163.675918][    C2] Call Trace:
[  163.677033][    C2]  <IRQ>
[  163.678113][    C2]  ? lock_acquire+0x1a9/0x4e0
[  163.679299][    C2]  ? find_held_lock+0x2d/0x110
[  163.680508][    C2]  ? __pfx___lock_acquire+0x10/0x10
[  163.681801][    C2]  ? lock_release+0x378/0x650
[  163.682998][    C2]  ? try_to_wake_up+0x102/0x1a30
[  163.684226][    C2]  ? __pfx_lock_release+0x10/0x10
[  163.685468][    C2]  lock_acquire+0x1a9/0x4e0
[  163.686688][    C2]  ? hrtimer_interrupt+0x100/0x810
[  163.687946][    C2]  ? __pfx_lock_acquire+0x10/0x10
[  163.689189][    C2]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  163.690506][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[  163.691805][    C2]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  163.693078][    C2]  ? __pfx_try_to_wake_up+0x10/0x10
[  163.694301][    C2]  _raw_spin_lock_irqsave+0x47/0x70
[  163.695510][    C2]  ? hrtimer_interrupt+0x100/0x810
[  163.696710][    C2]  hrtimer_interrupt+0x100/0x810
[  163.697889][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[  163.699096][    C2]  __sysvec_apic_timer_interrupt+0x146/0x3f0
[  163.700342][    C2]  sysvec_apic_timer_interrupt+0x8a/0xb0
[  163.701531][    C2]  </IRQ>
[  163.702505][    C2]  <TASK>
[  163.703455][    C2]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  163.704621][    C2] RIP: 0010:lockdep_unregister_key+0x105/0x250
[  163.705793][    C2] Code: 7c 08 84 d2 0f 85 29 01 00 00 8b 05 95 b1 19 0=
4 85 c0 74 02 0f 0b e8 6a e7 ff ff 41 f7 c5 00 02 00 00 74 06 fb 0f 1f 44 0=
0 00 <5b> 5d 41 5c 41 5d 41 5e e9 fe 6b 08 00 48 b8 00 00f
[  163.708701][    C2] RSP: 0018:ffff88811b817ca8 EFLAGS: 00000206
[  163.709878][    C2] RAX: 0000000000000002 RBX: ffffffffa87c2b78 RCX: 000=
0000000000001
[  163.711181][    C2] RDX: 0000000000000000 RSI: ffffffffa4ce1520 RDI: fff=
fffffa4fabf60
[  163.712451][    C2] RBP: ffff8881319b5ae0 R08: 0000000000000000 R09: fff=
f8883aef4626f
[  163.713705][    C2] R10: ffffed1075de8c4d R11: ffff88811b7cb300 R12: 000=
0000000000000
[  163.714934][    C2] R13: 0000000000000246 R14: ffffffffa894c088 R15: fff=
f888100e29118
[  163.716150][    C2]  ? lockdep_unregister_key+0xf6/0x250
[  163.717190][    C2]  nvmet_rdma_free_queue+0x2e/0x390 [nvmet_rdma]
[  163.718289][    C2]  nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma=
]
[  163.719418][    C2]  process_one_work+0x7ed/0x13a0
[  163.720387][    C2]  ? __pfx_lock_acquire+0x10/0x10
[  163.721335][    C2]  ? __pfx_process_one_work+0x10/0x10
[  163.722303][    C2]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  163.723253][    C2]  ? wq_worker_sleeping+0x36/0x200
[  163.724182][    C2]  worker_thread+0x100/0x12c0
[  163.725084][    C2]  ? __kthread_parkme+0xc1/0x1f0
[  163.726001][    C2]  ? __pfx_worker_thread+0x10/0x10
[  163.726928][    C2]  kthread+0x2ea/0x3c0
[  163.727762][    C2]  ? __pfx_kthread+0x10/0x10
[  163.728635][    C2]  ret_from_fork+0x2c/0x50
[  163.729488][    C2]  </TASK>
[  163.730237][    C2] irq event stamp: 17466
[  163.731066][    C2] hardirqs last  enabled at (17465): [<ffffffffa49830e=
4>] _raw_spin_unlock_irq+0x24/0x50
[  163.732306][    C2] hardirqs last disabled at (17466): [<ffffffffa4947a9=
a>] sysvec_apic_timer_interrupt+0xa/0xb0
[  163.733586][    C2] softirqs last  enabled at (17450): [<ffffffffa2249a9=
1>] do_softirq.part.0+0xb1/0x140
[  163.734822][    C2] softirqs last disabled at (17385): [<ffffffffa2249a9=
1>] do_softirq.part.0+0xb1/0x140
[  163.736059][    C2] ---[ end trace 0000000000000000 ]---
[  163.737030][    C2] general protection fault, probably for non-canonical=
 address 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN PTI
[  163.738476][    C2] KASAN: null-ptr-deref in range [0x0000000000000040-0=
x0000000000000047]
[  163.739678][    C2] CPU: 2 PID: 72 Comm: kworker/2:2 Tainted: G        W=
          6.4.0-rc1+ #4
[  163.740920][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-1.fc38 04/01/2014
[  163.742226][    C2] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [n=
vmet_rdma]
[  163.743412][    C2] RIP: 0010:__lock_acquire+0x24e0/0x5f00
[  163.744451][    C2] Code: 0f 83 a5 03 00 00 48 8d 1c 5b 48 c1 e3 06 48 8=
1 c3 e0 6f 7c a8 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 40 48 89 fa 48 c1 e=
a 03 <80> 3c 02 00 0f 85 15 25 00 00 48 83 7b 40 00 0f 85f
[  163.747177][    C2] RSP: 0018:ffff8883aef09ce0 EFLAGS: 00010002
[  163.748304][    C2] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ff=
ff11075de136f
[  163.749575][    C2] RDX: 0000000000000008 RSI: 0000000000000004 RDI: 000=
0000000000040
[  163.750844][    C2] RBP: ffff88811b7cc218 R08: 0000000000000001 R09: fff=
f8883aef3084b
[  163.752116][    C2] R10: ffffed1075de6109 R11: ffff88811b7cb300 R12: 000=
0000000000000
[  163.753383][    C2] R13: ffff88811b7cc1f0 R14: 00000000ffffffff R15: fff=
fffffa65622ec
[  163.754668][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[  163.756022][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.757214][    C2] CR2: 0000561acdb9d6d0 CR3: 000000010b3ce000 CR4: 000=
00000000006e0
[  163.758521][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[  163.759823][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[  163.761126][    C2] Call Trace:
[  163.762098][    C2]  <IRQ>
[  163.763008][    C2]  ? lock_acquire+0x1a9/0x4e0
[  163.764024][    C2]  ? find_held_lock+0x2d/0x110
[  163.765038][    C2]  ? __pfx___lock_acquire+0x10/0x10
[  163.766077][    C2]  ? lock_release+0x378/0x650
[  163.767080][    C2]  ? try_to_wake_up+0x102/0x1a30
[  163.768093][    C2]  ? __pfx_lock_release+0x10/0x10
[  163.769110][    C2]  lock_acquire+0x1a9/0x4e0
[  163.770074][    C2]  ? hrtimer_interrupt+0x100/0x810
[  163.771084][    C2]  ? __pfx_lock_acquire+0x10/0x10
[  163.772082][    C2]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  163.773133][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[  163.774144][    C2]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  163.775190][    C2]  ? __pfx_try_to_wake_up+0x10/0x10
[  163.776202][    C2]  _raw_spin_lock_irqsave+0x47/0x70
[  163.777215][    C2]  ? hrtimer_interrupt+0x100/0x810
[  163.778223][    C2]  hrtimer_interrupt+0x100/0x810
[  163.779216][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[  163.780236][    C2]  __sysvec_apic_timer_interrupt+0x146/0x3f0
[  163.781308][    C2]  sysvec_apic_timer_interrupt+0x8a/0xb0
[  163.782358][    C2]  </IRQ>
[  163.783216][    C2]  <TASK>
[  163.784068][    C2]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  163.785139][    C2] RIP: 0010:lockdep_unregister_key+0x105/0x250
[  163.786229][    C2] Code: 7c 08 84 d2 0f 85 29 01 00 00 8b 05 95 b1 19 0=
4 85 c0 74 02 0f 0b e8 6a e7 ff ff 41 f7 c5 00 02 00 00 74 06 fb 0f 1f 44 0=
0 00 <5b> 5d 41 5c 41 5d 41 5e e9 fe 6b 08 00 48 b8 00 00f
[  163.788971][    C2] RSP: 0018:ffff88811b817ca8 EFLAGS: 00000206
[  163.790091][    C2] RAX: 0000000000000002 RBX: ffffffffa87c2b78 RCX: 000=
0000000000001
[  163.791364][    C2] RDX: 0000000000000000 RSI: ffffffffa4ce1520 RDI: fff=
fffffa4fabf60
[  163.792626][    C2] RBP: ffff8881319b5ae0 R08: 0000000000000000 R09: fff=
f8883aef4626f
[  163.793870][    C2] R10: ffffed1075de8c4d R11: ffff88811b7cb300 R12: 000=
0000000000000
[  163.795103][    C2] R13: 0000000000000246 R14: ffffffffa894c088 R15: fff=
f888100e29118
[  163.796330][    C2]  ? lockdep_unregister_key+0xf6/0x250
[  163.797374][    C2]  nvmet_rdma_free_queue+0x2e/0x390 [nvmet_rdma]
[  163.798476][    C2]  nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma=
]
[  163.799622][    C2]  process_one_work+0x7ed/0x13a0
[  163.800602][    C2]  ? __pfx_lock_acquire+0x10/0x10
[  163.801559][    C2]  ? __pfx_process_one_work+0x10/0x10
[  163.802534][    C2]  ? __pfx_do_raw_spin_lock+0x10/0x10
[  163.803494][    C2]  ? wq_worker_sleeping+0x36/0x200
[  163.804439][    C2]  worker_thread+0x100/0x12c0
[  163.805351][    C2]  ? __kthread_parkme+0xc1/0x1f0
[  163.806271][    C2]  ? __pfx_worker_thread+0x10/0x10
[  163.807200][    C2]  kthread+0x2ea/0x3c0
[  163.808043][    C2]  ? __pfx_kthread+0x10/0x10
[  163.808919][    C2]  ret_from_fork+0x2c/0x50
[  163.809776][    C2]  </TASK>
[  163.810521][    C2] Modules linked in: crc32_generic rdma_rxe ib_uverbs =
ip6_udp_tunnel udp_tunnel nvmet_rdma nvmet nvme_rdma nvme_fabrics rdma_cm i=
w_cm ib_cm ib_core nft_fib_inet nft_fib_ipv4 nft_fib_ipv6g
[  163.817788][    C2] ---[ end trace 0000000000000000 ]---
[  163.818850][    C2] RIP: 0010:__lock_acquire+0x24e0/0x5f00
[  163.819928][    C2] Code: 0f 83 a5 03 00 00 48 8d 1c 5b 48 c1 e3 06 48 8=
1 c3 e0 6f 7c a8 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 40 48 89 fa 48 c1 e=
a 03 <80> 3c 02 00 0f 85 15 25 00 00 48 83 7b 40 00 0f 85f
[  163.822736][    C2] RSP: 0018:ffff8883aef09ce0 EFLAGS: 00010002
[  163.823900][    C2] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ff=
ff11075de136f
[  163.825209][    C2] RDX: 0000000000000008 RSI: 0000000000000004 RDI: 000=
0000000000040
[  163.826521][    C2] RBP: ffff88811b7cc218 R08: 0000000000000001 R09: fff=
f8883aef3084b
[  163.827836][    C2] R10: ffffed1075de6109 R11: ffff88811b7cb300 R12: 000=
0000000000000
[  163.829145][    C2] R13: ffff88811b7cc1f0 R14: 00000000ffffffff R15: fff=
fffffa65622ec
[  163.830463][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[  163.831867][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.833105][    C2] CR2: 0000561acdb9d6d0 CR3: 000000010b3ce000 CR4: 000=
00000000006e0
[  163.834446][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[  163.835794][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[  163.837137][    C2] Kernel panic - not syncing: Fatal exception in inter=
rupt
[  163.838585][    C2] Kernel Offset: 0x21000000 from 0xffffffff81000000 (r=
elocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  163.840211][    C2] ---[ end Kernel panic - not syncing: Fatal exception=
 in interrupt ]---


[2] siw:

[   29.856520][  T498] systemd-journald[498]: File /var/log/journal/02cb4e6=
014a94b2fa4.
[   53.344964][  T929] rdma_rxe: loaded
[   53.400627][  T909] run blktests nvme/003 at 2023-05-10 04:10:11
[   53.520087][  T942] SoftiWARP attached
[   53.621029][  T963] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
[   53.631333][  T964] iwpm_register_pid: Unable to send a nlmsg (client =
=3D 2)
[   53.634192][  T964] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[   53.687380][   T62] nvmet: creating discovery controller 1 for subsystem=
 nqn.2014-08.org.nvmexpress..
[   53.693404][  T965] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpres=
s.discovery", addr 10.0.2.150
[   63.762719][  T978] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvme=
xpress.discovery"
[   63.790054][    C2] ------------[ cut here ]------------
[   63.790565][    C2] DEBUG_LOCKS_WARN_ON(1)
[   63.790578][    C2] WARNING: CPU: 2 PID: 72 at kernel/locking/lockdep.c:=
232 __lock_acquire+0x2903/0x0
[   63.791589][    C2] Modules linked in: siw rdma_rxe ib_uverbs ip6_udp_tu=
nnel udp_tunnel nvmet_rdma ng
[   63.795785][    C2] CPU: 2 PID: 72 Comm: kworker/2:2 Not tainted 6.4.0-r=
c1+ #4
[   63.796324][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-1.fc38 04/01/4
[   63.797026][    C2] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [n=
vmet_rdma]
[   63.797607][    C2] RIP: 0010:__lock_acquire+0x2903/0x5f00
[   63.798020][    C2] Code: 08 84 d2 0f 85 d0 1f 00 00 83 3d 93 f3 18 04 0=
0 75 b4 48 c7 c6 a0 1c ce 92c
[   63.799425][    C2] RSP: 0018:ffff8883aef09ce0 EFLAGS: 00010082
[   63.799869][    C2] RAX: 0000000000000000 RBX: 00000000000006bc RCX: 1ff=
ff11075de136f
[   63.800640][    C2] RDX: 0000000000010003 RSI: 0000000000000004 RDI: 000=
0000000000001
[   63.801217][    C2] RBP: ffff88811bb54218 R08: 0000000000000001 R09: fff=
f8883aef3084b
[   63.801853][    C2] R10: ffffed1075de6109 R11: 0000000000000001 R12: 000=
0000000000000
[   63.802426][    C2] R13: ffff88811bb541f0 R14: 00000000ffffffff R15: fff=
fffff945622ec
[   63.803003][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[   63.803645][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.804120][    C2] CR2: 00007ff6323cc364 CR3: 000000021ca6c000 CR4: 000=
00000000006e0
[   63.804697][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   63.805269][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   63.805847][    C2] Call Trace:
[   63.806088][    C2]  <IRQ>
[   63.806299][    C2]  ? __pfx_mark_lock+0x10/0x10
[   63.806652][    C2]  ? mark_lock+0x101/0x16d0
[   63.806982][    C2]  ? __pfx___lock_acquire+0x10/0x10
[   63.807358][    C2]  ? lock_acquire+0x1a9/0x4e0
[   63.807701][    C2]  ? find_held_lock+0x2d/0x110
[   63.808949][    C2]  lock_acquire+0x1a9/0x4e0
[   63.810274][    C2]  ? hrtimer_interrupt+0x100/0x810
[   63.811531][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   63.812784][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[   63.814043][    C2]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   63.815341][    C2]  _raw_spin_lock_irqsave+0x47/0x70
[   63.816569][    C2]  ? hrtimer_interrupt+0x100/0x810
[   63.817761][    C2]  hrtimer_interrupt+0x100/0x810
[   63.818942][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[   63.820140][    C2]  ? __pfx___do_softirq+0x10/0x10
[   63.821316][    C2]  __sysvec_apic_timer_interrupt+0x146/0x3f0
[   63.822564][    C2]  sysvec_apic_timer_interrupt+0x8a/0xb0
[   63.823777][    C2]  </IRQ>
[   63.824793][    C2]  <TASK>
[   63.825779][    C2]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   63.826962][    C2] RIP: 0010:lockdep_unregister_key+0x105/0x250
[   63.828138][    C2] Code: 7c 08 84 d2 0f 85 29 01 00 00 8b 05 95 b1 19 0=
4 85 c0 74 02 0f 0b e8 6a e7f
[   63.831047][    C2] RSP: 0018:ffff88811bb9fca8 EFLAGS: 00000206
[   63.832253][    C2] RAX: 0000000000000002 RBX: ffffffff967c2b78 RCX: 000=
0000000000001
[   63.833595][    C2] RDX: 0000000000000000 RSI: ffffffff92ce1520 RDI: fff=
fffff92fabf60
[   63.834913][    C2] RBP: ffff888130ea22e0 R08: 0000000000000000 R09: fff=
f8883aef4626f
[   63.836204][    C2] R10: ffffed1075de8c4d R11: ffff88811bb53300 R12: fff=
f8881010df128
[   63.837473][    C2] R13: 0000000000000246 R14: ffffffff9694e678 R15: fff=
f88810112f918
[   63.838724][    C2]  ? lockdep_unregister_key+0xf6/0x250
[   63.839775][    C2]  nvmet_rdma_free_queue+0x2e/0x390 [nvmet_rdma]
[   63.840879][    C2]  nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma=
]
[   63.842021][    C2]  process_one_work+0x7ed/0x13a0
[   63.843016][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   63.844005][    C2]  ? __pfx_process_one_work+0x10/0x10
[   63.844997][    C2]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   63.845956][    C2]  worker_thread+0x100/0x12c0
[   63.846864][    C2]  ? __kthread_parkme+0xc1/0x1f0
[   63.847782][    C2]  ? __pfx_worker_thread+0x10/0x10
[   63.848700][    C2]  kthread+0x2ea/0x3c0
[   63.849542][    C2]  ? __pfx_kthread+0x10/0x10
[   63.850426][    C2]  ret_from_fork+0x2c/0x50
[   63.851296][    C2]  </TASK>
[   63.852054][    C2] irq event stamp: 231644
[   63.852885][    C2] hardirqs last  enabled at (231643): [<ffffffff929830=
e4>] _raw_spin_unlock_irq+0x0
[   63.854124][    C2] hardirqs last disabled at (231644): [<ffffffff92947a=
9a>] sysvec_apic_timer_inter0
[   63.855405][    C2] softirqs last  enabled at (231330): [<ffffffff902498=
6e>] __irq_exit_rcu+0xfe/0x20
[   63.856630][    C2] softirqs last disabled at (231303): [<ffffffff902498=
6e>] __irq_exit_rcu+0xfe/0x20
[   63.857837][    C2] ---[ end trace 0000000000000000 ]---
[   63.858798][    C2] general protection fault, probably for non-canonical=
 address 0xdffffc0000000008:I
[   63.860227][    C2] KASAN: null-ptr-deref in range [0x0000000000000040-0=
x0000000000000047]
[   63.861411][    C2] CPU: 2 PID: 72 Comm: kworker/2:2 Tainted: G        W=
          6.4.0-rc1+ #4
[   63.862645][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-1.fc38 04/01/4
[   63.863940][    C2] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [n=
vmet_rdma]
[   63.865117][    C2] RIP: 0010:__lock_acquire+0x24e0/0x5f00
[   63.866150][    C2] Code: 0f 83 a5 03 00 00 48 8d 1c 5b 48 c1 e3 06 48 8=
1 c3 e0 6f 7c 96 48 b8 00 00f
[   63.868877][    C2] RSP: 0018:ffff8883aef09ce0 EFLAGS: 00010002
[   63.869989][    C2] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ff=
ff11075de136f
[   63.871252][    C2] RDX: 0000000000000008 RSI: 0000000000000004 RDI: 000=
0000000000040
[   63.872513][    C2] RBP: ffff88811bb54218 R08: 0000000000000001 R09: fff=
f8883aef3084b
[   63.873777][    C2] R10: ffffed1075de6109 R11: ffff88811bb53300 R12: 000=
0000000000000
[   63.875044][    C2] R13: ffff88811bb541f0 R14: 00000000ffffffff R15: fff=
fffff945622ec
[   63.876317][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[   63.877674][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.878862][    C2] CR2: 00007ff6323cc364 CR3: 000000021ca6c000 CR4: 000=
00000000006e0
[   63.880158][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   63.881453][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   63.882754][    C2] Call Trace:
[   63.883721][    C2]  <IRQ>
[   63.884655][    C2]  ? __pfx_mark_lock+0x10/0x10
[   63.885705][    C2]  ? mark_lock+0x101/0x16d0
[   63.886702][    C2]  ? __pfx___lock_acquire+0x10/0x10
[   63.887744][    C2]  ? lock_acquire+0x1a9/0x4e0
[   63.888740][    C2]  ? find_held_lock+0x2d/0x110
[   63.889742][    C2]  lock_acquire+0x1a9/0x4e0
[   63.890711][    C2]  ? hrtimer_interrupt+0x100/0x810
[   63.891728][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   63.892735][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[   63.893753][    C2]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   63.894809][    C2]  _raw_spin_lock_irqsave+0x47/0x70
[   63.895815][    C2]  ? hrtimer_interrupt+0x100/0x810
[   63.896803][    C2]  hrtimer_interrupt+0x100/0x810
[   63.897789][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[   63.898802][    C2]  ? __pfx___do_softirq+0x10/0x10
[   63.899798][    C2]  __sysvec_apic_timer_interrupt+0x146/0x3f0
[   63.900865][    C2]  sysvec_apic_timer_interrupt+0x8a/0xb0
[   63.901908][    C2]  </IRQ>
[   63.902758][    C2]  <TASK>
[   63.903603][    C2]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   63.904674][    C2] RIP: 0010:lockdep_unregister_key+0x105/0x250
[   63.905757][    C2] Code: 7c 08 84 d2 0f 85 29 01 00 00 8b 05 95 b1 19 0=
4 85 c0 74 02 0f 0b e8 6a e7f
[   63.908505][    C2] RSP: 0018:ffff88811bb9fca8 EFLAGS: 00000206
[   63.909632][    C2] RAX: 0000000000000002 RBX: ffffffff967c2b78 RCX: 000=
0000000000001
[   63.910895][    C2] RDX: 0000000000000000 RSI: ffffffff92ce1520 RDI: fff=
fffff92fabf60
[   63.912148][    C2] RBP: ffff888130ea22e0 R08: 0000000000000000 R09: fff=
f8883aef4626f
[   63.913415][    C2] R10: ffffed1075de8c4d R11: ffff88811bb53300 R12: fff=
f8881010df128
[   63.914677][    C2] R13: 0000000000000246 R14: ffffffff9694e678 R15: fff=
f88810112f918
[   63.915926][    C2]  ? lockdep_unregister_key+0xf6/0x250
[   63.916985][    C2]  nvmet_rdma_free_queue+0x2e/0x390 [nvmet_rdma]
[   63.918102][    C2]  nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma=
]
[   63.919251][    C2]  process_one_work+0x7ed/0x13a0
[   63.920249][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   63.921242][    C2]  ? __pfx_process_one_work+0x10/0x10
[   63.922239][    C2]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   63.923203][    C2]  worker_thread+0x100/0x12c0
[   63.924115][    C2]  ? __kthread_parkme+0xc1/0x1f0
[   63.925038][    C2]  ? __pfx_worker_thread+0x10/0x10
[   63.925970][    C2]  kthread+0x2ea/0x3c0
[   63.926825][    C2]  ? __pfx_kthread+0x10/0x10
[   63.927713][    C2]  ret_from_fork+0x2c/0x50
[   63.928584][    C2]  </TASK>
[   63.929337][    C2] Modules linked in: siw rdma_rxe ib_uverbs ip6_udp_tu=
nnel udp_tunnel nvmet_rdma ng
[   63.936492][    C2] ---[ end trace 0000000000000000 ]---
[   63.937541][    C2] RIP: 0010:__lock_acquire+0x24e0/0x5f00
[   63.938610][    C2] Code: 0f 83 a5 03 00 00 48 8d 1c 5b 48 c1 e3 06 48 8=
1 c3 e0 6f 7c 96 48 b8 00 00f
[   63.941394][    C2] RSP: 0018:ffff8883aef09ce0 EFLAGS: 00010002
[   63.942548][    C2] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ff=
ff11075de136f
[   63.943849][    C2] RDX: 0000000000000008 RSI: 0000000000000004 RDI: 000=
0000000000040
[   63.945140][    C2] RBP: ffff88811bb54218 R08: 0000000000000001 R09: fff=
f8883aef3084b
[   63.946442][    C2] R10: ffffed1075de6109 R11: ffff88811bb53300 R12: 000=
0000000000000
[   63.947746][    C2] R13: ffff88811bb541f0 R14: 00000000ffffffff R15: fff=
fffff945622ec
[   63.949056][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[   63.950441][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.951673][    C2] CR2: 00007ff6323cc364 CR3: 000000021ca6c000 CR4: 000=
00000000006e0
[   63.953009][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   63.954336][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   63.955667][    C2] Kernel panic - not syncing: Fatal exception in inter=
rupt
[   63.957088][    C2] Kernel Offset: 0xf000000 from 0xffffffff81000000 (re=
location range: 0xffffffff80)
[   63.958706][    C2] ---[ end Kernel panic - not syncing: Fatal exception=
 in interrupt ]---


[3] tcp:

[   56.043999][  T910] run blktests nvme/003 at 2023-05-10 05:27:59
[   56.138547][  T943] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
[   56.148463][  T944] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   56.195051][  T170] nvmet: creating discovery controller 1 for subsystem=
 nqn.2014-08.org.nvmexpress..
[   56.200155][  T945] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpres=
s.discovery", addr 127.0.0.10
[   66.282334][  T956] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvme=
xpress.discovery"
[   66.286070][  T169]
[   66.286362][  T169] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   66.287082][  T169] WARNING: possible circular locking dependency detect=
ed
[   66.287903][  T169] 6.4.0-rc1+ #4 Not tainted
[   66.288447][  T169] ----------------------------------------------------=
--
[   66.289266][  T169] kworker/0:3/169 is trying to acquire lock:
[   66.289938][  T169] ffff888108c09030 ((work_completion)(&queue->io_work)=
){+.+.}-{0:0}, at: __flush_w0
[   66.291264][  T169]
[   66.291264][  T169] but task is already holding lock:
[   66.292058][  T169] ffff88811e6efdb8 ((work_completion)(&queue->release_=
work)){+.+.}-{0:0}, at: proc0
[   66.293361][  T169]
[   66.293361][  T169] which lock already depends on the new lock.
[   66.293361][  T169]
[   66.294496][  T169]
[   66.294496][  T169] the existing dependency chain (in reverse order) is:
[   66.295497][  T169]
[   66.295497][  T169] -> #2 ((work_completion)(&queue->release_work)){+.+.=
}-{0:0}:
[   66.296581][  T169]        process_one_work+0x786/0x13a0
[   66.297205][  T169]        worker_thread+0x100/0x12c0
[   66.297766][  T169]        kthread+0x2ea/0x3c0
[   66.298287][  T169]        ret_from_fork+0x2c/0x50
[   66.298843][  T169]
[   66.298843][  T169] -> #1 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
[   66.299765][  T169]        __flush_workqueue+0x130/0x12d0
[   66.300396][  T169]        nvmet_tcp_install_queue+0x6e/0x2a0 [nvmet_tcp=
]
[   66.301182][  T169]        nvmet_install_queue+0x331/0x830 [nvmet]
[   66.301920][  T169]        nvmet_execute_admin_connect+0x34e/0x7f0 [nvme=
t]
[   66.302735][  T169]        nvmet_tcp_io_work+0x26a7/0x3ae0 [nvmet_tcp]
[   66.303494][  T169]        process_one_work+0x7ed/0x13a0
[   66.304129][  T169]        worker_thread+0x100/0x12c0
[   66.304734][  T169]        kthread+0x2ea/0x3c0
[   66.305286][  T169]        ret_from_fork+0x2c/0x50
[   66.305833][  T169]
[   66.305833][  T169] -> #0 ((work_completion)(&queue->io_work)){+.+.}-{0:=
0}:
[   66.306882][  T169]        __lock_acquire+0x2f25/0x5f00
[   66.307528][  T169]        lock_acquire+0x1a9/0x4e0
[   66.308092][  T169]        __flush_work+0xf7/0x8f0
[   66.309409][  T169]        __cancel_work_timer+0x2ad/0x3e0
[   66.310715][  T169]        nvmet_tcp_release_queue_work+0x2e3/0x1330 [nv=
met_tcp]
[   66.312220][  T169]        process_one_work+0x7ed/0x13a0
[   66.313537][  T169]        worker_thread+0x100/0x12c0
[   66.314784][  T169]        kthread+0x2ea/0x3c0
[   66.315974][  T169]        ret_from_fork+0x2c/0x50
[   66.317214][  T169]
[   66.317214][  T169] other info that might help us debug this:
[   66.317214][  T169]
[   66.320432][  T169] Chain exists of:
[   66.320432][  T169]   (work_completion)(&queue->io_work) --> (wq_complet=
ion)nvmet-wq --> (work_compl)
[   66.320432][  T169]
[   66.324324][  T169]  Possible unsafe locking scenario:
[   66.324324][  T169]
[   66.326482][  T169]        CPU0                    CPU1
[   66.327690][  T169]        ----                    ----
[   66.328907][  T169]   lock((work_completion)(&queue->release_work));
[   66.330282][  T169]                                lock((wq_completion)n=
vmet-wq);
[   66.331700][  T169]                                lock((work_completion=
)(&queue->release_work));
[   66.333328][  T169]   lock((work_completion)(&queue->io_work));
[   66.334587][  T169]
[   66.334587][  T169]  *** DEADLOCK ***
[   66.334587][  T169]
[   66.337089][  T169] 2 locks held by kworker/0:3/169:
[   66.338208][  T169]  #0: ffff88812557f938 ((wq_completion)nvmet-wq){+.+.=
}-{0:0}, at: process_one_wor0
[   66.339961][  T169]  #1: ffff88811e6efdb8 ((work_completion)(&queue->rel=
ease_work)){+.+.}-{0:0}, at:0
[   66.341880][  T169]
[   66.341880][  T169] stack backtrace:
[   66.343686][  T169] CPU: 0 PID: 169 Comm: kworker/0:3 Not tainted 6.4.0-=
rc1+ #4
[   66.345105][  T169] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-1.fc38 04/01/4
[   66.346774][  T169] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nv=
met_tcp]
[   66.348254][  T169] Call Trace:
[   66.349274][  T169]  <TASK>
[   66.350217][  T169]  dump_stack_lvl+0x57/0x90
[   66.351357][  T169]  check_noncircular+0x27b/0x310
[   66.352522][  T169]  ? __pfx_mark_lock+0x10/0x10
[   66.353633][  T169]  ? __pfx_check_noncircular+0x10/0x10
[   66.354841][  T169]  ? register_lock_class+0xba/0x10a0
[   66.356031][  T169]  ? ret_from_fork+0x2c/0x50
[   66.357207][  T169]  ? lockdep_lock+0xca/0x1c0
[   66.358328][  T169]  ? __pfx_lockdep_lock+0x10/0x10
[   66.359480][  T169]  __lock_acquire+0x2f25/0x5f00
[   66.360621][  T169]  ? __pfx___lock_acquire+0x10/0x10
[   66.361784][  T169]  ? save_trace+0x53/0xbe0
[   66.362902][  T169]  lock_acquire+0x1a9/0x4e0
[   66.364034][  T169]  ? __flush_work+0xd7/0x8f0
[   66.365152][  T169]  ? __pfx_lock_acquire+0x10/0x10
[   66.366420][  T169]  ? __pfx___lock_acquire+0x10/0x10
[   66.367563][  T169]  __flush_work+0xf7/0x8f0
[   66.368641][  T169]  ? __flush_work+0xd7/0x8f0
[   66.369734][  T169]  ? __pfx___flush_work+0x10/0x10
[   66.370884][  T169]  ? find_held_lock+0x2d/0x110
[   66.372006][  T169]  ? mark_held_locks+0x96/0xe0
[   66.373121][  T169]  __cancel_work_timer+0x2ad/0x3e0
[   66.374307][  T169]  ? __pfx___cancel_work_timer+0x10/0x10
[   66.375729][  T169]  ? nvmet_tcp_release_queue_work+0x2cf/0x1330 [nvmet_=
tcp]
[   66.377106][  T169]  ? mark_held_locks+0x96/0xe0
[   66.378233][  T169]  ? __pfx_do_raw_write_lock+0x10/0x10
[   66.379384][  T169]  ? __local_bh_enable_ip+0xb1/0x140
[   66.380646][  T169]  ? lockdep_hardirqs_on+0x7d/0x100
[   66.381842][  T169]  ? __pfx_sk_stream_write_space+0x10/0x10
[   66.383016][  T169]  nvmet_tcp_release_queue_work+0x2e3/0x1330 [nvmet_tc=
p]
[   66.384342][  T169]  process_one_work+0x7ed/0x13a0
[   66.385395][  T169]  ? __pfx_lock_acquire+0x10/0x10
[   66.386463][  T169]  ? __pfx_process_one_work+0x10/0x10
[   66.387597][  T169]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   66.388733][  T169]  worker_thread+0x100/0x12c0
[   66.389796][  T169]  ? __kthread_parkme+0xc1/0x1f0
[   66.390866][  T169]  ? __pfx_worker_thread+0x10/0x10
[   66.391958][  T169]  kthread+0x2ea/0x3c0
[   66.392933][  T169]  ? __pfx_kthread+0x10/0x10
[   66.393974][  T169]  ret_from_fork+0x2c/0x50
[   66.394995][  T169]  </TASK>

