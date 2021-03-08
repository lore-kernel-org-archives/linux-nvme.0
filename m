Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91782C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 20:52:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76D4650DC
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 20:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76D4650DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=SfsNghIH4fi58xHTs4QucT2o9dz3i1yC5z6CPT1rSAM=; b=KkUnctlaQrQ6uPUyw0KzrPTvd
	jWCN6ezAfFKLMd2AI2QvuXVE7QZFV2rUj7HRe7py1izSLPvyQfUHL4LJGCbGw5DhcPGvDZPEA1sPC
	ay0h0Q032vnzadOnnAtFK/0hdcUICwTJhveEPxKEMIzBs1blcEFwBkdyJbNmrIiU0hN2g3U4AL5c8
	LSXtLzsZ6we+y4c06Sm5RkKIDXq0PVjLeI1wSRJEbhuxE+GBSvzGvbsY+6pDhyaN+VSXTIAuobS5X
	ycGwsy3r/dEWhYJ8Q8FBjy9P2rZpvLTFtya8j5CRfaABJTRTo3HDlm2o8J5g92U7KFVQ5d5lwrTiA
	evWlbD5Vg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJMrY-002qoi-3R; Mon, 08 Mar 2021 20:52:24 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJMrR-002qmJ-Gn
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 20:52:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615236737; x=1646772737;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=odHpCrG2t8uvUb3Nk43C/jk/B5sH0EJNcKQo/Q8W3us=;
 b=Z9tTeW746fKuDhEYIaoNU5qJYBVB7n2gE7ZKX6qqb0m+WnjmICTNifts
 //GOoj7XQPOQ0KRLYhFaCKMD3FWfh1S30GGn1aTBuo1TFEAw4S59KMr0Y
 X4WnzbkZkuvT/qOLpI2+1RDDCvpI36vya9aQhmhh8a1kHG1kOVPXQGZDP
 oCceyWchWcmUHJLGVUOppMuWxU5A3EB2OHHyPzO0nY93yVYPyhnDomnEp
 Jh48N9jGJAfKsjbnM6NCtDivmOeacBFnFSiOtEnlCPa41JBHdxWxf8sWA
 kXROYv0Kbxp8m6v58aNlz2WTF7zcmRuMP0/HOzyklG8YsDVPuBYtCutfb Q==;
IronPort-SDR: xQAXcTLMjvNN7s5DG5SrM4kpWH8M+XSbpAr1pewBufpV9guVFE7XB3YOJYkVZex6qE9PNOShh0
 aEq3vf3nsdfRYWFkeozTpSw/qxIRL4Ap/LeVHY2xt1O+pvR3At0+2moFocaOhYBkTXWehvvJ3h
 Of+dSWgQZQ1qBuyqg7mOH6GWb+U0g8xZmPywOcS6l+ruuXxab6yk13oXXuQxR93OluFsK+AJJ1
 YP2h1NuGC1f1iNbQCEkX08n/wFWh+n60bSasQFh1+4MD7O/F4u2jhx8Jr1EE2HQ1IVG2RdwlVp
 G/8=
