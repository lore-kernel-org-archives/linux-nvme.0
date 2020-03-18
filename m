Return-Path: <SRS0=qC0g=5D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD4C4332D
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 23:37:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2815120768
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2020 23:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ex1DE0Ub";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iY8h/YjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2815120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wj78TYEY+iysYls3dpLoP9rPiMNKcgYDcDnORq5X2no=; b=ex1DE0Ub9h4k/s
	sqP9n13Ep810uG2QtqMafCaiZydypZubQygDAXjkatniz8XQuGCC30rjm7dGpRxYqTxN0PBHI9nf8
	xQQaODR9q6it5BSPSUXdUWRu+cl5jwvqTyItNBDEkk39feBlKdAcxkPmtfRmNVjRhu9c5Y184+1X+
	MZbO/YmO6yN5OUGdslkpVQB1nDdaAaaUcGRWLexZ4fNlgYraQvVIG5wENlIKTG7mK7sJERC1eXuJN
	QuEvqCaJReoZsIXVVTK/wZxnpkDIv36EArpBSF4ifCuBK58tytxBwyzYXwUOBwyOrWbBFuycmZXv7
	FaZT/8RNkvrTfISERcgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEiFY-0004aA-5Q; Wed, 18 Mar 2020 23:37:24 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEiFV-0004Za-B1
 for linux-nvme@lists.infradead.org; Wed, 18 Mar 2020 23:37:23 +0000
IronPort-SDR: jULIh1G9MTRXq956pCH3jiq7FPnRNWTNCRAZzBO6GCyE6V+GQDSoPlM3CjyV2uFP3dpxktH9x7
 Oyu/PpyyqDOg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2020 16:37:20 -0700
IronPort-SDR: OO042jq2uWBOX2tfyszOo1XnRID+vjzQiapSB9M1ZpADcbMrRchjSX1AW+Vqa8t39E8BamddIo
 PNeIQv0bKCMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; d="scan'208";a="418137915"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga005.jf.intel.com with ESMTP; 18 Mar 2020 16:37:20 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 16:37:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 18 Mar 2020 16:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgJd9mQERnoFmb85vkacGSPfCKIg3TZ52wE1T9Y/r7ztsTwCkClXXT3pr8pV8F+weeJzLhbpOEtDnb/rdG7rfoCbGV4Xa4pNjiS4zn+U/Whhh4pfA+w4jlLvoS78KeEibUgu+hdOYGuBGzfNmPvtDL1/iPYn3/IDxIWICFkJe/4YkRjM0zembH6ZRZSlqeKULV6VIzKSg1Eh9toojnXAqpp+yQLhkQhUO4qwCVd6pINDI9GbZdvmYALK+QSsM4gtituzEEv83M+C2kiL9rrGI0DrBsd4Bmq4x/CCMd5dkJdDY/VrPJjgjb1jjofruPH06cqRABd10WDWUWezvQPHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUk27Csdlf3N6/wbXeXC0bq3hxmLMLpe9IzE55dKmD0=;
 b=LNfCpju452Ql174feqb7yxKRAVFerlXYjZX890u8HvGorv6fYxeYDejutL82+OSG7CRqGxAbZod/tcXTE353Mlt2VdsWoFSBUB51v4D+OCqgfm1KRWOm6Pio0sVoQ2q4mPSQ3dceG2iqM72kTDLA40QBFDuJMsJ/nN/efUiRLc/mDq/iJZvhimMi8ciRbC9/sPv4gwC4VXaQljo3IKbS4KaKWfxLIcJlzPJC/Gmq58ee+7ZsQR9ESHwjcnEk/gQ6nIY+PYbFz7Dz69aoRE2STUeQ2VjX9Gi3wf4+wk3QV+eZ3iO/lnvhQGezfvMaqp016zGWHo2Srjbzsaa4W6JQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUk27Csdlf3N6/wbXeXC0bq3hxmLMLpe9IzE55dKmD0=;
 b=iY8h/YjYvRyhTmg+jf37g/k/U8BY/K+CuJGX/KaiDAGpLoec2KO9TWVwrRHMu8yruq9Iaf3vkcwfV3XWH713Ez746uMSpgpLTIjNLgZQrxb5blUdZ1K0YCcOTbqD/fk5EJcHXdw+gl09CGRG99RBdK2oZW1BifKTZvG2xRzgiAo=
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by MW3PR11MB4667.namprd11.prod.outlook.com (2603:10b6:303:53::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Wed, 18 Mar
 2020 23:37:18 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::c5aa:a4e2:63e8:d7d3%6]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 23:37:18 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Topic: Sighting: Kernel fault with large write (512k) and io_uring
