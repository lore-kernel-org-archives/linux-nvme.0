Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B633DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Oct 2022 20:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XXTaJi4gmEbzulOsZgna75rfnmzbuiLoHarYl5lr6uw=; b=iHkJvgziV89RXPFMzbDswiEmnu
	Qd6bj3ngAuP16NieEtzZzwg63nNyW2sO0oRcYiwQysOG3ek9tPqVRsGhhD0UYHBvE4J3q8DMV4HBE
	7XuLNWDRx8yWW57TmhihcbY2KzBbCiS1jMpmBF49OsmxW5SuFU5Pcb+RO7XAlms6xrmXaW8ey36R2
	X/mTLbnaSvSwJ3zXhPZc6Vije2Qxk7IB8F5q1pkHAXnNBVODDYThxgAsPcpBlm3zA7sb3gTWuz5sk
	V9M/pRW31BrBB6DQ7Zi1q/NAfckGV15hWZOau7FLgYC9CKixsSd4OC7bSrG5LTF6qdQ9HE8vVr9m0
	1o5L/HPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiM0Z-005oRX-Fv; Tue, 11 Oct 2022 20:37:47 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiM0W-005oQr-Dl
	for linux-nvme@lists.infradead.org; Tue, 11 Oct 2022 20:37:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E07FDB80F9B;
	Tue, 11 Oct 2022 20:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7199DC433B5;
	Tue, 11 Oct 2022 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665520661;
	bh=VuP12wf751zAUpNtiXaAvHXoxtEv5eYxzplbClfQBlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMzAn75ao3cqZxJRHYxIoViPChYBIM4OvT5YoBMkJTcaVColDcf8GbBxSPfCrQx20
	 CgsGK10wYszdn5YaXKH5b1Cry/BLr53Ziu4aHmGzRSyMW/TB0TcNz5SRsgnN/uktBi
	 x45fus1iwuK0e3wDQhgg/X3v8FC82/XYmxQHy0EEs3QivV+wcAdk4dxMgmdLonDn/R
	 A+sw58lDUgS4hruf0NbeDcr/t/zfOatXp4NgNgp6af1TFRncNwTzQE1dDLuYIo5gdK
	 ln/OYUsdDvtoj6qyQtcKTk5itM/owhU4bdEMRuytA0l1HHXcBhXap8TtaZHOJg2MOb
	 Zay37ILRj2AMA==
Date: Tue, 11 Oct 2022 15:37:40 -0500
From: Seth Forshee <sforshee@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-tcp request timeouts
Message-ID: <Y0XUFGXHciDCXRTs@do-x1extreme>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
 <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
 <Y0XOoSmfwAdfOD9g@do-x1extreme>
 <f72fa6ba-e55a-6bb6-2efe-60458802c870@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f72fa6ba-e55a-6bb6-2efe-60458802c870@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221011_133744_770409_6241C678 
X-CRM114-Status: GOOD (  29.32  )
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

On Tue, Oct 11, 2022 at 08:19:47PM +0000, Chaitanya Kulkarni wrote:
> On 10/11/22 13:14, Seth Forshee wrote:
> > On Tue, Oct 11, 2022 at 07:30:56PM +0000, Chaitanya Kulkarni wrote:
> >> Hi Seth,
> >>
> >> On 10/11/22 08:31, Seth Forshee wrote:
> >>> Hi,
> >>>
> >>> I'm seeing timeouts like the following from nvme-tcp:
> >>>
> >>> [ 6369.513269] nvme nvme5: queue 102: timeout request 0x73 type 4
> >>> [ 6369.513283] nvme nvme5: starting error recovery
> >>> [ 6369.514379] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514385] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514392] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514393] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514401] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514414] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514420] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514427] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514430] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514432] block nvme5n1: no usable path - requeuing I/O
> >>> [ 6369.514926] nvme nvme5: Reconnecting in 10 seconds...
> >>> [ 6379.761015] nvme nvme5: creating 128 I/O queues.
> >>> [ 6379.944389] nvme nvme5: mapped 128/0/0 default/read/poll queues.
> >>> [ 6379.947922] nvme nvme5: Successfully reconnected (1 attempt)
> >>>
> >>> This is with 6.0, using nvmet-tcp on a different machine as the target.
> >>> I've seen this sporadically with several test cases. The fio fio-rand-RW
> >>> example test is a pretty good reproducer when numjobs in increased (I'm
> >>> setting it equal to the number of CPUs in the system).
> >>>
> >>> Let me know what I can do to help debug this. I'm currently adding some
> >>> tracing to the driver to see if I can get an idea of the sequence of
> >>> events that leads to this problem.
> >>>
> >>> Thanks,
> >>> Seth
> >>>
> >>
> >> Can you bisect it ? that will help to understand the commit causing
> >> issue.
> > 
> > I don't know of any "good" version right now. I started with a 5.10
> > kernel and saw this, and tested 6.0 and still see it. I found several
> > commits since 5.10 which fix some kind of timeouts:
> > 
> > a0fdd1418007 nvme-tcp: rerun io_work if req_list is not empty
> > 70f437fb4395 nvme-tcp: fix io_work priority inversion
> > 3770a42bb8ce nvme-tcp: fix regression that causes sporadic requests to time out
> > 
> > 5.10 still has timeouts with these backported, so whatever the problem
> > is it has existed at least that long. I suppose I could go back to older
> > kernels with these backported if that's going to be the best path
> > forward here.
> > 
> > Thanks,
> > Seth
> 
> Can you please share the fio config you are using ?

Sure. Note that I can reproduce it with a lower number of numjobs, but
higher numbers make it easier, so I set it to the number of CPUs present
on the system I'm using to test.


[global]
name=fio-rand-RW
filename=fio-rand-RW
rw=randrw
rwmixread=60
rwmixwrite=40
bs=4K
direct=0
numjobs=128
time_based
runtime=900

[file1]
size=10G
ioengine=libaio
iodepth=16


