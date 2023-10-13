Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C04CDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 19:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9iaY5nbqSlz/lQn+I5SVN4yrXFGvHEyZZSCeTY6LTCw=; b=o6ZNYV58T2s2gn6Y4R14vd0hGw
	fosavbQEgX/vp1jAK1SUahHXuNzbPuT42Gcebq4TK7f8PGpTfFX8LP6DAQp/cojgPBVyRFWMf6AWG
	8k7I8XOY8Zcox0CniuvjckT8XHm5uLGfrpvECXy1mwt3fdA4lfckQzTsOfMDwX9LbmW41yr3/MaiW
	6tBMQVRcDZItcBAL5H9kEW7qMKpC/tPTKgldESUOINntSY7xsZE4Yhn95+g3GLJNNlXaHLbF+joil
	buyYYGvSgWsEdRMRzB/Vjpe3zRaksa1T9QUU1XIIfehmOBZwt/PE4q75HPrGYHGhAo8i9vesEGLlH
	STm604Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrO4R-0049iZ-2i;
	Fri, 13 Oct 2023 19:43:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrO4O-0049hT-1b
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 19:43:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1697226216; x=1728762216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dM/cQyGTZYClCNv+rH1oEdMIrKkA57SdtoqiJk19s1U=;
  b=MlluzuB5aTDzH+pdhMb7sGtpXdpSGjhN8nB4QPAjLEpfytGvz+bbYLEI
   vYfjC/APJhtF51AScgBuEP0OIWTAHun2sp2jF6KzUINh99mURiKWEkqVd
   ApdFFTioNv4Z/fkGRyFbc3r/5tjWDUZEybosXaXj+Aol7Cxuga0vqpoM4
   B0lrgxSD7xYgAkCh0+UzrYRCzi7zncXL4F8vUhFQKCLSu95BKFEySjF0S
   h6oFv2WKW1JvS2+ZagC73BSvNfJBPV6Os/fyPFaYGiAecIArm6mVFJcnZ
   lo7EF/W6ySpMbuKx2NsvKOhoi5OhTcFdlT4AxcGYsIa6usdICPK1jBfrY
   g==;
