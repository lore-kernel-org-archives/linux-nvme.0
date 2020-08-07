Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75970C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 18:28:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3141E204EA
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 18:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1epQuCqp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BQzRUS/z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nG6xN+zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3141E204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=OsiK5EsP98sH31IKpb+sCqYDlw0TNgaXa7QIdHTH9as=; b=1epQuCqpH2Vke0R9LCAFiwMQQ
	GaNgxKJYkZraj8lNDR+gbpU1tgMtq9qqxc62uIK976zyBJFX+P3XNO644HcT1LjpxKWpcVvlISaEp
	bdFj+Gy23FR2PF9iy0gQrOurn6JFb9vxg/S9SIMnaalZAhY6jY5xo9Y5gEC/rvPbhLHjAaNd4RJTs
	xxdBkk3YNIqJjGK1EsSFMVN9pL2zMy69W/LiMQ4Br3MKslco1juOa2qwkxiFUOGjKDXU1MORAj6bC
	NMZp+zgOM/oXHexpfbOHRq2O9bHJP//fqmpnUQBRhPOSW+hekmF/iSIUaA6ezwo4XTXkIOkYz3U8c
	+hGwC6HFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k4769-0000Rs-H8; Fri, 07 Aug 2020 18:28:09 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k4764-0000RY-OV
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 18:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596824885; x=1628360885;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=h1FdQWejPnLh5xPVG8+m6Ps+cEUT6jAbjBaaC/jE6XY=;
 b=BQzRUS/zomJM6fjfVYvAl6ODMtzVpVlar1UL2skhHC1ldcA1cwc6UjGX
 yRgDpsWBRCTHIl3E+FSlPSy1X2F+mkv7lFdFbkvYAfQMbSpAeGqnbvD3q
 Kd9wgq3pudYXCuhlgBn9VIAwTASGDlWmxkYscCkBKbJDuuWTlYrhsWWYH
 qpiqP5b0+ka0UBLXC4Ny0MWFtvtsocHC2pRSVSiVTWezUn9VO3+FOwQR+
 8ksbapfAn4QU7OvPD/11wL37Oa/8FvdAw/IhLvk1QdcJ5jVgViz33xCdH
 JAQP5OYulZ+2JINtKl2C2TcicCXqjYmJSntJCy4SkxdXw/w/TS6cXISEy A==;
IronPort-SDR: DqbX68iRTj9wVDl48DyVbGwJmAsUTROXqSAJfeZhB/GFxzfffblQQRhvSAounS9jYIoztSXi/o
 +rVm0FOyvjnppwlZXz4rvLy8DeC37R1Xy8sEqmrinHCnSDpyUYv9ND6DnGi8jHwgLvyDICgibb
 /rSoQ0peyp7C5Dyuyn3gWQZNEao/cDV8MLKbvEHiQhAt28yrD+bPGKHMSPfhEVOMLGObr/GTaM
 rGsUPVNJ3CUfHT12++jomDs8aIqOFbYv7DzvtSKYODcqUvLNaxTvujp3ry+MSbBjpwPlQNtsEN
 G/g=
