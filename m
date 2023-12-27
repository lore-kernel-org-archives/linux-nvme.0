Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10256C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=i/jiLpbJ9P3ZosSkUyL/fimuriV7nuSeCMJGDM6bGiI=; b=kxeS1+fkDOkxF5
	sc1h0sJ66qvjxdDlwfsW0FknLHOnmIDuox7Lwrg8pcvyzBYY0Yu33foMJXUDsDoJPcqCus5806RhZ
	fBPnQ2k/7JkHfkBo6JksWBXaXkYNkY80a0d/ytUbEkYCvN0T7BFurjehRCX6jE7SHYVAIktxkO0Ru
	UuHqMO8xx+p/ybw0xbvT6NoqwT7/SP40Odx2AtjmXatSAoJrdQT8GQQvNmkKzxqNt3cSX5nsKfCig
	irikzgsK1ZlUPTaDlxKTQ+LL13ZE+o5k3lUTIWdTJb/FeH03+kuHyyxvKaCMlXBJgD4fiG4fcihnM
	HG1pjfyPb8vzQzm6bkMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIab1-00FShT-2Q;
	Wed, 27 Dec 2023 20:33:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIaay-00FSfq-2y
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 20:33:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3FFA960F9B;
	Wed, 27 Dec 2023 20:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36DCC433CA;
	Wed, 27 Dec 2023 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703709218;
	bh=cR2BdtbUvyxkdlNZa7jt8vw2huGd/GpllvoXZ+9AMOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kmM3XFxo7uGcBClCY3RMrVmoLzW9wIfksYTHWKDsDqjskjgiwu8EY6Bnz0myElcbl
	 1No/0Xu4+j0T9mAf7R31FcGzcw95Xv78PxpSqROJIvhw+u9bVCaFk0CyR3Mna5k8Ko
	 kiyBsV5JcVUc1FiMQkdof5xzJLpWKlD54kQM5OhdKlN6VlZa0VEo/inDyHDqQ8b4Ee
	 MAZAadx8BFaLnf4MExjLuZPSX4xG0eFRSKdayh1hrEs2bCY5qm/Zbkgg6i4+Lwq+pu
	 N2eiGkqhs/Hk2yLLDEYXT9hnh9KhHaySpS9qyVfkbhZ67YIWRsTlBwDncEon3PD15z
	 D/fGn0jpNl+Yg==
Date: Wed, 27 Dec 2023 14:33:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Message-ID: <20231227203337.GA1509884@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221172257.2234320-2-jallison@ciq.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_123340_996514_089E99A1 
X-CRM114-Status: GOOD (  13.05  )
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

On Thu, Dec 21, 2023 at 09:22:54AM -0800, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> This changes the bus driver interface with an additional entry point
> to enable devices to implement two-pass shutdown. The existing
> synchronous interface to shutdown is called, and if a shutdown_wait
> method is defined the device is moved to an alternate list.
> 
> Once the shutdown method is called for all devices, the
> shutdown_wait method is then called synchronously for
> all devices on the alternate list.

Christoph and Sagi noted that the objective is similar to "fire now
and wait for completion later."

Would it be practical to actually *do* that, e.g., add a global
shutdown workqueue, have the .shutdown() method of nvme and similar
drivers add items to it, and have the driver core wait until
everything on that workqueue has completed?

But I'm not a workqueue expert and I do see the scary warning at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/workqueue.h?id=v6.6#n619,
about not flushing system-wide workqueues, so maybe this wouldn't be
workable.

Bjorn

