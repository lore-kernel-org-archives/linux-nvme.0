Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B0AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:04:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01D52073E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Zhwgga/U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oI6ujgOD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cIX6pF/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01D52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Uj8ybJDsnIARQNGIXEGqZrmP/LfMY5waePx+d+Mpa8Q=; b=Zhwgga/U8sPdXlwxQH8+1p5Lb
	oeM8/XaZ6FlJ7wz5KKkaCDzHd7qeqqnVfRLuB3owW2s6gODVS4Leiq2ai51jDhPUMlRk1XOq+NLp8
	hmp+BbANnngNgpJbnhG0vajvvzUBbvZ0K1ZmpNg8fhC2adGHGYxFF1UfhVyRIC3ceKCOHF31KdruY
	30FHu8w3pVtyn495qGzLCn7aODJpsst7chSX32BZNz26aMxeHdgwLg7VI7h5FNqiwZ9Bl7LCZ4Z9L
	X7wdRSSAqvxjdkMoON4Z6ryHYuZqgSloZZ+frhFEwix1ivnTQi0iprtVHR4LJyX3FODk0rkPtq8li
	oPyVHt0nQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5GqP-0008Ap-4S; Mon, 10 Aug 2020 23:04:41 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5GqN-0008AJ-1D
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:04:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597100678; x=1628636678;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=iqPqjuWcDXypVByvjDjoI1ZajSQ06jnqlRlhhGNSEv0=;
 b=oI6ujgODxgkkLzvBMzUEcc8i23650yhYC4Skpvo0CbLmvU4yFiGl2f0z
 9GtgvOeMfdWUbfHW9u73TQyJYBdA7TUDqJSnn75dZNeqwvGXgRdvcuPT2
 7B07jqF1g8Z0Wj/4N7xCxgeZveBKDsVh1kD6MjJCWNEKlMJmokKvcnAbA
 9sToDbVS+rR+KCtlIu4rKUOOZmPL7eYiMxqhXJYveew2a4R17crNqAMCi
 tMqfWV89IfMP0CXq0c4j5mKi0pxz4/6ZbPvdBBjGDx2EsW9WRIleKZ40h
 F5zRsiG4KpxEPVxQlElGmD3s0BfA6zf5qYRQiUYTL2TMkbEPOXl1SB+eM g==;
