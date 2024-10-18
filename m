Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BC3D3C53F
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 03:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R13C9+NvGLeChFn8sIvHp+NNg4CtFwgOTV82fJ+W/Og=; b=TrRSxu/dcEUAnRTkA9/16H1QI/
	1MM4JhDeXb6c51ij2ROhxpLxn9UBpKaWXqqlyzbBmI+zq0n5Vex/8hN4WWjcAq7yGgyMRmGRRS0M/
	P8K3KsURQe+12Cz4Ub3Hj1YK8ieAi0MmtSXZAkva1Caua5Mc/VKPR7t+KlFjPvORa84XPU/tI2bxo
	fmZkE9fIUKHI9O6/EYnP2wNpJNf/nHQcIBTVDXRGuUwvzaC/X8aqyMTGUjmi3cDZrRtCn9Oih3V9l
	RbpwavoyipmweZJC64jvcZQ3Nv/HSA8S91BagIgVI5/iv1VxcX6uOABzyXfW9HNPEhCxBS7LmVQIe
	jrGt8Fww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1dfZ-0000000GnGx-27YD;
	Fri, 18 Oct 2024 03:28:53 +0000
Received: from mail-westcentralusazolkn190100000.outbound.protection.outlook.com ([2a01:111:f403:d123::] helo=CY4PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1dcz-0000000Gmrh-2sUf
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 03:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcbdlN4vkMGo+wBvCtY9GteV/SC5yfBteF+PvP1TyU9yHfblXfu/1pt8tLjmFg3A1cLZSsiRdXmB961dcXd3C1dK87X6fzXTH+e+AOk29WKxnzduP0fgNYjf+X0GMWuYUCgI43SbQx76ATb4X/tBt6uwmjz+V70dVn5oQEEhG4qUtA56HitDhEpSG82IkeH+1BSH9RdfCf8mKESFkEDEss86ZaVs7VxkfX5dojtYTG3rkJgIQPU0hPKXItCFC/QXqb4jQtZCND6NKuz3veE0G6pYytWs80z4xUihfHsQxDFrj0t0c+wswiYpSesIT7XVrxREuP7TrDQjU9RCnquRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R13C9+NvGLeChFn8sIvHp+NNg4CtFwgOTV82fJ+W/Og=;
 b=ml+lQ2yUUVrsbxchK6tZi/nrH9BsyCCtZKhkRdOl/vH9ANNEnCYkjajGgBIBgKpvxKtZIYBDY//W3AW+DYn9w46xbbLTPsN8aYWNdwm9b4+Ryr9gasXdI1h4veJtv1mJOTDjQI/mb/4ILsNid6YTuCVXUjTBpIzEB82Yo435HT1pSYbwX5ym3y3+UT050w+1Ig56e07V+tCltSfxlNMgq5aI4amio2oSkmxpB2yboOnpRZwAYvxLrT2k3F/k9MHqyz8vM06BeU7TCyCOYlLLzJdgV1zV/+m890AjZt7qioNAJsSK5ZTPhrZh5wDR8MmqqKOdIVfhPwbF1ttpK1QI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R13C9+NvGLeChFn8sIvHp+NNg4CtFwgOTV82fJ+W/Og=;
 b=EbDnrPM6tzc+lBnrnn9NX5Uv1N13f4tUn5Dqw0cG5tNAvXDSWS61ZbelD5wFLbxNPthT+R+LHXDUt4pg2JJ/daayF4LsreMdihLBiiRu/Uldtv9nTO/BzPwIhkERYF5YrHv8asXlmjyj58JLlt1337ukQ5Vm7hNegg83oBZCkfhA9ihGID6fjAuBsJu7JK7yny9n4vqruO801VuPrYmChbbFpNhfC6djTxvMHP6fDzICroEO/f8G4Pkuo3Co/BVALIRp/z9ls/z5rOCae0VXHvmHSlZrAYJukEU6vEwkyOOJsRd1osKlBt50LyKevW+QtX7/tlXWBIphbMQQ6eEqjQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10535.namprd02.prod.outlook.com (2603:10b6:610:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 03:26:05 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 03:26:05 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Stuart Hayes
	<stuart.w.hayes@gmail.com>, "linux-kernel@vger.kernel.org"
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
Thread-Index: AQHbGnTLCx/N5yqLpEGGHHPLbQxGQrKA6nvggAr0qtA=
Date: Fri, 18 Oct 2024 03:26:05 +0000
Message-ID: <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
 <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
In-Reply-To: <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10535:EE_
x-ms-office365-filtering-correlation-id: c3fbf216-7f7f-40b3-222a-08dcef24996c
x-microsoft-antispam: BCL:0;ARA:14566002|461199028|8062599003|19110799003|8060799006|15080799006|3412199025|440099028|102099032|56899033|1710799026;
x-microsoft-antispam-message-info: paegFFLa4/QWw6646ph5LJRolbLRCDZFU31XoW1AbfVpsajJjbU79WPzTTvzcfd9qRT26k5+gHywunUHmxGetFkPxpGvXb929gZpDoscv+1si8qSztmXNu+LQkLuLWlbVD10C9jbPUwNaB30aIPVctvW/AQRpQRVCEKxGEA/wlM8q7WMBPTRH10pkRHZ69yygSSAPy/AzOW+ahLLEvYygJVdemQxnaWhJFFx0NzKb5wkhG6K+Ny3wIhAvOS+e6EwZk7UD5dLJ8UmWe7Rq69+Tr+4AngzpP4kl4/ep4Xiw3zPU8vq9MedMoTQs/a/fn1AVQ3/zmj/U/iEoe4unzbGYHpIERi/Ad44UUVTczaAQan/jUTZ6kWRsaiwst2PRYkwL04UuzN1/AVNL+GJqvHpWb0k6onr4n2yhvLMbX6c+X5b9n/h4khTkcmbDdvKKtojHW7s2/Q8GwR6bYwGTpayw3kdiKFiMzI68W7BfqmrHIl7t6BnaCqULTSmWCNXNdcc7JT7fpcR1h38IhXC7a+EzeUN/q17QRJku6YCsF5LS5omOtAD5h5XqCODazwh6tdjoG+9+FZPrMZhHmLmWBmxWwtH906B7dUIKPedivaX3ZZbf4jySlQWQAoocepVNE2bg2ucvmFWFe1bC5Rbn82IVsyD03xGNhRhPbFV2O58ueRxr4QykI8xYjXtNN8dx6uSlQBxdCnodb6QoTUtbCUBa7KJ3q8l2ScQdRFBNJ3irmE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZwzRm9XoE554RixVeGpALj8CeyGbkn8yBEbUhItHsSIsJilajZ6VPIJRvwF?=
 =?us-ascii?Q?Gr/8LkssXcQDuSHpeVOFPJTqxTo4wwYvRFULqLwQ1QFEcgMbKNekRnLRRfkP?=
 =?us-ascii?Q?dn0ZAVv6i3G16Oukk/T6Ca6fffV9YJbRIMiYqyYEJbJ6/iq4emeMeOOmutY6?=
 =?us-ascii?Q?JtM68z4aLNjzFBzyb+fewAWtCpMlsgYvJw9e0MJfLWfPbtBiq0HcZME3qCu1?=
 =?us-ascii?Q?bi+63MXBcoeLM5Y31P6xIXLEBvcAn2TaAofK+1RKOoKsOk60sHnCaCwcGIvU?=
 =?us-ascii?Q?k7vGWnc48FIVwWRG7mFPgW6++E6cD9jDVjMCeD/Qkj9gtDR6I6o3hNmIu7SA?=
 =?us-ascii?Q?ejbMEBnfaugqqsm/bBnuUB6GbeF2ICuGh46waz4hqMu3iaFr5on8DKWhhhJQ?=
 =?us-ascii?Q?yuTRDavT6v/emlum+gtTSMkeE9lbfVNNttQ7mt743ehKnimBZkxuH+NduUC0?=
 =?us-ascii?Q?g5Il09A2jqnx4d7VTws5fWOfijCC66hwl9HbzMv2ZuM54DalJxWXqLO5YhkQ?=
 =?us-ascii?Q?NvJiEsPVGxsyOG7FnmovshDDiRGZMU/fb4C+hg+aQBgCM0wPpNrCvez/7xv3?=
 =?us-ascii?Q?P55Lucj6bR30dWtH5k5VXcjvJEFJZsAD+I5c9V2pLgnzFm1XoAkxZQqtjW11?=
 =?us-ascii?Q?UVtW6Uk4lNT1p5La/8jHV+XrziJgavn99YKZtEvBPxzfTAG8xZryCmG8JCXt?=
 =?us-ascii?Q?6Cyk+qDE1/5V619G7oD+V17cRIT2l7SaWvPk83S9nUcJabWe+oDwSPgDasFn?=
 =?us-ascii?Q?r3+yWrNX+K5YlzJan47OloJs35MnknV3/xTJs/uiSyMClr2vgQgwyM1vKUMZ?=
 =?us-ascii?Q?Nb//T0rW02zoYpKRS6ng2j3oUfb9xXvdkH29bhUuLljw45S9mYx2o5saYIxw?=
 =?us-ascii?Q?KsngHR9T19grxuUyMrDhjD4H0PvT09oKPb+4/zklZ1wvdguy424Vg2tNYTJN?=
 =?us-ascii?Q?I4X++1CXhB0MKyXMjjI2oZHVhGmk9UUkgDLSS7TqhsNVJ/knGY5eCLzmM027?=
 =?us-ascii?Q?IFhyHqFGGgy30B1mWqskjrKprhUmm8xd4IKlEmYLYYFOXbI9NGz/HaBQsFnm?=
 =?us-ascii?Q?WiSON7yxVTdrWucqGD8SHlQppasWsH+jPlREKd7dkfLLqu6KLk1Nf8p3E6KW?=
 =?us-ascii?Q?TSryAdkIKETgSs667d/ZqJP7/dw7HL7K1dq0XfRiYt7EDebnn5t8SAn8RQZh?=
 =?us-ascii?Q?Wz/YdwBWO0Ym+R+umn31y8QcDRizJrg8/XbB0WGJfXdGlXb8d42eAD18b78?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fbf216-7f7f-40b3-222a-08dcef24996c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 03:26:05.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10535
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_202613_773962_F3AE7885 
X-CRM114-Status: GOOD (  50.99  )
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

From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, October 10, 202=
4 9:22 PM
>=20
> From: Stuart Hayes <stuart.w.hayes@gmail.com> Sent: Wednesday, October 9,=
 2024 10:58 AM
> >
> > This adds the ability for the kernel to shutdown devices asynchronously=
.
> >
> > Only devices with drivers that enable it are shut down asynchronously.
> >
> > This can dramatically reduce system shutdown/reboot time on systems tha=
t
> > have multiple devices that take many seconds to shut down (like certain
> > NVMe drives). On one system tested, the shutdown time went from 11 minu=
tes
> > without this patch to 55 seconds with the patch.
>=20
> I've been testing this series against a 6.11.0 kernel in an Azure VM, whi=
ch
> is running as a guest on the Microsoft Hyper-V hypervisor. The VM has 16 =
vCPUs,
> 128 Gbytes of memory, and two physical NVMe controllers that are mapped
> into the VM so that it can access them directly.
>=20
[snip]
>=20
> But here's the kicker:  The overall process of shutting down the devices
> took *longer* with the patch set than without.  Here's the same output
> from a 6.11.0 kernel without the patch set:
>=20
[snip]
>=20
> Any thoughts on what might be causing this?  I haven't gone into the
> details of your algorithms for parallelizing, but is there any extra
> overhead that could be adding to the time? Or maybe this is
> something unique to Hyper-V guests. The overall difference is only
> a few 10's of milliseconds, so not that big of a deal. But maybe it's
> an indicator that something unexpected is happening that we should
> understand.
>=20
> I'll keep thinking about the issue and see if I can get any more insight.

I've debugged this enough to now know what is happening. I see the
same behavior in two different environments:

1) A Hyper-V VM with 8 vCPUs running on my local laptop. It has
no NVMe devices, so there's no opportunity for parallelism with this
patch set.

2) A Raspberry Pi 5 with 4 CPUs. Linux is running on the bare metal.
It has one NVMe device via the Pi 5 M.2 HAT.

