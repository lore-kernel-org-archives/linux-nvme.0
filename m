Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDBC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 07:14:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69902613C0
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 07:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69902613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RIjXT8qe7nKIp8cO22dqZLqf7wq3rAV1/xAkAQEkHb8=; b=GXVq+pR9o0w7QKwIiPLcLeauP
	k3L7QJkYR1RX9BNmQzoVCDgi2mc/iSFo/g3rlZBImRD8V7Xh2zNQlF3X8Qi6KvGtqn/R+cvv+Mt5Y
	h98t0q5Jxv8SxQzgP7OYq/CxpHyzCiKTOM6KMIdKG9eYMmqUpbxWA8MRWC0ducB+0YXbnXSSsCUDp
	tTeGmtI3wH94FVZ/Dh5/6fRPj/mFD3tATn2jWpSAP3EPe33yflDDzspBPDTEyk6GMC1OzLN6NaDeB
	1wEBN0FxJmnf+Gg4bUlU7bsrMiS1V2Y9TE5kbbYgeoA49LJs2Efk8SfzC7mXmfLQlKxG8qSErJLnh
	15nanNElA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWZiV-00BnI2-Jy; Wed, 14 Apr 2021 07:13:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWZiF-00BnFV-MV
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 07:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=ulv0kkIzzvDo5jOIHmvLHaRqp1gxhXmSNllgBGimGvI=; b=0DZuhTQkRO9/CGkyLyUoyw1Zib
 K1S7H5p73xM2D80jIwdylkc8iF+j1vbFBNdoxIXFmcPAmCkqEo3TcqQ7MOl5p3VU9v8RYWyJZQyoM
 1kqh32lLNWwL6aWM7WY5hAWFmh+zXExmR/gmuxSRwXKqKwK1wS3xMCyiBtXPEDU71FRXwFkOFGONp
 s2su4brk/8XQoyTz26u7aJ0PtJhzKK84ETrpIerGlwHysP+ClELAHuvSpuOCFvHty9/PC3MW2gzoX
 fd1P1ZPsymyQk35ED7B6qWj/w4ERb/qgr1bnwLa5bo5t5+R0hmO4FyNJ0/fYJXejtxbmZ+Ax0KVN5
 Og8huaOg==;
