Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3B5C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 02:00:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D78F2082E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 02:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KTHCUoOq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NRAkBsMo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wWVtac1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D78F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=TrFw4DXt3lA2ruMukLlIsJJbOTcdQsQJYkifnxD4U3c=; b=KTHCUoOqvS5fz/
	c1REz7yU2gXqqY0J9HZzcPNdlOq0hzAlmdaQs0mTkTCb69+kXZKGLq5kmdz3l4hSgsqQ/gGWeKt2x
	jZCmY2zHUqsvRIAv5ccRlSx0jZP6G4QAZtSyT13V00QJmedS8iS6csqYIA49WDiJCyNMu8JMpeK57
	b/bXlN+aU4394oKI3rDmkxkKgg1f320CmTLfLsos7/UH6eqf2dBHda9teBYu+wgN3+VO61tqzUM+T
	ng2RE7OHLCsgDrK9PSWxYEk86J8bdC/UfThL6BI7COfgHY+Tx8olkhzIKEifLSYCphQUkq40r1AoN
	1pvwcQpoZ+Bu/tbNOsWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iz9z8-00023p-95; Wed, 05 Feb 2020 02:00:10 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz9z4-0000qE-V0
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 02:00:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580868011; x=1612404011;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=fCEus7ye/wdM9LUk2chS5wi9KwqlHv9m8N3oOsKcIOw=;
 b=NRAkBsMotvQnEdcqfRYQcLUNOSon80M2l1l2j8GX/Zb2Wv+B/3p+z6Iq
 kFVcXL4d26MOgG3gW2HHGBWFKAl9e34LLy0kgT0/mPZGzoMstDM58Ry+o
 /NvsSvJBBUj18EG84WxcbIzYv2ioME1i8PNWRwoz/jxlF/CTLzll4cFkX
 KBPb2gNhbdCxSziY4F2Dfc8TGIrLB3R6KtDlbv1lLcfCxkwEE8vDSv3Mj
 OzCpuK20P6hu3t8TIcJ2I7pA5S1aDvm1u2tvwaNh6SwP8KyEc2NlTS/Pg
 nOA4X04Q8oEgDTjGunkN8Q3SqFnPCdfuBUmVl5Sd71W1BcmKw8/oiDqBB w==;
IronPort-SDR: xr1rOUjjSwXKgywZzirF+rFqYO9Byego2NLpZZ8Mqv0eyXvlGFFX6U0EuOj9dFSgELQwlXOHMv
 9s49+ABMHAl3tHYmKo2pWjqmM7yx3PcNbX86sb68ktUOV4dH6R57pGzgHUKpFeMTZtMCyo6pK7
 XAMB2/7hrnFUG4xhuEq7GsMxGkJckSytMI0DVIBB5Qj0rkwr9vF+CMWMTU/S2K+NrarVgqTEsV
 3yGFPcZwWvrNOZC3HqV51Mg4LcuB1KoMx38/T9+NEfENZBnsqKe65p8uv+FfpjW8GGZLffeMsj
 JEM=
X-IronPort-AV: E=Sophos;i="5.70,404,1574092800"; d="scan'208";a="230849898"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
 by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 10:00:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeQ9z2+9cnpi0Ip68bXNDjIBixdml5shAlO+z/1zXvSDRZfk3SQjnECB9qJeNKqwG94eg6HirvqlPxZQnTwlzBLqnSX4EQ06w8Bw/yjk3LT3kovxo88uBlZtebvKsESyBgwp++Mmquy/JGZ5rgJxEHTZAqH5t8QAgwsctEkxoYSR1BB2e1gSJ+PRC9877H8rnvcs2V1JHzSH3B8QrwV7AZ6Ms10DPwO+xTtc3weI7Cc9a5xrK3Zfhn3TuqIe82T6M8KTydjqjkFHNoJy21SF40qEEL/HQtjWZ+1ml+1VEFGwu+m4dpxNFNhVd9VwMnvWngQqz/Q53EMjTOudGos6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCEus7ye/wdM9LUk2chS5wi9KwqlHv9m8N3oOsKcIOw=;
 b=hrprNfQRpz16j+HBMYsgX+oqjjF9gkN7dqPdl/0LXW/Dk40suGZBFMn0s6loAulraAb1UmwMGAD33W+RISNDmgbSxPWdcEM0IMhTR8YFrPywtEZNiG5xl7ivE5aubqTrqpTfDcygPKKsk8fmYuEhXUpDPjXz/20K8U/3dq1YR11O07E6WLJkRQ5uY9XAuB6VVuJA7EDVkGvRFmOwIzhOBAWZWaTZFnGCutL1jV1Ed89Fap6tnAcDpEziqhb0Fzl1A3UDSyZvjmmFYgWbuWIvesPmtL31VRK/WJsKAxS3fYrIGX8DUyfPasbId9LuORZ75tUICaJqu0ECyBAbLkJQtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCEus7ye/wdM9LUk2chS5wi9KwqlHv9m8N3oOsKcIOw=;
 b=wWVtac1r93OAvkZgJisZ98wB159ix8+wCu8//41iDTK/eUHwS7aU3iA3cY+IQQ5tOn2OjNvT2UqfRavA09UxaUwbM6UoQIunz2uDicwMwLpnfYYqxbujocsnKykHvfVupQgvFp7RzZTCnbczEACNeD5rV3Ld17FpoKBt9orn6v4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4134.namprd04.prod.outlook.com (20.176.249.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 01:59:33 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 01:59:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/2] nvmet: bdev-ns buffered-io and file-ns write-through