X-CSE-ConnectionGUID: RwnlfBzBSLepQtP2Mlk9UQ==
X-CSE-MsgGUID: qGz6C/bAQiSS3W2O77QcTw==
X-IronPort-AV: E=Sophos;i="6.03,223,1694707200"; 
   d="scan'208";a="244601856"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2023 03:43:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fugo2EtmdhXWbls0mNRqy61vg5Afku8J/GNr9wZ0JRQCXb3m7mzT6LYc8wdTAYGBB+NwgBd8778w4/4NVjjK0YBrVcT6r6YQJ9IBOZtC5GjJB7oezb7F4UP4QesQqS5k9C6r1qI67cZqKaMFZ78EsgWuNK9wo/prV5RPkcTzQVeQs1INJR6X7xFYc1ixJPYdOku3gai5WOZ8+N/uFoFBeKTc2x2l5m0KZpVihKUEpCu42o7ytebeCtoTIhFIb3CWx94Jw/zM1hLe88IKQvOUhpAwMiyWy/g3CnunPvYgs9e9Sx4CghtVxi6zr2+B40ZnBeRsy4ErC1+oZReY/31kUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iaY5nbqSlz/lQn+I5SVN4yrXFGvHEyZZSCeTY6LTCw=;
 b=SVJUK61ydPnDCBG2pio/8uZUH4nouhd3wyrQKi6wf31onoNcI6Q4Y0AAf0X/x3kjsf4F0qzRyDYu8fRakwMLOioyAolBGyvpB5FQA7RsaEKECH+gXhEiXtJQQkT//5aLrEhW/3gzyBp9iezuTcr8zfLGLqPYn8blwUhTs+OAmJfUbNUVPQXzM40bc+v+oJLv7ZRGoytJm7m/gvr5qfqELvpiGR6EfYXKR7uAEEEC4OpzuLU/KIuWVd+QkKgEeVOfUBinLXHEOMH+n0fAuNW45jorviBmS0LCb3ESyodbiCrOUF4Ni+jmzEgnxFQeLyd5ySLU6gbiOPu32QxPK7faYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iaY5nbqSlz/lQn+I5SVN4yrXFGvHEyZZSCeTY6LTCw=;
 b=sMsvGYkHgws2mx5FOZpvT5S5pLiHaFTvcWGTNoBvOT33tipmV8Pa3uV83NGy4SNxkytKrmaDMxXNeDZQQq4Zba4APXVJRBAupxJ78vu1qbIls6R/P2idw5TQJFAonEXa6hJfZ7PtgL5v+FJlP0wF16XTI0QSXoAx4XebAtWMZsY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SN4PR04MB8352.namprd04.prod.outlook.com (2603:10b6:806:1eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 19:43:21 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6886.028; Fri, 13 Oct 2023
 19:43:21 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Kenji
 Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Thread-Topic: [PATCH v2] nvme: update firmware version after commit
Thread-Index: AQHZ/fL8/I5yjhJHTEW4R44mU62q7LBH7PoAgAAyKIA=
Date: Fri, 13 Oct 2023 19:43:21 +0000
Message-ID: <ZSmd1y+kaZkz1sXq@x1-carbon>
References: <20231013163420.3097-1-dwagner@suse.de>
 <ZSlzxGx8k9pgkhDk@kbusch-mbp>
In-Reply-To: <ZSlzxGx8k9pgkhDk@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SN4PR04MB8352:EE_
x-ms-office365-filtering-correlation-id: 0cda530c-8c0b-4498-edf6-08dbcc24a812
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i65RCIA/7CW5j4Ho2huEmBQV4gsqWTOo0XBFErltd5NQgoKLXKqegDiVMeqOOFq0+Z5H+tO/sswgeKhlm/uJxLRRt+5cchdY+uEUx/7jP0HgryhGIsu3eocZdgZgJTaungTqIwOIvHtlQQFdZuTgUHm3HPtJZGNOQCmQ7RiTN3HiOi24BuG+ZWcqeeof6nweejOJ2aBhRrOM9WbisiDPdvj29Dwcb028lI1h97FS9A+BZS00ur042tDJ6DaqVrLE7wX4b3IOY/MMZxHXF0DmN1jtb9/k6Rtm7aq2nCNYz7WoU85I1STq1DKMFenpU9FlGPLXloRkHo+vVSM7LJcX3URX0L8iHLyXhWb/cIyXYiNA9O9/tJzv/O9xSbiU25DShVD8/Zf9krA7KM3kBmdn6W/lT0wQX+cyT1OL2cL4hM2uJiUKXHkle5RJ/8X/hZqJmvE7xs5snj0yff9kz0iJDZyTXSjX4zbIGbn2BHSee6WJCgy+aJ2iF7MpZc1o8o+p61Ytt5G60jcjIj0BMkyTEzVPdHv9qnfAQQlj2fn9zddkuPIYGOtiIoNIktcdUycGiqEzUSaSXJdf5CW0ll3EG2Q8TTjAeLaW7toKgiqYxC0JYCC75HY9IHqAUNE43tIs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82960400001)(38070700005)(122000001)(33716001)(38100700002)(86362001)(66946007)(6916009)(2906002)(478600001)(6506007)(9686003)(4744005)(6486002)(8676002)(6512007)(8936002)(41300700001)(5660300002)(4326008)(76116006)(71200400001)(66476007)(91956017)(64756008)(66446008)(26005)(66556008)(316002)(54906003)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gDV0wWj1H0fxbGDeAq3MBON5ajK41mzLq9viZAEJwuSZwEcXYETPdrBM4H2N?=
 =?us-ascii?Q?QI3ve6xVqsN0ugxKqu9niH/TruEfm6e4EHDuUNg7LXuITGp4S/FsWKgnyzF4?=
 =?us-ascii?Q?BZaTGgHM+IZriWLm9lWjQQSOEOa2SBqu1TDYenNqcvZiu2abVAOKpk0f5htM?=
 =?us-ascii?Q?Sqs60MZbJuuQDTXv7LtXR+pR8g5FK4zhDL0uLoVWhgTxB6rusLAtYgxZFar1?=
 =?us-ascii?Q?qI39V6aHXYUCus6irH9tOvGujFTIGNEV6HkoWK16reTJfl7fzJMjyO4IKVyk?=
 =?us-ascii?Q?nPoBBv+uhwDHT0nT/2zVMFiF04Omq8sqWs8LTQfAOG1Xz1+gFOYjoUQlloyf?=
 =?us-ascii?Q?wJDgeWmT5rhxmJqd5yoO0QGVTbtoI5Z2UcLXmRUYKa1JvPQZVHcwKfesIfYH?=
 =?us-ascii?Q?zYf1bp2FP2GPZTTCcXdRRipUUMAXUwvz7eVTBZiqVq46qft0nk8TzZUXhxn+?=
 =?us-ascii?Q?Aym5GtslZr+IExnc5chEATkAKK5Os5ldrpaK64FLFswSe6Jx/tnnxC6CPXcS?=
 =?us-ascii?Q?4oInaYUygPh4p67pfmVEjtN/Nz/jFbWDPLWdeg102aXdDsqp5b2gJ6kRbw8+?=
 =?us-ascii?Q?+uhFXdn6Aj7cO1azdLpbkFFwAXcvl6fK+JbcgfhugXhxJx0gQcal0SxtE49r?=
 =?us-ascii?Q?Dx6B3d+rH4sNjqgkK8yTgVp3VQhGwKo9DoXcy6dH6gIYOI3xQi50k5aSq8ZX?=
 =?us-ascii?Q?tJ7u3v5BZKxKUKFXg0Pjh9treK39K7uYg5rKJKClvylDZzOlSo4/zBFV7+FR?=
 =?us-ascii?Q?ppKHNtdiRtUxFR9txnKADdZR6EeMThZoHuorqW2bBEKYJ1vGYOsvRstPfs5T?=
 =?us-ascii?Q?pxbSyC6QgKH8fStwj8pjM4RcQC9jnhVyzc27I8D291dzDR/hZE1dA92OSELb?=
 =?us-ascii?Q?Ldm1t2JX5qyBnCC2fQQAT49hmm3ONrKbZJtIzLp7dd2xiAPAwJdu5OUpKEju?=
 =?us-ascii?Q?UwjpXGo7OdW3whntNcXeEib8RlOjhkAprCpNU7VOd6dXJPploudX1ljLXC9p?=
 =?us-ascii?Q?yVJSKl3GnriaqqfUkmXo/qSpj+Z907rXQinLrskii+cELhBvk4rFaCoOP/JN?=
 =?us-ascii?Q?kqzK2ZSrvfPA5vOWx88nS1r7bUBHzSYKcoE2bim36wOBEaUgJG142ds7MntG?=
 =?us-ascii?Q?/pdD9KwMjuXTxTRbDICeTh0tYMt8b6z/WDa4Kox2wXPcQHlo5njaHL85B5O1?=
 =?us-ascii?Q?2DZbZNvo17GVs1jWDZD/CKEfAtufE8n+CTrxLx68HQKg0MsqfzR8GR06dq3v?=
 =?us-ascii?Q?B9lsQKV8qderO6GoPLxaXZDlSCAk/TVHeqZZJ+vUTIA+yhZPa+R4SneoYG35?=
 =?us-ascii?Q?Vkzdg78fyPeF7Kdt3u7gma06sa8jGVt+Rlw2/2vOVYUCzFa8BhbxGj2YIHnv?=
 =?us-ascii?Q?hS9bwOrQ1KehQvekM723PU9dVaCsvvotKN9hisVOLc/vJQa+qBVMnSCZh5Oq?=
 =?us-ascii?Q?EprG5zIj7guQNNYBuhM/Kg7yYt4RG98bIqAv60TzhUkxNRLiwQWMRa44RKeW?=
 =?us-ascii?Q?RYAIf8Ux8JqwoQCRxut4ohiJf65OXy7mCtQNTKZdgn3GLfV+6VGr7RoU8cWP?=
 =?us-ascii?Q?8zSRpe1m+YYnCRNOAc6FisfTxH2NZrVToRdkKGGs+YivgQyw/AwB5fU3DDRN?=
 =?us-ascii?Q?jA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3408167DC74DC4A9C5E12FAF7594664@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?O0k3wcfj9uaYpPg9erCeBtSBY48p2Mv/zgaCBg3NNTx9RSH+lt6yGBp9YLeY?=
 =?us-ascii?Q?UO67QXLB7Z2R8Sb9cqU71svTtkZBq6fqzRRnYfwKId39xq5rg5p6nbMuZJqs?=
 =?us-ascii?Q?1vCjMS62tKEklJ2AyWEbNMGt1E4mB9xjuXZuy/OoQuRFUPZkBVcS7KEaqTpj?=
 =?us-ascii?Q?38XtZQCv3vuGahXInC8rq4KsJhB03eG5hoPu55RIrv01wAwaPv1MugclHm7V?=
 =?us-ascii?Q?678GNwv2ptqhOcszqsFPKhDpsJ+JENpR/8mdsSs9p3iThiGvv0bkdvfD2rud?=
 =?us-ascii?Q?hfeC6ypnBS6oNT6iMWhmWt4QeotupEZnZ25IV3NqcNlF6Khf6WGkeCoQAwE5?=
 =?us-ascii?Q?psmUkYR8msTD9HIAMvs6+Ts11fw+Y5No/Y82z5FjcVzBM9hv/R2ggRb3aSQv?=
 =?us-ascii?Q?oL6SNUstTXKPdU/tELBIuZvTQwFVMF0EpSIMN7H3Z/aUwoi0Yf4WTV1cddY8?=
 =?us-ascii?Q?wI98p3gVIxU2SfaFwsKzk3xoyEFp9jxZYXbML5PGAGxbS68ckrxV/+pV9kVN?=
 =?us-ascii?Q?yVqas7R0VnWwsuaww7tSPi7XWYhmwoicAOa0rUsjiqJ3wQBSrWvjcbOMXxXX?=
 =?us-ascii?Q?NgG9vtI2Vs7JNNELFmGrCAeM6yFe9P9xv7uqYEILIZSkUoP3XRik0k+4VVtU?=
 =?us-ascii?Q?8tdMbNijFU7f0rm4qoOys4hjt+qJnW13bVhH8hHp+dYt0ja9OLzGtNOKgIvU?=
 =?us-ascii?Q?MECjzR0Be2E+/LEE1+Td0T1zzn2BN4nSkfdBGUKtiOrHG1ep6spgXmty2wKZ?=
 =?us-ascii?Q?I4RlE4FUZclCk/T/ejORHdIIEy0exhRoOkMZVSee1l+DBm5lx56IMa+XztAN?=
 =?us-ascii?Q?qbXHlM0/HOqtPx8bv3Pw2uK87SA92F3TWKTln8hvFFAP4+owfck7IOCIBBYh?=
 =?us-ascii?Q?K67cLjpmOx8Rk2Ie08MuZLsEOlf9YKh8+atQ3lwOzKbbJmBO2FaYz3y/r9Eu?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cda530c-8c0b-4498-edf6-08dbcc24a812
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 19:43:21.3193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A1Z9/p3kzM2hRhSJHH5akDQqo701ZMK3FmS6Ufd6VTWqHxoM1q06RmkjDTlgplDh/c0kugPPgbKkyoQbMgK+AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8352
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_124336_605212_08994318 
X-CRM114-Status: GOOD (  14.69  )
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

On Fri, Oct 13, 2023 at 10:43:48AM -0600, Keith Busch wrote:
> On Fri, Oct 13, 2023 at 06:34:20PM +0200, Daniel Wagner wrote:
> >  	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_N=
VM,
> > -			log, sizeof(*log), 0))
> > +			 log, sizeof(*log), 0)) {
> >  		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> > +		goto out_free_log;
> > +	}
> > +
> > +	afi =3D le64_to_cpu(log->afi);
> > +	if (afi & 0x30) {
>=20
> That should be 'afi & 0x70'.

Personally, I like GENMASK().
In this specific case it would be GENMASK_ULL(6, 4);

I find that more readable than 0x70.
Although for some reason GENMASK()/GENMASK_ULL() does not
seem to be used in drivers/nvme/


Kind regards,
Niklas=

