Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1A2C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 15:59:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11508613C5
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 15:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11508613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=34hzdSJigZ9W1Rx1lfEum2Fj9sVmJEfKY/+u+LvPuYQ=; b=SdEv8Z6KZiSa0vfCCJ0Ip5UNu
	COz087+meNREBhEs56aAqIeoSL47XCf43mqPggpH57iGNGyZQZJc6C/QoA8YJyo7+Kr3LpliIET2m
	bgAwrts1PmzqDqKtFdOogdZH1x20F5uTaSOM4RCDbLLb+35AVfUdxsuMZ+GGDdi3o12rnCoPHbzNT
	/TQ3GWO68CXR1gsqcxiyaWKZDgQMI38M+RpAtkslsuTOp+68lvWzGroE4RoKbtsLFbl7mb6y15NBU
	WO3go0mi6HWYBxZUnAt861Qvd92QSXatuisupWBSzWNSplglFy7BLlPrSF3OwdUdncmj78j065pX3
	QVL62RahA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbmai-003nXe-Ra; Wed, 28 Apr 2021 15:59:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbmaX-003nX5-Np
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 15:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=7QCrLsEA8AfmBCjkcWwYdU/qZ8s81ypMWPcMfkDAfo8=; b=nCjrDifWt8GVESGFrLPid74C+U
 qNTtfXNMXvo9E9jh5vp2v1mm8xClFrKZkmWxrWbHASjIIMWYpjeo3VAEk8sqq8uDJbo74th5RVDxi
 8raj7N2lutcLd+WO+SELHS0v8T386yL8Pea6fgYmXDR7Lt51akHzA/LfF4Cp9ErSYrBocFUhc5Wn7
 uyiDx2s9eA4nIHwwZ8QgGMnRS64vawuhAziwctrNJ9x7Wz+Al5R2ec396nEGnQG/fhFT9NRw7yezt
 2i8iX0yd6XMzBhd1il1TvBtCCJf7RJOfidelJGQrV1glKI3qgjfT3K78SIuPnE7ANLnxuXcB34Fiv
 sm+rVMgw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbmaU-00006n-Qk
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 15:58:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2983613BF;
 Wed, 28 Apr 2021 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619625534;
 bh=mbdX094ICi96UjiXN+UMEt2+rZ+IgEQVVC2q8WvYroY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GVWApvJv4PgoeJNhllx+rMXhSgyVKXfJMKZDrSlFgptQdD3TJkIak64bV4+NjwQOD
 zkiCFjcibParN3oj6+JwYI4RU5XzKn8oYHF9vn+YW3wzEzB0G4x9979I+XY+f3wEOo
 YFmySaifqgdIkDN+ZR2dBCYYQRM4oAL4LtdNljBAgdT+fgfgq0FM4rq360sPXGlgqE
 KyPi1G9FPJi/j1FgepFEM6Onu3tqhm/BPyvM6WXrejW38Hw0L79CtDRJNwxsqBdn5M
 g776syxIJrFxCGvn97OcaajcVc8Ezgm+oStgntT9h0o5NUDhpEt23VsRpOLFVX/1jx
 EItfTucUtv23g==
Date: Thu, 29 Apr 2021 00:58:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210428155847.GA21854@redsun51.ssa.fujisawa.hgst.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
 <8d8c5c82-f1d3-5599-ae3e-5af5ff12eb9d@grimberg.me>
 <20210427233956.GA631292@dhcp-10-100-145-180.wdc.com>
 <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <549e4f57-5f6e-d5ed-db63-8f82e9a7490a@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_085854_970937_B9E133F0 
