Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13159C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 08:18:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D4064E42
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 08:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D4064E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=aA1LMKgkLK59z3nb7nHa9zwFPGxOpYsk3mGpmk1ueL0=; b=WCOdIVlRxMrQ3dBwytpvK/c35
	2JBdSHjBZsm6p/7hCHMVXnpTjVfxWtFNLy30SdvuBfEhG0w9qld7u8RGgeOZh+7Bv5M9W5IhA7yEz
	CC4s3I8Be691xKyGOyR5jA3LFfB1vxkReOe1ERk5Jnnr5hO8nCeDfJ+kqYBEtq93VkNYLCfrtImN5
	Z+8CGEIjryoN2X4iPv7BAT2SsG833qxoA+7yjnfsq6HxaAjA3c34fFpwUMhj3ZN7E7gG5c4bA0eJ0
	489Jxif5zrApqtCewVuaKEXK5lsnOltsfvAOyJlVgQNsYkbxt+0s5MVyfuEF8nUVCU3zgr2S14SJP
	kY4QZTKCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9khb-0003yH-6W; Wed, 10 Feb 2021 08:18:23 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9khX-0003wu-EL
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 08:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612945371; x=1644481371;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=kRW/sXTStLPegIfuw1HF7sT2BgPyx2IieN3ebq//ooM=;
 b=XeGV6CKwFS4uLLpmxp9FjStfdj+TAbe6e9hL7gzfredCgnQAgocMOg2Q
 Icj02ORFD0IVKl6evIfMg/yh+fkffxkg6M1CKkebviGR3j6mjBNeLZTnZ
 U6aVEabKaFgMb1gT6hWqTmHhWveTLth2/VXSCOs+vtS5QqQXYXMTULFJc
 AcQ+0P7F19bUnnco1N8bdAadsYpyMjnS47FmaJLXzX2aSyoPhmtF2LMGw
 NjJfawXps7UUEAi7iapJMQZV6JCQUlCbZ0L5iXF2PekbYQ8bH6aCADWxg
 BdTEv6xJVsk4/QpI6d4z6o3zzNXfjyuyhqyfQnL2ndjYsoonwAU6xk9Nj Q==;
IronPort-SDR: Bgk22io528osMfrF9Yhx64q8Ss6xK+SjIpvb0L242XROTkrx4icnOvUhuL1rjgQdI8uBKrOPur
 H8cWKnRaTz44zrHvC9r0+XMoSoBzWeWC9FZv8rJ09jzIC0lsrimgRcWUCPizqUHaIzC/Ir2xJM
 07jG8KAJQ803ENM6xwtwtodRRIPWPfFVgWAdcVsO7PZXzA+Ixbjw54zh2Wl1OLgr70l08h8mnl
 cpAuy7bcP8QvPae7yaLGv3FoHOG1LUyfeKerox0pTA8tPVoU986Ts/kN5q36qEd79QYCGhu3dr
 mK0=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="263736061"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 16:22:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBl29VU3+HDQLQpfmTWeX9vb5CKbBLDZ4viOPXx/Bri3boN1QKeDZxTbntbv2X+awqSkR2Ndn9BzAHmIZRyAU5Ohw2NCtBSPhRpuhVofllxRMl+78eSoe53XICO6k3gRGZOB4PqrXLaMDR3feFvlORT63mGBbZZ1QCh+ut9mtsgrWTbgurDiKqp0BERnWBj9VebLXGCPb/5yTIvQqyXclE1wdLeKGq761tGvYfryWBMtTlXGMFFZGFsKyQ8EDbskD4OSu4Uz1CADP3O41BKWwtD+tFfTn/zAIEU2XPDTrmrQVOgKClxrLz6wysWMMK7T3Zq63DBmeyv2Rs8R69F6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGcYd0xRkgrCah+DTCDRzZ4/Kgs7F0QyVwcFyAhSkDE=;
 b=CqhAGYdeoSojBfAHudpd1HFPKEXIdmb9kHxg+GjRBye/p7s4SLOPTBl9vNmvwq0M2Yr4AOJEPmcIy+8SJLywwGayHclecVR34uykggY9QGmKL2h11RH6DwvN9mE9TD8nR9DMD1dlw5s22ByQ6k/o4sIEptJPk3vP5NWKgi71NfviUXajMwBYrcJzpIDh0cFdBwJF3I2p4xCoIyS2O7wYeFNoCBwdEWM6MDX9ZsNJYIS7p3escPQq3NVBgnd6QvQ0E9C0BKPNZGFlr0jV5FAGNTCx1OqpFb+AH2eOdtr1pEamATUDxHLSKFGjhehOehNCYYNnA4jcNFfO6oDAh2ElPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGcYd0xRkgrCah+DTCDRzZ4/Kgs7F0QyVwcFyAhSkDE=;
 b=sUvI8C8VGZAUXzFL49t9oMGg5zOsBJvgZMzrtHPtmrLN1s3g+8RSPGqz9tKRueiFY1adg7EsNyOIcMxCac+kpCIp/1rQt8+psQPNQEeLNIC9GRElxaWvwyTjSoJwbpXt3iOWj9aFg6MBO6E5mxmRMMSm9LjcoXX9uova0qVtHqU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 08:18:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 08:18:16 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 09/11] nvme-loop: rename variable to get rid of the warn
