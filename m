Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0769C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 19:43:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51AA765229
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 19:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AA765229
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=7kG7h7a3Cry9Yp5hkIOQbc4WGDkDq43GhiNZNczZ8+w=; b=K7lrInlmcyILXLw3y2y7RcUhB
	U5q7N6P0x6+lHi/YI6jFVa+X3IJsAvvDH3rOy35mas9P8BpDSGTv/gks5DhxXxxs9E0cmBUc2Ynne
	QywGYNjTlZ5XLYIy6y5zYfrRTL5TRUaFwR6qWi/f6nMa5GaKg6wrXR5IgyX9c+NKL7mKP93axQaeZ
	moi6D/XvY14e7dqCGqDaQGd1AMdGmzVf8pc3vTRRtLczNX0sCk+KLtTqs8SGNDNrg0ByxRMU0Hx8s
	ah8Li4w5PVP2HZXY7r1gBxjtQA6CtHt0MljLMpa4gthUUjI54guPUQ/V+K2qDflpaZZcUQrrF515z
	cpwL7EWdw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJiG4-005Jmr-8d; Tue, 09 Mar 2021 19:43:08 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJiG0-005Jm7-0Q
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 19:43:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615318984; x=1646854984;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DcBRa+Lh9k4iJZWfFJpBs0TcY+BQb7/haisccKj+Aog=;
 b=ewyaauRGP8beJnrG8MWCgeCMeVSTH8UYzA0qYJ7V2uf5AkeOT9aPXASL
 oii82gmUJvdHQ0wRKdh807l2CtIEFpcapN8kMYEkWwase8ZzmzeC/Q57Q
 ReMxKHO8R9gb/5xs1LnF5oqqFB87Q9aka+zNT70hdd29dl2+rEvKCrDk5
 NqlHUWC3B6Ua5DzEfoUMIN/3npgrIK6L43aB2+S/A/FHDxlD4vzDKN2dO
 TFiMXwE4zb2AndOlirvKcnlWB2b4MGz/OpWBT8+9ThSwzIU94VTQde5fB
 cGp71/9Z2ANnl3lVfr7NGeNTkib/SnlqeT8jJqiQFcdZrX180A+qOgHv6 w==;
IronPort-SDR: mn1cqUaMT8VRMF6cwCnYJuMdA17PKizMPUfMzzqjQBgTEDC+1iaqeGq2MSCsyczEMjEAsMzVAQ
 hM2MOoyZJZWHi1OGwAJiEr0X+d+5mU7ljyMDMS8RnwnVSPlSZyq1AJ3as36sA4SnDUt1Nlr5X0
 ODmRlsygOxPSIFnUlBZ/eVPeezI/728MZpkitMIEUHreKv5mqLiBu89Za+ASH8J9zxiTfz7mrm
 OWYKNV00yC83Dq7CKIq33i6JenCt/E86y81Zg955KiJaP/2nWw1hJmeFfLGozZ7LMlgk2dc1V8
 Dqk=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="162910758"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 03:42:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SStHVWX3pEWzgqgXBM4T9b7ZK7nmM3WiBF07uILrTj/SzSN9RNVoL3d80klsLe8M/qX6PLHQvqGl9cfwpDzXIgTHfar+2QzciiKRTImi0i8ozNl1ye40cL+UkYNCyf6z36RLwi/p4acoi/c/ITVtIHllSYUO9RgVJPEuZdZy/KPe+bluBVJWnegPsCoOPtW9xGT6qs+hI2x+F26ckuuYov/JEEcgZf9v1EskQdH/CUWam41cnOxb16khRn/oGGXoq6HeItpMALnI9xBBeL4U45xBznWzS/NsSfN4dtOW9r2YK1/+rA3vmqp+nU1xGX9xxQDCOkmr8NcvPXYt+B+Afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcBRa+Lh9k4iJZWfFJpBs0TcY+BQb7/haisccKj+Aog=;
 b=eyWPDTTf6zkUpUL5DEZwQIVCArZj24GVe+74cL5bj1bNRt7NTOJVmJhsKtqCvOQnYGyNef80qLO4jzGDrtxOo7uNDJJvD2fpj4x2bg8GzGlxka4KNZvXoQrjGIrP/Ae62bpjJXEdd6BpVr+G7eRQzmP0NeQF6Wv5SRyQpgD0g2/REHOJO91um+dIC8FKPlFyjJmrPxZfvjjRHVd2GvdCrU3C0n/Ww7iG5/SSkmM2ZST2vR3Nr0solWhnK+jgBTxraaZWezK86ApbGi1Whma+07+wTgjI+70Ip/kChAPCVy6poRiS8hRKUVMuQ309Q5nPB/kef/45FWjGfDWjcHeEUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcBRa+Lh9k4iJZWfFJpBs0TcY+BQb7/haisccKj+Aog=;
 b=Ke4zz6KF0FY9SmSJy0HPnQPCwCoTAPtoj+5CLuZMGJc2LDrgo7+9M4ZNoQ2fH8Q2rSBFHCEB+zyMrFnID4V7XdzPuKwF2cLdLGaWXezYZnj7pSWn/YfKPLYipfYRmrn6BrycBR6XmbGTMOoRKtyqrKyG+Rmc/+YkIwAg0iS3O4c=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7437.namprd04.prod.outlook.com (2603:10b6:a03:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 19:42:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 19:42:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "james.smart@broadcom.com"
 <james.smart@broadcom.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V2 0/8] nvme: few cleanups and small improvements
