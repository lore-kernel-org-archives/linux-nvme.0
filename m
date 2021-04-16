Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDCC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 07:53:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3546113D
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 07:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3546113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=mj0XwblWJ8/Oe0MhxP7/tkSmPv/9Z0CvtbDb1VhSUng=; b=hib3s9fo301tU5MhRuYahey4s
	BrRvr6kKvKPqTPlPrVDTgpLrxTOSqjgFRtyVlTedcCKUw6awsiGHXu3aY9v2V/3HJVCKq+rLbEi/q
	sXottsS2Dm5zKJYTtYMW0tUyhLKa6KdM1gk66HmPdsw04AetOaldzKebakI+MZ1lNc4+Z13V+amc4
	SJ1yGq4zj2wymwnuh8YzmY4Xbwz/ErgCFApCw3lvpCqt2LbAEIA6g+Yrs3Ef4mPpKuCDQ4OO4Dv0O
	bIOjwcao0HmeKC4p17vCxpdQjF9sPgzpluTufbfNm9kYFWXf8D+tAIrhDibw0+wjfrhLLBt2oHrbd
	6c3o5GhZg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXJHr-001FXg-Ut; Fri, 16 Apr 2021 07:53:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXIyH-001CUy-B9
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 07:33:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=aP6sY37UXVp54JB+x2hefY4yK1N+D/HDKTk38sQRNvI=; b=Pk+8tcGpvV2Dyadx2swd4tKF8g
 EXee1QerlpHSeKU0G4QwCYP50byiEYvXfzSY1HbFr72geqWBufeTr5whWpb0Xhlv8Er21DLixzAmI
 pfvG7I+0Cku6EwDgM9cwkbxJDew6M0ccXmARq0JOqGcnXzE1vs8aJFuKCEyYQVYCzUn+tCnTjrHeb
 GDgvjdyT6tSVqxccq5FcsmvQeNJFFQWEU+pf77szS479QuF3P0AKdo1cGt/+zxElmIyD5p1D9Yx2P
 5Yx0XBhODG3sMLFl8oFpD6B/ZiwxBlEtb3NZ4Dpd6ZyuGAOGYRXUuAegTBWy7KCwE+6wfKG6nY8lJ
 Rcehktvw==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXIyE-0099aH-Kw
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 07:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618558375; x=1650094375;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=2j5kx44k7zzrm3cFdECiFFkl/VmM0iyiyaG5MGFQrW0=;
 b=rTLu2XXucbCYtR+NBX392jdrYb1qNGfgOHriSu5iQHeGxmWySop+cluM
 aWUv8THOd0cw8yNhGAlOpQjiH279KrLHVkPozcolC21WfsD2wbs8iBAy8
 0XwoDfrzJOvh/0I6B+hMBxkIugz8NH6T0PY8qhwoX95gDINE8MbESvUh+
 0v9owUsMKxVkC5FfIB4gn1ey8BRYEWxC1HU0v9ytoLlSdy0nRFOlKwCJU
 csCYnqj2hEpLCcLiA5i5EsV7GJxooY3i1xIDDoE58mrKX46sGfPc+/J17
 pgZATRbQUlCS4vjinlZMJyhahTlu1x4KHMNALGlJ8ZalGFF5xulpwUnSb w==;