Thread-Topic: [PATCH V3 09/11] nvme-loop: rename variable to get rid of the
 warn
Thread-Index: AQHW/3B3v3Wgbqfh5EGDgw4n3UP6kw==
Date: Wed, 10 Feb 2021 08:18:16 +0000
Message-ID: <BYAPR04MB496597E9F3AE6D3D82306C0E868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
 <20210210054802.34269-10-chaitanya.kulkarni@wdc.com>
 <20210210081335.GE24040@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: df5751aa-9103-479c-ad24-08d8cd9c6afd
x-ms-traffictypediagnostic: BYAPR04MB6101:
x-microsoft-antispam-prvs: <BYAPR04MB6101BB6015FB4D34B1DE3969868D9@BYAPR04MB6101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yf2BS9ID2wC+uGNYhw6Y6gxVT4nRwEMMrmxBAVedmpVB+99tIMuCsF9u9QlRWnR7MD4yOEyOIKyyxSA+Y28gkgN4DhSlG6mT1LYecEfH1YC4ZdyF0bq7Z3L30JIPJzx9t5tEc4MoeYpHJw9zKEZKznDvxJoxs31uzFBylC1vdZuwS+RC7oIBQvXTwmwFqUIWQoGIoXvuvmkek690vwfBI8Y99eqTVQ154IuAaSWETKaHgmL1K8CxEpYqdLExlvZtGzkFcFGO3ct4d8uSJ2olo/71T8ff7VgXhklLfRjV4+YWFebrQkWYLLl5JV3Ovq3sbBs63lnpaV8+X1ljLKw5/AfbGSpdIApyiEA2XSUEzxqJIU3nANqz8nAdnDmwqDNEmZ9xNit1O8T+xSlEEmwdFlXx+E0NcxMJ7LPZS0pDEOQ3St5dNRvN17hI5t9y7kEHDc4HuB1MYIfXU+V5daW+5d4rjG0broTv2kh9KnzuPY8ACKKvG2C5i9TxYnaz2VXOpbD9OiQWIQiggDzFFbN2ODyqhR5obrbzl6oaoeEq1swQCo6DxopZ25IpIev1Ofml
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(478600001)(2906002)(9686003)(33656002)(53546011)(8936002)(5660300002)(4326008)(6506007)(8676002)(26005)(55016002)(558084003)(71200400001)(7696005)(6916009)(186003)(86362001)(83380400001)(64756008)(66476007)(54906003)(52536014)(316002)(66446008)(76116006)(66556008)(66946007)(26583001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kDi3lUVknA0EfMu6ydh40urokCwle3Mo3PQji2U/teeBiqocDvdko7DlVUcC?=
 =?us-ascii?Q?3LGsLfrdEe7qYQi0qBEfq8xg8Nu+m+ZTyqSFP9Acj87NCA9fRldy4CIZ13gu?=
 =?us-ascii?Q?9GskOgnNcOm9m9FqF+O2aaK8y+2r2H1dUleXP3Ha0G8eWrFj+BniQ8ztrch+?=
 =?us-ascii?Q?gjMmH5XxXfVSzcrjNvHVtzpuvH4O/4SoBiQxfp8+5WQ0Ubm1gKY+ch71BvfU?=
 =?us-ascii?Q?UNtygABXzDFEF1zJCKp9Q3/TCRUMVHVpAZif+T4pEkcOGvG37hEBT+/EOYen?=
 =?us-ascii?Q?jPKBjzAa7e6fNrzhohhbn8C1bSs916e5sSnK+RxEjsWaUKpj7x/ojsCynlV9?=
 =?us-ascii?Q?q0vowfvPXNFNXE/0k76kSqN94Vl6a64V2MnVFRZQYy2Mo32veUBl9CRXAm28?=
 =?us-ascii?Q?fZm2yeu7W/M0T8Cm36hayEPtfowB8DhEHWbOP8asPZaNKH2NF1xNNLC66j8i?=
 =?us-ascii?Q?FnaiaAVd9SkE7q0H13BlPGDfE/fOGEpwdnqUCmVdTvqo0IrBFhQtRUpiYBxL?=
 =?us-ascii?Q?iede4GP5/bDREEE9xAGwd2UYHaHUnUBcnDkN7NqMEUGLFvreceflrbAksku/?=
 =?us-ascii?Q?nSJsZLTcy/SV094EcjJS8ToKoaRhgxuWvmC41Pck3TbCqKNBo2xr3WAYyYbP?=
 =?us-ascii?Q?UP3t5NXRjbh5wu+kQOZq6b8vuDJkFbKAfiLcQK4zCtrhKTqlBCuAL57AqE75?=
 =?us-ascii?Q?SJnwdOUoU842s36V56J533CY+pPbrlp1+kHjrcnHDbgSQhtaKmxKsz19H/Mc?=
 =?us-ascii?Q?c7IBDpOXSYlTTKmD5PcrPch4Mq8/iw3YFUfROp4pN4O4CNks2wECsDy3PlTW?=
 =?us-ascii?Q?US9spvHYtb2iikl4gsUcrKcuVer8y9PSqXrKJPvPc7W8tsLzlJcdQxxwpkOQ?=
 =?us-ascii?Q?1zb1Uc/+tL0se+kEPQI/ah5dNxG8LYvBtiF5JyNeC7PWxTZx4N0Y/ohc1oiq?=
 =?us-ascii?Q?sZhRm7FAWe/sYKzTDlA0+1fZuJLOPBG0XuGy1bqRdtoZPzJnW7qRUmyD4Iy5?=
 =?us-ascii?Q?qF1DAzNbIwNd4UBJPB6EHtG+u/LR4XzlxnvROlpfptHzeim2Mby7SevfRrd6?=
 =?us-ascii?Q?Wa90W42xtVZ56KD58Rg6G6DetvD5FFXRuiSJzwYyxzbBJS9rB14qfsv4Ozy5?=
 =?us-ascii?Q?RCGEafA9ukMgVJei0ogai5wE7waOCdHxUtLW97s8u6aJP5LfylreVJ9qM2uL?=
 =?us-ascii?Q?j94zf8kuBYMci3+tGnU88/WLFaun0RJzVr4x15iTS29JIow5ex1QxPWIYrd9?=
 =?us-ascii?Q?0og1k1nw60iMdkMxDIPxO2Xs5AwhD3qo2K5u3iJDM7EugC2rOY3zdwKKfF8b?=
 =?us-ascii?Q?LNkfHO12qm63dgWGq0JgdJKl?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5751aa-9103-479c-ad24-08d8cd9c6afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 08:18:16.5198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0fnZXZV5z53wVpSlYTMS2uRvNa9GccTAf1EtKMaWemGN56bMynhR0OVx6uQP8ukc2/wUGvh4PhhtYAMbYEEqxC2TvfGKD4wJwShhrNu8g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_031819_834022_579C9823 
X-CRM114-Status: GOOD (  10.61  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/10/21 00:13, Christoph Hellwig wrote:
> numa_node is a perfectly fine name for a local variable.  Please find
> the global one and rename it instead.
>
I know, the warning is really annoying breaks the automated script for
clean compilation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
