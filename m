Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93578C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 06:52:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A3620691
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 06:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zSr+9gtr";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="gQrxSWge";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JWN/d/RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A3620691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=aCcFuLFhBs8kZizvivEQgumTURhrTVIh+kz2J2GXTBM=; b=zSr+9gtrxx0blTKx21pimUGIv
	74ly3UwfUE8fzzUydp8MU4YHhAuHJFRWqxUUMsHVLfh4T/vJFcx0EClkoR4Ctb0qk/moMPtywVaNe
	zJWea6lgV6Kica1m+qodtroIKL+4J+ANWDNEK+7RL0EJmg3Kcqi9x+U/A513YWnzXgBP2E4KKgZwW
	gFZCjjsJiQowfuQDlOtuDBjBCsdIj2BLXYHFzoXqMAsIOeVUh8K7YxjYvSpxwQhckPzjklSvBW6lS
	SQWz82rq9O/i/AV9KbYuKmZ0Gc+8sMcDH7EnWUdRcJNnzUKHrRLS2SZt3TbAktlmxPr9SPXnFfqOp
	L+cn6fFnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjd2h-0001iZ-Rf; Mon, 30 Nov 2020 06:52:11 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjd2a-0001iB-WF
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 06:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606719968; x=1638255968;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Z5sn7p9H1RbLs2hq4omKJ1UU5HFMsOUhHwlXiVtYC8w=;
 b=gQrxSWgeZD8U+dI9OKLhgBb6wFrbHO7vjZbOE2lBLwQ5Sv5BPD7S22oC
 IxxwMn8gKFnM8BqLP74xyNKZAtPedrFR/hlyvmxfpc2KRwvgZ4lkgwYgg
 sLWSQyUjg+qqWcT7u0llQb/SX/o066FOKU+eBtqSk26rdfw0cEyIRGwpR
 035nnrM8GOXuOBgtZNZWP2Sr3//zrOA3Ko5oCMB46zwiD9f5Y9C/vWMTJ
 rqOzhZEWtqfJzfUxzsDNn4NQdZSangG1kd5tUtn+Fo20VGWev7vxXF53B
 efjbxFGFwlzBTuhxHkgYJOJ9c/sFvep53eVTjfYGAOPHl0SU9ct892McB A==;