IronPort-SDR: FAKrQDSf36ag+RfeQod415beWzFfpxvtEq63gc8V1iKXt4jRdA2mCyNfqEFH94Pc7c1qeC1oOO
 xN5/eObe+iErzWyGFdIxNX4DILqsW65iM8Td4N+ay4LBxLk4Q9WGUZVQql4QgZQfoIl3V8hzgL
 jSZ7Lx2pkxq+gZt4rj+bRTvxDS+tQ3YAHa+R/ee89vKYE6bOO+Vbvwo74KTL7pJc9IWVARnsQq
 XoAVWqMzFXpoSVv3ymxUTJ+t3V35MvK2Jycu0payzjEYExv4OCIqx6w5vbDRTvZZ1NQE+AToqU
 K88=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; d="scan'208";a="165620708"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 15:30:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/GAZX7rSSMr9aDaAMvd9MID851Uv8NaFAkvCb4SyZd/JltK0Tfo+rhwnzTT2IV5MbrEWqo0fTp1o0i0jvcS2MWF+Hf+mkOXeAX7uNaq+gEuqLmfzHfFfEymXHhApqNjYtvj6nHkOr9+k45ZMgm5pXJ1YXUUPnANUi39MxRuMT0UTLvuA3lHn7RH9PWTOlOuuzepDf2tKhgLgUh2wMLoXJJyps4P6KEBN5CCHte/WYodHyOGR9rtWnDXIVhSh/p+salWkORhv+xL0UQU+0t7BXQX75cwCAZwBSeQeAuh+XuFQ5N75Q1/8lVNBU5a5te+TRN3UoWhFscihYNQKe+sfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP6sY37UXVp54JB+x2hefY4yK1N+D/HDKTk38sQRNvI=;
 b=Kp67K1P9rbROlkkqOcS1WQ2BYOo1GKYLWb1f4fbO7/fFPvHMIGPGpYlTd4PJMMjY6MXkBx4rHunSxpmRSFTpJVTcMErm58ew80rctdbDLGzGnUybvbhRXE8/3jLfHUs1MnkCPdlehF1Dp3EED1PmgdlqAaoW8xoLZQLRH7BPpajboTLOegUL2FxeRS4Kb/oAW7XrNfq2nYA0i9CPg1KK8y/Iox2XxG+FFJxFtTyweRdH5Baep7tM366WdmjR3bjZG57O8hfvO40mXc0QlwKO2mRqxvvFWURHW6lkqAeUBmN3K6mh+79FbQ2uC2OFaenrSE5GOd+JfOCIlY/afvQtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP6sY37UXVp54JB+x2hefY4yK1N+D/HDKTk38sQRNvI=;
 b=lLEsULuqsabq9eSFCxBf7PBwK/MtiuDO9zzrVgP4tlmulWam9j2veseaDrIt15lyfq01aZZuJdvDqvM6yLzr6nWiEtMYYpvPO9McfKnykLBUfSjT90F1tSnxFwiqpkEmJlLDudo37Tz+tyAOQvZLdkpAbI+W2fK4rf0zdGALQmY=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6415.namprd04.prod.outlook.com (2603:10b6:208:1a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 07:30:24 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.016; Fri, 16 Apr 2021
 07:30:24 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "dm-devel@redhat.com"
 <dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
 <axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
 <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, Josef Bacik
 <josef@toxicpanda.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Naohiro Aota
 <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 2/4] dm crypt: Fix zoned block device support
Thread-Topic: [PATCH 2/4] dm crypt: Fix zoned block device support
Thread-Index: AQHXMm1hiOyme3G/H0G7ONrrey5MQg==
Date: Fri, 16 Apr 2021 07:30:24 +0000
Message-ID: <BL0PR04MB6514908FACBF6A34D8A085C9E74C9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-3-damien.lemoal@wdc.com>
 <PH0PR04MB74165367AACA8F3D9F7B023A9B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c420:851d:e64f:2199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42bbae3b-f10d-4685-2664-08d900a97fcd
