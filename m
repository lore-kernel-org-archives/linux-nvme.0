Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:05:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6955564EFD
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6955564EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=w+fCW0rlBPiIXbnapIMEgqNzsfpIeqkwhL5JG0bpCc8=; b=T+a69ezmlDXWGes3mupKVs0Yb
	0JymnlsOx7YgKJOOxuFjLmSzBpZ0SR9j4Z5f5u8XmpLWkWpyn3Ba5M5GU1pyZ2SrzWfpjS7xIAtyl
	O1zM1CNrAi0xt5QJDlA22IdrMH+JaQlgqDQVHEEgDHlMB84sRV0a2YAer8evhcqL39OMwECFRthdZ
	MCadvVDktnmbkx9MiHdq+7UGxsK+vhfAixysySSKNwVDx6zzeunedvkdEerZTf5wYYearCipq31c0
	taFSjVvZvR9sTzE/6YITn0j2nQ82S64uQGCew6cLW/TAgRog7rH0gl3HIBPv1ns1QrIqEIw9pVrPD
	E//3DoUHA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMh6B-004Dbb-KE; Thu, 18 Mar 2021 01:05:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMh5m-004DYE-8r
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 01:04:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616029490; x=1647565490;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=I+gEqJfG+3nB0r0302/kLUTfAJUUc+oi1ZNwYG/+3QE=;
 b=Z01+eDM5WTdciQIj2+fuCL6VjgdBK26ieuijHgwC9Vfxprtg6/FVYjHY
 kN/GoVbYD3M74NE7RB8hAg/4lUg4lv3jSa4SuSLpWvV8XGKVxjNhjRGiM
 xmYxGMQMoSuVtxFR2cykW/pPy5fhXZMaPcr5eWOHeboFhLMLrfZ6QTRjR
 ROlwfdTyNi7CbXVbcLxNjh3Bl6IpwkXT4ZRePgvcEhaProh3rmSwqiPFl
 VVXWK1calypDq+VDsm82TfgUXPdB9XVoa3dC8jZ3XgRR94cmDdAcP/hVf
 iDVuwX8JOM5ESx98ha34GXGwh9VtItvABoYx11qocezU6eKOlykFP69a6 w==;
IronPort-SDR: kfZUvN9pli92lzAkJ2OqV9s/l3xi68BVX2yseDQQ9I5c0ZRK1Uvm6XP6DSqGdFM8l4T+AWmxoc
 lPgdYX8wybB0ssO+NqRBzNzmf34MEtTw0pUqsjRlnWWK5eAGCJKVccrHzCX/XAEYqDurWbtkFs
 1biNjUyzSGRFp6DNrt+OXq+HCR2hJN3L+JGhucQ43/ydEuM/CZd/nRNvj54Ihj0Ui8vcgxMim9
 WrMjFX0jcPsJYO5b1HPl2lyLy+PQcySlWrNCeIAw5h1qDSqfTTckLb2OPr+FfUU2PZmXr7Pzc7
 38A=
