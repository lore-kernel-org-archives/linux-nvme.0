Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F8BC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:33:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F353617C9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 23:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F353617C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=RpMz1QNSP2QO3ODgwyhg84Zj3R1MBI7u58mJUZQMJWU=; b=HH8MW2CX1XYZ8n1pbWwt23ybo
	Zsin0vRVnCQz7klwJRxPZFhuDzMKbR5h4bT8m3A+Fw/2vK0Oqd9YYvLY8ZXr5QgG7M/8PqGgI4XJY
	hWQCqHgSuv/zcAq1K4oew6GdBS+vjaZxUhyLG6HOG+ztPL1HYwiyw9Gv8WqdQCwZPo5o0Y62jGjyM
	XZ4FkziZYgkXGwyjDXfLabHPmHsDVOCJnBwukq1cOIyOUx9qCcT4OEZY4nPYYB31COzDRDuCmm/hR
	yhxaxWtgf840HGruOITHDl5y7yiFRQkghPUW2LsY6KYsyKBbM6Adm5wWCHlj2RL8cMNuEWITZQdFt
	bX0bmO6MQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRNrW-0057pI-4n; Tue, 30 Mar 2021 23:33:30 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRNrM-0057mo-3S
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 23:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617147201; x=1648683201;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=7h1yJyL8kiElDdgJqPgMYNk5APrf33QZr31hJBqZc1E=;
 b=AL5KSkhJCJF+5UYzwPXsqucsM+URqwPGocVSn47efRuev2+rN3UYPHVX
 sjRLmBrdQ68TAmA0/n+y3zcl+dsTGKUbshAgS2R+wrXh63fuh5+qn+NgT
 C9rOdDR2wBbtR7uQ6dBIOVdKKfvJYMTxmvo9WzB+4JTlE8p+xqmF599zH
 PAXLBBXzpKfQNZa3GJgMd/wIyMLq/FmuY7h8uaLmjKbrxQMM3IUr+7BT2
 ZqIbWvgxiaB4ruEFD3x79vVNvZxfWOVPt1onDyZUfjrMJdezJMqvA1hgW
 fTqewUX1czj/DeuwqIeBiCAmM1tRcAA0hJvIZMEk6v7mmNR4Lbw3XV6pB g==;
