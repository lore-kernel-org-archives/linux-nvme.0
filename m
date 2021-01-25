Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEA2C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 08:17:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AB622C9C
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 08:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AB622C9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gt497MtgrGa0wXBSXRqJbK3Pc8NJ97HBiY11WZcXEEQ=; b=h73Da2X63LDvOxRNDXd+PndWW
	UyD2yiPJZV28EjD/tWZ1WZjp9P7ezmaYXfjOPUC5wH7CjcGTu4QdVPZJoCluWpqF8K0P0wfi0DQZN
	eMTEl0yueh5nADXIA1lA4r3LGjO1cnlCn31ec+G4m0gjirMdpZZGBSEtNOkvstn7i+Nkvp9r4kbkF
	D5rWvY3mIBrJYGJ20qsU0942QlgU70nR02ddpXClsnFprtU3RFjbsZ4163tzUYL5hMACxhfkpWdCv
	rJNvYDFsPOlLDZ8pIZhC7h07X6hJ8Pn3mjO/t3GPhayRC9B7YepBj6m8QOnUVMfJD4zkHd67eaPpg
	iC3qipfrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l3x3a-0000L7-2P; Mon, 25 Jan 2021 08:17:06 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3x3V-0000KV-Bd
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 08:17:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611562621; x=1643098621;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=D3qK04kQb2Y0cHpGeao8pYoD+UHba8NOzBj9mkGou3k=;
 b=URlkWnSwjsGQ931ZgobfAwn50IyQzwUNFw3ISMJ9swGbVQUNjdObtPCy
 yyhOLbZ+uzz3HsxidqcmsRn2ordH6C4vNqaxOiU7UfUIjGRRNMuV139Jj
 zJgyonGPmAv0N5WwS9tblC/PzWOwJ6h1HCD3OCFv9pj4RkrbEE1lJvPQW
 WKyCnui8NXT+F0YlwRjj0cSDgRMAb+7F7RY18+Kr8um7LoTF5doVZPlxV
 Tt1CxtYzZ6fGKhaqnjgh8XvT5Psaon1BV0SEx8IxPu1oTUih4FS93lNHd
 QB+bZwXiK+DWVgkKWyOreyfm1ljCd7Zy7I7GgD1yRx126IKZdYv+m2yiU A==;
IronPort-SDR: xAACVGmVHXGS6Ms2IjjlLq2QDi3vBreXum8uRCV72aEjSZvdVSpXO9T2gP2qHtB1LOXDsSjzZT
 gvDgtU/U8liGxYk2QIQ0qBmO+betjoGNKgRQQ+g4haIHU1BO/IKPi94hALpg0jAvY8EQ3axRDH
 gc2ao1+0T4F21Z94AD0HR1F8bZD79E20JbvrVbrCujymPqBvOeLOnDSunNqGukBlWp2Q9fF1Je
 Cjyia/Ms1lKL7Xy90Lc/OznoMmvwrb47nSIquqGoCfHQy94fLlN/HjDZjgWnEhgMlnhylUWQxl
 y9s=
