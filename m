Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF38C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 12:44:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3F76195D
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 12:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3F76195D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WcyBKaSj9S6NdYIP7PZWryIjtgsKVwEayJTv6Xbj9nA=; b=qCzywHPuTZPqts9aB2pqzbQDC
	SYqzta5WwA+6GKGzv+NBcUwKmMqbpyDJnw50kbyZONZ4su01lKROEeAOrw6aLWG+EpQ8acG3ZBy0s
	5DTfiuHesHCXhRbJTOWn4kOn1A7RYE+ZBSDoqir9KZwSXEHA9Stba520AF9Z9ZVNcHg9JQZ6GcVpF
	MSsP25X6xV8zxGv2rQpiRyQndzKPfTc3A7GtWhIH94NU8BlEF7YQA9n77AFlnih4ZS6F/O0RSJjiu
	mbfq2wFUfBgRrrIedohAn8fHy6BV++d+pDMCIrwvESUhb5jBPc+AdKf9dUpdQadxbjKVS8sOCbQ3Y
	zVMc6q2UQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRaCT-006a5C-UW; Wed, 31 Mar 2021 12:43:58 +0000
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com
 ([40.107.243.41] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRaCQ-006a4l-FJ
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 12:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmw+6u0Lt/GXECun9qPuCGLDEcedfPXU0uuOZfAcMxmMonpeKZ1pMFXhZZ4ulobqBZIZ7Bigl8K9+xqHjw0cP2wyowqOfF6bKxk28JmnjMWb1JX9xXEUUVyYWMSj2XZbZTQ+F4vIRkkYY0IxL7fDp2Df2lHllwM1VwhXfwhgcU8KCkwlSB9VP982xk/5G1rQLhuEt9GjayZYE0NuxPNuUQ4E0+zb2OcB75zbHFFvcuTLhOy9v+A3EtOw2blmJj0wP2IemTAUruAoB0aUXoAYS6ZlKAB4g6XtKHinFHBEZ4g4FWFo9ucIJ4u8cRGJwPtCEKdT3ap9LwqPldlA4dLntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBFFZbQwYv5+m0lyKHMDknnqPrN891tIuQwOuqRt484=;
 b=g5f4ytPOb+3KoFwkSjsh7BbE4mC4IyFMX6D3bKxkAL0qzcIazff4SCDHkw7rxoTBFHSFoiTVlKLYKE+H93rXP1d5KpV4OSXX9aZgcSrbJMr1fDwJQqZX3FQYN7EGw8KvXbHtIjIVRJT4fmDxHST+4HG7jusx9UV8G/tSYvLWgtM5BdxaeoCqtNcMGpNjYN8bFR62kP979D/CNuFhUwnThrad0ia7S/8rslotYaekMZTH0lqrpjYxMB5XT9WGv9WXb2IlFvEPU0txFqnCUKQxTtA4U76ZYimIngZ+UAsnjwOsqNrLTZ9ROG3UuYraEKLF/TJ/rC3+OKHZBi1ninUWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBFFZbQwYv5+m0lyKHMDknnqPrN891tIuQwOuqRt484=;
 b=jgPVxuRdepIT68j3OS9NHaHKdfLcmnHcpOlmQZEbW04s+Db9TIaQrGJP1e+SHFRt3hJR5PH8Gofq+d2Ncq6sjE8H6MGdpNLvBJffU6UscxMQ7euRVfU/stU5fFBuEJ+ouKbAYV17h9CpB4Ut9Via+TRQ4cGAY+3wwnVwgJtypwE=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 12:43:51 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 12:43:51 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Thread-Topic: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Thread-Index: AQHXJWPbgv5G++f5pEuafnHum1+TRaqeDApg
Date: Wed, 31 Mar 2021 12:43:51 +0000
Message-ID: <BYAPR12MB3238341C947093068D5F735CFB7C9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1617108844-30110-1-git-send-email-Prike.Liang@amd.com>
 <BYAPR04MB496574D855EB7DFC0DA379E4867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB496574D855EB7DFC0DA379E4867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6c40c0b9-ff0a-48ab-a1ca-662ce28758a8;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-31T12:43:24Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca0815f0-a647-4f31-389c-08d8f442a32c
x-ms-traffictypediagnostic: BY5PR12MB4161:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB416101F08297DA34699187CBFB7C9@BY5PR12MB4161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dZEK0rxwU587XAibZcPGD+UuLZUeepsVHqsUm/Wsq0YtYy1bbyGUrdDBp7j7Gtj8Uyek2H1aQkAhalX2Q1MrURniB9c7MCWqrlRBnZwdmpu9KE9XIpOWHFqBOi2M+JCIzmvAxoevcSHDHFw2nI6fs6mkPkRak4rHuGhdjDNF3xOgBYjqWPQwV16Briob4Vj5XiRjlA1SHN64lsycNK+S2W/LYAQub8xL/3j+V099MazSm/f5uU60Qw+6d7F4K/tWEqTncF1X2CVDy1YLw8mAc7ulixjdjDonZPVaqOCCkG8bpS47R5fJAR5cIeOBJvL4lzocE+f32CLomY9pyKUEOSpCDAHDe6rjqQCsmTjd0TDqHx4OElAzmqV8wHH4+0UgjFyaX78WKGPlCAWc6v+PDZSj9Aw9SSVf6nylyHPAfa73lhLZThqRTv6RIiOsZL63GG2Y80aNVluts/9CRi3aTAZXAlzxefTOqsirfO9Bk5NbMBj6EF+Sex4iz5dYhsmbk1SFIWrmaOyV1J3bKzC8hrk8D1sNpU5rdTI0tfM7Yfb0Q+hm4otrsPSeII4ws+F4YjXBgRAaAVhW92hfF7nW6PKQQQ9x6OeL1txrEbJfZ53NqKFRSxj4N+0XFK505zLW0siPwPwnDPSXCce7qL8LJk8ZkWAnBx8RMYVOig2VoA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(66476007)(66556008)(76116006)(66946007)(66446008)(33656002)(64756008)(53546011)(8676002)(52536014)(5660300002)(2906002)(4326008)(55016002)(316002)(83380400001)(38100700001)(110136005)(9686003)(186003)(8936002)(4744005)(7696005)(54906003)(86362001)(15650500001)(6506007)(478600001)(71200400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Qwxr1I3vI+HKDbkUaMGWgkc0OUwZrZNsQCnCG8e3s2ezC7Iyl0JfVGQyKZnu?=
 =?us-ascii?Q?xAKterOjgAfPhm0/rB9H0sZ4h8+d5alm8sYxLP37lIh0eIGOwjisr1n8YONR?=
 =?us-ascii?Q?AuS12yimYCYK9SC3yttlufE8AaZVaSFFCBcyXO6ydekDA3URzpa+5Xv/dA6F?=
 =?us-ascii?Q?YhYeKJ4gsWmjnu6VCmdTArOSYU5zM/K8JEqG7FN12dlVOMyZ2cvT44HSE1D2?=
 =?us-ascii?Q?2N0Ia7wDkAE3kcZY6uSJ5qOXRxRjFY664lN1g07K19fl9LtGMCJl5NSatgDC?=
 =?us-ascii?Q?xfjwqwAuHA3KrfoFGE1qA4k3ywDeKLC5uT+XUiafBvHX9sL8B+BJG7wiH8Jm?=
 =?us-ascii?Q?ElCz4YpWxrtuU74RjJ9aTjfiwwepryCdpnWqj6NxT7L3DFevsBf2A7qJA1Gz?=
 =?us-ascii?Q?MANoG0gpotID/5+ia8JZ5jWyDKyKAf251MmSUka91tpeW84lNH/USni9sHNR?=
 =?us-ascii?Q?Pa7CxJXxg0ihhuae1EzC/H/XkvT4AU8rw6WnvtUSx5qSyNw+PSZVaTnDwO+u?=
 =?us-ascii?Q?DeKGU+EoTry/0/fr57r21JGD+g2Jodcg7746yhC5OiyJol5zI/AtkLC1Q6/z?=
 =?us-ascii?Q?+y5qvEolIB+nsaidJ+0i8c+oCkcpum8gs19Mwv27OCszvXIX6Sdm9Mvpn/09?=
 =?us-ascii?Q?2+LIht2PWlOb6+keAa3fn8E8KIGBDVesdkiaCuLtc0ukoqdSKRpoCiTOVxLp?=
 =?us-ascii?Q?rervyFlpdF6hGnFxbfT1vLKmFkW7PAflPPWulX/OKiL4zNKPKmwXBz6rRQVN?=
 =?us-ascii?Q?by+BQsuya9vg93qH7NFEUaW2IkyEG0HoJSpKqSgIEQIv19NL8mVtCjV+LZl9?=
 =?us-ascii?Q?VICHRHSij2mED3wutGWPG8/5eWEAnq39PZETi56gMP3nzejCR9LbjcQq1QZw?=
 =?us-ascii?Q?xA3K2iOe08fmKZ5UUCqz6jwHGdFOiDDY9BHsSOjtv2DhN9QE+TUm7q/7YY2b?=
 =?us-ascii?Q?/WWLEQc6O4zEEe8ok8XbHE+ehh1WPLch/a886Ee4n9mIKm3LjlrIpYGjaZdc?=
 =?us-ascii?Q?Ows6Dsb2oMDHf28086Xu9tgZ4YeHg43Pe/cB4X9x2G6lN8JkybODcznZ9aOY?=
 =?us-ascii?Q?JM0MqRb5vEpcpk+Q/vQqeuJSAYMhKA8pn/Zh3yxNfqQfc10Yw6v0ZlK3MmFd?=
 =?us-ascii?Q?H8rkgLzQ4kyM5NtU6ktD9983m+e9HoxW1FRMD74a/WCPLRcqGsj9W2FDSeCm?=
 =?us-ascii?Q?pFU9+AxVVWFEAHnVjT5m1DNa3ZLQSIzOXZz2jC/xxRNsfRY+NoZDPXXEXdW/?=
 =?us-ascii?Q?XnhswfQGQc1+5bszz2ESokKAwrYx8b/BseYP32YsbuQX1yr/DqEJBPYxTPE5?=
 =?us-ascii?Q?OQdB15HdvEgEGfmBefeD6HJy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0815f0-a647-4f31-389c-08d8f442a32c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 12:43:51.4448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMSU4WGftOWRaeyS9pVX0o6hETAZPsIRbns6Hph3/v9D2mpxQg1jXdGMZqvdNL1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_134354_789374_1A3799A5 
X-CRM114-Status: GOOD (  14.36  )
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

Thanks reminder and will update the patch v2.

> -----Original Message-----
> From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Sent: Wednesday, March 31, 2021 7:32 AM
> To: Liang, Prike <Prike.Liang@amd.com>; linux-nvme@lists.infradead.org;
> kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; S-k, Shyam-sundar
> <Shyam-sundar.S-k@amd.com>
> Subject: Re: [PATCH] nvme: put some AMD PCIE downstream NVME device to
> simple suspend/resume path
>
> On 3/30/21 06:08, Prike Liang wrote:
> > The NVME device pluged in some AMD PCIE root port will resume timeout
> > from s2idle which caused by NVME power CFG lost in the SMU FW
> > restore.This issue can be workaround by using PCIe power set with
> > simple suspend/resume process path. In the onwards ASIC will try do the
> NVME shutdown save and restore in the SMU FW instead of PCIe power set
> in the driver.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
>
> Did you get a chance to run checkpatch.pl on this patch ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