IronPort-SDR: G50w1G8PNFcjK0ucEq4VK4G9/Or4KlG9paQYWXve0zizI1MrUH2ox++ial9yr9292FgPF9Mcot
 4GGANkDRRLxlzZYjBqQIkEARt01L1HMB84decxgKaHgPUQcX9bvVVvp857CuU7CJBqD07ocOuu
 StvZWZKnbBQbz8GQwxf1JUfToBe1vRDd6GJ9C9ZCiSanzsYsEuCw4daWzI/FjoiCDkaZtknNLq
 LqOAHkJxt8stYr/oF4MqrsmxOiFEEFbb688aUXsuusnfttn5mxHHrueyMai0SfDxaNEeDLxyKW
 XXs=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; d="scan'208";a="164445167"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
 by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:32:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDOq3rqbOX2+z0hAk6BEPMZl0iwp3zl6SCqROgKt21I54mIj5Y+K5PLyM+uBFP1qXf/qog/0Lfz3nKPLMS7z+/0hUKiVVDcr3j0po+jDf+rdBXuN4gbbkXre7T8zxcnb+AasrT8urrwzMB1MAX6Ec6z1I84XmeYtK0sfpkcQmetBpnv/g6zuq2iFngcA2iAI3BN1gDMejH2H8enxYEcBUlxwItkblstpkmqPW8/s9PsDn99SpSNlSTAwxHpw4Q8TFtOAmA/xglQwzuQo2LzsI/dLvX/iTQe6ahTqRrstBBJ86Px72qmCxHb6grlL7a8Z0cApwJS2Zz4RZ5eLm+Wl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h1yJyL8kiElDdgJqPgMYNk5APrf33QZr31hJBqZc1E=;
 b=bCL/EiV7P266SUuTO6ZAPH5XhNujLmyjaLd22MNM9DnrqzJIa4ijGQSVMz4Bn8WmupoVMskp7J+N4WU/C/yaO3bAQTHXL7vO9IbUAiRrfU+Dc/VllxxLPQ7WD+7HFzS6Hp0dJHpf0nfnJLVHM//6IJkcqKmQQXeTN2wG8g07/2XRcESk69f7VQMlDwPAQ3CHRcYLLaIKtR8hSlM1OFY1UMX/4XezW9mZFYoAa/mjRbGCl4kCnrPsi667Gn9iVfp7A+/0tanH6u6d+LN0Meb7645rNQjtX/f/lqb5R8kfxsWHV1vDZWDM5XZgpKK/zT1Jd3Ev07pexBxAjLRda75Z/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h1yJyL8kiElDdgJqPgMYNk5APrf33QZr31hJBqZc1E=;
 b=QvVq6I00cBSLQzbBcm/tfZYuH1wFhO8wPqrtBs4gNqUk1wR9vCcr26oZK1oJNTFHA0WeJEXQdwWbrif4FSuEL2RO3PdiuICUbobqRmm2rVZ0sfRbzBz1Mj3fZJ+f5b8oBlQKQWQyMgBn2AHGZ0R5sWrkfdN0x95s4ePE2PlPfWo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5831.namprd04.prod.outlook.com (2603:10b6:a03:10d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Tue, 30 Mar
 2021 23:31:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:31:53 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Prike Liang <Prike.Liang@amd.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
 "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Thread-Topic: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Thread-Index: AQHXJWXR2892Hcneu0qYuPJJSQvNbg==
Date: Tue, 30 Mar 2021 23:31:53 +0000
Message-ID: <BYAPR04MB496574D855EB7DFC0DA379E4867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1617108844-30110-1-git-send-email-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39753c70-df5a-44dc-452e-08d8f3d4003c
x-ms-traffictypediagnostic: BYAPR04MB5831:
x-microsoft-antispam-prvs: <BYAPR04MB583190EFBBE52B5E15E2F86A867D9@BYAPR04MB5831.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEKxyyK1B52MF+p59ctRFQ1/jrI2L9oEvZ00xWmA+6B5+aaXC9AtkPjWMqhxV09c/CbC60y9b2b9a/36DQBPn4nZEAx4K6kppyGM5LCmc8bP45Ec0eFcgp8V/ANA3ZDJGg8UvK/HXyem7uTPz7BNNkncTrhY5qeO3dQovubHNILkmrp4hgcZeoG4tfZkF247nH7D9M/1+f1Xqi3SdzGocfMR+aIqXiE0GNo2GjiEvTSA8uRvfJc3VsVg8YqoIkBx3kEO71DsAvolj4xEWCZ8HASQqjCp3cTZpsgw9BniVpi9MLYXtuINMKSK2I7hQGOTZ1GNk6F9SgqLXuHnZY3c8GearLHiQTzNIMjprNwfdsQAllxf2AqElSdVs66Dka+nmuG2qEN0jBpom00DO7Vsjo58tqp5EPNaOptowOOZdfakMpFonvKhSBLcsszVaFXLBP65FArzMHdRxxZg6FjFh8ptC40fr2udqZzmIRmn7gzCfTT8CQ9YBkx26DsYsJ1PjOPkMalAt5SDb00BtDXlbAa8uDGQ9rUtVLeBsQWPoJGiYH3XQ8c8Ah2N8jTLtSCyoMoOqwmKg1vded9QTvhxxDiviLyNl0h0i+BT1PGLkGsaAg4QhDWThfcWtJFbx5FFolu/8Yqe+L/Yo0/bK4uJvMLE2CNHiCPWjU2VrHBTows=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(33656002)(76116006)(66476007)(66556008)(26005)(186003)(64756008)(66446008)(66946007)(71200400001)(38100700001)(8936002)(2906002)(52536014)(4326008)(478600001)(8676002)(54906003)(4744005)(7696005)(9686003)(55016002)(316002)(110136005)(15650500001)(86362001)(53546011)(6506007)(5660300002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/mxy3QBy7bBTFnLW7l0Rv9gUyuvgX/GHb81mFOf+ptecGEgrQ2HhdDzZt4wG?=
 =?us-ascii?Q?5u3U429aCdnnf/T3SesiOtYPh7PYvIpDCWrpsTHm/nEj/qzaWoGXn1Brm2U4?=
 =?us-ascii?Q?s5kfO143Rw/QYBq6AAAuY72a3QIItlQFj6Knfs3Su3KRPJQhuXxbItj44ScJ?=
 =?us-ascii?Q?pc3lh1jz3AfiywLcUDukG9WRoE75DbNDd0TgmRTt9bDY7jZ94UuD+EZMS+IX?=
 =?us-ascii?Q?jG7g/p7aaZ+gFWVbRGT9L3nqciMvb6PkalnFqxAc7izeUynMPt4MRAqMaBrk?=
 =?us-ascii?Q?PkioIs/PjGYxj1d1Bf6SVkz4/qZ+QBFpJ/ppOpToNqDnRV5nI9fWBO5tRvt1?=
 =?us-ascii?Q?d0Rw/3T6tcs7+nxdMbeN/OXipSkwtr2I18nKUI2M6SLN2vX0B4UqnZot+KGW?=
 =?us-ascii?Q?7Yfoz5y4rqta1VuZ8sSI576n+vibb5ZZhSRF6YJfBUKRBNpBg8KKjlwWgm6Z?=
 =?us-ascii?Q?opcV/MK0ePijiHuCotSNfq56lHBVR4SG+1zCqEpJo/VmVGNrDA3IKpfFgocb?=
 =?us-ascii?Q?7cQEno1Cpt8qMiDVGGHSW+cSRz9pYBMSmyWmo6lvTqu7aI+gRlEkGXa1upwW?=
 =?us-ascii?Q?O2PKnthxORm0hWLgVrdSKVAQbP0bmrMhH9EE0vq9fIy59luvjhVTc5lAjpCf?=
 =?us-ascii?Q?wkpinh2HWFMmDDxPZkj36PXTQLabyL7YGPWv9cusZlKfq/IiNJVjZgdzohs1?=
 =?us-ascii?Q?a6G/ZQk86ji9ISp00TmAWiWcD4g5pxWZQSeQCr1U7ZNVA5BpWRskJFow40qH?=
 =?us-ascii?Q?53u6DL132ikYaQPmAYESXM2z5mOZY67DUopiyYlf5brdwurxzXDEE/v29QoD?=
 =?us-ascii?Q?8oWWupgyPuwBaZgxqge25tcen5gMBYeUNsImunDQcMYb9AE2aQj6UGwze45i?=
 =?us-ascii?Q?r5IcR1DtLSNxgtTL48sJ3WThcV9lrYr1p+d6ymau9mRcHLkJnszfCqhdzGri?=
 =?us-ascii?Q?zx2DDx5X55YUHiq0iPvQ3D0+LD8AHRZ3/4CqUzsgOgNvtXJT4gnMjvO/fxJi?=
 =?us-ascii?Q?q5dLTVAdRk//4kbli1FeV7zdAy3QZWGAglulpL8uIdVfhBdLsuUHBYGuoJ4X?=
 =?us-ascii?Q?nDmY/N1TyYlHILMR+Xx8WNvAa90s1knpyO/xO9vSqhfB3VvWmSUzh+pImG9E?=
 =?us-ascii?Q?qYYPaF/h2uduTNz6m2WDDeqgEjMOzNpG2owDWTnj+AdJtprB2aTid58L+Fho?=
 =?us-ascii?Q?fIHCGp6TkKCwG9yO8bRPiH1PTrcUpGIOcq62xnRPLHss2CHgAh5M0yxtA/g/?=
 =?us-ascii?Q?AyCSjmfaiV1VjnMR3LU8kQJokNdNeAySlTypkiOXnT1Z9PzwewH4+cx1TI43?=
 =?us-ascii?Q?gaU2WdAgTFbne7wOSvL5q+y+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39753c70-df5a-44dc-452e-08d8f3d4003c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:31:53.4272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zhmtHW8/NeDIV6kEVXmwwiNHRrXF1T3GtM15piPE19fmNTDfUm71E9S1rIluu+vmMh0IAMDzx4lbn+kVFmiXn4W0/cfko16AnXnLSinCV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_003321_237569_F9A37B6D 
X-CRM114-Status: GOOD (  12.56  )
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

On 3/30/21 06:08, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout from s2idle which
> caused by NVME power CFG lost in the SMU FW restore.This issue can be workaround by using
> PCIe power set with simple suspend/resume process path. In the onwards ASIC will try do
> the NVME shutdown save and restore in the SMU FW instead of PCIe power set in the driver.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---

Did you get a chance to run checkpatch.pl on this patch ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
