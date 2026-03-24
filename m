Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF92F54ACF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 15:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZPMdzULenDfloG7X4hURGJEdGEam9TH/WLdzjA2Beg=; b=t/coEOKrXZ/5vosFzqwHrTccrN
	jjXP/5mQ+jbuNOOZUTaV5Vep2z7lU+Zg4feJVA5IvrAbWDSGn+poCCgpeJijbE/N7pGN0UbBpdeKu
	gHiMjwUJ0JEjPeCYjquyLE7nX5MXooRr1CRcLRsdaJWOlt6FxEtchSmnoWRZVLQpSmBEQFusbzcb8
	8T3r1GqxQBIR58tbg90uu9H0YpLJv7396AEaDS0TeaUqaBLKQ0JHjYkjTRW8GPhUyoJ6yF22FDGZB
	7lugEnoDBBbe6jghd37Y5iW0US7C2MUTVtfGK7vVkYa1JTTruo0X5QDrLsCkI2DZRCGgrborgYIh1
	sf2/O39A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53bg-00000001kmQ-3eEO;
	Tue, 24 Mar 2026 15:23:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w53be-00000001kls-39C1
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 15:23:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D0C3C600AC;
	Tue, 24 Mar 2026 15:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60E0C2BC87;
	Tue, 24 Mar 2026 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774365825;
	bh=zGFRPVJDxf4Igm6xRxQVBoqj3S1r0i8JYFoBeCr/Ycg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9VgrLrB+Jt9ShucyQLSiqKf40JGM+ECA7Sxzme2+NhIes3tKVtf5H4x2FXUEUR+x
	 sX0Xg3VDAlp5+2ChN4obxVC1l3up/M9DVE3VcNaFatkb8PlFqs07EQN69JH2UMi6KL
	 PXvZAWgBbiycSI/9fNQmuDKZQ/4dRVAnLTK6PHbQZUTZS4NarPfjVDaa1pbDDozs2j
	 lk73xh7UnFErxsywSAvwo/Gnm82po6qScWyPu9Jwj64JOr3/DTMo2KnI1C1OJevI9B
	 qmY0gjoOuocbw2SYfGYnHTMsKWwU+HWh+MBoQ0zql9AI5+mVm2EySgWF/00PUp4mHc
	 fQub5wCjnPEig==
Date: Tue, 24 Mar 2026 09:23:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Subject: Re: [PATCH v2 0/3] replace old wq(s), added WQ_PERCPU to
 alloc_workqueue
Message-ID: <acKsf_tK-mHtwO-m@kbusch-mbp>
References: <20260223102336.108512-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223102336.108512-1-marco.crivellari@suse.com>
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

On Mon, Feb 23, 2026 at 11:23:26AM +0100, Marco Crivellari wrote:
> 1) [P 1] Replace uses of system_wq
> 
>     system_wq is a per-CPU workqueue, but his name is not clear.
>     Because of that, system_wq has been replaced with system_percpu_wq.
> 
> 2) [P 2-3] add WQ_PERCPU to all relevant alloc_workqueue() users
> 
>     This change adds a new WQ_PERCPU flag to explicitly request
>     alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

Thanks applied to nvme-7.1.

