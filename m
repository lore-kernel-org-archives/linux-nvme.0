Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EEAC4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 03:07:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FF923B45
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 03:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FF923B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=eTAo201rmsNxjDGJlvxU1mfQ7ODoPzXx256BuMRoJxQ=; b=cDfVoWnlYYP01zYnnTwvk4cE8
	mRsvzLBAhehdyCeD3b3ChfBPm2sgyFzZcsAxzATdBsuOCbd5ZCh0PTCGhduVpG+3vsNRCZRP5+SlM
	bRgSpi+m5IsrfoHaAlbuCf0+nirdOoTOXs70+ST4oH0OwSXWCQ+dHOoOlpO2Cgk0pcX3P+X1vq0D3
	99TUzFgU/b2dmLMSAEItXsyS09tWN1acIxR7LadvwHoSK0ofRVNdLWUy9AUFjaBJD+eNLMhgw2Ncz
	CvbCTlt6Sl/eZvaNjckk06ph3PSQ29zlXFfrtBe2OImw6NAJ0IWwXIj3dl0qieuKIdBhGR6G2/SMD
	9RGgsnl6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knCIv-000154-SB; Thu, 10 Dec 2020 03:07:41 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knCIs-00014F-Vn
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 03:07:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607569658; x=1639105658;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BU/DJuLeVBdTFpEOSgT48lrVOjFziQVCM3/XF72O3gE=;
 b=ZhUEBtYfMm8YmkixiV7LUji8LXvi+MUpzY44hTGwUtFFGnNviU5VWTMc
 EkbXZn5+8o48pUL2D7RG3ofEw3fz/i/NUZJXjYybh49cUMilyPpH5Fned
 7I816W8WjmN94E8H7RvYvQEdldqCyj9rxn8uvMMsnSECg033z+LFVUx0c
 t+Iv3du3jUhSS+Y2D8CVQ5ktER1Nzl4X/TNd/r4wU9IgKmAwpWqk/y3bN
 evX7aC96h3CN9Ors3ThtlT84WoDG7fKktnLabeAkotyi/IRQmfuwJp741
 /SOFCBSzz4vvMSbNnb4iEQG+2Nw9FxHLyv7rsYjvOgGb4klws+RQ1bvko g==;
IronPort-SDR: 3uq3HfAflROTjatbtrm+iHW/4OYcc0AHyYb6NSmLJYcQ7bymU7GfR+KZevprgML+Kk7C+PiQ7l
 d1u0OOMChgAXwQ2OOK1TA4D4q2jnCvUoquwxrpUgSi5JACpkLQGGr50nn+fH1epCIFHXaclTPh
 5yR32m0Kpn6Jn+7+pGJeLlLc4AFa0k7v0uTWhKBunJ6sD9QcD90dM04ff6YOiuqx3X2R9MqMcY
 j6Dc2xei5nZDyumAXB+12rGH3UwXe+D5IrzOdn7ZiBuCOkq5MD0Ih6F7FMFpS2OhQFXZ9WjSry
 Vv4=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="154868780"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 11:07:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj4cbbeQtpfJyXvng33+Ah3CXtU2exZlFwdGWtdhMTOESvMs5d/YbJQgk/wcLGgWswterair6qUP6HzmtuZQcXUq95H1FcINqXpMo8b8fnVhRAqpRVNAcCUPQqmZ8TaiQOWS7JkJKMyoAup/ZdXM13siJABQmb7MvPrzefe8Aoe+sEriZqtJ8/SsjK8mhCn9PQMA8YO7XZ/5FH5IopyDw8ubDt/6NgJK+xE58YA1VbE1gRMxFjbrayB/VNtSs4Ag0zD89SVu89j/ucm8VRKi1wXKW7Tap1y7IQH5rUq36CCV0Bgy19kdQT/5fKtN23f3mW2moBW7B6CAb2GgT1D6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3tu4fXNmi5NGG1vc4EcLMa7VU/sQ5V9hPSOxP7k0Y4=;
 b=hwXDGdYxZVatvq5lNkcdG3fpRE/+aDSd4II1twoWGwoG3/ZQ8xIBTNim9+Iba6B56q1kaDhsejLmgL1v1ZZ+/35Ek5k1ch4Io/ncn3MDNdXDu65inlDpV8oJbCWZdMXGmqjcVue63b+MlsWU5dmgsSDm7ebcffcrUmL+O46RCq+epvoiEZ9MDkRC3d+43n7zro+ewJCSkv8BbyVM1Oubre5okxDpE/GdsHi1Md1kUOkeIGXxx6xRzsfrJdlVPtZVECXQB/+ce+6LGhunD8cg0u8tkznsxAU5ibie4Y6FhbUCV+pTgfG4Fw45w0MhRBLf5ZHNHX2dvFDGw1pNOOVCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3tu4fXNmi5NGG1vc4EcLMa7VU/sQ5V9hPSOxP7k0Y4=;
 b=yS3k58UEdkejcQIA0aRZOrhfyxGAKKSJ3G9XJjFy/pW38+mkB81UCKk+qKpJ4i1B1JBHHCecir6+P/FLTCc/zaewvDUO9/Ov78Sz7Y0ZxMXyFJiPQu1HDhPpP5FjEe8A2Cp9Zy5w9RyAIJWwRhbQMki6REx8wF91eeDAUVMjqpc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6421.namprd04.prod.outlook.com (2603:10b6:a03:1e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 10 Dec
 2020 03:07:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Thu, 10 Dec 2020
 03:07:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V4 0/9] nvmet: add ZBD backend support
