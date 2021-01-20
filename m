Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DDC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 17:48:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0D7223E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 17:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0D7223E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N/Syf6MP3Igq+ZYmvDPOhfKdQYuBl6D0HRedZNBRH3k=; b=3dtqWP5VdCUuj11xkqdfFcUKY
	y7VyD2PdpG7OzT5h8TLEqupWXh/ikUQl8R7BqloeaXO1XyS7Q8Hai2vTFBqSggBwQSocU4/cotukD
	CXLJlaHx+OGn/VU6RNsCb/w0RU/6JU4j+OoQsjYQmHVnrOyxgTqqCWJs0XBRk76QukEEb2ik68vqQ
	Pp03F6b71f3iFsmO+nu9wgpuYZpk+K1LFzhgykMKSJtIiSJEpvMVo+a6TQpPa228QfO4kobIdmbI5
	E6LYq84a8a97XAQDSkWj8B2YUnch0N+zuclX/3LzmuJ90nPajS2BwXP17TXllH5aJsgIK8kxhT2FS
	Luc6qbNXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Has-0008HS-2X; Wed, 20 Jan 2021 17:48:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2HVY-0005Hs-6X
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 17:43:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9AC7207C4;
 Wed, 20 Jan 2021 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611164579;
 bh=kQvj2zqVpbW9eJPSJSq2rvNGZsDViVThkcvlHYvvx0Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kJRe0bKImTZEeZbLCTTj7WjLVMBHnFsgiLPRgXN5X8IsiCgg2sY/JYF7RacTWECIq
 KTViPl437a5xbF5nZQUhjh2cMcHpiX7AF2w29WvvB95eThkRFmcGcDJhcwyzSU+DRZ
 1wtsaqFpfDV91n4y+h3c5gvvcAk5ITd0WTETgmZzvB/6qfgMvkjeq2VRw+1gQNfSF9
 N0/8ybCz7xneCpGkyyiJc4Umr78axL/t9WRGaPD08o2z6xSBLRKQjchd5PtGRRFS2+
 ZyE00BJpBrahWTD1DOGJrcHjVFwuj6Z5eU6FJz+rgrr2Lvj2E5BEbPSAE3QVAgF7dt
 qTAFe/tZlzOiA==
Date: Thu, 21 Jan 2021 02:42:52 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] nvme-pci: fix error unwind in nvme_map_data
Message-ID: <20210120174252.GA27657@redsun51.ssa.fujisawa.hgst.com>
References: <20210120094915.3198346-1-hch@lst.de>
 <20210120094915.3198346-3-hch@lst.de>
 <CAA03e5Hb49rpNq2A8hmvo6tVrLnon0yAUiZvWvd8THCXyDQ-kg@mail.gmail.com>
 <20210120164824.GA21874@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210120164824.GA21874@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_124304_613114_562C7CCD 
X-CRM114-Status: GOOD (  14.68  )
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
Cc: Marc Orr <marcorr@google.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 20, 2021 at 05:48:24PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 20, 2021 at 07:23:39AM -0800, Marc Orr wrote:
> > On Wed, Jan 20, 2021 at 1:49 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Properly unwind step by step using refactored helpers from nvme_unmap_data
> > > to avoid a potential double dma_unmap on a mapping failure.
> > >
> > > Reported-by: Marc Orr <marcorr@google.com>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > Should these patches go to stable?
> 
> Yes.  I've added the proper fixes tag:
> 
> Fixes: 7fe07d14f71f ("nvme-pci: merge nvme_free_iod into nvme_unmap_data")

Patches look good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

Just fyi, the 2/2 is the only one with the "Fixes" tag, but it depends
on 1/2 to compile. It applies cleanly to the recent stables, though, so
stable bot might have some trouble with it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
