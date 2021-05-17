Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B6AC433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 19:46:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3612A61040
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 19:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3612A61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rGaC0TtgiBB3Ov7qWQljAm6WnD5PA2a4Xzk6+b96528=; b=VorbwBnHdPAXW8hk/b1bBfGgl
	iJTBve2iQBQeSLFdQHJY/0TeDSNXgLsOo/fmnQoGmyFO2SnXJdMDVHMBCarE/eBtpYFcccmi/7FQo
	nrqFG+p56GTK5Yx8CeUtIzzJEQavCfvORMXV6Lhd478fjbaIbBGkBj7kSUEgXTBQrlZ3Xt8MVRL+r
	SRu5QRI4kwfCwLDCkP/4rcN3fOLCZy+JTRKbGT/BCCKpIrxbkmnzrt0XFInQGtMGCyNEnQv1mFut5
	CTfiebv067k8U7PHSH4j7t2bT8JRTdclF1jaFVnROkAr+vBSI5GFczaZrvJC/s1D4lbgStUZPTY04
	Be1xaeyHg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lijC2-00FyW7-2Q; Mon, 17 May 2021 19:46:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lijBz-00FyVf-7Z
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 19:46:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GZkaHzyOlc8ygG7gcuK81nkNGgW5j8hXGLdV8eHH/sA=; b=y/nk+sOtvu6vKla2NDzF7KhJJi
 f+7fibA1IAy2XeUiLHv/InJapC8PwvubHvo2XGihHo0Lq7pVpBN5fmCY7mPxHp2pnFVfX3M+dvJ3r
 5jeat80nC8ZMO0uRAs2F2FAnlAoegiFS42p2ABaa8r3lI+Pm4XzmMLyn4Kk/9LoBv2FFAG6W6632G
 PCqBguXjkCbQIuSngHB8maY2AzS793gLn8dm6tAyn3JPWOpOd3BpxTB8icHFtoYUK7QqeC04XAIQe
 WmdAhkexXqwT0oy/5MGK388+229fu4rSlvM0F9WyPzZcQ6E1l3IgIIqVdi/N99F0wdyra7snVLl0w
 pFUt0deQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lijBv-00E6Hv-Sh
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 19:46:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 358EA6134F;
 Mon, 17 May 2021 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621280775;
 bh=QwX7bY6MKD/yKQ+EV4Ta4fIpLcEgwaLW9IvjjRd+A8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c48OsCl1dh32G0rfkrb4mo+jNizZuVmV+5Fypb2YlPupoMJ0rKV3L2m1vixj4eYTk
 559MTUAbEo5S3iP8pKWKOitTPjUP5Q1gRWqW0eKma0ceWrL66vkiih0aN2Dg7N+yJW
 8BCTK4cjAbHqrFzBf0Su84N+9dwfjS2aXusyKGLCTwmwxFSlH1xH/TOXNUCRPGA0ID
 xL84SgOGI7/JuwLMXNqAZNNP2IxXRAcdr8j1W7rPzHOFS6TPlFZCabb1AoCNOyfM6k
 9w+06hkHCdICOHNqGlE6NvTxtyZ0lZs3LaW6afP07FVKz0vzY3C25Up1FKjf3qelyj
 XoclJxPWFS8fQ==
Date: Mon, 17 May 2021 12:46:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
Message-ID: <20210517194613.GA2709569@dhcp-10-100-145-180.wdc.com>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
 <0bd3f659-9691-4f25-6d3b-bdd19546186c@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0bd3f659-9691-4f25-6d3b-bdd19546186c@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_124615_968735_DCA4FDDD 
X-CRM114-Status: GOOD (  18.76  )
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

On Mon, May 17, 2021 at 12:09:46PM -0700, Bart Van Assche wrote:
> On 5/17/21 10:59 AM, Sagi Grimberg wrote:
> > We cannot detect a (perhaps buggy) controller that is sending us
> > a completion for a request that was already completed (for example
> > sending a completion twice), this phenomenon was seen in the wild
> > a few times.
> > 
> > So to protect against this, we use the upper 4 msbits of the nvme sqe
> > command_id to use as a 4-bit generation counter and verify it matches
> > the existing request generation that is incrementing on every execution.
> > 
> > The 16-bit command_id structure now is constructed by:
> > | xxxx | xxxxxxxxxxxx |
> >   gen    request tag
> > 
> > This means that we are giving up some possible queue depth as 12 bits
> > allow for a maximum queue depth of 4095 instead of 65536, however we
> > never create such long queues anyways so no real harm done.
> 
> Is a four bit generation counter sufficient? Shouldn't such a counter be
> at least 32 bits to provide a reasonable protection against e.g.
> duplicate packets generated by retry mechanisms in networking stacks?

It has to fit in the protocol's command identifier, and that's only 16
bits. Most of the bits for the tag, so the implementation uses the most
available. More could be better, but that would require a spec change.
 
> Additionally, I do not agree with the statement "we never create such
> long queues anyways". I have already done this myself.

Why? That won't improve bandwidth, and will increase latency. We already
have timeout problems with the current default 1k qdepth on some
devices.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
