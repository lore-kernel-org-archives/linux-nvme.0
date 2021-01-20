Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF37C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 10:47:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D88020702
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 10:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D88020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=N4MpuR56Yha0DyeuiKKKyzJBHF9xRwHezDMIL8FjJe0=; b=x3gqsTY19q1WkhQNgfWI5f4s+
	fzHH2HVO4pXnHs/b2G33DZzj3xTO5mqI3BHEOhqWBBK3Gj//W86MvXZI5Qvr1yUF+56SkL4P86qKW
	fF0TGXM/PP/9vvNsHN0j4cp33NmwzL88+q7edf9uQUSsUoMBeDhdC8401L7eJpbGB6Y7tNCCnWgfO
	Hb446PZL668pn6+jVSnsnRDNHlLnIck4lW/GU0lOzX+zsUL8uNYuRFYe8Z4jzVMn80Esd4+6iAvxZ
	Cjci3xtAN6leKGfDGAkOhcH37jH15aTgcXt45x153z1lCulaZCFC63DZB9epnjoMWt3MZO466cwEh
	QNxHD1Y8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2B0w-0002xC-HM; Wed, 20 Jan 2021 10:47:02 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2B0t-0002wj-V6
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 10:47:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611139619; x=1642675619;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=U3ssmbCYg6NvVscu4SdbntHO3Sa6+6ksLuNOg034rCQ=;
 b=FsPTri9mtfrKR1KObITwqtGXB79PRwxoUG5SpzQatf0iYPF7ZfLBPC9e
 9fKFMR4imaViNLqAhIpQBhNeYR8ype94eqq/Sq1vk3FIdCveWhxrBae/A
 bpLAjsb7QIIvZZPEz6epGwGLTxOmtLcbVp2OeemzSfXqsWgJlzzaf6Lbj
 nr2qUFiIsyaC7yjES1w2xOx60+R9Kt/uZqCSOSpttjslY7ysV3+agyrx2
 5bL++JO+i7XodnIv7//EW4Sw1foS0SpMELFpacg2ohq2FHhdYkjm6xhlA
 /3vrg6VmyOBRraLyaCM+JZfmRd68wJbQKwVaxjHgjUQei8IXU8nlvZlTi Q==;
IronPort-SDR: j9Mi6rhgnUVxEwL1DHCQbjVu/s7yYRUgSaAH4SHKeul4H8MoiIq6C90m7SyT6mvg6Tnj8tivCL
 ouqQ+esZnRrqyFS8HEaCLFWPBHnzn8n6zX7b4gh+bhtyjLfO5v30OhtAaHdMOrEoKjLQKquln3
 Bpehh5TiCQheBRiONL3rS7ZbOoGxJCnlGSN+rVzF9/vLjTEGAX5PJxZ9+P2UnSHXS3Gs/KsJ7v
 ZsGS3IF1aUTlYQVBsi5uvDQcnoBIXk9Vgd4g9F9Q1gSMLthXWCpO7Ti7Zy6Vr//XA1AgreLPPb
 42w=