Received: from mail-eopbgr770085.outbound.protection.outlook.com
 ([40.107.77.85] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWZiB-007Ysv-Pw
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 07:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN+AdIK3TVaN+lknVcpmHolIV6QdphcdHKZyOgh/IvYvuVBWEf6IXGLAxk/U5Juv5uGyLzEH7CIWRqQFOfHTdjIy2e/Hv3eGeZp58m4RDMkBwuJBtQTWsvvrKhWoJRZa1N4vOFtcxon4Ksd0UeTfioRs+Mznm9BBOyc7L3khO7IEsuCXQ5lo174A1SeDJa9lYsUO/ytdSntgbMK0XNSOfLIwyLev3p4c3l2OkzxVITQ6lFp58/r103CPyzEH9Hz97k0sOQ6SCLEd/giTb2cEZ5+MnuwvmMQmWdhdQsFtRW4Ygb4yStCntMXGpQw8of97gMV04Cixe3HUMXIshIQQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulv0kkIzzvDo5jOIHmvLHaRqp1gxhXmSNllgBGimGvI=;
 b=CAKu9bMGlxgNbqhGmocMaBI7OYK99sFzjNcOCAZIhQZ71VACN8duiAUwVrKES8mkRci3ceN2ikkEA0wrzb1XM9gC0VKmb5BBkSB0Jf6uHkwJYZSt1uJQR0Sov5dTtV/o9KpjTvbUbyGdiuk65ePDZ+KvFRQdnMfETmjTGgmF1+RBhB5CdOSdfz1M/IPEfKY0R6dA7J6nPG7nGtQrrv1L+fdT60RH3xlGlu43C5dS+014Q1MyLrDxn3z9dFNcFkl+XzQkesVsnBklMuE0RC/vq+Y92jXN3fkh/0E+o7r+tp0B8YDgUeYZSwTYbFvHQKHeHzG03ifG9uOCwNA7PLgzKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulv0kkIzzvDo5jOIHmvLHaRqp1gxhXmSNllgBGimGvI=;
 b=5cFDU5Q73nB9pphKy2aWtc83OQL5gHSqhk1u4GMND7I+WHQBAo8mj3/MaO+t59ipALWA1j0UvH8WmRz1XQjgTVGSYEPZ+pLCB1FtQQjAvSVP+x2CS26oXHFhg3S43Pqso8VqV39B9J1WMGjVpYLWjJRcs+teLbahILuR32eTywo=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4004.namprd12.prod.outlook.com (2603:10b6:a03:1a8::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Wed, 14 Apr
 2021 07:13:16 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 07:13:15 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "Chaitanya.Kulkarni@wdc.com"
 <Chaitanya.Kulkarni@wdc.com>, "hch@infradead.org" <hch@infradead.org>, "S-k,
 Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "# 5 . 11+" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Thread-Topic: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Thread-Index: AQHXMPZWugAdfwQ9zE+MP2pwxe1wgaqzj+0AgAAGbLA=
Date: Wed, 14 Apr 2021 07:13:15 +0000
Message-ID: <BYAPR12MB3238544752DD86202469CA1EFB4E9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1618381200-14856-1-git-send-email-Prike.Liang@amd.com>
 <1618381200-14856-2-git-send-email-Prike.Liang@amd.com>
 <YHaOJDm3GCZ8baAV@kroah.com>
In-Reply-To: <YHaOJDm3GCZ8baAV@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f21d2b45-011c-4fac-81ab-268c7ea84625;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-14T07:02:43Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4692ad1d-2e21-41b6-0a4b-08d8ff14c5fc
x-ms-traffictypediagnostic: BY5PR12MB4004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4004438754925362E27EB7ABFB4E9@BY5PR12MB4004.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kqUG1KrwcolXbpdL3dAITXNz0gdwZmtc43Jj4OOhk3GZLWos2dzLPPCoIXFtkOffF6fmnaW3ZfUbW/5TnnhEf8nCdwQaV/4Zwlr2LQVq3ofLGZIXCsTujhoq4S5p/h2paOmCvQrB43sxbTXNuHtcDpMcBCsfJaod4FRRkg77AYJy0CAYuI8GzHuMnuHMTqMRxX+ujJt34LA42RBC63kB/dl4D1/dYDJRPZ6J8tlBWM3Py8d2kUB/jxFN7r9wkDPVckDlq5kEeaksHFFtMVEXFcXBuiUK9K0XHmQkX1U7s3R/0U32Pc2rFgACKQl1PWkdszWOKMCCp75t3swsyBqnVesRm2WDLKtgUEoBxz+hj6ubzj+PFouv970iiDhl55naU/b8KP7SUpegbtHWuDNUFsxTrruGZOa6Xr5lD1TqdNav/1IYP+7UV69us+/NLGBVlZz5Tv5y7gDgweyIPi5ecNSDj8kCE+g5J69knlle7wuVbOZPOU4JCCmVW/rlRjFp24C8fNYj5lYklPK9ZoUac61ytXXv8BJOOwhyjnJTdruv2J/2PiMVUJWbi5C1kluTIa31r4VnJjVxlrio1LTrSinYiKtlnrNp7XnuY5vwJQA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(7696005)(122000001)(8676002)(38100700002)(26005)(71200400001)(76116006)(66946007)(6506007)(8936002)(478600001)(66476007)(83380400001)(5660300002)(64756008)(33656002)(54906003)(4326008)(186003)(52536014)(66556008)(53546011)(2906002)(66446008)(6916009)(9686003)(55016002)(15650500001)(86362001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mGa6LAM7VtvyAQ+fMdUz2H63ONyoDgdOXv6IoP3u2CMub5dF0auFZXrtoPbf?=
 =?us-ascii?Q?zZ0MF2Y735VH8Ax61Lbm6viA4XIQchfCnsILeDVnmQxHtSGSKNTza1mnlZF5?=
 =?us-ascii?Q?9TM160p0oeuDLAxiHk951kEkeYT3Dl7gBOhqc2MKKT88ykTrpwgnrKulmYS1?=
 =?us-ascii?Q?uhHL4OWoHrchQcCjiUUuPTjEXyEvw31mnPsFLNjBcYtu8j9pFxoRyDGCQCZg?=
 =?us-ascii?Q?hgBVgRiOjclcqorMszNCC4stSHZZP7/830yOVYQnvmy36DoEAOG9nyKaS7sv?=
 =?us-ascii?Q?0ddI+HRPrVDep4pGHmIUB37UJow9AnncCY1YE0wZAWaI/fp2zSZhSbLqBCWC?=
 =?us-ascii?Q?q7EG1gR//Qu5oXVPJQ5LAnjnJwlnw5vyeTIs3hSPNyRM5cMtUOXPeLZqujVX?=
 =?us-ascii?Q?AGwxZszYzJi9gdjROxSjLX2E0STbJrLPw22GND5YNWoQYO8MdO+ZBE4VvxQu?=
 =?us-ascii?Q?fZVvtppKuMZCofFC8ZEsfbm6AUwc1o1y29E+eLG4YDsqiX4XBRS72sGWt06z?=
 =?us-ascii?Q?G21XItirQDvUAJ0WDVkNqhmU5MQRKi+mnIKTudmDxIC3Ay62kI6Rb9eUQzOD?=
 =?us-ascii?Q?mHsLzyhO1raPOrD+Y4i8N5sHxA3HG0YffC9TeSP9ADHiYUMDwiKwbiTuEx+v?=
 =?us-ascii?Q?GfYJsxviiNpMcNcvzmEoCwKqsRqZ0TIAkqh+GIoH41ZmTSTWmgqBKkNEMnlH?=
 =?us-ascii?Q?E5FCTjEr39kmxfUhZcGswZUxHE+Zn7bYqCKeLKOI54DM3PxtayeNpUiyVGGO?=
 =?us-ascii?Q?xkqOjBpaiNrzhUzjT8ALs1spDa8lDQuX3Z1ByW+XJ/gag95JxCuqF3TDmzwV?=
 =?us-ascii?Q?XKDCKd1XGxE8d6pQj5MkIYBVRKRQsevAqjzogHsA4coCrJ6QQUZRIEcGp2o4?=
 =?us-ascii?Q?bRfhg26BluRRCrZxq3FZ7StGxAFnm+M4KweiPJieFXqLiylTvSjW/NgAU96w?=
 =?us-ascii?Q?1qz8UY1tFGdnaZ52oN6CJirjGfLu6j+hbZHsreYioTtLfwDtiilzGW7cjg5d?=
 =?us-ascii?Q?rGoP+oOSRFF35dBIrBXnsJEZ3f6VwSIwuwh4NBplPy3f2Q6OXYZVv/krCfgv?=
 =?us-ascii?Q?5SMofEUvsLYH+1lwmM4HAOCM9Ux2kGu+/QAAndDxC1PADJfS4sYJsPUnU+/a?=
 =?us-ascii?Q?nBr/jnLrypXN/TsoF6WJNGzMWT9bGrZvzmMUwMCqMVemZIOZkE1VcUV8+qzU?=
 =?us-ascii?Q?kwJe9vjAE2nEHuxhHgjuXfDI8IsPU88xTXTOyYN87Ce7e20pC7fmQBQoXDYm?=
 =?us-ascii?Q?OXA05oj2Qfp/xqkMXUSR8VF90Gq+kOaRL5aS86YsCB42iyF+Wmhb+JrTkKOE?=
 =?us-ascii?Q?v6Qjd4PoZqYZS54j8VqnIOaA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4692ad1d-2e21-41b6-0a4b-08d8ff14c5fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 07:13:15.7244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PW9Op8QHPELNAUoEWmB/353cOibgRoCS4cqXf8VFL4XFt1nOxzyEpPWAqp0VYg7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4004
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_001319_926844_85DC22FE 
X-CRM114-Status: GOOD (  22.69  )
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
> Sent: Wednesday, April 14, 2021 2:40 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: linux-nvme@lists.infradead.org; kbusch@kernel.org;
> Chaitanya.Kulkarni@wdc.com; hch@infradead.org; S-k, Shyam-sundar
> <Shyam-sundar.S-k@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; # 5 . 11+ <stable@vger.kernel.org>
> Subject: Re: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
>
> On Wed, Apr 14, 2021 at 02:20:00PM +0800, Prike Liang wrote:
> > The NVME device pluged in some AMD PCIE root port will resume timeout
> > from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> > This issue can be workaround by using PCIe power set with simple
> > suspend/resume process path instead of APST. In the onwards ASIC will
> > try do the NVME shutdown save and restore in the BIOS and still need
> > PCIe power setting to resume from RTD3 for s2idle.
> >
> > Update the nvme_acpi_storage_d3() _with previously added quirk.
> >
> > Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > [ck: split patches for nvme and pcie]
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > Cc: <stable@vger.kernel.org> # 5.11+
> > ---
> >  drivers/nvme/host/pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index
> > 6bad4d4..5a9a192 100644
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
> > @@ -2845,6 +2846,10 @@ static bool nvme_acpi_storage_d3(struct
> pci_dev *dev)
> >  if (!root)
> >  return false;
> >
> > +rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> > +if (rdev && (rdev->dev_flags &
> PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND))
> > +return NVME_QUIRK_SIMPLE_SUSPEND;
> > +
> >  adev = ACPI_COMPANION(&root->dev);
> >  if (!adev)
> >  return false;
> > --
> > 2.7.4
> >
>
> This is still broken, why resend it?
Sorry can't get how come the reference count leaked, could you help give more detail about this.
In this patch updated as add the rdev null point check and will need update the patch to return a Boolean value for an armed shutdown NVME device.

Thanks,
Prike

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
