Return-Path: <SRS0=/IAj=27=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E698C282DD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 19:15:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C67F206DA
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 19:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DL5S8r/Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="JFADkHTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C67F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Uv6zzUNW/nDt9Y1uLQ+WUCpdAXcq2JUlr6qBixpdLgc=; b=DL5S8r/Yj0pgQU
	aQ+y6dt/FRO7YnNQwJGlqoQJ3WJgrPX6Xth6bcdiZHTOYoRbZVWYT/vOoSLkDUu9paxzw1oaixJoq
	kbS5JWjIhLUTptOBGkb87hkLbQf5EpIna+GYNgX4w6qTxLDhlu4tuthZn5U5ZoFKa1zWCGpFFAQVP
	/KG+QjCl+Ft7LSh8EXaGKn8YwMtwTm8e1dZ3U2/ckxILHIudI4xXQCtocn/NMGKbLj0UfP2sX/ysJ
	KuRbP/r8bJNLJtNEBjGCUCrxXBxVvoK+5mvpUOuuGsaerNrMP+Ayb9qD/WrI6o0L4Av/MQIBPdCXY
	T7W3mckDoXrH2HjlR9HQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipzl2-0003Xr-PO; Fri, 10 Jan 2020 19:15:44 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipzkz-0003X3-G6
 for linux-nvme@lists.infradead.org; Fri, 10 Jan 2020 19:15:43 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Jan 2020 11:15:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; d="scan'208";a="255121674"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2020 11:15:40 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jan 2020 11:15:40 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Jan 2020 11:15:40 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 10 Jan 2020 11:15:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jan 2020 11:15:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+zXnJLAzfFYwGyPHTyp//tmXMkAnZ904DM096P5svRP704RtOEvwUuKRVPJ+mf8Q14KWdZzi9cqDLnjO7LciwvTaMfvsYxRyLKY5u7qSZQ5dIzgCHsdcY9756kpp108Y+qp2LXsrX/beYSCrNtJdRmbN2y8KNYIugQeGGrPcHHSs8kfir24q5DP0LiM7Bx8hZDqI9HL5oXp174l3rtIRn0cQDnwceGPs22xrSigus950e/Cz1sgCnf2sSHU7FKlY6R6th+XUgv3vXOGRQ4iiCoNveqLDwmdGIQl8kOqsaWx43HrhH3x9DZqFW54yKx6+m4Y4lb+9/YfRtGukiusiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXd/njHxwAjDPKaLDn79lr2MDLgLm1amI/j39pSB5mA=;
 b=b1wZ2UCiUJbHez+IeyvwE+UQQvHVvBZoJmPwFZBuG8+CW1kqdEUYM44jAdW4I6Cs0g8zRpNbhXD4P/GxzvbhFTRL6Xx/tvKraCViPidjNT9etAJUDsLiNPm0ycPka1s+BxP9l9o7weULXdYfRIJGatrFTGLa/U2/hxMIh0lmJ/2jc73HnC/UQD5JpG8HcNZacIeEE2gZ1E5tTcYtxJRo1AsD0wQQBmo+3We9XWW7afPLfZ02/+1MTOTMnC79a9/bHBigv37v3XblEAaWuP0rzp8mQmWQZPn29/tOblBQZOEupbgpQzVzpZzDxFYEPvnUNt9LpgGrJtUWzGbP2BGCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXd/njHxwAjDPKaLDn79lr2MDLgLm1amI/j39pSB5mA=;
 b=JFADkHTXIXiFPRsUqvIBs0ob8umgdr+3jWS/aR5hfcRlH0NY6RY+FtHyc7fDCDCe83gfmhWFhGpMlKGQvCEmHMdA+HgPoKEFF3Mx0O41b6NFHmKh7YwdIHC5motHVpGFdbhy8/eS5qWr+2iy/F4MfCChFMMkiFgM3m2621jPK8o=