X-IronPort-AV: E=Sophos;i="5.81,233,1610380800"; d="scan'208";a="161664604"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 04:52:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWI2IKP2cUnYD0nsFtC1XBeafrmEcA86jK1U4LuBDTWJI6jE8CBrTe/PIhT+tjTYxb16M8CZNClblMhJbhYEdqhzVKsfFbiRmkReodgEx7mE4Z466w2gx/fXAAzL0byYkteZYc3iGGjRtQFu7G0XQAzR/+q9Z4EQLNDJBOvqgZhT9b4mP6KxuB4lwdFqfkLGecBHfHIQhGsQui4InMqZySbqUOHwFCpUjB9s8IC6wCErj7t9YNAAiuJx+4BCwB7HqNw3Kl8U3RnoO8Bo97NDSK+U2bbXpj9HSWkAYdOkhD6lDtkFB+QWOeYcveIGM2Tgw5+6EEVrruTYFM+33TT4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odHpCrG2t8uvUb3Nk43C/jk/B5sH0EJNcKQo/Q8W3us=;
 b=bzHHLG7ou/VwA4gIGctWk2mEJYk167UmLnZ5+kt6ntrv1BsXokYlOCuXR68DvPV3lDyU5S9SJFPzFgzeJ2q1v3kvAuJczRbuX1KdHfG6GeKOTjb/YWwTS68/kAz15RL16WuccHoNDjhZTjGKJ2Mz4Z7cnFmP2TfW96FG1TF3SXvnqvy8OVQENaeyAZy4B3Un0YPigwoL5kkAol4EUByRrQ51VJa35g6JIbMhPpVlVl8wHm3ftL0BqHua5MoflyiXFmaNNzVwvsf0aMpzgdrMhZkOXoh8rqIcM7J+qnGZ8Usz1uXdKxVJoPFAQxkDQT6pxEUtSEtNPaXFX/qivom+Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odHpCrG2t8uvUb3Nk43C/jk/B5sH0EJNcKQo/Q8W3us=;
 b=qXnOYT4vFfYtcrs/7C5yUWWa7suL7w8Pio93r4PL1KIlnERL9xZQ9dDLqItH/kOq/5g6T0TmeKR7Yydt2eh1g5vKv6CifikeMzIGnNRZNWClxHU4S8g8d0jYotAzrHDBrXgXOyv8mp95JIMLjVD1L8vvrCiw7rO1y19W0x5lFEQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6551.namprd04.prod.outlook.com (2603:10b6:a03:1c6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 8 Mar
 2021 20:52:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 20:52:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 2/2] nvme-core: reduce checks for zero command effects
Thread-Topic: [PATCH 2/2] nvme-core: reduce checks for zero command effects
Thread-Index: AQHXFFEO8KUjQgQwQU2q9DQZfAvsfQ==
Date: Mon, 8 Mar 2021 20:52:12 +0000
Message-ID: <BYAPR04MB49658BB8E7A24D2EDB4F257186939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210308191804.8582-1-joshi.k@samsung.com>
 <CGME20210308191851epcas5p3253b85f29279714544c8c14a7525ce7d@epcas5p3.samsung.com>
 <20210308191804.8582-3-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be6aa34c-27ca-4e56-4eda-08d8e2740c55