x-ms-traffictypediagnostic: MN2PR04MB6415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB64151808F3F2350F284D5D0BE74C9@MN2PR04MB6415.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P18iKaewacv+Wa048lgjHjpiyEoKrS3dPIanCi20jjc4sv9RN2/XgIk535GD+lZdOdmcZBhwyyHvbtw8HFVc5dZP1OnOIYgHWf+bghw5ClrYGUaT0VBuwkis2UkeRZ5F4LN7BXmiq+Vt2bj15OWgYD+/I6ntz+akpF/Ui6cgDoYrT0EX6J9XUeZaL/UKPTTMRWm7fEFo1QAlxHdtxdXFDPec2A50pNthjHOWzidaIq2yAAfHyY8HsDX5sgMc2nCDi66nTbsTzSNard4F4fEioY3TFtTb53v/19VMce7o2feU0580R2CB5TjTLdP3xsgkp5m530lA8etvHjYGutrq4xr7pTRYR3C1yYLMJkvR8Vrzfm9qY4MlooQye3ryMynoZY8lYDmfJVW6M01JYeqnoKSzAKfqDhC0+mAQdHiqgn9cZNYxDYVcFVEy1TFz3Hij+0UaK1AN56WNLl4FKA+c0hBj/L9O0S9bHi9BsrBGJTUkHtSdn6E74PymzR7ujJIOv2qpqIUdwzpa5pAtAHi+EKN+SK/YnCgcZrXXv4X5HRCG0GOMGOPuyvi3L49DkUD4T8U5zGLsg5HGdQ/v+f2OcsBVmHXQHAbCRR079eU+z1PcuIGZ4jQsxmKzQQcm4No5NOT28TFwT6yc2DvwCAP3ew==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(7416002)(8676002)(478600001)(66946007)(55016002)(2906002)(122000001)(921005)(316002)(186003)(9686003)(110136005)(8936002)(54906003)(66556008)(86362001)(38100700002)(76116006)(66446008)(91956017)(33656002)(52536014)(4326008)(6506007)(7696005)(5660300002)(71200400001)(66476007)(64756008)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8L67xb8/47Ji1HC8CpbkiVcAmN9mGBIwwEkWDnVuRyIVf8io+YDRKNJrbpjI?=
 =?us-ascii?Q?ILqC5rNE9glZBV2tUnMDJupaSTdlJ+zywtnQrLhXQr9NwGG6X3B3jqfpV2N7?=
 =?us-ascii?Q?8BIvzT9zF7Td+s9rA1FLstFIUvpFV6kDiJ7wc6gWOBp/c8/g4TZnDGxjl6PZ?=
 =?us-ascii?Q?B9so6HyM0N6DDRDC0nFS3fcCcl2vf1gwbxlCp4SzDudJPh3GbQY1SAMYt1o6?=
 =?us-ascii?Q?dHas6AzSOvcG+AKfgHVX3CHCsjyLaBLQ32vxH6V8H3AlEB8HcXDyqll5OuZg?=
 =?us-ascii?Q?cCUOQuJYjskvkL41/foTEjh8lBC1dM581rsOKGFoKYYIsCu3y5D25xPJc5IS?=
 =?us-ascii?Q?m/holDsu07ZFRlGHHwWxFeNALm7xH+hvE6AfajkCi3Hdp98zUx5n/xYSN/0z?=
 =?us-ascii?Q?Cy+OAAXWXLpahmBoU01cR3eUqigzYqdGZMqEBUeRNfH4aVHdQ2kCybkxNUcG?=
 =?us-ascii?Q?hezu2XADOQKJ/MlslIBAf3uQXXg1j4zNMy/lmhqLuL9McH+ls6Ujnml/jUhw?=
 =?us-ascii?Q?ErOeb9iPiDowMa47inFb1mCFsf2W5lRsE1GHlUG3EjMiJ+ct/AnDtGPLoadS?=
 =?us-ascii?Q?OjXVMgse8q/iOzFCoo7lN5HLhjnmg41Lwx8Y+ArAotyvwpw+d2/YtyCu0wht?=
 =?us-ascii?Q?tWJSECJnb2Cs5TfYDdsPsewvjekwtljbCCqlMthZiFJuVOh6HBF+UVqDq+39?=
 =?us-ascii?Q?OBwBRhStQLHkEhwPl9FtUKNxnripgL4G7yJ20afOycgnMhMzVsK7dMft4CNZ?=
 =?us-ascii?Q?6qjahg7wWjdtCwYNu8H+mAWCY0gl9UUcLuw+dyWoXzCJwKGBCerFU12S52xz?=
 =?us-ascii?Q?slj9RhCR2QngN5ipnqV2pNkoN1tAhkmMAi4LS5v3jGC98cyhVCQF6SwZNjLe?=
 =?us-ascii?Q?kiHEtCDj1ZVp6BA0tq0j3jgOZ2wFLu4B+nX7fgKNM4NEvh2ZJ5OztoSlIHVM?=
 =?us-ascii?Q?0H+Jo+Aj9xpfYrDUeTB10Oli9b+drvfumBAG9e3y6Q2hVWTeK6b2oiIi8/X2?=
 =?us-ascii?Q?0HZqOWV8iZHP1MTVVDCwN/Zl/+kD2kiObILvqYZ7FR8MtY/KptgDyQ/ii6M4?=
 =?us-ascii?Q?Hq7zS1xMqiY0BPX48T4yGlEJL7mVwkW3K+cHCw2DPApUzI9DBSVdi2VtzuSX?=
 =?us-ascii?Q?xhfchVQKilReovZzv/Jy5ppUaw7C4VsjrzYPI+cLbQBT0+LBU2YtdJD8QXFg?=
 =?us-ascii?Q?u0AArXt8ykybRJlLoUr4+GSs3TMcVUG0LWRH+WS6pz6bEfrFfWGb7RXTleT/?=
 =?us-ascii?Q?sSO76qh07m5n6BNKS38+jwOkqBd6nzm+DvKKH1MPnlrEWm5pfrncQoavdUha?=
 =?us-ascii?Q?O0HS7jdsi5L4XRnoXNzDnXQhHd1AULIVbhvllGbJ+55mqaKVFLOG9eGqgBRo?=
 =?us-ascii?Q?HNYcBAU0cNKelmIUwiadFopj2wrw1QphCSSQB5FWNmB8vhSdng=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bbae3b-f10d-4685-2664-08d900a97fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 07:30:24.2025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eTPsBRoy3VXyjOKoQmWqeek45ohboElu8YdvmwxtejOsvB66/jyz2nZWeDcfdGUYJOvUlPCV34A7dWRPNk83Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6415
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_003254_775584_59278A62 
X-CRM114-Status: GOOD (  18.92  )
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

