Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B54CC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 00:30:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88810613A9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 00:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88810613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DMNFYSIeXBsdy8apNbbodjx46M4iYv2muAjZ2Ac7yKY=; b=f8RWeaI9zd5gLVis4LeTvQuSN
	G38VwgxKPANVHBxcUdSgL3mtR4I3w4UxwaQLq9wBdxJGPOgq6/YNRbCib7wN1MM8tcvgmEaHQvd4X
	RxQZ9irj6yn1l1nh6KPiHwcOQDA0wy1SFEYpEKEHQlWe15kBCuJvGUhmhQJSj0Zu3KnvaXRE6GCX5
	t0hGuo6q/RvQF7Fb/JfUoDtvyhHBiaCABkoG0q7DaPmBhn7rzTHeYUNJPXWxGZIeO0EVYMvMdQD8E
	SUrdxJmXCltiXsB9zlheEkIsbhEfyh2ReAL/DDyu16zGA5MVgQfjNMMKfakXZr+64qumlq+lxU2Ry
	CHhqm6czw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWTQ8-00Awci-C1; Wed, 14 Apr 2021 00:30:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWTPk-00Awbz-Ge
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 00:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=h402GBMBXQG73F3u6WXk5YwV7hQCIrZEXQo8Bpp2Jjc=; b=OxJuO3iyk/kVk4jhNi5J+ks+4V
 aZWKGCDhFtiRYF/5KdeM6aFfqi/GFPix1u749f51HXDKKI1rApTEvVbGIivBW93JnhOcrOb524Qvn
 SBvDPhNk+ptcwxYsx3fHtjCIpzWazYStbXWMSzUhW+u/L5XbhGSK7XAOyaIoFJZXyV1jCsi0LIDfC
 27T33/LcFYvcvknu3fMuNCee7fT7jXkEULeieXelwzZbSXCtpasEca4prReUDZSpVLRbHTm+fGBKF
 WN+HVKeF5Mm8yVSqe5D907yHU8P/+bpFwhlr2srmxhpuda54x/51VXZ2owVAeA4Vh+KAWTy2m/RTW
 DWMRbdrg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWTPh-007PAz-Sh
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 00:29:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CD88613A9;
 Wed, 14 Apr 2021 00:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618360189;
 bh=tHAVrqRVMnLi4Eem78829fmEEsUkiE+pu23vP0QahAM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MZHLOoTf4BN0atzRjwegp1OnRotvHHauH3rrpchEx1LxO/G1FULlvu+xz0rGny+wF
 JfMI6x8fISga35CdCC3C8roZmyq6962bswB7HXfZTgbd2x9vHiVkVQxIyVK63JEBH7
 79G+29jNuPN02LLJBq4x2b9RuxNvchtsl01sp5gVmaYcelUvUvR/7KEiK8EETpbtjA
 WNybzFCPecQbqCtXXYxz6Lzg30zgFv8DOQm40LhIbEUbkfLKvBM9ZFKsQQHsOCej7P
 LeoHU0DsA7csqgAS1Z6gDtVTZG42Se2bS1TDug9loKWKPbFlPjcLJnvY7F89uQrKMe
 26oJyzNCHyvUg==
Date: Tue, 13 Apr 2021 17:29:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_172949_978373_2BE80C92 
X-CRM114-Status: GOOD (  26.17  )
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

On Fri, Apr 09, 2021 at 11:04:43AM -0700, Sagi Grimberg wrote:
> 
> > > > > Thanks for the reply.
> > > > > 
> > > > > This was observed on the recent 5.12-rc4, so it has all the latest tcp
> > > > > fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
> > > > > difference. It is currently reproducible, though it can take over an
> > > > > hour right now.
> > > > 
> > > > After reverting 0dc9edaf80ea, we are observing a kernel panic (below).
> > > 
> > > Ah, that's probably because WRITE_ZEROS are not set with RQF_SPECIAL..
> > > This patch is actually needed.
> > > 
> > > 
> > > > We'll try adding it back, plust adding your debug patch.
> > > 
> > > Yes, that would give us more info about what is the state the
> > > request is in when getting these errors
> > 
> > We have recreated with your debug patch:
> > 
> >    nvme nvme4: queue 6 no space in request 0x1 no space cmd_state 3
> > 
> > State 3 corresponds to the "NVME_TCP_CMD_DATA_DONE".
> > 
> > The summary from the test that I received:
> > 
> >    We have an Ethernet trace for this failure. I filtered the trace for the
> >    connection that maps to "queue 6 of nvme4" and tracked the state of the IO
> >    command with Command ID 0x1 ("Tag 0x1"). The sequence for this command per
> >    the Ethernet trace is:
> > 
> >     1. The target receives this Command in an Ethernet frame that has  9 Command
> >        capsules and a partial H2CDATA PDU. The Command with ID 0x1 is a Read
> >        operation for 16K IO size
> >     2. The target sends 11 frames of C2HDATA PDU's each with 1416 bytes and one
> >        C2HDATA PDU with 832 bytes to complete the 16K transfer. LAS flag is set
> >        in the last PDU.
> 
> Are the c2hdata pdus have data_length of 1416? and the last has data_length
> = 832?
> 
> 1416 * 11 + 832 = 16408 > 16384

Sorry, this was a mistake in the reporting. The last one's data length
was only 808; 832 was the packet length.

> Can you share for each of the c2hdata PDUs what is:
> - hlen

24 for all of them

> - plen

11 transfers at 1440, 832 for the last one

> - data_length

11 transfers at 1416, 808 for the last one

> - data_offset

0, 1416, 2832, 4248, 5564, 7080, 8496, 9912, 11328, 12744, 14160, 15567

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
