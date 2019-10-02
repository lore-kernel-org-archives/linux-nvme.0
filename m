Return-Path: <SRS0=mn4A=X3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8AC35280
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2019 06:10:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840C3215EA
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2019 06:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EGAkexIp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c/X2umJC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OfdulA3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840C3215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=SDXtHLsXpMRotpXsP9tLpGivnuKwUD8snm2JdmG+niA=; b=EGAkexIpn8yAu1
	3k/3Ohmgg/uCrKRGL7XDyGHPw2R2yudz1xfgZpdO/DOAvrGlvLpvuJMI587GNxxBh8XUl4EITueSI
	/KiaizinbcAhVXT1cE4WRldwq7jncKV2NswtIT+aTYpuZjT4YXPWulJXsFuhK87L8HqxiYzRTXitD
	Rxfr+zzBA+kCLYaK4lMEtrmxOuD4A6FJgHWk3MbFH0V0qzXD2hNjoV/cO6ZNDkmVsXk4CpYoWGO0i
	xIxcOUuKRkwFJqPqE7IxfrH1i3nBDgQPy9wKiMnhMfLUdmTOe4GUIhjJfCkd7pSU6A0c9KfOBN4+a
	WFfr3hcSFGZJRFa+WWpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iFXqB-00083S-Nm; Wed, 02 Oct 2019 06:10:23 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFXq8-00083B-S9
 for linux-nvme@lists.infradead.org; Wed, 02 Oct 2019 06:10:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569996628; x=1601532628;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=wJee+Ue7K6j0n3g21KWpkKY/5Ad262uYL9yLIiAmeIE=;
 b=c/X2umJC/0y9lpx+XT9hIYfC0CWdzsvSm7t/ILFEmUSEci0VDDM1QBYx
 INaL9F7pbyrXUcHsfwu9YBeo3tGaR3BYwRAkM4hQFVXRYwsPfnOYNWp+T
 81pG7CvMDv0FhIA/wsqqvRn4Izhy9k+0f6/p68qtULoVAO4cp2APEKYDt
 BHDEHdwce9ycJ/m1+SBktnQIwjvSoPymCxnRfoSH6RYwumUNvr48X2JgY
 nfKcuJ+mYtm1ipo6QnPrE7VyXTouQCYdcTqvIqUEYyZZ9WY5eW6roGlcs
 MR3ufJGZ9xNwmDY4raVG0jBVY+ORdgt42XZz3NLdTQimRvIHQWXDKPgGu A==;
IronPort-SDR: ycIMVe7h3MKTZzhBnMR9t8vntX3AQD2vNJgTKKZUUnLfaaYwdrZ1w6dRVUGBK+zriVWmmOsjwD
 m4I7cJ5oEE4IIreENlQexE3QlhWpJGPRFSvbdBSSyInXw/YfrXEeXHlToRAaB+1jEW0CSjn07x
 GHhiX4ILLHZWHZomiRyUUJbStPRqY3N+IIX015ZFI2dOfGaS+IqBzXt34Dl7UG2OBIzXA/hc8l
 rX+Ef2WWOD/DgRcjGid4UXuBGj9rRcWUG2Gzu0vswlnIyjQIKqw7+lgiF4Hvyvf/2QGcWWr5e9
 CvQ=
