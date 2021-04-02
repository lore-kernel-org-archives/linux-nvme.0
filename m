Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC43C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 23:09:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D9561178
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 23:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D9561178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=s25iVwJJOwl6iOB7lC6ck3WUzIrKJLAigNogzxopCnk=; b=c1rZY2JTTjeCtByOIj+H3XWTT
	2iA9EdGZQMkt+tbFotUaYHE5B/dbMHY95bnA00AQzMK7YP3PS+gD2a8ZNYf9etm/erjszi0v1y3nY
	/p7Vpt4lk1dd5YegQXwzq6TeBD1xURGXnDo8tyAL0YeUTCdDlIZiVwOC2fbtujoY0EBle65DCbdcR
	xiz/NHaPZCv1MfQ2LJWBrjLu5ckjXoe1G4IsativID5MwRDoLlvsz6+30ZOVbJCH6/wYPWnjcKaLx
	6lHKoVi3f2Y5JqYE/RlUZUtoUwnt6RDgrovTxAbKViLyg0TQR8KQj87lGEjFRoxtZ4PevmEsyCNl5
	g+bZL9j1Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSSuC-00DxKh-Ab; Fri, 02 Apr 2021 23:08:44 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSStz-00DxJv-0b
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 23:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617404911; x=1648940911;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0NxvcLsXY/OvJADoFnzVnFEb4PaspdHooAaL6UNnEP4=;
 b=SZQP73bsZfaJl1Q+B1AyElml3QshqqRO3FeosVuJXn/JZEJmDr5Kqu+g
 rLHFj1iWB5rCTY+X5X3xVmTfoenP2KGntT2SQJITR0uj+2MSh+3rkcrGe
 UeoxvL1LBjV+VJb8CQnZ8Xq9Hwki76YDSmoOJsyd6gXpwijw4AGno0syh
 7+yHm/Y3nnUbOEV9xcEFEsTD5Iva1H3r0H49BBEVCFntU9vRFICsYWmk1
 /b3j0Ax8gurarGIlC31oaFis6McXIATk9Gzjk8LpqQXOACsp6yNAhKNSJ
 /fbXj6tsZMLNSTgFPJYoKq5yjzS847uuJCOkgNEYOD03ra4iuz2BtqW9a g==;
IronPort-SDR: AvBt3Q9VqOXmS754ss+VQNqKzE6YNbnBen4FczujIDHQQSwzeUpKwMfhO78I9f0qAa0vMbLuvc
 oF3Z8Cq+wrbU8ilBPGNNZVH3M/HMR/UtikLP4pkpI06JMrAkdguGZijaLXvn+njmaVHL2o4ua2
 10oF9tiVFsqGMIjUQDHFzOv6lugweLN+H5ceGPVl5vrSbdE/kmTSGZw0vOhn6Xqnoj70xiO60x
 w6m9bVtwO8GbXsyYX4cNBKFVXoFW97R/1ligpyTon5Qr4i/tizcnYd7HsRbktoR1BPjemYusuW
 j6o=
