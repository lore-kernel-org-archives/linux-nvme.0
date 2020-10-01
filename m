Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE56C4363D
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 01:41:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6792E2193E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 01:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y+DUhfji";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cI9TO3ap";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yTPa63Oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6792E2193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ZhswFBtgCOnY43+T9o00uKfVoJfWsCBH6dcATvW9JtM=; b=y+DUhfji/I2iiAGLeHg7AUJzw
	JSQ3kLAMMZz6o4xb+JRUHG/RvWFqpL+ZKY3b99OOu5zARrTfANsme1C6CEJolyGTzHz//NrZvfboV
	XgH/8l0Pz5+Cnbbxms+8PRmV1gTesQzQKC4ovQWWwdBzvEoewvgmlmLDhiVHH6ncntsmv8WmN6vj8
	MYZdVRpndb3A5up1sRIVSkFmhuCMAxoSlX/X6EYSmNvxn5iMMra6Ylkh5JieC05sjdMWMu/jbl029
	dCeAlj/X6qAVAJay4pJhnW++Yv4CzrENzuI4tvY2OZX0ZoHCGrOhgRiaAywWE/iCQcBswyYcOLCt+
	EaBnDj6ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNnb8-0003j9-Jb; Thu, 01 Oct 2020 01:41:30 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNnb3-0003io-6U
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 01:41:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601516485; x=1633052485;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=nyXCRTbYX90CbBJAPsz5uHlpBmzDN1wEZu25mUhCszg=;
 b=cI9TO3apdKjFt0kjGcjzOQjkYMrDDbdaRTcvO3m7rHtD77ovCebRVPep
 ny0dgv3tWCHV+NS57jj/6VJpohyfYZc2mEbgmU3JkZZDhUGAG1pPcw5Qa
 CRyhV/QZ2dzK6zFK3R7J6shxf/eyx5x+esOLg1w5S4OvQ8QvqNZ01zb8d
 DH8cfBXlvVfpWut3d0sCkCpTglTgzs+kOqIc9BPa5YxpfRIDmlMN6mqoO
 BbMP7IrZyG6jiXijZmszNkN+1a7A3F0B7Zf7T1sZxsyuVbCGUrOwd7bJ4
 mPBAn7WzkAOWH+g4kgmGRlCEXjfzWx7ZbySNHOkNZcjFdvZa2yO2HtuzQ g==;
IronPort-SDR: Ho7yrZgJycU9Igbo+9T/D+MFwkaPBrsMVFBPiQkEv0zwLpiWEyUOaqajuKqJVKbpYjiRaRCREs
 9iFEZqXCKfctl3RgQB0GV+RLTr5kTMU5BmT529k/Sg/56RO985x0YcBFOdn1/7u5DAQPa3hw3O
 a/Uo5DvaMHXEYsXqa5gM3X/8FSFo3JalOlzuVuz761FVAUIbEcex8ckwkUvKIr/Q8QLdRL5M9t
 R97wfOphmvq+iW5pgSEK/lU73qWAJxI6MOFc41PXOfQa64sSZyBGUWyQue6233TNGjyNu4SKr+
 EuM=
X-IronPort-AV: E=Sophos;i="5.77,322,1596470400"; d="scan'208";a="148627539"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
 by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 09:41:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNR24bG+gOti1X8zZ8wD55eoQcZblHT4fDqT0Va0OmRU2uV6OpXTIc7GMb3EJV80257bVhGTAxPVm55HeQvMbnoqVJbSwvbRwwz1X0Wi+yRXGt59Py9q2DlGDxHMk3fTqCpeAUPhs2PsJ3CwE3m9YL03N8wQphznxK98kaQ53G9BPWcpE0JAI4k0qdviGGQ5KRa8JGPco211AEkwrHEGHsn3Bf0LfBDATVlATS6XnrtjJVIdJ+FIiSUwXNKtAxMB/ZKXEg4Ge5gSRi8xLRqCtAfMMo69FLDo2XqmhX+IXu957IKlSsn2J4W2+NfW9dtFU+GZ1by6c8DQ9Lnh5YVH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyXCRTbYX90CbBJAPsz5uHlpBmzDN1wEZu25mUhCszg=;
 b=RKJe/VM3dZCEyf6h+1RF6bmSqnA844krXFuM41+91U1IGdkCsiVs3OH5kerc/B0tDbmmMvSsjUxNCSc156RzpJZfWpr7c6mK9Vx+TyW38NWBRUNZglaHB3p5gLS6lSYXLvx7I7BO3EaaauufY4wIabLHNLNffX5w6BOC7J39T9rl+uFdCvCFBeOqtiNT/e3vJQxZZYTNWzA2iH6eEOjQ8zoNCnbwBzyyd7NAnDBiOKohvJwOvSHfXoIEnBH+u7uLUD2uAB6cyONEHDUhIoJp6RWwK70WjrHyDOs84OgSIKISqeGJRM1ustZU+hRkLb9M38PAo64a2QYC360OWViXzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyXCRTbYX90CbBJAPsz5uHlpBmzDN1wEZu25mUhCszg=;
 b=yTPa63OatP6KgPHM7hgJ8OuQQ3QakH7DiZu2Ca7K6sftcllb2y29BFgUXzHLOJFfXZX4G2UONgbdJHoUTQ4ZftLW9He6cGQjfbrUSkHjedxvbNjwUQQ8szZQN44GgJhXR7XwQreJLTpnXUbVkngpkDNVG4eAC0H4ltXZOcYH2DM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6104.namprd04.prod.outlook.com (2603:10b6:a03:eb::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Thu, 1 Oct
 2020 01:41:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::e1cb:3a58:d588:d7eb%7]) with mapi id 15.20.3412.028; Thu, 1 Oct 2020
 01:41:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Mark Ruijter <mruijter@primelogic.nl>
