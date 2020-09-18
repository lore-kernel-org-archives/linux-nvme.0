Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16996C43465
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 00:49:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A365320853
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 00:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VVY8Wt8o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UN/7WDhe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Otj+otm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A365320853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Gto0VV4r5/cxzYipjo+pZJDiEiOlfTNF+kEmHu4hmsY=; b=VVY8Wt8o+Pj1J/TTWMnYwxWWJ
	YrubktEJLIx4Nuh70vyT1lak+SFynDezfiWuVn57jcTYJtejecE+HCyvcz2zw8kMpb0/ADAZmUXVB
	jlXsA+GrsQZP6Rfsr1jdEXRfCn+nQLBMU2jwNqFMaZf7/YSaAOuej3oMAwyjqD1GteiuqRHw2FBXh
	jlX8tMmm9R4h0UptgBVzhz7WfG3cpgWFDH2W5lvvdVsdWNeV85s0vUsdNmyqA4BdL5WiZOzKLBvJO
	8EuZNtFKxCGdqjL5wImE6889DznHDrRf5zI4aPkM2dghXLqO8Bop/6zLkmC5qdGht7roVK1FA12hX
	v4VN/nkaQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ4af-00067m-EE; Fri, 18 Sep 2020 00:49:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ4ac-00067J-I4
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 00:49:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600390166; x=1631926166;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Mp9dTDqKFM6XEjLjRA/16WMqL9oWh2BLRR6lriUCKBE=;
 b=UN/7WDheExRp/5dq4qAnZULWCvbsQZmWXRiEgQoNf0gm7OExrikwHemp
 scZN7gKSbDXoftS3VSo+7qJSudJXsrrS2z5fuH6/CAx+scxA2FLJT9IAB
 7vEBJm6pxkoxJHv5l7lTQoXTqJHZ1IOWCJyb2kT98wX/ufhYeInvAt5O0
 vxougToVTnut0A8wImHkkoQyBUIKidWccmhtrySESTPKN2mTuswpRNG4p
 jERbw6WDl6Xp4k5xxL+Q3l29lhvNLH54JP8Oi1C1PirigN0nkUyoITD5Q
 9wbH1NmV38kRtxTodxeEytydgQute6rLsLHtg76oSXcf6t410WZzC6iHD Q==;
IronPort-SDR: vKiCDCfUXuzHVcpF/ngag3cLKM7RS9YW/E76HE0n5M/jQ0vyTQO4/u+DDgW/09HpqwHlapBH77
 11JosnVN8Pqf7vBa+HL7XLiDKWmN3cW3CY14MGhsmaH471fCCjjTYOlcRD7EO5MOjHdNqM0M1u
 /vba8wgzYnvTXQUzQZzB9ylo6SZSmHiiXGhzY6KMUkpndkRiALi3Vv2/45wukQp/dCAJh+GIxn
 Tq4yegnyfyjr/Nc0hyTP1zT98gpxzS1PwRBgYHAs0J5BFauSKc6gADkAjRoHxgTL9zDBjj6MYm
 MNQ=
X-IronPort-AV: E=Sophos;i="5.77,272,1596470400"; d="scan'208";a="257345782"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2020 08:49:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA6waQ7xgaMQit/l2EDxUeNWURS4fymrwj+xF8lGFEx1mfEHMGcPItY33VSnxlFT/T7GyG4mB+Iv1qUbc/DcghvQOgU4WBW30mQDUXdhSNebnZUbcfjicYV6W7NlIzGkrbiOE/739+zzbvgNzmkOdUcX6DjrMo9hGA9woiqIOSFfPrF6E6ik4bjFxhqwdQfBPOzzZh9EDfgdRP+cSMHA/4MTMVij/v2e63TgV+Ojd1MDRoHlPT89NWMhbtWyTt08eXzvoBroEQvHuzVtOGKe0Pi2flRkgMiveoDZ8QrdHPqPS3SYWlDUc+OTbdcLrq3pXG6prwvza1RPB5u0eFDBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JqR7pXh+Xz6PKBzCPTporzsN35nwkn5FNiRuZJmZlA=;
 b=caMnVtmHSxdrwzUwsBNTISvUjeSy8/fZaj9s/1eJOwoOEwE2byvjXZ84kiGdygxLQvVIILjcxBB1lkVjgVPU7bK2SpliFCQwuKk3uPKTKC8euHVB83NaxPfyPaC5+DNubPWEig7g/FjoRDpA/3mcSUt20P+B8n9SjomXX3o6bwMODJ7ycn4lhIncnebxEWf2hzlEcearoSLTMwNqoCMVYj58Ck2d1TNGiWmkRNdm2WmsvCacpzyVB1lBgKkUsQdxAy1D6UeDN/EDHV9Yjsve0Bj/DvQJLIov4GwUzNCHvaRXkX6ae0CPqgUHOF+mG+dOQqn6Jp5m4mi0R8418UgIVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JqR7pXh+Xz6PKBzCPTporzsN35nwkn5FNiRuZJmZlA=;
 b=Otj+otm8AhRGFHhTowg9UXAxqLIMPAdwySvn9r16g+wEw6N3ILJJOZ/EBsQ8c/O7fVxGNDpbcIK2EJHU4tADoRlD1emLS8S4WgF7Mtgh7JoxL29xrJeQ80MnHhIjkW+3QU7NjDdzNuX82bUWCmZyq9Xkx04ea8ACDrrJB26bORc=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0424.namprd04.prod.outlook.com (2603:10b6:903:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 00:49:22 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3391.015; Fri, 18 Sep 2020
 00:49:22 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCHv3 0/4] zoned block device specific errors
