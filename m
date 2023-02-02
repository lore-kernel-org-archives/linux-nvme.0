Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACFFC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2OHpoNURKxBkNv0l6U6zR03qy0EsOF7kBTM1fqVaHZ0=; b=LoFhc9Dzcti3t6Kvv8qy2KFlP1
	NwqBFnfTbHnafecMklFVwNzftNOC9kkho0AUsFZxXb087j9psa4bklxY+Awk5Ck94qpEu+Ztrerrv
	uJCQK4qcVvHFFPxR1FbCXa0fS2Vtr02XR9e0mV4I5db9eAEmmpWgDO4y4rbLb2sxJ4XjT12+kibmn
	tLJb5pwHaNPEOSZcw4DWwBOsrOnLbhjnN0bSFj0TQzd8gXsYXqyYYk7YNQlwpss6VJ1Lu0L4irbcz
	G2xbgSFx3DL4WoNcgGJtcbWCclHc1YkpqUtthTXMDObwFAjjSf0Q809cWhkpn+CEBRmHO0da4dtUS
	yu/MWAfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNedA-00Gzo0-7C; Thu, 02 Feb 2023 18:48:20 +0000
Received: from mx07-001d1705.pphosted.com ([185.132.183.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNed6-00Gzn5-RH
	for linux-nvme@lists.infradead.org; Thu, 02 Feb 2023 18:48:18 +0000
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312EwUsm001559;
	Thu, 2 Feb 2023 18:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=2OHpoNURKxBkNv0l6U6zR03qy0EsOF7kBTM1fqVaHZ0=;
 b=YEnvkHvBml+WgozIB/VY1ZOmRkuTXEU/heG8NRFowUQsRfiqTEzemZWCtxgm3gycPoFV
 uegxFoDNViqCOTfOuA4bIfczSXWhqamVgITC4cPM1A3E//uk0if3dZHs4qR4DDwiPAtJ
 ZK8SDUrxXzsauCc//vZUStszEixAHF6uZqeJjckfE/q5kSweSVSqwmWuELFXKP7nLeBs
 8nLXZqNRj7E64EZ4BCgB0amu+MjfCeUWzvmiHdJE08l83uvahjvy+xAr7fUy02QIlpIB
 /bTaJDRSnZIPQ8gFsKr4LW6ddAd0GgZt9eN5S632WOb6YTfL8WjvLOoLji/S5ofQXc9B bw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nfna79mkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Feb 2023 18:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtbKWSagT27gvr3Mi9JI1BYJuz81ZnMBpAa4zb46iHGg4slNIYFPj3N2Spk8b4xp8Naoji3c5PNKFZGwLNMqJKErbHBqJaxtBuwYe5emj34QkPDdPiI10lAi/tC0yl2XWjLHWSMT0zd61PFhW3UOnZN98GCTfSYSTSVka6zFzXedWmi2dxJ+nNM07O5TLyB8qEThcSBF999P0jf8FdZEmKlNAuTsEK10HFJNRpossiyXNN/a9mTpCV3y4lEnnGwOS9Yr75y2hOkZ0Ux8tDoXmy/xTZfX13QacLKmGd4nt1D06S+tcpTDgslOHxfO6QOOvdE/vSF+qzUSV13buhwqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OHpoNURKxBkNv0l6U6zR03qy0EsOF7kBTM1fqVaHZ0=;
 b=afbKrNO4q10JGh/GQj9boIMcJQevV5aFjD+jX6/4k47+SlA03JVaWww4V+jZQXx09w8A3eVK8Jg4NQr4Mc5z77WntrQ7wriAqZmwV/zYJrYj7pOAO+mAwU+RH3Au5B+LahY8kUm2wHDWteg+u+0L5V4YHL4cOJgN3jQYzs3biNyaMqfLZh9ot8Pgz2CMG4DRSllIKsXK3WXlhHTlrkHJJGiwkQ0deNjWteDFCLJrOBCNu9tCHjwElUj1h+bZWOHS/dZiQ3JlSjSdnI211/V4L7BFsfwkJhQhKJBy5yXfWOgIepOSz4zhKScX9sJW7zh9Z2x1J65oBH1wFyXtwFfDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by PH0PR13MB5975.namprd13.prod.outlook.com (2603:10b6:510:16e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Thu, 2 Feb
 2023 18:47:35 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 18:47:35 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index:  AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAO7iAIAAazaAgAIPGOCAAMCqAIAAjSBw
Date: Thu, 2 Feb 2023 18:47:35 +0000
Message-ID:  <BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com>
References: <20230130101449.1772800-1-hch@lst.de>
 <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com>
 <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com>
 <20230131085828.GB3139@lst.de>
 <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com>
 <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230202101818.GB14931@lst.de>
In-Reply-To: <20230202101818.GB14931@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|PH0PR13MB5975:EE_
x-ms-office365-filtering-correlation-id: 4a2ebd20-d3db-4620-bc1b-08db054df334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  vPhQDVAdtdl37Dc690J6hnCM5Vg/uTvAi8gWBMDCZBB7dzxgIoS3rWIMVbTql/jnS6Q1xhDjFxplEGaSnM2Ag+ljPnvYc4zo6JEAak3CIg5IW3LfutzCuULx0vDmRFwDcB/dco2I6cND3/QyuMaQSAlD8vPF60veEByHaaSNTTs10HFOAs5ETHi1cjrD7YULPSGRRt+6h/4oVp7d8RtqXKw5bPzkoKqwIkMXNw7fv/9yQ++I3TBn8lTfuVy8y2OnemQBjL0GCP34pzKyMV9ESaLTuhmATzBEnXB+NLwP9Ar2UIbz4YFIwWtaydE6PmwqPtSNwQ/XemM4zGyrBVlY+gr09tgEu+HDxtPcwz/t1OxYtNIn+WdZgs/E0Gh4dhT+Hd3irfM+2zU4s1NqPkJ2DEVv2T9Um/xc52DzcZXE6lDryo/rGM5d/aE2CPIB0LZiKAsnbvhixsftpvN7RC48Zxz4AEXY/mkdikE3uNIh+eHoqn/ymdrnhrxxxghcyFac+pehEUj7G3qhpJ32Txh+xeW6WnmHaLWWdPVQWLwDulkVPp3iUjRflra9tC8h6WqhW0xm6QYlBPbSX7SGQs/3P4Jk812Frb8DJWnxCIPuSrI+A5mZW7Mo7ZLr7PzvC8FxTgUWoLON4ZC3L+2kITKnNYF/bf2nRPiGZVKwbQ0lII9vOB5IXMiJaVpox2KPEHqpmZEsARAajNb4/sT2VyYEifN4yE975B/IAdRPzmn1rTYOPWkEHG5doNvpt3tVykec
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199018)(82960400001)(8676002)(6916009)(4326008)(38100700002)(33656002)(64756008)(41300700001)(38070700005)(6506007)(66446008)(9686003)(26005)(55016003)(186003)(83380400001)(86362001)(122000001)(54906003)(66476007)(66946007)(66556008)(71200400001)(478600001)(76116006)(316002)(7696005)(2906002)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?1LtbSrJQFrU1YId6xQKnDppB1rPlHcsFKSIHUAu//waHOKJ699HIzbis+EFP?=
 =?us-ascii?Q?pVMrVkVA/TLEVf8/U/ZUSkMKvUjX30reOTFowRiHKt/HTt77sev4bTEHRpjp?=
 =?us-ascii?Q?US18eoo1tS590hdW3d2F4ZO8ObO10AFkOwvVCuJOGVMZ4lIxUYje++zgWjrK?=
 =?us-ascii?Q?JNEAdRt3+GYWVZqIt1woISkyWKTJKD5WlHQpNPR5S2ruW0k5lezK6NL7o0Bt?=
 =?us-ascii?Q?/1yd3c7w1dtYUVs9YWUOjjC9pXVwYOefrsp3Wmtu432Zebh4en4gyptWIp+i?=
 =?us-ascii?Q?i78L/hXJQ1YcmO5swsTTqje+44vEao5X0ViqemFHwQnxggkDpj4JhMKuBRKF?=
 =?us-ascii?Q?UplZiWR/+tvQxGMTMTx842SqPjZNudNbe7UT3qWJMg8Df2ZqsJuomr2az49V?=
 =?us-ascii?Q?kyfdAcE1dx8wB4eYTl6F7aeMT4mC4lePu/vZU2AwgukJKxF7NKMiwhRb1G4u?=
 =?us-ascii?Q?iuUzRxrllo6ORgk7937hVle/QXytkJaOIqZ9A6aMX1SeAPexOuU7ZAY9xHbK?=
 =?us-ascii?Q?IhOtHgyRb9wvJ5dtzgF9aKPiHEwNawsoy8fuoY6dEIaJg6MSaRsLc7mj7r4U?=
 =?us-ascii?Q?nj0HkSqEJtvplGcan/hnGmBQaL0kLAonBxJLsuxyS+6/fsSZXGeQiC+vyxr/?=
 =?us-ascii?Q?XyFGcbBAFEfoQhXS+HZY7XrKMKgzyLzcDtgj9oNgh/9iXxxyymgSAJr2dnll?=
 =?us-ascii?Q?PWC/WFxmL5iI/zN/otCQzTWOUZOTifqkJk6N736aKKfRTCiezNauRQGqw4GQ?=
 =?us-ascii?Q?GcXXhZX/0AoH388hJBh5WebxKKmeRWVm4OZWbhQnK0oUh5R5lvQC/UjrR8KZ?=
 =?us-ascii?Q?bptEo1c/KapsVc7OOwgeb8k/hbUx48uv9u6r4uGeMR/7WP+ysQdIAupf5ocZ?=
 =?us-ascii?Q?5WR766OrFczIxoPAfEFgDZvNetTCt6Bs5wnLYCd31jObPT8i5efdJChKhcQO?=
 =?us-ascii?Q?6mgYEPG9pjQjSGlgkYLkfWz/ZdXT6zu2l5cUqMH6dy44cHIqYOO9uyMIVmmV?=
 =?us-ascii?Q?vSu1RH2A/qXx8Opm6KUG6BwcbLrVNa9IYQYb0rP384Rt0vPX4YPsEBEpqXIB?=
 =?us-ascii?Q?d/W9HslO6d8dE1g2tgQ7WE6mhon0qYOaFJbX2IBBu9BGGNG7s21kyFbYf9Ae?=
 =?us-ascii?Q?NrKybp3s0SZGxB6xI8wDsevY11wvwlPbDemRiwPLlME4BhujH4CgQ7t2YFxR?=
 =?us-ascii?Q?kI65d2X6TzlQ6MQDN6kPsGKZg/SrHKPpT7St26MJNGhfhM/SG4/yOtYnfifE?=
 =?us-ascii?Q?2L2/vCVKEBh68N1BBnBsLqmN4css0DLu0gmI3k191mInknwEF35A9UVPxcyZ?=
 =?us-ascii?Q?w+YjQAHacIwIRqP6tVOAR3WRIn73s05pYTWVUxeNmfUkEJCwhlfyX6XRofxB?=
 =?us-ascii?Q?9LgAr1GwUHFLd6lk0VNzbzxgeaz4q63Op6xqxGFuSkluPhGEg77vf+1rJ3vg?=
 =?us-ascii?Q?gUY7lURemiDJaA/qqNkHPle8TS2/F6mZAFYCbVihyyY7Y3FMA8x+P4fJwnJU?=
 =?us-ascii?Q?JBkJl/0H7coXMYzg82a93ysSqG3cwT4LElN+Ni3g1kF0ANBwrLcwyYPDmyMA?=
 =?us-ascii?Q?VKwJJYXAKc2UiXuzuQi53VempsfNqSd5UvwnSBzN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	1I2FuBaIl/WTbvBF+ha31NYMRpuQ2QLckMwvqH1Tx9XzaV3yXclGX1JmhzBH9k599q7lGXOgFTD/U1cqzfnoT7Xo0Q97wPaZETvdMpfgmt175vIwJDNRx+ujdcIz3TndDiz4A7UZEk6csi4DSXHkBh2snJxtkEk5eEcMRG5+MzDIVxUiu1jIzHVM/IRDA9MXSVMxvqoMJ1LePekVIepqAaDKVPSprlGrsDbT77LQOCaj6gB032WzqLW8a+SSBIl/2W6FPcrQYoLZdB2pNxStVkC69j1DMAut9vtEwegXw546G5vpM4+yuzIkKenZThJD6eKCxdKp2kfUQ7QfTfTHP1X4dDbf1N9gh4ubcH4Vdfc7GaxR+Yza1qsa05PlrhHOlx7Vev4mIyKQqIp0dgeDSASg6EUT91m44PhRbIdhsO8vj1xI771idBoSbLfs4jMtf+V7UUu8LoGK/xOr5dnaR484wDnCYUtgRwu8z5vmrTBwBsUeRfO3U7eNQKCflNidytcGqZ7b9c0gkagvatBlb2aDaPNGb+ocbXEdPzPhTD6rDL2sLYL3IXFuA5S3WEHxLdUUAVRd+JSyRT+SmeuZX6niCfZcn8fJEhrQ2u8OSa1SJU9AN3Kx9JxQkVkJHzFLnjALKiAglQ9mOjBjGddcMzY5nH3LjRr867/U04zrc1ir3ZE8ECsAstiSvFBOwFGSrnh7YpNpJpWlJI50N+UNyQFfzJmt9fhMildzj0wf1qvRLnr4f+u28kFQ4UX1Nneh169M3olG7jDH5TkTyKK2IJ/V9ZOgsbn57+BrF3Qu7U+Uf5ueALJH5KB+16N3lXR3a7uMq+Jh7HyUKUt/JFl23M+GSiE5DBRYY4xT5dM2dKqeZM52/jHOzN4VmMmbEX4Y
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2ebd20-d3db-4620-bc1b-08db054df334
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2023 18:47:35.3684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntfo2WjkavodzOM2zl+X54Pr8GF1eQ7e7Qddxv24sgGt3NCEZ6/LYw1HxJGj3qELzIFmAo0LdbiHFTuC481pGrk3zQ83IAHt5/3GmZyWLhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5975
X-Proofpoint-GUID: 7sPtHAtNXGMklH5HVdBESRmTgf09o1IR
X-Proofpoint-ORIG-GUID: 7sPtHAtNXGMklH5HVdBESRmTgf09o1IR
X-Sony-Outbound-GUID: 7sPtHAtNXGMklH5HVdBESRmTgf09o1IR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_12,2023-02-02_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_104817_199062_87B69802 
X-CRM114-Status: GOOD (  16.87  )
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

> I've been trying to look for this code in latest upstream and it has chan=
ged entirely.  Any chance you could do a quick run with Linux 6.1?

Hi Christoph,
I tried same test on 6.1.9 (uname -r -> 6.1.9) for Samsung PM9A3

Samsung Electronics Co Ltd Device a80a

It gave me the result as on older kernel: failure in power state change and=
 device disappeared after test (logs below)
```
[  365.052300] pcieport 0000:00:03.4: aer_inject: Injecting errors 00000000=
/00004000 into device 0000:0b:00.0
[  365.062200] pcieport 0000:00:03.4: AER: Uncorrected (Fatal) error receiv=
ed: 0000:0b:00.0
[  365.070439] nvme 0000:0b:00.0: AER: PCIe Bus Error: severity=3DUncorrect=
ed (Fatal), type=3DInaccessible, (Unregistered Agent ID)
[  365.081824] pcieport 0000:00:03.4: AER: broadcast error_detected message
[  365.088635] nvme nvme5: frozen state error detected, reset controller
[  365.157742] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 0
[  366.205193] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 1008
[  366.213394] pcieport 0000:00:03.4: AER: Root Port link has been reset (0=
)
[  366.220312] pcieport 0000:00:03.4: AER: broadcast slot_reset message
[  366.226771] nvme nvme5: restart after slot reset
[  366.232018] pcieport 0000:00:03.4: re-enabling LTR
[  366.239088] nvme 0000:0b:00.0: restoring config space at offset 0x3c (wa=
s 0xffffffff, writing 0x10a) =20
...
[  366.994113] nvme 0000:0b:00.0: restoring config space at offset 0x8 (was=
 0xffffffff, writing 0x1080200)
[  367.003924] nvme 0000:0b:00.0: restoring config space at offset 0x4 (was=
 0xffffffff, writing 0x100406)
[  367.013663] nvme 0000:0b:00.0: restoring config space at offset 0x0 (was=
 0xffffffff, writing 0xa80a144d)
[  367.023595] pcieport 0000:00:03.4: AER: broadcast resume message
[  367.045269] nvme 0000:0b:00.0: Unable to change power state from D3cold =
to D0, device inaccessible
[  367.061721] nvme nvme5: Removing after probe failure status: -19
[  367.089330] nvme5n1: detected capacity change from 3750748848 to 0
[  367.096431] pcieport 0000:00:03.4: AER: device recovery successful
[  367.096470] nvme 0000:0b:00.0: vgaarb: pci_notify
[  367.226016] pci 0000:0b:00.0: vgaarb: pci_notify
```
# ls /dev/nvme5n1
ls: cannot access '/dev/nvme5n1': No such file or directory

I run the same test for another Samsung drive: PM1733
0b:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a=
824 (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd Device a801

```
[  334.527200] pcieport 0000:00:03.4: aer_inject: Injecting errors 00000000=
/00004000 into device 0000:0b:00.0
[  334.537072] pcieport 0000:00:03.4: AER: Uncorrected (Fatal) error receiv=
ed: 0000:0b:00.0
[  334.545320] nvme 0000:0b:00.0: AER: PCIe Bus Error: severity=3DUncorrect=
ed (Fatal), type=3DInaccessible, (Unregistered Agent ID)
[  334.556682] pcieport 0000:00:03.4: AER: broadcast error_detected message
[  334.563467] nvme nvme5: frozen state error detected, reset controller
[  334.615434] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 0
[  335.655445] pcieport 0000:00:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 1008
[  335.663647] pcieport 0000:00:03.4: AER: Root Port link has been reset (0=
)
[  335.670523] pcieport 0000:00:03.4: AER: broadcast slot_reset message
[  335.676954] nvme nvme5: restart after slot reset
[  335.684371] nvme 0000:0b:00.0: restoring config space at offset 0x3c (wa=
s 0xffffffff, writing 0x10a)
[  336.427724] nvme 0000:0b:00.0: restoring config space at offset 0x8 (was=
 0xffffffff, writing 0x1080200)
[  336.437510] nvme 0000:0b:00.0: restoring config space at offset 0x4 (was=
 0xffffffff, writing 0x100406)
[  336.447215] nvme 0000:0b:00.0: restoring config space at offset 0x0 (was=
 0xffffffff, writing 0xa824144d)
[  336.457117] pcieport 0000:00:03.4: AER: broadcast resume message
[  336.479575] nvme 0000:0b:00.0: Unable to change power state from D3cold =
to D0, device inaccessible
[  336.494264] nvme nvme5: Removing after probe failure status: -19
[  336.535861] pcieport 0000:00:03.4: AER: device recovery successful
[  336.535899] nvme 0000:0b:00.0: vgaarb: pci_notify
[  336.691465] pci 0000:0b:00.0: vgaarb: pci_notify
```

And again KIOXIA CD6 Device 1e0f:0007
This time recovery seems to works fine=20
```
[  760.688465] pcieport 0000:80:03.4: aer_inject: Injecting errors 00000000=
/00004000 into device 0000:85:00.0
[  760.700437] pcieport 0000:80:03.4: AER: Uncorrected (Fatal) error receiv=
ed: 0000:85:00.0
[  760.710238] nvme 0000:85:00.0: AER: PCIe Bus Error: severity=3DUncorrect=
ed (Fatal), type=3DInaccessible, (Unregistered Agent ID)
[  760.723600] pcieport 0000:80:03.4: AER: broadcast error_detected message
[  760.732011] nvme nvme3: frozen state error detected, reset controller
[  760.793311] pcieport 0000:80:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 0
[  761.819692] pcieport 0000:80:03.4: pciehp: pciehp_reset_slot: SLOTCTRL 7=
0 write cmd 1008
[  761.829594] pcieport 0000:80:03.4: AER: Root Port link has been reset (0=
)
[  761.838156] pcieport 0000:80:03.4: AER: broadcast slot_reset message
[  761.846263] nvme nvme3: restart after slot reset
[  761.852721] nvme 0000:85:00.0: restoring config space at offset 0x30 (wa=
s 0x0, writing 0xbc200000)
[  761.863559] nvme 0000:85:00.0: restoring config space at offset 0x10 (wa=
s 0x4, writing 0xbc210004)
[  761.874389] nvme 0000:85:00.0: restoring config space at offset 0xc (was=
 0x0, writing 0x10)
[  761.884634] nvme 0000:85:00.0: restoring config space at offset 0x4 (was=
 0x100000, writing 0x100406)
[  761.895725] pcieport 0000:80:03.4: AER: broadcast resume message
[  761.921897] nvme 0000:85:00.0: saving config space at offset 0x0 (readin=
g 0x71e0f)
...
[  762.055409] nvme 0000:85:00.0: saving config space at offset 0x38 (readi=
ng 0x0)
[  762.064599] nvme 0000:85:00.0: saving config space at offset 0x3c (readi=
ng 0x1ff)
[  762.079458] nvme nvme3: Shutdown timeout set to 16 seconds
[  762.166218] nvme nvme3: 64/0/0 default/read/poll queues
[  762.176470] pcieport 0000:80:03.4: AER: device recovery successful
```
Device is still visible:

# ls /dev/nvme3n1
/dev/nvme3n1

So looks like behavior is very similar on 6.1.9 to what I experience with 5=
.15 kernel