Thread-Topic: [PATCH V2 0/8] nvme: few cleanups and small improvements
Thread-Index: AQHXDj94aE43qW80wkyTAPOfjpKvBA==
Date: Tue, 9 Mar 2021 19:42:57 +0000
Message-ID: <BYAPR04MB4965D4BBD4CDB83B9A4357D586929@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
 <20210309100933.GC7372@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eafc7d7a-fcf4-4dd2-7092-08d8e3338a5d
x-ms-traffictypediagnostic: SJ0PR04MB7437:
x-microsoft-antispam-prvs: <SJ0PR04MB743776CAE0EA9DBDE48832FE86929@SJ0PR04MB7437.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QstyPo7o5brv2yULft+Gmo2O6IqOmGL3tul0BeYYQR/DPyXu0NLWDpFe6P4hfI5DeqEaZTb97veviXtihrYFejKGsW+rf3+OJSwIjotB5s6j6Kw5WUlNNUXdMBQrTxe2qSFFVmylu7qCRpv2F40vaWjvVmPLv3mwa5EuIU6EVPwR1hfbMaOSQ0kcsS2Ve/RRNDP1lFSlR9XIEh7XZ3oJ4yYA/z8lqFvux8+bndMSyavhI8njUDFk6Y9VfKGIYbY5XqjL5v7Xjg7w07Cz0boChzzpkjcvGewp10fmXADyds+un/uJoUjR8xoYO99sZg9OGmQvLxPzQpzETKJqt1yBnmZ0N2dpDVbnRxxmawKaHw3dAKe4WSuan1oUrwjbuTytxKVJKXhc36b0zshenFTxLxZoyQxZ97K65pZfJ6OoajN84fCjWMIFplCaiTCaQhaFzBwKbMVllJyrFT0oYtLJauJKt5x1i+X2cQYGwfrWgD122O6jzN7KpF4pKHk6IekVeXSHq6pAlsTqGd5JIJAmyQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(26005)(66476007)(66556008)(55016002)(8676002)(53546011)(2906002)(6916009)(71200400001)(6506007)(9686003)(186003)(66446008)(52536014)(558084003)(33656002)(64756008)(76116006)(5660300002)(86362001)(316002)(4326008)(8936002)(478600001)(54906003)(66946007)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oVD5IjcYCXLTeSSb2SIVz95nMr/4/+F7O5zZKKNYfRIgevsaMuCgRxKpJP6S?=
 =?us-ascii?Q?OP3ef7sKWieODuY9tLluclJsFPFKHbUm3DuN1scC6k+Choiafg1WcSANt25F?=
 =?us-ascii?Q?gdYPpMmSsY7SWhun6NOKcRlP6ig2yqacVLkeQxV1eHh3pTTmwPT0z5ga4MT+?=
 =?us-ascii?Q?G70NMDXqAhELf+j/ck/z2JTfFu+04bPMX4vUT9f6TQu1jwztqrlGDF0/4kDq?=
 =?us-ascii?Q?efsFAURRKYhHP04oX9DYxmqI8u909HMhE65imCzjxBuxaIFb6NSljIYNfaq3?=
 =?us-ascii?Q?LNp5WCeGlKkY7Pn3P8PuTYVlPvEz1FIwgVeugN2Yxn040amfBs0vlZ9xKyE4?=
 =?us-ascii?Q?DV1BAV1mGtXZ9HwvJvstIK7AJGuOsOkpTX3rk7KshdxYB6uDC/PI12NR1mqV?=
 =?us-ascii?Q?F4MfeKOw+Sl5CBIaS4Ki8faG8IjA1Hq1UXQYZ5S0PCmMD4oRvK/xGo0zIZDn?=
 =?us-ascii?Q?KdfpfFXtW3ilsWqDvN8a4wJmpTGOLOPi1udV8m22Wy1pld6HSt/2PxHwPSbu?=
 =?us-ascii?Q?uu6LNuPUN353X5vuF1nNXrEk34ABWnRR7jP+0SyNZRP27FsnbxQAsNV/BxcJ?=
 =?us-ascii?Q?Js1ZtHffSAvjiZ3eJGVRVhkJU97x8dZeXs8cPw4QY7se2rQPxS+7flQOznYj?=
 =?us-ascii?Q?5SrVTvMtGfbKYjEFPCD6WMxFq8F1vbqhrCA7dMU9y6VCMyJWc9ikoniX/OAK?=
 =?us-ascii?Q?Db4XGn3IF1V7bcXbxGN2qPoEyIf4ffeJEpD5GXiU/MmCS9NBNsj/7mMA8aiW?=
 =?us-ascii?Q?+f9ujRFrcHF4Scv0YCYLw4YvKc/AqyV8Eg0gPo0ADgzcvhBin5xgLDL5DtyY?=
 =?us-ascii?Q?3nyNKEY9uzO90tgcMtwa6oZoYdVEpHLvoDvXCOoQ5Bo+Mh6Nz+fFb0ZcB6wS?=
 =?us-ascii?Q?hyLLSWFxJ+N81rW3ufXTHayRhvDogugMu1KYS4GcQp7SxAbW1pOgzKbEvCYA?=
 =?us-ascii?Q?xrE8H93xcz5z4AL8MWyByv9BXfMSaBF0oBcKEDEKn6BLsFF6FSBgHfbAZWQ9?=
 =?us-ascii?Q?llCICYRcOpsLuB/mYKXoVgggnpT/k87YqPUyAYDH7OCZ/wKE5ps09Yfj8Lwv?=
 =?us-ascii?Q?eOMM6V6jSrPiBS4rzdILOGrXl1JXOyrHcMXCyiLanur4ak+hD0jJksWrsQZH?=
 =?us-ascii?Q?w80JKbswCnHJJGYTHbSfmYQXmYPt0SPpuW6JoxaGd6raFlBWiBqZVe859sLt?=
 =?us-ascii?Q?kxVfqukAroNYLrbYxXP2lHr6EJ2R6nkJKVcdKtVo3q/Sm4TCefQE0bQnsK7o?=
 =?us-ascii?Q?6UkHaalTjdGW7UVo3A3xbrt0bgvUhWOH90s4cJNmhx7fOcJFgbldk5VMRxJc?=
 =?us-ascii?Q?vwvDUhP/mKyqbgbRIE8Ofe+m?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafc7d7a-fcf4-4dd2-7092-08d8e3338a5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 19:42:57.5882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tVbF5g7v5jgeHUhPwYVBsiCaxmKMqm69Zg+GZRCcOAtjx4s3C2RtFYiinfMfXZsI1DFq/7D3NDjmV1s8SuDoXlx40axI68zWWj0eMsdWnx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_194304_547947_A4141477 
X-CRM114-Status: GOOD (  10.24  )
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

On 3/9/21 02:09, Christoph Hellwig wrote:
> Applied to nvme-5.13 except for the one likely patch
Okay.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
