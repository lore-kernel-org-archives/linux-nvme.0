Return-Path: <SRS0=56zt=JI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32414C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 22:05:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990F160201
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 22:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990F160201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gdSQ54zKApUgqgeCxiFKcXnHOQrfyGXo/lO8kv20DAo=; b=LF3yQW/9wLuRdm+l4znOxs3Mu
	3rw44JOkjtyhuuGw9nfD5cKCDsz9gdZmNXAjWurYZ49Ry+ZFm8TPXSisW4gy+7pHJdawI+5OmksaR
	PoiqeRwZMYPKlAXnu2ZoNatWlnSc2kQussSjE97EAVjEvnEE4/22d4LRK8uPJ75PLZaIC9WXonYVm
	S41dDHMMP3slLsp78TaL8zmyDya1+PTERpEmvhvRM/R9X2qZoBINAOJA/MF6a4LR4noJ7OOGKwvSO
	rR4MdYvJh4Q2R0J24a/rz4MOqgYmbPGuPWAKoAWykRPCrmIknEg5qDh4jMZSV8y+MhTewORvcHRhz
	Nq1rOHcGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lViD1-005Bnr-Id; Sun, 11 Apr 2021 22:05:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lViCq-005Bn1-HU
 for linux-nvme@desiato.infradead.org; Sun, 11 Apr 2021 22:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:To:
 From:Sender:Reply-To:Cc:Content-ID:Content-Description:In-Reply-To;
 bh=ZRBIUL8HYBBgY7dPDg/KJS2cRtT0FGIj10umftuEewY=; b=BAhTDkPdPO9nVNh5Y07KPRa9h1
 4bniVxXj9vslkrFfCD67AOGrANb/EjQIYIfa1vhpkTfDkti0NOKXL6pbmVsT1vsk93Z+ZP0aTHFco
 TmSz+uTmaikeXI3PDtE/2pGlnZQ7ReIhmoxNtsHU3rSnnr2Le7aD8WfDPAnTCv+gS4+jj1jwnxCxN
 l/mi3TulMrvVoRlQ7L3z1g9/mU2EbEgm/S4ok2WNZ3Zv0kjXjsgagO7d3wMCWBqBry9rWXiobQOQa
 QMX0Szmk/8qJpyEc8AfovD3q8ASVkCPWHl80PSKEK45D/NlP7Nyzk2jYlYFygcbPLa/gzYLjaPLX1
 VtDfj0jw==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lViCo-005lMm-1x
 for linux-nvme@lists.infradead.org; Sun, 11 Apr 2021 22:05:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618178722; x=1649714722;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=rnVmc8owu+rNlHBsdQC/w7FhGvXZL4cKvpWuS9Rx6FQ=;
 b=ahOjBtLt117bKfqf6fh0ezThHPapvaz3b7euZEh7Qi1LIlLwHl8mGzST
 Pt+oE9W8Be9ILWO/CSGbWJmMlnYcF6t9WTIRaPzDaexWdSSuvpb6XBx0x
 0RQPLXpmWyZS4TlsdU+yF3NAlXVWI2LIaf4TVo7WcFsUu/dXAmrDv7wo0
 mfXjONMKNcR0nTfEm9/8nptPlQ4LJJ+BmKEXPfVCi8fVEefXG453jGL5n
 aL7HehcBRLWktriUPk/WCrpwSONMVvgtutB41VHL7FPBTXBQmMj6cbjeL
 gP0f498xqxTyA80DF/+kNYvqv8iEnWxKbuvww0fwAPORG5FrjUVTmcQVD w==;
