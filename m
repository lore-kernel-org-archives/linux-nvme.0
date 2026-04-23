Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0351DF9937C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDKSlXg6ujrv4T/QoeVpg+ld9Uvc5Axc3KexdwpK5wI=; b=xaCQZII+5ySaElpL1WIyZUhfGU
	dkcQzRAekISjXFnxyCFq1m3NX/S9Zbq58rTjrccXQREyalIBQJIxYS/k1VKYYrfkHKJDZLa4gxsSu
	3HNiqJ3/X1lAHAEoMNEtM06y0En7dIIBG15jH0kbVb22d39B0JD84H1znmxdys2a+KHLV1X2oqlMs
	5dpVbfgcpgYWVKc1loFr++DfjtjxxuXIt1pdFdceda+eavWDv7HfB34hg4z/wBdCKKowTI8X3DSMt
	x69i2Ys6tyYUINvPjbwjOR3zbeAhiQuLGH/7Kuw5O09KMLvDXnIxsmGu1+36PEmSA8Muf7x/ENQh1
	t+JbHYpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFsWN-0000000BYEx-3c3O;
	Thu, 23 Apr 2026 11:47:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFsWL-0000000BYE9-0dau
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 11:47:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2A1C840A34;
	Thu, 23 Apr 2026 11:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA02C2BCAF;
	Thu, 23 Apr 2026 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776944820;
	bh=lAH+tMgsReb5YVC0CmXAwj1oMmvhUfKDEdN5ypoXL7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VR1KrBY9S+BKA8k7jOQ4sG8OyVJgAf6WtmbQeHmDYORbAMCr5fh7SpjfbTE9eZZxN
	 rzHKzoxMGlqJJ6utbOn/T4Sg/BVYFXnKlhovHu8Hnk7nwTRdzPnxczM8ncMLTxEa6I
	 /wlmNFzw1+ZOcQ1W26d+BcC9P5CfcCJA+EMtq0sjeFT9AB9b0m6Iv/3V0CegpKOGx5
	 1208mxBZFaUodfH8KMVxqvI0AsIzojqJrDysFUAKn835F3B5vL8ltK63r7S484cONZ
	 uECR5DDXheZKCldg6TyodnS/qboWOInXZISKyaXrr7Qv9jezXVe3Vx6epCT3FOHNwp
	 CU3ro1rSzVU1A==
Date: Thu, 23 Apr 2026 13:46:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
Message-ID: <20260423-auseinander-steigen-b80ee53079a8@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
 <81033e57-99e5-43f1-a6c3-c363e96f9c9f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81033e57-99e5-43f1-a6c3-c363e96f9c9f@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_044701_207413_E53D6973 
X-CRM114-Status: GOOD (  14.29  )
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

On Wed, Apr 22, 2026 at 01:29:56PM -0700, Bart Van Assche wrote:
> On 1/10/26 5:24 AM, Christian Brauner wrote:
> > The annual Linux Storage, Filesystem, Memory Management, and BPF
> > (LSF/MM/BPF) Summit for 2026 will be held May 4–6, 2026 in Zagreb,
> > Croatia.
> > 
> > LSF/MM/BPF is an invitation-only technical workshop to map out
> > improvements to the Linux storage, filesystem, BPF, and memory
> > management subsystems that will make their way into the mainline
> > kernel within the coming years.
> > 
> > LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
> > subsystem-specific tracks, cross-track discussions, as well as BoF and
> > hacking sessions. Please check out:
> > 
> >            https://events.linuxfoundation.org/lsfmmbpf/
> > 
> > for further details on the venue and hotels.
> 
> Thank you Christian for being one of the organizers of the
> LSF/MM/BPF summit. Will a schedule be made available before the summit
> starts? A link to the 2024 schedule is available at
> https://lore.kernel.org/all/20240510212132.83346-1-sj@kernel.org/.

The preliminary schedule is accessible here:

https://docs.google.com/spreadsheets/d/1mGEdDrWskp7Ua91jGXzquQGinorcD58DAVXhOiRp2Gg/edit?gid=1852749899#gid=1852749899

It just hasn't been liked on the website yet.

