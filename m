Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C67C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 00:18:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD0661159
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 00:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD0661159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Oi/x4gxCvS0S4m8+57NBndr6mOjjWd7OJO+7pppoRDE=; b=V0GbeQ8TaAIC5coY9iJ6VGJq7
	heBcVxfzHi8+yhafetVGMlczpsUj3dEERLMbeU6rwqBMuJGG96RyEW3dmERG0xOS690c7Qx6Y0Xm8
	BzKSAp7quM8cpx0fEyOrLEgFchLeiUjdUxI0IOWN8syvwZLQPphtW1LcIE2zrvFm4ztkZpZIRzz0j
	iZtHGQMbQZxG6Lyca7Ko+LMyiyU22DdvzJuGyM54ws3L1X770WiFspbSGC54tDs2tg8My1gqDVVZm
	7Ku1KIUw4N3/X1DBG3QH4Uu1n/PwaI5h4AVhK0jI6AOOsz5FafbZggNWMlBJxGti+UtVKBOCEotNk
	/ChXwLyOA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUIN6-006LPo-HR; Thu, 08 Apr 2021 00:18:08 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUIN1-006LLr-1e
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 00:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617841082; x=1649377082;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=CEqLzu/vAGTVTV5X1WFcNKYb5O0Mkf9ZGC+jKh9llc4=;
 b=EGBHti1a6FXGOoLR0Qvj0AMptgf+ZZf4ZiXdYD9RYhar51VRoT2jfWl6
 zl/+rsF0cM9SNc7d6HWKNLCGnnLt02wVaPdtibleENdW6O5v6jmuceXWW
 /kSS+BkZz/+mHCUqDqk/rpC+dabQrrKyCt6nEWbLKa/VIgUUpTNUYkDdN
 Mu95vE5TfzXUJZEJDeQRYZRTN10305dk8bD5OpxU8A6hOy0Ze3phkDcSn
 mEDv2mzbVHPAFKOxbkGn1F4J5lV+qyTHt6sBEibBjJAxew4BtbOkO5pyE
 R5rQDoMel6FmFrylLLOagzGB/Chlg+gV09OG0b8JAmi0tqKgDaPDh/lqj w==;
IronPort-SDR: s23Oq4a6vzL+8vPYtGJSqhyjwo1+m6dgWjOCRhsbaWQfS5SKfIhiJlaFFZ/BK+txqNDmA1BOoJ
 ZUFYF/8x5sXKAjiROgJnRoHl31fT9Ka/0gOLWcYZgYEw5l6qNIjb7dxQgKC3ePuwOCFAnA4isL
 96Z/MOoBzsiBWXrh9aS653MBhT+EzTEbaUHE+vBGbhoueL0YB/RDE9YIakVaD1mdiuSwfXk0XD
 V4+KxD3YqsKNmTLS6J0F15gOO1FeLqb7cQv2bfgobymgZ/EtHSO10gg2FdGIqwgo9IVePqPbC6
 Yys=