Thread-Topic: [PATCHv3 0/4] zoned block device specific errors
Thread-Index: AQHWjUjqfcSUOcFBsE6UeZD54mM7SQ==
Date: Fri, 18 Sep 2020 00:49:22 +0000
Message-ID: <CY4PR04MB37517EE05467F208E3A395D0E73F0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200917231841.4029747-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c162:b6b0:12c6:8cc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 451f07ad-f805-4b6c-50e0-08d85b6caf43
x-ms-traffictypediagnostic: CY4PR04MB0424:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0424960B52624E18A68EC5F1E73F0@CY4PR04MB0424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F15kx66VT3RJEGMwXfdCP3htFikpJqFXKSZc3dHFzmE26vR0jpXNAnZEpWmqTfwgRS95sLLJzlChVjJtE5REIuDvmjC0whgZlLWQDPAqTr4vqTBi2j81sn8vEwBKZ3kK+xeX7knMe0oWELvBvSkRVGBZiS17GVFg+745rd0E78B57QVDclAPcmXdfLhMVJrFXyHQ/0ZOea9YYeIdxoMfVCn9x8t2jrIIP1nH1AJYbwIVawHSslKDKnB1IL/olk9b9c5CFt5hICZ9HsY2GkjPEHIFCeFDhukd2Y5dcA/5TpL15SH/Se8IwHS5nzU648AO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(71200400001)(66476007)(5660300002)(64756008)(91956017)(6506007)(53546011)(66446008)(76116006)(66946007)(66556008)(316002)(52536014)(9686003)(186003)(2906002)(8676002)(55016002)(8936002)(33656002)(478600001)(83380400001)(54906003)(4326008)(7696005)(86362001)(6636002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: NIrXdcsWUWlOc7APspJ9nd07bX3Jg7jhoWOhigg8i0DHLtLBg6wePWpkdRwuzXIlBUzdJwQXNOcs1QXYOn0RuYUdzKbu2Vm+bR/3hpV9lSKcPFt564OgwXNXRgWOFJ3NU4nifQ98qL/EsuPv0scE8uRcODASowTmEAvu2iyn17TXdvNyb4o4UGpmq/3kxgOOZrc9/6ryW9gHElnI5I8d7bKp1MEvAke+ewdgFsjH/hoUZ9iYOs1/JKw8FsROSn+UbvHa5/b7eXcO3Sks2anugwb0V2SBSAN35KmKcVndpc97yGU12gqu0QrgL3hTw6fB37v4WsXuutriLsqlByszL86+gaomEj0NsEFrJmWXR5ckEIeD4K9sFjqd16wlHUYkO/fDmzz/sSE31TPMkaTtIuuGEfqhflBgNgvHArULW6wKYWCixz3uV8mD6E1MlNiETAiwuFuUk+zB9FbrOcP/j7havSjFNMKYyMpzD7oi3mqBYjcOYyGOgwfwpLLpsIc3wLDv9OsP5gjvC5anf85ZnPx3j8X0wgKcBGDiLYCtTkCK0Fh2no+mIh5SPqooxr8uQhyrYAnqFLoFDlMFn67PIYOkxa5AlxruYDzR3Nb+8/ZYJyad08dFQuj3l+k+M0Nngec8KI6ijWKEiZqtI5omsT0zulzIgMtiWyuQ3uCqk4FY5ezPvhwbQ97u2dpHcmifyGk1i10UgFQwjxGp1l7PPw==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451f07ad-f805-4b6c-50e0-08d85b6caf43
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 00:49:22.6695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZWJNYzOTZChPL7vOsw4dsL06PDhJ4bAIkyVQhYG7QE2RjQfLltal2t+++8q8pFt5VLelQ1wdgPXZVWPVdUHUCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_204926_835264_B0D5417F 
X-CRM114-Status: GOOD (  14.59  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/18 8:18, Keith Busch wrote:
> Zone block devices may have some limits that require special handling.
> This series provides a way for drivers to notify of these conditions.
> 
> v2->v3:
> 
>   Split status for max open vs max active errors (Christoph)
> 
>   Include scsi use for the new status (Damien)
> 
>   Update documentation for the new status inline with the request_queue
>   properties they relate to
> 
> Damien Le Moal (2):
>   scsi: update additional sense codes list
>   scsi: handle zone resources errors
> 
> Keith Busch (2):
>   block: add zone specific block statuses
>   nvme: translate zone resource errors
> 
>  Documentation/block/queue-sysfs.rst |  8 +++++
>  block/blk-core.c                    |  4 +++
>  drivers/nvme/host/core.c            |  4 +++
>  drivers/scsi/scsi_lib.c             |  9 +++++
>  drivers/scsi/sense_codes.h          | 54 ++++++++++++++++++++++++++++-
>  include/linux/blk_types.h           | 18 ++++++++++
>  6 files changed, 96 insertions(+), 1 deletion(-)
> 

+Niklas

We will also need to send an update for nullblk on top of Miklas patch that adds
MAR/MOR emulation, to have everything in sync. But Jens has not pulled that one
in yet I think.

Jens,

We could add Niklas patch, modified, to this series too. Or do you prefer an
incremental update for it ?

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
