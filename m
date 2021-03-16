Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046BCC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:26:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F47165139
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 18:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F47165139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=/2JfYdZ4WDxjGwyJW/zGc91Vp3valFB9Aa2I5ZD/4mQ=; b=Em865+3qnG87TALqlobNZ8sgA
	SB0HyOVtZvmF/fb66bCYM1jzWYXC+Sx5Df4vX0n2MrQBps17y5BfQif/LAE76K8cg2n6fepDqLess
	JSjDrobFr8s2XrxJtoITwJHELCVKN+spWwXIRn/a9NOzIvtlaZN6r6I2OSXRdmIk4GXGOPMZqEnoL
	v25QAeW3FNAUZrr2ak9f5Ou94nDLvq5O2iBPXOVu75Cr1eLhlKFF2PX5BHGQGfNtB54ffIfM+qRhn
	pNWqY/KWEKF+j3f/rCZm2dRoMegxIPSGjw84AmvEEEr36CiKSQbnzWZ0GSrTotgGuF8c7UXXXQ9i1
	vWqdlSTOw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMEOt-001cAT-8V; Tue, 16 Mar 2021 18:26:39 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMEOl-001c9m-W3
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 18:26:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615919204; x=1647455204;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=hrjQr41B5sCv0bI8j6OG07C8+1uBofvi/VVkX12zS5Q=;
 b=C3N/fmNGyXls0l3dyluZbsWVVwAKrkJ+/qQ4+m4ERa1QNxTf1lJLi4Zy
 O9b1q3rTHqN/vPkHL3Yi0oJWC4TK763hPxcIDsLxdYaxtBvkzKqPGBy3I
 PH0zugen4qgF59n6bZ3PfsHnrDWnVYaBdWNWm1X6rKfhLyX4+YulY4K2r
 bepLD/dlxorEcFXJyO7VAeHjruN3rYA88FVxU/RVy5bneNOcmrjH14GlU
 8ENuIVoNb8DG8ZV2BsUEY58Wt2Gk3yPGFfRYjaT0c49k3WkZQJCTq30BG
 fU7mJjFV7GwfY/bLVQVI26UxczBAVa4dpad+jp3wVYkN08z/AAQ3bPboA A==;
IronPort-SDR: eltwZcUh/V0th2lTlykOErkLtj7YnxAtPtY9DL3wG/LUI30fDPzaXIxlIf7muVMSMtZ381xN9Q
 UwB7aM8IIrEbNtcAlme0Gtc5bQSk/1GCRD0TNzcIulAzT1ooJ4hbN56Bnx6iQTHuqMiUsJ+PMC
 lJJ57GBW2Va+q+Ol4NVHNpROZVCKQ1iTsjLcgaPlMFdcMD42vAoTtwHWJDL2N62BBQkeVTo4tM
 6pkf1WaBr4Y5GQci3RtkmqaNgx2UHX1t7TV/LcUgvQzIlVNN5596c7F8FESDS831v3qmU/3DDZ
 Uzo=