X-IronPort-AV: E=Sophos;i="5.79,360,1602518400"; d="scan'208";a="268211173"
Received: from mail-sn1nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.58])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2021 18:46:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM8TNUb0AXPvp5Sy7E1UnlMMUPHH1BkWVnIxmodU5e77tV3lLIsudAPBP+NSZWltBu7TFP5eNfJQdJbECxkfvDEXGv/GKtIRRWjY3hfqIQiJDj97k2SS0Hs13qALXYF+rE32XeCgUEYLmy/rROMXav/+Q6kkVm6Ff5ZiVLbWMbAsKEKc+G16xf7cOLZUZYJZ/P1SfzXd+vGQdCWHrX2Bohbwv391r9WS6O/IT2uZzwyzz0P3TzheXcKHIlm4xHyxmr2xR58ldx8M8kC/FtJGudFPum5aRCf5j5tJw25bWVD31g3iD5a0guPrN9DmKng1WEoBcWSGJ8b6W2gE5B62Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3ssmbCYg6NvVscu4SdbntHO3Sa6+6ksLuNOg034rCQ=;
 b=QXHwf1qof/MdA4FibOVFaPPJneWXl3/q8/oi7QcQ8gOWEz392IGpTNuoTnijwh/NKyeeCg834jBgy9hECMIkLkQTT6/UNAGRSf5JdvDqi0/fq0y4i2fXPSJTRZLfy+74/+XsUfxZRrWFEjw1aEtIasLbNkF/6EGuTpQFdA6bmcxzv+k+UqZas4wV9drLq3/xDj+B8/6GaWiNYTozTuT6td9h8CSp0oFR3y+677NVyBdTh+8BaC5kC2IHJHlm/wTBgabs6+aKPuE6EmQ6zB3/MsEg/sLizk51plKLk+mv1JyRm1uDpNP1/0UhCaGGpSTYW/V2KDngGngwNBqFQdgX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3ssmbCYg6NvVscu4SdbntHO3Sa6+6ksLuNOg034rCQ=;
 b=MOmU3uOx9U3C1+bT8l/kIXD3Mp7ZeTYdu0a5wFkfyjUJi38pjZIoqdPgP5VHysg6nAkos2ttduKltHC78H2Pf6Iu6/aKKhQu1nirjWvYi8+TXNXTHJl26+h3xkCyZZyo+T6qY5aj8JUU0tVZMv+kr+GBExL3lGvZX8gaow6qOX4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6991.namprd04.prod.outlook.com (2603:10b6:208:1e1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 10:46:56 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 10:46:56 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] block: add zone write granularity limit
Thread-Topic: [PATCH v2 0/2] block: add zone write granularity limit
Thread-Index: AQHW7nICpvFo3Xy5NEe3/fjBT56Dcg==
Date: Wed, 20 Jan 2021 10:46:56 +0000
Message-ID: <BL0PR04MB651400694A65F9FB395C5652E7A20@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210119131723.1637853-1-damien.lemoal@wdc.com>
 <20210120100738.GA25746@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:b0d5:1d20:2559:58ed]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d01c3bd6-029e-4569-469c-08d8bd30b51f