X-IronPort-AV: E=Sophos;i="5.82,204,1613404800"; d="scan'208";a="163873262"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 08:16:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VES+SgV/1dsdPf+jtwroVgWD7TvvhBQ3T8T3W0Ou8smISmzxx33IdAhOMErTI35Zzjctm76EinkGzaOoQioxYoG9Sd2PplI9VF6z/eefECcRFn2Beb4h5hpJcrs2arNRLaju8sD8QZVwR3+6VvNBnIpLD5ao1DUTy1GU6O5EE4CwPjxZXYeuUrxUCrn9HZh5UJSr0I9KfHp6VhrlShJKO++fZLm8OInlHhihqo8J44J0BNmbbN5bjdIULgtTZ/bniEKdQ1h6Y9dm6yxBezuuh+M349uG0prRwd+GdVJGw5ky/vpiLOrNnv2+RZJCM9Y64Wgj1D0yp63hfZa7Grfu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEqLzu/vAGTVTV5X1WFcNKYb5O0Mkf9ZGC+jKh9llc4=;
 b=I5ha7odOSPR/AnybmmTfwMqXcdaBVgiS8lWAIFfkjaUcvyGt9CMouyUGbdcjQTVnlY04WXR7VgMH3BB+Nfx+57HfPVcqoyQpoohKEV1Q6NE0ylQ6afDHEFu3hcE55+0Q4KewUMUfHT+0qcC3AhlwbU4uW0tt77/gRqV+ZtoISDh7jhwEUh4M6MrY2aEHoVPSah9Hgr4Z4VHGawlLvdk+ttehIlAhQ197clir8G7tzZgENIHOQggUwCJzt7zd7pVdVkrutbPnSSyU9hb8yxzyiI5ndpcUp0WwTX7ObCnX9G2GXxC3UFWhY1GY22dUhpWpU4w3tr68hqYGoGz1HPjFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEqLzu/vAGTVTV5X1WFcNKYb5O0Mkf9ZGC+jKh9llc4=;
 b=diTFUkoqif7FLnbJc2BnTIGLM0FWpiGx2Y3mGMOIDYzXeAxExBs2xqt0PtZQI9vVtPYcxaCS97clnYZs39OdUPTSOReebCnhhZE6BLQsM7FR2eYfwpIYQEW8LLIhjjqNXpDojHpp/zI20LLIVR2EhSMtCNxHOmQwarxMsg2LmA0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Thu, 8 Apr
 2021 00:16:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Thu, 8 Apr 2021
 00:16:34 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Colin King <colin.king@canonical.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nvmet: Fix spelling mistake "nubmer" -> "number"
