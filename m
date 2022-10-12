Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988F3C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 16:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cGhlfSWnblXAK9nHJOezlZH+1A+tIq9co2EabIdm/JM=; b=UJsL8ozg0MIsC8xfPmrJq/LVOI
	VG3lYvKuw3MhSQ/UPdQfy+BxTI8qqTDtk+hfJD1qyyDNJMqU5epsMWQaMGZWttedhrJfbdBaqYAQ/
	HY864ajHpli6qBItgbRKMnJulcvQWjf6qqRxoAbF4muu3Lp5mCM0ZDuvBuGod87PlYoYcbb4+SzjC
	1vPBFaSeNPcVeMC4QTLqLB1Kxb5LPGtu5DweYVdFNe+jiRl9CIyZCZWSpd2vNVWNxoFGnraPWSCmr
	WsXiKz9JdoBRfj2/Uwdc9UqgeCG7rV445xyg2vIhdICwrBjX+N4MWbs9K7Un7gdvV3HSbfyphvpK4
	px/rG/YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oif0t-008lvv-Vf; Wed, 12 Oct 2022 16:55:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oif0r-008lvA-4I
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 16:55:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 13DA56153D;
	Wed, 12 Oct 2022 16:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D952C433D6;
	Wed, 12 Oct 2022 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665593719;
	bh=ToPKgmjLTd75owm5QSmeI2CAa7sXe8tT57dqU21OEwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1jpt3ZMED33+BLZS9emL4978k044iRYwvY96Fyk6kHPiPUQaeD8SbQAvV6pZaArl
	 uS3HRU8LdHsgBUbcDNDL9yOHdH9IX4u8R12jv8JyTVTJfWZEWQIHhSV0UEII555N5R
	 60BjJe2bFdfj6PW6aetwrwUsqC4Y77wcGA0n1pK/DQXG0pcxoBWWWUIqC8WNJIVcaC
	 DRBVxJFEnS9JgkDvBIw3P34mCecdjGc7UnDHXqSgepIa+UCkGoMG+0mVu40uxm8Ock
	 dlPinKbT6cEwOq/Gyhot+NwTlh2aoXyOCMuzLjjVMqmWkyH4mOixFxQGatm0wHfIz/
	 Rn/oJAOmBHEEA==
Date: Wed, 12 Oct 2022 11:55:18 -0500
From: Seth Forshee <sforshee@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-tcp request timeouts
Message-ID: <Y0bxdiqgNAGoxeY6@do-x1extreme>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
 <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
 <Y0XOoSmfwAdfOD9g@do-x1extreme>
 <f72fa6ba-e55a-6bb6-2efe-60458802c870@nvidia.com>
 <Y0XUFGXHciDCXRTs@do-x1extreme>
 <f7b44962-09d3-c724-89bc-453c86f4c1eb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b44962-09d3-c724-89bc-453c86f4c1eb@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_095521_293088_B083E242 
X-CRM114-Status: GOOD (  40.30  )
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

