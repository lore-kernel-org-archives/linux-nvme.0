Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22583C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 05:44:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68B22073D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 05:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bC60YPjS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oa0o1OgC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s/FmVQTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68B22073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=X30cq1mstAo7l22L780SYYsQxC+w8bCmf5/7DydDjhA=; b=bC60YPjSAFxMyV
	CjeO2PM7/rdGMo1dMmnnNcxkc+w+M4FbNXGdqSFfZsj78JWPK3LDTc2itiLyZQUIMZLzonMWa6Y8B
	vqtWRtptgD1XSfjJIZ9f9Ti3wLWAp5v3ae3JJXzNBmwivypfEE0i/Wg6+cI9kUt1k8F7lCOUPk74H
	+mqbFdrRujZDzY6VybWGBLAFqDBLQmyQiTUfEA6L1/ZAg01vsC2HnTE4dd+D+2qL4Hi4TaPKwS3AY
	nNqr6hzr1lbrigSJVSurFHasz9fkGbAuIYkWLvhPO08sI6N7OIgl925n2X+nzlqJua4lKKW6r52HV
	sW5KFIdcq1bQOMPfDlZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifHHS-0005Ru-Rd; Thu, 12 Dec 2019 05:44:54 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifHHP-0005RZ-K5
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 05:44:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1576129492; x=1607665492;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=7ZHcYbP7XcFQsXJfvNggdr9uChWRmF+LA7II2zh9ZSM=;
 b=oa0o1OgCKJlfdluS8uiXY42cq3PXTKu/lYhtKqe0uKEsKHGtD4+fSj+f
 0drR+T3G5k+xh8WG+TMF3M0oCgEcE5JKA5n4uQ3WCCyZ+HdMMSY87DwYg
 fe4IjkasMXzR3Pq/rGdtXftv4FWq6q63GcnZIjJ+5X4rBfbjRTw5tGR0W
 vbdGonivk/YM1+ot6Y8u7jDYyaSqjPZBZ3EPu6inATXWjcTHQLNQBaDHW
 gCSfYw+9+Klc12vSCXsLt3l5bZ4VbaCgphSGJC01JTjuGMYlQnI80OGu9
 O+7MWCzqtlIoD6cnDpew788Qlzr8of+V0G9vEyMracwG/DOLwfaV+ibob A==;
IronPort-SDR: Hwc9lCwfQ6F/NjiSDuvba8atPX32cyeXsL6SRdKMgZMA9iYAmv16jy7mlslehqq9Cm3gf9gaCU
 3PBAO4juDanWgEJMPW6GnutF2ulzcFCpZMYVQDEbcYNQREQdyEfV/DoupIH9InXi112tXYjLCU
 aEgh+BDg9J1Jp4lxD21wqR6r74pGepw7ms63LC1ZnJRvkJv2hwIzI+ObWqLUrz0In1pR6/ZvHz
 pQOgIB2GMUmkFnQJ3o9ZN+W7wgBz12exa5nS9wJumhF+cjHU5WAXrhyj8X1Wu3V5007oixi93u
 0xs=
X-IronPort-AV: E=Sophos;i="5.69,304,1571673600"; d="scan'208";a="129603984"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
 by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2019 13:44:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0JJBAoc0VlSla7rE1/eE3TqrBSVrg/bO23P9D8xD4Ij7Y28IOXwJbxLxQOSI9VhKGY5ga130N/3V4g51DjH41l27c7GyvqSiUQjc137/fhhBnmCA+uDvQLFgHCK2J5EGGf6NiAAq+izwHll4byxu/F2+U8ed5wKyrqdNh9UG6nS2aEpT9GdPV7IZR4l2WC+43RYMLVwJPRRYQ2CuJTdLiORVHz/GI+o3Oo87ceBo7QkX3T+zwOmTR1KycFtN2Go6bLkwBbdUqGONn6GnKh+Y+3YbjUiA0pS5+J7krFmS3emmkpU8UujqEP0LWwz/boYn52y+XtvRVmNSshtvUoQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZHcYbP7XcFQsXJfvNggdr9uChWRmF+LA7II2zh9ZSM=;
 b=UDTAI0qLhKLeWvrpWDMGwSW+5OMvcABHIYJP9PhfFUYkbtMhBDSY1ynkuKgCmePtdDr4eFYeSbXuucwm7gjhMbNOa1Emh5woKzemSawt7Hia0/XYUX9aLzDktT3EhI6KOlADqceTJoUXudI6/Yy2/yFZKpBtugouaAZGijTNy+Bjg8fLDboqFwGG9a1zbVPdu2GLhXAKtbw0FHt3kox0Alg/2pC3vxHKsaMKRFujNiAgAEtsx2U+MDxek8wU9784p+qWwNkc4j0nwStYY//vS3etpGAL/XyCuCsGVgxWoHl/hzu8ielGadl+9yBcoYjUaaxNY+89+5kGwn4ccEBLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZHcYbP7XcFQsXJfvNggdr9uChWRmF+LA7II2zh9ZSM=;
 b=s/FmVQTyigUUPdqjfVcn8t1rLERVxt4eQSkcGjELFSXT9PuhnB7Mz+mrZmgFRQDm1Lvf6INeA0Oke5iGaG68k5WVo9bicmV6pCmM3k/ec+SfQjROS9Htd668sbOBK4yeMYFRghRZ3RzpZMmXbl11mUXXoacxbu/ZiPAPy/yYf94=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4389.namprd04.prod.outlook.com (20.176.248.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Thu, 12 Dec 2019 05:44:44 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::c3e:e0b4:872:e851%7]) with mapi id 15.20.2516.019; Thu, 12 Dec 2019
 05:44:44 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 0/2] nvmet: add polling support