Thread-Topic: [PATCH][next] nvmet: Fix spelling mistake "nubmer" -> "number"
Thread-Index: AQHXK56dYF1jSvwZkkWiA8LPEQbXpw==
Date: Thu, 8 Apr 2021 00:16:34 +0000
Message-ID: <BYAPR04MB4965A4762BEA0FF5D1D7BDA486749@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210407111020.486625-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aec4c8c8-cec9-47d6-55de-08d8fa239185
x-ms-traffictypediagnostic: SJ0PR04MB7261:
x-microsoft-antispam-prvs: <SJ0PR04MB72611D26918497B36753721486749@SJ0PR04MB7261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxafA2Q1b2+nj/sVzSesxNeety7rXcIOyLJJunoydIqQmxCmpxqQcj2j65Kt5AcSkFX98nlifHD/4mzDMLwwyALn8hnGbSkQv+gsr3w0GeIj7jbR7PfWFRkq3yNdxrEibiDevMXWY9ichQyzDMtK0EpgjATWG/DjCKHKteHXMnHvwlWUYPj+4pdltPf0T4JNhV7MCze9hmQ+QUOlXjvq7o6oIHK0glqJQ9fyOhCjrPGStkpeM5Xpq6R88sw5T4wv+BxH08QNEp01IiL/px4QNSY8pgloQwJ3P06LnWqTy3cmIxenmvLh9I3NNR2ZsvEvycW4MU5tOXsfL+88i1xvRIWpVkvOQJiO4XvoPffd/qpk1LUwFBkSDXdvz20a1D/I1TN5Y6ZmvLvIY87jRR999EBr69PfV/JXia0uhVhbO5j6BuOf8wd/zsWW8b/liOralv97g0rDjk76AtR5dLQ0xkF0KnGOAnYYzYkl0Nd0YAqCZQBIDlPds/yE0LTtYq+6/IIFSRDPbae/y6OrKyKDXQQVgZa0dZ9apAuA/xo8XLgrtuRi0iIAc0aGlg9fnNVXEcYxj0vT2Dh77ErRgb9Bwrpmsz/hN1mhA7anbjdbx93J8NnqWidw6vANj2AkPw+o7/FIlgnL+2UwBsXMx465RmWoulY7PS9GQBuLfx6etJg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(9686003)(26005)(86362001)(558084003)(33656002)(186003)(55016002)(2906002)(83380400001)(71200400001)(53546011)(6506007)(76116006)(64756008)(66476007)(66556008)(110136005)(38100700001)(5660300002)(91956017)(478600001)(52536014)(7696005)(54906003)(8936002)(4326008)(8676002)(66446008)(316002)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bB8nqbO/lNM2dWvlBcTFCwJeMvPwLe+nw4PNac0xFza/2xhm/yFOnGAn25SK?=
 =?us-ascii?Q?8EUqfDTYvtb1Hc1H9ByZZPZHOaZizJ5VymQDFGDuetTk6FRl7KpP0y11fsdS?=
 =?us-ascii?Q?41YkI66Zyy+OpEKKXZ+IriD22aizRolkcICglO95duVQ00OgndqCM8OwCJNE?=
 =?us-ascii?Q?P6mgWIeAQiRY8DSNyAArgLiSIZTNRyEiHkYXCFMO9SpieJpj4eOa53ovddtl?=
 =?us-ascii?Q?N/X4146BKceNsNUplFrj8isY6NFh7fjhypqNwh/CRq5Vx6NZkPU0N/u9FbqV?=
 =?us-ascii?Q?YWVakzbvm+u40YdIQQWV9rC6pGPMHIksuzFIlwIUruvPFhi0XauTZI5b+sR/?=
 =?us-ascii?Q?zkEpJ2MvQOvsAwacIsMeFMvoHkmhMBoe0UP2MiCwpBR3MEcVYsdwVzhP4p2l?=
 =?us-ascii?Q?TZK1QcQntZhJayEI+xrXI1CTDNMSgsCeSTZd0m976y7NsreGve34ChWrf8lz?=
 =?us-ascii?Q?Uh0a30oRflQKgrpMkuZHtPkqSQUDTkurlk78J86PAiT8eitl8Z1jCQRQlnVI?=
 =?us-ascii?Q?42++GwpRJVHypc3OMt2xW7jJKBzzDQcgTA4uf8DZ57rmHkasyBYJt1ndqiBG?=
 =?us-ascii?Q?zSBv/HRTrPeINEb0/wDmmYo7xHyVJBNwphWNndLk4KKhJqdrVLQRohk+OZua?=
 =?us-ascii?Q?UDR163ExTe08xvaYDSXGQ+ticWJCiNIjW0QT+zFsQEr32iaYy80aKj6BX5tQ?=
 =?us-ascii?Q?vCuwyThzGpH0CkE4TrplB++aguw3GfsXQScj+ELRRiuxlm3ROA8b9PjzbY9m?=
 =?us-ascii?Q?NSz5ywmssvXJK81pXIaPMsIubW9lVaHJ9DOOfk2mzhROWgcd4M/AayyIEl6g?=
 =?us-ascii?Q?Fziy6ZmYBNGYo0jh859juue/0fqnI52zR8/kS3WM/DTRpsPdWQr1OR9QTNiW?=
 =?us-ascii?Q?Q88loYqtnm0LO3VPU8JEK0bVhmEKLDkgkeB2+S+YYdNDVSsspUQhl3xLYvKo?=
 =?us-ascii?Q?vQFP4RHNuWmBnELPMmK34MYiH92HlaZVo8bwQiSPvqbG8R7/Qa/u4kKQGMmr?=
 =?us-ascii?Q?7Oai4BFgS2HE/BYS/PAVaL3qNRuUFx09KS8UfJ3pUZEUxN9WcJf/Z4bqA2EG?=
 =?us-ascii?Q?QWpQ5kWLAJw9PBb5i3bZPCICC7Y+FCL7PLFYZOH1pq7thvNdJcXv4Te/Lxwj?=
 =?us-ascii?Q?McBc/SHHAp3Mb870vy6Mz9L6QFq1sfo9Jgk/r2ZFNfMe3gOMpV+8zw14ssWx?=
 =?us-ascii?Q?kTT9QXkpsrgSFW1/pJW18mRYdsuD8GH4qnQvg82FIQo4hGbJRGMgF7nT+sY5?=
 =?us-ascii?Q?vqA41mjcGCDjKwbteiDQZR0Zqa1bgogXSm9PcM2gGVy5Wppp3qdqBBkME0lH?=
 =?us-ascii?Q?nnNBtMkWfoUFMwpFciwKhEUB?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec4c8c8-cec9-47d6-55de-08d8fa239185
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 00:16:34.3829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y68GknQZidXqAxGGR+FvxPVo3udGda815kIRawou3cfy0zlukKUmxpGWzV0BN0Z40UmNCPMwtlxsdC+76S6BvA4RbURDHoELAF0Wi/8z9Mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_011803_585335_62BB571D 
X-CRM114-Status: UNSURE (   8.73  )
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

On 4/7/21 04:10, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_err error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