x-ms-traffictypediagnostic: MN2PR04MB6991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB699112F4488E414FF359EFF0E7A29@MN2PR04MB6991.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bo5ojCE/SFnzt2FJu/vcUTcVhyQyRemujxq/4Hs2Wj1irrknhzIenbe4ODaxN7pAY7wye7TobY4IjYgsW7PHgxR3Zc6yM0Crj70PFCypnuMgmQn4wN3zQ8rFA70vr4GKeWZDODnOL2+g93T7WeaL0hKNGCYFjWX5TGv2WdahxfUUC1cYh4yGKb9Z+Tbr0IqRhTsi/VjP1TE6iCY4NLA8XLa4jrZsv6tG+t829BWoU+8FxEVjs8rqhbK+fzyFtj+1Axuvuh/VAWhgs2hu2Cd8VXh3GBzGzWiYhx7sAhgHTOuF8kvfVLooVw90SOyU2GckLOtWHNMjeyhjLbLJCUy3WYdstsUDWWgTltgVT/EGv76tZhjlqYqO3J9Qn0iV5zMB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(66446008)(316002)(52536014)(91956017)(76116006)(2906002)(66476007)(54906003)(64756008)(9686003)(66946007)(66556008)(33656002)(7696005)(86362001)(5660300002)(83380400001)(55016002)(8676002)(71200400001)(558084003)(6506007)(6916009)(8936002)(53546011)(186003)(478600001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kegjGqWELsfHq1bzEsIl9rgdSkBBFY8vLe3xhJeVtMg/EAkjqDJWf3Dg1G6d?=
 =?us-ascii?Q?1OSx3m6rTMn8JmaQ/ny6OwZcFJWC9oJWAjRF5fjkd5DH7VV1LW4Rj0v4d5NQ?=
 =?us-ascii?Q?bkwNeU8xbB9H6XTcM3TAhGGk+voQp+Zm3hdPh80lCqELIpjmWheNuq5tA9FN?=
 =?us-ascii?Q?9baFYqDd+DH7qx6sUbP8jnRRa/TC/pJsd0mWAgxEP2lHNECWhw//NTttXKxB?=
 =?us-ascii?Q?1Wztl3bs7Xa8ZdkKaEMegIrBd0C3tfm9AmBs1el14hnD0/c8p8yLWgkV0uqG?=
 =?us-ascii?Q?M4/AVQUbtpQY4akJ/oqbl7RWH+QhtjvjapB+TFZVLFX2wJmiM1FBL9BriU+l?=
 =?us-ascii?Q?1Xy0CdwHpQTwleTtidX1fy2Oh8l4Yaf7aMjhQyWllgc71Pf71sR18ZJ8tL0N?=
 =?us-ascii?Q?1lrgzIPHjcmybYzmL5jXtu3OXCqyDuu4neUjrfnPTeI77aWCFMZV4Um7+VsW?=
 =?us-ascii?Q?NjPWr+0tDwDKu1XG74IEkIBluzUGxKr3ekBnFDvL/v1p8PUWsHejSxv4XA6R?=
 =?us-ascii?Q?l812/sQrfJj4cvgLAE98oHqi9S5Q8C4wNOJjPmIkre17svHAMHtrgNFNTlks?=
 =?us-ascii?Q?tmH2Q3ogF2HleU/nvCNjsaKELGChN84NV7OfgCDOL9SV4AnodzhEG1y4liLC?=
 =?us-ascii?Q?hv0dqAgvT79+eEkpZdomJtR9E/5kgdK9nA3iTV7ct50XJa4CU91Xeqff18Ww?=
 =?us-ascii?Q?eUUu2PjFBVv600IE+mU9ckwffuVkCHzGvI9pMBqrY0/sopmuPrFdGis1Yv3r?=
 =?us-ascii?Q?8xmGXt17KUbUOqMa5cMH7kPbzj6lEgRk88+NEmJOgeUBonItmtW6uD1odTsF?=
 =?us-ascii?Q?IwShczaQFny3gC6cKH2BW4NGoR2FMphzL0BY3fP7SGlvVl0wdW3IpkHLurPz?=
 =?us-ascii?Q?VovNXcZtKzGdf6wSUUxI8BPtfJP8OH8yaagR4jO7TY2rJNgKJpIqCmKOv359?=
 =?us-ascii?Q?JYZ4GJCrPG44WQVg0CvKsTzNQK23pVXNo6PDu4i1uLrRuiAHu/d74I0BrsDN?=
 =?us-ascii?Q?b2bt/mTWZr0Ijz1HcmAiNFjYde8jGVfNhe9C59y7CPjQ3yR0qQiMjV5vtAwz?=
 =?us-ascii?Q?mfCXt5gy9lhFzE9w0l1JdGt00+QIjvUItWlt/uepEkKM3TNcUvLiKpkYUG70?=
 =?us-ascii?Q?DyEMwf3m/gpaMKnDg9u+4jK31aI3rQ3OXA=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01c3bd6-029e-4569-469c-08d8bd30b51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 10:46:56.6804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nn5zOhpwHt7u12rUETG7PRNVsetQa1eGTB9c92/fK3GT0cGeopL6tyJxw8uoPKRqR4NsE402HshNwxfp2JIDvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6991
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_054700_150297_8D5C4844 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <Keith.Busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/01/20 19:07, Christoph Hellwig wrote:
> Shouldn't zonefs (in addition to the pending btrfs and nvmet patches)
> start using this new value instead pf the physical block size?
> 

And I think null_blk needs that limit set too. Forgot to add it.

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