IronPort-SDR: sPOVQd+C7kBH0QlUB7aIXDVndw1LATyOJtmjKUq4vFG0TgFiQ2qsogd9EzJxwTwZwnbp6VHIMc
 MNAZfVLIfAGKKkHRyx9R+b1tFUd52ymZs1PK/W7tsgbGSozYvK44wfeMCPqckKQG0XPDOB2tGY
 FygIfZGoULyjycnUQ3d7ZfYkNNFR0fibIjcNp+7fza74LceW9GZvEYyHoq6roLy3+ETExvzw8Y
 WmPZfFnEYKXENybGsAKwLkF70OrSKGQ+fZ6iJNkPf25VFCxHHnXvpreCtifDB+lrcNcDHHIm2l
 wgM=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144615965"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dStDhIo1+/jbU0Trhk2oI/btj2yHtjdABu1QC5k95Afaq8Ns8qwd5TVOmN873nerNGypbZgJAUxJJiSepJXQ0n+d8wo8E/CeU3k5BGGGFBCXj2DgK5S8UIBwz138IOLHQL0dSdqy6OhumqN+vqS8VkvZExcwAnawvEB5az95CzlJVXPP9/tltPFCrahVDSDF++QZG7QtXQQta0CYSEMkDXznA4HurMhFpoiNJ9soi3ybaW2Lyl0S7Z0Er7G2TmzRjPkwewBxs4fdA/VMyP7HsveMNY9AJxmTN1PZIz7pgCysL1MQnOaqNxSicyrqw8mMTFezMIS3KQfPiliEe+DxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqPqjuWcDXypVByvjDjoI1ZajSQ06jnqlRlhhGNSEv0=;
 b=OmP+T79EmG4nnMIXasd/p4hUWoSqrszt77mUM2wbpJeZk5I2TXIRWmxwxUjYTMlKjactlz/5i2hAvrRRgaad+UGjzJOaF/QAPoaTgWso3BK+9+2fUhpVuGHvSwc+V6d+3DUgIu5TrVIkTGmBdCq04i/4P3luakausy95tLMWlcT1EZws/ZRQyZcxFEfrI7eCDwK3bhjoEDS8jQztDW7LFK6Av0b3Q1RjXlxbPue1SoKHKCVUoYNyI29MgHdilA1FMbCwERGiPEsMrJFM4BqMZLVXUnm2NnrMgulnKhdh2JmGwpIqP9kkkL9FGwu+DnOJTtF/LDKCNPWX1Gz53b5h/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqPqjuWcDXypVByvjDjoI1ZajSQ06jnqlRlhhGNSEv0=;
 b=cIX6pF/cMCzaVYnbudufOv0FOx0Tc9ozvxSyn1icoKmeFwLMIRYnQuvQwPmSah2sd5KfxRkSAAV3qG1vFMvdLGWS5HD3DMtzEHJ4XJwF9lTNQVJ3sdoRbxSLv9yUbcAMrSK8vWXNagXrJ8M0dgYL0tG0kjgf8+fWafhefb4QGZQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5255.namprd04.prod.outlook.com (2603:10b6:a03:cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 23:04:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:04:36 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Topic: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Index: AQHWb0fs0yKpxgu3gEaaZuX9mEBqyg==
Date: Mon, 10 Aug 2020 23:04:36 +0000
Message-ID: <BYAPR04MB4965560F533D2B758FB7132886440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
 <20200810211119.GB269401@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f7ee97c9-2d88-4100-2b9d-08d83d81c0e1
x-ms-traffictypediagnostic: BYAPR04MB5255:
x-microsoft-antispam-prvs: <BYAPR04MB52559123B4CA6363D4611DF586440@BYAPR04MB5255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Q+7/iZsmlOz+gxr+GvNigE5cKV9Ct1/22Pa8JmDdDBswOOmS64b+fOeDoU+SbZt3diIbQCDjBNnvl0n8IMSPC8utr0xz1st/Jg5k2NKhtaSjJqI10yi8nmKpmqyqwxyNFq+9HVmpqf0A1FLeG7wkTReCfIVpk2Wjeruj4zDObPfC1w+qzmnWAvBL0l5JurnjBTjACKFihSy7pOuF+G4VVB6fkNGEFhWwlEQK7rvXLKGNDiew4H2oiJWcH+WSs7DbKDDvYzqyrKXKcoRkJ+SyK9WfOCb7DvqiRSHU57qjQUIGszGOSQEguZrO8+dWKf/TcHv8sJwEeU1rp2xvtbHpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(5660300002)(4326008)(55016002)(8676002)(186003)(478600001)(53546011)(6506007)(86362001)(2906002)(26005)(6916009)(33656002)(52536014)(7696005)(66556008)(66446008)(83380400001)(66476007)(9686003)(4744005)(71200400001)(66946007)(8936002)(64756008)(76116006)(54906003)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Kv0ee1P+MWyQ0TJl50abtbizh7mciwI/9W3lfSN2WCV5dnbNPA+z3H10q+wKPkBLr87mG+naODayjDXP25yuOOJMrCaYwdjDKteQYRoXxoDllplkAuh4LfqDmPc9wZ5cY0P0ro6vEkuGWMEm/49bD9AF5wovx4d+EF3Ff+MpihQEfua/T9dxE6ycNVSX8VBu3ktBqgNv+DTk7kLlX9veCkJntcr3ZygR0gAUdJ8n/3ynJLj0jsGl16nRyQemg+XJys64/zkxbFnLR40nCLJcjQLP+5O7aJxl+Sjr+ayZ0CZGolD1QWIHJ6afqRYuqZM7qVUgRIGiYuKI3gysQWoBW4nm8WX6+XrrfhLZJzK7nDOVhCNUWKVdHdpMaqVexOfLlY27r8RUDDNZSaEeUjaHMQPgK4jPBBuscnL4pOCK78KX+c60lOr4GiKA+JTTvEWmzXzyZRRcOuesAiiTEq84eAUNiMCTAYxVwe2fbgZHGl4/RL0cYMDZJaPdSgMrnbXld2zkGUjKAJRJ8GUSeP2uE5Y/NB5uTHOBpYrnWIw08GySwTwBiGsz8yb9yoUfbIBiKv4/W2sI0QOj6Wi4F3uqlN4MP2+AlMkhTHcLdrR2D7ygmU7B7jw8YTqoJRlJOB9TNgN8d6rlDgqCFAlFyqnf/Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ee97c9-2d88-4100-2b9d-08d83d81c0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:04:36.7913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rih7vgPIkBLaoeMGpeJHZq+6CPBqy9pwVXf6tDU/InWEv9HcRRG1KSt4vHJyBU726e4pfispr56age5Q3sCGzCnhdjuvk/TMv+4FCoQ1QTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5255
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_190439_211653_FC96C168 
X-CRM114-Status: GOOD (  10.25  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 14:11, Keith Busch wrote:
> Are these flags even used? I'm not finding these getting copied to the
> 'struct request' in this command's setup, nor am I finding anything in
> the blk_execute_rq() path that checks the bio's bi_opf.
> 

Good point, maybe they are needed for backward compatibility ?
Can we be consistent with the backends and different flags ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