X-IronPort-AV: E=Sophos;i="5.81,300,1610380800"; d="scan'208";a="163549278"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
 by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2021 07:07:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1ene8Zzf38xtNONw0I6Hor+QBpcHsPLvIz1m6TBE1a82oXa32MPZtjmLwpUQtJdVf1moANH0TUrJ882G8gAGjr9oOMQ0+EjKT2dOEXvgQwNv4Xc3fq5hKOMw0N/z8tvJZRt9EyF3GO1KgIBE99NdXpLXSSYUl/7W/XIq5VPwAmuRhe99Sm7qhTqXO2Eg40yqs9ruxKCKneTgXiggJws0lcLFDpesywqnznyVijVLVHBCKUChFvLNhFpCUaGaSgc/5nMq/tiipuxpbepchCzsNqX9yet4S5YEUL3+5ZXkZna6TQIYM6owExAHz3nMSlQKjdyCT/bIxXLeCKyINtbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqt405sSZh7j1XMBP1OGl9Yw8Z+w66DB/SLniQU/Pzg=;
 b=UZbVZqRw65HDidOMaAK9BHTVrjxKVq0miDPPv5UeyWX3PuhDQSiPRoS4Q4+J5AtrunEToghcsVnTHKvRLIxk82sRdf5YBD+5f3DuEoaTr3EXm+P+8yiEObhUiWd3XYz7gzp9j762hTnxCJmL6W+0eoWf5g1LMTZ4gdpi6UzBWZP7Du4vmXTMm6Xv69CcIckt4w1c9waSRK5NeQ95pOxtUn4TVm+a+DTcNTDF9AzRSSBVcuTl2w0c4bQY1SgDFfDhH4kCib6OyGlNywewj0gzsLw9PemqAqW94nuE4JCZPlzvOrTUvSEYcQBI4mvZZqq7lOBNG/LNttAzjISwAmJhtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lqt405sSZh7j1XMBP1OGl9Yw8Z+w66DB/SLniQU/Pzg=;
 b=gIxD1dqHqxMtfOpfzK+GK1bPEwaqq/VhUWpUWExZfbTFfrH9LX4pK4lRubyEh1O0GtWwwujAWIT8BD1mb7FejaCnVwRqtgffjYHlfYRrVhTn6vcRakLaqS0B+Ya7DtdGYhcBKBVwcdEktwu8DVMwhBya5VN1UT8uMBK1z3NfMU8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5526.namprd04.prod.outlook.com (2603:10b6:a03:e9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 23:07:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3999.032; Fri, 2 Apr 2021
 23:07:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hou Pu <houpu.main@gmail.com>, "amit.engel@dell.com" <amit.engel@dell.com>
CC: "Ran.Anner@dell.com" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC
Thread-Topic: nvmet_set_error ignores error_loc NVMET_NO_ERROR_LOC
Thread-Index: AdcaQlC1JQMsBcUcQtuIzJaPGyvIQA==
Date: Fri, 2 Apr 2021 23:07:21 +0000
Message-ID: <BYAPR04MB49657D66C4F7D7E2360A335E867A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BL0PR1901MB20202EA160DFA04E828A3719EE6B9@BL0PR1901MB2020.namprd19.prod.outlook.com>
 <20210402073531.23753-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2787fd3e-9c0d-47d9-4128-08d8f62c11e5
x-ms-traffictypediagnostic: BYAPR04MB5526:
x-microsoft-antispam-prvs: <BYAPR04MB55268961A22243A8C38EB98E867A9@BYAPR04MB5526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fxXwsUWFU8f7IXIvOBJDTF6aFwyseMtGxd9ioA0XTllbtsSRXoKxK6+Dp+2Kk4itO+pPTkMJt8YGExjkev2GcHsi4Zkh6IXrQ0nHAAc6XHr+YzLDddME74Bu6EJKWatNEYYGkTLqIsmBJk1JUHeok+PjCUdLbx16o+/aikluou9syImXjqAhF3Fl/MzE8I+Z+A1yh8h3Wz6twUQZ2UWhgWrWg0ML7CqzjC1cFTkGAMY+EVUHWIvu3qp8uBMpS2sccOxr1LmsuRjYapXajg1O7M9SbZZotdqnPk6fmzH2RUtiMVFiqOSa7RmXQeuhBhQqeQxcCvKjqsCuBlmGO0OtPux2UTh3OSfjuneYUOAnXzn/VCrg/9XPRce1WayTCTMO1xvNodMxCsMUkwh4vNt4AodSJs9uNxymkOJWocxRQwbvhItsHWYE/FsnBuqrAmyC27fWwZkXejNsNwoHMi9tSZmSttmDc1n3mqWqi2ED+9zo1M2OOoOFj9dUr/CLyyDY0k3rMQ7rJSNnt0/NLpfcUkLZKBiMEJ1EqHZNn6OaWDg/36h0V/eV789aMQoTD5T5We224iwVLbiuyQ5HOJe/ljl0dE9uD7qzGYq3K1pp0S1EhPORRlkk5wLOHllJRXGskpckTu3IVPlUGNaPhxE5D4NF3nHJnaNqPakwpmx3qOQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(86362001)(38100700001)(71200400001)(54906003)(66556008)(8676002)(110136005)(186003)(7696005)(66446008)(6506007)(53546011)(52536014)(4326008)(55016002)(66946007)(66476007)(64756008)(76116006)(9686003)(4744005)(2906002)(83380400001)(316002)(8936002)(26005)(478600001)(33656002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?V/yZbipYumTbpHQozNZaGT5M8Lv/DUHdaQYCQSgcpczswVEorFciMSGzw13E?=
 =?us-ascii?Q?eMA+PlvHoNzI2iQwY5ws6r8V3ZnDc11A28sjEWOpHLKvc12dEdSFsgUeXren?=
 =?us-ascii?Q?6uGd9qY1NyT/+BrbT1q1Hg1O6PsOn/+W8VBVaSNbvY9MWu3Dp5D0PTEbOoi4?=
 =?us-ascii?Q?PgKY1P5VcsUnXLFJDPiYrQbdUtNIU4VjteYGdj9AUKEgHq8223Rf2e43uN2b?=
 =?us-ascii?Q?e0nnL7StIKuHNnIBigNrJAy7WcJ/exZJSUTbyB/+jFeUq8QLsJImb+3cAjik?=
 =?us-ascii?Q?3AapKbzTvWybU2bctR8LFD5MAcRcC0JF7U0oDkR1VYNlod2J5FFVg2Ky4hhc?=
 =?us-ascii?Q?0odGYaF/xKaT+oTermA2oWDjD+34+nQiiM3Dgn8EKOiPqYE124fMBPrSEo7M?=
 =?us-ascii?Q?R5kuNtAAhhUoEqEjXxJyb2cK/Lk0juyOJP6gPIvxPMnPZHht5pDRurA5zKfh?=
 =?us-ascii?Q?u39pMjkI6pGUbznLuOjBbKkCi7hfZsenFi+Lz5KP34bfz7mO0s0fTJ0MWwii?=
 =?us-ascii?Q?bkIofntVxRKxiBPf+mPX7f81Q3ttO9aVIkd7F02O/UmTFklyWu7iF3fNm0r/?=
 =?us-ascii?Q?HiTwbPUtG/YXEhCjQvBW7xpdpIaVq0VMzFy5A97jNIKidZA8Zw8+XxFfPIjn?=
 =?us-ascii?Q?z7FWrDTtxK9Cwb5VKOms5VnHfADSQX9KIQx22Ha/alLR5i2ehrzfVaibPK/d?=
 =?us-ascii?Q?Hwy3Tgp5snIPCk92yIRhUHLnYNcTEYPBHLxLaFR6CzeWJFvVboJeowg2KQtP?=
 =?us-ascii?Q?vwpZz4YYqBxnURnKesfqgthzFNral1SJXArQmeLrzEY2A84U/+WlvmqTvXoG?=
 =?us-ascii?Q?n2dlfuQRSwgzYZNqX3hJAeN6+pDCltmWJK7pcPouVcrrVmH6QGfNV0XGykH+?=
 =?us-ascii?Q?ANe39hkYtBFB25UhahUO+p4hKPT6ZTR1neXRCG74gyyIp3224rfNDNpC/8fA?=
 =?us-ascii?Q?aO3J5FGvB7H39ZXe5Rd7aO4zjtGoNPj4Y6XNX0yPKuoNfUUdl35SI2xgefey?=
 =?us-ascii?Q?v1FJmuoEy+WJqs73AQMscaGgzqzWELeRtqX4zz2DzFF6jnjrgM/j19h0RJXK?=
 =?us-ascii?Q?b5Y5Kfruwvb6+Tat6YCzlgFAFjrhL/+czMdNgRwxuPUZsR3zKQWQt4EFfWkh?=
 =?us-ascii?Q?C3nwwJDS/5/SdHhaU1rXoFBpqn0+acbWcIeSYZNkV5NUmrbdwVlx8xWiujSs?=
 =?us-ascii?Q?Qr2U4sPMceKCtgOPKzr3w0wIDCaLqhMvwJmVq0Tw9F7BXdGBJKcDOXekihzG?=
 =?us-ascii?Q?gP/9kIHRn+eeFHV6XYL631psFK00FKI3OKc+++QqPfKiymLN7F97gCF7EVZb?=
 =?us-ascii?Q?O0cMf7iMxvO5l2j4FBbEqliQ?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2787fd3e-9c0d-47d9-4128-08d8f62c11e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 23:07:21.1216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWm+8CKX9I8IZVC5eTEpKhQ8He4us8W7bdSZp5cb/FNDyNdV/+a4LAp9b8MFjDPGL314czEcm7SLIr289Q1dPadipVkUBInSk1cpLE9SQcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210403_000831_801670_D48C6AEE 
X-CRM114-Status: GOOD (  12.91  )
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

On 4/2/21 00:36, Hou Pu wrote:
> Hi Amit,
> I think the specification does not tell us which error should go into the
> error log page (or does it?). It is decided by implementation and current
> implementation only records errors with an error_loc other than
> NVMET_NO_ERROR_LOC.
>
> So the problem here is that:
> If some errors which do not set error_loc should go into the error log page,
> we need some change here.
>
> Thanks,
> Hou
>
>  

We set the error based on the request so I think for all the errors we
do have
a error location. Have you encountered a place in current code that sets the
error which is not related to any request ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
