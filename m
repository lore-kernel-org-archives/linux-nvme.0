Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344A3D2446D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 04:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BzHz/dS5O2U3Hg3it7LCJNW68D5lNZMNIBaWNjC2JRE=; b=DaA8P2+KD/IH0d8gg9WKlNOpMg
	GDwF+8ffB3U5zZPsTT2yMVkNMOaQ0hbQSwColkiBpIhkxIX4yVDiGyDD8XIwsta+xT1RN6PT/uda0
	q3fw6ysApJYuOBwnW3LWXIaYP3+D5yyey/ojMXKK7yL3maq662YO0gbNhGAgdA46TqoltoE+/K8/S
	dFSXJ02YK+D9NM0uUnbLNbVLbVXt1zLgGT7r6FxZb/RAeyRq3QAXwMvQZNRJUtpWU3y9bHpq3pEf+
	TOmFsX2sduPpwLpBolWhO1W/qbDl7yyxZXeakR9r8OWAYPE34jTg0IDmGOSWHi8113dHpvwGoZSaK
	D5F6yH9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sz7Bg-0000000FDo5-39BD;
	Fri, 11 Oct 2024 04:23:36 +0000
Received: from mail-centralusazolkn190100000.outbound.protection.outlook.com ([2a01:111:f403:d107::] helo=DM1PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sz7Ac-0000000FDkJ-3IIy
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 04:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5pR8IlcOrU1ctWgfIp3m3lbGwCgKtgHmJDxLYiAgf68k6hAk6/XFmFoT2Jc0ntzPGl9B8uhvFnznlQrdAvjH95bc1/EdlAwKOcmCQa2COdP6/zPZR3dRB3a/pzvGXFC1u9KuE6EAJruB6rqk0orMHq1EZncJvOEdy2XoWACqD6GafTIpkyhIPt+otyrSNQkfPLd0Gz1y1urdNnFFRKV9Ma04m2qXhvbedO1CA2F/tviOBc0btjoUezN4dXMwm46YQdm7ecVN28fI63xXQDaRtSHHfvgaMzgkPLeeUPv7/6ywrE0XjGN/2Y0E+e6a/qUH978sFYZJAnqR2LXdvhdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzHz/dS5O2U3Hg3it7LCJNW68D5lNZMNIBaWNjC2JRE=;
 b=mTO7ZRsbsx1k23F/deGb6Xoh6IxAZy/LkTfAv4hsFe8wLfi20ONC3F89F2MDUXkN6ukM2Bu/KBFolxynhWEactAC1/YrbLqnf8ykS5ja0iDJ7e5X180VB2MT4fC7HzxBSTV5rMlp/SluEut0xtagw80kNt64d7DWKPd6K0hk8GeztJpmmef5mpH2dwOLcLGMSQ+KZbe4EIyPyuu3kyj1uOnZrxzCvwCOJK8Aon2KdqZfliK24zMmom8eRomYmni4jUstj3OtzCBLU4AE48V2naOktiHsSsvxOI0xWuxddLFOAeg3W+Q8y593CEfqwK63R2Mz+YzLyBwmZZt7iMtuwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzHz/dS5O2U3Hg3it7LCJNW68D5lNZMNIBaWNjC2JRE=;
 b=PQqcSdX79pimFZ+gBlTw+MDqn97F/QCjWcy2cisb32RRWV5TjAGlLBUsCzo15VdINlD77DvrAnePvY8nIYlxPSGnE6AmcyggbCERpAx53jiWsbyZlVlILFYgA8A6WCqTSQnG1Bg4Ynu7qZzArEVPfS6G/Q9nfLVZhj3jcEsBYoYNUjlKt99U1nwpnUcNzNzhuqMfwQsie9j9xVk2kUc0q+l14u/uLYcAx1r4fme6PKw/PCU897AwoibeTnxZ5LodEu/SrmE9m/l60W6AAay4Uwms8ahC7T28DXB89xcoSaG8qWp/kz3E4t1jeMu4Ek+KQmj9qivZMqbgB69xEfIt+A==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by CH2PR02MB6950.namprd02.prod.outlook.com (2603:10b6:610:5c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 04:22:19 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8026.020; Fri, 11 Oct 2024
 04:22:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>, Oliver O'Halloran
	<oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>, Keith Busch
	<kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, David Jeffery
	<djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>, Jens Axboe
	<axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Nathan Chancellor <nathan@kernel.org>, Jan
 Kiszka <jan.kiszka@seimens.com>, Bert Karwatzki <spasswolf@web.de>
Subject: RE: [PATCH v9 0/4] shut down devices asynchronously
Thread-Topic: [PATCH v9 0/4] shut down devices asynchronously
Thread-Index: AQHbGnTLCx/N5yqLpEGGHHPLbQxGQrKA6nvg
Date: Fri, 11 Oct 2024 04:22:19 +0000
Message-ID: <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
In-Reply-To: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|CH2PR02MB6950:EE_
x-ms-office365-filtering-correlation-id: 6a7c76f2-efd2-40b2-a44f-08dce9ac4bc2
x-microsoft-antispam: BCL:0;ARA:14566002|7042599007|8062599003|19110799003|8060799006|15080799006|461199028|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info: W/ZUm+oA0Cqnj38uq5I3Ej8BOaV/RgzTAU5jF5gZodA/R0S29PTw0ue2LqNb3xaDovUREEWCz39C8/8PQ42YF4tXN5rzYqIvRoyhOyHfvOYYWpXvVGApVArddNF50YmajboE9HMIH+MuCScquqwKUQab2RvlhoFWgbo66ErrSK2DZO0wjZ10qC2UR9JkL8pxTvyMePUEmuUdmd+IWZsr/GKZ4lwPNg3sWktzNXAjan5E9m1Fkb2hdTty+2/+EjuQYnSY3VbO8NeWIEadkexXGoe8c9UG4trDPt5chcBB99VXuO+64e+5ESl1LvJKgVHctOW0cQz2WBcAkTfH4sf+G7v/QqeaGADgX+Xn0VRodB/VvoYMG7pPXM0tF1JY1jGpmK8u62sYNA7sCeTbcoAbU6rLCOjYaF2R3pXTi/QN6hW3NF3O1nG1k3xeiwhAsP0zJzWKt9cv2QCFo94QwF/Piwqe1c51hIrtAC4ep8yhfqngDM9S/p3zxuRFRtKSq3T571gMBMlMmM/KdFWiV6xXJQga53+SVFMRYL7/difgiByVez6WQxCJbMYk8fjoLoQ42ieTxIDbaeffxqH5ezZwwnPWGJmpBEU4SRk3NK3bo1kR2k1lyPfAWuVJ4/kd+bvR26HPJ2f+a9C7kOECbXd/QB70mEWIT4pueDdT5TBG4ynzRzlS1QZwUbvCQ2kxumamY5o1EzZjpE8Ec3Er1vwPwPGTV2H7z6KGy2NN+Pwjxhg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vyiD5fMybiM0ngCDB+quALyKylsJ5o8zFIDLYaujT24qwFhGG2B3mFqFMYBq?=
 =?us-ascii?Q?IyuxRCgUERwrVDnqyKBmrLbwseSS5mG+jjHXU+ohC2YhhAAZzHZj2q0YQoIA?=
 =?us-ascii?Q?gkg+mmZ6D1PGn/SyjWS/RasZHlrBeAIn81yJFm6jwscpBJhxylUSSYkbXlcr?=
 =?us-ascii?Q?D2jgO06Twut6r3VPnQvc/+CEAAAwfq7DGqmp7HxhLv4xFI0vZUvj9gZ3B3RC?=
 =?us-ascii?Q?Qtu7pXUV1+TQZV8+fNLPgohMMyvxtm25+5LTyw3+YIhZQY5xixPknQ7/C5Vs?=
 =?us-ascii?Q?gHjP8ZEBbGzRuMZX35jD9PQA7YnJs7C3M7zLXJST/HNT+VcWiJjA+drGB8We?=
 =?us-ascii?Q?SLgtiH3aq301kifPm13dyOpVRr/y2RKWwTUSUAl+P7mNiJdk5xOpqXeGicAR?=
 =?us-ascii?Q?7ZFYZ4Tp90AZyOqQ/qZUcr2hgerw4pkHMAqlbuwfvUBGuf7sc3FHi7blXP9N?=
 =?us-ascii?Q?ZtphNMAWeKGCThAIyHy9jwk3GsuAf2HEO8cD+O3hHn5OzabOB+9eSigzS4He?=
 =?us-ascii?Q?XQEC6xdecsRRi7PSgvCYw5iQxsVh3EWDMhpxHSKA8yRov3KFl2GzmwAgvbc4?=
 =?us-ascii?Q?/cUNO/srjA1yz5b2NihQ8HOAJoks1PjAtiuljFBZ0A1iHQUMFYtH+DyiLYae?=
 =?us-ascii?Q?kGs2AuF6SRdY8YGKISCRXfKDD3InvjNWzotWZeHb6PoDYXIfGoCDswBqNh55?=
 =?us-ascii?Q?0qj6F0C0cZElO2cXOtvWlx3KWa+ssgQ50eiDOuPdmIOpXbo80/YZS6DZFEhj?=
 =?us-ascii?Q?8FB/vei3aqRDwXxvkQH0XZJdfIFktQEe7mds6DTJvbyDe8CiEXwgA7a+v20E?=
 =?us-ascii?Q?IPvHo0RCLd98ncQgMIm1rsm4NqHeOX6FGi0vyXICRJP+4byiJuU3Ye7OiQ9r?=
 =?us-ascii?Q?bwWUjkMUxUJ+kPFwAih8ALwj7EmNY0MfLbSElccQlKVNtBJkLR4QR/k182Ki?=
 =?us-ascii?Q?4jjK7mBW964SNrOE7zuh1uG+41sUWUyluFbyLUePz1qufGamKD3U7b0AJAx+?=
 =?us-ascii?Q?XzsHr+hxBzne4e1A25EF10qh7yMc6zItni+8P+eMKTemEtsilzczIGFvKj7A?=
 =?us-ascii?Q?/t/U0bGoQzerIzGTNySoavnMOkagPRCCnqPRtYYcyumEPcmJMf/FgxKFwpLM?=
 =?us-ascii?Q?sJ3k6jAtwxzwyAQByyMONnnNdESg2iaFeSV1/T2mAeT2w0H+BfozQQX2iKIC?=
 =?us-ascii?Q?xBXND9zZNky9qFWoP7LIHEQS4//2J3+8H1A34NXbVU8DV37uX9D+GK2s5EU?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7c76f2-efd2-40b2-a44f-08dce9ac4bc2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 04:22:19.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6950
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_212230_934037_0AB1390A 
X-CRM114-Status: GOOD (  33.82  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Stuart Hayes <stuart.w.hayes@gmail.com> Sent: Wednesday, October 9, 2=
024 10:58 AM
>=20
> This adds the ability for the kernel to shutdown devices asynchronously.
>=20
> Only devices with drivers that enable it are shut down asynchronously.
>=20
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minute=
s
> without this patch to 55 seconds with the patch.

I've been testing this series against a 6.11.0 kernel in an Azure VM, which
is running as a guest on the Microsoft Hyper-V hypervisor. The VM has 16 vC=
PUs,
128 Gbytes of memory, and two physical NVMe controllers that are mapped
into the VM so that it can access them directly.

But I wanted to confirm that the two NVMe controllers are being shutdown
in parallel.  So before doing a shutdown, I set
/sys/module/kernel/parameters/initcall_debug to "Y" so the shutdown
of each device is recorded in the console output.  Here's the full set of
device shutdown messages:

172.609825	platform intel_rapl_msr.0: shutdown
172.611940	mlx5_ib.rdma mlx5_core.rdma.0: shutdown
172.613931	mlx5_core.eth mlx5_core.eth.0: shutdown
172.618116	nvme c2b7:00:00.0: shutdown
172.618262	nvme 132e:00:00.0: shutdown
172.618349	mlx5_core 1610:00:02.0: shutdown
172.618359	mlx5_core 1610:00:02.0: Shutdown was called
172.782768	hv_pci ba152dae-1610-4c67-b925-81ac4902e4ce: shutdown
172.786405	sd 0:0:0:1: shutdown
172.788788	sd 0:0:0:0: shutdown
172.789949	sd 0:0:0:0: [sda] Synchronizing SCSI cache
172.794209	atkbd serio0: shutdown
172.795974	hv_utils 242ff919-07db-4180-9c2e-b86cb68c8c55: shutdown
172.800432	hv_pci 0cdfe983-132e-434b-8025-fc9ab43c0fc5: shutdown
172.802812	hv_pci 2394da4f-c2b7-43bd-b72f-d3482ef6850a: shutdown
172.805145	hv_netvsc 0022487e-1043-0022-487e-10430022487e: shutdown
172.807575	hyperv_fb 5620e0c7-8062-4dce-aeb7-520c7ef76171: shutdown
172.810026	hyperv_keyboard d34b2567-b9b6-42b9-8778-0a4ec0b955bf: shutdown
172.812522	hid_hyperv 58f75a6d-d949-4320-99e1-a2a2576d581c: shutdown
172.814982	hv_balloon 1eccfd72-4b41-45ef-b73a-4a6e44c12924: shutdown
172.817376	vmbus c4e5e7d1-d748-4afc-979d-683167910a55: shutdown
172.819789	hv_storvsc f8b3781b-1e82-4818-a1c3-63d806ec15bb: shutdown
172.822324	hv_storvsc f8b3781a-1e82-4818-a1c3-63d806ec15bb: shutdown
172.824813	hv_utils 2dd1ce17-079e-403c-b352-a1921ee207ee: shutdown
172.827199	hv_utils b6650ff7-33bc-4840-8048-e0676786f393: shutdown
172.829653	hv_utils fd149e91-82e0-4a7d-afa6-2a4166cbd7c0: shutdown
172.836408	platform eisa.0: shutdown
172.838558	alarmtimer alarmtimer.0.auto: shutdown
172.842461	platform Fixed MDIO bus.0: shutdown
172.864709	kgdboc kgdboc: shutdown
172.878009	serial8250 serial8250: shutdown
172.889725	platform pcspkr: shutdown
172.904386	rtc_cmos 00:02: shutdown
172.906217	serial 00:01: shutdown
172.907799	serial 00:00: shutdown
172.910427	platform efivars.0: shutdown
172.913341	platform rtc-efi.0: shutdown
172.915470	vmgenid HYPER_V_GEN_COUNTER_V1:00: shutdown
172.917479	vmbus VMBUS:00: shutdown
172.919012	platform PNP0003:00: shutdown
172.926707	reg-dummy reg-dummy: shutdown
172.961360	ACPI: PM: Preparing to enter system sleep state S5

You see the Mellanox CX-5 NIC, the two NVMe devices, various Hyper-V
virtual devices, and platform devices being shutdown. Everything seems to
work properly, so that's good. The two NVMe devices are shutdown very
close in time, so they are probably being done in parallel.

As a comparison, I did the same thing with an unmodified 6.11.0 kernel.
Indeed, the NVMe device shutdowns are significantly more apart in time
(110 milliseconds). That's not noticeably slow like the NVMe devices you
were dealing with, but doing them in parallel helps a little bit.

But here's the kicker:  The overall process of shutting down the devices
took *longer* with the patch set than without.  Here's the same output
from a 6.11.0 kernel without the patch set:

745.455493	platform intel_rapl_msr.0: shutdown	=09
745.456999	mlx5_ib.rdma mlx5_core.rdma.0: shutdown	=09
745.458557	mlx5_core.eth mlx5_core.eth.0: shutdown	=09
745.460166	mlx5_core 1610:00:02.0: shutdown	=09
745.461570	mlx5_core 1610:00:02.0: Shutdown was called	=09
745.466053	nvme 132e:00:00.0: shutdown	=09
745.579284	nvme c2b7:00:00.0: shutdown	=09
745.718739	hv_pci ba152dae-1610-4c67-b925-81ac4902e4ce: shutdown	=09
745.721114	sd 0:0:0:1: shutdown	=09
745.722254	sd 0:0:0:0: shutdown	=09
745.723357	sd 0:0:0:0: [sda] Synchronizing SCSI cache	=09
745.725259	atkbd serio0: shutdown	=09
745.726405	hv_utils 242ff919-07db-4180-9c2e-b86cb68c8c55: shutdown	=09
745.728375	hv_pci 0cdfe983-132e-434b-8025-fc9ab43c0fc5: shutdown	=09
745.730347	hv_pci 2394da4f-c2b7-43bd-b72f-d3482ef6850a: shutdown	=09
745.732281	hv_netvsc 0022487e-1043-0022-487e-10430022487e: shutdown	=09
745.734318	hyperv_fb 5620e0c7-8062-4dce-aeb7-520c7ef76171: shutdown	=09
745.736488	hyperv_keyboard d34b2567-b9b6-42b9-8778-0a4ec0b955bf: shutdown	=
=09
745.738628	hid_hyperv 58f75a6d-d949-4320-99e1-a2a2576d581c: shutdown	=09
745.740770	hv_balloon 1eccfd72-4b41-45ef-b73a-4a6e44c12924: shutdown	=09
745.742835	vmbus c4e5e7d1-d748-4afc-979d-683167910a55: shutdown	=09
745.744765	hv_storvsc f8b3781b-1e82-4818-a1c3-63d806ec15bb: shutdown	=09
745.746861	hv_storvsc f8b3781a-1e82-4818-a1c3-63d806ec15bb: shutdown	=09
745.748907	hv_utils 2dd1ce17-079e-403c-b352-a1921ee207ee: shutdown	=09
745.750948	hv_utils b6650ff7-33bc-4840-8048-e0676786f393: shutdown	=09
745.753012	hv_utils fd149e91-82e0-4a7d-afa6-2a4166cbd7c0: shutdown	=09
745.755000	platform eisa.0: shutdown	=09
745.756266	alarmtimer alarmtimer.0.auto: shutdown	=09
745.757868	platform Fixed MDIO bus.0: shutdown	=09
745.759447	kgdboc kgdboc: shutdown	=09
745.760679	serial8250 serial8250: shutdown	=09
745.762110	platform pcspkr: shutdown	=09
745.763387	rtc_cmos 00:02: shutdown	=09
745.764726	serial 00:01: shutdown	=09
745.765898	serial 00:00: shutdown	=09
745.767036	platform efivars.0: shutdown	=09
745.768783	platform rtc-efi.0: shutdown	=09
745.770240	vmgenid HYPER_V_GEN_COUNTER_V1:00: shutdown	=09
745.771949	vmbus VMBUS:00: shutdown	=09
745.773197	platform PNP0003:00: shutdown	=09
745.774540	reg-dummy reg-dummy: shutdown	=09
745.775964	ACPI: PM: Preparing to enter system sleep state S5
	=09
There's some modest variability in the individual steps, but the 110 ms
saved on the NVMe device seems to be given back on some other
devices. I did the comparison twice with similar results. (I have the
full data set with comparisons in an Excel spreadsheet.)

Any thoughts on what might be causing this?  I haven't gone into the
details of your algorithms for parallelizing, but is there any extra
overhead that could be adding to the time? Or maybe this is
something unique to Hyper-V guests. The overall difference is only
a few 10's of milliseconds, so not that big of a deal. But maybe it's
an indicator that something unexpected is happening that we should
understand.

I'll keep thinking about the issue and see if I can get any more insight.

Michael Kelley

>=20
> Changes from V8:
>=20
> Deal with shutdown hangs resulting when a parent/supplier device is
>   later in the devices_kset list than its children/consumers:
>   * Ignore sync_state_only devlinks for shutdown dependencies
>   * Ignore shutdown_after for devices that don't want async shutdown
>   * Add a sanity check to revert to sync shutdown for any device that
>     would otherwise wait for a child/consumer shutdown that hasn't
>     already been scheduled
>=20
> Changes from V7:
>=20
> Do not expose driver async_shutdown_enable in sysfs.
> Wrapped a long line.
>=20
> Changes from V6:
>=20
> Removed a sysfs attribute that allowed the async device shutdown to be
> "on" (with driver opt-out), "safe" (driver opt-in), or "off"... what was
> previously "safe" is now the only behavior, so drivers now only need to
> have the option to enable or disable async shutdown.
>=20
> Changes from V5:
>=20
> Separated into multiple patches to make review easier.
> Reworked some code to make it more readable
> Made devices wait for consumers to shut down, not just children
>   (suggested by David Jeffery)
>=20
> Changes from V4:
>=20
> Change code to use cookies for synchronization rather than async domains
> Allow async shutdown to be disabled via sysfs, and allow driver opt-in or
>   opt-out of async shutdown (when not disabled), with ability to control
>   driver opt-in/opt-out via sysfs
>=20
> Changes from V3:
>=20
> Bug fix (used "parent" not "dev->parent" in device_shutdown)
>=20
> Changes from V2:
>=20
> Removed recursive functions to schedule children to be shutdown before
>   parents, since existing device_shutdown loop will already do this
>=20
> Changes from V1:
>=20
> Rewritten using kernel async code (suggested by Lukas Wunner)
>=20
>=20
> Stuart Hayes (4):
>   driver core: don't always lock parent in shutdown
>   driver core: separate function to shutdown one device
>   driver core: shut down devices asynchronously
>   nvme-pci: Make driver prefer asynchronous shutdown
>=20
>  drivers/base/base.h           |   4 +
>  drivers/base/core.c           | 137 +++++++++++++++++++++++++++-------
>  drivers/nvme/host/pci.c       |   1 +
>  include/linux/device/driver.h |   2 +
>  4 files changed, 118 insertions(+), 26 deletions(-)
>=20
> --
> 2.39.3
>=20


