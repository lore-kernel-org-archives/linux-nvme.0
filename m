Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC6DC56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:07:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5628520857
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 08:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mGLdLlqW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O0LzmW9N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G7aLFU89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5628520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=DpKLMyPu8Xqb/+8Y4MyaXYK5JK9m7Jjjqm0pET9QyaA=; b=mGLdLlqWUFv2NHXpO2Pzdi3AK
	HmikA4aF+dOdFVGkUXRckzBcRj1/BMd9/FnaUMv3zvSfISXuAkUSN7KpFrqM2mE+8qoz59nsMgZXL
	FLwvjovnTVDuUOtb0Mi2G639WS1m99pgRKafoRt+pB1TwpNqftqoxzMB2NMt2t4jW1iCN4lf8lc1n
	PYSWpZI0NCAhcG+B5tpkXNCpphPvywmqfVGcZfVgJtoJJB4gOMHa7xA1zo4lyP4iogCJOwzLhG0Va
	vCXm3Hv8Xbuui1jzktQ8M9IebCvzE9vg1i+fh0C4cAEnK6ZSc1TsDE7hUEby5XtVXIB8qkDn9hXZ1
	8yhDhB/eQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiCJA-0006PX-Qr; Thu, 26 Nov 2020 08:07:16 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiCJ6-0006OO-3S
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 08:07:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606378031; x=1637914031;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=NMkXzWl9vqOqhQsbPNbe2yXwV5dxbO7x4kmD3Q+Paig=;
 b=O0LzmW9NOtysq6WF1y5cI8Fg4kDqgZCYeIkrp2JZREY8kZ1gykxQtOh3
 DMZiC+SkuHvdI/bQp20VRYbz+X9suIdhOEZ8Gky6yc1Mg9ldHT93PGcTh
 dMWvRoxh+wfKOloeze69c7DYLfOHdxs4oczWnE1ss3IiZFdhMi74eIHQm
 znpfQoxeBza1ZnxsY0OH+vdak8yDt+gigJkskolZHAoJ23uYTY0LKL0JK
 9RhaQRnoRnEFkdQo465khSY0TiGB+BCnXwyxNykMUdSJgF7yRVSiehD4W
 bLXm6OYQeBqSbHtq0SZNfaifOVS3Yh7J7bsFsaVylMK63FONFboG304Cn Q==;