In both cases, the loop in device_shutdown() goes through a lot of
devices:  492 in my Hyper-V VM, and 577 in the Pi 5. With the code
in this patch set, all the devices get added to the async_wq in
kernel/async.c. So async_wq quickly gets heavily populated.

In the process, the workqueue code spins up additional worker threads
to handle the load.  On the Hyper-V VM, 210 to 230 new kernel
threads are created during device_shutdown(), depending on the
timing. On the Pi 5, 253 are created. The max for this workqueue is
WQ_DFL_ACTIVE (256).

Creating all these new worker threads, and scheduling and
synchronizing them takes 30 to 40 milliseconds of additional time
compared to the original code. On the Hyper-V VM, device_shutdown()
completes in about 5 millisecond with the original code, and +/- 40
milliseconds with the new async code. The Pi 5 results are more
variable, but also have roughly 30 to 40 milliseconds additional.

Is all this extra work a problem? I don't know. Clearly, there's big
benefit in parallelizing the NVMe shutdown, and in those situations
the extra 30 to 40 milliseconds can be ignored. But I wonder if there
are other situations whether the extra elapsed time and CPU
consumption might be a problem.

I also wonder about scalability. Does everything still work if
device_shutdown is processing 5000 devices? Is there a possibility
of deadlock if async_wq can only have 256 active items out of
5000 queued ones?

