Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F187C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 03:20:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47E361246
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 03:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47E361246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=okqGEZJlgUwGovell+slSdfhmqs1SdlEyCZkRr6/08A=; b=h6GIr4pwgSA7k23ME/+u4iRaE
	tUdE8mw9aHpJWMVeH9eaweHHHh00vGH9jyGcB5e5nHcWlaFTiDpvwLKIem1AylAjk0+fLvBlJ/J2q
	p1bP9mVON95m/nfBDNFK083IkbScWcDBV++1e9OsMnF8gOIhu0QEj2hMNxAFpDKhAW7wbZnqv3qAa
	Bw1O7DeZEpo33HFm3cXX7jgWSzqS9S+FJBkiipY4h8MmGxBkYljSEIW/Ho3Sb6OPZ+eblPjfPqBOQ
	PaWuY93mp2Z43fD6OO/TLHmY5hqz7H3WA8bLQq1mQxd9zWV5OXt/xpQ0AwKsifIFxYGz+x5jvc8et
	ogZcJsxgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lW9at-0089Aw-WF; Tue, 13 Apr 2021 03:20:05 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lW9ao-00899E-AO
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 03:19:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=OnZsMb/PLqfZ/pvFat2xBa/0v/Iqd0fdRzIKVI+6ONI=; b=hKl1ojeGF4+39djDleTld2mfv4
 +c70+PiCPvueIyQekaVH1/nbLrcUOqmaF9BtfvNNQDxhkVjuZIK8A5I43t+7KYxvUaTQ1KVdGH2Ff
 SEeJjEUvkG6X895J/3i3vVx7tsYRJjlUYn8Y15+roCdYOUBAeND02R8y6Vip/abd5ayt3jV78qWuX
 z3yaadvy8emtq9x5+Q8vGUSQotuXVA0t/hM5TiP8Abo9EM9lF4zJfdhcDmfN5clSB318xp8+osDmS
 D0yICvretIxF4V0RETY/Oe5+NkiUaoBS1IcrK5m+n+EzET64r5R+uc2Ukq3ctGlUbpWX0WpYSR/3v
 9X3B8nzg==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lW9ak-006hFM-SP
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 03:19:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618283994; x=1649819994;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xEv6jylqg+L2xyLUIochLQj9i8LYwryAhOAuR7S8zqA=;
 b=inqEQAPF38yXYRVbC5Bi8nbFvie7/GTB1cNkfhp932v4vp6OJv6N5PzV
 4dYXSCmqN7ZTEMz58q8ulKh98+f6i5eNbWT6ryV+93eBjCt2Benl5j5Ex
 rrzAFSt5zcgXdfyILW4h8WX4jhajS5GhelXbYZoRJlYd1YG6/gPSFpNFp
 7EzAF5DDx6n9P4RpciJlPooKL/E/hhIUuv8QA4NaezmuauggZ26xxlC4U
 /Byo0VLmArLqi0/TYp4hc7x3JXdIoejygL/jOEOqmH7YZlZulN6RaC9ji
 rKFUkhLbxMoNfxRAMhVTffOUoi4XvqUPyYLbHaRriCCiJzyinuWl1XUav A==;
IronPort-SDR: TjZ/tBVVFYnBj9RZ/XR3OG+2Vs/Cvl5NBMoADmReGLY1qKU0CXC1GFJcwE6gTWzaJQ74L/4kMY
 STDiLe/Qaqx9AJ2hdOCGt4FbdgjMnO2uAHkjvqXWajhJHx/tzE/OIROJPryI+0eoKMYP3PkSC2
 qR9vs2zKRxAbXbzHi6EDpsWuLkFg4Nmgpx8mgtsZPWzJaqkQj6QDPEXIoFQIJihkOgMgV4yisw
 OV1yOYwmFF7sBrYI8hXK+Yyazq8U7RXY+MF0ibB+1acv9wJEwSDistb7XtGx9jMHeY6zFSygqn
 C54=
