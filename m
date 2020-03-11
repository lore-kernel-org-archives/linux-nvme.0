Return-Path: <SRS0=tokg=44=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A7BC10DCE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 01:27:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291F1205ED
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 01:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="daz1v5mD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2qu5ZMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291F1205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DBV4t+L/iLbTeGgJsbFLbyI9AJ3jEK3TXu/NYbtDUhM=; b=daz1v5mDDyUOl/
	92xalUaxCEYY46U34nkkrU2te3Vz6amRyaTn8jSLYGkVPIqfdt/msMCmC5h2Ky6EOAQqV+fs5sMOA
	Q+lJhPzOFUyTAp8N2U1IDwBwu2yh247AADjA6qemF5uhl7hV2vIrisCJmrVi3eUzX5JOBq9YgV0PU
	p5GioQDb0snwEXeBPSX7uqFr1W/+argrXyFBbz1GrWWWX+XjuKjVmappTYx0MI4E//k3+/w80TjsR
	mqgXS7yM04igy/h4w+17fZ9uj3OkY4r7JLtdf1s9b5gKpEJl/1O/9TVhpc7Ijj/pZYccLULY7CCOg
	mFGTGkPJK0OUp8G0jN2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBq9L-0007Vl-PZ; Wed, 11 Mar 2020 01:27:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBq9I-0007V9-R2
 for linux-nvme@lists.infradead.org; Wed, 11 Mar 2020 01:27:06 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1A5EB205ED;
 Wed, 11 Mar 2020 01:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583890023;
 bh=2WR/XqFjKZdY2vFOsxiWU+HrbFRF/jZWdWnBW9PIM1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n2qu5ZMjZ/ua3UaMuscAtWnOjJ394g6iuaEDZOnuby+NqxAVmCNj0d1qagqjyFvUC
 pLql8hv3NPnzwZOFim7pH89/evbV5iKMCbKcuAxV5gvUNIXVPjlRIW7ULmBJOqKrkw
 2sJTt3C7L2gpMenESxWaB6eU2BLVru5Q+2w0tM9g=
Date: Tue, 10 Mar 2020 18:27:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Subject: Re: I/O performance with block sizes > 128k
Message-ID: <20200311012701.GF604509@dhcp-10-100-145-180.wdl.wdc.com>
References: <321f0a4b-8a75-8cae-2d77-34ad712225d3@oracle.com>
 <20200310170818.GA28008@infradead.org>
 <20200310194421.GB17237@redsun51.ssa.fujisawa.hgst.com>
 <3971720d-d05d-9a08-cb5e-6396df70a8b2@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3971720d-d05d-9a08-cb5e-6396df70a8b2@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_182704_899852_A568C5F6 
X-CRM114-Status: GOOD (  15.71  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 10, 2020 at 05:52:02PM -0700, Bijan Mottahedeh wrote:
> On 3/10/2020 12:44 PM, Keith Busch wrote:
> > On Tue, Mar 10, 2020 at 10:08:18AM -0700, Christoph Hellwig wrote:
> > > On Mon, Mar 09, 2020 at 02:49:10PM -0700, Bijan Mottahedeh wrote:
> > > > I'm seeing a sizeable drop in perf with polled fio tests for block =
sizes >
> > > > 128k:
> > > Try using a controller with SGL support.  NVMe PRP unfortunately are
> > > a completely brain dead scheme once you use non-tiny I/O sizes (
> > > and actually really painful even for those for other reasons).
> > SGL would really help if you have phyiscal continuity, and never needs
> > to allocate from the dma pools. If most pages in the transfer are not
> > physically contiguous, though, PRP is still more memory efficient. But
> > yes, the PRP format is ... unique. :)
>
> So with SGL you can potentially bypass dma pool allocation but with PRP y=
ou
> always have to regardless of contiguity?

Yes, if the payload can be expressed as a single address range, an
SGL capable controller can describe that in the NVMe command without
allocating a scatter list payload to accompany the command.

The maximum length of a PRP is 4k. If you're transferring 256k per
command, that will require at least 64 PRP entries regardless of the
number of ranges in the DMA mapped scatter-list.

> > FWIW, I couldn't measure a performance drop on real hardware comparing
> > the large pool vs the small one.
> =

> I took out my workaround.
> =

> I can't see a big drop on h/w with 256k either; however, I can't push the
> tests far enough because they hang depending on the number of fio jobs and
> iodepth.
> =

> They seem to be stuck in an io_uring poll loop:
> =

> =A0=A0=A0 58.91%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0 [k] blk_poll
> =A0=A0=A0 27.01%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0 [k] io_iopoll_get=
events
> =A0=A0=A0=A0 8.56%=A0 [kernel]=A0=A0=A0=A0=A0=A0=A0=A0=A0 [k] blkdev_iopo=
ll

That looks pretty normal for polled io.
 =

> I had to kill the fio jobs and got a bunch of this output:
> =

> Jobs: 103 (f=3D103): [r(4),_(1),r(12),_(1),r(2),_(1),r(10),_(1),r(2),_(1)=
,r(1),_(1),r(7),_(1),r(1),_(2),r(16),_(1),r(5),_(1),r(6),_(2),r(2),_(1),r(2=
),_(1),r(2),_(1),r(3),_(1),r(9),_(1),r(4),_(2),r(5),_(1),r(3),_(1),r(1),_(1=
),r(4),_(2),r(2)][0fio:
> job 'fiotest' (state=3D5) hasn't exited in 300 seconds, it appears to be
> stuck. Doing forceful exit of this job.
> =

> Hopefully Jens can comment what this means.

What kernel are you using? A bug observed with multiple threads polling
the same queue was just fixed in the 5.6-rc5 release (also in 5.5.8,
5.4.24 stables).

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