Thread-Index: AdX9ef3PKRC8AConRsKyiM0hXsW0JA==
Date: Wed, 18 Mar 2020 23:37:18 +0000
Message-ID: <MW3PR11MB4684AEE8587BFCC0A9F41DE4E5F70@MW3PR11MB4684.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [134.134.136.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96766aca-a874-4776-a9bb-08d7cb954c28
x-ms-traffictypediagnostic: MW3PR11MB4667:
x-microsoft-antispam-prvs: <MW3PR11MB466767EE5E6B5FB77540E654E5F70@MW3PR11MB4667.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(376002)(366004)(39860400002)(346002)(199004)(86362001)(81156014)(6916009)(81166006)(45080400002)(478600001)(33656002)(54906003)(7696005)(6506007)(2906002)(26005)(66446008)(66556008)(76116006)(66946007)(52536014)(8676002)(5660300002)(55016002)(186003)(30864003)(66476007)(71200400001)(8936002)(316002)(9686003)(64756008)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MW3PR11MB4667;
 H:MW3PR11MB4684.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lO3pUVDey5qLcyMeyIZde+vMjS98bi40qaIE8klbB6LzHaHhHU4zJwokWB3w27+VR5nYcbdjZG67L1tepjd7k0dG3+jkpx7zx6iBZtQWJSjurB248a9NzcWnIy9eH+W1WbAlP+Owh/QJOYZD8WlFI5NTrK083E1SPAc2eanAXHuj2+NP7EoILaSkddTj/jrihYx2pLLvHfhn+gy9Xv3Mn4krGklpnePFFAHI/TtKGQjeFIt07QnS3o+Vyij2mULdx1qkSr2I8T6djO/vuGafZW279fIAtbUhFRJO3IIfXjSQjwBxvArRgYGf62E5gnzSpHdL3tB2Q5CI+PIGP7EbeSODYUODVpEWNiVODqFE3NuWQDvpqDbDM0hDr43WWzrUV5Iw0tvzfihCdY3yZ1bA2v7u2FsNHobKVNDf2lexy/xfgu1cvupD1f+4LxPRY3A6
x-ms-exchange-antispam-messagedata: PwqCQJchBZ2U7LkYfqs1lnmeoy1SVMT7f39TVz3qPn0hIdW5s4qFaomgUjuKlKyIK8CrVw29XP8sRV7vojbS6opfGeFRQUVrEPeW7/+ih47OXqIPiGQgTffM3oMCotvvd+hNWbVj3U+Cv55pEhbOOA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 96766aca-a874-4776-a9bb-08d7cb954c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 23:37:18.2771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RiaY+D2yyK2qcLGcslyMgnyKd0LTj8xwxi7eFrS7g484lTr7dN+jPp7wSJNhWeOEg6LEP3bDRB2LP012WxN130dsGO3LJq76tf0ugs4HVpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4667
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200318_163721_505306_7D783A7F 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hope all are well out there - wash hands (mine are getting rather chapped) and keep a good social distance.

OK for my sighting.  Recently experienced a large write failure and so I retested after removing all development patches.
I rebuilt initiator kernel removing all development patches, except the priority patch (but set to 0, making it a noop) and the three stability patches listed below I had to apply to correct a previous fault I had seen when using baseline branch nvme-5.5-rc.  With the FIO verify options turned on I see a different failure report (shown at bottom)  So, wondering if any one out there knows of some other lingering large write issue that may have been fixed?

Three stability patches added to tip of branch, suggested previously to fix an issue (list add corruption) I reported on linux-block list:
- io-wq-re-add-io_wq_current_is_worker
- io_uring-ensure-workqueue-offload-grabs-ring-mutex
- io_uring-clear-req-result-always-before-issuing

The initiator host kernel fault details are the following:

[ 1907.415517] nvme nvme0: queue 5: timeout request 0x11 type 6
[ 1907.415519] nvme nvme0: starting error recovery
[ 1908.432805] BUG: kernel NULL pointer dereference, address: 00000000000000c8
[ 1908.433229] #PF: supervisor read access in kernel mode
[ 1908.433536] #PF: error_code(0x0000) - not-present page
[ 1908.433844] PGD 8000001f8e7c2067 P4D 8000001f8e7c2067 PUD 202eab9067 PMD 0
[ 1908.434292] Oops: 0000 [#1] SMP PTI
[ 1908.434498] CPU: 3 PID: 5626 Comm: fio Tainted: G           O      5.5.0-rc2stable+ #56
[ 1908.434967] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018
[ 1908.435408] RIP: 0010:nvme_tcp_try_recv+0x59/0x90 [nvme_tcp]
[ 1908.435739] Code: 24 20 31 c0 49 8b 5c 24 18 48 89 df e8 d0 c6 58 d9 c7 45 60 00 00 00 00 49 8b 44 24 20 48 c7 c2 40 c0 26 c0 48 89 e6 48 89 df <48> 8b 80 c8 00 00 00 e8 3b 67 99 d9 48 89 df 89 c5 e8 c1 e6 58 d9
[ 1908.436838] RSP: 0018:ffffb5f309b7bcb0 EFLAGS: 00010286
[ 1908.437144] RAX: 0000000000000000 RBX: ffff89164c076900 RCX: 0000000000000000
[ 1908.437561] RDX: ffffffffc026c040 RSI: ffffb5f309b7bcb0 RDI: ffff89164c076900
[ 1908.437978] RBP: ffff8915f63e0460 R08: 0000000000000000 R09: 0000000000000001
[ 1908.438396] R10: 0000000000000024 R11: 071c71c71c71c71c R12: ffff8916624b2d80
[ 1908.438813] R13: ffff89167045c000 R14: ffff8915f73e5230 R15: ffff8905f53c9800
[ 1908.439231] FS:  00007f1d60ebc700(0000) GS:ffff89167f040000(0000) knlGS:0000000000000000
[ 1908.439705] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1908.440041] CR2: 00000000000000c8 CR3: 000000201e2a2003 CR4: 00000000007606e0
[ 1908.440458] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1908.440875] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1908.441292] PKRU: 55555554
[ 1908.441450] Call Trace:
[ 1908.441597]  nvme_tcp_poll+0x49/0x70 [nvme_tcp]
[ 1908.441866]  blk_poll+0x25a/0x360
[ 1908.442067]  io_iopoll_getevents+0xe8/0x360
[ 1908.442315]  ? __switch_to_asm+0x40/0x70
[ 1908.442546]  __io_iopoll_check+0x4b/0xa0
[ 1908.442777]  __x64_sys_io_uring_enter+0x19c/0x600
[ 1908.443055]  ? schedule+0x4a/0xb0
[ 1908.443254]  do_syscall_64+0x5b/0x1b0
[ 1908.443469]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1908.443765] RIP: 0033:0x7f1dd17ecec9
[ 1908.443975] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 cf 2c 00 f7 d8 64 89 01 48
[ 1908.445073] RSP: 002b:00007f1d60ebbac8 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
[ 1908.445516] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1dd17ecec9
[ 1908.445933] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000005
[ 1908.446350] RBP: 0000000000000020 R08: 0000000000000000 R09: 00007f1d00000000