x-ms-traffictypediagnostic: BY5PR04MB6551:
x-microsoft-antispam-prvs: <BY5PR04MB65519A82EC47802E8145EE9F86939@BY5PR04MB6551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jxoWKZ9AA2X8zTbrNlXmNlQ+9xKPZNjwA+H247r/25vlGft//K3mW+rQW1ktgDNNvgt3H03kVCj2QLUr6zhAbJJxYCdGzm6MJFAmXuOuc/1O9hyRR9p5XYBRvOWJgynpEI7vmQOHxV+KGPyCnDel46z5FMcLUYywLuheKd5EsVM6NqmnUKl0F/gijjAJDhjPqyS9XdZqV1e5L5FfMgtSO3SeX5mAtEavOWlAnW7VneM9HWUa8d74/0SGBmFLa5/Z3+GMyMdpsOSPgK2qOF1x3dxBCYeCvgpsdGfpj+6hHjuLR33gf5Edqsky7r+SWWmhWUbPSYCKM+f5rKkg2KVCcViT582xy0eVBTBr7lOrYQTyDryCBfdFIEby63p+XcPLwJbuRPGLB0IiXIX9Ttjhbi+FOHGvZa01OYBnUlbfnwnFghmFvEX57eOtLHSodloNNKMIGJ71/cFBX5Al2dWQYsKVcHFwEiDpiA7qBSsTV3nA4jrS6TUGQnhxzAXJc1F5ZdEg4waOA98H1hFjS13g2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(478600001)(71200400001)(8676002)(4326008)(6506007)(55016002)(9686003)(558084003)(53546011)(76116006)(91956017)(64756008)(66556008)(86362001)(66946007)(33656002)(66476007)(66446008)(52536014)(26005)(186003)(316002)(110136005)(54906003)(7696005)(8936002)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Odlr8dzMRge4CuxsvF2N2udK+2SmFSHLL0gL1yUERfCQ94+Jbhyt7tpLxPD+?=
 =?us-ascii?Q?VMaFpBX/kCdbfcxFNSteYFXFSurk3zU4Y2DNUH+eSb3MwcFZR6xXHhr6pzyg?=
 =?us-ascii?Q?J8yNOJGcFdIO8FBLSMSG4/dY8t83g3u76cyHqev93UdYYxXPGGrzvxuU3/yL?=
 =?us-ascii?Q?dWRZafTjR6L3i0b0rJzzOK7osquxNzWg+0vEciiK/+P065HErTHgUhl+ieYb?=
 =?us-ascii?Q?ASuy3qMiiWZ2C7JSJvJ3IiGIOA6afA4ZyzhZ9wdHSNxDPCYS3dK4rLvpZTr1?=
 =?us-ascii?Q?X/VGu3KnynKepJEN40sXmDY9ikto4/CjXndBDRMbVp16ljFkOLAn2aM145YF?=
 =?us-ascii?Q?jwDo5dxrtSwX+vGTJqOBbmVFBeZvXszBDW1J4XcgoeG10/MTWxuUkMWvcphJ?=
 =?us-ascii?Q?r11WQSI2LjmDwPzlbpKfsiSCE5YufD5fX+NWHZ4ULsh+KO/wTGi/FQiH91rA?=
 =?us-ascii?Q?J9bTuZPHdIzj/C5GgPJhXmPhnHGc+T5EXPshs8n9+BGKv0SqDXWPbCBsK68k?=
 =?us-ascii?Q?Vykh4N835RceKCOURDHQyywGgTkrrig9IjRJBHXfoc0M9rxtQ1pVwuL6lfDo?=
 =?us-ascii?Q?8YkCrSiilPdMVOAjquwWfLza/0EN+0pKz/bPboWCs2aSqPYlB+9K91e/aofb?=
 =?us-ascii?Q?cyAAmJks/+1IjHnXtVGBVTUHTXxorSyjgyucLT4gp34TeRjHIoHpUn6igTRF?=
 =?us-ascii?Q?i2n+6ZhKvzjc+Za3LsHEGDLOPJi+odWgOJs5dF/lC5bBQ+o5cVl2g4+zHRiK?=
 =?us-ascii?Q?iiq6jk/oPe9bdKkQ52a4XUxrXWPYtw1zBvYjQVg3LXieRZitDOjgrbfigGga?=
 =?us-ascii?Q?2xjxIy6Z8Q9OiG241oUzMfKFhAKgXLTKsQRvRU37bw2Fd7dr/7xNduH+jy0A?=
 =?us-ascii?Q?oHu5jyX/54XwmmaqgM0EvNPcfXycS8CdjzCNoPwedSmF5x10fv9z7gK09j83?=
 =?us-ascii?Q?z2xy58wLHUrrWJErd8JJxjQrYo8UGLfmCRziHgwW1mF3L5PouMPut7KFk72a?=
 =?us-ascii?Q?bC1D1LVKqP8ZwTxyFLFqJVc73KGDpI5vJbAK5azgaXbRiQuqIjIwVBi/Yxqq?=
 =?us-ascii?Q?fDO5KJUtMrWaBKBr3Stk6mMK2F47aw7OBpPENYo8J1fwec69w6QjIpj6S6o5?=
 =?us-ascii?Q?jandNydQL2GkV1xv6MIJAjyPXzT7cWLPz0uaVnG5nZYXusxpWipgr0ThmxCC?=
 =?us-ascii?Q?gikxGjD9Ldbt3g5Nb6jaILWCemDfVEE4Qr3t7wNFWm+ZYFtUPCjq/WMgKMtU?=
 =?us-ascii?Q?yxN5rESsoz4j8xRpUln2ab5jGES/1iwrYA1t3p2Zz3r7tQpuxjC8FHLmDna8?=
 =?us-ascii?Q?ygqUaegR0jdovJRiXsaBOGTV?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be6aa34c-27ca-4e56-4eda-08d8e2740c55
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 20:52:12.3116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /D6MASFAmfyIO3hHLHPYiqPsF6W2+9q2aD4ukZXfjiINekikitR/4tkQ7fzWxoKayiCCHpNVWkrInzzgB9b4ZGENic+m8mm2qHyA0KKJCfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6551
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_205218_141766_3AAF0171 
X-CRM114-Status: UNSURE (   9.27  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

On 3/8/21 11:27, Kanchan Joshi wrote:
> For io passthrough commands, effects are exepcted to be zero.
> nvme_passthrough_end() does three checks in futility for this case.
> Bail out of function-call/checks.
>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
