Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F0C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 07:40:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C07B610C8
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 07:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C07B610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RVFwNmd1Aqv4Du2Fz3v32jwvR8UAaCk4rjKJrE+p5XY=; b=mC92vSLjup7vXfScunEbveysJ
	Qa/28oQHlAo+rzf31G8N9dk72GfZPs6vKHFyZVml9h0m5UoQwkV7Ccn+GNcHxTck1kzy09N1n+Gia
	mnXDjcHP0ETnAFwQ+VfB9tDuuAGMhokAEG4dEN4C89YiyQwqwaZSRMrhfxVWDUmE+cnJJTluQrlM9
	GAZC9oT5/2G2yTZn05pMcyF6umSAtJQRQLSp+jN3mXg9eMMdBTHBLrBxY4TCflhJfS1JPPPiQxROZ
	3/vdXo50HJGKPhdyiVucdARMShpjTVdT/z89pnkpJxUzZwmofJuLpS/LADq22J2moeh/RFrgUp7eS
	UrF5+aVhg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWwbR-00FFKG-8N; Thu, 15 Apr 2021 07:39:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWwbN-00FFJu-74
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 07:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=6aJ1xTDrJBKtBij8iPYVAkJyL8wai2FfN2L/3NwDYwY=; b=mBSbNfjxvCdkFvHCH5DH0A1wh8
 KAk2sYZkkYYFzcdJJ6682k1agMjrUuve7a0ODxKU2uNcQR37d5x630U6RzIWgPoW/LBNCWNjp0vc2
 ARnKQHJ/dvnCBTovhje2t0LBANf3QDsJI62uUCow3bTUmSrdVcCH/eGouXHu++7U891G0iDEyw3KW
 kLLE+mw/6ldoVT8bL5n84/xfIyaem8R9lt+NvUjLvbs6wayjQK5wtX9yrtrFmsIicA4hWvKz97m9r
 ZrYLvIbRugWVIFMUKrIXH/msb/9Ey/xDauoXzNly544VrGuzMlabaEaVAX/LFSiFRYPXyTsVUcC1D
 LWBhz/WA==;
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com
 ([40.107.237.84] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWwbJ-008LiM-Vq
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 07:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CorD6TMYLFsu/5AxogHoTOo2CdN+gU2iwn3fBp+BHJUcuKpG6YFdEam0GCwh5hueZ4YG/Os9CECg3xnKMNbenjwG50gimmeNR18W/w2yuMLQKD1u7QS6+oBGcL3kFDZh4oD70s+1cUNrBaAZ4tyKZSj6TSrDP9eDvM0jbrAhJOjRIXZ+SbZhd+URttBK1wvXeKmyKx0t0IoJw8EH4uNi4twj02JTd5AEoPe+sTqEvnUWlwJNg+SuDCF3JUtfVsY1Tekti4i+XeIq8Z91Bt8z0+b2FWvsyO0aNeRwGADik6fHXlI6EqLguu1nf3z1GYUmYfeFitv4OBGF3nD1fUQObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aJ1xTDrJBKtBij8iPYVAkJyL8wai2FfN2L/3NwDYwY=;
 b=GBqxaQTE6RVJ5RhcWGDcXnxP7w8pkVDgN18Q3KVsb71awfQEzsAvwdr1/c9Oqn1NYUKxGGKb+OCCqLkZOzqd+rGSHyi0s9eGbFE/vO0JtImaKcwpCdr+IzmrpJB8R/3cKIRNISQEuaE8zAHXFeVw1v/YCa77gy5h6FCKDUCEpoWgPtkq1woVSpO0uKNQW1esGSTXUzsdZ/EM3SJ9GJ8YnyJKah4vMriNQvq/qD20yetLTCVywFp8GoSBxrjm9NjGPgn1X5JoT5vH4CVcP7FyR5ffCvD6PgkaDB5aBIUvIHaXT8CgEfTppu6cNpiLseiTAgL1CzrXIzVDzcuW7Fsa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aJ1xTDrJBKtBij8iPYVAkJyL8wai2FfN2L/3NwDYwY=;
 b=jo5UQfaBmQxNQXQa3IHoK1QpbvmkExFhZ8hq8jleY4a1e22ZfXU5adbXGBgzVPG+DQOyaJgeLhGUgjJHarA5VZ4jLrT3RrSFK7I0r2amCkcSYilUP2XLjJhg7cGGVyZyfh4aQZajwvRk55jj0Fu5j8nkoXlfsrMVlMdtVhwvXuM=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3413.namprd12.prod.outlook.com (2603:10b6:a03:ab::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Thu, 15 Apr
 2021 07:39:40 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 07:39:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH v4 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Thread-Topic: [PATCH v4 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Thread-Index: AQHXMarV7C/otTYo/0OwwvB1XryPfaq1Hh2AgAAKSgA=
Date: Thu, 15 Apr 2021 07:39:39 +0000
Message-ID: <BYAPR12MB32382A0F46F74C6E5DA1D566FB4D9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
 <1618458725-17164-2-git-send-email-Prike.Liang@amd.com>
 <YHfdWYY3QSjIM2lT@kroah.com>
In-Reply-To: <YHfdWYY3QSjIM2lT@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=18f64854-d380-49c0-a747-d5a74c8247c0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-15T07:06:49Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b8fd47b-d5c4-451d-8621-08d8ffe1a07e
x-ms-traffictypediagnostic: BYAPR12MB3413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB34137C167E39671974FD18F7FB4D9@BYAPR12MB3413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: herc2mds0pYJETSklMYii3bhQofm/htyQwkB1Wemd5x2GqzvPKoN/Pc50qlRwuOPHe/KvWfJmRT4POclzwRh4K6DRoYYCswCyzzfTXElhLrgqFokDvVqnewxlalpg7zA0npEal7ae/65VtfZA5qeMbYVCsIlHNz5LOyRPj7n24qdTiSo0P12zgqs2p0Pc5kLPC10dO1iBjgfaUcK4yRgKXPs5ov178xviHZuX6gY5Fi6DwKMNQC5Uqcv399Eej383ZkHNwNfBL6HA3ccShOn9FduWHXclG6vyPHTNxVAfya4daVtJxCDIBqW2HMX857imit+EWLrLvXA/pIhPi/b9zVGxMxLnUjNNgjQ/w6BPF16WRZH28q8wCOmLI9PwuX/bKaDd2cEZGtCpXxV/smfLpuc8Ctc6KUBzdvNaWtxsy1prNlUPdoQfsu+wgTdN07vqoZwoFlDdvZqgK+R3TPFe/nihTIdQumBIy7iKpwd/nxyH+UgwCyt3SGv9oUEPSd0up/CFFYBYjxrFJUDLYJun5DWoqWMDfryo8INkg8I14l0dxSXKW+ZA/EdHNSThZvAh9zsckuRNtZCq79T3Fv/0sF+z03l8QqXGCZ5oZ7nXSg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(83380400001)(33656002)(55016002)(6916009)(7696005)(64756008)(6506007)(2906002)(53546011)(15650500001)(26005)(54906003)(9686003)(478600001)(71200400001)(76116006)(86362001)(316002)(66476007)(66446008)(186003)(52536014)(66556008)(38100700002)(122000001)(8936002)(66946007)(4326008)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2j/j+LS1r1E2pym4nOl3/NBEG3+6C414bUNY/pxsNcvVYpxzJdwqUaYCpvqk?=
 =?us-ascii?Q?wH5Xw+RGH3xQpA6wHKBRUVT0Un2IyFpCGJez9lQeGCDGKcFUy3xlpXzU7HG9?=
 =?us-ascii?Q?M2WDOpiQzbWGAo4YkdSV0C9lRJ5aqZaQvrQS4cyvuViyGr/kNItORNQCrS1B?=
 =?us-ascii?Q?ChRJmUbyp3Lcq+UK4QvUFkgTx3MmYuMLXL+bkZAPRhukmq4mcLGX4Pifxc/q?=
 =?us-ascii?Q?M60z3KkYbbz9n1zfx+sChc5qB8pVDCbEChSREmjDutV5OP7HvXmnFkVDdv8x?=
 =?us-ascii?Q?++8tY9yMmw8c+V4YsOUhygmKSzSNhUbfMNKNsPFFd7S2gGXke/3x/O5nO7N5?=
 =?us-ascii?Q?Dbdz0WEAfR4nTlcgujrRMAN/3VNlpkIY5TJRTYSA3h05XKzIUnf4hLLNy6he?=
 =?us-ascii?Q?LfhKJ9qAkPWAbcObwdoDa44bu6+MTZ5KNIe7OpqjGyTipm5wBhSdLJ9y2nfH?=
 =?us-ascii?Q?PqjB0MygtJAZeK4hbx4x6veDEIAShdt6RFtk5wH8zXzaNirbX5I8jGchb0zV?=
 =?us-ascii?Q?2BtWYOlkPgEq44UAPsrbByf4LcXV6DJ+Q5GMWKSdlmUdZp9qZnaP8qYX3tbY?=
 =?us-ascii?Q?jBa8xMK51AzRVqbGfavHxMt1X3D4VFC6ItZW2jE8ZDVqudEC/gZ6PgtEOpcg?=
 =?us-ascii?Q?yC3g0YW/r/LDJM7Upx3BHiid82fTLzPFFhqvt4v1+AQ5AWlApgxcUtktMXQj?=
 =?us-ascii?Q?sS8Vk/0PwXG5Wngz/HJIwxiJ9tNBnbiaGYs5lnO6akAOXRAFz+0M1FqJCy0N?=
 =?us-ascii?Q?o1bE8vbhdZJUcK3e22VREwQ19DvWkodkHzP0zaVwIVflJMSc6o20UCM/O84p?=
 =?us-ascii?Q?jHbPogjWBd6m0xEY6L90eMW9idBsnpIwsC+O3g2MRKBJKLi9LCaylSJ+DnKE?=
 =?us-ascii?Q?wiFcdM8AamFDQy9IyxXiwF8zIAQPoLGLMAEJO3qcx9oWroTMvXQoNB2+GoVH?=
 =?us-ascii?Q?XtNKzKU84150KPAvqRKd59TSFFSMNjUio0OSgeqg+pg9e9j38iDSS708ylMg?=
 =?us-ascii?Q?s55CnThXGKlgyF1GDb/jGhkjDMtxh0DQcxBWIT40yIfpcZLx64Upqug2Xa9i?=
 =?us-ascii?Q?rs1+IeeuLV9aNaShPf99HWBQkLRxCSVUuEeuxQojedJ2+N2DbsTip+mU7RK2?=
 =?us-ascii?Q?8zGfTn8a4/o1Zw9AtFvzg198NDyDWQapThHy7iv7AhfTIUPXtW44t5VvFy9J?=
 =?us-ascii?Q?RXgXKjsJb8WbshtQZARduwqi0DJ6Z1BNT1zBTBK+7H8Ry6rJiz/zzU7wXUgj?=
 =?us-ascii?Q?3WjxD4RIKoSKVzat/KuRBITWeZKq26WT2Jiie97m26K8cYOTGJeoyqDe6SYJ?=
 =?us-ascii?Q?0yFxoZsBL5tVRGQk2ofZTFp3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8fd47b-d5c4-451d-8621-08d8ffe1a07e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 07:39:39.5877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQgwicOOS0EZNmsv1wNV5OW5jWc3fquaLC1mxg157uY1BB5ZKl4+dBDch0edT0kE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3413
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_003946_397089_B79DA0C5 
X-CRM114-Status: GOOD (  27.81  )
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

[AMD Public Use]

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, April 15, 2021 2:30 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: linux-nvme@lists.infradead.org; Chaitanya.Kulkarni@wdc.com;
> hch@infradead.org; stable@vger.kernel.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>
> Subject: Re: [PATCH v4 2/2] nvme-pci: add AMD PCIe quirk for
> suspend/resume
>
> On Thu, Apr 15, 2021 at 11:52:05AM +0800, Prike Liang wrote:
> > The NVME device pluged in some AMD PCIE root port will resume timeout
> > from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> > This issue can be workaround by using PCIe power set with simple
> > suspend/resume process path instead of APST. In the onwards ASIC will
> > try do the NVME shutdown save and restore in the BIOS and still need
> > PCIe power setting to resume from RTD3 for s2idle.
> >
> > Update the nvme_acpi_storage_d3() _with previously added quirk.
> >
> > Cc: <stable@vger.kernel.org> # 5.11+
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > [ck: split patches for nvme and pcie]
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> >
> > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>
> You don't sign off and review a patch.  And you do not put a blank line
> between them, this should all be one chunk of text.
>
>
>
> > ---
> > Changes in v2:
> > Fix the patch format and check chip root complex DID instead of PCIe
> > RP to avoid the storage device plugged in internal PCIe RP by USB adaptor.
> >
> > Changes in v3:
> > According to Christoph Hellwig do NVME PCIe related identify opt
> > better in PCIe quirk driver rather than in NVME module.
> >
> > Changes in v4:
> > Split the fix to PCIe and NVMe part and then call the pci_dev_put()
> > put the device reference count and finally refine the commit info.
> > ---
> >  drivers/nvme/host/pci.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> > 6bad4d4..ce9f42b 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2832,6 +2832,7 @@ static bool nvme_acpi_storage_d3(struct pci_dev
> > *dev)  {
> >  struct acpi_device *adev;
> >  struct pci_dev *root;
> > +struct pci_dev *rdev;
> >  acpi_handle handle;
> >  acpi_status status;
> >  u8 val;
> > @@ -2845,6 +2846,12 @@ static bool nvme_acpi_storage_d3(struct
> pci_dev *dev)
> >  if (!root)
> >  return false;
> >
> > +rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>
> Please look at the root bus for the specific device, do not assume that you
> are only on this specific bus.
>
Thanks proposal, do you mean search the root complex device should by NVMe RP bus and something like as the following?
rdev = pci_get_domain_bus_and_slot(pci_domain_nr(root->bus), root->bus->number, PCI_DEVFN(0, 0));

> greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
