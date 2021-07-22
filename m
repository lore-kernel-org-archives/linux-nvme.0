Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B615C63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 15:54:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CB86127C
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 15:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CB86127C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mOWDqlPjZJB3vtxvpb7xLHioiFvrsVv4NL9x6fax4r4=; b=aXeqaSi2+IIADv
	RYGzQ8Y4LAQgtJVy6NGOwFAtjrc3Pjv9XxPdGbXqjOn6fieyDNOC/+2ttmxiUT0sMAxN0WY4BPgaB
	w9/o7YHEIUKzxclcOmciWc6nOvb+Ca5R6XN1HgFMq/H2XwZ0x3UTbH1hqPAR1nfZvVYsQ5ZIQNkvV
	f3I1lOvsrmMciJKTwvvn/cYGAz8GzfSTRcG3Q6o1u+LxQARWHYBpDj92Sy5MJJNxRhA8DrM0cb8zY
	D5BxvXKALfsgsmGQxdLqukExxiTtMOHXav6gGV8ANuXp2YZ/vXNOEBEHqXKcUFiQMAWGMqA3DDCkQ
	b9xWWbuBr0S3Ar79bAvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6b1s-002203-4k; Thu, 22 Jul 2021 15:54:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6b1o-0021zG-DB
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 15:54:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626969267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgWRIlTRPrFPSXBUW8Pt0zlG5aAoFdN/NE3i2abB5QA=;
 b=CJmCl0WHP9JckfdzwZ5WK3v024FgDC1BXD74xDTL1A4vO4OJ2bPG8ItXIeU/Zius3aV/nD
 2xN+FKMYwYmd4NQczy36YDr2oWb35NTrNJWkArJwdQlTZv9gdQalrNzAiZx1kv6o7QbTnb
 7qBG5JOvogMAX056/XixAohF/4PKlZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-jOWvxWLjNiW4zeSswEF1LA-1; Thu, 22 Jul 2021 11:54:25 -0400
X-MC-Unique: jOWvxWLjNiW4zeSswEF1LA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99ED280BCB1;
 Thu, 22 Jul 2021 15:54:18 +0000 (UTC)
