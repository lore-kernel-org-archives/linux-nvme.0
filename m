Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0467C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 23:59:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7441E64E79
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 23:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441E64E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=G/zndy5VooQqf3u4zn8D/66/9ALvu7tdjOm4uen3Bbw=; b=DQrSftQCeclmEWMPY30A1zoQ5
	v6WrWz+8HQqdbovYW9eZHbbUVO8IgtLkdtFMkdk1I0zwn6ccvRvZ2kawKmYvOkKcDgqO78dPMfLRY
	wJFJHog/IwloetBdaeH3tBvRN5w+D7C9OUaIocLxsVKwb5yk+kjN/triZ9WQiE4kqfnjEJTvSRNBi
	GQ3bsEBq/TIEOvdc7hkJybmrsLhAn6eUqDUIioGRl9JbxsMgt6UBFZWoktkC909Xn5/LFCFsFRzb6
	TEq4FUiN0fK42u7hbCBdrFaF7f4SNrdSpa0Z6k9ipqrtW6J8/VtdZ++eJEs12QIcQhysdevArcIDX
	NHkV7bqlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAFa-0006vD-Dj; Tue, 16 Feb 2021 23:59:26 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAFW-0006un-H7
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 23:59:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613519962; x=1645055962;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=0BuZ+N/xvgnYktx+Bq+yhle+4vDn3p2ggqVEgE6gRZ8=;
 b=cwnb4v+PEY/ozijs53nUOKlWNOXnDuKk8iZuYJbVOThh+yGnE5xOpdTY
 xAm32z6E1DLCtOokXNc8DJd9Z/5eZgPAXrdcCFiL/u/1WnWsHfPwY3Y9b
 Aqzzsy5rs3D4R9ogAIX/fsPxcDTG05+3ZuLjuWHuQrS8DvGAr4pwju3XB
 Qe1SysQDdwXGkAPAuRt/F5PitKZiA6IfKRx3ldL06vfSJbJlChkgO1xfL
 BVvwW2KqOKzoAadGw5nbzKBLxiZrw+EJI0v5pi4sa0TWO59bpPEHzHNM0
 6enX2rQXrVcoaKM9I3St9vKpeUlan/9J6g3I7Cmw+dyqfOEfqEOAH/89r A==;