IronPort-SDR: s7DCsRknmA7mVeZUOzRrIHKHnBBUYiPSNHGLXkWX282VDIPuauwDxdxLn4TPUnY4tmofc7Xg4a
 gRlBvlFNUabkzxwHMyti/8VdMRtMA6teh5wu5kih288o3j/Fz8x2SvbHvaeFfqfcAym6cWku0p
 8KyU52dZOfTN4hGA9jUTld5Wg5oLOsZAaeTuvXZXk3xCTolhT7ttojj1URs+hHLr47zmqhkfZB
 tWF0uB4IGnTYQ6bF4DyW1hKRZVc3atDjAhgFE6jleYwxrNFgwwsMrTA0rFvJhIZpEyhVVXggWy
 Ags=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; d="scan'208";a="257463384"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
 by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 15:06:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4owiO4Sp2voIRcyWRIYPJnFJEF49V7FjD+eKHmFF3W1GarfbHg5PqVb293ixr+nbImtKA7/B74vPMqqbbqSjWpLRSFulzfjYOp/mwqc9KTWznZdP/g+Pw/nWQpXEi47T+vNPghY4mRYD/jMalot5PzOpTojNQgWix8GZTc3YMstwROqYDrQndUIAD2rK1zAga5qONHshh+vsQlgsjNHmpFRoUs1eQ2ETPs0viH+N8zkrcC8jm8CJPuWcESyhefD6u0stf4b5bpDJxe9kL1lHuKiGH5hWUEVuBVaDFPOAj0+oRvAzljr8X9BkoHh2p+2k6CAWz8g+II6w9DVZE2Uwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbXXW3AiFclrzzxSdlL9nqhFxk51UELwMWUwAfb3uQs=;
 b=cmn1zfaGfVQSqZQnGHTJBWdzngW6GZ9E986PdVRBr9WwyGZmdcfoP62pXT23zE5UKGAF2tz0HVe/GJpyGFRic3EDjjU1Xgs9Foit280sEgasTrd6PEeS9CXya7H3ZbaesdAi7hddFa6/byLxc4MmWh305RhR6jzOuEjeHzM2iIWC/p+/ayU9qlBGzNhYSUJ0jwEgIDipM8CuCuvQmfghSqfW4v72aXHEtmW59ei8I8kpjatTez1UMzsACUeAvb+XRIhuvVxG6GtFiufw69RJJjJgdCzzu/Kz6FIY9y2pr2RaTJCxriZy9NU8/milqfchBX7hXIJyR0dUXXmkztByFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbXXW3AiFclrzzxSdlL9nqhFxk51UELwMWUwAfb3uQs=;
 b=JWN/d/RDsfqp1qxn0loRf4jZoiIo/Saxd2RwIhdiWJVBZs+n4KTOpazsHUyMCDJP4WBKeiUman1uN5dOUBm9/MQLUcHM10DF4afWFp6s6qqqtem4bDlo7Gmmq4kWoH8Gow19HswUyjht3Su9/kjMxnck3QOrfRxdAgWJvOQCDmg=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6885.namprd04.prod.outlook.com (2603:10b6:610:92::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Mon, 30 Nov
 2020 06:51:59 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 06:51:59 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Topic: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Index: AQHWxsj8BV6nBA+s3kKgMz1iixbxTw==
Date: Mon, 30 Nov 2020 06:51:59 +0000
Message-ID: <CH2PR04MB6522E1D0137093EC187E7AA3E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abca2fff-5a03-4d60-d745-08d894fc6fb1
x-ms-traffictypediagnostic: CH2PR04MB6885:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB68852DF0120D846E6B3ACA89E7F50@CH2PR04MB6885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Q2rvzpEGyzPmHA2ovLZdKLHOOWxJYHYgOeZR5ylM6rZZxBEOMaTHJilWoCftFnh/TABHLLQ2kqjN0MVzbALdVfd67bKV0nigJxhcUvylUz/3RUvPQi8BYp8g4OA0Tuw/iuigp+KKAaix7h05qb5WkzEP8dJwkaoJJJFcqqVYHdaslgdz0ob9eHkmmKoksmFA90579ih0qr6GZirmH/0gcgvo91ziFpuHBjaVaUedAsi96U6kIfWfECGxBh9DPNCHfXEf2BjP0I9hwofn28u2Q8JVqFYoD9fyeHbayMmo7ECAuBVfDbwg1ukzGL/VeJE5kFR0Me0btUJb2DrM8kTCg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(55016002)(9686003)(76116006)(83380400001)(7696005)(53546011)(8936002)(6506007)(52536014)(66556008)(478600001)(66446008)(64756008)(66946007)(66476007)(91956017)(4326008)(5660300002)(33656002)(8676002)(86362001)(71200400001)(2906002)(316002)(186003)(110136005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Be4izRlAb0oKPYBMpal7QOqpNvF1gVLu5PixAMc6IOvgznoDl7Q+qhuumpWI?=
 =?us-ascii?Q?VQgBZWf/S3HGc7CQ+Bs8hcYCP59NEA8BchSY4PAf7GA1ezCowsOWoW9j2U86?=
 =?us-ascii?Q?jDfmeF1fpFPtPM4EZir1tujXeVlkeeKrcHFzX8D2DxnLH4/Gk8ZvJJHlDLZV?=
 =?us-ascii?Q?OlYdhCIDJrpCvNvQ2ECXEOocQcNd1OzZcLsZe45VWEvDGcjLPJsiLbYsAz8I?=
 =?us-ascii?Q?jwPGovpK7LZxLRw6/9NK5ulKWWl5jEdwIAoT7wmItRE5piXLRgOJW8sMON3K?=
 =?us-ascii?Q?pzoxwPRzLH4jO5zdmOmzLbRdOiDLctOQB31PlZjt4lupXZQkiw9FtjyvnCDU?=
 =?us-ascii?Q?MFIAaGIdgFd4G13Zw8Cp+IVMHqijekRpzxq+5S+h3nS3yIeu9lD1GPZ1I8f4?=
 =?us-ascii?Q?pfhP+3gj+mXFaewv5XjGCMnV1vhSgvDB6P4KbJVblVFLKUQc7kZ1E9N/mxFJ?=
 =?us-ascii?Q?u60kA8w61vPmq8d3yXX7Nd8kUcTdGEv1eLr0Ar4EJMHwXYjL0LmKXFOltXxY?=
 =?us-ascii?Q?PakEpoepf3NUnTo1Pr/oB/vAqvk1zLmEqszS5UnHbhPQnlLawMR0dfMxfG/7?=
 =?us-ascii?Q?gqTMXx3FX7FCMTGG6t5ZKiayeh9LLgJ7sAJ1M0nN8e7EMNk5vOF0e7Ba6GhS?=
 =?us-ascii?Q?+6hKBKgoKbKkJsTUZKmS89YxobrDJr38o60iwPDUgGoO+Nu0taOCA94Zosmi?=
 =?us-ascii?Q?jSYpZNAlG6IjHIIACRD+NMBo0Kuri+R5/tJZ5HHQCwkxliymaekvCncw+Czh?=
 =?us-ascii?Q?gqdYcijuoApQjifOqLbe2G01kJDER/YiQTP+8SwMpZFKUK7tnr84C0WKnFqO?=
 =?us-ascii?Q?jKBWfk2629BPFbl+/sNzorJ5uvYutmHCcnAHpLepWgWqmYH5LsilkMLYt7mE?=
 =?us-ascii?Q?akx//u8FWsCu7y1guvtqjUldxXcrM4sVgskcOAn01owsMMir9clM04Alw801?=
 =?us-ascii?Q?mtOpneH4CGRj0SIKOFWHGXNcCGL+uRH57tcc+O5rN2YlQO2mSq2qdgu/fQWY?=
 =?us-ascii?Q?Nu92bCtlVpFeaqe+rv/qnrIhLyOC39NUkExTGuXZfERmTbDmW34ykR5dDN9B?=
 =?us-ascii?Q?+o9Mkd4Q?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abca2fff-5a03-4d60-d745-08d894fc6fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 06:51:59.8564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjKTKCnwKP7VDqWTB0DA9FfA8aq4v50abrOKkmSYtbN+yd1iwuS+zvDGNRycJ2AxHyl/XaZvWiq8MBIJ4cI43Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6885
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_015205_363848_88EFE1A9 
X-CRM114-Status: GOOD (  26.73  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/11/30 12:29, Chaitanya Kulkarni wrote:
> NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block
> Devices (ZBD) in the ZNS mode with the passthru backend. There is no
> support for a generic block device backend to handle the ZBD devices
> which are not NVMe devices.
> 
> This adds support to export the ZBD drives (which are not NVMe drives)
> to host from the target with NVMeOF using the host side ZNS interface.
> 
> The patch series is generated in bottom-top manner where, it first adds
> prep patch and ZNS command-specific handlers on the top of genblk and 
> updates the data structures, then one by one it wires up the admin cmds
> in the order host calls them in namespace initializing sequence. Once
> everything is ready, it wires-up the I/O command handlers. See below for 
> patch-series overview.
> 
> I've tested the ZoneFS testcases with the null_blk memory backed NVMeOF
> namespace with nvme-loop transport. The same testcases are passing on the
> NVMeOF zbd-ns and are passing for null_blk without NVMeOF .
> 
> Regards,
> Chaitanya
> 
> Changes from V1:-
> 
> 1. Remove the nvmet-$(CONFIG_BLK_DEV_ZONED) += zns.o.
> 2. Mark helpers inline.
> 3. Fix typos in the comments and update the comments.
> 4. Get rid of the curly brackets.
> 5. Don't allow drives with last smaller zones.
> 6. Calculate the zasl as a function of max_zone_append_sectors,
>    bio_max_pages so we don't have to split the bio.
> 7. Add global subsys->zasl and update the zasl when new namespace
>    is enabled.
> 8. Rmove the loop in the nvmet_bdev_execute_zone_mgmt_recv() and
>    move functionality in to the report zone callback.
> 9. Add goto for default case in nvmet_bdev_execute_zone_mgmt_send().
> 10, Allocate the zones buffer with zones size instead of bdev nr_zones.
> 
> Chaitanya Kulkarni (9):
>   block: export __bio_iov_append_get_pages()
> 	Prep patch needed for implementing Zone Append.
>   nvmet: add ZNS support for bdev-ns
> 	Core Command handlers and various helpers for ZBD backend which
> 	 will be called by target-core/target-admin etc.
>   nvmet: trim down id-desclist to use req->ns
> 	Cleanup needed to avoid the code repetation for passing extra
> 	function parameters for ZBD backend handlers.
>   nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
> 	Allows host to identify zoned namesapce.
>   nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
> 	Allows host to identify controller with the ZBD-ZNS.
>   nvmet: add cns-cs-ns in id-ctrl for ZNS bdev
> 	Allows host to identify namespace with the ZBD-ZNS.
>   nvmet: add zns cmd effects to support zbdev
> 	Allows host to support the ZNS commands when zoned-blkdev is
> 	 selected.
>   nvmet: add zns bdev config support
> 	Allows user to override any target namespace attributes for
> 	 ZBD.
>   nvmet: add ZNS based I/O cmds handlers
> 	Handlers for Zone-Mgmt-Send/Zone-Mgmt-Recv/Zone-Append.
> 
>  block/bio.c                       |   3 +-
>  drivers/nvme/target/Makefile      |   2 +-
>  drivers/nvme/target/admin-cmd.c   |  38 ++-
>  drivers/nvme/target/io-cmd-bdev.c |  12 +
>  drivers/nvme/target/io-cmd-file.c |   2 +-
>  drivers/nvme/target/nvmet.h       |  19 ++
>  drivers/nvme/target/zns.c         | 463 ++++++++++++++++++++++++++++++
>  include/linux/bio.h               |   1 +
>  8 files changed, 524 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/nvme/target/zns.c
> 

I had a few questions about the failed zonefs tests that you reported in the
cover letter of V1. Did you run the tests again with V2 ? Do you still see the
errors or not ?


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