X-IronPort-AV: E=Sophos;i="5.81,257,1610380800"; d="scan'208";a="163551227"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 09:04:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RocPY2ceKSEtZlVRQqZPOe7fL4DW578E4gaiKMc0QQbkDGqsZ0eUf40qssVpkhZsMzsZfxmU3xhIW8e87/v2naA4zbWq8XzvJkAb+RsmGLKLMFbyLPBXRWWACtp9X0zTLPAx761cBfX0Gyhb4rENUrf6/F1du2TDJMiKHEw5RNmZZ4o2tVsUB+60Hb2qJ0+NHaSfFxtSsZwYgmsfB0XI5dyZ3VGNtj2eSAvrNAY5+sIbFr54QeQTxGvztHHdI/GMOgIclUbqMH83uwWEcVZ+c9iyfYOfCuA47KMH2NUwXs4qqJZifT7CupSHtejf4AwHNbgSlSK+dlicvIG5qj1vHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+gEqJfG+3nB0r0302/kLUTfAJUUc+oi1ZNwYG/+3QE=;
 b=KYsMiZuigpzezq0I2n+MfA+qARbJ2i7W/7F/UeGFFk6hWgsBJDtbRpj340Ey+IxULSY/tarN+wNeGCTnGmFiWZuaKom0zBPi2CiHtrvBhfLy0oT2mqW84pNGCHEVY8aq7eBfNZ4pgpsURjR/ZxSvjVKDulyNc9AwtZ5FZ8Ix7y8OpDx3rBIXC5hm07L/VznoL723Gqu1GlONDtiA+zikHHYcs9I1M1wTBBNINE13+fa/wivlqOo6S6eJ4c1z3ReuWVY11oUq2T+aMRrCIq6Vtp0UIXRNCwxTRa6k8eu7bccoZbEiIbNfsCTH0K4T62Vyo4smI9cG1SC2VnwGP0z5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+gEqJfG+3nB0r0302/kLUTfAJUUc+oi1ZNwYG/+3QE=;
 b=J4C3XoFf30TfT9h//D9MdJsDUBIgJ/joltezCKsrOXWMRyTFBJB1JueQSQglDkkRBRYHMYQuqHP1iaTaAROUyV++wyiM0me21hxSE/2ehbs3O0J2gLrp2c9XoA2bfMm7/W6btnVqArGk882c7Wfz84O5uwL9hJ7D99CW5AhagxI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5686.namprd04.prod.outlook.com (2603:10b6:a03:103::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 01:04:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 01:04:42 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: warn of unhandled effects only once
