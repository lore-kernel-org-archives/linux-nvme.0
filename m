Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F71AC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 03:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=68URICBHNg4KZvf2IdJFowcuR7GWwwSD7fugZeLcYPQ=; b=TNMZPc/NDZ0mmmQBEPqCii1fLO
	yGq6PNhZ1xcFpZ4JcuUam71FWPw487xwv7E/GHgZP2Pmk45uJEdpSnSLcuvoFTfmUhx1BuRDBnVHy
	h6B6G3wW8VpoQZ3XuG3oZJSxSQIu+ybvSjipphKosWexLPvMhRCa/pGCzNtK8jOwKkNMjURSruSIr
	a8pytI/HHu7gHGnpxtX1oexVrruZcbZ+aJbeQvR7n/e8XmUUqPtXQ3XokvLIhLvH2YGD1V8irY91W
	fUlvWUEzgCmbzBn42rM93xKGYNWdrgqLeZbCVPnIdS+OReHdUtv1m5RmpHH/3j/6/ILKuxvRFacoM
	WE9Vq8uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6OkO-009L1G-L6; Wed, 29 Jun 2022 03:52:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6OkL-009L0V-Ev
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 03:52:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6B15B61DD6;
	Wed, 29 Jun 2022 03:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC645C34114;
	Wed, 29 Jun 2022 03:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656474727;
	bh=g4zzHulG7GEAulCIuTQXR87g3faKAviePs7vVysrZVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CU/JyhXgpmfz4YLj08Kz1NhuQAAHT1lu62q+NTk66UWeOLW1EmysLLkGr+PTLWM8T
	 tNvO+mKZsiPMrRo3ZcC3PCAKkmfJQwsAUINx4frjPs1pz9P42zbm3IHzKF+p88kPhP
	 Lp095hZbD9frg2rlaIGrJmHHiU4/MpO2S/Kzx7gBhyl8tQVovjqE9iL7cSJ7uORQLV
	 w4Ttw3mzCDfXzoYWXf+W49fTAk6rwRDqlnWHNEVFmLlOJTnXUvDdjnb4K2mAgEl2vS
	 58riKEzOHtZOHhWEeegTuuYjztX9JgK1KIrmnx+h9OTxApVzbTLJQ6gwCdwtM7ykKh
	 eE4ridlaUcK2w==
Date: Tue, 28 Jun 2022 21:52:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Keith Busch <kbusch@fb.com>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YrvMY7oPnhIka4IF@kbusch-mbp.dhcp.thefacebook.com>
References: <ab1bc062b4a1d0ad7f974b6068dc3a6dbf624820.camel@linux.ibm.com>
 <YrS2HLsYOe7vnbPG@kbusch-mbp>
 <YrS6/chZXbHsrAS8@kbusch-mbp>
 <e2b08a5c452d4b8322566cba4ed33b58080f03fa.camel@linux.ibm.com>
 <e0038866ac54176beeac944c9116f7a9bdec7019.camel@linux.ibm.com>
 <c5affe3096fd7b7996cb5fbcb0c41bbf3dde028e.camel@linux.ibm.com>
 <YrnOmOUPukGe8xCq@kbusch-mbp.dhcp.thefacebook.com>
 <20220628110024.01fcf84f.pasic@linux.ibm.com>
 <83e65083890a7ac9c581c5aee0361d1b49e6abd9.camel@linux.ibm.com>
 <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a765fff67679155b749aafa90439b46ab1269a64.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_205209_600008_374E6E23 
X-CRM114-Status: GOOD (  13.54  )
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

On Tue, Jun 28, 2022 at 11:18:34PM -0400, Eric Farman wrote:
> Sort of. In the working case, I see a set of iovecs come through with
> different counts:
> 
> base	count
> 0000	0001
> 0000	0200
> 0000	0400
> 0000	0800
> 0000	1000
> 0001	1000
> 0200	1000 << Change occurs here
> 0400	1000
> 0800	1000
> 1000	1000
> 
> EINVAL was being returned for any of these iovecs except the page-
> aligned ones. Once the x200 request returns 0, the remainder of the
> above list was skipped and the requests continue elsewhere on the file.
> 
> Still not sure how our request is getting us into this process. We're
> simply asking to read a single block, but that's somewhere within an
> image file.

I thought this was sounding like some kind of corruption. I tested ext4 on
various qemu devices with 4k logical block sizes, and it all looks okay there.

What block driver are you observing this with?