X-IronPort-AV: E=Sophos;i="5.79,372,1602518400"; d="scan'208";a="162678897"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2021 16:16:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIhfeOt8V9OTFamPW+5X5xV+7Hfjxcp0UeRj9O29iNP79OkxF0TnR3I9F3mi6SJFqEynmyd6PkvhPhIZrIizegx0CwewtAHQpMkDqMYuJ0rL5WbbRjA4Xu8MyD65QBz30FZTW1Vfef/0QThEV+dMoqaNE4AcSf5uUdKUV2agW7oWBBFjxf/O5mtEXkvdFsZp+3/aEgMAcIo0kuCSYJyhpar4QZYaDvRbxm+JQUz3r9bcKi8oKcXHJvsIIPY5W2Kte3tU0F+iNVvpeLbn5FvSGtP7Tk6W37VYZzdFMmi01ogUJ7w7glHZWz/zY+qRz23KkE8wikWD6LdRRCmw2XhcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/R8D5POos4OwlZOgfhnNlTfIZQUjtWaYbRElFF4Rno=;
 b=e+BXQzifHjaD+5Zm8SIja+sza6OsA2FUBpCInRP0dR9FxN5oeGdSaKv1HSE6IhuVGeGTo55Ngpp3gc9gCT99ZCS16A1+XvnUQlncyWJvB46RgHSrRxjNaX+yiZpP1RWqFwxijcyaP4neL3gqf0luTP+Feju593IU4MhfmKysDQw+H6wWjEqDuRNA2e85n8lWu1sUOke6jZjpSSRmb0vhIfeVz4X7X0mQJJr/wlsGBESGHgfZ9XA0lE3F3AJyLJaleqOESrMvylsIny82zhqeukonxxB4Q9DKB1MMkhKEC9MtzsK/9SRF0iKcHJq4t8QIhyZCkZLqWQYheR+NV3Ucig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/R8D5POos4OwlZOgfhnNlTfIZQUjtWaYbRElFF4Rno=;
 b=SC79JuiNVX++38HohcDob/L6p6ER9zRkpKuJ0jS1RdW7N3vJfYF4p2SyTUlZ4bboqyC/+nLsNb5UPwHUA1VTzPTIjILVlSDujpCiSiXZX1P2uFz8HsMzhEakT4mesc7ogXoXrdh312dZH7ZEazabddOU39fEU0G4aAC3NTlfKFw=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB3995.namprd04.prod.outlook.com (2603:10b6:5:af::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12; Mon, 25 Jan 2021 08:16:56 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::11d3:8b30:e11f:87e5]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::11d3:8b30:e11f:87e5%9]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 08:16:56 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Bradley Chapman <chapman6235@comcast.net>
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
Thread-Topic: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow; 
 use-after-free.
Thread-Index: AQHW7/M76C/jHanXd06518y48t9PXA==
Date: Mon, 25 Jan 2021 08:16:55 +0000
Message-ID: <20210125081654.GA226984@localhost.localdomain>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <c48abecf-8e4f-b76a-c751-1a0d239c99b3@comcast.net>
 <BYAPR04MB4965404638B4C43DBA577D1686A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965342B52D5C3C6D8A7892D86A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <23f49172-5d0e-618a-199d-d568f695dc30@comcast.net>
In-Reply-To: <23f49172-5d0e-618a-199d-d568f695dc30@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: comcast.net; dkim=none (message not signed)
 header.d=none;comcast.net; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 660c54f6-60ea-4140-de08-08d8c1099487
