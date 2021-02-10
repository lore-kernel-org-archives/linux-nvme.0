Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D1C433E6
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:16:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D2D64E02
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D2D64E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=1JL0GZnjpm0gaXqr/p1K/U1mNIbjVMyFSYc+34dUXuE=; b=yZzeak+5St2BZcday7RRgx3y2F
	REsGK4F/I9a/nm2uyMfnGUfJzoTtH0EzXEMFuTkBZGm77urJ4lgWX6caFjr3mGmSxCeLghoSioMp7
	4lO633ouZJlt6cqJ+YkwBb9+0L0FQQSk7Jp6lif5bl5G4OIE47bkBkrJ0xpH4rkjxYJPeRhBCMOo6
	vVkRYQ3rHk1z1TkRPtKG3x5wZt38mj0rvK0XMzDQ3alDYIFAFu8B87wjTyH+Z6iPJ6HQeXHXoHS2J
	BamORcg4dOGU8loH2Eq0Xgji9yYksH02OAwTPH5ag77sGN44x2F2N4S86ikDDhvUg3IhcET5mbhBz
	tvuzRK7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9xmu-0003hU-JE; Wed, 10 Feb 2021 22:16:44 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9xmr-0003gi-Sx
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 22:16:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612995401; x=1644531401;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=CzTXdTnmS+XNYheOT8TWtx5v+vPY3My9SuEoFqjNhlA=;
 b=eqpmXrK9D2lzDGo2XOuX+c0/4+XZBmkU+9edUQIW4N38VnSfqORFxd69
 bKlYn1dsxS3+GabKqnwRITjwjUnmLFmOjOe1BdZn+aMl+zKmLTkUPiYVI
 wkIydCl+rdAFG8OdNzwFajxn8XwPTT0DdBQQRPDzukmvg0PhV7D0kLrh6
 +gyxZ55KTfZYO8k6ioHbxcxHbgrPc2N0a01r1XrtAg1FNm4MfyWg37JpS
 5w2kbJFQZaJCM7COJ0sEfgqO/PLm9BQGh/izddoEkarTdnD69rOSG6KN/
 7YQl00UoztIA5PyedcbyMuia+Ou3uh++L29Dt9nwdzmzjrz1v59rhyTl5 w==;
IronPort-SDR: Uvs2fz5ePwDwKQnPtDCbe5Amb+EXAIL9XrFhFICwpthdupsUPgRc5dAHFWHNSQ5vcihhqlrR6o
 mGCYcbfkp4TgflyTEXMa5qer7ClmpozWZX88BVAFTWwakLr0vQihd/VQ7svbDI3w4a5Hm91vgL
 hrzQakGxMK2dbqJ9xdNi4ZMBiDnIEsEbkdzKGhdxk9fq913gDHRGbL0gGqSKLFK+sGKcaWZRox
 FWevJoLMTMXVWtqQc0TYz6vK1ye10LGC9TR66pueMGTzhztmzoefE/d/6qTJuZHOn0sY8VE9Gw
 07A=
