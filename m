Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3835EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=73Fr9S9nx8T7H/jiHas6UVLS2rsrVkJYqrrTnSJQ304=; b=FBbaR2q+RCqXPjW/4nvQVY30M/
	27YoRvYuxP8WkdqiMDGVAVQV/QvWm99t/uC4ZDM510y9q8nK8O+FZxzWOWhCumFmanlSZ3i8P7QIi
	JZG36e8k90pZqFeBSktJTrccFky0/lRWQzYSFTIzrxEZQKGzIZHLlbX91aPgTS6J2YU/7hPnqSbz4
	qyPQQ0q/cO/oEEGEMphHcFu/KycpVbrk/XVM3qEzI/k718zEIpvHYElmAviDAciGiRa0ZjGcU6npA
	drOVmqDC8IiqlmXYp/vSMeu+/DipxjU2K4FVv1SUtyQejOjRKn89RDWMygf2MEVkHF9brPaX4UlxE
	ZbolS5IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntX4u-008cAc-FG; Tue, 24 May 2022 16:08:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntX4r-008c9J-Lu
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 16:08:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 81BA760F8C;
 Tue, 24 May 2022 16:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AA8C34113;
 Tue, 24 May 2022 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653408488;
 bh=oiW2p/UGLESMDfrF9POu/KIjyAN8pSubovc2wkGpmNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f32ZOwqaFVKv6UhGz793ohOEqfrZptAhb45nNNhKoNzk6bu86hcwTLXOooSDF9arP
 hxKpU0MNQU/gviO8eVE5jecbIoPS+Z5D5n5hDRu84LFjeMOcjRYFXZ1kdjb4oXrmIZ
 tI39MJv1Yqq+t3mJQ8yw7w3HYt/s50Rj/TPpcJacDzbykVCDKvAftjT0XJv9R0/kQZ
 KNeIIK6IKixBeEtH4wKBNXX24ZrNOLNFEHfmN+2v6iXZ6PZVJfFQ37LTtgzX2lQb25
 uM+cakgarlmL5aguJerEPMKuNPRka73b0++4H7SuPZ3Zexg3o9faUkk1YaskGAoLUE
 GYpgKXXYsPloQ==
Date: Tue, 24 May 2022 10:08:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Nicklin <jnicklin@blockbridge.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: nvme: split bios issued in reverse order
Message-ID: <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_090809_827736_4FBDABEF 
X-CRM114-Status: GOOD (  16.85  )
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

On Tue, May 24, 2022 at 09:25:20AM -0400, Jonathan Nicklin wrote:
> On Tue, May 24, 2022 at 8:58 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > There seems to be an inconsistency in the order of writes that are
> > > issued after splitting a bio. Ordering depends on how the application
> > > write is submitted and the number of I/O queues configured.
> > >
> > > In our testing nvme/tcp,
> >
> > Is this specific to nvme-tcp?
> 
> No. This is not specific to nvme-tcp. I confirmed the same behavior
> directly to a pci device.

I just tried this on a qemu pci device with MDTS set to  '3' for 32k splits.
Both psync and libaio dispatch the submitted bio's in ascending LBA order. I'm
using kernel 5.18 with these fio commands:

 # fio --name=global --filename=/dev/nvme0n1 --bs=128k --direct=1 --size=128k --rw=read --ioengine=psync --name=job 
 # fio --name=global --filename=/dev/nvme0n1 --bs=128k --direct=1 --size=128k --rw=read --ioengine=libaio --name=job 

The first command produced this trace:

 fio-438 .. 57.799950: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=29184, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-438 .. 57.799995: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=513, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-438 .. 57.800002: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=514, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-438 .. 57.800009: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=515, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-438 .. 57.800017: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=516, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=256, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-438 .. 57.800023: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=517, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=320, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-438 .. 57.800029: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=518, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=384, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-438 .. 57.800046: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=3, cmdid=519, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=448, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

And the second command produced this:

 fio-445 ..  83.440824: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=32896, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-445 ..  83.440870: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=28801, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=64, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-445 ..  83.440920: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=24706, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=128, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-445 ..  83.440931: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=20611, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=192, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-445 ..  83.441246: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=36992, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=256, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-445 ..  83.441259: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=32897, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=320, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-445 ..  83.441287: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=28802, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=384, len=63, ctrl=0x0, dsmgmt=0, reftag=0)
 fio-445 ..  83.441348: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=10, cmdid=41088, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=448, len=63, ctrl=0x0, dsmgmt=0, reftag=0)

