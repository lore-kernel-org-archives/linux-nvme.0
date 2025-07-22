Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE321C83F25
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 02:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjxjj3aaU5OCPr/MDpLwNWANQqNl6x97ye9wax9rmP0=; b=1hNrn1nfzfyICEmKARbyAK4zQt
	WHU26f2675D7EtvNiWchhSyba7vApXlRo26F9rfCInJvUk9jV+tQ2YQwXFZ6izcLI+ATM7XZsSiH6
	HiTysd1zE7Kjb1crF3d7+ZlToKM1E+3LZJxA0VSzOxGE0+55ND7El46r1veiwC0albausuiDk/J0+
	illZAK7ZyCMO2V/KIGKqfAN2VjW+rbX0cabPZ472+bglqd/duQljhz9x8ZXVG4zNZyaOHY/8Xc0gF
	4J0u/9lvWUy6AIIzuw52z9XWxuQSlWgo0WlI/sF5u0Pn62gfmtA2ZUlpZ7QXdXUR8kUf6LQnoT5U0
	yStyZETQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue3CF-000000017Wj-2QdN;
	Tue, 22 Jul 2025 02:57:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue3C7-000000017W5-25cX
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 02:57:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 74AED5C576A;
	Tue, 22 Jul 2025 02:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ACAC4CEED;
	Tue, 22 Jul 2025 02:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753153050;
	bh=obx46y8kX606Lhxat/qkPD+aU0Igt2JtC0PlKp3SXqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4vpAhgcRQd44hbO5IXbGXyMfwwJbjnsEixMidJQONtxMlRFuas/fvnahR5bbZyrs
	 MC53Q0TZvqNXRFN/sGVr9Sko2rQ+TdEzwOKzRQZZR9wz8XE6A8+vcj3wuscTSDX0em
	 Pd1+xIs7e1Uy0CuotntCTKDMKeP5fwboKwtA/ScYE6HXULlJn/9uhXni93vpN36uIc
	 6tCadwvdt75THGaSqu5CQImW9YRQurT3TmMQCwq4pqfQqz/vrN/BOd7VMAH8OIiY90
	 syrc6YEn2edhkMqZUJXOn3/DM9MF9NMpYIGgXK4rxHgGM/miSYTDbxjqqRGkIjiUOe
	 lXUr9u4AvPRLA==
Date: Mon, 21 Jul 2025 20:57:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@kernel.dk, james.smart@broadcom.com,
	dick.kennedy@broadcom.com, njavali@marvell.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v8 7/8] nvme: sysfs: emit the marginal path state in
 show_state()
Message-ID: <aH7-F2WxrhoCiK7O@kbusch-mbp>
References: <20250709211919.49100-1-bgurney@redhat.com>
 <20250709211919.49100-8-bgurney@redhat.com>
 <aG7pSA6TOAANYrru@kbusch-mbp>
 <35738598-0733-408c-8597-20c3599a8973@redhat.com>
 <aHa0JpsASqGuHdOA@kbusch-mbp>
 <ccb69ee6-bd5e-4585-9ccc-0c49cb30f1a9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb69ee6-bd5e-4585-9ccc-0c49cb30f1a9@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_195731_686600_C15D064B 
X-CRM114-Status: GOOD (  26.34  )
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

On Wed, Jul 16, 2025 at 08:07:51AM +0200, Hannes Reinecke wrote:
> On 7/15/25 22:03, Keith Busch wrote:
> > 
> > What you're describing is a "path" state, not a controller state which
> > is why I'm suggesting the "ana_state" attribute since nothing else
> > represents the path fitness. If nvme can't describe this condition, then
> > maybe it should?
> > 
> We probably could, but that feels a bit cumbersome.
> Thing is, the FPIN LI (link integrity) message is just one a set of
> possible messages (congestion is another, but even more are defined).
> When adding a separate ANA state for that question would be raised
> how the other state would fit into that.
> From a conceptual side FPIN LI really is equivalent to a flaky
> path, which can happen at any time without any specific information
> anyway.
> Again making it questionable whether it should be specified in terms
> of ANA states.

I see. Re-reading ANA, it is more aligned to describing a controller as
active/passive or primary/secondary to the backing storage access rather
than the state of the host nexus, so I agree it's not well suited
for an ANA state. :(
 
> > Where does this 'FPIN LI' message originate from? The end point or
> > something inbetween? If it's the endpoint (or if both sides get the same
> > message?), then an ANA state to non-optimal should be possible, no? And
> > we already have the infrastructure to react to changing ANA states, so
> > you can transition to optimal if something gets repaired.
> 
> It's typically generated by the fabric/switch once it detects a link
> integrity problem on one of the links on a given path.
> 
> As mentioned above, it really is a attempt to codify the 'flaky path'
> scenario, where occasionaly errors are generated but I/O remains
> possible. So it really is an overlay over the ANA states, as _any_
> path might be affected.
> This discussion only centered around 'optimal' paths as our path
> selectors really only care about optimized paths; non-optimized
> paths are not considered here.
> Which might skew the view of this patchset somewhat.

Okay, but can we call it "degraded" instead of "marginal"? The latter
implies the poor quality is endemic to that path rather than a temporary
condition.