On 2021/04/16 16:13, Johannes Thumshirn wrote:
> On 16/04/2021 05:05, Damien Le Moal wrote:
> 
> [...]
> 
>> +	CRYPT_IV_NO_SECTORS,		/* IV calculation does not use sectors */
> 
> [...]
> 
>> -	if (ivmode == NULL)
>> +	if (ivmode == NULL) {
>>  		cc->iv_gen_ops = NULL;
>> -	else if (strcmp(ivmode, "plain") == 0)
>> +		set_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags);
>> +	} else if (strcmp(ivmode, "plain") == 0)
> 
> [...]
> 
>> +		if (!test_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags)) {
>> +			DMWARN("Zone append is not supported with sector-based IV cyphers");
>> +			ti->zone_append_not_supported = true;
>> +		}
> 
> I think this negation is hard to follow, at least I had a hard time
> reviewing it.
> 
> Wouldn't it make more sense to use CRYPT_IV_USE_SECTORS, set the bit
> for algorithms that use sectors as IV (like plain64) and then do a 
> normal

There are only 2 IV modes that do not use sectors. null and random. All others
do. Hence the "NO_SECTORS" choice. That is the exception rather than the norm,
the flag indicates that.

> 
> 	if (test_bit(CRYPT_IV_USE_SECTORS, &cc->cipher_flags)) {
> 		DMWARN("Zone append is not supported with sector-based IV cyphers");
> 		ti->zone_append_not_supported = true;
> 	}
> 
> i.e. without the double negation?

Yes. I agree, it is more readable. But adds more lines for the same result. I
could add a small boolean helper to make the "!test_bit(CRYPT_IV_NO_SECTORS,
&cc->cipher_flags)" easier to understand.


> 
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
