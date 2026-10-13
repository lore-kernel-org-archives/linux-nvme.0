Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48776CC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UgznpuaGHIjf/1wAtS+z9UAIAApoFcgHOqVgQ1r4wfs=; b=4uI//gySokwLmJ1StbaWrwuADE
	6HV57+KdthD7gBuLjcN8tyyhbA57WH6imb6IYKcjJ5075zxy4aG7kkgKK6qx4GspajwCyD6ta54qk
	U5JPPjjvE5BQIG4IJu2LBeaz2s4ockmaLHdl0cV73jBa3D12+qptuC6/KAPA8DVYb4qStZL6pb2pI
	YnMIv345hRD4U2LbIe74UzTFmwsH2yG+JZg7XK3wlOeGMnwNFPgnNefT7r3RLpKndBf6N2WgrUihT
	XZX7yO44ne6ZRXUmV1n9CZUrj+bSBFWxOVd+dj8V8/SPS2At7spGWUeSANlqYw/61Qe/9JGDoJJUm
	02KkmKlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGebt-0000000DNjc-3cUw;
	Tue, 13 Oct 2026 15:40:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGebs-0000000DNjE-3H26
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:40:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7A2E743E9A;
	Tue, 13 Oct 2026 15:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB471F0089E;
	Tue, 13 Oct 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906012;
	bh=UgznpuaGHIjf/1wAtS+z9UAIAApoFcgHOqVgQ1r4wfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SABT8bwuM0GGX/xLV1aYqca17/tmwLq/mJJlAKIfVhLQLSxnNK1gEtBNLd83MXtpJ
	 2/9VYQIQUdguIygxVTJvlsW34DacLsndpQM2MHI6WJSyyfFC+gEIsie7VMbjAclBcn
	 JR4wX9tovHRzEijrrVm/SX3gOdfsb8uYRQFb46w9AN2eK4WgJX4MrgUZ5LCcJ+Ynm6
	 BXmtHb7FsWeCZ1qWwHGp3xclr2328NuiRJQtJDa9nXbk25B4kzl1Iw6NnGXqe1fnxj
	 djFXz3HRHyPDrrHYnxIb0YiTTiqED6/X+nLen3wm10EDQkkJrXwptkIGHGy21ChToc
	 VG1OTsqNnjWGw==
Date: Tue, 13 Oct 2026 09:40:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: fail when the controller does not
 authenticate itself
Message-ID: <as5Q2k-aQokHA-ar@kbusch-mbp>
References: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
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

On Tue, Oct 06, 2026 at 10:48:05PM +0900, Yehyeong Lee wrote:
> nvme_auth_process_dhchap_success1() returns success as soon as the
> controller clears the rvalid flag in its DH-HMAC-CHAP success1 message,
> without looking at whether the host had asked the controller to
> authenticate.  A host configured with a controller secret sends a
> challenge in its reply, computes the expected controller response, and
> sets chap->bi_directional; if the controller then answers with
> rvalid = 0 the response is never compared, the host still sends
> success2, and the queue is marked as authenticated.
> 
> A malicious or man-in-the-middle controller therefore only has to clear
> one flag to turn the configured bidirectional authentication into a
> one-way one, without holding any secret of its own.  The target side
> already treats the mirror image of this as fatal: when the host supplied
> a challenge but no controller key is configured, nvmet_auth_success1()
> fails the authentication rather than answering with rvalid = 0.
> 
> Refuse the connection if the controller returns no response although
> bidirectional authentication was requested.  chap->bi_directional is the
> right condition rather than ctrl->ctrl_key, because secure concatenation
> sends a challenge only to derive the PSK and deliberately clears
> bi_directional; a one-way setup without a controller secret keeps
> returning success as before.

Thanks, applied to nvme-7.4.

