Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE4BC5DF81
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 00:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sF6qC2tATd5bpUhpJzb3ip99Px/YMCDFCjqpY5PEkp0=; b=lY1JAZlvldRS1+k1f7+nbhjboz
	WO4ISSdfm+FO27D3jjwbB/0y95sdnGRAAy5uWno7CUz6KnoCP8uzjYFSQxdeWyF6wA0A9s/hb3meO
	XCjrXhbpliiOoaCeO21SV5Kg2KS5iXRTAeiQ87ULuyzMn8AYk5QKDkg8y+xtNVyZMmAoE/V9n8tMt
	E/gQUrn398PvyytuWcIITIeWfuPkbtsXFj69GGIVohpY+Y6MgRgvGpHqW7J7cJ65S/Q2xfXZ9ebAx
	sbeJA6n9nE0Lvnf9lTVCeqti+gje+jcX11X4g91UNxnt24n5BK0veyaQRa57w6IDu3ukzOSG+Xyh2
	d2bM5PVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfVW-0000000Hacq-3myz;
	Tue, 25 Aug 2026 00:59:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfVV-0000000Hace-0BAr
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 00:59:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 58E52411FC;
	Tue, 25 Aug 2026 00:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58831F000E9;
	Tue, 25 Aug 2026 00:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619556;
	bh=sF6qC2tATd5bpUhpJzb3ip99Px/YMCDFCjqpY5PEkp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iXzMSRdQZPivtTQznxDUbQarJOpfFFEuD9jRfEaOlO+7dy69hOUSIcyU7yzY2MhWU
	 k7G5SxB2eVFSepG8UnXkOcPXypF+gmRot0Zx/dkYNHphH7wYn+xC0iRy5tNpeRO6it
	 +rjHv/1ApvN0BDCB/Usy55dvxD+bLVkpLxFLO4BeZOIh9bKZJIQDmmaqo8y5VyruAf
	 yz189/6VY4FJpaOgSOmr/Eyysp4H5rzZGMiXdwTNjnHn75XhJcAuaG7RT9SBR2Ziyo
	 tPttE4wB074B6uyjz498IJFHzQT8zHzNBSfw4e86VG9vR6EVq8cJ7V1nxwsWEpFm65
	 4YjBBstwgsBPA==
Date: Mon, 24 Aug 2026 18:59:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Greg KH <greg@kroah.com>, security@kernel.org, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: fix out-of-bounds write when receiving an
 over-long PDU
Message-ID: <aozo4lBg1fhoojdP@kbusch-mbp>
References: <2026081459-handoff-wildly-eeb5@gregkh>
 <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814194811.1581041-1-kumar.shivam43666@gmail.com>
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

On Fri, Aug 14, 2026 at 03:48:11PM -0400, Shivam Kumar wrote:
> nvmet_tcp_try_recv_pdu() reads a PDU header into the fixed 128-byte
> queue->pdu union, then computes the remaining payload length as
> 
> 	queue->left = hdr->hlen - queue->offset + hdgst;
> 
> and reads that many more bytes into &queue->pdu + queue->offset, without
> ever bounding the result against sizeof(queue->pdu).
> 
> A struct nvme_tcp_icreq_pdu is itself 128 bytes, exactly the size of the
> union. Once a header digest has been negotiated (hdgst = 4), a second
> ICReq passes the hlen == nvmet_tcp_pdu_size() check but yields
> queue->left = 128 - 8 + 4 = 124, so bytes 8..132 are written into the
> 128-byte buffer -- 4 bytes past its end, over queue->hdr_digest and
> queue->data_digest. Those bytes are attacker-controlled (an ICReq
> carries no digest), and the duplicate ICReq is only rejected later,
> after the overflow. A remote unauthenticated host can thus corrupt
> kernel memory adjacent to the receive buffer.
> 
> Reject any PDU whose declared length would read past the end of
> queue->pdu before the second recv.

Thanks, applied to nvme-7.3.