Thread-Topic: [RFC PATCH 0/2] nvmet: add polling support
Thread-Index: AQHVryK85gJ3GKafwE2Wl4D0J6eouQ==
Date: Thu, 12 Dec 2019 05:44:43 +0000
Message-ID: <BYAPR04MB57495A09DE5E7652E2B38AAF86550@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191210062557.5171-1-chaitanya.kulkarni@wdc.com>
 <fe370161-13d7-a005-2666-968107be13bd@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1b36eb0-b1f8-4724-48c0-08d77ec66451
x-ms-traffictypediagnostic: BYAPR04MB4389:
x-microsoft-antispam-prvs: <BYAPR04MB4389A56113A62165661492ED86550@BYAPR04MB4389.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(2906002)(76116006)(186003)(33656002)(66946007)(7696005)(53546011)(478600001)(4744005)(110136005)(6506007)(52536014)(86362001)(66556008)(9686003)(55016002)(81156014)(8676002)(81166006)(4326008)(71200400001)(66446008)(66476007)(64756008)(316002)(26005)(5660300002)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4389;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bot7vzBAWAloUJvBFbAt007037v1GQAEUL/fWj61BCdkzzkVYPv5Wwe1fjlKUYaxSoM7vZyzgm6yAXDsyDVae7CYU1ceDnXNt8e3MgxFEoYXb2VC9Pj3nyEyLagHfzdWu/dMA53XaTyRf+2cAvYIY3AkAIHKoZ+yKzLo98ogutB05Cqwc8I8fdnQjgmz7tr+Qek45ozrlLK4iGb8PstPH3B6GoCr/kes7+h18nhdYd1yjtVsd5tlrwNi/ruGBUwqmKGTFNa1OwHqYqL+eIiPmsrUsi+pufLPU3cgCBbaE6uYgJnTXNcVvAvOVzEpFkpT+KWTvr7Ivy3blj5LTmm4nMMTE2jaJ17q7jLtu3kh0tedU3NpgVo5fC40197gocyFN80lJePKijO3Wde7iat4voTeRjUIAAqO2iOnA5HOYr5MGPzFqWaLWe/N8uCTjqtH
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b36eb0-b1f8-4724-48c0-08d77ec66451
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 05:44:44.2260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FKAWxZ/ilA9pH6l57rUe4R4sDva738JZTPhsHT0e/MP20MEBwY5AsJcNEKofWhNNMR8xDIX1u4bzz8i7f2f4pbitL+HhrhxCalT+LXts5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4389
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_214451_733675_5AC16F0C 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/11/2019 05:01 PM, Sagi Grimberg wrote:
> percpu threads per namespace? Sounds like the wrong approach. These
> threads will compete for cpu time with the main nvmet contexts.
>
That make sense, how about a global threadpool for target which can be 
shared between all the subsystem and their name-spaces just like we
have buffered_io_wq?
> Have you considered having the main nvmet contexts incorporate polling
> activity between I/Os? Don't have a great dea on how to do it from first
> thought...
>

I am not able to understand nvmet context, can you please elaborate ?
Are you referring to the pattern we one have in the
nvme_execute_rq_polled() ?


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
