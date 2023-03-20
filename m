Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0827EC7618A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5wFxlEvYg3XuK9Hfobj35J656qg9kxC6L0CkESFltog=; b=UBmTqp6tgeYHk4RTPerjwfAxxu
	xMtFrNUqfHd6rPngjFXXw7vW8/hlQ3/j68I7N7HuMLodQyg7R1o+OV9R3IQ2TpA4tTjeEBAOc+FGx
	l0Awg/WAIDBTWuTLgc4tEBvqDJxrzijcSdkGea8IsFn7Uvkd8lgB2Uw4ubPheB84KRBYJpfe9Ujs5
	rksa2L7HrZuNuO1TiGmMqsm42OcteCxo4DYJuPFIVp2wx/tl+MLpX2ISnFlC54TObSMZ1SOXJSJ4m
	Wi3ixbRkAskagBtfY5Nw1ALZVYXsV6wRyYXOheaxtUA41RE8jzaJaMoHCjwEoZt4L4XIQadM8DRdL
	rLZeyS4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peH5f-009SpH-1r;
	Mon, 20 Mar 2023 15:06:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peH5c-009SoS-1o
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 15:06:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AE9EC61582;
	Mon, 20 Mar 2023 15:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAB6C4339C;
	Mon, 20 Mar 2023 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679324783;
	bh=zfiZOAPp5FrfqQPtr7uSanqGFntqU22xr7Kssg7eP9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uY2AKHdqma7uGiSCP1xaJVq/74NF+E4/g6N43TOXO1oOIZqTUM6uFu4sieJz/+i2d
	 bnyMYEvXHol/HN9TBscHdxg+QiwCIf4zSIwd1YpzInaaFX6rVgN8JlzLPECeU4p/j3
	 Hj3EtKIVHhlzQ8sF/Gu7n1PMQHh2QEB1hqj/8kuTmdrtd4f6giodUA0Mdk1ChhMiIb
	 KvhHpbcvSR44ZlgnwawGbQuRXzlsj9BBCAtbbkN4hpfqf37BHsMf6rwpakpbelFs3I
	 CCTVCVkf8vswGBwhYqRtDbBr8QUkDydd6BdYy/M723QkHc4Lq8f8VJbl/hRc5x7pA5
	 A6eE1ifYPGEpQ==
Date: Mon, 20 Mar 2023 09:06:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp poll queue crash
Message-ID: <ZBh2bCPAnShTMxoF@kbusch-mbp>
References: <20230320141912.avtauwpy5t4x2rvz@carbon.lan>
 <b8db776f-abf2-7c50-2b73-02fb30fed008@grimberg.me>
 <20230320145113.md6dcyv22yqhppmz@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320145113.md6dcyv22yqhppmz@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_080624_661245_9B37FAE0 
X-CRM114-Status: GOOD (  10.93  )
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

On Mon, Mar 20, 2023 at 03:51:13PM +0100, Daniel Wagner wrote:
> On Mon, Mar 20, 2023 at 04:36:58PM +0200, Sagi Grimberg wrote:
> > This was reported and is discussed in thread:
> > nvme-tcp: kernel NULL pointer dereference, address: 0000000000000034
> 
> Thanks, I couldn't remember this discussion.

It just happened late last week, so no worries.

I believe we can get rid of bio and bdev dependency, and I am working on
detangling how to get the cookie through without these.