X-IronPort-AV: E=Sophos;i="5.75,446,1589212800"; d="scan'208";a="144477576"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
 by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2020 02:28:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgeQYzxZMSMXUqX6gB8QdSmNWfemiGQdvKJNocCb50/xnw3bR++/pDW480b3iIii9M5RhtqvHJM4D65aefLLYMLT5gIpSegaHRzkhSr/9qtrgEGx8q5M/HBX/hF+eesktjesJsfaTMfXoFh4dze0Rs+x//l6t8+8eukyrE0zh3GF+lIQ4X5Zok50+1vGDS68ZSZO+YJeNVAaHHq5k7BvsMV/k7ZN35BjRMEICaZ9L3rlsU86lBb2MI/ZeFt+ci0Kk/gVB4nIzwgwdAegE5Xq52VmfLCj+WcYMLUedFdTGSW2PV2W9uP4r76WxmneTb3GM1felMGjESzET+4L1HyzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1FdQWejPnLh5xPVG8+m6Ps+cEUT6jAbjBaaC/jE6XY=;
 b=FIsqQPAqBy2NWILgDzTRFiTbD2sfwCVTDFllFF8Jeo9T8ODA8r6FXDQqFVnDhglCwQ7YvtILO4EVRRL2orDLn2ydhcDQVsYtyfocclVfmT8rglA1pi+89rWJnFslwsSc2JWNmHqE30hGljgpFdwZRhWmC22gs6WclrUQRXbBctibunxqvQtT4PNXLTyEpag+TXq/rMsZESDXhgNlOIhDNs/N1kOjXmOIbGEtWM/+tzxptQ1hQLinuBGN1wmwy6FYapbW7TZ5neQqk1uB9L9gNmPw2azm6Q7CO9CD6j0fZFFxmBIweAWkelst+pcc2EBOq9bub5+lmiVlHFSgDQVkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1FdQWejPnLh5xPVG8+m6Ps+cEUT6jAbjBaaC/jE6XY=;
 b=nG6xN+znlOFMQNfBnRAoDQUQsmC00A9gQL1uot+WTtKs14IcLeS8fDptJ43z904t/sKsHFBtisBWbxCX9oVqYHKPT1y3/z2OTDH35s6xr6H0FFHSXpwj6sMS8m+0tkTPGRY8erN0aK6CdcTV/Y8mmsE7TaPfJ+NSmlprzr65GmI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6422.namprd04.prod.outlook.com (2603:10b6:a03:1ee::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 7 Aug
 2020 18:28:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 18:28:00 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
Thread-Topic: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
Thread-Index: AQHWbGFewWKkBKEEpEmie8k5QoTBCg==
Date: Fri, 7 Aug 2020 18:28:00 +0000
Message-ID: <BYAPR04MB49652472FC206F905513382B86490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
 <20200807022032.48873-2-chaitanya.kulkarni@wdc.com>
 <cbf389f7-b437-e866-21a7-792fcaf405ad@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 686b890d-ca7c-41bc-f9e9-08d83aff9d98
x-ms-traffictypediagnostic: BY5PR04MB6422:
x-microsoft-antispam-prvs: <BY5PR04MB6422E136B872E92C7A711D5386490@BY5PR04MB6422.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VFgJ6HB91JyZeAqdWNm7IMGyhevhycBBGAMzmrO2+YSwDmJLjhleRnmczbBcLki44QiOHVR/7wZZmC/sB14Cbr0cRHxhHcr1jIEkO9upWtk/TCbYXHvoNBLfuf3ScKmcfH7S8tzI/7gUdHUGrRBr3ZVFqLAjVRAkifpRdbHtpv+OFYSfpJr6Puhe7HHDvRYCRdh5q3VpbWErlvLDVPoZuDj0jTjLf10eEuLyBNww/jQjXSI/gsT/bxkrqybd151H3NA1FLVnY9RX+9m7o6vYjLZg2IkArKDgYzUltUVjgU5lGCOi7/EGshNeLbG1KhRw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(53546011)(26005)(76116006)(6506007)(7696005)(66946007)(71200400001)(33656002)(478600001)(66446008)(66476007)(66556008)(64756008)(52536014)(2906002)(4744005)(8676002)(110136005)(8936002)(5660300002)(316002)(54906003)(4326008)(55016002)(86362001)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 0mmbG4NryJ6ksKAqiVM7apAu2Ma10twZbzJOd0z8ISFCbKC9HduN0px3YcIHLL7RWG/VaSyz5iGLnT3IZNymHIp4iji7WLN1gCz6whvNdaB0H1cLommmD1OsilEN5TMGd4/qKWSewG4w2wmblkTxZgjE4aRyeg3Pvm3oD6tSCxIfHTNXWENfnbJWwXU7GdI5BOiWNvTmwNenniYyHZf9N/bS+6n4dBP3aKoFWwtkni/6vezpdKmj3AO3Ncs5QUpRAvVSucand5SCcKR4kpJw2KTIn5cqRAM7TKRHhiH5FBXHemyg4sthKF1gFPZWBGEmK7sqTv5jNgyQh6GnnE7y3ceHZP29IFlkQET8xTp1M2BJGRba5fmNBcKvLaoCsrJkNuxZHEn3rJtBZigIoZyfHxlBm51f9TeglU2uP9gCUPWMEsItGQKohj7PdPKk/KTMFcL7FoWzXq1YuA95vCbz/Ff8WGqprsf+OH0JqD+k8TcdJ1e6WMLkXpDTlzEBgABwdFX5orIFNJMFXWwbxwxEDJUVB1lIDEVr9UWb4LbAJQh5n0GQbaCAEPEsjx50+ik7bPKbGSZvAarSBhmsbbz9WIX/Ej5tOQG61QTh4s6oz72ZZj9O4YWwLv3Es9xx4Q5izri9STY7m9nykN+RoPl0xQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686b890d-ca7c-41bc-f9e9-08d83aff9d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 18:28:00.5896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7IGlrDUrHEUpWGqk4q7SuFcEEWzmOcaeGxgnlDALoPV9sozApzesBCZguNWl7vJCId64dUVnYRTsiQUHanSrL7pRC2xA7igsjL5OgFoy1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6422
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_142805_191334_6544BB42 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: "logang@deltatee.com" <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/7/20 10:37 AM, Sagi Grimberg wrote:
> This patch seems fail when applying:
> 
> $ git am -s mail/chaitanya-pt-fixes/1
> error: cannot convert from y to UTF-8
> fatal: could not parse patch
> 
> Google search suggest that maybe the file is corrupted, but not sure.
> 
> Did you do something special with your environment?
> 
> Patches 2+3 do not have this issue.
> 
> Strange...

No, let me resend.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