Thread-Topic: [PATCH] nvme: warn of unhandled effects only once
Thread-Index: AQHXG3DFuhwuSMmCHEKcP5EmZsABBQ==
Date: Thu, 18 Mar 2021 01:04:42 +0000
Message-ID: <BYAPR04MB496549AA51EB81EE75DF077886699@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210317203341.17315-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a61fe3c1-401b-4173-af97-08d8e9a9d03e
x-ms-traffictypediagnostic: BYAPR04MB5686:
x-microsoft-antispam-prvs: <BYAPR04MB5686D2895045A0786C4F171F86699@BYAPR04MB5686.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+rjAG6YSl7FdkVO9+NLBeI3fu22wnfQfOOLpOtVtcyn3HYTWSKCBjmVyWClvaDGOToSo6BegDdZ8S1gSjPZj4TF8c5SAtslgGcgbNYCzbm2cd6InIohD2Ya2EWmXx9ZXOnyxUKMOeNueASSKJxZZa4LELfvrn6p7SLZA4Nk1kadn6gtHp0vWTKeROCT4SdJprGow9sXBA2XhhCwqAQmZaQq/1nOhXdUT4psA+hJ4ZphMhZw2qd2O2kpu/p2sP7Fgo0JLe3BSx5/bo9HLE/SQIbW122LiZE4XH6SYkGQUT2CN1LV8J3VTRSvZ17CySwobdztezpJjURil2GldQYJdJObaETqpcACHezrPs/XQHwRmV1VN7gXiEGGpEJUW9N4LAGIZQKaHP1YPsLqG/QButdVsR0i1xOIP5mHwH1PD8iOxR0E5kfKX3qbzlzV5ipnPLSPxZP94B90HkpbmcPrvaoo+GUTm2GGbLePebdCAjGpUpO54RdjUn5ZQHNYIZlxhKKGa7yUsfGReKSqBInz3eqBamfpwrAcLKu7OQQLxPQycBEBVRbq2WMYfiD1BRqF40x0Xh1e1fxl4hw8Qm5AqdiI6PCN/tfQBJAe4HqwlRE2/VL0VQvuTi3tz7O+19WC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(66946007)(66446008)(66476007)(9686003)(54906003)(8936002)(558084003)(4326008)(52536014)(38100700001)(64756008)(86362001)(478600001)(26005)(186003)(6916009)(316002)(55016002)(8676002)(91956017)(5660300002)(7696005)(2906002)(6506007)(66556008)(71200400001)(83380400001)(53546011)(33656002)(76116006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/Ql5rbROThZDR5YkodCehKApxl3Aalg5vVnuqkKQOmAXLk2glatVWwMlinpE?=
 =?us-ascii?Q?GoZaBx8PaO7A9CzTs02w7jpa/3lnohlpx3m6iVA/1n4/G1Sz4g1HXiu6uYuw?=
 =?us-ascii?Q?g/iF/XsMjnoFuPIBVHSbM+YWuA162cQOVEZEgQoM4woYCLHYHknMyyFbN2OO?=
 =?us-ascii?Q?hTCVvAceyWJDX1evvbBb7lPzyYzcHT2F4/kya1TQFAYaRSglecpCZ26B4J0K?=
 =?us-ascii?Q?qyPUylv7iKm00dQLY+hFgeHTQUnTR1pJHBHXJdSFr4uwQSISUgL4towZAuOg?=
 =?us-ascii?Q?cO/YlNHvkWA7oYt9rGTzUPRiW3E0NccMQVV08TEoBjf0p00jMVFj5q2CMPLn?=
 =?us-ascii?Q?u+6mWTYr/pGRQ6Sa4ajj1K3xB0KQCs29poj+huYCm44I4voZdwXMe8xfvAmg?=
 =?us-ascii?Q?IIruP3vyE1CDZjuquy3SPe7U+K9AK/4sC+Z9tRg4gw9EfqYc4ZS4UhVdaLyK?=
 =?us-ascii?Q?cm6U/eGAWSeUWfPsCdODD9AjV3ZXySpA52J4tcWrHLz2BECtcX5be1iMRTs6?=
 =?us-ascii?Q?dSfprdYkDM8XZxVjnrHdESmeFonkNR40q2+04+DGkiaEM2KCr8MY3T/B3PWj?=
 =?us-ascii?Q?AQLbuowMepMxhyI1hqubpR+/aH/7KSxSubV8oE8ZonaWZxhaD+WOWRCFLelo?=
 =?us-ascii?Q?nDt68jE8JpqZCx9I593PqHcwjtSZ5rawf+WiL7cTmEi7k4QgBcxhBRKa2U0Q?=
 =?us-ascii?Q?yej+XXfeYU3SOdzTPBVIYvYHlOIBURMPuXl+wJpK18qNlZpAFQ5DqPZd+em+?=
 =?us-ascii?Q?lhf/wtQcDJNSCrR+6ONoQ5NEji3yRaXc8ncHCHi5s3LH/A0D/h5oQBVXn3+N?=
 =?us-ascii?Q?fT07VNdoAkptDLbE9OrjwC3p9+cby3d+nEja9a1SZpdr/f4+bYHAdH+LpLkV?=
 =?us-ascii?Q?L3kBsaBIFS+PXFppnblHiRw5VMoSSTCpM0ovRxz4MQz5+8UsgXt5Yy+v/mmS?=
 =?us-ascii?Q?YE3upoMoYRPS+J8FBnYMi/80ONRq9y/6/NRrTA289hWUJolCWsHXqpbs/o5I?=
 =?us-ascii?Q?jabAHMSVfLywFimF0v3C2Q4qakkooy4TEAwqLkjdhnHoe0YrmO3n88jizX7V?=
 =?us-ascii?Q?kSUAiuKjKuUAriFxxgdPzREVU8fO01U+mCfrccD+HpnUUl/l6IpAW0nnZUDk?=
 =?us-ascii?Q?ol+UlRQWJPuozxA+8I1oKsB9gc2RLAWTGi5IMwsowslsGkpOqDHBy8uhI8qn?=
 =?us-ascii?Q?UYMenrOvYHoZo1ycpUmGoYHALqBLgn6wF6lp9j4YaOCSDfvmEHGCRMYp1U2D?=
 =?us-ascii?Q?SY95raBdmI/dO+TEGivDDlR4zotdCnERTbrnYMq+DkGoNRm2lp5l9SwyqbnP?=
 =?us-ascii?Q?39Yikulmm8Ozvg7SJ4XCdIek?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61fe3c1-401b-4173-af97-08d8e9a9d03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 01:04:42.3427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9o1utrG/0WtzHdrd70T5ID20QvKQKozS+T3jHt7cq5dcsoT1QU9b/XQ6ts95saEw1ZWukGA8zEqUbut5f2loxSVKXSCtlVUCFPNFL585fT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5686
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_010456_005153_75987E68 
X-CRM114-Status: GOOD (  11.26  )
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

On 3/17/21 14:01, Keith Busch wrote:
> We don't need to repeatedly spam the kernel logs with the same warning
> about unhandled passthrough IO effects. Just one warning is sufficient
> to observe this condition occurs.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