Subject: Re: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
Thread-Topic: Exporting NVMe-oF devices read-only enforced on export from the
 NVMe-oF target.
Thread-Index: AQHWllSMA3Lc493H20yf5BlML9rh4Q==
Date: Thu, 1 Oct 2020 01:41:20 +0000
Message-ID: <BYAPR04MB496566CA79419A1F18B4B6BB86300@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BBC87AAC-A523-41F0-8CDE-38757C407C7F@primelogic.nl>
 <BYAPR04MB4965DEBF8F5F06FC026B502786330@BYAPR04MB4965.namprd04.prod.outlook.com>
 <04159F18-52B6-47B2-BF69-E1FD6B67E8A0@primelogic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: primelogic.nl; dkim=none (message not signed)
 header.d=none;primelogic.nl; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8dd6173d-ca50-4775-66ba-08d865ab192e
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-microsoft-antispam-prvs: <BYAPR04MB6104D5857DA3ACDBDBB9D2A686300@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUz8uzVtNgFJMcWlnIp3k0V+k+TXPi0KrfqMFTqik0A43gFiOVHTtqM8WmOYFkAV6GBibowG1Z3fKneBSTgWh282sRvU4xCCSi6Ey5BcYUS7N1OCLmvA2N2fmoRkz4Tnm+gkhyKocexOnh6abLrC2J3vL/keZo5OhCJkkFFKJOaRNPZoanyZ5QMwTxyhUST88B2BwS9BpkGnycsEzD2nptq+I1T4Z+6m6RjBMnKxZYKA6vivxMZSl/++hPWv6TMZyWIoZK583ehsT2dXlixE6kgRAdd2tjUcwy8/ILyiqbH0t/1wVoBY8/axYWKS5A0WzixiP8lUmih1052DqhkSog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(2906002)(8676002)(4326008)(52536014)(4744005)(6916009)(86362001)(71200400001)(478600001)(66946007)(66476007)(66446008)(76116006)(66556008)(7696005)(53546011)(6506007)(64756008)(5660300002)(26005)(186003)(316002)(55016002)(8936002)(33656002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4wJOxA/8o2OfIORRhHc2BhK06cC6IGzy1L5EhD+uH53hNPS7WcNwDq7QPTV8hGRNMkg1aUTlZDBHfqKV5pTxUO+hUcFaxv5BGy+XWWjltGQ7vnB461xtLsOjrbRvKi1Vl/s0d6ay69AqNp1GyPeJf/xt6oCloaRPsW2p9dcdu5XdBfJxosIpB68P8aLK5P9PgmBQkOT796gOloV1+W2tzhYeyHGp2ya9OZPitMmOLhqYNDVs6t3RLPUSak2ChHDk1E5esjpR8XYFAb1DZQO4tX5HelzxW+eqSPfyKd4yzs2knRTiYh3jkxUpxbaNmz+CelInP45f7E9hM8uGuMPZsVY7Yxm2x24tdAMnfM1v0rIEp5+Ius3P1QURAXJskGHzBReYV+aDGRvBUFX+saGIbPkyvNcjnKl3ogoSscnNwPehRGaJ0MlmhYsCr3sTE0bBRW4eIIjBbt1Wjqih1Byhl95Ib27kCVAzT8MeoaHmiPY1dmwyf/rbmAfIFDo4lad5f9IxO8lPsvhoAn30aP2S2BNt4mymFVfqkrw9M773jhn+X//kwQwYUoYUt2mEh+kxe4MbXat5IfQfoKbpoZ/YRnAIE6kz6TdRxvS9jOy4KgtH4zKElScPuDi0p/XJBeSeKFTgMw85AiGlTR2zuVdkDg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd6173d-ca50-4775-66ba-08d865ab192e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 01:41:20.7070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNYLgqt/iJ+twHkDECwg8nazk7TvaYA+3efvIkn/mH+wlO1S41W5vOrB4tySi2f3TTHx+GfT4XYIlQlvdT5mtcfjZUNW6nI+28VFjiJg+OM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_214125_525279_2A83FA67 
X-CRM114-Status: GOOD (  15.77  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/30/20 00:38, Mark Ruijter wrote:
> Hi Chaitanya,
>
> Let me explain my use case. Since I think we having different things in mind.
> You are suggesting to use nvme cli to set an nvme drive namespace to readonly and export it readonly using the NVMe target driver?
> This will certainly work, I agree.
>
> In my case let's assume I have a raid device /dev/mdX that I want to export readonly to an initiator. I am unable to run any command on the initiator.
> The target should export the device in such a way that the initiator can never accidentally write to it.

I see, your patch looks good, but it doesn't cover all the cases if we
want to export ro device.

Let me send a series on the top of your patch to make discussion easy.

> I fail to understand how nvme cli NVME_NS_WRITE_PROTECT can help me in this use case?
>
> Thanks,
>
> --Mark



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