On Wed, Oct 12, 2022 at 09:33:19AM +0300, Sagi Grimberg wrote:
> Hey Seth, thanks for reporting.
> 
> > > > > Hi Seth,
> > > > > 
> > > > > On 10/11/22 08:31, Seth Forshee wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > I'm seeing timeouts like the following from nvme-tcp:
> > > > > > 
> > > > > > [ 6369.513269] nvme nvme5: queue 102: timeout request 0x73 type 4
> > > > > > [ 6369.513283] nvme nvme5: starting error recovery
> > > > > > [ 6369.514379] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514385] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514392] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514393] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514401] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514414] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514420] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514427] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514430] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514432] block nvme5n1: no usable path - requeuing I/O
> > > > > > [ 6369.514926] nvme nvme5: Reconnecting in 10 seconds...
> > > > > > [ 6379.761015] nvme nvme5: creating 128 I/O queues.
> > > > > > [ 6379.944389] nvme nvme5: mapped 128/0/0 default/read/poll queues.
> > > > > > [ 6379.947922] nvme nvme5: Successfully reconnected (1 attempt)
> > > > > > 
> > > > > > This is with 6.0, using nvmet-tcp on a different machine as the target.
> > > > > > I've seen this sporadically with several test cases. The fio fio-rand-RW
> > > > > > example test is a pretty good reproducer when numjobs in increased (I'm
> > > > > > setting it equal to the number of CPUs in the system).
> > > > > > 
> > > > > > Let me know what I can do to help debug this. I'm currently adding some
> > > > > > tracing to the driver to see if I can get an idea of the sequence of
> > > > > > events that leads to this problem.
> > > > > > 
> > > > > > Thanks,
> > > > > > Seth
> > > > > > 
> > > > > 
> > > > > Can you bisect it ? that will help to understand the commit causing
> > > > > issue.
> > > > 
> > > > I don't know of any "good" version right now. I started with a 5.10
> > > > kernel and saw this, and tested 6.0 and still see it. I found several
> > > > commits since 5.10 which fix some kind of timeouts:
> > > > 
> > > > a0fdd1418007 nvme-tcp: rerun io_work if req_list is not empty
> > > > 70f437fb4395 nvme-tcp: fix io_work priority inversion
> > > > 3770a42bb8ce nvme-tcp: fix regression that causes sporadic requests to time out
> > > > 
> > > > 5.10 still has timeouts with these backported, so whatever the problem
> > > > is it has existed at least that long. I suppose I could go back to older
> > > > kernels with these backported if that's going to be the best path
> > > > forward here.
> > > > 
> > > > Thanks,
> > > > Seth
> > > 
> > > Can you please share the fio config you are using ?
> > 
> > Sure. Note that I can reproduce it with a lower number of numjobs, but
> > higher numbers make it easier, so I set it to the number of CPUs present
> > on the system I'm using to test.
> > 
> > 
> > [global]
> > name=fio-rand-RW
> > filename=fio-rand-RW
> > rw=randrw
> > rwmixread=60
> > rwmixwrite=40
> > bs=4K
> > direct=0
> 
> Does this happen with direct=1?

So far I haven't been able to reproduce it so far with direct=1.

> > numjobs=128
> > time_based
> > runtime=900
> > 
> > [file1]
> > size=10G
> > ioengine=libaio
> > iodepth=16
> > 
> 
> Is it possible that the backend nvmet device is not fast enough?
> Are your backend devices nvme? Can you share nvmetcli ls output?

Currently I have a quick-and-dirty setup. The systems I have to test
with don't have a spare nvme device right now but do have a lot of RAM,
so the backend is a loop device backed by a file in tmpfs. But it should
be plenty fast. I'm working on getting a setup with an nvme backend
device.

o- / ......................................................................................................................... [...]
  o- hosts ................................................................................................................... [...]
  | o- hostnqn ............................................................................................................... [...]
  o- ports ................................................................................................................... [...]
  | o- 2 ................................................... [trtype=tcp, traddr=..., trsvcid=4420, inline_data_size=16384]
  |   o- ana_groups .......................................................................................................... [...]
  |   | o- 1 ..................................................................................................... [state=optimized]
  |   o- referrals ........................................................................................................... [...]
  |   o- subsystems .......................................................................................................... [...]
  |     o- testnqn ........................................................................................................... [...]
  o- subsystems .............................................................................................................. [...]
    o- testnqn ............................................................. [version=1.3, allow_any=1, serial=2c2e39e2a551f7febf33]
      o- allowed_hosts ....................................................................................................... [...]
      o- namespaces .......................................................................................................... [...]
        o- 1  [path=/dev/loop0, uuid=8a1561fb-82c3-4e9d-96b9-11c7b590d047, nguid=ef90689c-6c46-d44c-89c1-4067801309a8, grpid=1, enabled]

> Also, just to understand if things are slow or stuck, perhaps you
> can artificially increase the io_timeout to say 60s or 120s.

I could still reproduce it with io_timeout set to 120s.

Thanks,
Seth

