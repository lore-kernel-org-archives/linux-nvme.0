Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD4C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:53:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44FB207DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWL/MhXp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ApImkgyZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k5a5xsjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44FB207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=aqDHtPIOaxzNPyyOA+gGM56rUku2gb0kNto29vgQ8Fc=; b=fWL/MhXpqDx8uiLGUAkMr8vdb0
	+THEodX8tLLV605zdIU2m0NfoLCs/EKpcxjWpEnfzfIqBXS3yKH/kGkln1b/Jn8ifkDFqcIjJ3BgW
	jmKx3UAmvpC6u8sL23l0m8TT0T5iDZcp2vWM2MPdEgybOUKfZFjhBAq9S9FyCowHXKUrekRZo7kk+
	RxqJoPT4pA2t/FzmayDM5rs5+8jD8DtO4jzIq1QRqKdPdgICbn6Bw0fxgr14z9w9btv8UQgHQ3cJH
	KWS5jQLdiHd8XAf+xCdBIaiKnmVLiXnqE/knr1wqiNzzp7I855yhfgB2Lop74u7OQN1ibMtw3bICg
	9U0MSt9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8W1I-0005LT-Uq; Wed, 19 Aug 2020 21:53:20 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8W1F-0005Ke-IA
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 21:53:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597873998; x=1629409998;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=mFGjJsEgIjwqjO+ZA9lMJs6wvdwn38bAry8fFBN30HQ=;
 b=ApImkgyZRmRYq9AeJ48CzHIh9E6MFWp5f0YaZiZNqMk0HfHuB4ps/jts
 3ZMnuCAZ2JMH6IBNEeBA8Zlp7CcQyaJuk3BNdqIlXuylnCBGwd+uKVKt6
 5O+iG3gPnIIzTLijCIfQM0N/dTKRKlsX5YILA9I8e38iOc6JNLYXs0Gow
 ImHiIJc9ih73nb4RJwvoJ5KzgrfaGF9ztAvFO/vgVIJEXtftuGcxyyjQw
 ZN+PDb1CyOO+/YnEff69ye1StMBGjeSt9iviGRluleBW0mREknPufUcuK
 VREZTdgyzUSmC87JLTIIZgxTePMQLXz3JjAsL3Y4vu6oXJfIo8nfTZqZI g==;
IronPort-SDR: vOWYHtLhIJYK1oZyNdnasIsn52+/b5ey/ECYcEg42SP1A1gbWMOWK35cMJJSvC0ztLdLqj6/uk
 Zgje7TqpOOujqV0uaZV5GjmoOiOeFvraXnZuVT3hLM0q2ZDxK2Xlb/ISHABOQmv4YYl/q5sH40
 AHtxazAeX0Q9sVwmrB23O5JnbI076AGXINoeS7DOqHnTwS7RXJRx0BmLuEnBE09AK3a+9YZTq3
 AjYSHufNgS4mRIjmQ8NH+CY7/6DhLfoxY+q67M/HzkLDRRN277KHPMIqdMepDaHFOUA6vNPD/x
 OwU=
X-IronPort-AV: E=Sophos;i="5.76,332,1592841600"; d="scan'208";a="149681779"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
 by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2020 05:53:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fT1PmwBgae8rklftGkGh8aUaHYZ/mQede/VZMvWFWskzGDC239RvbKXtSJ5Y8lijQE989mv306AUHdHMceYq2h3/913Q+umNC41KHnD04eMwflcUWefaCxkqx4eUW/ZMpWW5/1+z8vheGps/FFUe94FugIEeaMcfCLn43sW0TQkwrPv7UB5ZmxnMJunNEWwuBHK93SY68sfOTtUjnrcSgY6+HDx9PCxA8dcYBXTPd3357sz2CAAuNiALibh4YodcVjm8I9QNn3PVQc/ENdCqA4knmVBThIJY6LnpSYKuPL4jVWvLneQU5EsNoWU6kH/XWTyG1q/RL9/eH7lrNnFG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFGjJsEgIjwqjO+ZA9lMJs6wvdwn38bAry8fFBN30HQ=;
 b=bQcCYTU6/vJouxPFxl7sUfG/zjdwrsBDChePlkFc2QjfUPHJ4ELAHwW4aOkolDMflPsrFY8ERY2R75YMhSuNLqCJgziLacr0kzqC8EHMycz/rJb1ZfQDdWPQxZK/W7X/S/RENB55Qb5ZFHFjK0ueDqyp66GrE/Bb9YBjpr9My5CJJHtXrMmQVJV8xuONBFaqQb39qTUgnu+ku73lTO7jiOAqNLXegoPwjHEJrmQXWuTlb+wEk+F95/tbvtxfagmkbGSgRKff95xXHJ1U7RUVCohpsW5WRcEDnuZ9W+d5YZrVSB9pJZ2JW2qiE/yGIfGPvjRiUBuwIUUzNcEhq4rJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFGjJsEgIjwqjO+ZA9lMJs6wvdwn38bAry8fFBN30HQ=;
 b=k5a5xsjwqG5PRg7ZLs9GK/e1JqtWfSmsjTVaoZB4yNq9we12Ha5pTO0x7Eb/0M3+bbSlXHRJuPLX/A7eEJC+4fQQ0wMY90sgHPcCclk8LKBq4YZORjx/5XaycghtmiWnJfH2TmvVnFcb5ar9g/gmA+Pl/e0d2YM8fybyoc9RTDg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3960.namprd04.prod.outlook.com (2603:10b6:a02:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Wed, 19 Aug
 2020 21:53:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 21:53:14 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH nvme-cli] fabrics: fix segfault when -t <transport> is not
 passed