IronPort-SDR: CQLOfUfPTizXWGJSe88qeHedkSCVb1eHtgFMYVyvjlv3Tz3hR8DwZsp8u+zgMLCX3EUT72SxIp
 WkoX7+g8TpUE69hEZG6qqauAh8pur2ZA62rjNzZW0muGI8KLoR0gyGJSVlW8xfz6aNgJlqB7Mw
 3ts8tBLif/qwp+7mu6coQW5WjHrITyMyFFYGjJzAa/rJoCFws9xH40uIz90+l72E2mq19ayNKS
 fCX3szNTfFnaoyRghCQR83HegeBl0o/mKqTklguK1M9v93k59q3Jp103Z0XnclWaI7mp68G+Th
 EvQ=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; d="scan'208";a="153609522"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 16:07:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEVo4DJgDfoDCHzndjYASaHfHsIQ6Jlsz+1YuH+/jdgqkwgGwL4jzCrClkZqJFRNtyFyLNEXAkkMUVJEG16CULHc9J8LGtnJY9aZqwS/Pt+11LUFnqMLv/hbDW0DVHA9f1yuWwh2pWl+icT3i5D5mYIMHmGi3Vx0/xaruYn2M3WEBhjOHb0NPxFEuwPsjafpPjv6MnZKcVJWagOrZAmGqoeyQPauuUfOPIWUpA+CgS8k+6cTZo8tN6Z/5XYiHWvlQ+WaNMZF+FuPu0kLqpMi3AuC9DJQzjmDU7HpQVwPCzuFUyohnv/0lXpZJlamsNYhSO9urW2fG4KJlBHmSprcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGZifd9A6U1fpeko8iHtjlVvtGtx6USj/eCs+c3Wdso=;
 b=dlfkZwZOa6czr12A+ymvyc5ys2ZuQ+V9+hc8L7w0E+RUFUjNVCErfX+woIxq28OhdlxVpfLy1icxiqm8bHfef2LnZ5BUEj94ouaKz4pWPRZt97fIzBxgkgkAs7n1QpEQ7c8RHfOGPktBldUZvMmdneNHdPRCrJ5bYhJwupP6T4DTdRLMa3VVMzjjZv1YOQr/Q38Am2fyK0Vy0d880bO6l4j7qL/sPK5qFFkZ2qUs/gIhB7JwbQx8JbVpFXu3FSj6F/pg6rvfO0N81XV8bU5U0cgw4B3eltY6/1fQbwMEyyDGqZnBIF1fmlnxLhPCOj+Ikrvn92c1z9m0eyVYsi0OFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGZifd9A6U1fpeko8iHtjlVvtGtx6USj/eCs+c3Wdso=;
 b=G7aLFU89trXu0IZNepT/5Ca5Asr+oq9OfhehPzFknmJPJV/rm6B5WWKHX8Of1pwdpe2dCFATLarHiTCT2M+R0EyiAVzZv1VwWKm13FwUUyaTo72wEFBLe/Lsy0idZrEvJ79Q6V+SKQNPFpNIdyoxbcFQglNHis2Gka8Q5w4mTFc=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6775.namprd04.prod.outlook.com (2603:10b6:610:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 08:07:07 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 08:07:07 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Topic: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Index: AQHWw53ElH89gtWC4UOrc4ORrjUAQA==
Date: Thu, 26 Nov 2020 08:07:07 +0000
Message-ID: <CH2PR04MB652216EF13A129EDA3BCEE31E7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e8c59e3-2741-400b-9715-08d891e244d0
x-ms-traffictypediagnostic: CH2PR04MB6775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB677511938466FAFB269BCFACE7F90@CH2PR04MB6775.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RpzzrGmsTvKKtSo2J2ERnqjsZiHJGEw++w7W8f48GFth3kgee8l9NW2rO9zlLqIe8F+Kdm2kE49pUzPRXqELkrNSB5AWn4a9yDhBJPEMWnTIWzrkE/0ySIH6In+FSnB2mJQMK1npFPlpP0zfXeW5bNBRJO7OW7Z4ze0zRGxeyK6YfVXVosc/w7/uWbWlrtbKjp6K+SkGb5iZepn5RYhpJba63RhFFAuztvDETyxe/kret20bM9+Pmrg3gQck32eVhNfVFSDCNqRHonSiyVWNCuKWqPngiHrASOcmKPYxQMQHk5oqM/WRe9up2MwoB9jzDtIQ+F1LEDOOkcwr3/hgGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR04MB6522.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(5660300002)(66946007)(54906003)(2906002)(64756008)(66556008)(8936002)(8676002)(66446008)(316002)(76116006)(66476007)(478600001)(91956017)(4326008)(52536014)(71200400001)(6506007)(55016002)(110136005)(33656002)(53546011)(9686003)(186003)(7696005)(86362001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UCZaStuTZ5cAlUwsueZFkdWEp44zxCEv/ldgUOajmB3znRHSmhMOtkdf03G1?=
 =?us-ascii?Q?MCB1Waswe0hos/aSkhQzI7u62LiOBMerhvWBC1madGQQ2PbAs0dgWvjq2+QZ?=
 =?us-ascii?Q?KrpvgbIZK4ZmToXpphdp5xBFw42Xb4jcTyc48yykAo+DqitiyQiKUcWMVyV+?=
 =?us-ascii?Q?Jt4Z/dPOxjTUafzhiS6i72/2hXFWIRv/pcsIzwKvqJATnAyrY9hVPKiaJA8S?=
 =?us-ascii?Q?Uh4oQnV7DMPnKff9CG38dEHyd3BDlxwG2K69iAYxHyvhANPvHBupiU+kJuvo?=
 =?us-ascii?Q?DpdhJft8+dBU0Q5MJOt7A4al3spMgphUOA1bEHZPA0PBhEeYNhSHetHM/RUH?=
 =?us-ascii?Q?FqbH1TiI96OAkAdMZZ6CnDMlsvszacI7p8R0iGU3AjAHDJuApggPU9T5qSss?=
 =?us-ascii?Q?3hO6XRXRGe2Zmwc7dXyOuVlC/VvH8205jcBqOJ6fQ+FnXT3C/E3qu39mf0Dh?=
 =?us-ascii?Q?KByrKJpyg/fkx8cjKKRZML7FN/lq4UT43JgCMNbA+gWHU3bfESkCEkIfdl0M?=
 =?us-ascii?Q?9fYEsefKPJScHRJzzQqvjQSYO6otHgeKBYAqnNZiz4lgYu+QWJG9o9IoEnDz?=
 =?us-ascii?Q?EBNuAtUMHUrdy9jNaaJMGeDwsY6YySYKBj/HFlcgBB7fffu+4hIbItuTBkOR?=
 =?us-ascii?Q?O61LKMAKhC4a9tJ2lbuwiZOqQ4+Ee9v6mPxrIbwq71+2FOnxxx6Hblq8m/aC?=
 =?us-ascii?Q?2fgrZq5mhBJ1S5cAXMNvlxiuueCMmv6B1eNAoOJuNvWN9RU+eDyWARFgcgkm?=
 =?us-ascii?Q?BGmPX7GtiTscHPRKBXSGQa0iEidYlWxAKsUJB2EVkWW5tJu1wDu2QZpccMqW?=
 =?us-ascii?Q?Vdw4M/Stq5nOFrT48ZQw3sFcbaVY9coXm8XH95xltNK5Bg2RpWmyMxKCtafF?=
 =?us-ascii?Q?yr2v8H1uORxAi4A9mz2WijRMlXVwaadUPX0D7JlT33vLJ3TsltVZW9W+cLiE?=
 =?us-ascii?Q?SLeyOntypY7SE6GEzL0AnClaSgokI1B+aL0et07JKihvWBoEG19xMeMIE7sp?=
 =?us-ascii?Q?R2krcD7TbfqPUVSXQo6eadEH8MejKDY8VqVDECOgKrbgv2yFVJ5ruVHML1jk?=
 =?us-ascii?Q?dBWfd6zB?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8c59e3-2741-400b-9715-08d891e244d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 08:07:07.4967 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZBVij10wCtwDqRIJbO34fc3YvqzBOza0Gx0i2pKyTdGJ03Rjc1l3oQmsjWTZH4szcf+Q6BjDBzn0df18d6x1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6775
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_030712_389936_CC61DF23 
X-CRM114-Status: GOOD (  26.77  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:
> Hi,
> 
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
>  drivers/nvme/target/Makefile      |   3 +-
>  drivers/nvme/target/admin-cmd.c   |  38 ++-
>  drivers/nvme/target/io-cmd-bdev.c |  12 +
>  drivers/nvme/target/io-cmd-file.c |   2 +-
>  drivers/nvme/target/nvmet.h       |  18 ++
>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++
>  include/linux/bio.h               |   1 +
>  8 files changed, 451 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/nvme/target/zns.c
> 
> Test Report :-
> 
> # cat /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1/device_path 
> /dev/nullb1
> # nvme list | tr -s ' ' ' ' 
> Node SN Model Namespace Usage Format FW Rev 
> /dev/nvme1n1 212d336db96a4282 Linux 1 1.07 GB / 1.07 GB 4 KiB + 0 B 5.10.0-r
> # ./zonefs-tests.sh /dev/nullb1 
> Gathering information on /dev/nullb1...
> zonefs-tests on /dev/nullb1:
>   4 zones (0 conventional zones, 4 sequential zones)
>   524288 512B sectors zone size (256 MiB)
>   0 max open zones
> Running tests
>   Test 0010:  mkzonefs (options)                                   ... PASS
>   Test 0011:  mkzonefs (force format)                              ... PASS
>   Test 0012:  mkzonefs (invalid device)                            ... FAIL
>   Test 0013:  mkzonefs (super block zone state)                    ... FAIL

See below.

>   Test 0020:  mount (default)                                      ... PASS
>   Test 0021:  mount (invalid device)                               ... PASS
>   Test 0022:  mount (check mount directory sub-directories)        ... PASS
>   Test 0023:  mount (options)                                      ... PASS
>   Test 0030:  Number of files (default)                            ... PASS
>   Test 0031:  Number of files (aggr_cnv)                           ... skip
>   Test 0032:  Number of files using stat (default)                 ... PASS
>   Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
>   Test 0034:  Number of blocks using stat (default)                ... PASS
>   Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
>   Test 0040:  Files permissions (default)                          ... PASS
>   Test 0041:  Files permissions (aggr_cnv)                         ... skip
>   Test 0042:  Files permissions (set value)                        ... PASS
>   Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
>   Test 0050:  Files owner (default)                                ... PASS
>   Test 0051:  Files owner (aggr_cnv)                               ... skip
>   Test 0052:  Files owner (set value)                              ... PASS
>   Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
>   Test 0060:  Files size (default)                                 ... PASS
>   Test 0061:  Files size (aggr_cnv)                                ... skip
>   Test 0070:  Conventional file truncate                           ... skip
>   Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
>   Test 0072:  Conventional file unlink                             ... skip
>   Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
>   Test 0074:  Conventional file random write                       ... skip
>   Test 0075:  Conventional file random write (direct)              ... skip
>   Test 0076:  Conventional file random write (aggr_cnv)            ... skip
>   Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
>   Test 0078:  Conventional file mmap read/write                    ... skip
>   Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
>   Test 0080:  Sequential file truncate                             ... PASS
>   Test 0081:  Sequential file unlink                               ... PASS
>   Test 0082:  Sequential file buffered write IO                    ... PASS
>   Test 0083:  Sequential file overwrite                            ... PASS
>   Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
>   Test 0085:  Sequential file unaligned write (async IO)           ... PASS
>   Test 0086:  Sequential file append (sync)                        ... PASS
>   Test 0087:  Sequential file append (async)                       ... PASS
>   Test 0088:  Sequential file random read                          ... PASS
>   Test 0089:  Sequential file mmap read/write                      ... PASS
>   Test 0090:  sequential file 4K synchronous write                 ... PASS
>   Test 0091:  Sequential file large synchronous write              ... PASS
> 
> 44 / 46 tests passed
> #
> #
> # ./zonefs-tests.sh /dev/nvme1n1
> Gathering information on /dev/nvme1n1...
> zonefs-tests on /dev/nvme1n1:
>   4 zones (0 conventional zones, 4 sequential zones)
>   524288 512B sectors zone size (256 MiB)
>   1 max open zones
> Running tests
>   Test 0010:  mkzonefs (options)                                   ... PASS
>   Test 0011:  mkzonefs (force format)                              ... PASS
>   Test 0012:  mkzonefs (invalid device)                            ... FAIL

Weird, this should not fail. zonefs-tests.sh creates a regular nullb device to
test that mkzonefs rejects regular disks. What was the failure here ?

>   Test 0013:  mkzonefs (super block zone state)                    ... FAIL

Same, this should not fail: this checks that if the super block is in a
sequential zone, that zone must be in the full condition. And seeing that all
conventional tests are skipped, it looks like your nullb drive does not have any
conventional zones. What was the error here ?

>   Test 0020:  mount (default)                                      ... PASS
>   Test 0021:  mount (invalid device)                               ... PASS
>   Test 0022:  mount (check mount directory sub-directories)        ... PASS
>   Test 0023:  mount (options)                                      ... PASS
>   Test 0030:  Number of files (default)                            ... PASS
>   Test 0031:  Number of files (aggr_cnv)                           ... skip
>   Test 0032:  Number of files using stat (default)                 ... PASS
>   Test 0033:  Number of files using stat (aggr_cnv)                ... PASS
>   Test 0034:  Number of blocks using stat (default)                ... PASS
>   Test 0035:  Number of blocks using stat (aggr_cnv)               ... PASS
>   Test 0040:  Files permissions (default)                          ... PASS
>   Test 0041:  Files permissions (aggr_cnv)                         ... skip
>   Test 0042:  Files permissions (set value)                        ... PASS
>   Test 0043:  Files permissions (set value + aggr_cnv)             ... skip
>   Test 0050:  Files owner (default)                                ... PASS
>   Test 0051:  Files owner (aggr_cnv)                               ... skip
>   Test 0052:  Files owner (set value)                              ... PASS
>   Test 0053:  Files owner (set value + aggr_cnv)                   ... skip
>   Test 0060:  Files size (default)                                 ... PASS
>   Test 0061:  Files size (aggr_cnv)                                ... skip
>   Test 0070:  Conventional file truncate                           ... skip
>   Test 0071:  Conventional file truncate (aggr_cnv)                ... skip
>   Test 0072:  Conventional file unlink                             ... skip
>   Test 0073:  Conventional file unlink (aggr_cnv)                  ... skip
>   Test 0074:  Conventional file random write                       ... skip
>   Test 0075:  Conventional file random write (direct)              ... skip
>   Test 0076:  Conventional file random write (aggr_cnv)            ... skip
>   Test 0077:  Conventional file random write (aggr_cnv, direct)    ... skip
>   Test 0078:  Conventional file mmap read/write                    ... skip
>   Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... skip
>   Test 0080:  Sequential file truncate                             ... PASS
>   Test 0081:  Sequential file unlink                               ... PASS
>   Test 0082:  Sequential file buffered write IO                    ... PASS
>   Test 0083:  Sequential file overwrite                            ... PASS
>   Test 0084:  Sequential file unaligned write (sync IO)            ... PASS
>   Test 0085:  Sequential file unaligned write (async IO)           ... PASS
>   Test 0086:  Sequential file append (sync)                        ... PASS
>   Test 0087:  Sequential file append (async)                       ... PASS
>   Test 0088:  Sequential file random read                          ... PASS
>   Test 0089:  Sequential file mmap read/write                      ... PASS
>   Test 0090:  sequential file 4K synchronous write                 ... PASS
>   Test 0091:  Sequential file large synchronous write              ... PASS
> 
> 44 / 46 tests passed
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