X-IronPort-AV: E=Sophos;i="5.81,254,1610380800"; d="scan'208";a="266674122"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
 by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 02:26:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1+W28l8/eZD+dS+7G6dStLJ/r+MMv9spUD7CDOxgqMLpt1S+e0mMWJQtKSljydOtiC8Zx2lb2lqtGAWVyPMBUG/nB698O6jKYBzpUMSsZlRR3o/JmEVv3idrvKuiq3aGTe2rXRAPogf8k8bzgLehxTdENaDPnZTMiUe4lNiyg486HOdJr65GWZwiHr4yrY3A6IdMSkxr5nq7vHDThx/QTDo/Nwl7WDhU7w8AjC8KzV76ckH7NPz5krU5SB04pUyKVvt9TWoZzx7+oAztc+fMRoUilQp1weq+7xygpikRyAd6t0XXv+Y32AKoQ4in6nG2TQ9SSnmSIURREDC3uezDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oflheA3fvugz5zijaBLhuQ9R7sXJJODRes5zUJT4mEE=;
 b=Cq90WoJ8Xk5IkOsPq0JDvpnO+1XHQr6DeynSPYknx/gsPwgdtzJmnFQkEsAjzAncFy9SpaO+qKV4f99F2s7ogwfYs02FMSxpk81jk/K5+jfTsXokZCvwB4wk1Ej8zAzyzopjc6HlzYYvzSFTUrEFgrNwIUz3PC/MIoxM9MF+u4jJezVylCnpMb8JhsuyGXfeDcQOkUV0h6P6C3mZMm/rbv18BuVlqZUz//nTrAbdGkqMIHq1e66uafX7neKV/sUd13Ev/wdA6usPZp+WQloIzDC4VUYts+PAGZTJAszGc4/2ICHCzuBmcW+oJmMO7aRiouN9jolOB4zNpk57nTFafA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oflheA3fvugz5zijaBLhuQ9R7sXJJODRes5zUJT4mEE=;
 b=n9Pw4zZx5sVEZDWb3Iqt6qkTxVQVYuX1HXNwjaqWMwpkzHE5znzKrYmNaLJNfgsy9EDt1zSKdAD6eCgeZiCJ/6m/ivdtLCSC3NUFm/IShdnhwKwjaaS+hRwPSa1zyX9vvZalrx70msv4F51uMteCTM9M9LjNB/IMW4nuvrDCYqU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3781.namprd04.prod.outlook.com (2603:10b6:a02:ab::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 18:26:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 18:26:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Engel, Amit" <amit.engel@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
CC: "Anner, Ran" <Ran.Anner@dell.com>
Subject: Re: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC
Thread-Topic: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC
Thread-Index: AdcaQlC1JQMsBcUcQtuIzJaPGyvIQA==
Date: Tue, 16 Mar 2021 18:26:27 +0000
Message-ID: <BYAPR04MB496507F3725ABEA5A8E56E00866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BL0PR1901MB20202EA160DFA04E828A3719EE6B9@BL0PR1901MB2020.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 177653be-497d-4d3d-b989-08d8e8a90323
x-ms-traffictypediagnostic: BYAPR04MB3781:
x-microsoft-antispam-prvs: <BYAPR04MB37818D4D2456B341BC845C04866B9@BYAPR04MB3781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJVQ6oBoJ/0PyxvVXMoMq6KmxRxtHomFSh+uJEvnhSoYSC0NDINIjCFaA4VX0kQk5naWSyXAdq4y3DPXJONsU17PRLyTCGrSmjjL+If0mjTeb5Mg5LXA57OsjkVj74rukygbpEVthVYBqd32513x+a6GzenMXGjsolWvxT5uRuXYQAOrwJp9dkC0XzcJOG0eeoJMJs9yO7TLUCnPhrSHl6KBcVNtCSXBL2UGy+jdsEETYcdXZJJy3Hlrl/uEhE+gy2+JRLa8x+++MC8ePYorZBdZ57eTwHUSR4fqX3wiLc3Nxxh+f765KJ2OCZIOJkF2hUQWQ65lxq6Hd94/LEPLPGqbxLmB0ldl+bDqUFbdSN7ek7ioFgceKtgGMSn4hy6FwMEGLQsuAir4ogSev/IvFxQ5QO8Z2HUs8IhFAHst9OHhbYufLyeHmeSGrSXibFt+Br6WoLjEG4XYDzb154NXq4zXH4dkwRJlTPbZ3YumpOJs+cAtApxXRIRmjmMppRilaGXG8WhHyhN2Q0i3mYiwIE4zBAVTNcXpvICl0aacvtM94tluyp3776p06zFeX2kz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(26005)(2906002)(186003)(4326008)(478600001)(71200400001)(6506007)(66946007)(76116006)(52536014)(7696005)(86362001)(66556008)(83380400001)(5660300002)(66446008)(66476007)(64756008)(91956017)(53546011)(33656002)(8936002)(316002)(110136005)(8676002)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?469WW6erbyHwFUGaKRo2+XuwPo6Eac/CeCjeb4ERx34cw/4DeQ65xXdh2G0M?=
 =?us-ascii?Q?h4plrekV8VstBbchaWrAACIYFf+9eRaeOx7bH98EzeKcCGDU96bIzmo38dSv?=
 =?us-ascii?Q?qXHal+EadgIGXM0A3vA/0osGA3DTm/sQ4C8yK++liBif5ab8LqeSzQwIPf1a?=
 =?us-ascii?Q?Cxy5mfzvRLOKDBG89fqykUVH7t0eEdvmUX/o4jOpLyFFpCzjkFMtajWECZZ1?=
 =?us-ascii?Q?K7JzfDnmvwn0meljmxudcmy1m8UjW6t1kyPiA7K1guqBbt/ssxISnjYuy9JI?=
 =?us-ascii?Q?EiDkn+iWigsq1DfBmmQRoxOIyAAI8OO/xsoBsv0kBZ9SnVYtPFch60Cw4/ai?=
 =?us-ascii?Q?lgDkdsBzAuD7t9tir4VLljiAjB1HH8P5URdDLUQMsijFUKW3lamocn7cF8l+?=
 =?us-ascii?Q?LvfFP9TFbpagut2k2cWcPFb4lFmISQ6R5FAiTIdRC4bf3KWaDWmZHzzsW81K?=
 =?us-ascii?Q?qKiIOLacDfale6axAWeIkEg0XXfUrYx4nHqg4qgoR2qo/b8hWlQJdalKBtAw?=
 =?us-ascii?Q?Yaaph1gizeMedZ5jGdjZosAJOG1wvP1Fhnk1tlmvg2VxtRvlgn7v05nJvmaP?=
 =?us-ascii?Q?42FJD33+MsYhM4jYlxadWMoHXKwhKNpcvieBJTcge4pP+aHqZKhTarJQ14dG?=
 =?us-ascii?Q?Gx6Y2mcGZPX4qSVMajyDXzOGhyujlMRmynDvn1qAVfNmr6SfehDK0r/kbfAn?=
 =?us-ascii?Q?Vu3Ye6QhHSzkDo7kEEGUuB0btLGqTrnix2eEm4uyqVLtk8LpkIkDlDQci9ZN?=
 =?us-ascii?Q?bDcaApUbMhp/lBc410RboqlRW/rFBaOPuksa0P4mUaMc/GIxyUv55vyZICBi?=
 =?us-ascii?Q?6BLU/dH2IW7WKXLuzNJkUd7dks21PLTWg4cuVzUhs6rTluRpLC95mfskaTTC?=
 =?us-ascii?Q?VTNEK2J1K79AjyRLMkzfX+HJEJOptkMRny3RTTHQcXkE9oOTP9HcwIgp86d+?=
 =?us-ascii?Q?urAuzJt5m1t/YsKXXfEsISN/U2sLpY+aNWufRFqaixFYpyFEBN2XOERbqP1m?=
 =?us-ascii?Q?kVzC9e5X4TbqM7uq7hLIYSGXcM7lbnQ2YF8nTtwMUj2LWcbtPW5ngCzqoalT?=
 =?us-ascii?Q?IJpJG8Bb1hhush/6kAO8MmbZdMGdRD0ryaosqXEeaqMHq5+HICHoChTN0pab?=
 =?us-ascii?Q?+gvMdDkIAxLSaESGTZgkZ4JMa9qyTG0BpxE7JwkweIHjQIK+Ix0d0vJq6zL1?=
 =?us-ascii?Q?B13yRJV0Ih4IvV9b3P07DjszZ3iIBhD2w00aFc/oxh9qyorxupbdYkVjqLY/?=
 =?us-ascii?Q?3xO1qSC87jslUDAqWCoV5JGwuTZ8Erb2UcYyHSzDEcBqyyK+fm8xoAtE0PmJ?=
 =?us-ascii?Q?y5Tfk7ygOgcht4YVfXEmQhpn?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177653be-497d-4d3d-b989-08d8e8a90323
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 18:26:27.1582 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KMa1ebTsNDEiLGnWB/Ho9sUACmyaOvZAwSeV3CffwfMhvwmz8M/3cCkv/yPjR0zycNPSLIzoxsSoXOP7ZZfeVGc0pSGpnyTtQzwJBJmTdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3781
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_182632_723979_DBB108B2 
X-CRM114-Status: GOOD (  13.68  )
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

On 3/16/21 02:09, Engel, Amit wrote:
> Hello,
> A question regarding Get Log Page - Error Information lid 01h:
> According to nvme spec 1.4,  bytes 15:14 refer to 'Parameter Error Location'
> "If the error is not specific to a particular command, then this field shall be set to FFFFh"
>
> In the current implementation, nvmet_req_init initializes req->error_loc to NVMET_NO_ERROR_LOC (((u16)-1))
> Then nvmet_set_error has this condition:
>
> if (!ctrl || req->error_loc == NVMET_NO_ERROR_LOC)
> 	return;
>
> means that the error log will not contain errors that don't specify error_loc
> is that expected ? 
> don't we expect that param_error_location log page field will be set to FFFFh in case there is no other valid req->error_loc ?
>

Based on your email description I think this is what is needed,
please confirm I'll send out a patch:-

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b15ed7ac34eb..29a6a1446cd8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -914,6 +914,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct
nvmet_cq *cq,
        req->cqe->sq_head = 0;
        req->ns = NULL;
        req->error_loc = NVMET_NO_ERROR_LOC;
+       req->param_error_location = 0xffff;
        req->error_slba = 0;
 
        /* no support for fused commands yet */


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