Thread-Topic: [PATCH nvme-cli] fabrics: fix segfault when -t <transport> is
 not passed
Thread-Index: AQHWdhSsQDR0dGv1fkq5p+dfQgj0IA==
Date: Wed, 19 Aug 2020 21:53:14 +0000
Message-ID: <BYAPR04MB4965F354B86BE5F807732247865D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200819103157.50211-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01f3d48b-128b-44ab-329d-08d8448a4655
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-microsoft-antispam-prvs: <BYAPR04MB3960348F9CC4C20A35E0D996865D0@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKxUhOpd5veKvKUuxrO9yhjOHyx/Zpi+iDlLsXkh0udkuIFgqgKxWiPBjRvq/+zzNlJNmNipwn/19LUOX8FHvA6msuDV6vo47lwtOhA0+qqhCNM5OOXfQtpCumd0/u8lHwmyB890lOoPZLUdGJmADv91Ac0zzkO48Bx6RSPo6ZvIi8fcvBf/xLpYaNQwWPA0ybzririZ9xRUCTEA/rZXlDyEwEWXcqfZ3Z9zd7a04lDsYMsUVlOgt8KRTdS9vdh57LD327qY98dvrogDudDHIpKs6W4BEHalCuUmmHkPNYMrNjx+fMbB0jUVdWELqEnH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(86362001)(6506007)(53546011)(55016002)(478600001)(33656002)(7696005)(76116006)(66476007)(9686003)(558084003)(186003)(66946007)(26005)(71200400001)(66556008)(64756008)(110136005)(8676002)(2906002)(316002)(52536014)(5660300002)(8936002)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: au7YAVTiMiuQ+iDafQu1Uc92jTTXleyhaXO/CWoHzUVcc4Q1bzLPbCaAQO1NVTghT6ygt8ewsWg18peHCcUFpQxu89/+/nN8m0EdUwSthNT4fCeEpspjcGtmtfddBqItFaItDnPcCX0qD71b2HfCp9TVgzSf7PhocS5qWXw2A8K/c5TU1nyq/TKnhCY8c1C4CO0j+xR1TPd10JVBZEyhGEXphQtviI5mfATvIQwaCXabGa2zAQsN6TLned1eHUBAV8G1l187dZ5TMhhytUjgw0k1Q2q2kPx2R5nzZodohmvoNViirLgv7R3Cf5FLohm7c9/4T/QEYN2NkrJ4zJ1fbJsGITxTULnKwuTRDM6TkfXHtQDIW7Imxh1B7Me4cxjHdfsJZv3d7ThTa92iJorzNpbKrOXCW/cNE5TpXS3obtGCI8gtXjtHvyqECW/yGX4r7duc5g7i3UfVZAhPlRNUuw9m/bHMeBmABALWCsNBTYfxdGoCIA/cru8x8G2pBTyVxYhV0QPm/PX/wznt35FO8Ct/rHtCr0W+jjRw67OKhWiBCBX/061CRiIANkctWQE1tnYEkxPrKoxZ31rtFPbIfDP3PJ3oFgbRAjbpfULLFH8ZkC6YssuOY4Fu0aG199Z0gjn4BAcVLFzLVEk7O03GrA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f3d48b-128b-44ab-329d-08d8448a4655
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 21:53:14.7450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6JF8AGkgr+abG3UQ8f7cG5WQVwaeeXuGgx86bGS5/WRnJA3h6NNo8CZNQYwe9Q8Axg8Cw36f6W+nN6vD1CL3Y46RsoeAF3BVCRzFHSTPfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_175317_764401_1186BA25 
X-CRM114-Status: GOOD (  10.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/19/20 03:37, Sagi Grimberg wrote:
> Need to check if transport was provided before we derefernce
> it.
> 
> Fixes: 9da606b4afcc ("fabrics: allow traddr to be host name for ip based transports")
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
