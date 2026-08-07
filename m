Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86096C5AD2B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2026 23:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a1VCoVGitUDKbUIrUKYflD+xbqueMVkN7giTuNUkzBI=; b=QMWWxaJ4DWrI62eNf3YO0sL+z6
	jb0itSykHPZjaPtxvGo+5xWYDAvr/k7lfwYwTFJR2MdNlDoLUV6kWIjXSApav0D3DEMambpS8N5HX
	wqkyUK3e8UCFFuWKF8zKaoTrpGzFhVinvWtLvOLMbfjmoivuKU10uocC3lb33hEHFOcYrgTpjewK0
	xp0jHCczsFx578ZQxhggtC1qnLFq3QcV02POY4/c2UqfnJkfTjI88emIq/QBCzJ4n9oSiLSbY+GRF
	0HdHFGRhIXvPhUljga5VLwL6au/1jdM1yTUzNADX/25HjoxhW8ADq/og9NrDnquqn0XsRMmwjXKgE
	0e504SBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsTga-00000008r8v-2rTa;
	Fri, 07 Aug 2026 23:09:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsTgY-00000008r8e-2J6s
	for linux-nvme@lists.infradead.org;
	Fri, 07 Aug 2026 23:09:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 077286001A;
	Fri,  7 Aug 2026 23:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5098B1F000E9;
	Fri,  7 Aug 2026 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786144145;
	bh=a1VCoVGitUDKbUIrUKYflD+xbqueMVkN7giTuNUkzBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gjnJpbBhXIUxCc4ccVrr9YkzMjrrmnkYgtdimIuMcbkeF6kwyg6G5b5UBWhfgmq3A
	 EL1M5pvzed9WlZBrOS37sEcdLZcxnn5BqOU9Cn08MLVotA90SUufkZSoZUn8ABThDi
	 1mozyPAMUVDKopmFLZddaU9kl87xAPujDPdSXK1ztbKSkTGrXtNU4dj0YncUIKeniv
	 6Z3t900yUU6wCQ8ct0URM2U07KaOQ9dUOSK4YIpl698jtDktvbYE9EfH0xqGG63rao
	 aVtwvc+dSqMHNmym5d0Qn0FQxvN6mPDrJuSRDNBnHL7J6moN1iDDvl+g/eODsYG5e8
	 ntuX6ttZ0rkew==
Date: Fri, 7 Aug 2026 16:09:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, kbusch@kernel.org,
 hch@lst.de, hare@suse.de, sagi@grimberg.me, chaitanyak@nvidia.com,
 gjoyce@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/4] nvme-tcp: limit I/O queue count based on
 NIC queue count
Message-ID: <20260807160904.2eb1b3d1@kernel.org>
In-Reply-To: <4d8c8d92-d39b-4721-a405-f03f01fbb95b@linux.ibm.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
	<20260731073918.614014-3-nilay@linux.ibm.com>
	<amzPvMWfzetiirw0@devvm7509.cco0.facebook.com>
	<4d8c8d92-d39b-4721-a405-f03f01fbb95b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 1 Aug 2026 19:08:05 +0530 Nilay Shroff wrote:
> > Looks like the userspace can already pass the preferred number of queues,
> > so in this case, why not do all this netdev resolution and queue
> > estimation in the userspace? Presumably most or the users you care
> > about always go through nvme-cli, right?  
> 
> Yes, userspace can already specify the preferred number of I/O queues, and nvme-cli
> provides an option to do so when creating an NVMe/TCP connection. However, choosing
> an appropriate value requires userspace to know both the number of online CPUs and
> the number of active TX/RX queues on the NIC used for the connection. Determining
> the latter also requires identifying the correct netdevice. That may involve a route
> lookup to determine the egress interface, particularly when the NVMe/TCP host and
> target are not on the same subnet.
> 
> So while this could be implemented in nvme-cli, it would require userspace to duplicate
> the logic needed to determine the actual netdevice and its current queue configuration.
> The intent of this change is to make the default queue selection automatic and avoid
> requiring users to determine and specify this topology manually.

In another message you said you add ntuple filters. So you _are_ doing
what you describe here as a problem. User space will know something we
don't know sooner or later, so you should just add the uAPI instead of
guessing in the kernel. BTW the queue count is likely to change after
all of user space boots, so if you run before whatever configures
queues for the machine in userspace you'll be using wrong counts.

> An explicitly specified "nr_io_queues" would still take precedence, so userspace can
> override the default when desired.
> 
> Just for the note, this change also follows the general approach used by nvme-pci, where
> the default number of I/O queues is constrained by both the number of possible CPUs and the
> queue resources available from the controller.

Not sure that maps well to networking. For TCP at least there will be 
a protocol stack that runs between the device queues and your queues. 
I guess that will depend on the network and the details of the
benchmark. But again, better to let the user tune to their workload
and machine.

Consider patch 1 nacked.

