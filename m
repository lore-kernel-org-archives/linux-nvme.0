Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F037C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 22:13:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BBF22BE9
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 22:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BBF22BE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Tpw/o7fsh6HXLmUlcl97Hb7sypSHO4FdDWLVMH59E2M=; b=nrMjibiXh9R9N1XZkzfuCsYQM
	xqiAHLgyAt7lFuHhv3khhfs9zEjIgV56+bum9DsvsYfFFGPFsjxhi0PWS8U3H0lILA3rNpeuUe67m
	Mchqz74YxVRnvLVyMvXObilDuZW0JO29JYg8eM/psip/RbYD+DMaKKB3Lxi87TT2uPh7vUUMShuiO
	RwLtWSU7oezkrdjggPLqKdbAAafF9abR3xkpG8Qqfb/2Lok6Ns6dBKTSPu1iWCSfqfbXy9mJlalqZ
	mK2Obmc5hfskINvpc820bb4n4i83r0ErDctaS2MphJzr5gBRHsuWLYd5FhtAeK193ECqkyRPSg4U8
	H2vzuwvUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpIZ3-0002BX-7w; Tue, 15 Dec 2020 22:13:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpIZ0-0002B1-8P
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 22:12:59 +0000
Date: Tue, 15 Dec 2020 14:12:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608070376;
 bh=eq135qPs8rX0EmCuSg7lZlv26CCkNVi2mHFfW0PaKfQ=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=V3qupgigEqSrKUhsJO8QIOooNBFGrLuClWbNNK9y0yBjA48Ww9Iyb1JnWf4mDL8c8
 tPv2cHyK31BoJYBIU+VlKDjnY5oKR9XZalPNPJohOiO1jCZeE2RovqofhsCWK+qP2z
 dbDtxkIlmfItBa8kngt7/mgiRgqIL3G5vq2uaz9ckI/i/B67zqYhsHnRa4SOaxYxUZ
 z8YEMbixosH8WJ11WNKeRyloU7+tkPdEtq2HWbkupYA1XF7FhJDOVdaDVg+gt4KINv
 bbPy88UqWp1u+jSm5QgF7/ioStaG81EDpF6KFFaRSxVrBXfe924llAccDX5axUg2Zf
 jVai8ToW+Lcmw==
From: Keith Busch <kbusch@kernel.org>
To: javier@javigon.com
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Message-ID: <20201215221254.GA3915989@dhcp-10-100-145-180.wdc.com>
References: <20201215195557.30169-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215195557.30169-1-javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_171258_415226_6FA51DE3 
X-CRM114-Status: GOOD (  16.03  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, minwoo.im.dev@gmail.com,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 15, 2020 at 08:55:57PM +0100, javier@javigon.com wrote:
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>
> =

> Create a char device per NVMe namespace. This char device is always
> initialized, independently of whether the features implemented by the
> device are supported by the kernel. User-space can therefore always
> issue IOCTLs to the NVMe driver using the char device.
> =

> The char device is presented as /dev/generic-nvmeXcYnZ. This naming
> scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> for multipath will follow.
> =

> Christoph, Keith: Is this going in the right direction?

I think this is looking okay, though I'm getting some weird errors and
warnings during boot. The first one looks like the following (I will
look into it too, but I wanted to get a reply out sooner).

[    4.734143] sysfs: cannot create duplicate filename '/dev/char/242:1'
[    4.736359] CPU: 4 PID: 7 Comm: kworker/u16:0 Not tainted 5.10.0+ #172
[    4.740836] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[    4.744228] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[    4.745558] Call Trace:
[    4.746122]  dump_stack+0x6d/0x88
[    4.746834]  sysfs_warn_dup.cold+0x17/0x24
[    4.747656]  sysfs_do_create_link_sd.isra.0+0xb0/0xc0
[    4.747659]  device_add+0x604/0x7b0
[    4.749298]  cdev_device_add+0x46/0x70
[    4.753241]  ? cdev_init+0x51/0x60
[    4.753246]  nvme_alloc_ns+0x670/0x8a0 [nvme_core]
[    4.753249]  ? _cond_resched+0x15/0x30
[    4.753253]  nvme_validate_or_alloc_ns+0x99/0x190 [nvme_core]
[    4.753258]  nvme_scan_work+0x152/0x290 [nvme_core]
[    4.753261]  process_one_work+0x1ac/0x330
[    4.753262]  worker_thread+0x50/0x3a0
[    4.753264]  ? process_one_work+0x330/0x330
[    4.753265]  kthread+0xfb/0x130
[    4.753266]  ? kthread_park+0x90/0x90
[    4.753269]  ret_from_fork+0x1f/0x30
[    4.753272] CPU: 5 PID: 88 Comm: kworker/u16:1 Not tainted 5.10.0+ #172

> Keith: Regarding nvme-cli support, what do you think about reporting the
> char device as existing block devices? If this is OK with you, I will
> submit patches for the filters.

I'm not sure I understand what you mean about reporting these as
"existing block devices". Are you talking about what's shown in the
'nvme list' output?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