Thread-Topic: [PATCH 0/2] nvmet: bdev-ns buffered-io and file-ns write-through
Thread-Index: AQHV28eQfwnQ9V1tW0O+Znq+GbcJgQ==
Date: Wed, 5 Feb 2020 01:59:32 +0000
Message-ID: <BYAPR04MB57498DF60EC65BDA419F25EB86020@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200205015653.21866-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53727e6e-1d1e-4ac5-884c-08d7a9df0b76
x-ms-traffictypediagnostic: BYAPR04MB4134:
x-microsoft-antispam-prvs: <BYAPR04MB4134203AFCF4A57E6099290786020@BYAPR04MB4134.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(4744005)(316002)(8676002)(478600001)(8936002)(81166006)(81156014)(86362001)(7696005)(186003)(26005)(54906003)(6916009)(2906002)(53546011)(6506007)(66446008)(66556008)(76116006)(66946007)(66476007)(64756008)(71200400001)(55016002)(52536014)(33656002)(5660300002)(4326008)(9686003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4134;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9k0v2KplMJGeOSXacgt4lbgBugP4z5JJg1TUbna+qNcpHyR/86HX1LjqrfPuYL7SHfzpFD6AjkKI+muMRtsbMjNWnJiK6Pho971qhYAqryjmDzhrtZFN2rsgzNIWhcArliGn8o1RRAxtVCKk/zDM705LB5W1CzANAa1MOxyvMGsIHgOyKL6VXNguSKZ9RPHCHcHVD3998c/M7uUdggWk+9nyQE7VBt2d+k102jgf9VeerAGueToXOWeiSiEOZfVzof+ZKOkUpdXBgsW1TWUE66x3YFQJTNiQzAUso3fZy0BfVy9MtDrisXJ8qW5HfL30E4EyJzXsjoq+26UmvfdgNc9lrl1o7KHf/lnRlv6yB9181EwGbzntRTu6UBD9pgPQGxpDx9E2otxic8l8SHD1Dfe00QvZzi+X+3HDUiAbZKfCOQlXzfx/P0G2tdXqKaB3
x-ms-exchange-antispam-messagedata: Ic7hyun2Rwz2XVO98sWEMD2Egy37FSXxChd+Q9pONiJK34303AShBFI7YcKvBzQnn6wLkUDXUNtBQzCsPrAA1gZHhOCCvOnj2hjFwDwThkW1uHzPleHJh3wiTO6AdPZRPBhRotqBgidzs5woB0mkSA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53727e6e-1d1e-4ac5-884c-08d7a9df0b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 01:59:32.9144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Rvw6YnnrvpHf3g3ivtRbPyHGd3oUsY2/OWkjFJzSBjGccSleus4CNkr82kNp6ShMSiUt5goIBPfffzSTzvRYtKy+NZkFN1Yj0Gpv/rPNao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_180007_072385_61D91827 
X-CRM114-Status: GOOD (  10.43  )
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
Cc: "MRuijter@onestopsystems.com" <MRuijter@onestopsystems.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Please ignore this series, I'll send the another one.

Sorry for the noise.

On 02/04/2020 05:57 PM, Chaitanya Kulkarni wrote:
> Hi,
>
> These are last two patches which are based on the discussion with Mark
> (CCd here) along with cntlid and mode.
>
> This patch series adds a support for block device namespace to use
> cache and file-backed namespace to use cache in write-through.
>
> Please have a look at the respective commit logs for more details.
>
> Regards,
> Chaitanya


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