If I turn on FIO verification options ( --do_verify=1 --verify=crc32c ) I see the following fault for same 512k write I/O pattern:

[ 4850.021884] BUG: stack guard page was hit at 00000000291034b3 (stack is 0000000040c9cc3e..00000000e65d9875)
[ 4850.022471] kernel stack overflow (page fault): 0000 [#1] SMP PTI
[ 4850.022829] CPU: 3 PID: 3744 Comm: fio Tainted: G           O      5.5.0-rc2stable+ #56
[ 4850.023298] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018
[ 4850.023742] RIP: 0010:memcpy_erms+0x6/0x10
[ 4850.023982] Code: cc cc cc cc eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[ 4850.025087] RSP: 0018:ffffb8ec09557b68 EFLAGS: 00010206
[ 4850.025392] RAX: ffff943ef5c2d840 RBX: ffff943ee9216500 RCX: 00000000000003e0
[ 4850.025808] RDX: 0000000000000800 RSI: ffffb8ec09558000 RDI: ffff943ef5c2dc60
[ 4850.026225] RBP: 0000000000080000 R08: ffffb8ec09557bd8 R09: 0000000000000080
[ 4850.026640] R10: ffffffffffffffc0 R11: 0000000000000000 R12: 0000000000000000
[ 4850.027056] R13: ffffb8ec09557be0 R14: ffffb8ec09557bb8 R15: 0000000000080000
[ 4850.027472] FS:  00007f5db8053700(0000) GS:ffff943eff040000(0000) knlGS:0000000000000000
[ 4850.027944] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4850.028279] CR2: ffffb8ec09558000 CR3: 000000203a052006 CR4: 00000000007606e0
[ 4850.028695] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4850.029111] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4850.029527] PKRU: 55555554
[ 4850.029684] Call Trace:
[ 4850.029834]  io_setup_async_io+0x51/0xc0
[ 4850.030065]  io_write+0xe4/0x220
[ 4850.030256]  ? get_page_from_freelist+0x43f/0x1220
[ 4850.030538]  io_issue_sqe+0x419/0xac0
[ 4850.030752]  io_queue_sqe+0x13b/0x620
[ 4850.030967]  ? kmem_cache_alloc_bulk+0x32/0x230
[ 4850.031231]  io_submit_sqes+0x783/0x990
[ 4850.031456]  __x64_sys_io_uring_enter+0x231/0x600
[ 4850.031735]  ? syscall_trace_enter+0x1f8/0x2e0
[ 4850.031995]  do_syscall_64+0x5b/0x1b0
[ 4850.032210]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4850.032506] RIP: 0033:0x7f5e28983ec9
[ 4850.032714] Code: 01 00 48 81 c4 80 00 00 00 e9 f1 fe ff ff 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 cf 2c 00 f7 d8 64 89 01 48
[ 4850.033808] RSP: 002b:00007f5db8052ac8 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
[ 4850.034249] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f5e28983ec9
[ 4850.034665] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
[ 4850.035080] RBP: 00007f5de40008c0 R08: 0000000000000000 R09: 00007f5d00000000
[ 4850.035495] R10: 0000000000000001 R11: 0000000000000246 R12: 00007f5deb0ba000
[ 4850.035911] R13: 00007f5db8052d60 R14: 000000000000c8e0 R15: 00007f5deb0e8a90
[ 4850.036328] Modules linked in: nvme_tcp nvme_fabrics nvme nvme_core ice(O) intel_rapl_msr intel_rapl_common skx_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm rfkill irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate iTCO_wdt iTCO_vendor_support intel_uncore intel_rapl_perf dcdbas ipmi_ssif pcspkr mei_me joydev i2c_i801 lpc_ich mei ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter drm_kms_helper drm_vram_helper drm_ttm_helper crc32c_intel ttm drm tg3 bnxt_en megaraid_sas ptp i2c_algo_bit pps_core [last unloaded: ice]
[ 4850.066910] ---[ end trace a22216d511ea2653 ]---
[ 4850.083136] RIP: 0010:memcpy_erms+0x6/0x10
[ 4850.097681] Code: cc cc cc cc eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[ 4850.126922] RSP: 0018:ffffb8ec09557b68 EFLAGS: 00010206
[ 4850.141247] RAX: ffff943ef5c2d840 RBX: ffff943ee9216500 RCX: 00000000000003e0
[ 4850.155619] RDX: 0000000000000800 RSI: ffffb8ec09558000 RDI: ffff943ef5c2dc60
[ 4850.169919] RBP: 0000000000080000 R08: ffffb8ec09557bd8 R09: 0000000000000080
[ 4850.183902] R10: ffffffffffffffc0 R11: 0000000000000000 R12: 0000000000000000
[ 4850.197649] R13: ffffb8ec09557be0 R14: ffffb8ec09557bb8 R15: 0000000000080000
[ 4850.211195] FS:  00007f5db8053700(0000) GS:ffff943eff040000(0000) knlGS:0000000000000000
[ 4850.224881] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4850.238645] CR2: ffffb8ec09558000 CR3: 000000203a052006 CR4: 00000000007606e0
[ 4850.252631] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4850.266603] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4850.280477] PKRU: 55555554
[ 4850.294045] ------------[ cut here ]------------
[ 4850.307618] WARNING: CPU: 3 PID: 3744 at kernel/exit.c:723 do_exit+0x50/0xc00
[ 4850.321397] Modules linked in: nvme_tcp nvme_fabrics nvme nvme_core ice(O) intel_rapl_msr intel_rapl_common skx_edac nfit x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm rfkill irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate iTCO_wdt iTCO_vendor_support intel_uncore intel_rapl_perf dcdbas ipmi_ssif pcspkr mei_me joydev i2c_i801 lpc_ich mei ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter drm_kms_helper drm_vram_helper drm_ttm_helper crc32c_intel ttm drm tg3 bnxt_en megaraid_sas ptp i2c_algo_bit pps_core [last unloaded: ice]
[ 4850.397550] CPU: 3 PID: 3744 Comm: fio Tainted: G      D    O      5.5.0-rc2stable+ #56
[ 4850.413832] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018
[ 4850.430246] RIP: 0010:do_exit+0x50/0xc00
[ 4850.446603] Code: 25 28 00 00 00 48 89 44 24 28 31 c0 e8 79 04 08 00 49 8b 84 24 b0 0b 00 00 48 85 c0 74 0e 48 8b 10 48 39 d0 0f 84 f9 08 00 00 <0f> 0b 65 8b 05 1f dc f3 78 a9 00 ff 1f 00 0f 85 3c 0a 00 00 45 8b
[ 4850.481036] RSP: 0018:ffffb8ec09557ef0 EFLAGS: 00010012
[ 4850.498330] RAX: ffffb8ec09557dd0 RBX: 000000000000000b RCX: 00000000ffffffff
[ 4850.515836] RDX: ffff943e6c381fc8 RSI: 0000000000000000 RDI: ffffffff884b03c0
[ 4850.533342] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff87ec3be0
[ 4850.550859] R10: 000000000000000f R11: 0000000007070707 R12: ffff943eeaad4000
[ 4850.568303] R13: ffff943eeaad4000 R14: 000000000000000b R15: 0000000000000001
[ 4850.585730] FS:  00007f5db8053700(0000) GS:ffff943eff040000(0000) knlGS:0000000000000000
[ 4850.603111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4850.620223] CR2: ffffb8ec09558000 CR3: 000000203a052006 CR4: 00000000007606e0
[ 4850.637392] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4850.654398] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4850.671306] PKRU: 55555554
[ 4850.688099] Call Trace:
[ 4850.704867]  rewind_stack_do_exit+0x17/0x20
[ 4850.721813] ---[ end trace a22216d511ea2654 ]---


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