Received: from T590 (ovpn-12-57.pek2.redhat.com [10.72.12.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DA0E10016F2;
 Thu, 22 Jul 2021 15:54:13 +0000 (UTC)
Date: Thu, 22 Jul 2021 23:54:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] iommu_dma_unmap_sg() is very slow then running IO
 from remote numa node
Message-ID: <YPmUoBk9u+tU2rbS@T590>
References: <YOhcOv1oOwm6fco+@T590>
 <ad5bc549-d83f-bee0-9a9f-03a5afd7f3d9@huawei.com>
 <YPd7IGFZrsTRfUxE@T590>
 <74537f9c-af5f-cd84-60ab-49ca6220310e@huawei.com>
 <YPfwAN1onpSKoeBj@T590>
 <a2650064-41cf-cb62-7ab4-d14ef1856966@huawei.com>
 <YPklDMng1hL3bQ+v@T590>
 <9c929985-4fcb-e65d-0265-34c820b770ea@huawei.com>
 <YPlGOOMSdm6Bcyy/@T590>
 <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc552129-e89d-74ad-9e57-30e3ffe4cf5d@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_085428_563478_94B2DC6B 
X-CRM114-Status: GOOD (  29.05  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 22, 2021 at 12:12:05PM +0100, John Garry wrote:
> On 22/07/2021 11:19, Ming Lei wrote:
> > > If you check below, you can see that cpu4 services an NVMe irq. From
> > > checking htop, during the test that cpu is at 100% load, which I put =
the
> > > performance drop (vs cpu0) down to.
> > nvme.poll_queues is 2 in my test, and no irq is involved. But the irq m=
ode
> > fio test is still as bad as io_uring.
> > =

> =

> I tried that:
> =

> dmesg | grep -i nvme
> [    0.000000] Kernel command line: BOOT_IMAGE=3D/john/Image rdinit=3D/in=
it
> crashkernel=3D256M@32M console=3DttyAMA0,115200 earlycon acpi=3Dforce
> pcie_aspm=3Doff noinitrd root=3D/dev/sda1 rw log_buf_len=3D16M user_debug=
=3D1
> iommu.strict=3D1 nvme.use_threaded_interrupts=3D0 irqchip.gicv3_pseudo_nm=
i=3D1
> nvme.poll_queues=3D2
> =

> [   30.531989] megaraid_sas 0000:08:00.0: NVMe passthru support : Yes
> [   30.615336] megaraid_sas 0000:08:00.0: NVME page size   : (4096)
> [   52.035895] nvme 0000:81:00.0: Adding to iommu group 5
> [   52.047732] nvme nvme0: pci function 0000:81:00.0
> [   52.067216] nvme nvme0: 22/0/2 default/read/poll queues
> [   52.087318]  nvme0n1: p1
> =

> So I get these results:
> cpu0 335K
> cpu32 346K
> cpu64 300K
> cpu96 300K
> =

> So still not massive changes.

In your last email, the results are the following with irq mode io_uring:

 cpu0  497K
 cpu4  307K
 cpu32 566K
 cpu64 488K
 cpu96 508K

So looks you get much worse result with real io_polling?

> =

> > > Here's some system info:
> > > =

> > > HW queue irq affinities:
> > > PCI name is 81:00.0: nvme0n1
> > > -eirq 298, cpu list 67, effective list 67
> > > -eirq 299, cpu list 32-38, effective list 35
> > > -eirq 300, cpu list 39-45, effective list 39
> > > -eirq 301, cpu list 46-51, effective list 46
> > > -eirq 302, cpu list 52-57, effective list 52
> > > -eirq 303, cpu list 58-63, effective list 60
> > > -eirq 304, cpu list 64-69, effective list 68
> > > -eirq 305, cpu list 70-75, effective list 70
> > > -eirq 306, cpu list 76-80, effective list 76
> > > -eirq 307, cpu list 81-85, effective list 84
> > > -eirq 308, cpu list 86-90, effective list 86
> > > -eirq 309, cpu list 91-95, effective list 92
> > > -eirq 310, cpu list 96-101, effective list 100
> > > -eirq 311, cpu list 102-107, effective list 102
> > > -eirq 312, cpu list 108-112, effective list 108
> > > -eirq 313, cpu list 113-117, effective list 116
> > > -eirq 314, cpu list 118-122, effective list 118
> > > -eirq 315, cpu list 123-127, effective list 124
> > > -eirq 316, cpu list 0-5, effective list 4
> > > -eirq 317, cpu list 6-11, effective list 6
> > > -eirq 318, cpu list 12-16, effective list 12
> > > -eirq 319, cpu list 17-21, effective list 20
> > > -eirq 320, cpu list 22-26, effective list 22
> > > -eirq 321, cpu list 27-31, effective list 28
> > > =

> > > =

> > > john@ubuntu:~$ lscpu | grep NUMA
> > > NUMA node(s):  4
> > > NUMA node0 CPU(s):   0-31
> > > NUMA node1 CPU(s):   32-63
> > > NUMA node2 CPU(s):   64-95
> > > NUMA node3 CPU(s):   96-127
> > > =

> > > john@ubuntu:~$ lspci | grep -i non
> > > 81:00.0 Non-Volatile memory controller: Huawei Technologies Co., Ltd.=
 Device
> > > 0123 (rev 45)
> > > =

> > > cat /sys/block/nvme0n1/device/device/numa_node
> > > 2
> > BTW, nvme driver doesn't apply the pci numa node, and I guess the
> > following patch is needed:
> > =

> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 11779be42186..3c5e10e8b0c2 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4366,7 +4366,11 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struc=
t device *dev,
> >   	ctrl->dev =3D dev;
> >   	ctrl->ops =3D ops;
> >   	ctrl->quirks =3D quirks;
> > +#ifdef CONFIG_NUMA
> > +	ctrl->numa_node =3D dev->numa_node;
> > +#else
> >   	ctrl->numa_node =3D NUMA_NO_NODE;
> > +#endif
> =

> From a quick look at the code, is this then later set for the PCI device =
in
> nvme_pci_configure_admin_queue()?

Yeah, you are right, the pci numa node has been used.

> =

> >   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> >   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
> >   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> > =

> > > [   52.968495] nvme 0000:81:00.0: Adding to iommu group 5
> > > [   52.980484] nvme nvme0: pci function 0000:81:00.0
> > > [   52.999881] nvme nvme0: 23/0/0 default/read/poll queues
> > Looks you didn't enabling polling. In irq mode, it isn't strange
> > to observe IOPS difference when running fio on different CPUs.
> =

> If you are still keen to investigate more, then can try either of these:
> =

> - add iommu.strict=3D0 to the cmdline
> =

> - use perf record+annotate to find the hotspot
>   - For this you need to enable psuedo-NMI with 2x steps:
>     CONFIG_ARM64_PSEUDO_NMI=3Dy in defconfig
>     Add irqchip.gicv3_pseudo_nmi=3D1
> =

>     See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/arch/arm64/Kconfig#n1745
>     Your kernel log should show:
>     [    0.000000] GICv3: Pseudo-NMIs enabled using forced ICC_PMR_EL1
> synchronisation

OK, will try the above tomorrow.

> =

> But my impression is that this may be a HW implementation issue, consider=
ing
> we don't see such a huge drop off on our HW.

Except for mpere-mtjade, we saw bad nvme performance on ThunderX2=AE CN99XX=
 too,
but I don't get one CN99XX system to check if the issue is same with
this one.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
