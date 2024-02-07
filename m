Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1AFC4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=eVJqSihgt0p7uln1wHBca59d4aGPW0I3w+8cTIVtEJI=; b=Teem0VU5WSaTRI
	i7vFR2KZXniqqT9nKQzMxq1Wf4UFKugXH4EeaT2w1jlnpkT7wjiuAc2fLxoYfZX891Y2m7z9HnM4m
	qkM9Z8a85nNPG45FVUZsLbTXp7CtonuB9uvLFat6SYok1lT9+EgLzz8GPTdxdd2ciHNk0Fk9KI/0M
	3+VNNAtG1BD2YJSWMEm0XyerFlY9M8qre3qAG0CjdVGEVfTkssrjVhxBmonwndfcauuDMGiu6tcTw
	A3+gFLRv94bUjcqQF2RDBKMcd/KrR1dT4CUneEZGsl6lTeWusrh4yBLdOTMTo5LNtyvhaO2trBVmn
	PC0/qPSL1ZfNW7lJCltQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpyQ-0000000C27p-1gsa;
	Wed, 07 Feb 2024 22:00:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpyN-0000000C26d-2WAC
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 22:00:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 217D361ADD;
	Wed,  7 Feb 2024 22:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816DBC433C7;
	Wed,  7 Feb 2024 22:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707343250;
	bh=j0bMR3ry6ouW5L/+7DYxtqo56xcwV6oH779uSyf0cvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=thPsQdD89+sbH4qKZN8eCgururAEFt45glsLocB1IaGknhysCrMTVV88K38mxI3M/
	 xanqynJzXK/PI43fPe6U6ccscF27z8+9tH8C5jxFcWJobHQlP3iY+qtj4efnQawoHJ
	 22/jh2moJwLlWXM77SRjUmkOvosnTEC4jtuvBYnHjIIfQuEKE/w9WQ1ftKjSbcJzmL
	 cGRhCNZa7wp2D/5nfRKB8bQOJV96dV8gWxQvejUVZRjgrh7uR5wi7y3n9aXdnXJQBV
	 3sMBCAhHKTmLNspfM0Lt1nbgs695HWaArLMR8Ow1a9gbeb39nm/T6riFgISUN2/R4R
	 X8mL6S+l9U+gg==
Date: Wed, 7 Feb 2024 16:00:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, djeffery@redhat.com,
	linux-nvme@lists.infradead.org
Subject: Re: Make NVME shutdown two-pass - Version 6
Message-ID: <20240207220048.GA919889@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207214044.2374295-1-jallison@ciq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_140051_702542_622A0683 
X-CRM114-Status: UNSURE (   8.94  )
X-CRM114-Notice: Please train this message.
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

On Wed, Feb 07, 2024 at 01:40:39PM -0800, Jeremy Allison wrote:
> This is version 6 of a patchset originally written by
> Tanjore Suresh <tansuresh@google.com> to make shutdown
> of nvme devices two-pass.
> 
> Changes from Version 5:
> 
> 1). Function nvme_request_shutdown() name changed to
> nvme_ctrl_shutdown_start() as requested by Sagi Grimberg.
> 2). Git commit message reformatting to 75 columns
> as requested by Bjorn Helgaas <bhelgaas@google.com>.
> 
> NB. An alternate patchset from David Jeffery <djeffery@redhat.com>
> has been proposed that covers much of the same ground.

Would be useful to have a link to David's patchset for comparison.