Received: from BYAPR11MB2712.namprd11.prod.outlook.com (52.135.223.141) by
 BYAPR11MB3479.namprd11.prod.outlook.com (20.177.187.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 19:14:46 +0000
Received: from BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9]) by BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9%2]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 19:14:46 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Page fault on branch nvme-5.6
Thread-Topic: Page fault on branch nvme-5.6
Thread-Index: AdXH6IazhWB7YrruQzSy63A2Yr2BUA==
Date: Fri, 10 Jan 2020 19:14:46 +0000
Message-ID: <BYAPR11MB271291B9322BFF44486E5673E5380@BYAPR11MB2712.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7abaecc-f161-498d-0b6b-08d796015b62
x-ms-traffictypediagnostic: BYAPR11MB3479:
x-microsoft-antispam-prvs: <BYAPR11MB3479F1058BC3A8D02CF113DDE5380@BYAPR11MB3479.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 02788FF38E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(2906002)(7696005)(52536014)(9686003)(76116006)(66476007)(64756008)(81156014)(66446008)(8676002)(81166006)(66556008)(478600001)(71200400001)(8936002)(33656002)(316002)(55016002)(6916009)(66946007)(6506007)(26005)(86362001)(5660300002)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR11MB3479;
 H:BYAPR11MB2712.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z16GfaEqpjj7mOHIrVj39MuxuvfdiQAKxuOhqUD4BqvZPiabtnClLmuVIfRUtIPTibyDGtHprZ77ZfDeUmymqjW3+m/p43oLmO/kARRkL5/+GrkPQJXGPrBsUe9icwFindPSLLN1sEbrsPLZ1jshJRGJGTYgiqp32g7MWUgyrhVvnMMImwd+3jAiFDIE0fmNbtEoLR1kAKlyCTCH6YGew+NTn1E/xDQDwAtJ+CZ8id7ZOfE/VZ2NSTyyRRDT5XFJaAqKVouxVdFBUuP0dq3UskrLN9X9XVzxSeOAQ+pG+jSDZ4VN9jVuWEDTgxqkgKHOPKnMJjwKrSoFWF0B4is1gSAfFW/tz9a3x5Abp+Kmr3akpUKta9kCMOKtKFN7WC/FBlgySNT9z2akVFPYf0lBStO+7wftFeLtYGeaNvXwXRmrlAWUvPtZB3SlDAT5Hju2
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b7abaecc-f161-498d-0b6b-08d796015b62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 19:14:46.6471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41XStKIM4Fn7m8FlMPDx7SQ33afud/b6gp3c02HZhw9PjTdVqkiewKKZarX9VkxY/ahPY9Shx5BU+4PC0g/pSP5dU6fykpSVmQPKr2FVGlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3479
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200110_111541_610586_12C5914F 
X-CRM114-Status: UNSURE (   8.17  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping: Anyone tracking this already?  Do not see note on this list, maybe I missed it?  Will dig into it more unless already a known issue.
Thanks --- Mark

Just updated to this branch.  Performing baseline testing before attempting to make any patch changes.
Fio libaio seemed to work fine.  Fio io_uring hitting PF.  Attempting I/O to single nvmf tcp device.

fio --filename=/dev/nvme0n1 --time_based --runtime=60 --thread --rw=randrw --rwmixread=100 --refill_buffers --direct=1 --ioengine=io_uring --hipri --fixedbufs --bs=4k --iodepth=1 --iodepth_batch_complete_min=1 --iodepth_batch_complete_max=1 --iodepth_batch=1 --numjobs=1 --group_reporting --gtod_reduce=0 --disable_lat=0 --name=cpu3 --cpus_allowed=3
cpu3: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=1

Tip of this pulled branch currently:

commit 2fcb73048f5a98e3cc18124f07067825e9f18b9d
Author: Edmund Nadolski <edmund.nadolski@intel.com>
Date:   Wed Nov 27 10:17:43 2019 -0700

    nvme: remove unused return code from nvme_alloc_ns

    The return code of nvme_alloc_ns is never used, so change it
    to void.

    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Edmund Nadolski <edmund.nadolski@intel.com>
    Signed-off-by: Keith Busch mailto:kbusch@kernel.org

PF Info:
[  415.518095] BUG: kernel NULL pointer dereference, address: 0000000000000018
[  415.518508] #PF: supervisor read access in kernel mode
[  415.518809] #PF: error_code(0x0000) - not-present page
[  415.519110] PGD 800000100bdd7067 P4D 800000100bdd7067 PUD 103b154067 PMD 0
[  415.519528] Oops: 0000 [#1] SMP PTI
[  415.519732] CPU: 3 PID: 3665 Comm: fio Tainted: G           O      5.5.0-rc3stable+ #2
[  415.520194] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018
[  415.520638] RIP: 0010:io_free_req_many.part.67+0x16e/0x1d0
[  415.520959] Code: 48 0b a9 01 48 89 da e8 50 ab f6 ff 48 63 53 40 49 8b 46 08 a8 03 75 3e 48 f7 da 65 48 01 10 48 63 4b 40 49 8b 96 f8 00 00 00 <48> 8b 42 18 a8 03 75 3a 48 f7 d9 65 48 01 08 c7 43 44 00 00 00 00
[  415.522053] RSP: 0018:ffff9f61c901bd90 EFLAGS: 00010213
[  415.522357] RAX: 00002d3e00009e78 RBX: ffff9f61c901be10 RCX: 0000000000000001
[  415.522773] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff9213bf020e00
[  415.523189] RBP: ffff9f61c901be18 R08: ffff9223ac3e3160 R09: ffff9f61c901be00
[  415.523605] R10: 0000000000000352 R11: 071c71c71c71c71c R12: 0000000000000001
[  415.524020] R13: 0000000000000000 R14: ffff9223add33800 R15: ffff9223add339d0
[  415.524436] FS:  00007f9f2818b700(0000) GS:ffff9223bf040000(0000) knlGS:0000000000000000
[  415.524908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  415.525244] CR2: 0000000000000018 CR3: 00000010154e6005 CR4: 00000000007606e0
[  415.525659] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  415.526075] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  415.526490] PKRU: 55555554
[  415.526647] Call Trace:
[  415.526793]  io_iopoll_getevents+0x27b/0x2f0
[  415.527044]  ? blkdev_ioctl+0x669/0xa50
[  415.527272]  ? __check_object_size+0x182/0x1d0
[  415.527531]  __io_iopoll_check+0x4b/0xa0
[  415.527760]  __x64_sys_io_uring_enter+0x19c/0x360
[  415.528038]  do_syscall_64+0x5b/0x1b0
[  415.528255]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
