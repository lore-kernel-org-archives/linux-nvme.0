Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141A5C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 05:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJ47g0lQiZ1IxZPAdoK3AtFcG9VYMclb8XyiilcI8U4=; b=sdXmHcNvLmA1YWOrBLYQIy8+GU
	Udd/L92JRUyIs8JOohBb7kKiDSjHpriEokx/4SY2SMT+flXIvdiNxYooh0r4bg8fwXMod4TJMQ/Nu
	Rm7W/AK0ZWZEhJ+Ob1sYo+NsRUyAOykm9UskeuaSuZYpwVZRTo4bunC64BzPQph3Ku6wHtfa73Iz6
	nZ6X6cep20pWL/y7jBX4UK//pfg3mM25LeJWodG4Wkb8w9B26mPcQJgNb8mJU83j9h/r8U2hviwGQ
	6z+W0tFwENhmUhuUOHw74UP0dFmEy3c5c+woEv1sQ5bHUUAZUatxU48J2Ka0yRI4X7usSXAgBYkPF
	fV48+a7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsbB8-0000000A9Xm-2Te0;
	Thu, 13 Mar 2025 05:32:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsbB4-0000000A9XO-39qX
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 05:32:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 05BBA5C4879;
	Thu, 13 Mar 2025 05:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1520AC4CEDD;
	Thu, 13 Mar 2025 05:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741843937;
	bh=emJoGt99NIuuRfKoBT8X5IZIhInNkbZdFL6rrAyLdYo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Z5kJHn6N/Z7Gh4Xlm1eZDQAC3QQ0Kqbv3kMBw2UgT+foZlGN/pf2StKvjXzDrQtvS
	 BC0Z51FdTLyOjbyJe1Ek/GuDzKLZj2FEZ42ZCVpLJ4FDqjMwhjzWzeQKwdTRuFb1/R
	 LdstGmxDjKVnqTtjiKFoK7iw2TZVJsXQ7uJRiboB46ThaRwW2keERHcWVtkAdflsM3
	 hZeY5voHe4C4XdPzo2BHFut6f1Gnet8H2RDg2JwsNMOraxGuV4VOYhZZHVFSFNQoCB
	 yd13aFeGqybdW8+zPtIc989dPF8DvXdHR0146JFGZmOHNJoHpANgpHlD4+1T3w3h+f
	 uEpllFxNmkKjA==
Message-ID: <61b7748f-839d-4746-a623-1912028c4fe8@kernel.org>
Date: Thu, 13 Mar 2025 14:32:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/11] nvmet: Add NVMe target mdev/vfio driver
To: Mike Christie <michael.christie@oracle.com>, chaitanyak@nvidia.com,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, joao.m.martins@oracle.com,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, kwankhede@nvidia.com,
 alex.williamson@redhat.com, mlevitsk@redhat.com
References: <20250313052222.178524-1-michael.christie@oracle.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250313052222.178524-1-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_223218_906009_67FC76B4 
X-CRM114-Status: GOOD (  35.82  )
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

On 3/13/25 14:18, Mike Christie wrote:
> The following patches were made over Linus's tree. They implement
> a virtual PCI NVMe device using mdev/vfio. The device can be used
> by QEMU and in the guest will look like a normal old local PCI
> NVMe drive.
> 
> They are based on Maxim Levitsky's mdev patches:
> 
> https://lore.kernel.org/lkml/20190506125752.GA5288@lst.de/t/
> 
> but instead of trying to export a physical NVMe device to a guest, they
> are only focused on exporting a virtual device using the nvmet layer.
> 
> Why another driver when we have so many? Performance.
> =====================================================
> Without any tuning and major locks still in the main IO path, 4K IOPS for
> a single controller with a single namespace are higher than the kernel
> vhost-scsi driver and SPDK vhost-scsi/blk user when using lower number
> of queues/cpus/jobs. At just 2 queues, we are able to hit 1M IOPS:
> 
> Note: the nvme mdev values below have the shadow doorbell enabled
> 
>         mdev vhost-scsi vhost-scsi-usr vhost-blk-usr
> numjobs
> 1       518K    198K        332K        301K
> 2       1037K   363K        609K        664K
> 4       974K    633K        1369K       1383K
> 8       813K    1788K       1358K       1363K
> 
> However, by default we can't scale. But, tuning mdev to pre-pin pages
> (this requires patches to the vfio layer to support) then it also performs
> better at lower and higher number of queues/cpus/jobs used with it
> reaching 2.3M IOPS woth only 4 cpus/queues used:
> 
>         mdev
> numjobs
> 1       505K
> 2       1037K
> 4       2375K
> 8       2162K
> 
> If we agree on a new virtual NVMe driver being ok, why mdev vs vhost?
> =====================================================================
> The problem with a vhost nvme is:
> 
> 2.1. If we do a fully vhost nvmet solution, it will require new guest
> drivers that present NVMe interfaces to userspace then perform the
> vhost spec on the backend like how vhost-scsi does.
> 
> I don't want to implement a windows or even a linux nvme vhost
> driver. I don't think anyone wants the extra headache.
> 
> 2.2. We can do a hybrid approach where in the guest it looks like we
> are a normal old local NVMe drive and use the guest's native NVMe driver.
> However in QEMU we would have a vhost nvme module that instead of using
> vhost virtqueues handles virtual PCI memory accesses as well as a vhost
> nvme kernel or user driver to process IO.
> 
> So not as much extra code as option 1 since we don't have to worry about
> the guest but still extra QEMU code.
> 
> 3. The mdev based solution does not have these drawbacks as it can
> look like a normal old local NVMe drive to the guest and can use QEMU's
> existing vfio layer. So it just requires the kernel driver.
> 
> Why not a new blk driver or why not vdpa blk?
> =============================================
> Applications want standardized interfaces for things like persistent
> reservations. They have to support them with SCSI and NVMe already
> and don't want to have to support a new virtio block interface.
> 
> Also the nvmet-mdev-pci driver in this patchset can perform was well
> as SPDK vhost blk so that doesn't have the perf advantage like it
> used to.
> 
> Status
> ======
> This patchset is RFC quality only. You can discover a drive and do
> IO but it's not stable. There's several TODO items mentioned in the
> last patch. However, I think the patches are at the point where I
> wanted to get some feedback about if this even acceptable because
> the last time they were posted some people did not like how
> they hooked into drivers/nvme/host (this has been fixed in this
> posting). There's some other issues like:
> 
> 1. Should the driver integrate with pci-epf (the drivers work very
> differently but could share some code)?

Will have a look.

> 
> 2. Should it try to fit into the existing configfs interface or implement
> it's own like how pci-epf did? I did an attempt for this but it feels
> wrong.

Note that the configfs for pci-epf is supported by the PCI endpoint
infrastructure. It is not all implemented by the driver alone.

-- 
Damien Le Moal
Western Digital Research