X-IronPort-AV: E=Sophos;i="5.81,169,1610380800"; d="scan'208";a="159693722"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
 by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 06:16:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1Sb4p96ZyxnbBkRciZhIXl0vQTPrGdI6vYlgXQOudT8eUxTMs2rwdWNpuLO/wKgpZXfUGJEWh21A3GOULpT12rzsMRonwfW1aKBJ51dJn+lZnPV9gDhPsLGb1EDqjSpESO7iusc7LkfiSWKSLXr0jIF/vrifhrSW0wSS8SePxTgSSYuXacD9Q6XmoqFXFbYRbsUBnaUyAzE/QFX0CCXS/3SYT0vi8jPbvrknTlq+FOJBJDJBGPG6ngZ2l8sGvFL/ky7arx9WHx14e7TdN4AaNJF8B2//nSZ3xyroo1HihntEKG/+53KfVytJ2fcce4wvLxXKpuNHViWrOZFLAdalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CqWv5ro76LRzXnq/IYb2VC4b8BGs/8YH8iPtZnx68A=;
 b=O07Up98d/hDRGWLp5Gav8k7cJryYijW8IPB5uZyePBArz2A8JwNHDVb0t/YCD98eoNEuis3PrghGEohecVJIxCh6bGHBM16kCrjIO7F32pE5VeKFXP2dgyqD95wdwuqoCUvAqNk9gDXRwdAtZkmH4Qs9nU/5gIwgEypzmO8YSb722f/sJhDj4XIfV9kQLEXI99h+5lRM/JmKmzgWBsScMuRII941NcwyMHfF8zFwxN7lpfjZwYU9bbFJxuLVbxIvLT9TwRqGzmw/Z8XV5AJTusTOfeNxbb5XHS6/648l4M8sgIVLdR7QlqLJERr4vAo/Cgoum/KN8h67cLKIC+uXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CqWv5ro76LRzXnq/IYb2VC4b8BGs/8YH8iPtZnx68A=;
 b=T4RY2ZJhDrXI5r36P6+4FkqyPhH2gc8PujhGaYQDT0grDESWx76CXiisIyX8tosIBaZwOuHjnoUZ3yhaD+kW+VaSHvPW28DiU8UL8Cd0/PnTfCKY3A4nqzIAcYI/WRQv+g9WzFzWXOPzTSd3shPISJBt9DQY7AcDMUXIMjFN5Pg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5526.namprd04.prod.outlook.com (2603:10b6:a03:e9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Wed, 10 Feb
 2021 22:16:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Wed, 10 Feb 2021
 22:16:39 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-tcp: fix crash triggered with a dataless request
 submission
Thread-Topic: [PATCH] nvme-tcp: fix crash triggered with a dataless request
 submission
Thread-Index: AQHW//mDPl8TPwWlMUWT3oSY1CnHtw==
Date: Wed, 10 Feb 2021 22:16:39 +0000
Message-ID: <BYAPR04MB49650F2CB6A009986E0DC517868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210210220400.1730263-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2607:fb90:482b:10d6:f4fe:f24b:7108:1811]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6595b301-3b83-486f-d73b-08d8ce1189c4
x-ms-traffictypediagnostic: BYAPR04MB5526:
x-microsoft-antispam-prvs: <BYAPR04MB55266E5D132A4DD7CC2F4390868D9@BYAPR04MB5526.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+Ft1Fgq5OuU8zxE7nqzjAmyGXI8Jdv6HO1eEw9vxqN6kZbtNB/1yPnCDYobo68pqTWk3W8liCblfKoRIK5tMGAhrCiUPxLsPLVEXerON+HCmzjxpQR5hyidxGweUGw3BiOoR6sc3aY0Ko3M4hQB+cp3RIJjO42bkBEOCun6Em3Zjo7bgMq86h+Phy0F73KQKOSfn1E5cSF4PZmsHd6b+zQUFs/airmtVh2ZWEhlzuhVKLIObXU6eEDUq2se1qLxOGuepO45FP2O8N4GE0PF91lJXqQ2poLkjdr/KMfugvVXep/Dh4FC7VWFHeuCO5BzkV9KlnoNbzhWgiTohtTh05bHyIK0TNfxnKiXGiqqlwFkyk82Yb7O5GUK1BnbvthdvZ5dBaWXg7JU28TCYtQ7YsReZg8jOG2xF7qlHxiHce1EjnKZ8xVc4gD7ETuqng987Z6Cj+nC2cR0L8lLNcAUGMJPBmCFnlypE7+Y3CLO1uNQPEUQ8X+Hft1hAUGsZds4i1ax9BWSHS2SEiirJc2n3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(55016002)(8676002)(33656002)(478600001)(2906002)(6506007)(53546011)(9686003)(110136005)(186003)(316002)(83380400001)(66556008)(66476007)(8936002)(7696005)(71200400001)(76116006)(52536014)(66946007)(66446008)(64756008)(5660300002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f0kWeSFHbxwdvO6IW50TY/ITtCCrwCucF6PpwcpNAmGhR6VRTMoJE8ziPk96?=
 =?us-ascii?Q?9rBBXwq+w+UDP4uJ4cBJHBeSDWEcRFppQjyC7oFtZ22/5b3+wTjn/eNHuaC7?=
 =?us-ascii?Q?48EODx7sbQyBSfslO+svM1mRoB1MEW1WBntQr/wJX7/F8bcjGjoHhndTsuPY?=
 =?us-ascii?Q?dtT/pWTcjwSqPu4uEWjzLb1suIppkONutPVjCh7oHmZGkItCrQmgtTIaHfLe?=
 =?us-ascii?Q?YvHqnVqnGkcQXlVy58JUYaZtC31Uu/WT4mk8Abj4/q5bGW6z+31DF3tWR8mV?=
 =?us-ascii?Q?sJ+zC2kfZ+n9BNxIz3c/nHODLNK9D4fB1ci4dE76j68rV3jCTYfQNJ1Y04GK?=
 =?us-ascii?Q?EytOcxAHVOgxhM9PImkW3BUVMGxTQBrYutDRqXl6/7SV1rB+ur/IkIFN+TvV?=
 =?us-ascii?Q?+IzvTV3YDbV8/0vfKpcOZbQ0BwOQaNwI2VwYs4HLAcf5gUHU4JbJaVA8sE1H?=
 =?us-ascii?Q?4XESMnE/O3A10HLFrnMcX/9xACO9pYBYlSW3vi3mrYkF6iktklvnIP6RxBT5?=
 =?us-ascii?Q?HJPdDIINENAByVIZ8OlFVGpryy5X27w2xrsVfQ0rgnrNGPrzioZZv2/s0JXN?=
 =?us-ascii?Q?yqR4Oi3MSHDpZY++Cpfzxji4twSLNL1sXnByHWEsJN0YN3AQLfiCtuv2LNDz?=
 =?us-ascii?Q?7ATxzBQh3ngqfyUE76GKdwLUZ6KK6r7aaaRtJHLkt9H2rv6qXc7rMTKTaUlw?=
 =?us-ascii?Q?jxIQ+XsACClc2tcAxFyCDst/+xxNaBAAU9a7MmS3mlLfw62MEYOoxivCiD2n?=
 =?us-ascii?Q?O4I5amQzKbmG6TEczACKk+iQh1h+wLLolqeY/KjMNc8KgfD7QSz06nOT4fqA?=
 =?us-ascii?Q?hsn0JwwbrKtBUt6qxxW9Rhj14k2pI9mMD32dK/sX+4MS8MMU2Gr8SxJzlWE2?=
 =?us-ascii?Q?vMUj/etlWJ8s84CM16WqsJMRjJ+rvbtm197v3NsCBW7wWwxwRjKnKRQQ3wzA?=
 =?us-ascii?Q?+IMRUPa42fwMDvuwD0gJ9fKgj31OzHgrA9183X3Xokm08AaxMJGGys+77kPb?=
 =?us-ascii?Q?0mEThfcwpjNxveP+Ej7R6YqaDuRlBbFdHw17oVnOWUq20n0lRoZ+32nj/ot+?=
 =?us-ascii?Q?PN8zmHwaloCEAr3NrOqzgc4ZUeoJQ6IGqs91ZYNyUEWdO5etfXf8uabUQcPE?=
 =?us-ascii?Q?eqSLtd5oiSbjjJfu5sbgT7Gm1Q8/Ad0WDh60skw6pCj1ZJyeyjNYFdFT3bPQ?=
 =?us-ascii?Q?FE98pxBnSIklu8c0+eXVLm7pjiXWyrES8/pwvtkv1CQTcZz3aQELZ2lHllKq?=
 =?us-ascii?Q?81RZsvNHhdqlxEFtHLmyW1QO6NBKOc8F1/C6wHaKYKt+sL50xJPsxNjK+jbB?=
 =?us-ascii?Q?ddZCktdSKxtOpeaYY6ZnYAXx4JEQ5/VvMT5KVxWqiDEY59g+GatF+QVHs8yH?=
 =?us-ascii?Q?R34udO6wNBSq2QXIqy5Jda7tVw4wkECRGezg3P80n9s4AnpGzA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6595b301-3b83-486f-d73b-08d8ce1189c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 22:16:39.3250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5njlOTPI8DYgIbznAPnXF2s+BMNAOJOCjuNWq7BZV7QgBh/bHNQZq9F2tuxN3d4J8GIijwSPoKLLJGbEZGhr35UlUQJnQQmirIweiT7rpNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_171642_070556_B2AFDF61 
X-CRM114-Status: GOOD (  13.61  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/10/21 2:10 PM, Sagi Grimberg wrote:
> write-zeros has a bio, but does not have any data buffers associated
> with it. Hence should not initialize the request iter for it (which
> attempts to reference the bi_io_vec (and crash).
> --
>  run blktests nvme/012 at 2021-02-05 21:53:34
>  BUG: kernel NULL pointer dereference, address: 0000000000000008
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP NOPTI
>  CPU: 15 PID: 12069 Comm: kworker/15:2H Tainted: G S        I       5.11.0-rc6+ #1
>  Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
>  Workqueue: kblockd blk_mq_run_work_fn
>  RIP: 0010:nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
>  RSP: 0018:ffffbd084447bd18 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ffffa0bba9f3ce80 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000002000000
>  RBP: ffffa0ba8ac6fec0 R08: 0000000002000000 R09: 0000000000000000
>  R10: 0000000002800809 R11: 0000000000000000 R12: 0000000000000000
>  R13: ffffa0bba9f3cf90 R14: 0000000000000000 R15: 0000000000000000
>  FS:  0000000000000000(0000) GS:ffffa0c9ff9c0000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000008 CR3: 00000001c9c6c005 CR4: 00000000007706e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>  Call Trace:
>   nvme_tcp_queue_rq+0xef/0x330 [nvme_tcp]
>   blk_mq_dispatch_rq_list+0x11c/0x7c0
>   ? blk_mq_flush_busy_ctxs+0xf6/0x110
>   __blk_mq_sched_dispatch_requests+0x12b/0x170
>   blk_mq_sched_dispatch_requests+0x30/0x60
>   __blk_mq_run_hw_queue+0x2b/0x60
>   process_one_work+0x1cb/0x360
>   ? process_one_work+0x360/0x360
>   worker_thread+0x30/0x370
>   ? process_one_work+0x360/0x360
>   kthread+0x116/0x130
>   ? kthread_park+0x80/0x80
>   ret_from_fork+0x1f/0x30
> --
>
> Fixes: cb9b870fba3e ("nvme-tcp: fix wrong setting of request iov_iter")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