X-IronPort-AV: E=Sophos;i="5.64,573,1559491200"; d="scan'208";a="220514255"
Received: from mail-by2nam03lp2052.outbound.protection.outlook.com (HELO
 NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.52])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2019 14:10:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUlmTqyKxh8iOT603yToFvBAIHf9jnGwnWdX5sk/V12snaUhwQh7bvQhQziQ17QWJWwa4Etz2fDcwf932Q9wRqYmlU5OM883uxpOHYO9u7OT4pi5B481EC82W6/eh63HmmRdYPuDSKabtLJrjdEzcaFejjauF/D9cMWDSHnqF15rmyiyFxnaov3NRS6EUwoohxokAEzZ+/hAlCOqpqj9dRHev4pXlodRS+gsdJHR5W5z1z1D9IK4hM0T+I7ELrYINeDXN5BMKgciHHjoV/NKrKb1QypDOtPKvzEY8a/KD1/+R6tNxRw5LP4yWO8jURR4t1h7Oz7GT39MMzn+GOoPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJee+Ue7K6j0n3g21KWpkKY/5Ad262uYL9yLIiAmeIE=;
 b=AVDb/E1I7zv8AetrB2Az4KVrUjqKSqT/ZC3WVVLhTPtERabro556LnCeiStYtSpoykRoa9yBrZ5SmzdqQcNnM3cluNP0n8nVllniSlQURg2QTXMEgNwO+JsiCyqGfkGRu4SYPNyjlt/r6bG6EEPM0Aw88pujeC4y71MMcVNslxMlOvtRdh1jl4NoVlOQGOxD3daNBhHPOSaaNO6hHjx0kakcC8zwNhK7MeDljdnMjrPDnIpGsNQbAscM41+7KR+rAGsbYntkiFyTk8UjcJDvKNp46acP/pnczTxk9X4JOKxUyhTA2e0dR10IAhh6ZaCLNRWtlglfHQFVq4Qbj8I3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJee+Ue7K6j0n3g21KWpkKY/5Ad262uYL9yLIiAmeIE=;
 b=OfdulA3sDAQRAZ0+b/ltp6ICXbGSE/xWBJBIgaUleMIWz4PXZhEOPuxX5RnxLbIMbBJL1+QBdHselbPv6x3VwKkilu3GT9XYRjhrjEg7m+3UuLBmJLYVmsFg//OSUPhORBXoEN8d4t1SYt2hCS9aatTOEVNbS/JTO5VQk2fcgJ8=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6069.namprd04.prod.outlook.com (20.178.234.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 06:10:10 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::45c6:1:4f9f:eab8]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::45c6:1:4f9f:eab8%4]) with mapi id 15.20.2305.023; Wed, 2 Oct 2019
 06:10:09 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH] nvme: define struct for __nvme_submit_sync_cmd()
Thread-Topic: [PATCH] nvme: define struct for __nvme_submit_sync_cmd()
Thread-Index: AQHVeK3i3e5fq2y9tkqFZTXIXU35FQ==
Date: Wed, 2 Oct 2019 06:10:09 +0000
Message-ID: <BYAPR04MB5749A393F5328589B36CDE36869C0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191001231346.18518-1-chaitanya.kulkarni@wdc.com>
 <58CA8A6F-46B6-4728-9EF4-ED3EAEEEEE2E@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 955320f6-e023-4c55-5d83-08d746ff2e01
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB6069:
x-microsoft-antispam-prvs: <BYAPR04MB6069C82C0C2FBA8E47BFFB6E869C0@BYAPR04MB6069.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(51914003)(55016002)(486006)(66066001)(6506007)(6916009)(52536014)(5660300002)(2906002)(558084003)(86362001)(9686003)(3846002)(6116002)(229853002)(6436002)(446003)(4326008)(14454004)(8936002)(316002)(6246003)(8676002)(81166006)(81156014)(305945005)(33656002)(76116006)(256004)(476003)(7736002)(74316002)(66446008)(64756008)(66556008)(66476007)(66946007)(7696005)(478600001)(53546011)(102836004)(76176011)(25786009)(71190400001)(71200400001)(186003)(26005)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB6069;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnWL8W0+kWjjSAd9D5SOLV6Gwf0VG3N7r0FMOTIOmjAkNL2/varEZ7skYx18v1DZu04PuVl5FIz1d++sgSkbWYNyO1UmHIf+S7fEMJGbtgVVY1jipbZMNUo5BwzT73wd9+EsCsHcRxiwMF9UzSOkVNLRzQltGuIogSNg5uxGzS4YSI9RykiGrH/xFAadkOwlbchNFz/jRMSPTNqq+UZ0rPMn0Szhq++G5itZ0vPrLHu74Qd9e0UsiDfJzkBU2sfiIcatdqK0FTwp2xfWWJwRBKx/ZyoPFGxwK9K62qnj4zYkjiHl8XT8ES+Iy2e6RjKCehvj2+GhXbDFQFejG0HOzSXJULONC/RyvWC3UvbmIGKSam6Q/X50h6+hKmb0tBl/piw9PmDTmJqobHeuyNN9Va+ASab6BxXBPL/VY7VjSSc=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955320f6-e023-4c55-5d83-08d746ff2e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 06:10:09.6671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+bHEL9NGL5XyToU+tTx2STnwGYM4sXlFNbdgZcohf7mDjbTpvDJWDcNo+NVHQ1KowHC4OOJs8I+jkQfLUJyL20UglUCpeoTfjhaDKBKYq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191001_231021_025994_791522C7 
X-CRM114-Status: UNSURE (   8.67  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/1/19 10:47 PM, Javier Gonz=E1lez wrote:
> Makes sense to me. We have other places with similar arguments (e.g.,
> nvme_submit_user_cmd). Would it make sense to unify this too if we move
> in this direction?
> =

Thanks for the feedback, I'll add that too in the next version.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