Thread-Index: AQHWyHOH1JcUBqpEUEyzhAkmSykeow==
Date: Thu, 10 Dec 2020 03:07:32 +0000
Message-ID: <BYAPR04MB496565EF0AF026C16225792C86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202092019.GA3957@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1f01a2d-f6e1-4f35-ed30-08d89cb8bcd9
x-ms-traffictypediagnostic: BY5PR04MB6421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB642153204B10DD834392AF9486CB0@BY5PR04MB6421.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dyaxkl6P1M1PXditIHpUq6mAfo9R3Pa60FLoT/lgdRyY4tYXy5Dr06Ri3PjXnR4mVovn0jGYydlgLZJttyyBxjxKu6rnRdEICO2bdvWc82q7PVJMpl+FEmYTzCmFd2KssJQ1u7vniUN1CcsL9+43CaAFJVthA8qDxVT6HiUC6JOpfOnLy7r2YPiUCGE6DQ4BMyKU9EmYopb9QsgPE0XpQ94l0JDNp6eDWYhwATxV1Z+6nD+oCpQY6q8Q1dapz2AfLqvi6K2tep8KGoWOI/GEvJdMVNEG7OMN9AMFzckCQbgsMsgtKZviOGkJbVA2F16msvM3iOJwc27smy+rawr3Sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(366004)(508600001)(55016002)(5660300002)(54906003)(8676002)(66946007)(86362001)(4326008)(26005)(33656002)(71200400001)(76116006)(6916009)(8936002)(9686003)(7696005)(64756008)(52536014)(53546011)(6506007)(66556008)(186003)(66476007)(2906002)(66446008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zNS3bisFxhvo9hxfcFlceDk4AwOZV/ObnqU3R9ixSD+SXAzDHkL6FvB/s2om?=
 =?us-ascii?Q?JnUcKOC6gP86gYJVanNcHQelUszzsdqVqgNAmQ6ptIdIzH96U/Ph9b0g7Z+u?=
 =?us-ascii?Q?+L2R2gtKWzDRG7l4iVvhiBkh5yharyIBBckpYkhzFo7avK9lbNhndFzOoDoe?=
 =?us-ascii?Q?BahZZys67dRJa9+G2lwEo+Vn3KaCs56zqRxr5ExdVLUuyy5CK4ozcpfFT8h7?=
 =?us-ascii?Q?rciv0PZnViEImhdDDwYysW88DH6ATAOx3LZUL5Im3Ou93yUwgtbD1kPzgU+7?=
 =?us-ascii?Q?rbLyUoQjsSVn34cCPppehGjdW2VzT3rdlSDNfqp7NvJ5fM67mIsF9xfAiUu/?=
 =?us-ascii?Q?8A7bhJYimrFY9gy9t88d9tGJs1hINjyGAZNfxEsjGKP8ffXn5hIoUxQ4HIjH?=
 =?us-ascii?Q?+YvVexZJQPf5Rz5nMXzvBOsDNf5Z3/VVoFrw18RI5pBNmtkc3m1U4KYy0LNd?=
 =?us-ascii?Q?TfM9/cGcy4NvehJ1bhhEcjVV2KWAQmAOncJ6gkWUazY6AhRM80ynHCqvgGb6?=
 =?us-ascii?Q?ZFj0nJt6u7+1PnzT2gl3M8IgzL25HL/yXIV7cuCJq9iPnTi533BKrw2Q/V0F?=
 =?us-ascii?Q?guEzBxcFzOAHiKJvC6EJ2r9JzMwf0buE/F92BxLjr39YwEYVIeVO/QVw+96Z?=
 =?us-ascii?Q?D2384EwXa5g6FEsrRhRFL8pa+3AaQKBah5VmDKye8LUYj5213N2BjuVH0aEq?=
 =?us-ascii?Q?ULhY8Drf0Li3wOR7NesAFcSOVbwkHSnxUa8nplf/kZ8K8Jd9y3bGnt95Wf8x?=
 =?us-ascii?Q?SfAeiAopbFTYgrcghxSK1n0IfOdkseJXC7Pggp6Aj8ufSnx++eg8U7X2WDWK?=
 =?us-ascii?Q?9opvlKFgmyPtqDXkrG6MOUY2FhMKkRUJJWrAXhPMQnNwfoVmPYBdGqB9MrbU?=
 =?us-ascii?Q?h5L/8+Y/CWYAeoLre3xXPlp1BzMdiSiuqdI00k6xKqwBuC0iDtrkRvPIfUBJ?=
 =?us-ascii?Q?xWVEPTc/nsEQ05o0zguRd4CRmM3LREkURW9dk4l7jPbYQ/XcHkCPYBtgjMEQ?=
 =?us-ascii?Q?aOFh?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f01a2d-f6e1-4f35-ed30-08d89cb8bcd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 03:07:32.8239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAQxoc1nzGD873fpnC8WSuCnH0vdr+4M1mHI2Sr4p2ebdcQ+NUrggOLQXNjPiiuRocV82VmuXe1J/cazy556UFV8974OIF7BpiqNtaXWzss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6421
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_220739_238434_33A256A2 
X-CRM114-Status: GOOD (  14.86  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/2/20 01:20, Christoph Hellwig wrote:
> Unless I'm missing something this fails to advertise multiple command
> support in the CAP property, as well as the enablement in the CC
> property.  How does the host manage to even use this?
>
Yes, it is because host side doesn't check for the controller cap
property it
only checks for the ns->head->ids.csi == NVME_CSI_ZNS that is set from the
ns-desclist call, so this series got awaywithout cap/cc and CSI target side
support.

I think something like following (totally untested) will help to avoid the
scenarios like this for ZNS drives so we can rejects the buggy controllers
early to make sure we are spec compliant :-

# git diff# git diff
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d9b152bae19d..7b196299c9b7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2166,6 +2166,11 @@ static int nvme_update_ns_info(struct nvme_ns
*ns, struct nvme_id_ns *id)
        nvme_set_queue_limits(ns->ctrl, ns->queue);
 
        if (ns->head->ids.csi == NVME_CSI_ZNS) {
+               if (!(NVME_CAP_CSS(ns->ctrl->cap) & NVME_CAP_CSS_CSI)) {
+                       pr_err("zns ns found with ctrl support for CSI");
+                       goto out_unfreeze;
+               }
+
                ret = nvme_update_zone_info(ns, lbaf);
                if (ret)
                        goto out_unfreeze;



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