x-ms-traffictypediagnostic: DM6PR04MB3995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB399598D5349E227C3526356AF2BD9@DM6PR04MB3995.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2s/ILwMY+jY7D1LzCG3lQH+0l6IzEK5fOBrUhJMiGYVPzi9BjF7BG9NYAlOZ3f8591oJADOOu0b7E0deYFJNtZdGoj0G4P0gY2wbE8skdY3CvJqaEs413WlQM8zywpv3tcAnesq4p+2WEQaesAQx5RRYiL4QR/U8gJISFMKw3zXbezkT75pVOas6xrkk2h9EGyw530LRqWQwZd69e20C2Pq/io6/PlcAtvqcTHnW757HXKG9+0zdIyGFK3fjbfArLdwU9Llva9+izTAy90b6oggHJifYipRRIkEB0w3dXl90i02PPH9ZtKbUBztspRS3SQuav7vrwyK+UOMPwam5z94WQqS4TH2YMb+nEGsWWla+943FF0195pksiFDxNKQgSsINJA0TFsTbuBRN6ZFgcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(186003)(9686003)(6512007)(33656002)(64756008)(5660300002)(8676002)(6506007)(6916009)(71200400001)(83380400001)(2906002)(66476007)(66446008)(1076003)(4326008)(66556008)(316002)(76116006)(91956017)(54906003)(478600001)(6486002)(86362001)(26005)(8936002)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uHpJCVlh8XBIx5+6KeIKBZwMUSVqg7iUxk0c0Pt1Y00LeBh4X2VFcPR1aq7v?=
 =?us-ascii?Q?lpoh9xv/dQZZMPDGX+JqXcmTsCURmLr1/Has27L2VBmuLFTFs/E5y20uMGRl?=
 =?us-ascii?Q?RyZfpuurRyNBEzrg3jqoqk9gpKAG60TanE8PrIjZ7q0GHGLlM1I/TDb48Qq1?=
 =?us-ascii?Q?yI7/NuxMihU5NZq1lwROUZ9aeCNFtUiwwOpcE/2TUMN1X22InmLqkS5g5Xhg?=
 =?us-ascii?Q?hMegphQQQncp1soKccLWY3+yQhz2fTNBFotzJZ5zUCLWbUsCxRRS4iy1wl/m?=
 =?us-ascii?Q?kNmxhF0j1rkA7QNAisMpBjVdd4wxmrQevapqkBNi6O9qixw7gDLi4RG/+dbZ?=
 =?us-ascii?Q?G2C+MfGd8Z4CzG5szJkDTNwbdbO6XaD9eB4kvFwtuIFAJdscXx9H+oPwkN/2?=
 =?us-ascii?Q?NwaLhxNYWBeYp64lHzFKOQQOsecNNZs4Hmw1CnWg0Tuhrzx0gvhrXMMSbT6k?=
 =?us-ascii?Q?lnYW1YaMYhTIo7hByNPvf/3hZ9q2khxpQo0aqh1qZnVuEOQnC0BEj0m53xGk?=
 =?us-ascii?Q?5piE+VH8KYxTzI9S254jK4rKBI+Y4XB0fc+ux0kI4+k4sKs6Rx62Lianwrqb?=
 =?us-ascii?Q?anuYaiK0VujI9zh63cqtfrlawCX7ySbfYi+38RgyfT3TLRvJNPvyOeHYuWLV?=
 =?us-ascii?Q?1PhrhnZx/4vGCn/1TZB/Mmu6WDts80cRe7nd74IS77w40BzBlfV/eAy6c5xW?=
 =?us-ascii?Q?V08TQ18+77PsdHX+5bL3A0Hg9zDAsUdMU4ulXjuj9u8LtCrbGVw2M4giw0gu?=
 =?us-ascii?Q?s4aXPxNtLPzqPqYhXjIpsWo+BIAvHZ96HhpLe0e+Uzy2LzWpnOj8sgBANiQn?=
 =?us-ascii?Q?kkYMUcon5o1jQgNFc6Eh1RxcUKGJlXsMsTuzqYYWwaQdF4JN043w4o5U4mys?=
 =?us-ascii?Q?SqxSBGuqT+Cp5Lz+KJTQdIie/Fpn8OMqjv1OhkGhY7aaWyWp0fdNwFjtT3KO?=
 =?us-ascii?Q?aTUh3obmok+ubdTbOUM3VRq483mtvTBNJStnbzRN5w9MeUNwfygnavCQTkTC?=
 =?us-ascii?Q?bVza?=
Content-ID: <B1FCDFD881FEAF4A812635EC31229735@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660c54f6-60ea-4140-de08-08d8c1099487
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 08:16:56.2504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9bYCrgBmOZ9qbSfNmyLNHEfHEOGFHwGGFPrmTYlsknuKhSi3KtpcMaM0HXW02X022xA5DHMDiOeqvWcuWtx/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3995
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_031701_724109_5CDDE28F 
X-CRM114-Status: GOOD (  17.50  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 22, 2021 at 07:54:26PM -0500, Bradley Chapman wrote:
> With the following patch applied to the NVMe tree, my system hard-locked and
> would not respond to Alt+SysRQ once I mounted the filesystem and attempted a
> directory listing of the root of the filesystem.
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 25456d02eddb..7ba5e8e92e19 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3228,6 +3228,8 @@ static const struct pci_device_id nvme_id_table[] = {
>                 .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>         { PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
>                 .driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> +       { PCI_DEVICE(0x1d97, 0x2263),   /*  SPCC */
> +               .driver_data = NVME_QUIRK_SINGLE_VECTOR },
>         { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
>                 .driver_data = NVME_QUIRK_SINGLE_VECTOR },
>         { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
> 

Hello Bradley,

Chaitanya asked you to test the NVME_QUIRK_DISABLE_WRITE_ZEROES quirk.
Your patch seems to instead use the NVME_QUIRK_SINGLE_VECTOR quirk.

Did you try the NVME_QUIRK_DISABLE_WRITE_ZEROES quirk?


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