IronPort-SDR: WoepM2uLszjMI3IRpNZ+O6y0O6+cCwn2rC5AFw8SJqLsAxSs5hb+uKAikRH3stB0xKyyOpvoX7
 43uOHYQhMzKZg5bR3zbmhpgCtWy2UlsKKYChnYyEAGrckGDnjvP0GtTWRSQX7nm7WDJHwNLaCV
 izlyKXiwjRmP8wYNqFtMkZ3dK+BzrN5iggXQHLRQB29gU/+64TjuRCXquC1ntqFXJHqn2JCydT
 4aTRaUz1ToYsQJfzvMcCXSlvdJ5+T2LbyVYFwMlZazEzH8U2debeSuZaO3P1J4HzqtJisolGUI
 a88=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; d="scan'208";a="165268441"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
 by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 06:05:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmimJv0NIRHdD8M6llFfY2orzE/SQCQgrir2H5xxAkue7BM4Pa2nTZMlDOZ1qAjhxKIK8UHEPtd/IRAiRXVzbgfWb7VUqyGgMOCpJey5LC8HZTsuzk/i0rsctb/ZN383y5+WWMTotlpzBei2lA/pL/2vHm4JT8jo1H14OgDdiV9AcBSQSC9EY1gZFFxSrjGEhx7+/X00L2ERJ0P1neDgRiG3bRZCQmBzvlydu4FmqZFuNamVqE83JR31Fw8Dip0UENKYWC1E4UFDYRLATjBCogiHU/I9YPb9XDJF9KW/b8oyepxEq/Hxth0/T0QXX9je3neuMhpTlcfQRkE3Ob1QAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRBIUL8HYBBgY7dPDg/KJS2cRtT0FGIj10umftuEewY=;
 b=g1FNpAfKE0k+K67cVIPVH9/FaYcK1ABMvsFp+SruOZ6w5GORRSKpf9h5czv83So8i4DuNqEPqpNfdSz2oa1R0BIbvh9SczeLSyHvky/qtw7RPJmltbSeTmTWExoT6jrwF6guSfEtH8LZxvgU9Jqd9+aKEJbBqJOh0il25wzsnYIgt4BhhKyY9X++HY3snBg/F7/rdU4+eeBMxwOgeaNK4wGgAjfVS/RJSUsSdMFVqjStohEEzt3Lp6Fvl1lcRIujv9LtHFdbhkXO7/J2tVCEoqa/4KARFyU2v2U5l3IDVNl2QaJ09QgcPVIJEoz4415F3alBLNZlFqHDoyJ4ZoNElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRBIUL8HYBBgY7dPDg/KJS2cRtT0FGIj10umftuEewY=;
 b=dlNMiczCnhNH55CJayHE9BVjbLPsXwxHp6FKtKIW1/l4vjkZvBmKowSlzeadkk9M1H03Cn5bBcgHDeCq1ggi7O0EP0VGFLlC4qeNSD+bBqcqRHKV9OqcRdylFhm17HSvP4Dbx5vlPCgy1Fnu3gXmHyI6PtF4B571ZpKULwzDoBk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7262.namprd04.prod.outlook.com (2603:10b6:a03:292::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sun, 11 Apr
 2021 22:05:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Sun, 11 Apr 2021
 22:05:17 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "amit.engel@dell.com" <amit.engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: do not ignore error_location FFFFh
 (NVMET_NO_ERROR_LOC) on nvmet_set_error
Thread-Topic: [PATCH] nvmet: do not ignore error_location FFFFh
 (NVMET_NO_ERROR_LOC) on nvmet_set_error
Thread-Index: AQHXLqzNlz18p4VjL0GH+D6C8JD+hQ==
Date: Sun, 11 Apr 2021 22:05:17 +0000
Message-ID: <BYAPR04MB4965E8355D001DBEF7FBC5AD86719@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210411081831.15100-1-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6cd7848-85a9-4f08-c9b3-08d8fd35e465
x-ms-traffictypediagnostic: SJ0PR04MB7262:
x-microsoft-antispam-prvs: <SJ0PR04MB7262BA40B8F267759BF2252F86719@SJ0PR04MB7262.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnDFiliUzw+NNuxpFgzcGGTybEjsm5QIk5QHAvDxCZJZtpfvSYfdTpEi5yMgRzbynq7ywWfsaBvFLtPvnVO0M48Drko3neD7Xd0teFlRnDnt9XYjvD/bGHMo4ddMaMk9IUA5h3yDprClDU+JxUR78z22hdJP+wAZ8SlLN8VbMFLi/qZx0qBufR5NhDIKJCGmBDbT5sONAMVZzXMGhrUo+q3T/vXm6WGRX2h8CQeaCQncn3B+kuTmK5rESpoeX6BGlxVDsTE9fAdJVIqq+Sd5u/B1QvWPb0F29jU/NUWholHeZitPvS8TCuYXbOENRDDAYsZTfknLK4QCzMPtXuy3fZfHwdKsAVYFhDz7e/QocEsS37+6C3E8UloGuZsRfHAmtAd7XjjABbfdQAbc01zxXCPK4J4AC5oGoLyw2jtoKsGgRveq07e4TOG61YHUnA2S/cO7J/EgOEVtDyoRJ/VbL8/OIcB4/7giEDdCdCLDuoY92JAUu61Nhknv22smYNnr7L2rvhK9/Ghvjxx/IJnm+dy3HOW9M52ulA/EMyPip+cbe+dSyA1B1ydFooFnFy+kOeuicdI0M1UErWQrSRmP76fT1KGRXnyqE+tOx4msw94=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(186003)(478600001)(26005)(2906002)(316002)(53546011)(8936002)(38100700002)(9686003)(55016002)(83380400001)(86362001)(8676002)(66476007)(64756008)(66556008)(52536014)(66946007)(4744005)(7696005)(76116006)(5660300002)(66446008)(110136005)(6506007)(71200400001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yAEFqSwGzPFfWCu8JF0gowI67C6ZEavASnv/9Gge1XLqAhQrNnOZPgDinJq8?=
 =?us-ascii?Q?6ZegdiXHlTDiltmsNejGcmFiP3JfUudiBFdBzIiXmFdogJZfq9FRj5NDHRD+?=
 =?us-ascii?Q?BScSW8dXsYQFXtTLAyL55ugwKn0+Fa6jkpfqMm3CW+Ub7mSiY7bruVm2zY/O?=
 =?us-ascii?Q?Z00jZ79mfLZVIVNVGPCCobWeRjzeia5n4KKjXc4ofA+eCTIJrFlZYbDRthof?=
 =?us-ascii?Q?3T0ZJSVusrx32LWSNMfjax8b6wdkSFtOWpRdRr+Rb76TElZxiphfqU0Rzn8r?=
 =?us-ascii?Q?ktW6Y/ZgaRYqXGrEKG3sjsydc70rTsrdViB+anStuIrN8sP4lBZW/5q54a2S?=
 =?us-ascii?Q?ffk5lAkHh6QO5efZMamUi/pDblT5OC2ARK8UhkH3q/xxqfV4ycEG+ce3fK/Q?=
 =?us-ascii?Q?Mo6yoyOjqb24of2Nm6YATE8gqQLL/XZ37yfhQBhCHrfwl/aBMvwZuUyB3UnC?=
 =?us-ascii?Q?WMasflP2Nr41fyTi89z9FmISqyCxoHdVaNWebse/qjFGGf4lK0P1b4X2dJrc?=
 =?us-ascii?Q?pMidbTwrCdsFQpezmX+LPv5DWNzII3Toj829GUaKfn9XhosqUDb24cD7T+6+?=
 =?us-ascii?Q?S+Ji+cwwdne5VKE8UfumykOQQSnpLjxb7wjMHCDzyIu0RoMi/bTAkEPBI1sO?=
 =?us-ascii?Q?M1hU65Jv9IXawm/dRMMizm/3+NVyxMUFEsWRIug1iNm04c8vvxWTM0kwb/E3?=
 =?us-ascii?Q?6mIQXYEeohC09QMdiVERGVLCEV9xUo8f4MeNe8yV+3PaiZbT5DKaqL5Q55i1?=
 =?us-ascii?Q?j0a2I62x0LHJbI6oHubrVKFMP/YeAGdfJokvDsB7sM137j6EcDHSPuMK2bsz?=
 =?us-ascii?Q?favrXLntMI84s459IUgtXmcUZKmKcykAMw8oSP4Ibw/a2p2t3dVZVaAfDFxh?=
 =?us-ascii?Q?qzHwRpfs05x3PrjX8ESHW+Yug0kobE7OhYsZ47OjsAORxmHxx1ee9uEoAszT?=
 =?us-ascii?Q?+qXIKA6e3NFrlQ9B0w2dN4wePj0BW8e874ttx5ehSYhQKFjwaXHL/YkVQYNU?=
 =?us-ascii?Q?9cOO7Ij9FmTjZipXY1p9AxSSOca7NfiRrj965yGM+7h6NZIGehH+jUtPCU04?=
 =?us-ascii?Q?s0NnyN+XlWnkKG7xJyhaMJMjKNoS1vb0aG332BFApjLS2ZQVsXs9rblOzRVj?=
 =?us-ascii?Q?6mCXrvXNhqtslh/8IcYvYE54qIv+y5lScKrZM29v4AMKJIHcu3He9t9F15Pr?=
 =?us-ascii?Q?5B2sETqRKtcQYSF/PA6SVfEvOhDBglZFeG/S28fBp6Z2UHLF+Ss3FBW7/7+L?=
 =?us-ascii?Q?i1i+3ii1bP2BCVA/0Mrz6X25ssNKzGKRBsbpinXiJTKzMPCmDWlq1CZCmTCw?=
 =?us-ascii?Q?t8fFJp56qilO9sddo38Zt9jF?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6cd7848-85a9-4f08-c9b3-08d8fd35e465
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 22:05:17.7456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7fAjQrRnvUbfLDeKXd/OsLQaytYCuIZj2cy4wwCJnPwyHIdBi/CcLWxCIO5Lc1wQs9GLLkpqs4tDhzNCxLOSkSna56Y5FZfbCocCkMKn8aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7262
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210411_150522_189619_424B1D9D 
X-CRM114-Status: GOOD (  13.43  )
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

On 4/11/21 01:29, amit.engel@dell.com wrote:
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index f4cc32674edd..2506f8de2e8b 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -689,8 +689,10 @@ static u16 nvmet_write_protect_flush_sync(struct nvmet_req *req)
>  	else
>  		status = nvmet_bdev_flush(req);
>  
> -	if (status)
> +	if (status) {
>  		pr_err("write protect flush failed nsid: %u\n", req->ns->nsid);
> +		req->error_loc = offsetof(struct nvme_common_command, cdw11);
> +	}
>  	return status;
>  }
>  

Do you have an application level use case to recording the internal errors
for target ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