Michael Kelley

>=20
> >
> > Changes from V8:
> >
> > Deal with shutdown hangs resulting when a parent/supplier device is
> >   later in the devices_kset list than its children/consumers:
> >   * Ignore sync_state_only devlinks for shutdown dependencies
> >   * Ignore shutdown_after for devices that don't want async shutdown
> >   * Add a sanity check to revert to sync shutdown for any device that
> >     would otherwise wait for a child/consumer shutdown that hasn't
> >     already been scheduled
> >
> > Changes from V7:
> >
> > Do not expose driver async_shutdown_enable in sysfs.
> > Wrapped a long line.
> >
> > Changes from V6:
> >
> > Removed a sysfs attribute that allowed the async device shutdown to be
> > "on" (with driver opt-out), "safe" (driver opt-in), or "off"... what wa=
s
> > previously "safe" is now the only behavior, so drivers now only need to
> > have the option to enable or disable async shutdown.
> >
> > Changes from V5:
> >
> > Separated into multiple patches to make review easier.
> > Reworked some code to make it more readable
> > Made devices wait for consumers to shut down, not just children
> >   (suggested by David Jeffery)
> >
> > Changes from V4:
> >
> > Change code to use cookies for synchronization rather than async domain=
s
> > Allow async shutdown to be disabled via sysfs, and allow driver opt-in =
or
> >   opt-out of async shutdown (when not disabled), with ability to contro=
l
> >   driver opt-in/opt-out via sysfs
> >
> > Changes from V3:
> >
> > Bug fix (used "parent" not "dev->parent" in device_shutdown)
> >
> > Changes from V2:
> >
> > Removed recursive functions to schedule children to be shutdown before
> >   parents, since existing device_shutdown loop will already do this
> >
> > Changes from V1:
> >
> > Rewritten using kernel async code (suggested by Lukas Wunner)
> >
> >
> > Stuart Hayes (4):
> >   driver core: don't always lock parent in shutdown
> >   driver core: separate function to shutdown one device
> >   driver core: shut down devices asynchronously
> >   nvme-pci: Make driver prefer asynchronous shutdown
> >
> >  drivers/base/base.h           |   4 +
> >  drivers/base/core.c           | 137 +++++++++++++++++++++++++++-------
> >  drivers/nvme/host/pci.c       |   1 +
> >  include/linux/device/driver.h |   2 +
> >  4 files changed, 118 insertions(+), 26 deletions(-)
> >
> > --
> > 2.39.3
> >
>=20