X-CRM114-Status: GOOD (  43.26  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 27, 2021 at 04:55:43PM -0700, Sagi Grimberg wrote:
> 
> > > > > > > > This was observed on the recent 5.12-rc4, so it has all the latest tcp
> > > > > > > > fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
> > > > > > > > difference. It is currently reproducible, though it can take over an
> > > > > > > > hour right now.
> > > > > > > 
> > > > > > > After reverting 0dc9edaf80ea, we are observing a kernel panic (below).
> > > > > > 
> > > > > > Ah, that's probably because WRITE_ZEROS are not set with RQF_SPECIAL..
> > > > > > This patch is actually needed.
> > > > > > 
> > > > > > 
> > > > > > > We'll try adding it back, plust adding your debug patch.
> > > > > > 
> > > > > > Yes, that would give us more info about what is the state the
> > > > > > request is in when getting these errors
> > > > > 
> > > > > We have recreated with your debug patch:
> > > > > 
> > > > >     nvme nvme4: queue 6 no space in request 0x1 no space cmd_state 3
> > > > > 
> > > > > State 3 corresponds to the "NVME_TCP_CMD_DATA_DONE".
> > > > > 
> > > > > The summary from the test that I received:
> > > > > 
> > > > >     We have an Ethernet trace for this failure. I filtered the trace for the
> > > > >     connection that maps to "queue 6 of nvme4" and tracked the state of the IO
> > > > >     command with Command ID 0x1 ("Tag 0x1"). The sequence for this command per
> > > > >     the Ethernet trace is:
> > > > > 
> > > > >      1. The target receives this Command in an Ethernet frame that has  9 Command
> > > > >         capsules and a partial H2CDATA PDU. The Command with ID 0x1 is a Read
> > > > >         operation for 16K IO size
> > > > >      2. The target sends 11 frames of C2HDATA PDU's each with 1416 bytes and one
> > > > >         C2HDATA PDU with 832 bytes to complete the 16K transfer. LAS flag is set
> > > > >         in the last PDU.
> > > > >      3. The target sends a Response for this Command.
> > > > >      4. About 1.3 ms later, the Host logs this msg and closes the connection.
> > > > > 
> > > > > Please let us know if you need any additional information.
> > > > 
> > > > I'm not sure if this is just a different symptom of the same problem,
> > > > but with the debug patch, we're occasionally hitting messages like:
> > > > 
> > > >     nvme nvme5: req 8 r2t len 16384 exceeded data len 16384 (8192 sent) cmd_state 2
> > > 
> > > According to this message, this means the host got an r2t for 16384
> > > bytes after it already sent 8192 (which can only happen if it previously
> > > got an r2t soliciting 8192 bytes or more that accumulate to that). Can
> > > you share for each r2t pdus in this sequence:
> > > r2t_length
> > > r2t_offset
> > 
> > This one took a bit to go through. The traces all only have a single r2t
> > pdu with 0 offset for the full length of the requested transfer. I had
> > to add trace events to see what the heck the driver is thinking, and
> > the result is even more confusing.
> > 
> > The kernel message error:
> > 
> >      nvme5: req 5 op 1 r2t len 16384 exceeded data len 16384 (4096 sent)
> > 
> > And all the new trace events for this request are:
> > 
> >      fio-25086   [011] ....  9630.542669: nvme_tcp_queue_rq: nvme5: qid=4 tag=5 op=1 data_len=16384
> >      fio-25093   [007] ....  9630.542854: nvme_tcp_cmd_pdu: nvme5: qid=4 tag=5 op=1 page_offset=3664 send_len=72
> >      <...>-22670 [003] ....  9630.544377: nvme_tcp_r2t: nvme5: qid=4 tag=5 op=1 r2t_len=16384 r2t_offset=0 data_sent=4096 data_len=16384
> > 
> > The fact "data_sent" is non-zero on the very first r2t makes no sense to me.
> 
> Yep, not supposed to happen... Like the traces though! very useful and
> absolutely worth having.
> 
> > I so far can not find any sequence where that could happen.
> 
> The only way that data_sent can increment is either by getting an r2t
> solicitation or by sending incapsule data.
> 
> What is the ioccsz the controller is exposing?

In capsule data is not supported by this target, so ioccsz is 4.

> in nvme_tcp_sned_cmd_pdu we have:
> --
>                 if (inline_data) {
>                         req->state = NVME_TCP_SEND_DATA;
>                         if (queue->data_digest)
>                                 crypto_ahash_init(queue->snd_hash);
>                 } else {
>                         nvme_tcp_done_send_req(queue);
>                 }
> --
> 
> Where inline_data flag is:
> 	bool inline_data = nvme_tcp_has_inline_data(req);
> which essentially boils down to:
> 	req->data_len <= queue->cmnd_capsule_len - sizeof(struct nvme_command);
> 
> I wonder how does the nvme command sgl look like? is it an offset
> sgl?

Just a single data block descriptor SGL. The target supports only 1 and
reports that through ID_CTRL.MSDBD.

What do you mean by "offset" SGL?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