X-IronPort-AV: E=Sophos;i="5.82,218,1613404800"; d="scan'208";a="275483460"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 13 Apr 2021 11:19:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPCE6YUbryZhOcOSnPMCHmU9Hq1Z3izb/XmLAPrPTemY1rC1VwDoBYZd6uePMqvxueaaiLpAWP9CXIIkezqRWXOtIgFNYXjZU0nhNNMOM0hIWmDDhuKt42emaYkGCIboBeMzg79TFnIofPPtHgx/p2RtfLkpfkuJaYNLU2NiuATSKX5SIeYp8OwDFx2Rr78jCLj6iHlyX5XtUEi22z5bqpKLJ3RlnmFxkFqraOVuTybMF0h5xUuHGNu9nCE3JvoCER71Pj8QxRXMyiuQB8aVkOdismZQsMRsaoJc3TbzQEyTn5J6qNBtbyGgCTXTtqndiwxCaPTECj38ASI1sWqmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnZsMb/PLqfZ/pvFat2xBa/0v/Iqd0fdRzIKVI+6ONI=;
 b=Zi0E3MvFbu7PxUrckygkom0EteM1JqoDA+SmVfPQdkqOLSLsg2rDicY4IM2APovq7knBoJKATJstvxP9m8Lg2AiW/6xpdIyw7lZiSn2O5PBtRHhLuWkyRfuqWW/vOdEtG8G+mB0HHl2ML0tVmNTDQXpO3NZppxEImRmQlqp8dS3rORr1ntVxNmUZe1gjo6gWKksMElnOjtMuT/EAhv/GflVLb2uLiZ0uAljqfxMhK8EUrFEnjS+3I4QnDcogV3JoZAfbuGV/rxYoO/o+phKw2+QWB3YhRqC9s3sw359OqM0BrEPJordGKrZME9Ga17MYoHIJm+FxXvZFNBXCrONa3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnZsMb/PLqfZ/pvFat2xBa/0v/Iqd0fdRzIKVI+6ONI=;
 b=oZ5F+7S5tnot0o1r7NtOx8Mfz/oLd7A+MJFhVsyVno0It7cPkixtG3nqa2co51GOXl62XZXN8COYbgg7ZGz/7P+fHC/S/r3g/SELs8LIav/WXWlheHdJdmYezLyq/w+L6ACHze7YY65SfEaJDxrr7yylPMyBkAZwfYua/+AZPVI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 03:19:50 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 03:19:50 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Yuanyuan Zhong <yzhong@purestorage.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "cachen@purestorage.com" <cachen@purestorage.com>