IronPort-SDR: XnUNbRHxGexOPI+GS2TH2dO6FGMA/R98MyNTJXiZItxr5whk7uTrxqxPT80S7Ju4nSLt8TU5ak
 lV/fneXruGuH+o1sAudjmJRoIrVflpf8Q6FWGf4Ej2Tf7ubWmeK3GPpt1DknSGQ+O5Lew6WOfr
 t4PlyJzke48VrwxIcyLn3e6+Wc6jO9AfcWfFEXRch6qjKeH5HFICmx5W3DVb9yyhxa2yWOIya+
 Fr4Mi63racLOfpwlyVre2XR58EKbOxgOzzafVPYAgcXnuGSIbT8vdQoAE2b5QhWwHAoZLrjyrv
 DiA=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="270628369"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 07:59:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUoc/A9TV5glxdONeOqCL6KxLTQwHFjkDcEF7elJMZoH4MdwG2+e3ncEdJUDxKfEBxidhDaIHXkjpynWURzl2+b+WAhu6Pr4WUURDJbpYgcYJjJQ9clxOCFaYeAr/q0H1vJTZD4Sjzqa2+x5Cyqa1yP8JTzYudl1NB5ExJYJcnkx+8WMugWKDt6bwToRy+oiIwKnITsSIV7jqVndV+T+w1vTjL2ozWxrE5ROSOMLbK4YTL+yua1PTw2Ov8RETY8/SfMMD/T5vK+RNO74gcauv0cYexEuP4vKZ11D7EDPRhqcwGF4pUVfUOcdJZhWls87l3mieKYRHhsO0naf8/UApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BuZ+N/xvgnYktx+Bq+yhle+4vDn3p2ggqVEgE6gRZ8=;
 b=djoNhM164EcusJSLygJn5RPRPlOR6Vpz0H/EzoHgyv0tIAAWZyYf9zdUhblbCOfG1SSkB61t7xde0C5NAz5Sy417n+57ODS4ubQYwVzHtbQrdALIT4mf6o/XFWjyacZQnA6yEb4mf/Y3BGEUY7Mo9isf5ZksPdyeKKNB6Z36E8hbI6PlzMU5OC0O47AQ+amCGyB8btTqE483r2jW2/0u70lOOKpaxmYk662fGAEYm+5d7jNe4jyY20oxjuT9WV7z+CWH+M7xMEYn4EXeLy49sZKwmaPJoDmi5QpEdASxb2ZkP3cxRqDrAidy/3a9eItWs5Dw14KUDq4KkFr5oNAUfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BuZ+N/xvgnYktx+Bq+yhle+4vDn3p2ggqVEgE6gRZ8=;
 b=JsNG42zrtG2Ktng6LsEBIxvDgA02ehrbT0Ye5WcgWjHe7jGEnoBpJNUZYgjvS7/tk/73hL+zxpayRYgz2fifaLRJ9/aKo7n8F+KMDeRAtNDeuO+a84Pvju0Slz9a9pVrS/a4Yg52Hvh7SJvo0RoX4798jWySg3epU7AN35UAOuc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6247.namprd04.prod.outlook.com (2603:10b6:a03:ea::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 23:59:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Tue, 16 Feb 2021
 23:59:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: use lighter smp barriers in nvme_irq
Thread-Topic: [PATCH] nvme: use lighter smp barriers in nvme_irq
Thread-Index: AQHXAu696T9/DajUoEiPLgnbqLXgjw==
Date: Tue, 16 Feb 2021 23:59:17 +0000
Message-ID: <BYAPR04MB4965D222B05866D93852835F86879@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1c90fd6a-d991-b347-479c-2c8ae5a4c51f@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6d202b61-1ebc-47a2-d570-08d8d2d6deb7
x-ms-traffictypediagnostic: BYAPR04MB6247:
x-microsoft-antispam-prvs: <BYAPR04MB6247991439A63D2C4A8052FB86879@BYAPR04MB6247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nr02LdXkLGTKuYfyE/DXKSSxPa0X4qUbI9fuBUSPVgpEKHc8Zl8ZCjEGecLJYCgnD9Xjhv32SIzZ2kAmp4NlsiNVB69Mfo44Cu5u9Tlj4O+/S/kTQdVu3UwN3sIMuz5azCzD59IzkO1z2q8H3EFuIB2Q4rYUUjmnnbQ7Fhriv7bxiWnFkfuxxjN3pGC5bDxtMxv/XPE2z7HusemhHclVo8EXn9CjFTMaUNjR8prPNVkOtJsyNFXrXavg7QJroCGHBqMoFodPel38WPnoK9hG3IKf/Eyp2yuSOecsem2TmIe5tAF2AGkCtt8Vm0GnUbWOaxGi/YrORzWIMFrqymFqAm79s9oOHL35yD8uMm0CDOHW9KLNWz4Fkhb6zKSeOZGWLdGtEjhbsbcGmCfZHTp5Xh+DUdCxZOBbTrJLDxsBNU/WvN7kYajTTbxJtbdhr+Jcc5OhiANwaAq+Edijvrh8E8VpYmJJwG9k/dI8YdbuXO2XcbPm/7iTiZ7csGuk9adHtdiMylvgMuQhbf/BVL9ULQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(8936002)(7696005)(33656002)(55016002)(5660300002)(6506007)(558084003)(110136005)(53546011)(316002)(9686003)(52536014)(64756008)(66446008)(66476007)(8676002)(4326008)(478600001)(66946007)(71200400001)(186003)(2906002)(26005)(76116006)(86362001)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eNFP3Gv7hMrkzyi86q4P3cQ30HnNyEqB4SREYFyiq5eM3mNIpAxiVFzcXMD+?=
 =?us-ascii?Q?CkW1W3d+ViQebG8jOKMGaz2J9GajRfgh7bLVQOKN9NxSm8DJUEg/sc0s+GUD?=
 =?us-ascii?Q?bXTGoEN3D7HAMCgnMQttzHXHivsoIUjhBGvnTfmuBLsaif2hyHxnLPlz51sT?=
 =?us-ascii?Q?HBYlAJFQCuC9C3WIYGT35dLue8zjkt2knmjFlAKse1K1WV/eyZS+HQub8HDt?=
 =?us-ascii?Q?0JyW05omMd03m8+kVPOxMWVYu9QPuY7TgroSMtyYJrKPsr+hkedR0G9xLyZl?=
 =?us-ascii?Q?BFGfdgRaofFhSNlmQlAEla02QZWTn/3KM5ZDPRAu6iDdV7QE9fMuZDLwuYyr?=
 =?us-ascii?Q?uColQiK5EcnsaK1IRqVvtkR+lAqb/TBioqEPrVTj9r+mQKa7TsO70ckAR861?=
 =?us-ascii?Q?Ve4BztAS05hQ7g37yH9NMVnKUEKXvjWasaZKNezWevR472/WPSCstczTLgET?=
 =?us-ascii?Q?bLRrWNCzDBXoMFRQsFhFIcmmX5jqjJwcGDda4jnojRU0W0y1GZLIvBfbHonI?=
 =?us-ascii?Q?JRTP74H9KYW3ZKClbHC2qQZiUkgAmW4SsHmrNxECh+DjKSA09Uc0OvPusoK6?=
 =?us-ascii?Q?eEUC+lfX5HVQK5dT8s1aisI9SGABhO6CXWWOHzPHVAfvgt+ho8X7cPAzyXDs?=
 =?us-ascii?Q?uAzZbfv2b9t+ZAUosxmjy2jsefJibqupBZDR5c8yeM/HQQdmo7cm+1kq6qql?=
 =?us-ascii?Q?4tBepQ6uYVImZwhYm3k1Pv3soBq1srW56pHMHga7dxGkTpZlSfeis9iAuSzn?=
 =?us-ascii?Q?rOXuo2STxtED+bInaFmZWoAbsfeU89NagB2JuQPpQMEyCaqaV7VciABKNOVr?=
 =?us-ascii?Q?loEg102Te3RHdF7uJb58W1g1khipn+9xV1gYt31EBcD+X/Uodwf631utW5TY?=
 =?us-ascii?Q?Y44/UrLW5C4WFZy5kE3/I4EFzbQOmcjUw26xqQf693ndFHni+YzLweukf2+A?=
 =?us-ascii?Q?a79OVCmOWq5tznvjQuHZtNRIEZOYZje0vm8stv70S4XckxPdgM81rnZvOUI5?=
 =?us-ascii?Q?ymVNeoGWnSEfk1uZROR8lStC4PG+LX0NE/sriQ8GiO89L56EOn5xVhYfJvgK?=
 =?us-ascii?Q?Ce1hQD/uU9uPQkuaxlVL+WFXcjnwsXJkk+adNMJCzxrMkb0ds6qS9Cflecug?=
 =?us-ascii?Q?U+NOCc8Ti9vPe8EodNIjTTn7QIVWkc4ScL3X+JN4V9z/8/vYJN/cy/C6PbUb?=
 =?us-ascii?Q?9WPrOyMQwjvYHu8/5YCDyX12jFadiZIgA2pOQAF157ReLJU1mW2EZaxLqs3v?=
 =?us-ascii?Q?GDujrH38QfowA8NpQ2XH6Db+zDFDVLh6OirgM0kiC3klTRKpBZfPAamM81hv?=
 =?us-ascii?Q?Q4K5kZOAcnckLy9rahYI1GUt?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d202b61-1ebc-47a2-d570-08d8d2d6deb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 23:59:17.3239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnB8IC7IvO2+iyaATZuhCTq3WnARb/lXt+d6YjgKkPBx3i2VvNFYCpGlUj50HM5NjP7pJ1pzDjRo/DGEHS2XgpxlDOcHnlPUW6R1fGb7Oqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_185922_713932_573DCD1D 
X-CRM114-Status: GOOD (  10.73  )
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

On 2/14/21 08:30, Heiner Kallweit wrote:
> Based on the description we should be fine using the less heavy-weight
> smp barriers here. On x86 this would be compiler barriers only.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Can you share performance numbers ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
