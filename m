Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66BFC64E7B
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 11:22:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F502206E3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 11:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E81BbgnT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jrH/HYA5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZAiJiaTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F502206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=vEwUEC1fsThVJbCQvpmK4qIlBt9gQaG4vtryFOJAX6w=; b=E81BbgnTDcYqyHTNJ5N8FOBjp
	1QFAc7xyfL55o5IdCaE+E4zoeH7yOwMa8T7rLwxxyZQZOCvOIrviufDt+HwHwnBC2rn1CFGamjIDU
	nmkDc8m0OPIdsnS9KbONfKCC20ewXlgPXymnJaX4lp5U4BvyT3G3dAIjrK2n8AwlJrSLyz/kxs9Jp
	zEOZa54ONE9VHLUhR7cSSmCUF88T8MH9PV3XV2eRawUyTEX0gW08ffev9/gJ4vTQoUSNV7sqrlZxG
	cokSumxXbemkbvnYj9S5W8joAqAqiiwjQIwwB1jo70ZJ1Xe6IjuCFTVmDxkb2EEWDY89GSPgMEHrS
	erguAVugw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kk3jZ-0007gB-Bt; Tue, 01 Dec 2020 11:22:13 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kk3jV-0007ez-Mg
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 11:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606821729; x=1638357729;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=eEVP8QLPsXiwHkOrFIaj4VoUxu3BboxLNBJPOgrOUSU=;
 b=jrH/HYA5nRn1pWCiCreGcGeFBqDcbIao9JwlOuNFuXcpYVb2B5pRRAMt
 QvIHGB7KUT7zfcM4CBgflE6OmZOrk2yb2vZ7S5f0QIGx8X/iS+nvZx9Xp
 WIRasqOeW+RQncoTc6trI2vBHvhAPAh8n/Ien7xI6EOgAkdb7o0T6zDx0
 uHo5wv/Zubib4acEtLMpIFah+sSdah0EqDZUtZHYTsZmSXopkeDjLliiX
 cxadVyoqc+AjZGDDZspJ2phYzYDx61ITgLS1RzBf6IO11nAFhESJBWZJD
 /azwhKsTo190Etn+BrCU2fl99dWxDSDyr2zyQWY6zpWeIToMrbyR068go Q==;
IronPort-SDR: eahwF8SWnh/Hv8xy97UnlXEEvznijJhOAvkIThBxO0y3+yTxCV3dm3Tb+RBIg55/xgjs7W4Ody
 ZffIvvGQ+L1Z0YfHB77YqXnVkSXgmkUtnlTCHmYKX1wdclAuNph4o5gacwXJWYDZ5CBb8nqDK5
 TEWxM8+PIb9W80ndQMAZMPtcoxWjvCaPR6eZdyX31oSuXtKrhUtCL2whd4aSQa9dG/fUDOOKDf
 BJSsO5mVzvQOQ04A/FNNs7dGbU+svfYZnlwvZjRIMipTAwK9pmVz7lydS4p6SDObV5sC0AHQ+G
 fjE=
X-IronPort-AV: E=Sophos;i="5.78,384,1599494400"; d="scan'208";a="153978449"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 19:22:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNBozcC6GkBDMepQTtuNDJKDHnmYWKnzEiaqZC4hx+0ZFlPR7km7YaaTWUxtI1zsnJyDw1Fyi3MK6i1TCJOyD/D1OTlKHiKinqBNFnJjaGu55XaRKtwctQWxXmWqSk9GOU3pIPSqSt0hRcPYJ+Fq8Y9iKc00jJEXjn2wCvxT9IQGUjFBus4eOxnGdrgV8MvFbBS7u05u2IoKXUpLmacNiV1qZhnXlbxx6idxkPbyqlTmC1lXpquzzHRvZTmRvWqq5WeHY+BsOCNwqsCuoqjTuN7AHO/i6iBlphxnQq1HbFNMELYMmkipJeA75B3IhcQfOoTmXh/M2CFFp330hQzXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYTkcy9OrNUPRhdbDk0j04ANvI4sN3lq320ILikHHog=;
 b=dMsySNuEeXrzzWGsVVARCbUJTxe0hKOyC0G+XNLBjdk71EIflraR/+kj50TcAbGI7Sh1q+1wv0rIQ/ahPSZWqAv5fEi0Oi9gEUf9wK37XIloGtBvsDKZoNT0q1V3QaLxz9oi7Nxy9mXweuqhJRZnoriRJRgIUUps8f5KGNFQFDUptka+veFTvXQ8CgfSHDGypOyrifzSDFNqc+BNxq/ae6RiUSicWzFwaaQbZ9CvHk61DRNM2zFjjZg74ZlE941Qp9D213E5hDolMHezqBn3vcSiBOLZe3ZJfidHPDEPNlqUZF3tUW3rJmm21vHby0OkV1ZT1T5FUMOQLczU5nP7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYTkcy9OrNUPRhdbDk0j04ANvI4sN3lq320ILikHHog=;
 b=ZAiJiaTIi84x6E4fZceX9wVSMaRfEpw0cHl/lsW3RWNHz4Y39tBCZTvtqskuI/QFWQs5zQT0reChPFWVUloe5BU12zaxXEtwVF8u8G3yxeF4x5CK6A8VjVeCZD9TyAHVGux6uf+IS8XuEvOjh78xSDv2tlipc60usJEuAxmtP1k=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7078.namprd04.prod.outlook.com (2603:10b6:610:98::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Tue, 1 Dec
 2020 11:22:05 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Tue, 1 Dec 2020
 11:22:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 0/2] add simple copy support