Subject: Re: [PATCH] nvme-core: initialize status to NVME_SC_HOST_PATH_ERROR
Thread-Topic: [PATCH] nvme-core: initialize status to NVME_SC_HOST_PATH_ERROR
Thread-Index: AQHXL/dWjQWKnrXNmUq5ZNDUJ+22uQ==
Date: Tue, 13 Apr 2021 03:19:50 +0000
Message-ID: <BYAPR04MB49656BC34E2C7AA4E3324DF2864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210412234543.19913-1-yzhong@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: purestorage.com; dkim=none (message not signed)
 header.d=none;purestorage.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42613ed3-65ba-4290-e086-08d8fe2aff9f
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124C1EAA2A8F1D0BDBDFB6D864F9@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14ELIGpsajhhMKenf4BWkjrY/hL+VaVTFXiTN1Fogxx+sNqC8JXGE+fWB2QaYmYp1mHWMO90YnN/j48rbmkzn1UpXTSDEUZu65ytBYITaEztTbeBGQi9ILbtZ29DOUcLH4ejnx+izna6OPDNkZg0LS1Uo8ksTJFn22ffJqL2Kl+l7KbZNol7DBgY3jNZVeppdzOyY/O32oO+/pEyFzyPbTYYawrjg8yhZmkrF3e0F0G3R2FKxkKLKqcJIOVWQoQDG/MnkaoqL8R5UJWte+S5Ad3BsCH/+ngI9NNuJLuitLQRj0+45Z9WOH5cCnUCWWCoKxS1DCRtoXAz/KaRVQOK+g//iTTDQ72Y3/P86yjEgenM2Jf+8QpVYfCGYjqOsHLPTdOHWevoBB0idaisJtPCThjOLsUZRVNTFGhiiUPtbC301kJwryp/DbPYeXZvV8/Cr9bohQfJoLXMpbM5oraIvjhFTuh43d3X3IipwbnZOK0L4OsGWzitOt0SUNWpyZhuJvuPMDWSsDAETVdD8lLH9fXfTBL7KT6cz1BpC4F+8T3Yt/3buB8iDZ9o3/rKXhpUrU36zr7PDGmKpnqdYZ7MqdPocK8EUrnNvENEjQL7a+A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(33656002)(9686003)(7696005)(86362001)(54906003)(71200400001)(6916009)(8676002)(2906002)(38100700002)(8936002)(66446008)(4326008)(66556008)(5660300002)(53546011)(478600001)(186003)(76116006)(52536014)(6506007)(83380400001)(66946007)(64756008)(66476007)(55016002)(316002)(4744005)(26005)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HhVwcgJ4hNu2HD3jjLNb7PJanPxAsSBvPL+DaxpnSlaY/HB6OZGodznZvDjs?=
 =?us-ascii?Q?njLoag41SxWGugZJZ8obPwiMHL6/Zzbw0dgbd8HNbzusjiKV4xbE1GZ2DLak?=
 =?us-ascii?Q?tbJZkxfOITRdZvdvLWjNogHzEVIQGxZ4DSNuMy3U+j2hoflXCHenHymKdhni?=
 =?us-ascii?Q?zfhvsd9O+Vp0XnrJxuojH6LiVaVZFKPYf6XX3vJ4mCBi7o66UuRjz98tudQr?=
 =?us-ascii?Q?i5rXlHja4dw5WNArhMiPgQ2UtcLzVVh3g+mhsuYicDJdXYlrTGe2LASio4ic?=
 =?us-ascii?Q?xjZx/bbubhfO819Mh/v13oSYj/tBnlH5VvsIPo62NbJNUzbMU2XKLWSaOOl4?=
 =?us-ascii?Q?6G/7RvgnRTyjjCqMYo3fC9UVB8EWyMNd+otD4QvuhAhpVIlxqAc+rDuhOadn?=
 =?us-ascii?Q?NCF+C9tpcFgaNBHiJY3iNS1SkpvTWjbr+zL/sqGFALRvqiTdrBWcCdFJNpxO?=
 =?us-ascii?Q?VfA/o8GwOfCsUIVMmVDLRNmbyr6j39wAKsIsa0Q0zUgGCvz1f8AwmrzJBRRP?=
 =?us-ascii?Q?RVodr+Qn0aGvvx5Kvv2gmuA+J/60irmps9ysRwcoJdJiVqZHPqOQcFEXdgpL?=
 =?us-ascii?Q?kk2pgcVrgmtYxuTOKq59gy6L285Ru7mx7cRW9N/0tnC9YghQ2zMRO4BUoy74?=
 =?us-ascii?Q?dQyecmmmD+04jl/s6a57hwxlwN3w3ih7QuPERMTC3hMyFV1GOVFwydoGUouU?=
 =?us-ascii?Q?KcJEEjVFEutUD4ty+inMpeDSGLNd6bOXAyb8zuHnfsxq2KBLzrUyaCgftznp?=
 =?us-ascii?Q?ehGbpTQMBzee8+ygShPiTNxKxpM2HEBi9CpRHJ2fSVA682jSsaS7COorVjyH?=
 =?us-ascii?Q?jQhPJ1S4G+kIaBQqiS3Lx2h9OgfZgtoviP83DVE37rxns+MbKb5yBCd6b97n?=
 =?us-ascii?Q?lhIE8mXd7h1+FTDYc+V2P36vnx+9ONU+Vukw+ahbaFA8jba4txt5BqzFDd1n?=
 =?us-ascii?Q?YIrGhoOwL3I6JlT8jX3iyVFoSbazcUBFbZOk+lHH3WwI964wsiO2KqizOSm8?=
 =?us-ascii?Q?JulN3TDfpDLCcx/S2xOvLWyfgpZG7W59ZEpjyNdmDQT6Ne1fx93sOUmQk9GM?=
 =?us-ascii?Q?ndrNOaPXUtojTbar2x8vKVHixnD0CUI9g48haGoR1bS5/MmYRNjmHr6SXtdJ?=
 =?us-ascii?Q?acO8FgabXWWQPt6wgQ2c8K3Fz8hT5ZBvJbk7AQxhEp+jSkbrbo7OfDy5auFJ?=
 =?us-ascii?Q?1GCysiJzTSP5PZlUCEEkzz622dMYxdCZ2fJV9HSynH5uFj6z9YFbgmmVNWVK?=
 =?us-ascii?Q?aGCEp/Qf5vgFpSI+i09UdkFw07WlLMc9ef63BBMSv4u5KtxWJZxGzaO5HJAA?=
 =?us-ascii?Q?Vt9RhQWq0AQyPQRP0PDxW4R8?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42613ed3-65ba-4290-e086-08d8fe2aff9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 03:19:50.2035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATBLrRR/XqRZuQaKY/GsOC4nSMNIp3M2ET8tAjrcLHMjJxGOqu9UgaNnuLxV5RjLQ2B/VsBXspiOZwwa5WxdIlaXQH2p9UOQjKIWh8cgjIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_201955_029056_7752B6FE 
X-CRM114-Status: GOOD (  11.59  )
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

On 4/12/21 16:55, Yuanyuan Zhong wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0896e21642be..f22323d02755 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -580,6 +580,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
>  		nvme_req(req)->flags = 0;
>  		req->rq_flags |= RQF_DONTPREP;
>  	}
> +	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
>  }
>  

Since setting the status to the error value in not common when
clearing the request this needs a good comment why we are doing it
in nvme_clear_nvme_request().



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
