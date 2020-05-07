Return-Path: <SRS0=DRq2=6V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA29EC38A24
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 15:35:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8C52082E
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2020 15:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UhvMX1u+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0/hmWRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8C52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0bD1Hh26U2xt48lYHqz5K9yB8rOclxJfcjPrkVl3du8=; b=UhvMX1u+fbh6tT
	IzYPbe+vioEWbDdU0iQHiXbsN0jfiV4qGhOj58kCj+jQ9cXyz76mEI2qBjC1N2Fju7D1kXf7r72Ic
	Ib0ao36gJcuGjZUr/MWO/MQvwR0mn4zDvC0zj1BlzcakQLNFztHrBE9Addx1naK1wTGm2pn46OVI7
	3Pl/XcRcMSUbuqhvO75KgjACiZ0EWMhZUYt7s5VWeUiDDTerJS1byAiHjSWXfhJIv7uWfxh6p3cxw
	zC5hOS8+grfFnQhMNurARFj8BUGxYWXvEJbRoskZtVpQMELq6jpb9sD2Kyli0bclpMx+Rz+WkM/FD
	1lrj3kYCPdqrIlXDlbzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWiYK-0003rU-CT; Thu, 07 May 2020 15:35:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWiYH-00038w-8o
 for linux-nvme@lists.infradead.org; Thu, 07 May 2020 15:35:10 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5FF5B207DD;
 Thu,  7 May 2020 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588865708;
 bh=6dd46DbqPVPLM4tQsRo/+agcDGFgoxHT2tuttmS6f1g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a0/hmWRgxqAfK0XDWJztLXsXrTYODvjPyxIy1fWjT2Jlov2jRsEDnbZ3tGaPSxdwx
 6aMwj+CbJVZwIvtOcbCnFgt9wDQF+wHln46XefEV/e24o67ciYFvGOHpedGAnrOpg2
 2EfD9dSZHS/95+pPUo6ZozxxuqEEbEkdCm9e/xbA=
Date: Thu, 7 May 2020 08:35:06 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200507153506.GA2621480@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200506143519.GA570@lst.de>
 <4155a814-798c-0c7e-5433-daf719c0345c@huawei.com>
 <20200506163104.GD12919@willie-the-truck>
 <3453193c-424b-1e4c-16be-279088612c68@arm.com>
 <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
 <6673a108-c572-12ff-7ddd-b88147829615@huawei.com>
 <4dae5990-e81b-8b33-dafc-ee47e4f06b6a@arm.com>
 <e1643b53-d362-0b5e-573f-72f0ea249ebf@huawei.com>
 <20200507142352.GA2621422@dhcp-10-100-145-180.wdl.wdc.com>
 <8b297620-c72b-2184-36cb-032f5cfda05c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8b297620-c72b-2184-36cb-032f5cfda05c@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_083509_359760_5A3AF056 
X-CRM114-Status: GOOD (  17.80  )
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
Cc: sagi@grimberg.me, Robin Murphy <robin.murphy@arm.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, axboe@fb.com,
 Will Deacon <will@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 07, 2020 at 04:11:23PM +0100, John Garry wrote:
> On 07/05/2020 15:23, Keith Busch wrote:
> > On Thu, May 07, 2020 at 02:55:37PM +0100, John Garry wrote:
> > > On 07/05/2020 12:04, Robin Murphy wrote:
> > > > > [=A0 177.132810] DMA-API: nvme 0000:85:00.0: device driver tries =
to
> > > > > free DMA memor
> > > > > y it has not allocated [device address=3D0x00000000ef371000]
> > > > > [size=3D4096 bytes]
> > > > [...]
> > > > > [=A0 177.276322]=A0 debug_dma_unmap_page+0x6c/0x78
> > > > > [=A0 177.280487]=A0 nvme_unmap_data+0x7c/0x23c
> > > > > [=A0 177.284305]=A0 nvme_pci_complete_rq+0x28/0x58
> > > > =

> > > > OK, so there's clearly something amiss there. I would have suggested
> > > > next sticking the SMMU in passthrough to help focus on the DMA API
> > > > debugging, but since that "DMA address" looks suspiciously like a
> > > > physical address rather than an IOVA, I suspect that things might
> > > > suddenly appear to be working fine if you do...
> > > =

> > > OK, seems sensible. However it looks like this guy triggers the issue:
> > > =

> > > 324b494c2862 nvme-pci: Remove two-pass completions
> > > =

> > > With carrying the revert of $subject, it's a quick bisect to that pat=
ch.
> > =

> > That's weird.
> =

> Or maybe exacerbating some other fault?
>
>  Do you see this with different nvme controllers?
> =

> I only have 3x, and they are all ES3000 V3 NVMe PCIe SSD
>
> > Does your
> > controller write the phase bit before writing the command id in the cqe?
> =

> I don't know. Is that sort of info available from nvme-cli?

No, the only way to 100% confirm is with bus protocol analyzers. It's
a protocol violation if a controller was behaving that way. We've seen
devices broken like that before, though it's been a while since I've
seen such behvaior.

> [  885.344575] WARNING: CPU: 41 PID: 4565 at block/blk-mq.c:665  blk_mq_s=
tart_request+0xc4/0xcc

This warning appears to support my suspicion: the completion side is
observing a new phase with a stale command id, and that command id was
reallocated as a new request that we're still constructing at the time
the double-completion occured.

Host software is supposed to be guaranteed the entire CQE is written
once we see an updated phase, per spec: "If a Completion Queue
Entry is constructed via multiple writes, the Phase Tag bit shall be
updated in the last write of that Completion Queue Entry."

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