Thread-Topic: [RFC PATCH 0/2] add simple copy support
Thread-Index: AQHWx7FKsGlRN3mkpEWADJoApLvJfQ==
Date: Tue, 1 Dec 2020 11:22:05 +0000
Message-ID: <CH2PR04MB652240A4A23F89B26118FD66E7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CGME20201201054049epcas5p2e0118abda14aaf8d8bdcfb543bc330fc@epcas5p2.samsung.com>
 <20201201053949.143175-1-selvakuma.s1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9559c890-4a7e-4a12-6363-08d895eb5540
x-ms-traffictypediagnostic: CH2PR04MB7078:
x-microsoft-antispam-prvs: <CH2PR04MB70788C861CE322D927581D98E7F40@CH2PR04MB7078.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vy4O5uA5xSZ2jnv+8sdStr744QazMtMkzFdi8cmDEpG/yXIbW71nrY4edvfMQlyaW2EFy3OB12AiX11neGuBsVmSZciYx6xepFOuwFdiZvDnJvAjM1HGXrZaFQJC7HILdIrmrwdjO9jci5vmzN8bhnZRxoVKRuxHJnS+LAFzPA8VsaAddAe2gNGtOCCPfhLJpI5sFX59MiGSiwUXDGDBXLR/xGPoEcuRai2kjKwZ2bMoG0HfGPOYeGaY61KIcGnSlJUGGog0EkhRXCLJCr+6oqIp6m6sEKQ+31IIEo0vBl+L8lTEvuAXSTXKHsZP8y5xehA+9Yyy9dyjX0hjONphJJ6tRenGsLkzGImMBLktOPJ25NN8+mIk0LnmRSBJZ8p4fncO6QrBjdPQY+Kf4i5nkGOkmXrtEpLujkZWl2vtkMde6TQk8A9NX32Xcjou4pfnHlJqPExdlHMW9f0iwSr7oF2PsKLWMdRZNmITOTWzR9Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(76116006)(86362001)(478600001)(83380400001)(316002)(9686003)(7696005)(4326008)(966005)(186003)(66946007)(91956017)(64756008)(53546011)(55016002)(26005)(71200400001)(8936002)(110136005)(7416002)(66476007)(66556008)(5660300002)(2906002)(54906003)(8676002)(52536014)(6506007)(33656002)(66446008)(15398625002)(43620500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vi+2VLbt6Lae9lJVrI7n+y3zWjrxj72pWpL9n+aOzlKot8nIxJ9gZ7SNXxxi?=
 =?us-ascii?Q?+QnH6JfNoNMmNDXQ9gnNw7U0SU93a65zzRElyy6cPMzIyNN3XuCJHTZro5Xs?=
 =?us-ascii?Q?egqgIiSUIz9u8tygD6QQmp3gdwBpAG6op5ze7KZSl1fQpd4I8vXnyNSW5y7j?=
 =?us-ascii?Q?h7NLp5P91nBxP6LC3PmAwUTCwzG1Ki/kP3/n4BQnvvmr1/vEmcboCuFnViNM?=
 =?us-ascii?Q?j0gfX1ZRQxHxeHuvCM8meFR4HwLUcp74L6M+qDXOO6NfBUZuWAaD/NpwcMzX?=
 =?us-ascii?Q?CLEld6DQ+zEAIrN0bR7WthW8mYyjVD7LzHe5a+U4ekI3FaqFmWbH/uIAVZ0q?=
 =?us-ascii?Q?eHrZJbjEYSSuj/Zd5cGyO5usSTjG1V/jyfFqZiEGjGIWsO6nmrSVYYWf4oAS?=
 =?us-ascii?Q?MGi19TOGlZcs71uRzX5IHRv7bDt3LPX5SHHbk5Bqy7dSKKuMBO/DS7k0wja4?=
 =?us-ascii?Q?4MdUabYitJOgbnupmTQoPwMcrzlUQ2nos0o9VWflqvTPWLQOlMtuwS/8ex8k?=
 =?us-ascii?Q?SJnWM2Rj/bgB1VjGgIEGuAookE801sDRL5dlVQ6DitJEwMCIUcRddAG3YLNT?=
 =?us-ascii?Q?8y/i3ip38b4fTpLLb2zfQUYlMVuia46lmai6euXZYTeC/ioRNYQ8kpkqw6Z3?=
 =?us-ascii?Q?GV5tD5qGNNbE/daMh3iU+T5HiS+lYTTKHM4qNoVjoPgO4o6I30xJ+6PYJ8dW?=
 =?us-ascii?Q?iX7t/FVcQgVfZPFZZ7yZKtQm5ikgOLPoh7qsetd5O7OwN22IQ2KuuMCZueBw?=
 =?us-ascii?Q?jurYAyd7NBWqObqaV4vZJdy0cy5E3d+3E1TcpDgFlF7PCnUxeyaMSxmQdrrv?=
 =?us-ascii?Q?wcXnY1j2faLLFcl+D+Qx2es6//Wl2lGkdZ9pa3tYQKcPKua4lrYos5o3ju8O?=
 =?us-ascii?Q?2zOHT7Vbn2BcI/x05e6sJVwVTS2PlvDcnOwz9f/qmdfbqSN+hUkHycyOzRG0?=
 =?us-ascii?Q?h/CVWiF4IcD6FK/s+0a7V75i7iXiHO8IattFpIFvUOuBMLbZ0DTYG1f4T5my?=
 =?us-ascii?Q?5J5+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9559c890-4a7e-4a12-6363-08d895eb5540
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 11:22:05.1617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zUSIFR9OMhMbkPUTP+K8GbMD2lwk56toMULEUMsAu1Bbf+G7xSXdLDQbHhSMS7LHNkV99kjysNUvPUxlW2xp+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_062210_099347_4449351A 
X-CRM114-Status: GOOD (  22.31  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>, Mike Snitzer <snitzer@redhat.com>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

+ Mike and DM list

On 2020/12/01 16:12, SelvaKumar S wrote:
> This patchset tries to add support for TP4065a ("Simple Copy Command"),
> v2020.05.04 ("Ratified")
> 
> The Specification can be found in following link.
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip
> 
> This is an RFC. Looking forward for any feedbacks or other alternate
> designs for plumbing simple copy to IO stack.
> 
> Simple copy command is a copy offloading operation and is  used to copy
> multiple contiguous ranges (source_ranges) of LBA's to a single destination
> LBA within the device reducing traffic between host and device.
> 
> This implementation accepts destination, no of sources and arrays of
> source ranges from application and attach it as payload to the bio and
> submits to the device.
> 
> Following limits are added to queue limits and are exposed in sysfs
> to userspace
> 	- *max_copy_sectors* limits the sum of all source_range length
> 	- *max_copy_nr_ranges* limits the number of source ranges
> 	- *max_copy_range_sectors* limit the maximum number of sectors
> 		that can constitute a single source range.

This is interesting. I think there are several possible use in the kernel in
various components: FS (btrfs rebalance, f2fs GC, liklely others) and DM at the
very least.

However, your patches add support only for NVMe devices that have native support
for simple copy, leaving all other block devices out. That seriously limits the
use cases and also does not make this solution attractive since any use of it
would need to be conditional on the underlying drive capabilities. That means
more code for the file systems or device mapper developers and maintainers, not
less.

To avoid this, I would suggest that this code be extended to add emulation for
drives that do not implement simple copy natively. This would allow this
interface to work on any block device, including SAS & SATA HDDs and RAID arrays.

The emulation part of this copy service could I think be based on dm-kcopyd. See
include/linux/dm-kcopyd.h for the interface. The current dm-kcopyd interface
takes one source and multiple destination, the reverse of simple copy. But it
would be fairly straightforward to also allow multiple sources and one
destination. Simple copy native support would accelerate this case, everything
else using the regular BIO read+write interface. Moving dm-kcopyd from DM
infrastructure into the block layer as a set a generic block device sector copy
service would allow its use in more places. And SCSI XCOPY could also be
integrated in there as a different drive native support command.

> 
> 
> SelvaKumar S (2):
>   block: add simple copy support
>   nvme: add simple copy support
> 
>  block/blk-core.c          | 104 +++++++++++++++++++++++++++++++---
>  block/blk-lib.c           | 116 ++++++++++++++++++++++++++++++++++++++
>  block/blk-merge.c         |   2 +
>  block/blk-settings.c      |  11 ++++
>  block/blk-sysfs.c         |  23 ++++++++
>  block/blk-zoned.c         |   1 +
>  block/bounce.c            |   1 +
>  block/ioctl.c             |  43 ++++++++++++++
>  drivers/nvme/host/core.c  |  91 ++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme.h  |   4 ++
>  include/linux/bio.h       |   1 +
>  include/linux/blk_types.h |   7 +++
>  include/linux/blkdev.h    |  15 +++++
>  include/linux/nvme.h      |  45 +++++++++++++--
>  include/uapi/linux/fs.h   |  21 +++++++
>  15 files changed, 473 insertions(+), 12 deletions(-)
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
