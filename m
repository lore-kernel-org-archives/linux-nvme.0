Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7492C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 19:53:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBFF61177
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 19:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBFF61177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZBXlhCFzEdvNvhqrXm2ykElzMkeThuR4FrG6dPwm4m4=; b=ow52QWYp44r333Cl2CZxqFwLx
	FjESVh6/GQ7pUSCu948V3lMDQLeQ+ZmZqL+X6ef30trHdzHVQuvcti1X9XbQb+wnjGxSNNxpy04TK
	xnWDgUcRME+9ovYE5TwVFMzEg/ZUJQp7jFNyrKPyvgn/m6MJ25UXWZTeAn3+TGOQDXVn1DVAXTpxY
	ksbK3gWM+eIslt7GnLdKA31ixuQ2wrMp0bQZknqtIIO+n/dTFqQJvt8Ns2ioq2fk8Qv3iGO9KZjFc
	UjBZweJvNZZmuNaQNZbSE+XdW8UZlRRWiFK+g3tIdGKet9RLfkvRzM+0xw+B9LB5vUzskqPhDFgqC
	A31MU+UdA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUEF8-005suk-2f; Wed, 07 Apr 2021 19:53:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUEF1-005stg-Av
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 19:53:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD17F61130;
 Wed,  7 Apr 2021 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617825206;
 bh=Y8tM6/wf+ua0tN4Cfx8ho+ANEUmJWOssXl5lTrCvLUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dgz6ynYFlpdGGcEfVTZgRJD8S1mdFwVrWoqjM4vwycY1PS0dlOJ4OdGCbvLrrzp0i
 huzDwZK/t1lB+DHVYXh6DSB1BRis0Cq3eVaar7unGhu5S2BMubqKfyAmMDd9E1OVeC
 AE1KjWIG9b4DKtGYE/z47fd+g+hfyABFvXxnRrFIVix383Cz8AErOnds11Pf2utFct
 nhpS8Ctr1ZmdU2hmzxykhS4Ovf8XeNfMzeLtTH5YxC5ovNQZjF6gYUfroP4roPRtla
 980dzAl8R0QHGjxzFAePP0f9ublnfvKdWr+wLLv1wY5tr5cyTMDYgWyGQFFceGf3Cb
 1Syg1f9GpU/bA==
Date: Thu, 8 Apr 2021 04:53:19 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210407195319.GA30623@redsun51.ssa.fujisawa.hgst.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_205331_637553_D20EFAF2 
X-CRM114-Status: GOOD (  26.39  )
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

On Mon, Apr 05, 2021 at 11:37:02PM +0900, Keith Busch wrote:
> On Fri, Apr 02, 2021 at 10:27:11AM -0700, Sagi Grimberg wrote:
> > 
> > > > Thanks for the reply.
> > > > 
> > > > This was observed on the recent 5.12-rc4, so it has all the latest tcp
> > > > fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
> > > > difference. It is currently reproducible, though it can take over an
> > > > hour right now.
> > > 
> > > After reverting 0dc9edaf80ea, we are observing a kernel panic (below).
> > 
> > Ah, that's probably because WRITE_ZEROS are not set with RQF_SPECIAL..
> > This patch is actually needed.
> > 
> > 
> > > We'll try adding it back, plust adding your debug patch.
> > 
> > Yes, that would give us more info about what is the state the
> > request is in when getting these errors
> 
> We have recreated with your debug patch:
> 
>   nvme nvme4: queue 6 no space in request 0x1 no space cmd_state 3
> 
> State 3 corresponds to the "NVME_TCP_CMD_DATA_DONE".
> 
> The summary from the test that I received:
> 
>   We have an Ethernet trace for this failure. I filtered the trace for the
>   connection that maps to "queue 6 of nvme4" and tracked the state of the IO
>   command with Command ID 0x1 ("Tag 0x1"). The sequence for this command per
>   the Ethernet trace is:
> 
>    1. The target receives this Command in an Ethernet frame that has  9 Command
>       capsules and a partial H2CDATA PDU. The Command with ID 0x1 is a Read
>       operation for 16K IO size
>    2. The target sends 11 frames of C2HDATA PDU's each with 1416 bytes and one
>       C2HDATA PDU with 832 bytes to complete the 16K transfer. LAS flag is set
>       in the last PDU.
>    3. The target sends a Response for this Command.
>    4. About 1.3 ms later, the Host logs this msg and closes the connection.
> 
> Please let us know if you need any additional information.

I'm not sure if this is just a different symptom of the same problem,
but with the debug patch, we're occasionally hitting messages like:

  nvme nvme5: req 8 r2t len 16384 exceeded data len 16384 (8192 sent) cmd_state 2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
